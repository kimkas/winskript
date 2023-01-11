#See skript genereerib paroolid kasutajatele
$file = "C:\Users\Administrator\winskript\AD_Kasutajad_Paroolita.csv"

$users = Import-Csv $file -Encoding Default -Delimiter ";"

$ErrorActionPreference = "SilentlyContinue"
foreach ($user in $users){
    # Kasutajanimi on Eesnimi.Perenimi
    $username = $user.FirstName + "." + $user.LastName
    $username = $username.ToLower()
    $username = Translit($username)
    $password = Get-RandomPassword(8)

    $upname = $username + "@sv-kool.local"
    #display name = eesnimi + perenimi
    $displayname = $user.FirstName + " " + $user.LastName
    New-ADUser -Name $username -DisplayName $displayname -GivenName $user.FirstName -Surname $user.LastName -Department $user.Department -Title $user.Role -UserPrincipalName $upname -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true
if(!$?)
{
echo "User $username already exists - can not add this user"
}
else
{
echo "New user $username added succsesfully"
$username + ";" + $password | Out-File -Append -FilePath C:\Users\Administrator\Documents\skriptimine\kasutajanimi.csv
}
}
$ErrorActionPreference = "Stop"

function Translit {

    param(
    [string] $inputString
    )

    $Translit = @{
    [char]'ä' = "a"
    [char]'ö' = "o"
    [char]'ü' = "u"
    [char]'õ' = "o"
    }

    $outputString=""

    foreach ($character in $inputCharacter = $inputString.ToCharArray())
    {

        if ($Translit[$character] -cne $Null ){

            $outputString += $Translit[$character]
        }
        else {

            $outputString += $character
        }
    }
    Write-Output $outputString
}
# See funktsioon genereerib antud karakteritest suvaliselt määratud pikkusega parooli
function Get-RandomPassword {
    param (
        [Parameter(Mandatory)]
        [int] $length
    )
    $charSet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.ToCharArray()
    $rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
    $bytes = New-Object byte[]($length)

    $rng.GetBytes($bytes)

    $result = New-Object char[]($length)

    for ($i = 0 ; $i -lt $length ; $i++) {
        $result[$i] = $charSet[$bytes[$i]%$charSet.Length]
    }

    return (-join $result)
}
# Skripti lõpp
