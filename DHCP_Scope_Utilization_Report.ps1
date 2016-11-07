$threshold = 75
$email_to = "scloud@sbch.org"
$email_from = "scloud@sbch.org"
$email_server = "smtprelay.sbch.org"
$date = Get-Date
$report = "C:\temp\DHCP\report.csv"


Get-DhcpServerv4ScopeStatistics -computername chs-dhcp2.sbch.org | Select ScopeID, PercentageInUse, Free, InUse | Where PercentageInUse -gt $threshold | Export-Csv $report -NoTypeInformation

Send-MailMessage -To $email_to -From $email_from -SmtpServer $email_server -Subject "DHCP Scope Report - $date" -Attachments $report

Remove-Item $report
