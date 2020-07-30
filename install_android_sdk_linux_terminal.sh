#!/bin/bash

#https://stackoverflow.com/questions/60730615/sdkmanager-warning-could-not-create-setting-java-lang-illegalargumentexcepti

#https://stackoverflow.com/questions/60440509/android-command-line-tools-sdkmanager-always-shows-warning-could-not-create-se

clear
echo ""
echo ""
echo "=== Instalação de Android SDK ==="
echo ""
echo ""

echo "1. Criar diretório /opt/android-sdk"
mkdir /opt/android-sdk

echo "2. Baixar SDK para o diretório /opt/android-sdk"
wget -O /opt/android-sdk/android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip

echo "3. Extrair arquivo android-sdk.zip no diretório /opt/android-sdk"
unzip /opt/android-sdk/android-sdk.zip

echo "4. Dar as permissões corretas à pasta /opt/android-sdk"
chmod -R +x /opt/android-sdk

echo "5. Entrar na pasta /opt/android-sdk/tools/bin"
cd /opt/android-sdk/tools/bin

echo "6. Fazer download e configurar Platform Tools, Tools e Build Tools"
yes Y | /opt/android-sdk/tools/bin/sdkmanager --licenses
./sdkmanager tools platform-tools $(./sdkmanager --list | grep build-tools | tail -n1 | cut -d" " -f3)

echo "7. Adicionar links simbólicos do Platform Tools, Tools e Build Tools à pasta /usr/bin"
cd /usr/bin
ln -fs /opt/android-sdk/platform-tools/adb .
ln -fs /opt/android-sdk/platform-tools/fastboot .
ln -fs /opt/android-sdk/build-tools/$(ls -1 /opt/android-sdk/build-tools/ | tail -n1)/aapt .

echo "8. Baixar o arquivo 51-android.rules para o diretório /etc/udev/rules.d/"
wget -o /etc/udev/rules.d/51-android.rules https://raw.githubusercontent.com/snowdream/51-android/master/51-android.rules

echo "9. Dar permissão de leitura ao arquivo 51-android.rules em /etc/udev/rules.d/"
chmod a+r /etc/udev/rules.d/51-android.rules