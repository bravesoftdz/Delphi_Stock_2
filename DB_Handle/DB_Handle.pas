unit DB_Handle;

interface

uses Classes, SysUtils, ASGSQLite3, StdCtrls, DB_GetData, DB_Type;

function CheckInventory(StockNO: String): TInventory_Stock;
function CheckTestMode(): boolean;
procedure UpdateRestart(SetValue: String);

implementation

uses DMRecord;


function CheckInventory(StockNO: String): TInventory_Stock;
var sql_str, IsTestMode: String;
begin
  if(DB_Handle.CheckTestMode) then
    IsTestMode:= '1'
  else IsTestMode:= '0';

  sql_str:= 'select * from RecordMsg where StockNM="' + StockNO + '" and TestMode="' + IsTestMode + '"';
  DB_GetData.GetFree_Sql(sql_str, DataModule1.asqQU_Temp);
  if(DataModule1.asqQU_Temp.RecordCount > 0) then begin
    DataModule1.asqQU_Temp.Last;
    Result.LeftQty:= DataModule1.asqQU_Temp.FindField('LeftQty').AsInteger;
    Result.LastBuySell:= DataModule1.asqQU_Temp.FindField('BuySell').AsString;
  end else begin
    Result.LeftQty:= 0;
  end;

end;

function CheckTestMode(): boolean;
begin
  DB_GetData.GetSpecific_Sql('TestMode', '', '', 'tbConfigure', DataModule1.asqQU_Temp, true);
  if(DataModule1.asqQU_Temp.RecordCount > 0) then begin
    Result:= DataModule1.asqQU_Temp.FieldByName('TestMode').AsString= '1';
  end else begin
    Result:= false;
  end;
end;

procedure UpdateRestart(SetValue: String);
begin
  DataModule1.asqQU_Temp.SQL.Text:= 'Update tbConfigure set IsRestart="' + SetValue + '"'  ;
  DataModule1.asqQU_Temp.ExecSQL;
end;
end.
