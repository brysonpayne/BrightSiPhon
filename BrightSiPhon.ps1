# BrightSiPhon v2.0 - Attribution 2.0 (CC BY 2.0) https://creativecommons.org/licenses/by/2.0/
# cite as:
# Payne, B., Marquez, M. (2021). BrightSiPhon: Hacking Air-Gapped Systems. Hacker Halted 2021. Atlanta, GA. October 7-8, 2021.
# Note: This version of the algorithm is a PowerShell script written for 
#       laptops, Surface tablets, most all-in-one PCs, and other Windows 
#       devices with brightness programmable by WMI. BrightSiPhon.ps1 is 
#       being released to github during Hacker Halted 2021 (Oct. 7, 2021)
#       The desktop version of this approach requires a short C/C++ program,
#       using SetMonitorBrightness function (highlevelmonitorconfigurationapi.h)
#       to be released after the CCERP conference later this month (Oct. 29)

$message = Read-Host "Enter a message: "

$brightness=50
$delay=10
$myMonitor=@(Get-WmiObject -Namespace root/wmi -Class WmiMonitorBrightnessMethods)[0]
$myMonitor.wmisetBrightness($delay,$brightness)
Start-Sleep -Second 3

$binary = [System.Text.Encoding]::Default.GetBytes($message) |  %{[System.Convert]::ToString($_,2).PadLeft(8,'0') }
$binary
$array = $binary.ToCharArray();

foreach($num in $array){
	$brightness=100
	if ($num -eq '0') { $brightness = 0 }
	$myMonitor=@(Get-WmiObject -Namespace root\wmi -Class WmiMonitorBrightnessMethods)[0]
	$myMonitor.wmisetBrightness($delay, $brightness)
	Start-Sleep -Second 1
}

$brightness=50
$myMonitor=@(Get-WmiObject -Namespace root\wmi -Class WmiMonitorBrightnessMethods)[0]
$myMonitor.wmisetBrightness($delay,$brightness)
Start-Sleep -Second 3