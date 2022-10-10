# powershell script that automate git push
$LOOP=0

while($true) {
    $LOOP=$($LOOP + 1)
    $EPOCH=$(Get-Content epoch.txt)

    if ($EPOCH -ge $([int](Get-Date -UFormat %s))) {
	git push origin main
        Write-Output "Do not automate push in the future!"
        exit
    }

    $EPOCH=$([int]$EPOCH + [int]$(Get-Random -Maximum 86400))
    Write-Output $EPOCH > epoch.txt
    $DATE=(Get-Date 01.01.1970)+([System.TimeSpan]::fromseconds($EPOCH))
    Write-Output $DATE > date.txt
    git add .
    git commit -m $DATE --date $DATE

    if ($LOOP -ge 100) {
        git push origin main
        $LOOP=0
    }
}
