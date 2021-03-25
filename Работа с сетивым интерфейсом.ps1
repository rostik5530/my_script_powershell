Set-ExecutionPolicy Unrestricted
Set-NetIPInterface -InterfaceIndex 2 -AutomaticMetric 1
###########################################################
Set-DNSClientServerAddress –InterfaceIndex 1 –ServerAddresses 77.88.8.8,77.88.8.1
############################################################
$nics=Get-WmiObject win32_Networkadapter -Filter "netenabled = 'true'" # Ищем все активные интерфейсы
ForEach ($nic in $nics) {
$nicDeviceEnable=gwmi MSPower_DeviceEnable -Namespace root\wmi | where{$_.instancename -match[regex]::escape($nic.PNPDeviceID) } 
$nicDeviceWOL=gwmi MSPower_DeviceWakeEnable -Namespace root\wmi |where{$_.instancename -match[regex]::escape($nic.PNPDeviceID) } 
$nicDeviceWOLMagic=gwmi MSNdis_DeviceWakeOnMagicPacketOnly -Namespace root\wmi |where{$_.instancename -match[regex]::escape($nic.PNPDeviceID) } 
$nicDeviceEnable.Enable =$true; $nicDeviceEnable.psbase.Put() # Меняем и применяем параметр
$nicDeviceWOL.Enable =$true; $nicDeviceWOL.psbase.Put()
$nicDeviceWOLMagic.EnableWakeOnMagicPacketOnly =$true; $nicDeviceWOLMagic.psbase.Put()}