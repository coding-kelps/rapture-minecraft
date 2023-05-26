from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

import os
from ansible.errors import AnsibleUndefinedVariable, AnsibleParserError, AnsibleConnectionFailure
from ansible.plugins.inventory import BaseInventoryPlugin, Constructable, Cacheable

try:
    import boto3
    HAS_BOTO3 = True
except ImportError:
    HAS_BOTO3 = False

DOCUMENTATION = """
    name: read_terraform_state
    plugin_type: inventory
    version_added: "1.0.0"
    short_description: Read terraform state
    description: Loads ansible vars from remote terraform state 
    notes: 
        - requires boto3
"""

DIR = os.path.dirname(os.path.realpath(__file__))

class InventoryModule(BaseInventoryPlugin, Constructable, Cacheable):
    NAME = "read_terraform_state"

    """
    Loads variables for groups and/or hosts
    """

    def __init__(self, *args):
        super(InventoryModule, self).__init__(*args)
        self.bucket_name = "kelps-gitops"
        self.target = "tfstates/rapture-minecraft.tfstate"
        self.aws_region = "eu-west-3"

    def verify_file(self, path):
        return True 
    
    def parse(self, inventory, loader, path, cache=True):
        super(InventoryModule, self).parse(inventory, loader, path, cache)

        if not HAS_BOTO3:
            raise AnsibleParserError('Vars plugin requires boto3')
        
        try:
            sts_client = boto3.client('sts')

            assumed_role_object = sts_client.assume_role(
                RoleArn="arn:aws:iam::660168936356:role/KelpsGitOpsRole",
                RoleSessionName="AnsibleVarsPluginSession"
            )

            credentials = assumed_role_object['Credentials']

            s3 = boto3.resource('s3',
                                aws_access_key_id=credentials['AccessKeyId'],
                                aws_secret_access_key=credentials['SecretAccessKey'],
                                aws_session_token=credentials['SessionToken'],
                                region_name = self.aws_region)
             
            content_object = s3.Object(self.bucket_name, self.target)
            tfstate_content = content_object.get()['Body'].read().decode('utf-8')
            tfstate = loader.load(tfstate_content)
            ansible_vars = tfstate['outputs']['ansible_vars']['value']
            vars = loader.load(ansible_vars)

            self.inventory.add_host("ubuntu")
            self.inventory.set_variable("ubuntu", "ansible_host", vars["ec2_instance"]["public_ip"])
            self.inventory.set_variable("ubuntu", "ansible_user", "ubuntu")

        except Exception as err:
            raise AnsibleConnectionFailure(err)
