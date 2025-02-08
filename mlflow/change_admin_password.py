import os
import argparse
from mlflow.server import get_app_client

os.environ['MLFLOW_TRACKING_USERNAME'] = "admin"
os.environ['MLFLOW_TRACKING_PASSWORD'] = "password"

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument( "--password", required=True )
args = parser.parse_args()

auth_client = get_app_client("basic-auth", tracking_uri="http://localhost:80")
auth_client.update_user_password( "admin", args.password )
