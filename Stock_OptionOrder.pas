unit Stock_OptionOrder;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, StrUtils, SKCOMLib_TLB;

// procedure FutureOrder(LeftQty: Integer; IsBuySell: String; BuySellQty: Integer);
procedure TempShowInterestStock(LeftQty: Integer);
procedure GetOpenOrder();
function LastInventoryCheck(DateType: String): Integer;
procedure AfterInventoryOrder(BuySellQty: Integer; BuySellType: Integer; OderPrice: Extended);

implementation

uses ChungYi_Main, Quote_uSKQ, SQLFunc, Public_Variant, StringList_Fun, DMRecord,
     Quote, Strategy, DB_Handle, getK_Value, OrderHandle;

 {
// 期貨下單
procedure FutureOrder(LeftQty: Integer; IsBuySell: String; BuySellQty: Integer);
var i,j,k : integer;
   Item, ListItem, ListItem1 : TListItem;
   iCode : integer;
   Symbol,Price : String;
   strMsg : array[0..1023] of AnsiChar;
   iSize : integer;
   getNowTime: String;
   InventoryBuySell, OrderQty: Integer;
begin
   K:= 0;
 //  if fmChungYi.edtPrice.Text= '' then fmChungYi.edtPrice.Text:= 'M'; // 價格判定
   fmChungYi.edtPrice.Text:= FloatToStr(CloseP); // 價格判定


       Item := fmChungYi.ListView1.Items.Item[i];

       for j := 0 to 0 do begin
         if(DB_Handle.CheckTestMode) then begin
           ListItem := fmChungYi.ListView3.Items.Add;

           ListItem.Caption := Item.SubItems[0]+Item.Caption;

           getNowTime:= TimeToStr(Time);
           ListItem.SubItems.Add(getNowTime);  //0
           ListItem.SubItems.Add( fmChungYi.cbbCommNO.Text);  //1
           ListItem.SubItems.Add( fmChungYi.rgBuySell.Items.Strings[ fmChungYi.rgBuySell.ItemIndex]);
           ListItem.SubItems.Add( fmChungYi.rgTradeType.Items.Strings[ fmChungYi.rgTradeType.ItemIndex]);
           ListItem.SubItems.Add( fmChungYi.edtPrice.Text);
           ListItem.SubItems.Add(IntToStr(BuySellQty));
           ListItem.SubItems.Add( '');
           ListItem.SubItems.Add( '');

           Symbol := Trim( fmChungYi.cbbCommNO.Text);
           Price := Trim( fmChungYi.edtPrice.Text);

           strMsg := #0;
           iSize := 1023;

           TempShowInterestStock(LeftQty);
           exit;
         end;

         if(fmChungYi.ListV_Interest.Items.Count > 0) then begin
           for i := 0 to fmChungYi.ListV_Interest.Items.Count - 1 do begin
             if(fmChungYi.ListV_Interest.Items[fmChungYi.ListV_Interest.Items.Count - 1 - i].SubItems.strings[0]= fmChungYi.cbbCommNO.Text) then begin
               OrderQty:= StrToInt(fmChungYi.ListV_Interest.Items[fmChungYi.ListV_Interest.Items.Count - 1 - i].SubItems.strings[2]);

               if(fmChungYi.ListV_Interest.Items[fmChungYi.ListV_Interest.Items.Count - 1 - i].SubItems.strings[1]='B') then
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
         end else begin    // there is no inventory
           if(OrderType='Balance') then
             Stock_OptionOrder.AfterInventoryOrder(OrderQty, InventoryBuySell)
           else
             Stock_OptionOrder.AfterInventoryOrder(StrToInt(fmChungYi.edtQty.Text) + OrderQty, InventoryBuySell);
         end;

         //  Order_AfterInventory:= true;
         //  fmChungYi.btnOpenInterest.Click;
       end;

   LastInventory:= False; // 一下單後, 昨日留倉判定歸 false
   // 顯示當日損益
   fmQuote.lbBalance.Caption:= '當日損益: ' + FloatToStr(GetBalance());
 //  Windows.Beep(440, 1000);
end;
}

procedure TempShowInterestStock(LeftQty: Integer);
var Titem, ListItem: Tlistitem;
    I: Integer;
begin
 sK_LineList.OrderList.Add(fmChungYi.edtPrice.Text);
 sK_LineList.Order_TimeList.Add(DateTimeToStr(Now));
 fmChungYi.ListV_Interest.Clear;

  // 寫入價格
  if fmChungYi.edtPrice.Text= '' then
   fmChungYi.ListView3.Items[fmChungYi.ListView3.Items.Count - 1].SubItems.Strings[4]:= FloatToStr(CloseP)
  else fmChungYi.ListView3.Items[fmChungYi.ListView3.Items.Count - 1].SubItems.Strings[4]:= fmChungYi.edtPrice.Text;
 {
  Titem := fmChungYi.ListV_Interest.Items.add;
  Titem.Caption := fmChungYi.ListView3.Items[0].Caption;  // 帳號
//  Titem.SubItems.Add(fmChungYi.ListView3.Items[1]);  // Order time
  Titem.SubItems.Add(fmChungYi.cbbCommNO.Text);  // 商品
  Titem.SubItems.Add(NowBuySell);  // 買賣別
  Titem.SubItems.Add(fmChungYi.edtQty.Text);  // 未平倉部位
  Titem.SubItems.Add(FloatToStR(CloseP));  // 平均成本
  }

  // 寫入資料庫
  ListItem := fmChungYi.ListView3.Items.Item[fmChungYi.ListView3.Items.Count - 1];
  SQLFunc.InsertData(ListItem, LeftQty, false);
  TradeQty:= 0; // 歸零

  if NowBuySell = '' then // NowBuySell <> '' 時表示目前進平倉, 目前資料清除, 否則錯誤
    fmChungYi.ListV_Interest.Clear;
end;

procedure GetOpenOrder();  // 以資料庫方式  獲取未平倉內容
var Titem, ListItem: Tlistitem;
    LeftQty: Integer;
begin
  if(not DB_Handle.CheckTestMode) then
    exit;

  fmChungYi.ListV_Interest.Clear;
  LeftQty:= LastInventoryCheck(ThisTradeDate); // 與日期無關
  DataModule1.asqQU_Temp.Close;
  DataModule1.asqQU_Temp.SQL.Text:= 'select * from RecordMsg';
  DataModule1.asqQU_Temp.Open;
  DataModule1.asqQU_Temp.Last;

  if (LeftQty > 0) then begin
   Titem := fmChungYi.ListV_Interest.Items.add;
   Titem.Caption := fmChungYi.ListView1.Items[0].Caption;  // 帳號
   Titem.SubItems.Add(fmChungYi.cbbCommNO.Text);  // 商品
   Titem.SubItems.Add(DataModule1.asqQU_Temp.FieldByName('BuySell').Text);  // 買賣別
   Titem.SubItems.Add(IntToStr(LeftQty));  // 未平倉部位
   Titem.SubItems.Add(DataModule1.asqQU_Temp.FieldByName('Price').Text);  // 平均成本

   NowBuySell:= DataModule1.asqQU_Temp.FieldByName('BuySell').Text;
  end;
end;

function LastInventoryCheck(DateType: String): Integer;
var LastBuyQty, LastSellQty: Integer;
begin
{  // 判定是否有留倉單
  LastBuyQty:= 0;
  LastSellQty:= 0;
  LastInventory:= False;
  DataModule1.asqQU_Temp.Close;
  DataModule1.asqQU_Temp.SQL.Text:= 'select Sum(Qty) as TotalQty from RecordMsg where BuySell="B"';
  DataModule1.asqQU_Temp.Open;
  if DataModule1.asqQU_Temp.FieldByName('TotalQty').Text <> '' then
   LastBuyQty:= DataModule1.asqQU_Temp.FieldByName('TotalQty').AsInteger;

  DataModule1.asqQU_Temp.Close;
  DataModule1.asqQU_Temp.SQL.Text:= 'select Sum(Qty) as TotalQty from RecordMsg where BuySell="S"';
  DataModule1.asqQU_Temp.Open;
  if DataModule1.asqQU_Temp.FieldByName('TotalQty').Text <> '' then
   LastSellQty:= DataModule1.asqQU_Temp.FieldByName('TotalQty').AsInteger;

  Result:= abs(LastSellQty - LastBuyQty);  }

  // 正統作法
  if fmChungYi.ListV_Interest.Items.Count > 0 then LastInventory:= True;
end;

procedure AfterInventoryOrder(BuySellQty: Integer; BuySellType: Integer; OderPrice: Extended);
var i,j,k : integer;
   Item, ListItem, ListItem1 : TListItem;
   iCode : integer;
   Symbol,Price : String;
   strMsg : WideString;
   iSize : integer;
   getNowTime: String;
   OrderStruct: FUTUREORDER;
begin
  ListItem := fmChungYi.ListView3.Items.Add;

       //    ListItem.Caption := Item.SubItems[0]+Item.Caption;

           getNowTime:= TimeToStr(Time);
           ListItem.SubItems.Add(getNowTime);  //0
           ListItem.SubItems.Add( fmChungYi.cbbCommNO.Text);  //1
           ListItem.SubItems.Add( fmChungYi.rgBuySell.Items.Strings[ fmChungYi.rgBuySell.ItemIndex]);
           ListItem.SubItems.Add( fmChungYi.rgTradeType.Items.Strings[ fmChungYi.rgTradeType.ItemIndex]);
           ListItem.SubItems.Add( fmChungYi.edtPrice.Text);
           ListItem.SubItems.Add(IntToStr(BuySellQty));
           ListItem.SubItems.Add( '');
           ListItem.SubItems.Add( '');

           OrderStruct.bstrFullAccount:= WideString(FutureAccount);
           OrderStruct.bstrStockNo:= fmChungYi.cbbCommNO.Text;
           OrderStruct.sTradeType:= 2;            // //0:ROD  1:IOC  2:FOK
           OrderStruct.sBuySell:= BuySellType;
           OrderStruct.sDayTrade:= 1;                //當沖0:否 1:是
           OrderStruct.sNewClose:= 2;                //新平倉，0:新倉 1:平倉 2:自動
           OrderStruct.bstrPrice:= FloatToStr(OderPrice);
           OrderStruct.nQty:= BuySellQty;

           strMsg := #0;
           iSize := 1023;

           iCode := fmQuote.SKOrderLib1.SendFutureOrder(WideString(fmQuote.edtLogID.Text), false,
           OrderStruct, strMsg);

             if (iCode <> SK_SUCCESS) and (iCode <> 5) then begin
              ListItem.SubItems.Strings[7] := '委託失敗, Code: ' + IntToStr( iCode)+ ' ' + strMsg;
              // 如果保證金不足, 自動平倉
              // if AnsiContainsStr(strMsg, '保證金不足') then fmChungYi.btnBalance.Click;
             end else begin

              TriggerInternal:= True;

              ListItem.SubItems.Strings[6] := strMsg;
              // fmChungYi.OpenInterestTimer.Enabled:= True;

             end;

end;
end.
