#!/bin/bash

echo -e "Downloading and configuring newest versions of the following packages:"
echo -e "- Tools\n- Platform-Tools\n- Build-Tools"
cd /opt/android-sdk/cmdline-tools/tools/bin/
yes | ./sdkmanager tools platform-tools $(./sdkmanager --list | grep build-tools | tail -n1 | cut -d" " -f3) 2> /dev/null

if [ $? == "0" ]; then
    echo -e "\nUpdating simbolic links in /usr/bin"
    ln -fs /opt/android-sdk/platform-tools/adb /usr/bin/
    ln -fs /opt/android-sdk/platform-tools/fastboot /usr/bin/
    ln -fs /opt/android-sdk/build-tools/$(ls -1 /opt/android-sdk/build-tools/ | tail -n1)/aapt /usr/bin/
    echo -e "\n Update process completed."
else; then
    echo -e "Update process failed. Please try again later."
fi