# Installing kvm/qemu virtual machine on debian 12 and its derived

1. **Hardware Virtualization Support:** As mentioned earlier in your instructions, it's crucial to verify
2. hardware virtualization support before attempting to install KVM. Users should ensure that their CPU supports Intel VT-x or AMD-V.
3. The provided commands (`grep --color -iE 'vmx|svm' /proc/cpuinfo` and `lscpu | grep Virtualization`) are effective in checking for these features.

4. ```shell
   grep --color -iE 'vmx|svm' /proc/cpuinfo` and `lscpu | grep Virtualization
   ```

5. **Enabling Virtualization in BIOS/UEFI:** If the hardware supports virtualization but it's not enabled in the BIOS/UEFI settings,
6. users will need to access these settings and enable the virtualization feature. The exact steps can vary depending on the motherboard or system manufacturer.

7. **KVM Module Check:** After installation, you've included a check to verify if the KVM modules are
8. loaded using `lsmod | grep -i kvm`. This is a good step to confirm that the necessary kernel modules are loaded.

9. ```shell
   lsmod | grep -i kvm
   ```

   **Installing virtual machine after checks**

   ```shell
   sudo apt install virt-manager qemu-system libvirt-daemon-system qemu-utils
   ```
  **Do installation without GUI**

  ```shell
  sudo apt install qemu-system libvirt-daemon-system virtinst qemu-utils
  ```

11. **Starting libvirt Management Daemon:** Starting and enabling the libvirtd service is crucial for managing virtualized guests.
12. The provided commands (`sudo systemctl enable --now libvirtd` and `systemctl status libvirtd`) ensure that the libvirtd daemon
13. is running and set to start on system boot.

14. ```shell
    sudo systemctl enable --now libvirtd
    systemctl status libvirtd
    ```

15. **Launching KVM Virtual Machine Manager Graphically:** The instructions for launching the Virtual Machine Manager (`virt-manager`) are clear.
16. This graphical tool provides a user-friendly interface for managing virtual machines.

17. ```shell
    virt-manager
    ```

18. **Adding User to libvirt and kvm Groups:** Adding the user to the `libvirt` and `kvm` groups is necessary to grant the user the required permissions
19. to manage virtual machines. This step helps address potential permission issues when launching `virt-manager` as a standard user.
    If you are launching Virt-manager as standard user, you may be prompted to enter your administrator password to run it,
    **"system policy prevents management of local virtualized systems"**.

  ```shell
sudo usermod -aG libvirt,kvm YOUR-USERNAME-HERE
```

20. 
