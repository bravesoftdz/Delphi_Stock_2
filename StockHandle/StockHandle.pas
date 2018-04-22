unit StockHandle;

interface

uses Classes, StdCtrls, SysUtils, DMRecord, Public_Variant, String_Form, String_Handle;

 procedure GetStockStartEndList(var cbbStockNO: TComboBox);
 procedure GetStockStartEnd_Str(StockNO: String);
 procedure GetNowStock(var StockNO, BuySellQty: String);

implementation

 uses ChungYi_Main;

procedure GetNowStock(var StockNO, BuySellQty: String);
begin
  DataModule1.asqQU_Temp.Close;
  DataModule1.asqQU_Temp.SQL.Text:= 'select * from tbStartEnd '
    + ' where Flag="True" ';
  DataModule1.asqQU_Temp.Open;

  DataModule1.asqQU_Temp.First;
  if(DataModule1.asqQU_Temp.RecordCount > 0) then begin
    StockNO:= DataModule1.asqQU_Temp.FieldByName('StockNO').AsString;
    if(StockNO= '') then
      StockNO:= 'TX00';
//    StartTime:= DataModule1.asqQU_Temp.FieldByName('StartTime').AsString;
//    EndTime:= DataModule1.asqQU_Temp.FieldByName('StartTime').AsString;
    BuySellQty:= DataModule1.asqQU_Temp.FieldByName('BuySellQty').AsString;
  end;
end;


procedure GetStockStartEndList(var cbbStockNO: TComboBox);
var
    I : Integer;
    Temp_Str, sql_str: String;
begin
  cbbStockNO.Items.Clear;
  sql_str:= 'select distinct StockNO from tbStartEnd where Enable= "True" ';
  getList_fromDB(DataModule1.asqQU_Temp, sql_str, 'StockNO', cbbStockNO);



  {
  DataModule1.asqQU_Temp.Close;
  DataModule1.asqQU_Temp.SQL.Text:= 'select distinct StockNO from tbStartEnd '
    + ' where Enable= "True" ';
  DataModule1.asqQU_Temp.Open;

  cbbStockNO.Items.Clear;
  DataModule1.asqQU_Temp.First;
  if DataModule1.asqQU_Temp.FieldByName('StockNO').Text <> '' then begin
    for I := 0 to DataModule1.asqQU_Temp.RecordCount - 1 do begin
      cbbStockNO.Items.Add(DataModule1.asqQU_Temp.FieldByName('StockNO').Text);

    //  StockList.Add(DataModule1.asqQU_Temp.FieldByName('StockNO').Text + ',');
      DataModule1.asqQU_Temp.Next;
    end;
  end;
   }
 {
  StockList.Add(Temp_Str);
  StockList.Delimiter:= ',';
  StockList.StrictDelimiter:= true;
//  StockList.Text:= StockList.DelimitedText;
  cbbStockNO.Text:= StockList.DelimitedText;
  FreeAndNil(StockList);
  }
end;

procedure GetStockStartEnd_Str(StockNO: String);
var StartTime, EndTime: String;
begin
  DataModule1.asqQU_Temp.Close;
  DataModule1.asqQU_Temp.SQL.Text:= 'select * from tbStartEnd '
    + ' where StockNO="' + StockNO + '"';
  DataModule1.asqQU_Temp.Open;

  DataModule1.asqQU_Temp.First;
  StartTime:= DataModule1.asqQU_Temp.FieldByName('StartTime').Text;
  EndTime:= DataModule1.asqQU_Temp.FieldByName('EndTime').Text;

  if(StartTime <> '') then
    Public_Variant.StartTime:= StartTime + ':00'
  else  Public_Variant.StartTime:= '08:45:00';

  if(EndTime <> '') then
    Public_Variant.EndTime:= EndTime + ':00'
  else Public_Variant.EndTime:= '13:45:00';

  Public_Variant.FuturOrderType:= DataModule1.asqQU_Temp.FieldByName('FuterOrderType').Text;
  if(isnum(DataModule1.asqQU_Temp.FieldByName('BuySellQty').Text)) then
    ChungYi_Main.TradeQty:= DataModule1.asqQU_Temp.FieldByName('BuySellQty').AsInteger
  else
    ChungYi_Main.TradeQty:= 1;

end;

end.
