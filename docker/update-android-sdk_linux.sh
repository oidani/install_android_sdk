#!/bin/bash

echo -e "1. Downloading and configuring newest versions of the following packages:"
echo -e "- Tools\n- Platform-Tools\n- Build-Tools"

cd /opt/android-sdk/cmdline-tools/tools/bin/
yes | sdkmanager tools platform-tools $(sdkmanager --list | grep build-tools | tail -n1 | cut -d" " -f3) 2>&1 /dev/null

if [ $? == "0" ]; then
    echo -e "\n2. Updating simbolic links in /usr/bin"
    echo -e "\n2.1. adb"
    ln -fs /opt/android-sdk/platform-tools/adb /usr/bin/
    echo -e "\n2.2. fastboot"
    ln -fs /opt/android-sdk/platform-tools/fastboot /usr/bin/
    echo -e "\n2.3. aapt"
    ln -fs /opt/android-sdk/build-tools/$(ls -1 /opt/android-sdk/build-tools/ | tail -n1)/aapt /usr/bin/
    echo -e "\nSTATUS: update process completed."
else
    echo -e "\nSTATUS: update process failed. Please try again later."
    exit 1
fi
exit 0