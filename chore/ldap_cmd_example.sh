# Change root password
echo "
dn: olcDatabase={0}config,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: `slappasswd -s MYPASSWD`
" \
| ldapmodify -Y EXTERNAL -H ldapi:///


# Change user password
ldappasswd -xZZ -H ldap://ldap.4.nasa -D "uid=stu1,ou=People,dc=4,dc=nasa" -w MYPASSWD -s MY@PASSW


# Change PublicKey
echo '
dn: uid=ta1,ou=People,dc=4,dc=nasa
changetype: modify
delete: sshPublicKey
-
add: sshPublicKey
sshPublicKey: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhhgWcdaP64XsL2R3cyTnE+UCnuggvTjKddZWjKLs06Y5f+HovlD4enCnEdomQMix9K4gJ8AWm10ukBFCdAhGuhGQcsiTb/SHzuOHwZ93QLZ1bnTMT7NcN3+BaY9LKr11SLXT+fJ99UO+4DssNtdaM1qkrSanJ9sMVy9TDUXj6DLc5yw9KYOQ68seG80DTXbwNnEfctYlhbFGep48q7CZgGq6EfPPtuoz0bA5OrunndaFf7krZUiqeOP35rZAdjdugXUdQhkasfLe8LaXm2KOsB863cWbflQ9WmidkEV9z8bYMaHNXLLMhByBhyea+gpsbhlTXPrRWTTOhQHp+uih8WI1cgoRp/TO8K/W/4YfxAkSZdzLTZeZZhDhyJhvQKbp35Rw33/wSVyDgrqcILse+M++XGES7sB+gi6oZWKugq7Sx+d6hwBmxdSyi5FABo5dguvjtIxQz5tYEDol7vVmLplNOvrtMDUgmtE5q8BCsTFmMUMFzztZJEanAhOrMSNc= 2022-na-hw4
' \
| ldapmodify -xvZZ -w MYPASSWD -H ldap://ldap.4.nasa -D "uid=ta1,ou=People,dc=4,dc=nasa"


# Change PublicKey by admin
echo '
dn: uid=stu1,ou=People,dc=4,dc=nasa
changetype: modify
delete: sshPublicKey
-
add: sshPublicKey
sshPublicKey: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhhgWcdaP64XsL2R3cyTnE+UCnuggvTjKddZWjKLs06Y5f+HovlD4enCnEdomQMix9K4gJ8AWm10ukBFCdAhGuhGQcsiTb/SHzuOHwZ93QLZ1bnTMT7NcN3+BaY9LKr11SLXT+fJ99UO+4DssNtdaM1qkrSanJ9sMVy9TDUXj6DLc5yw9KYOQ68seG80DTXbwNnEfctYlhbFGep48q7CZgGq6EfPPtuoz0bA5OrunndaFf7krZUiqeOP35rZAdjdugXUdQhkasfLe8LaXm2KOsB863cWbflQ9WmidkEV9z8bYMaHNXLLMhByBhyea+gpsbhlTXPrRWTTOhQHp+uih8WI1cgoRp/TO8K/W/4YfxAkSZdzLTZeZZhDhyJhvQKbp35Rw33/wSVyDgrqcILse+M++XGES7sB+gi6oZWKugq7Sx+d6hwBmxdSyi5FABo5dguvjtIxQz5tYEDol7vVmLplNOvrtMDUgmtE5q8BCsTFmMUMFzztZJEanAhOrMSNc= 2022-na-hw4
' \
| ldapmodify -xvZZ -w MYPASSWD -H ldap://ldap.4.nasa -D "cn=admin,dc=4,dc=nasa"


# Change sudoer
echo '
dn: cn=%Admin,ou=Sudoers,dc=4,dc=nasa
changetype: modify
replace: sudoOption
sudoOption: !authenticate
' \
| ldapmodify -xvZZ -w MYPASSWD -H ldap://ldap.4.nasa -D "cn=admin,dc=4,dc=nasa"


# Change TLS
echo '
dn: cn=config
changetype: modify
replace: olcSecurity
olcSecurity: tls=0
' \
| ldapmodify -xvZZ -w MYPASSWD -H ldap://ldap.4.nasa -D "cn=config"


# Change attrs
echo '
dn: olcDatabase={3}mdb,cn=config
changetype: modify
replace: olcAccess
olcAccess: to attrs=userPassword
  by self write
  by anonymous auth
  by dn.base="cn=config" write
  by dn.base="cn=admin,dc=4,dc=nasa" write
  by * none
olcAccess: to attrs=shadowLastChange,sshPublicKey
  by self write
  by dn.base="cn=config" write
  by dn.base="cn=admin,dc=4,dc=nasa" write
  by * read
olcAccess: to *
  by dn.exact=gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth write
  by dn.base="cn=config" write
  by dn.base="cn=admin,dc=4,dc=nasa" write
  by * read
' \
| ldapmodify -Y EXTERNAL -H ldapi:///


# Add user
echo "
dn: uid=stu4,ou=People,dc=4,dc=nasa
objectClass: person
objectClass: inetOrgPerson
objectClass: organizationalPerson
objectClass: posixAccount
objectClass: shadowAccount
objectClass: ldapPublicKey
sn: stu4
cn: stu4
uid: stu4
uidNumber: 20004
gidNumber: 20000
homeDirectory: /home/stu4
sshPublicKey: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhhgWcdaP64XsL2R3cyTnE+UCnuggvTjKddZWjKLs06Y5f+HovlD4enCnEdomQMix9K4gJ8AWm10ukBFCdAhGuhGQcsiTb/SHzuOHwZ93QLZ1bnTMT7NcN3+BaY9LKr11SLXT+fJ99UO+4DssNtdaM1qkrSanJ9sMVy9TDUXj6DLc5yw9KYOQ68seG80DTXbwNnEfctYlhbFGep48q7CZgGq6EfPPtuoz0bA5OrunndaFf7krZUiqeOP35rZAdjdugXUdQhkasfLe8LaXm2KOsB863cWbflQ9WmidkEV9z8bYMaHNXLLMhByBhyea+gpsbhlTXPrRWTTOhQHp+uih8WI1cgoRp/TO8K/W/4YfxAkSZdzLTZeZZhDhyJhvQKbp35Rw33/wSVyDgrqcILse+M++XGES7sB+gi6oZWKugq7Sx+d6hwBmxdSyi5FABo5dguvjtIxQz5tYEDol7vVmLplNOvrtMDUgmtE5q8BCsTFmMUMFzztZJEanAhOrMSNc= 2022-na-hw4
userPassword: `slappasswd -s MYPASSWD`
loginShell: /bin/bash
" \
| ldapadd -xvZZ -w MYPASSWD -H ldap://ldap.4.nasa -D "cn=admin,dc=4,dc=nasa"


# Delete user
echo '
dn: uid=stu4,ou=People,dc=4,dc=nasa
changetype: delete
' \
| ldapadd -xvZZ -w MYPASSWD -H ldap://ldap.4.nasa -D "cn=admin,dc=4,dc=nasa"


# Search example
ldapsearch -xvZZ -w MYPASSWD -H ldap://ldap.4.nasa -D "cn=admin,dc=4,dc=nasa" -b "cn=%Admin,ou=Sudoers,dc=4,dc=nasa"
ldapsearch -Y EXTERNAL -H ldapi:/// -b "cn=config"


echo '
dn: uid=stu4,ou=People,dc=4,dc=nasa
changetype: modrdn
newrdn: uid=wow4
deleteoldrdn: 1
' \
| ldapmodify -xvZZ -w MYPASSWD -H ldap://ldap.4.nasa -D "cn=admin,dc=4,dc=nasa"

echo '
dn: uid=stu4,ou=People,dc=4,dc=nasa
changetype: modrdn
newrdn: uid
uid: wow4
' \
| ldapmodify -xvZZ -w t3P7vCeVbyfP3E9PZXUqFMZbUM7bCC2g -H ldap://ldap.4.nasa -D "uid=stu4,ou=People,dc=4,dc=nasa"


echo "
dn: uid=stu4,ou=People,dc=4,dc=nasa
changetype: modify
replace: userPassword
userPassword: `slappasswd -s t3P7vCeVbyfP3E9PZXUqFMZbUM7bCC2g`
# userPassword: `slappasswd -s t3P7vCeVbyfP3E9PZXUqFMZbUM7bCC2g123`
# userPassword: `slappasswd -s t3P7vCeVbyfP3E9PZXUqFMZbUM7bCC2g456`
" \
| ldapmodify -xvZZ -w MYPASSWD -H ldap://ldap.4.nasa -D "cn=admin,dc=4,dc=nasa"


ldappasswd -xZZ -H ldap://ldap.4.nasa -D "uid=stu4,ou=People,dc=4,dc=nasa" -w t3P7vCeVbyfP3E9PZXUqFMZbUM7bCC2g -s t3P7vCeVbyfP3E9PZXUqFMZbUM7bCC2g123 "uid=ta1,ou=People,dc=4,dc=nasa"

# t3P7vCeVbyfP3E9PZXUqFMZbUM7bCC2g
