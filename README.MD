# NCTU-NA-2022-LDAP-ANISBLE

## 使用方式

1. 安裝 Ansible 與 Python

    ```sh
    # 用 pipx 隔離套件
    python3 -m pip install --user pipx
    python3 -m pipx ensurepath
    pipx install ansible --include-deps
   ```

2. 配置測試環境(這個東西就用來在虛擬測試而已, 如果你要直接裝在實體機的話, 可跳過)
    1. 安裝 [Vagrant](https://www.vagrantup.com/) 與 [VirtualBox](https://www.virtualbox.org/), 不喜歡也能使用其他 [Providers](https://www.vagrantup.com/docs/providers)
    2. 安裝 vagrant-hosts plugin, 以讓每台機器自動更新對應的 hosts.(可參考 [`ansible-openldap/provisioner/Vagrantfile`](ansible-openldap/provisioner/Vagrantfile), 裡面有為 router 安裝並設定 coredns, 如果有 dns 的話就不需要它了)

        ```sh
        vagrant plugin install vagrant-hosts
        ```

    3. 可更改 [`ansible-openldap/provisioner/Vagrantfile`](ansible-openldap/provisioner/Vagrantfile) 的規格, `hostname`, 或是 `forwarded_port`, 後續 Ansibe 的東西也要對著改
    4. 移動到 [`ansible-openldap/provisioner`](ansible-openldap/provisioner) 後, 輸入以下指令安裝並啟動所有機器

        ```sh
        vagrant up
        ```

3. 使用 [`chore/gen_rootca_cert_quick.sh`](chore/gen_rootca_cert_quick.sh) 快速地產生自簽的 CA 憑證
4. 可更改 [`ansible-openldap/inventory/inventory.ini`](ansible-openldap/inventory/inventory.ini) 以設定該如何連到這些機器(帳號也在裡面, 反正就是一個測試用的~)
5. 可更改 [`ansible-openldap/group_vars/all.yml`](ansible-openldap/group_vars/all.yml) 以設定整組 LDAP
6. 移動到資料夾 [`ansible-openldap`](ansible-openldap) 後, 使用以下指令部署整組 LDAP

    ```sh
    ansible-playbook ldap-playbook.yml
    ```

7. 倘若不想自己寫 `ldif` 或 cli 操作, 可使用 [`chore/docker-compose.yml`](chore/docker-compose.yml) 來快速部一個 phpldapadmin 來編輯與瀏覽
