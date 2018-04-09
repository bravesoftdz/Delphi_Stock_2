unit SQLFunc;

interface

uses SysUtils, ComCtrls, Classes, ASGSQLite3, DB_Handle;

procedure InsertData(ListItem: TListItem; LeftQty: Integer; TempDB: boolean);
function RunSQL(SQLStr: String; FieldNM: String): String;

implementation

uses Public_Variant, ChungYi_Main, DMRecord;

procedure InsertData(ListItem: TListItem; LeftQty: Integer; TempDB: boolean);
var TimeStr, SQLStr, IsTestMode: String;
    isBuySell: String;
begin

  if(DB_Handle.CheckTestMode) then
    IsTestMode:= '1'
  else IsTestMode:= '0';

  if(TempDB) then
    isBuySell:= 'temp'
  else
    isBuySell:= ListItem.SubItems.Strings[2];

  SQLStr:= 'insert into RecordMsg (SN, TradeDate, TradeTime, Account, '
      + ' StockNM, BuySell, Criteria, Price, Qty, TradeSN, Msg, TestMode, LeftQty) values("'
      + IntToStr(DataModule1.AssignSN('RecordMsg')) + '", "'
      + ThistradeDate + '","'
      + ListItem.SubItems.Strings[0] + '","'
      + fmChungYi.cbAccount.Text + '","'
      + ListItem.SubItems.Strings[1] + '","'
      + isBuySell + '","'
      + ListItem.SubItems.Strings[3] + '","'
      + ListItem.SubItems.Strings[4] + '","'  // price
      + ListItem.SubItems.Strings[5] + '","'  // qty
      + ListItem.SubItems.Strings[6] + '","'
      + ListItem.SubItems.Strings[7] + '","'
      + IsTestMode + '",'
      + IntToStr(LeftQty)
      + ')' ;
  DataModule1.asqQU_Record.SQL.Text:= SQLStr;
  DataModule1.asqQU_Record.Open;
  DataModule1.asqQU_Record.SQL.Text:= 'select * from RecordMsg';
  DataModule1.asqQU_Record.Open;

end;

// 取得特定欄位值
function RunSQL(SQLStr: String; FieldNM: String): String;
var
  zqExec : TASQLite3Query;
begin
  zqExec := TASQLite3Query.Create(nil);
  zqExec.Connection := DataModule1.asqDB_StockRecord;
  with zqExec do
  begin
    SQL.Text := SQLStr;
    //ExecSQL;
    Open;
    if (zqExec.FieldByName(FieldNM).Text= '') or (Round(zqExec.FieldByName(FieldNM).AsFloat)= 0) then Result:= '0'
    else Result:= IntToStr(Round(zqExec.FieldByName(FieldNM).AsFloat));
    Close;
    Free;
  end;
end;
end.
