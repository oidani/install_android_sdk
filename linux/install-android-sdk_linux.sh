#!/bin/bash

clear
echo ""
echo ""
echo "=== Instalação de Android SDK ==="
echo ""
echo ""

echo "1. Instalar OpenJDK 8"
apt install openjdk-8-jdk

echo "2. Criar diretório /opt/android-sdk/cmdline-tools/"
mkdir /opt/android-sdk/cmdline-tools/

echo "3. Baixar SDK para o diretório /opt/android-sdk/cmdline-tools/"
wget -O /opt/android-sdk/cmdline-tools/android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip

echo "4. Extrair arquivo android-sdk.zip no diretório /opt/android-sdk/cmdline-tools/"
unzip /opt/android-sdk/cmdline-tools/android-sdk.zip

echo "5. Remover arquivo android-sdk.zip"
rm /opt/android-sdk/cmdline-tools/android-sdk.zip

echo "6. Dar permissão de execução à pasta /opt/android-sdk/"
chmod -R +x /opt/android-sdk/

echo "7. Entrar na pasta /opt/android-sdk/tools/bin"
cd /opt/android-sdk/cmdline-tools/tools/bin/

echo "8. Criar link simbólico para o sdkmanager em /usr/bin/"
ln -fs /opt/android-sdk/cmdline-tools/tools/bin/sdkmanager /usr/bin/

echo "9. Fazer download e configurar Platform Tools, Tools e Build Tools"
yes | sdkmanager tools platform-tools $(sdkmanager --list | grep build-tools | tail -n1 | cut -d" " -f3)

echo "10. Adicionar links simbólicos para Platform Tools, Tools e Build Tools à pasta /usr/bin/"
ln -fs /opt/android-sdk/platform-tools/adb /usr/bin/
ln -fs /opt/android-sdk/platform-tools/fastboot /usr/bin/
ln -fs /opt/android-sdk/build-tools/$(ls -1 /opt/android-sdk/build-tools/ | tail -n1)/aapt /usr/bin/

echo "11. Baixar o arquivo 51-android.rules para o diretório /etc/udev/rules.d/"
wget -O /etc/udev/rules.d/51-android.rules https://raw.githubusercontent.com/snowdream/51-android/master/51-android.rules

echo "12. Dar permissão de leitura ao arquivo 51-android.rules em /etc/udev/rules.d/"
chmod a+r /etc/udev/rules.d/51-android.rules