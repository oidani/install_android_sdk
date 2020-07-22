#!/bin/bash

https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip

https://stackoverflow.com/questions/60730615/sdkmanager-warning-could-not-create-setting-java-lang-illegalargumentexcepti

https://stackoverflow.com/questions/60440509/android-command-line-tools-sdkmanager-always-shows-warning-could-not-create-se

clear
echo ""
echo ""
echo "=== Instalação de Android SDK ==="
echo ""
echo ""

echo "1. Baixar SDK para a home do usuário"

echo "2. Extrair arquivo android-sdk-linux-terminal.zip na Home do usuário"
unzip $HOME/android-sdk-linux-terminal.zip

echo "3. Dar as permissões corretas à pasta $HOME/android-sdk-linux-terminal"
sudo chmod -R +x $HOME/android-sdk-linux-terminal

echo "4. Entrar na pasta $HOME/android-sdk-windows-terminal\tools\bin"
cd $HOME/android-sdk-windows-terminal/tools/bin

echo "5. Fazer download e configurar Platform Tools, Tools e Build Tools"
echo "OBS: será necessário aceitar as licenças manualmente."
./sdkmanager tools platform-tools $(./sdkmanager --list | grep build-tools | tail -n1 | cut -d" " -f3)

echo "6. Adicionar links simbólicos do Platform Tools, Tools e Build Tools à pasta /usr/bin"
cd /usr/bin
sudo ln -fs $HOME/android-sdk-linux-terminal/platform-tools/adb .
sudo ln -fs $HOME/android-sdk-linux-terminal/platform-tools/fastboot .
sudo ln -fs $HOME/android-sdk-linux-terminal/build-tools/$(ls -1 $HOME/android-sdk-linux-terminal/build-tools/ | tail -n1)/aapt .

echo "7. Mover o arquivo $HOME/51-android.rules para o diretório /etc/udev/rules.d/"
https://snowdream.github.io/51-android/
sudo mv $HOME/51-android.rules /etc/udev/rules.d/

echo "8. Dar permissão de leitura ao arquivo 51-android.rules em /etc/udev/rules.d/"
sudo chmod a+r /etc/udev/rules.d/51-android.rules

echo "11. Desabilitar timestamp"
sudo su
echo 0 > /proc/sys/net/ipv4/tcp_timestamps
sysctl -w net.ipv4.tcp_timestamps=0

cd $HOME
echo "12. Testar ADB"
adb devices

sleep 2

echo "13. Testar Fastboot"
fastboot devices

sleep 2

echo "14. Testar AAPT"
aapt
