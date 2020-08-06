#!/bin/bash

echo -e "1. Downloading and configuring newest versions of the following packages:"
echo -e "- Tools\n- Platform-Tools\n- Build-Tools"

yes | sdkmanager tools platform-tools $(sdkmanager --list | grep build-tools | tail -n1 | cut -d" " -f3) &> /dev/null

if [ $? == "0" ]; then
    echo -e "\n2. Updating simbolic links in /usr/local/bin/"
    echo -e "\n2.1. adb"
    ln -fs /opt/android-sdk/platform-tools/adb /usr/local/bin/
    echo -e "\n2.2. fastboot"
    ln -fs /opt/android-sdk/platform-tools/fastboot /usr/local/bin/
    echo -e "\n2.3. aapt"
    ln -fs /opt/android-sdk/build-tools/$(ls -1 /opt/android-sdk/build-tools/ | tail -n1)/aapt /usr/local/bin/
    echo -e "\nSTATUS: update process completed."
else
    echo -e "\nSTATUS: update process failed. Please try again later."
    exit 1
fi
exit 0