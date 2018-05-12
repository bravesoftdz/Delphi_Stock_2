unit First_Check_Strategy;

interface

uses DBCtrls, Graphics, Classes, SysUtils;

procedure Check_Gate1(CommNO: String);

implementation

uses Stock_OptionOrder, Strategy_Engine, Strategy_Float, Strategy_Internal,
  Strategy_InventAnti, Strategy_KeepOrder, Strategy_PreOrder, Strategy_Profit,
  Strategy_Special, Strategy_Special_2, Public_Variant, OrderHandle;

var FloatStopOrder: boolean;
    InternalPass: String;


procedure Check_Gate1(CommNO: String);
begin
  if(Public_Variant.UserNM= 'MrHuang') then begin
    GetOpenOrder();  // �H��Ʈw�覡  ��������ܤ��e (�̭��|�P�_�O�_�� TestMode)
    if(GoStrategy_PreOrder()) then begin// �e�ܳ�PŪ
      if(PreOrder_Active(CommNO)) then begin
         OrderHandle.NormalOrder('Balance', '');
      end;
    end;
  end;

end;

procedure Check_Gate2(CommNO: String);
begin
  if(Public_Variant.UserNM= 'MrHuang') then begin
    if(GoStrategy_Profit()) then begin //  only balance   PT��Q�j��
      if(Profit_Active(CommNO)) then begin
         OrderHandle.NormalOrder('Balance', '');    // buy sell is assigned by inventory itself
      end;
    end;

    if(GoStrategy_InventAnti()) then begin //  TR�w�s��ϦV
      if(InventAnti_Active(CommNO)) then begin
         OrderHandle.NormalOrder('Order', '');
      end;
    end;

    if(GoStrategy_Float()) then begin //  SL�L��}��
      if(Float_Active(CommNO)) then begin
        FloatStopOrder:= true;
      end else
        FloatStopOrder:= false;
    end;

    if(GoStrategy_Internal()) then begin //  HD���T�T
      InternalPass:= Initial_Internal(CommNO);
    end;
  end;

  if (not FloatStopOrder) and (GoStrategy_Engine()) then begin //  ��������C
    if (Initial_Engine(CommNO)= 'B') and (InternalPass= 'B') then
      OrderHandle.NormalOrder('Order', 'B')
    else if(Initial_Engine(CommNO)= 'S') and (InternalPass= 'S') then
      OrderHandle.NormalOrder('Order', 'S');
  end;

  if(GoStrategy_KeepOrder()) then begin //  SP�d�ܳ�PŪ
    if(Initial_KeepOrder(CommNO)= 'B') then
      OrderHandle.NormalOrder('Order', 'B')
    else if(Initial_KeepOrder(CommNO)= 'S') then
      OrderHandle.NormalOrder('Order', 'S')
    else if(Initial_KeepOrder(CommNO)= 'Balance') then
      OrderHandle.NormalOrder('Balance', '')
  end;

end;
end.
