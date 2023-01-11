param(
$kasutajaNimi,
$taisNimi,
$kontoKirjeldus
)
$KasutajaParool = ConvertTo-SecureString 'qwerty' -AsPlainText -Force
New-LocalUser $kasutajaNimi -Password $kasutajaParool -FullName $taisNimi -Description $kontoKirjeldus
