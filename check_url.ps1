### parametrs side.
param (
    [string] $url=$args[0]
)
function Get-WebStatus($url) {
    try {
        [net.httpWebRequest] $req = [net.webRequest]::create($url)
        $req.Method = "GET"
        [net.httpWebResponse] $res = $req.getResponse()
        if ($res.StatusCode -eq "200") {
            echo  "`nSite $url is OK (Return code: $($res.StatusCode) - $([int] $res.StatusCode))`n"
            $returncode=0
        } else {
            echo "`Site $url, Something is wrong.`n" `
            $returncode=2
        }
        exit($returncode)
    } catch {
        echo  "`nSite $url, Something is WRONG.`n"
        $returncode=2
        exit($returncode)
    }
}

Get-WebStatus $url


### For executing powershell -File C:\Users\mammadov\Desktop\check_url.ps1 -url 'http://localhost'