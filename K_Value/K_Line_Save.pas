unit K_Line_Save;

interface

uses Classes, SysUtils;

procedure KeepListData();
procedure K_Line_Initial();
procedure K_Line_Close();

var DayCloseList: TStringList;

implementation

uses Quote, Public_Variant, ChungYi_Main, DMRecord, StringList_Fun, DB_Handle, getK_Value;


procedure KeepListData();
begin
  AveList.SaveToFile('AveList.txt');
  HighList.SaveToFile('HighList.txt');
  LowList.SaveToFile('LowList.txt');
  K_List.SaveToFile('K_List.txt');
  K_OpenList.SaveToFile('K_OpenList.txt');
  K_CloseList.SaveToFile('K_CloseList.txt');
  sK_LineList.OrderList.SaveToFile('OrderList.txt');
  sK_LineList.Order_TimeList.SaveToFile('Order_TimeList.txt');
  sK_LineList.K_5_MinuteList.SaveToFile('K_5_MinuteList.txt');
  DateList.SaveToFile('DateList.txt');
  MinuteQtyList.SaveToFile('MinuteQtyList.txt');
  BuyQtyList.SaveToFile('BuyQtyList.txt');
  SellQtyList.SaveToFile('SellQtyList.txt');
end;

procedure K_Line_Initial();
begin
  AllSQLList:= TStringList.Create;
  SubAllList:= TStringList.Create;
  SQLList:= TStringList.Create;
  AveList:= TStringList.Create;
  MinuteQtyList:= TStringList.Create;
  BuyQtyList:= TStringList.Create;
  SellQtyList:= TStringList.Create;
  HighList:= TStringList.Create;
  LowList:= TStringList.Create;
  K_List:= TStringList.Create;
  K_OpenList:= TStringList.Create;
  K_CloseList:= TStringList.Create;
  DateList:= TStringList.Create;
  K_LineList_Min:= TStringList.Create;;
  OrderParamList:= TStringList.Create; // 記錄何種參數觸發下單
  HistoryKList:= TStringList.Create;
  DayCloseList:= TStringList.Create;

  sK_LineList.OrderList:= TSTringList.Create;
  sK_LineList.Order_TimeList:= TSTringList.Create;
  sK_LineList.K_5_J02_List:= TSTringList.Create;
  sK_LineList.K_5_J03_List:= TSTringList.Create;


end;

procedure K_Line_Close();
begin
  KeepListData();

  if Assigned(AllSQLList) then FreeAndNil(AllSQLList);
  if Assigned(SubAllList) then FreeAndNil(SubAllList);
  if Assigned(SQLList) then FreeAndNil(SQLList);
  if Assigned(AveList) then FreeAndNil(AveList);
  if Assigned(MinuteQtyList) then FreeAndNil(MinuteQtyList);
  if Assigned(BuyQtyList) then FreeAndNil(BuyQtyList);
  if Assigned(SellQtyList) then FreeAndNil(SellQtyList);
  if Assigned(HighList) then FreeAndNil(HighList);
  if Assigned(LowList) then FreeAndNil(LowList);
  if Assigned(K_List) then FreeAndNil(K_List);
  if Assigned(K_OpenList) then FreeAndNil(K_OpenList);
  if Assigned(K_CloseList) then FreeAndNil(K_CloseList);
  if Assigned(DateList) then FreeAndNil(DateList);
  if Assigned(K_LineList_Min) then FreeAndNil(K_LineList_Min);
  if Assigned(OrderParamList) then FreeAndNil(OrderParamList);
  if Assigned(HistoryKList) then FreeAndNil(HistoryKList);
  if Assigned(DayCloseList) then FreeAndNil(DayCloseList);

  if Assigned(sK_LineList.OrderList) then FreeAndNil(sK_LineList.OrderList);
  if Assigned(sK_LineList.Order_TimeList) then FreeAndNil(sK_LineList.Order_TimeList);
  if Assigned(sK_LineList.K_5_MinuteList) then FreeAndNil(sK_LineList.K_5_MinuteList);
  if Assigned(sK_LineList.K_5_MinuteList_DateTime) then FreeAndNil(sK_LineList.K_5_MinuteList_DateTime);
  if Assigned(sK_LineList.K_5_J02_List) then FreeAndNil(sK_LineList.K_5_J02_List);
  if Assigned(sK_LineList.K_5_J03_List) then FreeAndNil(sK_LineList.K_5_J03_List);

  if Assigned(HisTable_List) then FreeAndNil(HisTable_List);
end;
end.
