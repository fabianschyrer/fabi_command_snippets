Metabase G Suite Sync

client ID:		863016118673-l7f5s3!#je9sej5pvpdh73k3l30h5ihvdeqt.apps.googleusercontent.com
client secret:	AnBv0mHquXJbTYmApH1raL0=iUgK

virtualenv -p python3 /Users/fabianalexander/Documents/virtualenv/gsuite-sync-env
source /Users/fabianalexander/Documents/virtualenv/gsuite-sync-env/bin/activate
deactivate

pip install --upgrade google-api-python-client oauth2client
vi quickstart.py
python quickstart.py


https://developers.google.com/api-client-library/python/apis/





https://developers.google.com/admin-sdk/directory/v1/guides/manage-group-members#get_all_members
GET https://www.googleapis.com/admin/directory/v1/groups/groupKey/members
?pageToken=pagination token
&roles=one or more of OWNER,MANAGER,MEMBER separated by a comma
&maxResults=maximum results per response page

{
   "kind": "directory#members",
   "members": [
   {
    "kind": "directory#member",
    "id": "group member's unique ID",
    "email": "liz@example.com",
    "role": "MANAGER",
    "type": "GROUP"
   },
   {
    "kind": "directory#member",
    "id": "group member's unique ID",
    "email": "radhe@example.com",
    "role": "MANAGER",
    "type": "MEMBER"
   }
  ],
   "nextPageToken": "NNNNN"
}







https://developers.google.com/admin-sdk/directory/v1/guides/manage-groups
GET https://www.googleapis.com/admin/directory/v1/groups/groupKey

{
    "kind": "directory#groups",
    "id": "group's unique ID",
    "etag": "group's unique ETag",
    "email": "sales_group@example.com",
    "name": "APAC Sales Group",
    "directMembersCount": "5",
    "description": "This is the APAC sales group.",
    "adminCreated": true,
    "aliases": [
     {
        "alias": "best_sales_group@example.com"
     }
    ],
    "nonEditableAliases: [
     {
        "alias": "liz@test.com"
     }
    ]
}






https://developers.google.com/admin-sdk/directory/v1/guides/manage-group-members
GET https://www.googleapis.com/admin/directory/v1/groups/groupKey/members/memberKey

{
   "kind": "directory#member",
   "id": "group member's unique ID",
   "email": "liz@example.com",
   "role": "MANAGER",
   "type": "GROUP"
}






https://developers.google.com/admin-sdk/directory/v1/guides/manage-users
GET https://www.googleapis.com/admin/directory/v1/users/liz@example.com

{
 "kind": "directory#user",
 "id": "the unique user id",
 "primaryEmail": "liz@example.com",
 "name": {
  "givenName": "Liz",
  "familyName": "Smith",
  "fullName": "Liz Smith"
 },
 "isAdmin": true,
 "isDelegatedAdmin": false,
 "lastLoginTime": "2013-02-05T10:30:03.325Z",
 "creationTime": "2010-04-05T17:30:04.325Z",
 "agreedToTerms": true,
 "hashFunction: "SHA-1",
 "suspended": false,
 "changePasswordAtNextLogin": false,
 "ipWhitelisted": false,
 "ims": [
  {
   "type": "work",
   "protocol": "gtalk",
   "im": "lizim@talk.example.com",
   "primary": true
  }
 ],
 "emails": [
  {
   "address": "liz@example.com",
   "type": "home",
   "customType": "",
   "primary": true
  }
 ],
 "addresses": [
  {
   "type": "work",
   "customType": "",
   "streetAddress": "1600 Amphitheatre Parkway",
   "locality": "Mountain View",
   "region": "CA",
   "postalCode": "94043"
  }
 ],
 "externalIds": [
  {
   "value": "employee number",
   "type": "custom",
   "customType": "office"
  }
 ],
 "relations": [
  {
   "value": "susan",
   "type": "friend",
   "customType": ""
  }
 ],
 "organizations": [
  {
   "name": "Google Inc.",
   "title": "SWE",
   "primary": true,
   "customType": "",
   "description": "Software engineer"
  }
 ],
 "phones": [
  {
   "value": "+1 nnn nnn nnnn",
   "type": "work"
  }
 ],
 "aliases": [
  "lizsmith@example.com",
  "lsmith@example.com"
 ],
 "nonEditableAliases: [
  "liz@test.com"
 ],
 "customerId": "C03az79cb",
 "orgUnitPath": "corp/engineering",
 "isMailboxSetup": true,
 "includeInGlobalAddressList": true
}









