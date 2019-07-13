### parametrs side.
param (
        [string]$sql_server=$args[0],
        [string]$sql_query=$args[1],
        [Int]$execTime_warn=$args[2],
        [Int]$execTime_cri=$args[3],
        [Int]$cnt_warn=$args[4],
        [Int]$cnt_cri=$args[5]

      )


### Connection Side
$sqlConn = New-Object System.Data.SqlClient.SqlConnection
$sqlConn.ConnectionString = “Server=$sql_server;Integrated Security=true;Initial Catalog=BPMDEV_96”
$sqlConn.Open()
$sqlcmd = $sqlConn.CreateCommand()
$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
$sqlcmd.Connection = $sqlConn
$query = $sql_query
$sqlcmd.CommandText = $query
$adp = New-Object System.Data.SqlClient.SqlDataAdapter $sqlcmd
$data = New-Object System.Data.DataSet
$adp.Fill($data) | Out-Null


### Check data is null or no
if ($Data.Tables[0] -ne '')
{
        ### Iterate over table data
        foreach ($row in $Data.Tables[0].Rows)
        {
         $MachineName =  $row[0].ToString().Trim()
         $execTime = $row[1].ToString().Trim()
         $cnt = $row[2].ToString().Trim()
        # Icinga Exit Codes , #0 = OK, #1 = Warning, #2 = Critical, #3 = Unknown
                if((( $execTime –lt 0) -or ( $execTime –eq 0) -or (( $execTime –gt 0) -and ($execTime –lt $execTime_warn))) -and (( $cnt –lt 0 ) -or ( $cnt –eq 0 ) -or (( $cnt –gt 0 ) -and ($cnt –lt $cnt_warn))))
                {
                    echo " $execTime and $cnt is OK for $MachineName "
                    $returncode=0
                }
                elseif((( $execTime –gt $execTime_warn) -and ($execTime –lt $execTime_cri)) -or (( $cnt –gt $cnt_warn ) -and ($cnt –lt $cnt_cri)))
                {
                    echo " $execTime and $cnt is NOT OK,WARNING for $MachineName "
                    $returncode=1
                }
                elseif(( $execTime –gt $execTime_cri) -or ( $cnt –gt $cnt_cri ))
                {
                    echo " $execTime and $cnt is NOT OK,Critical for $MachineName "
                    $returncode=2
                }
                else
                {
                    "Status is Unknown"
                    $returncode=3
                }
                exit($returncode)
         }
}
else
{   echo " exectime, cnt is null and OK for $MachineName "
    $returncode=0
    exit($returncode) 
}


### Execute
#  powershell -File  C:\Users\MammadovBQadm\Desktop\sql.ps1 -sql_server server_name -sql_query “select c.MachineName, AVG(DATEDIFF(ss,p.ExecutionStart, GETDATE())) execTime, count(*) cnt from WorkflowQueueProcessingItem p with (nolock) left join DB_ActiveConnections c with (nolock) on c.Uid = p.ServerConnectionUid group by c.MachineName;”  -execTime_warn 30 -execTime_cri 60 -cnt_warn 30 -cnt_cri 35
