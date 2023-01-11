# see skript loob kasutaja tema ees ja perenime järgi.
Echo "Sisesta eesnimi"
$eesnimi=Read-Host
Echo "Sisesta oma perekonnanimi"
$perenimi=Read-Host
$kasutajanimi=$eesnimi.ToLower() + "." + $perenimi.ToLower()
$taisnimi=$eesnimi.ToUpper() + " " + $perenimi.ToUpper()
Echo "Sisesta konto kirjeldus"
$kirjeldus=Read-Host
$parool = ConvertTo-SecureString "Parool1!" -AsPlainText -Force
$ErrorActionPreference = "SilentlyContinue"
New-LocalUser "$kasutajanimi" -Password $parool -FullName "$taisnimi" -Description "$kirjeldus"
if(!$?)
{
Echo "Viga! Sisesstatud kasutaja on olemas või sisestasid ikoone."
}
else
{
Echo "Konto on loodud"
}
$ErrorActionPreference = "Stop"
