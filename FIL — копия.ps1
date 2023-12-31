    # Созадём объект Excel
$word = New-Object -ComObject Excel.Application

    # Делаем его видимым
$word.Visible = $true

    # Добавляем рабочую книгу
$WorkBook = $word.Workbooks.Open('\\LES-ADMIN4\Users\backup_fil.JANUS\Desktop\backup\backup3.xlsx')
    # Открывает переменную для работы с первым листом
$LogiclDisk = $WorkBook.Worksheets.Item(1)

    # Переименовываем лист
$LogiclDisk.Name = 'Резервное копирование'

    # Заполняем ячейки - шапку таблицы
$LogiclDisk.Cells.Item(1,1) = '№'
$LogiclDisk.Cells.Item(1,2) = 'Файл'
$LogiclDisk.Cells.Item(1,3) = 'Дата'

    # Переходим на следующую строку...
    $Row = 3
    # Присваеваем стартовый порядковый номер
    $n=1..100
    # Задаем массив IP-адрессов
$serv =   'oren-server',                    'orsk-nserver',           'tumen-server',         'UK-NOVASERVER',          'UFA-NSERVER',         'samara-nserver',           'FABRIKA-SRV',            'MAG-SERVER',             'nvagon-serv',          'yo-fileserver',          'nsk-server',                   'hyper11',             'MK-Ilinka',        'kurgan-server',          'troitsk',                   'black',                     'miass 1c-7',				'public 180.100', 			 'sql backup'	
    $s =   '\\10.74.56.100\backup\','\\10.74.156.100\BACKUP\','\\10.74.72.110\backup\','\\10.74.80.100\backup\','\\10.74.2.110\backup\','\\SAMARA-SERVER\VeeamBackup\','\\10.74.120.100\backup\','\\10.74.140.110\backup\','\\10.74.170.110\backup\','\\10.74.12.100\backup\','\\NSK-SRV\Shared NSK','\\10.74.180.99\SQL backup','\\10.74.40.110\backup\','\\10.74.45.100\backup\','\\10.74.3.104\d$\BACKUP SQL\','\\srvbackm\d$\Backup\Black','\\srvbackm\d$\Backup\Miass 1c-7\1с','\\srvbackm\d$\Backup\public 180.100','\\srvbackm\d$\Backup\SQL backup'
    $x =   '\\10.74.56.100\backup\','\\10.74.156.100\BACKUP\','\\10.74.72.110\backup\','\\10.74.80.100\backup\','\\10.74.2.110\backup\','\\SAMARA-SERVER\VeeamBackup\','\\10.74.120.100\backup\','\\10.74.140.110\backup\','\\10.74.170.110\backup\','\\10.74.12.100\backup\','\\NSK-SRV\Shared NSK','\\10.74.180.99\SQL backup','\\10.74.40.110\backup\','\\10.74.45.100\backup\','\\10.74.3.104\d$\BACKUP SQL\','\\srvbackm\d$\Backup\Black','\\srvbackm\d$\Backup\Miass 1c-7\1с','\\srvbackm\d$\Backup\public 180.100','\\srvbackm\d$\Backup\SQL backup'
    $q =   '\\10.74.56.100\backup\','\\10.74.156.100\BACKUP\','\\10.74.72.110\backup\','\\10.74.80.100\backup\','\\10.74.2.110\backup\','\\SAMARA-SERVER\VeeamBackup\','\\10.74.120.100\backup\','\\10.74.140.110\backup\','\\10.74.170.110\backup\','\\10.74.12.100\backup\','\\NSK-SRV\Shared NSK','\\10.74.180.99\SQL backup','\\10.74.40.110\backup\','\\10.74.45.100\backup\','\\10.74.3.104\d$\BACKUP SQL\','\\srvbackm\d$\Backup\Black','\\srvbackm\d$\Backup\Miass 1c-7\1с','\\srvbackm\d$\Backup\public 180.100','\\srvbackm\d$\Backup\SQL backup'
   
    # Задаем стартовое значение массива
    
    $ii=0
     $i=3
    $i2=0
    $i3=3,7,11,15,19,23,27,31,35,39,43,47,51,55,59,63,67,71,75,79,83,87,91,95,99,104,109,114,119,124,129
    # присваеваем массиву нынешнюю дату
        $Now = Get-Date
    
    # задаём формат файлов
    $Extension = "*.bak"
    $Extension = "*.vib"
    $Extension = "*.vbm"
    $Extension = "*.vbk"
    $Extension = "*.tib"
    $Extension = "*.TIB"

    # задаём временной период
    $Days = "15"
    $Days2 = "60"
    $LastWrite = $Now.AddDays(-$Days)
    $LastWrite1 = $Now.AddDays(-$Days2)
    
    # ... и заполняем данными в цикле по серверам

 foreach ($ss in $s)
 { $Row=$i3[$ii]

        $LogiclDisk.Cells.Item($Row,1) = $n[$ii]
        $LogiclDisk.Cells.Item($Row,2) = $serv[$ii]
 	    $logiclDisk.Cells.Item($Row,3) = 'Name Bases SQL'
	    $logiclDisk.Cells.Item($Row,4) = 'Date'
	    $logiclDisk.Cells.Item($Row,5) = 'Size'
	    $logiclDisk.Cells.Item($Row,6) = 'Name Acronis Backup'
	    $logiclDisk.Cells.Item($Row,7) = 'Date'
	    $logiclDisk.Cells.Item($Row,8) = 'Size'
        $LogiclDisk.Cells.Item($Row,9) = $s[$ii]
        $Row++

 Foreach ($b in Get-ChildItem -Path $ss -Recurse | Where-Object{$_.PSIsContainer}) 
 {
  
   $a= Get-ChildItem -Path $b.FullName -File *.bak | Sort-Object LastWriteTime |Where{$_.LastWriteTime -gt "$LastWrite1"} | Select-Object -Last 1 | Group-Object -Property LastWriteTime
   $mas=$a | ForEach-Object {$_.Group}
   $mas | ForEach `
    {
        $LogiclDisk.Cells.Item($Row,3) = $_.Name
        $LogiclDisk.Cells.Item($Row,4) = $_.LastWriteTime
        $LogiclDisk.Cells.Item($Row,5) = "="+$_.Length+"/1024/1024"
        $Row++
        
	        }
    
 }
  $ii++
  $Row++
  }
 
 #$Row = 4

$ii=0
 
   foreach ($ss in $q)
 { $Row=$i3[$ii]
 	    $logiclDisk.Cells.Item($Row,6) = 'Name Acronis Backup'
	    $logiclDisk.Cells.Item($Row,7) = 'Date'
        $Row++
   Foreach ($b in Get-ChildItem -Path $ss -Recurse | Where-Object{$_.PSIsContainer}) 
 {

      $a= Get-ChildItem -Path $b.FullName -File *.vhd | Sort-Object LastWriteTime | Select-Object -Last 1 | Group-Object -Property LastWriteTime
   $mas=$a | ForEach-Object {$_.Group}
    $mas | ForEach-Object `
    {
         
        # $LogiclDisk.Cells.Item($Row,3) = $i+1   
        $LogiclDisk.Cells.Item($Row,6) = $_.Name
        $LogiclDisk.Cells.Item($Row,7) = $_.LastWriteTime
        $LogiclDisk.Cells.Item($Row,8) = "="+$_.Length+"/1024/1024"
        $Row++
  
  }  
  }
  $ii++
  }
 
 $ii=0

 foreach ($ss in $x)
 { $Row=$i3[$ii]
 	    $logiclDisk.Cells.Item($Row,6) = 'Name Acronis Backup'
        $Row++
   Foreach ($b in Get-ChildItem -Path $ss -Recurse | Where-Object{$_.PSIsContainer}) 
 {

      $a= Get-ChildItem -Path $b.FullName -File *.vbm | Sort-Object LastWriteTime | Select-Object -Last 1 | Group-Object -Property LastWriteTime
   $mas=$a | ForEach-Object {$_.Group}
    $mas | ForEach-Object `
    {
         
        # $LogiclDisk.Cells.Item($Row,3) = $i+1   
        $LogiclDisk.Cells.Item($Row,6) = $_.Name
        $LogiclDisk.Cells.Item($Row,7) = $_.LastWriteTime
        $LogiclDisk.Cells.Item($Row,8) = "="+$_.Length+"/1024/1024"
        $Row++
  
  }  
  }
  $ii++
  }

 $ii=0

 foreach ($ss in $x)
 { $Row=$i3[$ii]
 	    $logiclDisk.Cells.Item($Row,6) = 'Name Acronis Backup'
        $Row++
   Foreach ($b in Get-ChildItem -Path $ss -Recurse | Where-Object{$_.PSIsContainer}) 
 {

      $a= Get-ChildItem -Path $b.FullName -File *.vib | Sort-Object LastWriteTime | Select-Object -Last 1 | Group-Object -Property LastWriteTime
   $mas=$a | ForEach-Object {$_.Group}
    $mas | ForEach-Object `
    {
         
        # $LogiclDisk.Cells.Item($Row,3) = $i+1   
    # задаём временной период
    $Days = "15"
    $Days2 = "60"
    $LastWrite = $Now.AddDays(-$Days)
    $LastWrite1 = $Now.AddDays(-$Days2)
    
    # ... и заполняем данными в цикле по серверам

 foreach ($ss in $s)
 { $Row=$i3[$ii]

        $LogiclDisk.Cells.Item($Row,1) = $n[$ii]
        $LogiclDisk.Cells.Item($Row,2) = $serv[$ii]
 	    $logiclDisk.Cells.Item($Row,3) = 'Name Bases SQL'
	    $logiclDisk.Cells.Item($Row,4) = 'Date'
	    $logiclDisk.Cells.Item($Row,5) = 'Size'
	    $logiclDisk.Cells.Item($Row,6) = 'Name Acronis Backup'
	    $logiclDisk.Cells.Item($Row,7) = 'Date'
	    $logiclDisk.Cells.Item($Row,8) = 'Size'
        $LogiclDisk.Cells.Item($Row,9) = $s[$ii]
        $Row++

 Foreach ($b in Get-ChildItem -Path $ss -Recurse | Where-Object{$_.PSIsContainer}) 
 {
  
   $a= Get-ChildItem -Path $b.FullName -File *.vbk | Sort-Object LastWriteTime |Where{$_.LastWriteTime -gt "$LastWrite1"} | Select-Object -Last 1 | Group-Object -Property LastWriteTime
   $mas=$a | ForEach-Object {$_.Group}
   $mas | ForEach `
    {
        $LogiclDisk.Cells.Item($Row,3) = $_.Name
        $LogiclDisk.Cells.Item($Row,4) = $_.LastWriteTime
        $LogiclDisk.Cells.Item($Row,5) = "="+$_.Length+"/1024/1024"
        $Row++
        
	        }
    
 }
  $ii++
  $Row++
  }
 
 #$Row = 4

$ii=0
 
   foreach ($ss in $q)
 { $Row=$i3[$ii]
 	    $logiclDisk.Cells.Item($Row,6) = 'Name Acronis Backup'
	    $logiclDisk.Cells.Item($Row,7) = 'Date'
        $Row++
   Foreach ($b in Get-ChildItem -Path $ss -Recurse | Where-Object{$_.PSIsContainer}) 
 {

      $a= Get-ChildItem -Path $b.FullName -File *.vhd | Sort-Object LastWriteTime | Select-Object -Last 1 | Group-Object -Property LastWriteTime
   $mas=$a | ForEach-Object {$_.Group}
    $mas | ForEach-Object `
    {
         
        # $LogiclDisk.Cells.Item($Row,3) = $i+1   
        $LogiclDisk.Cells.Item($Row,6) = $_.Name
        $LogiclDisk.Cells.Item($Row,7) = $_.LastWriteTime
        $LogiclDisk.Cells.Item($Row,8) = "="+$_.Length+"/1024/1024"
        $Row++
  
  }  
  }
  $ii++
  }
 
 $ii=0

 foreach ($ss in $x)
 { $Row=$i3[$ii]
 	    $logiclDisk.Cells.Item($Row,6) = 'Name Acronis Backup'
        $Row++
   Foreach ($b in Get-ChildItem -Path $ss -Recurse | Where-Object{$_.PSIsContainer}) 
 {

      $a= Get-ChildItem -Path $b.FullName -File *.tib | Sort-Object LastWriteTime | Select-Object -Last 1 | Group-Object -Property LastWriteTime
   $mas=$a | ForEach-Object {$_.Group}
    $mas | ForEach-Object `
    {
         
        # $LogiclDisk.Cells.Item($Row,3) = $i+1   
        $LogiclDisk.Cells.Item($Row,6) = $_.Name
        $LogiclDisk.Cells.Item($Row,7) = $_.LastWriteTime
        $LogiclDisk.Cells.Item($Row,8) = "="+$_.Length+"/1024/1024"
        $Row++
  
  }  
  }
  $ii++
  }

 $ii=0

foreach ($ss in $q)
 { $Row=$i3[$ii]
 	    $logiclDisk.Cells.Item($Row,6) = 'Name Acronis Backup'
	    $logiclDisk.Cells.Item($Row,7) = 'Date'
        $Row++
   Foreach ($b in Get-ChildItem -Path $ss -Recurse | Where-Object{$_.PSIsContainer}) 
 {

      $a= Get-ChildItem -Path $b.FullName -File *.TIB | Sort-Object LastWriteTime | Select-Object -Last 1 | Group-Object -Property LastWriteTime
   $mas=$a | ForEach-Object {$_.Group}
    $mas | ForEach-Object `
    {
         
        # $LogiclDisk.Cells.Item($Row,3) = $i+1   
        $LogiclDisk.Cells.Item($Row,6) = $_.Name
        $LogiclDisk.Cells.Item($Row,7) = $_.LastWriteTime
        $LogiclDisk.Cells.Item($Row,8) = "="+$_.Length+"/1024/1024"
        $Row++
  
  }  
  }
  $ii++
  }
 

 foreach ($ss in $x)
 { $Row=$i3[$ii]
 	    $logiclDisk.Cells.Item($Row,6) = 'Name Acronis Backup'
        $Row++
   Foreach ($b in Get-ChildItem -Path $ss -Recurse | Where-Object{$_.PSIsContainer}) 
 {

      $a= Get-ChildItem -Path $b.FullName -File *.vib | Sort-Object LastWriteTime | Select-Object -Last 1 | Group-Object -Property LastWriteTime
   $mas=$a | ForEach-Object {$_.Group}
    $mas | ForEach-Object `
    {
         
        # $LogiclDisk.Cells.Item($Row,3) = $i+1   

#Приведем день и месяц к виду 01-09, а не просто 1-9
if ($LastFileDate.Day -lt 10) {
$oldday = "0" + $LastFileDate.Day
}
else {
$oldday = $LastFileDate.Day
}

if ($LastFileDate.Month -lt 10) {
$oldmonth = "0" + $LastFileDate.Month
}
else {
$oldmonth = $LastFileDate.Month
}

if ($CurrentDate.Day -lt 10) {
$newday = "0" + $CurrentDate.Day
}
else {
$newday = $CurrentDate.Day
}

if ($CurrentDate.Month -lt 10) {
$newmonth = "0" + $CurrentDate.Month
}
else {
$newmonth = $CurrentDate.Month
}

$exe= ".xlsx"

$newfoldername = [string]$newday +"."+ [string]$newmonth +"."+ [string]$CurrentDate.Year + [string]$exe  # [string]$oldday +"."+ [string]$oldmonth +"."+ [string]$LastFileDate.Year + " - " + [string]$newday +"."+ [string]$newmonth +"."+ [string]$CurrentDate.Year
#$der=New-Item G:\kains -Name $newfoldername -Type "file"
    # Сохраняем файл под именем даты
$WorkBook.SaveAs('\\LES-ADMIN4\Users\backup_fil.JANUS\Desktop\backup'+$newfoldername)
    # Закрываем файл

$word.Quit()