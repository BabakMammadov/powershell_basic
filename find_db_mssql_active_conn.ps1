### parametrs side.
param (
        [string]$sql_server=$args[0],
        [string]$db_name=$args[1],
        [string]$sql_query=$args[2],
        $warn=$args[3],
        $cri=$args[4]
      )


### Connection Side
$sqlConn = New-Object System.Data.SqlClient.SqlConnection
$sqlConn.ConnectionString = “Server=$sql_server;Integrated Security=true;Initial Catalog=$db_name”
$sqlConn.Open()
$sqlcmd = $sqlConn.CreateCommand()
$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
$sqlcmd.Connection = $sqlConn

$query = $sql_query
$sqlcmd.CommandText = $query
$adp = New-Object System.Data.SqlClient.SqlDataAdapter $sqlcmd
$data = New-Object System.Data.DataSet
$adp.Fill($data) | Out-Null


$result = $Data.Tables[0].Rows.Column1
    if($result –gt $warn)
{
    "Status is OK"
    $returncode=0
}
elseif(($result -gt $cri) -and ($result -lt $warn) )
{
    "Status is Warning"
    $returncode=1
}
elseif(($result -gt 0)  -and ($result -lt $cri))
{
    "Status is Critical"
    $returncode=2
}
else
{
    "Status is Unknown"
    $returncode=3
}
exit($returncode)
###  powershell -File  C:\Users\Mammadov\Desktop\sql.ps1 -sql_server server_name -db_name db_name -sql_query "select count(*)  from DB_ActiveConnections where Status = 2" -warn 7 -cri 5