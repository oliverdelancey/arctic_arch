# Virtualbox Steps

1. Create `Arch Linux` virtual machine. Use the default BIOS mode; VirtualBox is annoying with (U)EFI.
2. Boot with the latest Arch iso.
3. Download the install script.
```bash
curl -L https://git.io/JkdG5 > vbxset.sh
```
4. Give script `777` privileges and run.
```bash
chmod 777 vbxset.sh
./vbxset.sh
```
