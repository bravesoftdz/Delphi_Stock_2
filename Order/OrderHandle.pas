unit OrderHandle;

interface

uses StdCtrls, ExtCtrls, SysUtils, Dialogs;

procedure NormalOrder(OrderType: String; BuySell: String; OrderParam: String='');
function GetBalance(): Extended; // ���o����l�q
procedure btnBalance();

var TradeQty: Integer= 0; // �U��f��

implementation

uses Public_Variant, DB_Handle, DB_Type, K_Line_Save, Stock_OptionOrder, OverSeasOrder,
   getK_Value, ChungYi_Main, DMRecord, Quote;


// �U��Ѽ�
procedure NormalOrder(OrderType: String; BuySell: String; OrderParam: String='');
var J: Integer;
    InvenResult: TInventory_Stock;
    LeftQty: Integer;
begin
   if(Public_Variant.UserNM= 'JackyChou') then
     exit;

   InvenResult:= DB_Handle.CheckInventory(fmChungYi.cbbCommNO.Text);
   // if InvenResult.LeftQty = 0, the buy / sell bust be assinged by outside: BuySell

   if TickTime < Public_Variant.EndTime then begin// 13:44:01 �H�ᤣ�U��
     if (fmChungYi.edtQty.Text= '0') or (fmChungYi.edtQty.Text= '') then fmChungYi.edtQty.Text:= '1';
     KeepListData(); // �O�d�ˬd���

   {  if InvenResult.LastBuySell = 'S' then begin
       fmChungYi.rgBuySell.ItemIndex:= 0;
       NowBuySell:= 'B';
     end;
     if InvenResult.LastBuySell = 'B' then begin
       fmChungYi.rgBuySell.ItemIndex:= 1;
       NowBuySell:= 'S';
     end;
     }
   end else
     exit;

    OrderParamList.Add(TickTime + ',' + NowBuySell + ',' + FloatToStr(CloseP) + ',' + OrderParam);
    OrderParamList.SaveToFile('OrderParamList.txt');


    if InvenResult.LeftQty > 0 then begin// ���w�s
      if OrderType= 'Balance' then begin// ���� // NowBuySell ��ثe�w�s
        TradeQty:= InvenResult.LeftQty;
      //  NowBuySell:= ''; // ���ܮ�, NowBuySell �M��, �s�ܫh�b�U�����O
      end;

      if OrderType= 'Order' then begin  // �ϦV��
        TradeQty:= StrToInt(fmChungYi.edtQty.Text) + InvenResult.LeftQty;
      end;

      if(InvenResult.LastBuySell='S') then begin
        fmChungYi.rgBuySell.ItemIndex:= 0;
        NowBuySell:= 'B'
      end else if(InvenResult.LastBuySell='B') then begin
        fmChungYi.rgBuySell.ItemIndex:= 1;
        NowBuySell:= 'S';
      end;

    end else begin   // �L�w�s, �u��s��
      TradeQty:= StrToInt(fmChungYi.edtQty.Text);
      NowBuySell:= BuySell;
    end;

    LeftQty:= TradeQty - InvenResult.LeftQty;
    if(Public_Variant.FuturOrderType= '���f') then begin
      if(OrderType='Balance') then
        Stock_OptionOrder.AfterInventoryOrder(TradeQty, fmChungYi.rgBuySell.ItemIndex, CloseP)
      else
        Stock_OptionOrder.AfterInventoryOrder(StrToInt(fmChungYi.edtQty.Text) + TradeQty, fmChungYi.rgBuySell.ItemIndex, CloseP);
    end else if(Public_Variant.FuturOrderType= '�~��') then begin
      OverSeasOrder.OverseasFutureOrder(CloseP, LeftQty, NowBuySell, TradeQty);
    end;

    BreakLoop:= True; // �U�����, �U������]�� True
    A13LowReturn:= False;
    A13HighReturn:= False;
    B_OrderOK:= False; // �@�U���, B_OrderOK �ߨ��ର false, �ϤϦV���i�U��

    Get_D53_D53(6);
end;

function GetBalance(): Extended; // ���o����l�q
var E_Sell, E_Buy, InventoryCost: Extended;
    HasOrder: Boolean; // �O�_���d�ܳ�
begin
  E_Buy:= 0;
  E_Sell:= 0;
  HasOrder:= False;

  // ���P�_����O�_�w�U��
  DataModule1.asqQU_Temp.SQL.Text:= 'select SN from RecordMsg where TradeDate= "' + ThisTradeDate + '"';
  DataModule1.asqQU_Temp.Open;
  if DataModule1.asqQU_Temp.RecordCount > 0 then
  begin
   HasOrder:= True;
   if fmChungYi.ListV_Interest.Items.Count > 0 then  // ���⤵��w�s����
   begin
    if (fmChungYi.ListV_Interest.Items[0].SubItems.strings[1]= 'B') then
     InventoryCost:= StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[2])*
                    StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])
    else
     InventoryCost:= (-1) * StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[2])*
                    StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])
   end;
  end else begin
   if fmChungYi.ListV_Interest.Items.Count > 0 then  // ����d�ܮw�s����
   begin
    if (fmChungYi.ListV_Interest.Items[0].SubItems.strings[1]= 'B') then
     LastCost:= StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[2])*
                    StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])
    else
     LastCost:= (-1) * StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[2])*
                    StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])
   end;
  end;

  DataModule1.asqQU_Temp.SQL.Text:= 'select BuySell, Sum(Price*Qty) as BalanceQty '
    + ' from RecordMsg where TradeDate="' + DateToStr(fmQuote.dtpDate.Date) + '" and BuySell="B"';
  DataModule1.asqQU_Temp.Open;   // E_Buy
  if DataModule1.asqQU_Temp.FieldByName('BalanceQty').Text <> '' then
   E_Buy:= DataModule1.asqQU_Temp.FieldByName('BalanceQty').AsFloat;

  DataModule1.asqQU_Temp.SQL.Text:= 'select BuySell, Sum(Price*Qty) as BalanceQty '
    + ' from RecordMsg where TradeDate="' + DateToStr(fmQuote.dtpDate.Date) + '" and BuySell="S"';
  DataModule1.asqQU_Temp.Open;   // E_Sell
  if DataModule1.asqQU_Temp.FieldByName('BalanceQty').Text <> '' then
   E_Sell:= DataModule1.asqQU_Temp.FieldByName('BalanceQty').AsFloat;

  // ���o�l�q
  if HasOrder then
   Result:= E_Sell - E_Buy + InventoryCost - LastCost // ����w�U��
  else Result:= 0; // ����w���U��

end;

// ��ʥ���
procedure btnBalance();
var InvenResult: TInventory_Stock;
begin

 OrderType:= 'Balance';
 InvenResult:= DB_Handle.CheckInventory(fmChungYi.cbbCommNO.Text);

 if InvenResult.LeftQty > 0 then begin
  if InvenResult.LastBuySell = 'B' then OrderHandle.NormalOrder('Balance', 'S', 'Manual')
  else OrderHandle.NormalOrder('Balance', 'B', 'Manual');
 end else begin
   ShowMessage('�L�d�ܳ�');
 end;
end;
end.
