#путь начала прораммы переименовки папок на 2 под уровне по внутренним в них файлам(3 под уровень)
Set-Location "C:\Users\Rostik5530\Downloads\курс по коготочкам"
#первый фильтр - напишите формат файла
$filtr1 = "mp4"
#второй фильтр - напишите формат файла
$filtr2 = "pdf"
#переключатель очистки преписи - если файлы не преименованны то будут в любом случае переименованны
[bool]$perekl = $true 
$simvolFiltrDel = ")" # последний символ удаляймого знач
$simvolFiltrSave = "Y" # первый символ сохраняймого знач
#переключатель сортировки по числовому значение укажите позицию значений
[bool]$pereklFiltr = $true 
[int]$znachPosition = 1 # позиция числа(начинаеться с нуля это 1 позиция)
###################################################################################################
function Rename ($fileName,$lock,$stack) {
    $pyt1 = "$lock\$fileName\*." + $filtr1
    $pyt2 = "$lock\$fileName\*." + $filtr2
    $ysl1 = Test-Path -PathType Leaf -Path $pyt1
    $ysl2 = Test-Path -PathType Leaf -Path $pyt2
    $kra = $lock + "\" + $fileName
    if($ysl1 -and $ysl2)
        {
            $prom = $lock + "\" + $stack + "(" + $filtr1 + " + " + $filtr2 +")" + $fileName
           Rename-Item $kra -NewName $prom
        }
    elseif($ysl1)
        { 
            $prom = $lock + "\" + $stack + "(" + $filtr1 + ")" + $fileName
           Rename-Item -Path $kra -NewName $prom
        }
    elseif($ysl2)
        { 
            $prom = $lock + "\" + $stack + "(" + $filtr2 + ")" + $fileName
           Rename-Item -Path $kra -NewName $prom
        }
    else
        {
            $prom = $lock + "\" + $stack + "(пусто)" + $fileName
           Rename-Item -Path $kra -NewName $prom
        }
}


$a = Get-ChildItem -Name
foreach ($c in $a){
    Set-Location $c
    if($pereklFiltr -eq 1)
    {
        $d = Get-ChildItem -Name | Sort-Object {[int]($_.Split(" ")[$znachPosition])} 2> $null
    }
    else 
    {
        $d = Get-ChildItem -Name
    }
    [int]$stack = 1
    foreach ($i in $d){
    if(($i.Contains("(" + $filtr1 + " + " + $filte2 +")") -or $i.Contains("(" + $filtr1 + ")") -or $i.Contains("(" + $filtr2 + ")") -or $i.Contains("(пусто)")) -and $perekl)
        {
            $c = $i.Split("$simvolFiltrDel")
            [int]$schet = 0
            foreach ($simvol in $c)
            {
                if($simvol -ne $simvolFiltrSave){$schet++}
            }
            Rename-Item -Path $i  -NewName $c[$schet - 1]
        }
    $lock = Get-Location 
    Rename $i $lock.Path $stack 2> $null
    $stack ++ 
    }
    Set-Location ..\
}