cls
echo ""
echo ""
echo "=== Instalação de Android SDK ==="
echo ""
echo ""

echo "1. Baixar SDK"


echo "4. Extrair arquivo C:\android-sdk-windows-terminal.7z no disco C:\"
cd "C:\Program Files\7-Zip\"
.\7z.exe x C:\android-sdk-windows-terminal.7z -oC:\

echo "5. Entrar na pasta C:\android-sdk-windows-terminal\tools\bin"
cd C:\android-sdk-windows-terminal\tools\bin

echo "6. Fazer download e configurar Platform Tools, Tools e Build Tools"
echo "OBS: será necessário aceitar as licenças manualmente."
$build_tools_package = .\sdkmanager.bat --list | findstr build-tools | select -last 1 | %{$_.split('')[2]}
$build_tools_version = $build_tools_package.split(';')[1]
.\sdkmanager.bat platform-tools tools $build_tools_package

echo "7. Adicionar caminhos do Platform Tools, Tools e Build Tools à  variável Path do Windows"
$android_path = ";C:\android-sdk-windows-terminal\platform-tools;C:\android-sdk-windows-terminal\tools;C:\android-sdk-windows-terminal\build-tools\$build_tools_version"
$path_atual = [Environment]::GetEnvironmentVariable('Path', 'Machine')
$path_novo = $path_atual + $android_path
[Environment]::SetEnvironmentVariable("Path", $path_novo, 'Machine')

echo "8. Aplicar herança de permissões ao conteúdo da pasta C:\android-sdk-windows-terminal\"
Set-Acl -Path C:\android-sdk-windows-terminal\* -AclObject (Get-Acl -Path C:\android-sdk-windows-terminal\)

echo "9. Testar ADB"
adb devices

sleep 2

echo "10. Testar Fastboot"
fastboot devices

sleep 2

echo "11. Testar AAPT"
aapt
