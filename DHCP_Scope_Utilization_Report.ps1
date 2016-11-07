$threshold = 75
$email_to = ""
$email_from = ""
$email_server = ""
$date = Get-Date
$report = "C:\temp\report.csv"
$DHCP = ""

Get-DhcpServerv4ScopeStatistics -computername $DHCP | Select ScopeID, PercentageInUse, Free, InUse | Where PercentageInUse -gt $threshold | Export-Csv $report -NoTypeInformation

Send-MailMessage -To $email_to -From $email_from -SmtpServer $email_server -Subject "DHCP Scope Report - $date" -Attachments $report

Remove-Item $report
