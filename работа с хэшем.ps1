#1-2
$kra = (Get-Process | Get-Unique).ProcessName
#3
$schet = 0
$hecx = @{}
foreach ($i in $kra)
{
    $hecx.add($schet,$i)
    $schet++
}
#4
foreach ($i in $($hecx.Keys))
{
    if($hecx[$i][0] -eq "S"){$hecx[$i] = 'locked'}
}
#5
foreach($i in ($hecx.Count)..($hecx.Count-6)){$hecx.remove($i)}
foreach($i in 0..9){$hecx.remove($i)}
# результат $hecx
#6-8
$mass = 3,3.4,"Кря"
$newhecx = @{}
$schet = 0
foreach ($i in $mass)
{
    if($i.GetType().Name -eq "String"){[string]$newhecx.Add($schet,$i)}
    elseif($i.GetType().Name -eq "Int32"){[Int32]$newhecx.Add($schet,$i)}
    elseif($i.GetType().Name -eq "Double"){[Double]$newhecx.Add($schet,$i)}
    $schet++
}
# результат $newhecx