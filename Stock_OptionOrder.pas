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
// ���f�U��
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
 //  if fmChungYi.edtPrice.Text= '' then fmChungYi.edtPrice.Text:= 'M'; // ����P�w
   fmChungYi.edtPrice.Text:= FloatToStr(CloseP); // ����P�w


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

   LastInventory:= False; // �@�U���, �Q��d�ܧP�w�k false
   // ��ܷ��l�q
   fmQuote.lbBalance.Caption:= '���l�q: ' + FloatToStr(GetBalance());
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

  // �g�J����
  if fmChungYi.edtPrice.Text= '' then
   fmChungYi.ListView3.Items[fmChungYi.ListView3.Items.Count - 1].SubItems.Strings[4]:= FloatToStr(CloseP)
  else fmChungYi.ListView3.Items[fmChungYi.ListView3.Items.Count - 1].SubItems.Strings[4]:= fmChungYi.edtPrice.Text;
 {
  Titem := fmChungYi.ListV_Interest.Items.add;
  Titem.Caption := fmChungYi.ListView3.Items[0].Caption;  // �b��
//  Titem.SubItems.Add(fmChungYi.ListView3.Items[1]);  // Order time
  Titem.SubItems.Add(fmChungYi.cbbCommNO.Text);  // �ӫ~
  Titem.SubItems.Add(NowBuySell);  // �R��O
  Titem.SubItems.Add(fmChungYi.edtQty.Text);  // �����ܳ���
  Titem.SubItems.Add(FloatToStR(CloseP));  // ��������
  }

  // �g�J��Ʈw
  ListItem := fmChungYi.ListView3.Items.Item[fmChungYi.ListView3.Items.Count - 1];
  SQLFunc.InsertData(ListItem, LeftQty, false);
  TradeQty:= 0; // �k�s

  if NowBuySell = '' then // NowBuySell <> '' �ɪ�ܥثe�i����, �ثe��ƲM��, �_�h���~
    fmChungYi.ListV_Interest.Clear;
end;

procedure GetOpenOrder();  // �H��Ʈw�覡  ��������ܤ��e
var Titem, ListItem: Tlistitem;
    LeftQty: Integer;
begin
  if(not DB_Handle.CheckTestMode) then
    exit;

  fmChungYi.ListV_Interest.Clear;
  LeftQty:= LastInventoryCheck(ThisTradeDate); // �P����L��
  DataModule1.asqQU_Temp.Close;
  DataModule1.asqQU_Temp.SQL.Text:= 'select * from RecordMsg';
  DataModule1.asqQU_Temp.Open;
  DataModule1.asqQU_Temp.Last;

  if (LeftQty > 0) then begin
   Titem := fmChungYi.ListV_Interest.Items.add;
   Titem.Caption := fmChungYi.ListView1.Items[0].Caption;  // �b��
   Titem.SubItems.Add(fmChungYi.cbbCommNO.Text);  // �ӫ~
   Titem.SubItems.Add(DataModule1.asqQU_Temp.FieldByName('BuySell').Text);  // �R��O
   Titem.SubItems.Add(IntToStr(LeftQty));  // �����ܳ���
   Titem.SubItems.Add(DataModule1.asqQU_Temp.FieldByName('Price').Text);  // ��������

   NowBuySell:= DataModule1.asqQU_Temp.FieldByName('BuySell').Text;
  end;
end;

function LastInventoryCheck(DateType: String): Integer;
var LastBuyQty, LastSellQty: Integer;
begin
{  // �P�w�O�_���d�ܳ�
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

  // ���Χ@�k
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
           OrderStruct.sDayTrade:= 1;                //��R0:�_ 1:�O
           OrderStruct.sNewClose:= 2;                //�s���ܡA0:�s�� 1:���� 2:�۰�
           OrderStruct.bstrPrice:= FloatToStr(OderPrice);
           OrderStruct.nQty:= BuySellQty;

           strMsg := #0;
           iSize := 1023;

           iCode := fmQuote.SKOrderLib1.SendFutureOrder(WideString(fmQuote.edtLogID.Text), false,
           OrderStruct, strMsg);

             if (iCode <> SK_SUCCESS) and (iCode <> 5) then begin
              ListItem.SubItems.Strings[7] := '�e�U����, Code: ' + IntToStr( iCode)+ ' ' + strMsg;
              // �p�G�O�Ҫ�����, �۰ʥ���
              // if AnsiContainsStr(strMsg, '�O�Ҫ�����') then fmChungYi.btnBalance.Click;
             end else begin

              TriggerInternal:= True;

              ListItem.SubItems.Strings[6] := strMsg;
              // fmChungYi.OpenInterestTimer.Enabled:= True;

             end;

end;
end.
