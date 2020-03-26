""" Module for KMSKeyDeletionScheduled """

import json
import os

import boto3
from reflex_core import AWSRule


class KMSKeyDeletionScheduled(AWSRule):
    """ Reflex Rule for detecting and preventing KMS Key deletion. """

    client = boto3.client("kms")

    def __init__(self, event):
        super().__init__(event)

    def extract_event_data(self, event):
        """ Extract required event data """
        self.key_id = event["detail"]["requestParameters"]["keyId"]
        self.deletion_date = event["detail"]["responseElements"]["deletionDate"]

    def resource_compliant(self):
        """
        Determine if the resource is compliant with your rule.

        Return True if it is compliant, and False if it is not.
        """
        # If the event occurred then the resource is not compliant
        # and we need to take action. So always return False
        return False

    def remediate(self):
        """
        Fix the non-compliant resource so it conforms to the rule
        """
        self.client.cancel_key_deletion(KeyId=self.key_id)

    def get_remediation_message(self):
        """ Returns a message about the remediation action that occurred """
        message = (
            f"The KMS key with ID {self.key_id} was scheduled for deletion "
            f"on {self.deletion_date}."
        )
        if self.should_remediate():
            message += " Deletion has been cancelled."

        return message


def lambda_handler(event, _):
    """ Handles the incoming event """
    rule = KMSKeyDeletionScheduled(json.loads(event["Records"][0]["body"]))
    rule.run_compliance_rule()
