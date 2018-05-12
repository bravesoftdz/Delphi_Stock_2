unit OverSeasOrder;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, StrUtils, SKCOMLib_TLB, String_Form;

  procedure OverseasFutureOrder(OderPrice: Extended; LeftQty: Integer; IsBuySell: String; BuySellQty: Integer);
  function ConvertOrderDate(Year_Str, Month_Str: String): String;
  function getProductNO(Comm_Str: String): String;
  procedure AfterInventoryOverseaOrder(OderPrice: Extended; BuySellQty: Integer;
   BuySellType: Integer);


implementation

uses ChungYi_Main, Quote_uSKQ, SQLFunc, Public_Variant, StringList_Fun, DMRecord,
     Quote, Strategy, Stock_OptionOrder, DB_Handle, DB_Type, OrderHandle;

// overseas ���f�U��
procedure OverseasFutureOrder(OderPrice: Extended; LeftQty: Integer; IsBuySell: String; BuySellQty: Integer);
var
   Item, ListItem, ListItem1 : TListItem;
   iCode : integer;
   iSize : integer;

   SeaOrder: OVERSEAFUTUREORDER;
   getOrderMsg: WideString;
   StockList: TStringList;
   getTime : TDateTime;
   Date_Str, Year_Str, Month_Str: String;
begin
   StockList:= TstringList.Create;
   StockList.Add(fmChungYi.cbbCommNO.Text);
   StockList.Delimiter:= ',';
   StockList.DelimitedText:= StockList.Text;

   getTime:= Now;
   Date_Str:= stringreplace(DateToStr(getTime), '/', '', [rfReplaceAll, rfIgnoreCase]);
   Year_Str:= MidStr(Date_Str, 1, 4);
   Month_Str:= MidStr(Date_Str, 5, 2);

   fmChungYi.edtPrice.Text:= FloatToStr(CloseP); // ����P�w

   if(DB_Handle.CheckTestMode) then begin
     Item := fmChungYi.ListView1.Items.Item[0];

           ListItem := fmChungYi.ListView3.Items.Add;
           ListItem.Caption := Item.SubItems[0]+Item.Caption;
           ListItem.SubItems.Add(TickTime);  //0
           ListItem.SubItems.Add( fmChungYi.cbbCommNO.Text);  //1
           ListItem.SubItems.Add( fmChungYi.rgBuySell.Items.Strings[ fmChungYi.rgBuySell.ItemIndex]);
           ListItem.SubItems.Add( fmChungYi.rgTradeType.Items.Strings[ fmChungYi.rgTradeType.ItemIndex]);
           ListItem.SubItems.Add( fmChungYi.edtPrice.Text);
           ListItem.SubItems.Add(IntToStr(TradeQty));
           ListItem.SubItems.Add( '');
           ListItem.SubItems.Add( '');


           SeaOrder.bstrFullAccount:= WideString(FutureAccount);
           SeaOrder.bstrExchangeNo:= WideString(StockList[0]);
      //     SeaOrder.bstrStockNo:= WideString(StockList[1]);
           SeaOrder.bstrStockNo:= getProductNO(StockList[1]);
      //     SeaOrder.bstrYearMonth:= WideString(Year_Str + Month_Str); // ???
           SeaOrder.bstrYearMonth:= ConvertOrderDate(Year_Str, Month_Str);
      //     SeaOrder.bstrYearMonth2:= WideString(Year_Str + Month_Str); // ???
           SeaOrder.bstrOrder:= WideString(FloatToStr(OderPrice));
      //     SeaOrder.bstrOrderNumerator:= WideString(FloatToStr(OderPrice)); // ???
           SeaOrder.bstrTrigger:= WideString(FloatToStr(OderPrice));   // ???
      //     SeaOrder.bstrTriggerNumerator:= WideString(FloatToStr(OderPrice));  // ???
           if(fmChungYi.rgBuySell.Items.Strings[ fmChungYi.rgBuySell.ItemIndex]='B') then
             SeaOrder.sBuySell:= 0
           else
             SeaOrder.sBuySell:= 1;

           SeaOrder.sDayTrade:= 0; // ???
      //     if(TradeQty > 2) then
      //       TradeQty:= 1;
           SeaOrder.nQty:= TradeQty;
           SeaOrder.sTradeType:= 0; // 0:ROD  1:IOC  2:FOK
           SeaOrder.sSpecialTradeType:= 0; // 0:LMT  1:MKT  2:STL  3.STP ???
           SeaOrder.sNewClose:= 0; //�s���ܡA0:�s�� 1:���� (�ثe����i�ϥηs�B����;�����ȷs�ܥi��)

           TempShowInterestStock(LeftQty);
           exit;
   end;

   Order_AfterInventory:= true;
   fmChungYi.btnOpenInterest.Click;


    {
           iCode := fmQuote.SKOrderLib1.SendOverSeaFutureOrder(WideString(fmQuote.edtLogID.Text), false,
             SeaOrder, getOrderMsg);

             if (iCode <> SK_SUCCESS) and (iCode <> 5)  then
             begin
              ListItem.SubItems.Strings[7] := '�e�U����, Code: ' + IntToStr( iCode)+ ' ' + getOrderMsg;
              // �p�G�O�Ҫ�����, �۰ʥ���
               if AnsiContainsStr(getOrderMsg, '�O�Ҫ�����') then fmChungYi.btnBalance.Click;
              // �Ȯɵ{��, ���R��
              // TempShowInterestStock();
             end else begin

              TriggerInternal:= True;

              ListItem.SubItems.Strings[6] := getOrderMsg;
              // ��������ܮw�s
              fmQuote.SKOrderLib1.GetOverSeaFutureOpenInterest(PAnsiChar(WideString(fmChungYi.edUserid.Text)), PAnsiChar(WideString(FutureAccount)));

              // TempShowInterestStock();
             end;
                    }
   LastInventory:= False; // �@�U���, �Q��d�ܧP�w�k false
   // ��ܷ��l�q
   fmQuote.lbBalance.Caption:= '���l�q: ' + FloatToStr(GetBalance());
 //  Windows.Beep(440, 1000);
end;

function ConvertOrderDate(Year_Str, Month_Str: String): String;
var Year_Int, Month_Int: Integer;
begin
  Year_Int:= StrToInt(Year_Str);
  Month_Int:= StrToInt(Month_Str);
  if(Month_Int > 9) then begin
    Month_Int:= Month_Int + 3 - 12;
    Year_Int:= Year_Int + 1;
  end else
    Month_Int:= Month_Int + 3;

  if(Month_Int < 10) then
    Result:= IntToStr(Year_Int) + '0' + IntToStr(Month_Int)
  else
    Result:= IntToStr(Year_Int) + IntToStr(Month_Int);
end;

function getProductNO(Comm_Str: String): String;
var Position: Integer;
begin
  Position:= Pos('_', Comm_Str);
  Result:= StrMiddle(Comm_Str, 1, Position - 1);
end;

procedure AfterInventoryOverseaOrder(OderPrice: Extended; BuySellQty: Integer;
   BuySellType: Integer);
var
   Item, ListItem, ListItem1 : TListItem;
   iCode : integer;
   iSize : integer;

   SeaOrder: OVERSEAFUTUREORDER;
   getOrderMsg: WideString;
   StockList: TStringList;
   getTime : TDateTime;
   Date_Str, Year_Str, Month_Str: String;
   InvenResult: TInventory_Stock;
   LeftQty: Integer;
   Sql_Str: String;
   tempButSell: String;
begin

  StockList:= TstringList.Create;
  StockList.Add(fmChungYi.cbbCommNO.Text);
  StockList.Delimiter:= ',';
  StockList.DelimitedText:= StockList.Text;

  getTime:= Now;
  Date_Str:= stringreplace(DateToStr(getTime), '/', '', [rfReplaceAll, rfIgnoreCase]);
  Year_Str:= MidStr(Date_Str, 1, 4);
  Month_Str:= MidStr(Date_Str, 5, 2);

  if(OderPrice= 0) then
    OderPrice:= 2000;

  fmChungYi.edtPrice.Text:= FloatToStr(OderPrice); // ����P�w

  Item := fmChungYi.ListView1.Items.Item[0];

           ListItem := fmChungYi.ListView3.Items.Add;
           ListItem.Caption := Item.SubItems[0]+Item.Caption;
           ListItem.SubItems.Add(TickTime);  //0
           ListItem.SubItems.Add( fmChungYi.cbbCommNO.Text);  //1
           ListItem.SubItems.Add( fmChungYi.rgBuySell.Items.Strings[ fmChungYi.rgBuySell.ItemIndex]);
           ListItem.SubItems.Add( fmChungYi.rgTradeType.Items.Strings[ fmChungYi.rgTradeType.ItemIndex]);
           ListItem.SubItems.Add( fmChungYi.edtPrice.Text);
           ListItem.SubItems.Add(IntToStr(BuySellQty));
           ListItem.SubItems.Add( '');
           ListItem.SubItems.Add( '');

           SeaOrder.bstrFullAccount:= WideString(FutureAccount);
           SeaOrder.bstrExchangeNo:= WideString(StockList[0]);
           SeaOrder.bstrStockNo:= getProductNO(StockList[1]);
      //     SeaOrder.bstrYearMonth:= WideString(Year_Str + Month_Str); // ???
           SeaOrder.bstrYearMonth:= ConvertOrderDate(Year_Str, Month_Str);
      //     SeaOrder.bstrYearMonth2:= WideString(Year_Str + Month_Str); // ???
           SeaOrder.bstrOrder:= WideString(FloatToStr(OderPrice));
      //     SeaOrder.bstrOrderNumerator:= WideString(FloatToStr(OderPrice)); // ???
           SeaOrder.bstrTrigger:= WideString(FloatToStr(OderPrice));   // ???
      //     SeaOrder.bstrTriggerNumerator:= WideString(FloatToStr(OderPrice));  // ???
           if(fmChungYi.rgBuySell.Items.Strings[ fmChungYi.rgBuySell.ItemIndex]='B') then
             SeaOrder.sBuySell:= 0
           else
             SeaOrder.sBuySell:= 1;

           SeaOrder.sDayTrade:= 0; // ???
           if(TradeQty > 2) then
             TradeQty:= 1;
           SeaOrder.nQty:= TradeQty;
           SeaOrder.sTradeType:= 0; // 0:ROD  1:IOC  2:FOK
           SeaOrder.sSpecialTradeType:= 0; // 0:LMT  1:MKT  2:STL  3.STP ???
           SeaOrder.sNewClose:= 0; //�s���ܡA0:�s�� 1:���� (�ثe����i�ϥηs�B����;�����ȷs�ܥi��)

   // Temp code, �ݧR��
   // =========================================================
   // �g�J��Ʈw
  InvenResult:= DB_Handle.CheckInventory(fmChungYi.cbbCommNO.Text);
  // ��̬ۦP , �s��
  if((InvenResult.LastBuySell= 'B') and (BuySellType= 0))
    or ((InvenResult.LastBuySell= 'S') and (BuySellType= 1)) then begin
    LeftQty:= BuySellQty;
  end else begin // �ϦV��
    LeftQty:= BuySellQty - InvenResult.LeftQty;
  end;

  if(BuySellType= 0) then
    tempButSell:= 'B'
  else tempButSell:= 'S';

  ListItem := fmChungYi.ListView3.Items.Item[fmChungYi.ListView3.Items.Count - 1];
  SQLFunc.InsertData(ListItem, LeftQty, true);

  // ��s DB ���̫�@�����
  Sql_Str:= 'Update RecordMsg set BuySell="' + tempButSell + '" , Price= ' + FloatToStr(OderPrice)
    + ' where Account="' + fmChungYi.ListView3.Items[0].Caption
    + '" and StockNM="' + fmChungYi.cbbCommNO.Text
    + '" and BuySell="temp" ' ;
  DataModule1.asqQU_Temp.SQL.Text:= Sql_Str;
  DataModule1.asqQU_Temp.ExecSQL;
  //==========================================================

   iCode := fmQuote.SKOrderLib1.SendOverSeaFutureOrder(WideString(fmQuote.edtLogID.Text), false,
             SeaOrder, getOrderMsg);

             if (iCode <> SK_SUCCESS) and (iCode <> 5) then begin
              ListItem.SubItems.Strings[7] := '�e�U����, Code: ' + IntToStr( iCode)+ ' ' + getOrderMsg;
              // �p�G�O�Ҫ�����, �۰ʥ���
               InvenResult:= DB_Handle.CheckInventory(fmChungYi.cbbCommNO.Text);
               if AnsiContainsStr(getOrderMsg, '�O�Ҫ�����') and (InvenResult.LeftQty > 0) then
                 fmChungYi.btnBalance.Click;
             end else begin

               TriggerInternal:= True;
               ListItem.SubItems.Strings[6] := getOrderMsg;
               // ��������ܮw�s
               fmQuote.SKOrderLib1.GetOverSeaFutureOpenInterest(WideString(Userid), WideString(FutureAccount))
             end;

end;
end.
