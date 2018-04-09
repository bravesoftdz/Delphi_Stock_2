unit CheckNetwork;

interface

uses wininet, windows;

function IsInternet : boolean;
function IsNetwork : boolean;
function InternetConnected: Boolean;

implementation


function IsInternet : boolean;
  var
     origin : cardinal;
  begin
     result := InternetGetConnectedState(@origin,0);


     //connections origins by origin value
     //NO INTERNET CONNECTION              = 0;
     //INTERNET_CONNECTION_MODEM           = 1;
     //INTERNET_CONNECTION_LAN             = 2;
     //INTERNET_CONNECTION_PROXY           = 4;
     //INTERNET_CONNECTION_MODEM_BUSY      = 8;
  end;

function IsNetwork : boolean;
  var origin : cardinal;
  begin
 //    result := InternetCheckConnection(@origin);


     //connections origins by origin value
     //NO INTERNET CONNECTION              = 0;
     //INTERNET_CONNECTION_MODEM           = 1;
     //INTERNET_CONNECTION_LAN             = 2;
     //INTERNET_CONNECTION_PROXY           = 4;
     //INTERNET_CONNECTION_MODEM_BUSY      = 8;
end;

////网络是否连通
function InternetConnected: Boolean;
const
// local system uses a modem to connect to the Internet.
INTERNET_CONNECTION_MODEM = 1;
// local system uses a local area network to connect to the Internet.
INTERNET_CONNECTION_LAN = 2;
// local system uses a proxy server to connect to the Internet.
INTERNET_CONNECTION_PROXY = 4;
// local system's modem is busy with a non-Internet connection.
INTERNET_CONNECTION_MODEM_BUSY = 8;
var
  dwConnectionTypes : DWORD;
begin
  dwConnectionTypes := INTERNET_CONNECTION_MODEM+ INTERNET_CONNECTION_LAN
   + INTERNET_CONNECTION_PROXY;

  Result := InternetGetConnectedState(@dwConnectionTypes, 0) ;
end;
end.
