
import os, requests, msal, time 

  

TENANT_ID     = os.environ['TENANT_ID'] 

CLIENT_ID     = os.environ['CLIENT_ID'] 

CLIENT_SECRET = os.environ['CLIENT_SECRET'] 

WORKSPACE_ID  = os.environ['WORKSPACE_ID'] 

PBIX_PATH     = os.environ['PBIX_PATH'] 

REPORT_NAME   = os.environ['REPORT_NAME'] 

ENVIRONMENT   = os.environ.get('ENVIRONMENT', 'Unknown') 

BASE = 'https://api.powerbi.com/v1.0/myorg' 

  

# 1. Authenticate 

print(f'Authenticating for {ENVIRONMENT}...') 

app = msal.ConfidentialClientApplication( 

    CLIENT_ID, 

    authority=f'https://login.microsoftonline.com/{TENANT_ID}', 

    client_credential=CLIENT_SECRET 

) 

token = app.acquire_token_for_client( 

    scopes=['https://analysis.windows.net/powerbi/api/.default'] 

)['access_token'] 

headers = {'Authorization': f'Bearer {token}'} 

print('Authentication successful') 

  

# 2. Upload .pbix 

print(f'Uploading {PBIX_PATH}...') 

url = f'{BASE}/groups/{WORKSPACE_ID}/imports?datasetDisplayName={REPORT_NAME}&nameConflict=CreateOrOverwrite' 

with open(PBIX_PATH, 'rb') as f: 

    resp = requests.post(url, headers=headers, files={'file': (PBIX_PATH, f, 'application/octet-stream')}) 

import_id = resp.json().get('id') 

print(f'Upload accepted. Import ID: {import_id}') 

  

# 3. Poll for completion 

for attempt in range(20): 

    time.sleep(10) 

    status = requests.get(f'{BASE}/groups/{WORKSPACE_ID}/imports/{import_id}', headers=headers).json().get('importState') 

    print(f'Attempt {attempt+1}: {status}') 

    if status == 'Succeeded': break 

    if status == 'Failed': raise Exception('Import failed!') 

  

# 4. Trigger refresh 

datasets = requests.get(f'{BASE}/groups/{WORKSPACE_ID}/datasets', headers=headers).json()['value'] 

ds = next((d for d in datasets if d['name'] == REPORT_NAME), None) 

if ds: 

    requests.post(f'{BASE}/groups/{WORKSPACE_ID}/datasets/{ds["id"]}/refreshes', 

                  headers=headers, json={'notifyOption': 'MailOnFailure'}) 

print(f'RetailIQ deployed to {ENVIRONMENT} successfully!') 
