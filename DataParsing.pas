unit DataParsing;

interface

uses Classes, SysUtils, StrUtils, ComCtrls, Dialogs;

procedure TradeReportParsing(DataStr: String);
procedure RealReport(DataStr: String; TypeNM: String);
procedure ShowInterestStock();
procedure GetAccount_Error(bstrReport: String; ErrorCode: Integer);
procedure OverseasInventory(OverseasList: TStringList);

implementation

uses ChungYi_Main, Public_Variant, String_Form, SQLFunc, Stock_OptionOrder, DB_GetData,
     OverSeasOrder, DB_Type, DB_Handle, DMRecord, getK_Value, Quote;

procedure GetAccount_Error(bstrReport: String; ErrorCode: Integer);
begin
// ShowMessage(bstrReport + ', ' + IntToStr(ErrorCode));
end;

procedure TradeReportParsing(DataStr: String);
var DataList, SendList: TStringList;
    ListItem : TListItem;
    StockPrice: String;
begin
 if TriggerInternal= True then
 begin
  TradePrice:= '';
  DataList:= TStringList.Create;
  SendList:= TStringList.Create;
  DataList.Add(DataStr);

  ListItem := fmChungYi.ListView3.Items.Item[fmChungYi.ListView3.Items.Count - 1];
  if Copy(DataList.Text, 16, 1)='D' then // 成交
  begin
   StockPrice:= Copy(DataList.Text, 80, 6); // 取得成交價
   // 寫入價格
   fmChungYi.ListView3.Items[fmChungYi.ListView3.Items.Count - 1].SubItems.Strings[4]:=
    StockPrice;
   // 寫入資料庫
 //  SQLFunc.InsertData(ListItem, );
   TriggerInternal:= False;
  end;

  if (Copy(DataList.Text, 17, 1)= 'T') or (Copy(DataList.Text, 17, 1)= 'Y') then // 成交失敗
  begin
   fmChungYi.ListView3.Items[fmChungYi.ListView3.Items.Count - 1].SubItems.Strings[7]:=
     '成交失敗 ' + fmChungYi.ListView3.Items[fmChungYi.ListView3.Items.Count - 1].SubItems.Strings[7]; // 失敗訊息
   // 寫入資料庫
  // SQLFunc.InsertData(ListItem);
   // 重新下單
   if not AnsiContainsStr(fmChungYi.ListView3.Items[fmChungYi.ListView3.Items.Count - 1].SubItems.Strings[7], '保證金不足') then
   begin
    fmChungYi.lbFail.Visible:= True;
    fmChungYi.BackupBuyTimer.Enabled:= True;;
   end;
   TriggerInternal:= False;
  end;
//  DataList.SaveToFile('回報資料.txt');

  if(Public_Variant.FuturOrderType= '期貨') then
    fmQuote.SKOrderLib1.GetOpenInterest(WideString(Userid), WideString(FutureAccount))
  else if(Public_Variant.FuturOrderType= '外期') then
    fmQuote.SKOrderLib1.GetOverSeaFutureOpenInterest(WideString(Userid), WideString(FutureAccount)) ;
  if Assigned(DataList) then FreeAndNil(DataList);
  if Assigned(SendList) then FreeAndNil(SendList);
 end;
end;

procedure RealReport(DataStr: String; TypeNM: String);
var i, OrderQty: Integer;
    InventoryBuySell: Integer;
    ListItem: Tlistitem;
    OverseasList: TStringList;
    InvenResult: TInventory_Stock;
begin
 InvenResult:= DB_Handle.CheckInventory(fmChungYi.cbbCommNO.Text);

 if TypeNM= 'Stock' then begin
   if Copy(DataStr, 1, 2) <> '##' then
     BalanceList.Add(DataStr)
   else begin
   // BalanceList.SaveToFile('StockList.Txt');
     BalanceList.Clear;
   end;
 end else if TypeNM= 'Interest' then begin
   if Copy(DataStr, 1, 2) <> '##' then
     BalanceList.Add(DataStr)
   else begin
   // BalanceList.SaveToFile('InterestList.Txt');
   // if not AnsiContainsStr(BalanceList.Text, 'NO DATA') then
     ShowInterestStock();
     BalanceList.Clear;
   end;
  {
   if(Order_AfterInventory) then begin   // before order, get Inventory, then order
     for i := 0 to fmChungYi.ListV_Interest.Items.Count - 1 do begin
       if(fmChungYi.ListV_Interest.Items[i].SubItems.strings[0]= fmChungYi.cbbCommNO.Text) then begin
         OrderQty:= StrToInt(fmChungYi.ListV_Interest.Items[i].SubItems.strings[2]);

         if(fmChungYi.ListV_Interest.Items[i].SubItems.strings[1]='B') then
           InventoryBuySell:= 1
         else
           InventoryBuySell:= 0;

         if(OrderType='Balance') then
           Stock_OptionOrder.AfterInventoryOrder(OrderQty, InventoryBuySell)
         else
           Stock_OptionOrder.AfterInventoryOrder(StrToInt(fmChungYi.edtQty.Text) + OrderQty, InventoryBuySell);
         break;
       end;
     end;
     Order_AfterInventory:= false;
   end else begin  // after ordering or just get Inventory

   end;
   }
//  fmChungYi.tsOpenInterest.Caption:= '未平倉內容 (' + IntToStr(fmChungYi.ListV_Interest.Items.Count) + ')';
 end else if TypeNM= 'OverSeas' then begin
   if(AnsiContainsStr(DataStr, '##')) then begin  // 結束
     StartOverseas_Inventory:= false;
   end else if(AnsiContainsStr(DataStr, '@@')) then begin
     StartOverseas_Inventory:= true;
  //   if(AnsiContainsStr(DataStr, '查詢完畢')) then // no data
  //     StartOverseas_Inventory:= false;

   end;

   // 實際內容
   if StartOverseas_Inventory and (not AnsiContainsStr(DataStr, '@@')) then begin
     OverseasList:= TStringList.Create;
     OverseasInventory(OverseasList);
     FreeAndNil(OverseasList);
   end;

   // before order, get Inventory, then order. get Inventory 結束後才下 Order
   if(not StartOverseas_Inventory and Order_AfterInventory) then begin
     OrderQty:= 0;

     for i := 0 to fmChungYi.ListV_Interest.Items.Count - 1 do begin
       if(fmChungYi.ListV_Interest.Items[i].SubItems.strings[0]= fmChungYi.cbbCommNO.Text) then begin
         OrderQty:= StrToInt(fmChungYi.ListV_Interest.Items[i].SubItems.strings[2]);

         if(fmChungYi.ListV_Interest.Items[i].SubItems.strings[1]='B') then
           InventoryBuySell:= 1
         else
           InventoryBuySell:= 0;

         break;
       end;
     end;

     if(fmChungYi.ListV_Interest.Items.Count= 0) then begin
       if(InvenResult.LeftQty= 0) then begin
         OrderQty:= StrToInt(fmChungYi.edtQty.Text);
         InventoryBuySell:= fmChungYi.rgBuySell.ItemIndex;
       end else begin  // 反向單
         OrderQty:= InvenResult.LeftQty;
         if(InvenResult.LastBuySell= 'B') then
           InventoryBuySell:= 1
         else
           InventoryBuySell:= 0;
       end;

     end;

     if(OrderType='Balance') or (InvenResult.LeftQty= 0) then
       OverSeasOrder.AfterInventoryOverseaOrder(CloseP, OrderQty, InventoryBuySell)
     else
       OverSeasOrder.AfterInventoryOverseaOrder(CloseP, StrToInt(fmChungYi.edtQty.Text) + OrderQty, InventoryBuySell);

     Order_AfterInventory:= false;
   end ;

 end;


end;

procedure ShowInterestStock();
var Titem, ListItem: Tlistitem;
    I: Integer;
begin
  fmChungYi.ListV_Interest.Clear;
  if not AnsiContainsStr(BalanceList.Text, 'NO DATA') then begin // 若有資料
   for I := 0 to BalanceList.Count - 1 do begin
    sK_LineList.OrderList.Add(fmChungYi.edtPrice.Text); // 有資料時, 才列入正式 OrderList
    sK_LineList.Order_TimeList.Add(DateTimeToStr(Now));
    TempList.Text:= BalanceList.Strings[I];
    TempList.StrictDelimiter:= True;
    TempList.Delimiter:= ',';
    TempList.DelimitedText:= TempList.Text;

    Titem := fmChungYi.ListV_Interest.Items.add;
    Titem.Caption := TempList.Strings[1];  // 帳號
    Titem.SubItems.Add(TempList.Strings[2]);  // 商品
    Titem.SubItems.Add(TempList.Strings[3]);  // 買賣別
    Titem.SubItems.Add(TempList.Strings[4]);  // 未平倉部位
    Titem.SubItems.Add(TempList.Strings[6]);  // 平均成本

 //   NowBuySell:= fmChungYi.ListV_Interest.Items[0].SubItems.strings[1]; // 記錄目前 B or S
    TempList.Clear;
   end;
  end;

end;

procedure OverseasInventory(OverseasList: TStringList);
var Titem, ListItem: Tlistitem;
    I: Integer;
    Sql_Str: String;
begin
  fmChungYi.ListV_Interest.Clear;

  TempList.Text:= OverseasList.Strings[I];
  TempList.StrictDelimiter:= True;
  TempList.Delimiter:= ',';
  TempList.DelimitedText:= TempList.Text;

  Titem := fmChungYi.ListV_Interest.Items.add;
  Titem.Caption := TempList.Strings[2];  // 帳號
  Titem.SubItems.Add(TempList.Strings[3]);  // 商品
  Titem.SubItems.Add(TempList.Strings[5]);  // 買賣別
  Titem.SubItems.Add(TempList.Strings[6]);  // 未平倉部位
  Titem.SubItems.Add(TempList.Strings[8]);  // 平均成本

  // 更新 DB 的最後一筆資料
  Sql_Str:= 'Update RecordMsg set Price= ' + TempList.Strings[8] + ' and Qty=' + TempList.Strings[6]
    + ' where Account="' + fmChungYi.ListView3.Items[0].Caption
    + '" and StockNM="' + TempList.Strings[3]
    + '" and BuySell="temp" ' ;
  DataModule1.asqQU_Temp.SQL.Text:= Sql_Str;
  DataModule1.asqQU_Temp.ExecSQL;


  TempList.Clear;
end;
end.
