# VMware Steps

1. Create virtual machine with `Linux 5.x 64bit`.
2. Add this line to the `.vmx` file:
```
firmware="efi"
```
3. Boot with the latest Arch iso.
4. Download the automation script.
```bash
curl -L https://git.io/JJFvx > vmware_setup.sh
```
5. Give it full permissions, and run.
```bash
chmod 777 vmware_setup.sh
bash vmware_setup.sh
```
