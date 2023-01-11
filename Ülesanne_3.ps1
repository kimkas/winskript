# See skript kontrollib kas kasutajad on juba olemas.
$file = "C:\Users\Administrator\winskript\AD_Kasutajad_Paroolita.csv"
# Järgnev käsk impordib faili sisu.
$users = Import-Csv $file -Encoding Default -Delimiter ";"

$ErrorActionPreference = "SilentlyContinue"
foreach ($user in $users){
    # Kasutajanimi on eesnimi + perenimi
    $username = $user.FirstName + "." + $user.LastName
    $username = $username.ToLower()
    $username = Translit($username)
    #
    $upname = $username + "@sv-kool.local"
    # eesnimi + perenimi
    $displayname = $user.FirstName + " " + $user.LastName
    New-ADUser -Name $username -DisplayName $displayname -GivenName $user.FirstName -Surname $user.LastName -Department $user.Department -Title $user.Role -UserPrincipalName $upname -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) -Enabled $true
if(!$?)
{
echo "User $username already exists - can not add this user"
}
else
{
echo "New user $username added succsesfully"
}
}

$ErrorActionPreference = "Stop"
#
function Translit {
    # Täpitähed
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
