unit ChouRule;

interface

uses Public_Variant, Windows, SysUtils;

function TimeLimit(TickTime: String): boolean;

implementation

function TimeLimit(TickTime: String): boolean;
var SystemTime: String;
begin
//  SystemTime:= FormatDateTime('hh:mm:ss', Time);
  if (Public_Variant.UserNM= 'JackyChou')
    and ((TickTime < Public_Variant.StartTime) or (TickTime > Public_Variant.EndTime)) then
     Result:= true
  else Result:= false;
  {
  if (Public_Variant.UserNM= 'JackyChou')
    and ((SystemTime < Public_Variant.StartTime) or (SystemTime > Public_Variant.EndTime)) then
     Result:= true
  else Result:= false;
  }
end;
end.
