docker pull vault
docker run vault
docker exec -it $(docker run -d -v /Users/fabianalexander/Documents/Documents/Projects_internal/Hashicorp_Vault:/vault --cap-add=IPC_LOCK vault server) /bin/sh

export VAULT_ADDR='http://127.0.0.1:8200'
vault operator init
vault status




/mnt # vault init
WARNING! The "vault init" command is deprecated. Please use "vault operator
init" instead. This command will be removed in Vault 0.11 (or later).

Unseal Key 1: HxDR0JtUfz32LIr2oJ5V/I2h6Dv5Slp22Gx0DJPBCzTv
Unseal Key 2: kEmkL4FP++kjOSlNW2tRJumeMq2PJRwLFuXdpr70gk72
Unseal Key 3: QFbIXUe7RUVvrnfjkzQQl+e4l0B03XjI38i1erEmD1UE
Unseal Key 4: y4nqOZ2rOFtS2BZA93U/muCFCjWvskir60INtShiaXHX
Unseal Key 5: lTOZahA2sRa0w48PryU/EGZunqDAN8ZuVIgMF5iyU6E5

Initial Root Token: 31351c49-7013-ba1f-1e03-b8379e2f10fa

Vault initialized with 5 key shares and a key threshold of 3. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 3 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated master key. Without at least 3 key to
reconstruct the master key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.





vault operator unseal HxDR0JtUfz32LIr2oJ5V/I2h6Dv5Slp22Gx0DJPBCzTv
vault operator unseal kEmkL4FP++kjOSlNW2tRJumeMq2PJRwLFuXdpr70gk72
vault operator unseal QFbIXUe7RUVvrnfjkzQQl+e4l0B03XjI38i1erEmD1UE

vault login 31351c49-7013-ba1f-1e03-b8379e2f10fa

vault write secret/mysql_database_credentials username=user1 password=userpasssword888
vault read secret/mysql_database_credentials
vault read -format=json secret/mysql_database_credentials
vault operator seal
