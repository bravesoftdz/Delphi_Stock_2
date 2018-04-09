unit Strategy;

interface

uses Windows, Messages, SysUtils, Controls, Classes, DBClient, DB, Dialogs,
     Graphics, Forms, StdCtrls;

 function B1_Strategy(): String;
 procedure B1_Strategy_Any();
 procedure B1_Strategy_Assign();
 procedure B1_Order();
 procedure Trigger_C_Strategy(TradePrice, NowHigh, NowLow: Extended);
 procedure Trigger_C2_Strategy(TradePrice, NowHigh, NowLow, AvePrice: Extended);
 procedure Trigger_D1_Strategy(AvePrice, Ave10, Ave20, TradePrice: Extended);
 procedure RunStrategey(TradePrice, AvePrice: Extended);
 procedure Trigger_E_Strategy();
 procedure LastPhase();
 procedure WeightLight();
 procedure KeepListData();
 function GetBalance(): Extended; // ���o����l�q
 procedure A4_Module();
 procedure ReSetK(U_or_D: String);  // K Ĳ�� Reset

implementation

uses Quote, Public_Variant, ChungYi_Main, DMRecord, StringList_Fun, DB_Handle, getK_Value;

// �e�}�� (��������C�I), �d���᭱�ϥ�
function B1_Strategy(): String;
var I, StartNO, EndNO: Integer;
begin
 SetData.P_Lowest:= 0;
 // ���o B1 ���C�I      // ���o�e�X�̰��C�� �D���N�I
 if (fmChungYi.dbeB1.Text <> '')
    and (DateList.Count >= StrToInt(fmChungYi.dbeB1.Text)) then
 begin
  if DMRecord.IndexNO= 61 then // �L��
  begin
   StartNO:= HistoryKList.Count - StrToInt(fmChungYi.dbeB1.Text)-1;
   EndNO:= HistoryKList.Count - 2;
  end else begin  // �L��
   StartNO:= HistoryKList.Count - StrToInt(fmChungYi.dbeB1.Text);
   EndNO:= HistoryKList.Count - 1;
  end;

  for I := StartNO to EndNO do
  begin
   TempList.Text:= HistoryKList.Strings[I];
   TempList.Delimiter:= ',';
   TempList.DelimitedText:= TempList.Text;
   if SetData.P_Highest < StrToFloat(TempList.Strings[2])/100 then
    SetData.P_Highest:= StrToFloat(TempList.Strings[2])/100;
   if (SetData.P_Lowest <> 0) then begin
    if (SetData.P_Lowest > StrToFloat(TempList.Strings[3])/100) then
     SetData.P_Lowest := StrToFloat(TempList.Strings[3])/100;
   end else SetData.P_Lowest := StrToFloat(TempList.Strings[3])/100;
  end;

 end;
end;

procedure B1_Strategy_Assign(); // Ĳ�o���󦨥߫h ���I�d��: Sell, �C�I�d��: Buy
begin
  if (fmChungYi.dbrgB2or3.ItemIndex= 1) and (fmChungYi.dbeB1.Text <>'') then // (OutsideUpDown<> '')
  begin
   if (ThisOpen < sStrategy.B_HighD) then
    if (ThisOpen > sStrategy.B_LowU) then InsideHighLow:= True
    else begin
     InsideHighLow:= False;
     OutsideUpDown:= 'Down';
    end
   else OutsideUpDown:= 'Up';
  end;

 if B_Order < 2 then
 begin
  if InsideHighLow then B1_Order();  // ��}�l�b�d��

  if not InsideHighLow then  // ��}�l���b�d��
  begin
   if (OutsideUpDown= 'Down') and (CloseP >= sStrategy.B_HighD) then B1_Order();
   if (OutsideUpDown= 'Up') and (CloseP <= sStrategy.B_LowU) then B1_Order();
  end;
 end;

 if B_OrderOK and (B_Order =1) and (fmChungYi.dbeB5.Text <>'') then // �ϤϦV��
 begin
  if (NowBuySell = 'S') and (CloseP - StrToInt(fmChungYi.dbeB5.Text) = StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])) then
  begin
   B_Order:= B_Order + 1;
   fmChungYi.NormalOrder('Order', 'B', 'B3')
  end else
  if (NowBuySell = 'B') and (CloseP + StrToInt(fmChungYi.dbeB5.Text) = StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])) then
  begin
   B_Order:= B_Order + 1;
   fmChungYi.NormalOrder('Order', 'S', 'B3')
  end;
 end;
end;

procedure B1_Order();
begin
{  if B_Order = 1 then
  begin
   if CloseP = sStrategy.B_HighU then
   begin
    B_Order:= B_Order + 1;
    if NowBuySell = 'S' then
     fmChungYi.NormalOrder('Order', 'B', 'B3')
    else if NowBuySell = '' then
     fmChungYi.NormalOrder('Balance', 'B', 'B3');
   end;

   if CloseP = sStrategy.B_LowU then
   begin
    B_Order:= B_Order + 1;
    if NowBuySell = 'B' then
     fmChungYi.NormalOrder('Order', 'S', 'B3')
    else if NowBuySell = '' then
     fmChungYi.NormalOrder('Balance', 'S', 'B3');
   end;
   if CloseP >= Ave5P then ReSetK('1') else ReSetK('-1');
   B_OrderOK:= True;  // ���ɥi�U�Ϥϳ�
  end; }

  if B_Order = 0 then
  begin
   if CloseP = sStrategy.B_HighD then
   begin
    B_Order:= B_Order + 1;
    if NowBuySell = 'B' then
     fmChungYi.NormalOrder('Order', 'S', 'B3')
    else if NowBuySell = '' then
     fmChungYi.NormalOrder('Balance', 'S', 'B3');
   end;

   if CloseP = sStrategy.B_LowU then
   begin
    B_Order:= B_Order + 1;
    if NowBuySell = 'S' then
     fmChungYi.NormalOrder('Order', 'B', 'B3')
    else if NowBuySell = '' then
     fmChungYi.NormalOrder('Balance', 'B', 'B3');
   end;
   if CloseP >= Ave5P then ReSetK('1') else ReSetK('-1');
   B_OrderOK:= True;  // ���ɥi�U�Ϥϳ�
  end;
end;

procedure B1_Strategy_Any(); // ���N���C�I
begin
 if StartOrder and (B_Order < 1) then // ��KĲ��
 begin
  if fmChungYi.ListV_Interest.Items.Count> 0 then
  begin
   if NowBuySell= 'B' then
   begin
    if (CloseP = DataModule1.asqQU_Param.FieldByName('B2').AsExtended) and
       (DataModule1.asqQU_Param.FieldByName('B2').AsExtended > StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])) then
    begin
     B_Order:= B_Order + 1;
     fmChungYi.NormalOrder('Order', 'S', 'B2');
     if CloseP >= Ave5P then ReSetK('1') else ReSetK('-1');
     B_OrderOK:= True;  // ���ɥi�U�Ϥϳ�
     sStrategy.B2_Light:= 1;
    end else sStrategy.B2_Light:= 0;
   end else
   if NowBuySell= 'S' then
   begin
    if (CloseP = DataModule1.asqQU_Param.FieldByName('B2').AsExtended) and
       (DataModule1.asqQU_Param.FieldByName('B2').AsExtended < StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])) then
    begin
     B_Order:= B_Order + 1;
     fmChungYi.NormalOrder('Order', 'B', 'B2');
     if CloseP >= Ave5P then ReSetK('1') else ReSetK('-1');
     B_OrderOK:= True;  // ���ɥi�U�Ϥϳ�
     sStrategy.B2_Light:= 1;
    end else sStrategy.B2_Light:= 0;
   end;
  end;
 end;

 if B_OrderOK and (B_Order =1) and (fmChungYi.dbeB5.Text <>'') then // �ϤϦV��
 begin
  if (NowBuySell = 'S') and (CloseP - StrToInt(fmChungYi.dbeB5.Text) = StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])) then
  begin
   B_Order:= B_Order + 1;
   fmChungYi.NormalOrder('Order', 'B', 'B2')
  end else
  if (NowBuySell = 'B') and (CloseP + StrToInt(fmChungYi.dbeB5.Text) = StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])) then
  begin
   B_Order:= B_Order + 1;
   fmChungYi.NormalOrder('Order', 'S', 'B2')
  end;
 end;
end;


// ����A4 �Ҳ�
procedure A4_Module(); // �W�ߥX�Өѽե�
begin
  // ���C�t  A4_3
   A4_2Float:= False;
   A4_3Floated:= False;
   if (fmChungYi.dbrA1.ItemIndex= 2) then // (�ݰ��C�t)
   begin
    // A4-3 ���� // ���C�t �Ҳ�
    if fmChungYi.dbcbA4_23Check.Checked and (fmChungYi.dbrgA4_2or3.ItemIndex= 1) then
    begin
     if (fmChungYi.dbeA4_3_1.Text <> '') and (fmChungYi.dbeA4_3_2.Text <> '')
       and (SQLList.Count >= StrToInt(fmChungYi.dbeA4_3_1.Text)) then
     begin
      if (((sStrategy.A4_3_High + sStrategy.A4_3_Low)/2 - StrToInt(fmChungYi.dbeA4_3_2.Text)) <
         CloseP) and
         (((sStrategy.A4_3_High + sStrategy.A4_3_Low)/2 + StrToInt(fmChungYi.dbeA4_3_2.Text)) >
         CloseP) then
       A4_3Floated:= True;

{      A4_2Max:= GetMax(HighList, StrToInt(fmChungYi.dbeA4_3_1.Text), 'End');
      A4_2Min:= GetMin(LowList, StrToInt(fmChungYi.dbeA4_3_1.Text), 'End');
      if A4_2Max - A4_2Min < StrToInt(fmChungYi.dbeA4_3_2.Text) then
      begin
       if (CloseP <= A4_2Max) and (CloseP >= A4_2Min) then
        A4_3Floated:= True;
       end;  }
     end;
    end;

    // A4-2 ���C�t �Ҳ�
    if fmChungYi.dbcbA4_23Check.Checked and (fmChungYi.dbrgA4_2or3.ItemIndex= 0) then

    // ���C�t�D�޶�
    if not A4_3Floated and not A4_2Float and A4TimePass then  // A4TimePass �� A4Timer �M�w
    begin
     if NowBuySell <> '' then
     begin
      if (NowBuySell= 'S') and BuyOK then
      begin
       if NowLow > StrToFloat(LowList.Strings[LowList.Count-2]) then A4_Weight1:= 1 else A4_Weight1:=0;
       if NowLow > StrToFloat(LowList.Strings[LowList.Count-1]) then A4_Weight2:= 1 else A4_Weight2:=0;
       if NowHigh > StrToFloat(HighList.Strings[HighList.Count-2]) then A4_Weight3:= 1 else A4_Weight3:=0;
       if NowHigh > StrToFloat(HighList.Strings[HighList.Count-1]) then A4_Weight4:= 1 else A4_Weight4:= 0;
       if CloseP > StrToFloat(HighList.Strings[HighList.Count-1]) then A4_Weight5:= 1 else A4_Weight5:= 0;

       if ((A4_Weight1 + A4_Weight2 + A4_Weight3 + A4_Weight4 + A4_Weight5) >= 3) then
        fmChungYi.NormalOrder('Order', 'B', 'A4');
      end else
      if (NowBuySell= 'B') and SellOK then
      begin
       if NowHigh < StrToFloat(HighList.Strings[HighList.Count-2]) then A4_Weight1:= 1 else A4_Weight1:=0;
       if NowHigh < StrToFloat(HighList.Strings[HighList.Count-1]) then A4_Weight2:= 1 else A4_Weight2:=0;
       if NowLow < StrToFloat(LowList.Strings[LowList.Count-2]) then A4_Weight3:= 1 else A4_Weight3:=0;
       if NowLow < StrToFloat(LowList.Strings[LowList.Count-1]) then A4_Weight4:= 1 else A4_Weight4:= 0;
       if CloseP < StrToFloat(LowList.Strings[LowList.Count-1]) then A4_Weight5:= 1 else A4_Weight5:= 0;

       if ((A4_Weight1 + A4_Weight2 + A4_Weight3 + A4_Weight4 + A4_Weight5) >= 3) then
        fmChungYi.NormalOrder('Order', 'S', 'A4');
      end
     end else // �L�w�s
     begin
      Temp1:= HighList.Strings[HighList.Count-2];
      Temp2:= HighList.Strings[HighList.Count-1];
      Temp3:= LowList.Strings[LowList.Count-1];

//      if (NowHigh < StrToFloat(HighList.Strings[HighList.Count-2])) and (NowHigh < StrToFloat(HighList.Strings[HighList.Count-1])) and
//         (NowLow < StrToFloat(LowList.Strings[LowList.Count-1])) and SellOK then
      if (NowHigh < StrToFloat(HighList.Strings[HighList.Count-1])) and (CloseP < StrToFloat(LowList.Strings[LowList.Count-1])) and
         (NowLow < StrToFloat(LowList.Strings[LowList.Count-1])) and SellOK then
       fmChungYi.NormalOrder('Balance', 'S', 'A4');
      if (NowLow > StrToFloat(LowList.Strings[LowList.Count-1])) and (CloseP > StrToFloat(HighList.Strings[HighList.Count-1])) and
         (NowHigh > StrToFloat(HighList.Strings[HighList.Count-1])) and BuyOK then
       fmChungYi.NormalOrder('Balance', 'B', 'A4');
     end;
    end;

   end;
end;

procedure ReSetK(U_or_D: String);  // K Ĳ�� Reset, E11 �Ѱ��n��1
begin
 StartOrder:= False;
 if (U_or_D = '1') then
 begin
  UpDown:= '1';
{  if (CloseP < Ave5P) then
  begin
   UpDown:= '-1';
   StartOrder:= True
  end; }
 end else
 begin
  UpDown:= '-1';
{  if (U_or_D = '-1') then
   if (CloseP > Ave5P) then
   begin
    UpDown:= '1';
    StartOrder:= True;
   end;    }
 end;

 if CloseP= Ave5P then StartOrder:= False;

 // E11 �Ѱ��n��1
 if (NowBuySell= 'S' ) then
  if (CloseP <= (LastClose + 5)) then
   LastInventory:= False;

 if (NowBuySell= 'B' ) then
  if (CloseP >= (LastClose - 5)) then
   LastInventory:= False;
end;

//========================================================================================
// ���浦���P�_
procedure RunStrategey(TradePrice, AvePrice: Extended);
var K_Ave: Extended; // K �Υ�����
begin
 // �}�L���I�짡�u
 if not StartOrder then
 begin
  if (UpDown = '1') then
  begin
   if (CloseP < Ave5P) then
    StartOrder:= True
  end else
  if (UpDown = '-1') then
   if (CloseP > Ave5P) then
    StartOrder:= True;
 end;

 // E11 �Ѱ��n��1  //E11 �Ѱ��覡: CloseP <= LastClose �h��Ѥ�������B�@;���ݭn���ܩάO��ϦV��=0.
 if (NowBuySell= 'S' ) then
  if (CloseP <= LastClose) then
   LastInventory:= False;

 if (NowBuySell= 'B' ) then
  if (CloseP >= LastClose) then
   LastInventory:= False;

 // D ����
  if fmChungYi.dbcbD_Open.Checked and not BreakLoop then
  begin
   if (fmChungYi.dbeD6_1.Text <> '') and
     ((sStrategy.D1_Weight + sStrategy.D2_Weight + sStrategy.D3_Weight + sStrategy.D4_Weight + sStrategy.D5_Weight + sStrategy.D6_Weight)
     >= StrToInt(fmChungYi.dbeD6_1.Text)) then
   begin
    Floated:= True;
    sStrategy.D6_1_AntiWeight:= 0;
    sStrategy.D6_1_Weight:= 1;
   end else begin
    Floated:= False;
    sStrategy.D6_1_AntiWeight:= 1;
    sStrategy.D6_1_Weight:= 0;
   end;

   // D7 ���� (�Ѱ��L��)
   if (fmChungYi.dbeD7.Text <> '' ) and
     ((sStrategy.D1_AntiWeight + sStrategy.D5_AntiWeight + sStrategy.D6_1_AntiWeight)
     >= StrToInt(fmChungYi.dbeD7.Text)) then
   begin
    Floated:= False;
    D7_True:= True;
   end;
  end;

 // �Q�Ѯw�s�B�z��~�i�� (�B�ǳ�), �B E3 ��Ĳ�o (E3_Light=1 �d��)
 if (not LastInventory) and (sStrategy.E3_Light= 1) then
 begin
  if (not Floated) and A2Pass and A13_14_Open then // �D�L��L��, �B�T�T�� true, �BA13_14_Open=true
   A4_Module();

  // �}�L���I�짡�u
  if not StartOrder then
  begin
   if (UpDown = '1') then
    if (CloseP < Ave5P + 3) then
     StartOrder:= True;
   if (UpDown = '-1') then
    if (CloseP > Ave5P - 3) then
     StartOrder:= True;
  end else
  if (not Floated) then // �D�L��L��, �B�T�T�� true
  begin
   if (fmChungYi.dbrA1.ItemIndex= 0) and A2Pass then // A3 ���� (�ݩT�w�Ҧ�)
   begin
    if (fmChungYi.dbeA3.Text <> '') and (fmChungYi.dbeA3_1.Text <> '') and (StrToInt(fmChungYi.dbeA3.Text) < AveList.Count) then
    begin
     TempFloat:= (GetTotal(K_CloseList, StrToInt(fmChungYi.dbeA3.Text)-1, 'End')+ CloseP) / StrToInt(fmChungYi.dbeA3.Text);
     K_Ave:= (GetTotal(K_CloseList, StrToInt(fmChungYi.dbeA3.Text)-1, 'End')+ CloseP) / StrToInt(fmChungYi.dbeA3.Text); // ���o�X�� K �Υ�����
     if NowBuySell <> '' then  // ���w�s��
     begin
      if NowBuySell= 'B' then
       if ((K_Ave - CloseP) > StrToInt(fmChungYi.dbeA3_1.Text)) and SellOK then
        fmChungYi.NormalOrder('Order', 'S', 'A3_1');// �ϦV��
      if NowBuySell= 'S' then
       if ((CloseP - K_Ave) > StrToInt(fmChungYi.dbeA3_1.Text)) and BuyOK then
        fmChungYi.NormalOrder('Order', 'B', 'A3_1');// �ϦV��

     end  // �L�w�s��, �Ѽ� = Balance, ��ܤU��q����Ƕq
     else begin
      if ((K_Ave - CloseP) > StrToInt(fmChungYi.dbeA3_1.Text)) and SellOK then
       fmChungYi.NormalOrder('Balance', 'S', 'A3_1');
      if ((CloseP - K_Ave) > StrToInt(fmChungYi.dbeA3_1.Text)) and BuyOK then
       fmChungYi.NormalOrder('Balance', 'B', 'A3_1');
     end;
    end;
   end;

   if (fmChungYi.dbrA1.ItemIndex= 1) and A2Pass then // (�ݯB�ʼҦ�)
   begin
    // A5 ���� (�[�\ A6, A7, A8, A9)
    if (fmChungYi.dbeA5.Text <> '') and (fmChungYi.dbeA5_1.Text <> '') and (StrToInt(fmChungYi.dbeA5.Text) < AveList.Count) then
    begin // ���o�X�� K �Υ�����
     TempFloat:= (GetTotal(K_CloseList, StrToInt(fmChungYi.dbeA5.Text)-1, 'End')+ CloseP) / StrToInt(fmChungYi.dbeA5.Text);
     K_Ave:= (GetTotal(K_CloseList, StrToInt(fmChungYi.dbeA5.Text)-1, 'End')+ CloseP) / StrToInt(fmChungYi.dbeA5.Text);
     if (fmChungYi.dbeA7.Text <> '') and (fmChungYi.dbeA7_1.Text <> '') then
     begin // A6 / A7

      if (fmChungYi.dbcbA6.Text= '�Ϧ�') then
      begin
       if (TradePrice - Last_K) > StrToInt(fmChungYi.dbeA7_1.Text) then
       begin
        FloatOffSet:= (-1)*Trunc((TradePrice - Last_K) / StrToInt(fmChungYi.dbeA7.Text)) * StrToInt(fmChungYi.dbeA7_1.Text);
       end;
       if (Last_K - TradePrice) > StrToInt(fmChungYi.dbeA7_1.Text) then
        FloatOffSet:= Trunc((Last_K - TradePrice) / StrToInt(fmChungYi.dbeA7.Text))* StrToInt(fmChungYi.dbeA7_1.Text);
      end;

      if fmChungYi.dbcbA6.Text= '����' then
      begin
       if (TradePrice - Last_K) > StrToInt(fmChungYi.dbeA7.Text) then
        FloatOffSet:= Trunc((TradePrice - Last_K) / StrToInt(fmChungYi.dbeA7_1.Text))*StrToInt(fmChungYi.dbeA7_1.Text);
       if (Last_K - TradePrice) > StrToInt(fmChungYi.dbeA7.Text) then
        FloatOffSet:= (-1)*Trunc((Last_K - TradePrice) / StrToInt(fmChungYi.dbeA7_1.Text))*StrToInt(fmChungYi.dbeA7_1.Text);
      end;
     end;

     // A8
     if (fmChungYi.dbeA8.Text <> '') and (fmChungYi.dbeA8_1.Text <> '') then
     begin
       if NowBuySell= 'B' then  // buy ���
        if (K_Ave - StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3]))
          > StrToInt(fmChungYi.dbeA8.Text) then  FloatOffSet:= FloatOffSet - StrToInt(fmChungYi.dbeA8_1.Text);
       if NowBuySell= 'S' then  // Sell ���
        if (StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3]) - K_Ave)
          > StrToInt(fmChungYi.dbeA8.Text) then  FloatOffSet:= FloatOffSet + StrToInt(fmChungYi.dbeA8_1.Text);
     end;

     //A9
     if (fmChungYi.dbeA9.Text <> '') and (fmChungYi.dbeA9_1.Text <> '') then
     begin
       if NowBuySell= 'B' then  // buy ���
        if (K_Ave - TradePrice)
          > StrToInt(fmChungYi.dbeA9.Text) then  FloatOffSet:= FloatOffSet + StrToInt(fmChungYi.dbeA9_1.Text);
       if NowBuySell= 'S' then  // Sell ���
        if (TradePrice - K_Ave)
          > StrToInt(fmChungYi.dbeA9.Text) then  FloatOffSet:= FloatOffSet - StrToInt(fmChungYi.dbeA9_1.Text);
     end;

     // A5 �U��
     if NowBuySell <> '' then
     begin
      if (NowBuySell= 'B') and SellOK then
       if (K_Ave - TradePrice) > StrToInt(fmChungYi.dbeA5_1.Text) + FloatOffSet then fmChungYi.NormalOrder('Order', 'S', 'A5_1');// �ϦV��
      if (NowBuySell= 'S') and BuyOK then
       if (TradePrice - K_Ave) > StrToInt(fmChungYi.dbeA5_1.Text) + FloatOffSet then fmChungYi.NormalOrder('Order', 'B', 'A5_1');// �ϦV��
     end else // �L�w�s��, Balance ��
     begin
      if SellOK and ((K_Ave - TradePrice) > (StrToInt(fmChungYi.dbeA5_1.Text) + FloatOffSet)) then fmChungYi.NormalOrder('Balance', 'S', 'A5_1');
      if buyOK and ((TradePrice - K_Ave) > (StrToInt(fmChungYi.dbeA5_1.Text) + FloatOffSet)) then fmChungYi.NormalOrder('Balance', 'B', 'A5_1');
     end;

    // FloatHasAdd:= FloatOffSet; // �w�[�L���I��
    end;
   end;

   // A11  turn �I  (�����w�s)
   if (fmChungYi.dbcbA11_Check.Checked) and (fmChungYi.dbeA11.Text <> '') and not BreakLoop then
   begin
     if NowBuySell= 'B' then
      if (StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3]) - TradePrice)
       > StrToInt(fmChungYi.dbeA11.Text) then
      begin
        fmChungYi.NormalOrder('Order', 'S', 'A11');
        sStrategy.A11_Light:= 1;
      end else sStrategy.A11_Light:= 0;
     if NowBuySell= 'S' then
      if (TradePrice - StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3]))
       > StrToInt(fmChungYi.dbeA11.Text) then
      begin
        fmChungYi.NormalOrder('Order', 'B', 'A11');
        sStrategy.A11_Light:= 1;
      end else sStrategy.A11_Light:= 0;
   end;

   // A13  ���ܩΤϦV��
   if fmChungYi.dbcbA13_Check.Checked and not BreakLoop then
    if (fmChungYi.dbeA13.Text <> '') and (fmChungYi.dbeA13_1.Text <> '') then
    begin
     if NowBuySell <> '' then
     begin
      if A13High < TradePrice then A13High:= TradePrice;
      if A13Low > 0 then
      begin
       if A13Low > TradePrice then A13Low:= TradePrice;
      end else A13Low:= TradePrice;

      if NowBuySell= 'B' then
      begin
       if TradePrice - StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])
         >= StrToInt(fmChungYi.dbeA13.Text) then
       begin
        A13HighReturn:= True;
       end;
       if A13HighReturn and
         (TradePrice < StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3]) + (A13High - StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3]))*(1 - StrToFloat(fmChungYi.dbeA13_1.Text)/100)) then
       begin
           fmChungYi.NormalOrder('Balance', 'S', 'A13');
           A13_14_Open:= False; // ���ܫ�, �קK A4 ���W���^�h
           if CloseP >= Ave5P then ReSetK('1') else ReSetK('-1');

           sStrategy.A13_Light:= 1;
           A13HighReturn:= False;
           A13High:= 0;
       end else sStrategy.A13_Light:= 0;
      end;

      if NowBuySell= 'S' then
      begin
       if StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3]) - TradePrice
         >= StrToInt(fmChungYi.dbeA13.Text) then
       begin
        A13LowReturn:= True;
       end;
       if A13LowReturn and
          (TradePrice > A13Low + (StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3]) - A13Low)*(StrToFloat(fmChungYi.dbeA13_1.Text)/100)) then
       begin
           fmChungYi.NormalOrder('Balance', 'B', 'A13');
           A13_14_Open:= False; // ���ܫ�, �קK A4 ���W���^�h
           if CloseP >= Ave5P then ReSetK('1') else ReSetK('-1');
           sStrategy.A13_Light:= 1;
           A13LowReturn:= False;
           A13Low:= 0;
       end else sStrategy.A13_Light:= 0;
      end;
     end;
    end;

   //A14
   if fmChungYi.dbcbA14_Check.Checked and not BreakLoop then
    if (fmChungYi.dbeA14.Text <> '') then
    begin
     if NowBuySell <> '' then
     begin
      if NowBuySell= 'B' then
       if TradePrice - StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])
         >= StrToInt(fmChungYi.dbeA14.Text) then
       begin
          fmChungYi.NormalOrder('Balance', 'S', 'A14');
          A13_14_Open:= False; // ���ܫ�, �קK A4 ���W���^�h
          if CloseP >= Ave5P then ReSetK('1') else ReSetK('-1');
          sStrategy.A14_Light:= 1;
       end else sStrategy.A14_Light:= 0;
      if NowBuySell= 'S' then
       if StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3]) - TradePrice
         >= StrToInt(fmChungYi.dbeA14.Text) then
       begin
          fmChungYi.NormalOrder('Balance', 'B', 'A14');
          A13_14_Open:= False; // ���ܫ�, �קK A4 ���W���^�h
          if CloseP >= Ave5P then ReSetK('1') else ReSetK('-1');
          sStrategy.A14_Light:= 1;
       end else sStrategy.A14_Light:= 0;
     end;
    end;
  end;

  // B ����
  if fmChungYi.dbcbB_Open.Checked and not BreakLoop then
  begin
   if fmChungYi.dbrgB2or3.ItemIndex= 1 then  // �D���N���C�I
   begin   // 1: B3, 0:B2
    if (fmChungYi.dbeB3.Text <> '') then
     B1_Strategy_Assign();
   end else if fmChungYi.dbrgB2or3.ItemIndex= 0 then
   begin  // ���N���C�I
    if fmChungYi.dbeB2.Text <> '' then
     B1_Strategy_Any();
   end;
  end;

  // C ���� (���w�s�ɤ~�|����)
  if fmChungYi.dbcbC_Open.Checked and not BreakLoop then
   if (sStrategy.C1_Weight + sStrategy.C2_Weight + sStrategy.C3_Weight + sStrategy.C5_Weight) >= StrToInt(fmChungYi.dbeC7.Text) then
   begin
    if NowBuySell <> '' then
    begin
     if NowBuySell = 'B' then fmChungYi.NormalOrder('Order', 'S', 'C')
     else if NowBuySell = 'S' then fmChungYi.NormalOrder('Order', 'B', 'C');
     if CloseP >= Ave5P then ReSetK('1') else ReSetK('-1');
    end;
   end;

{  // D ����
  if fmChungYi.dbcbD_Open.Checked and not BreakLoop then
  begin
   if (fmChungYi.dbeD6_1.Text <> '') and
     ((sStrategy.D1_Weight + sStrategy.D2_Weight + sStrategy.D3_Weight + sStrategy.D4_Weight + sStrategy.D5_Weight + sStrategy.D6_Weight)
     >= StrToInt(fmChungYi.dbeD6_1.Text)) then
   begin
    Floated:= True;
    sStrategy.D6_1_AntiWeight:= 0;
    sStrategy.D6_1_Weight:= 1;
   end else begin
    sStrategy.D6_1_AntiWeight:= 1;
    sStrategy.D6_1_Weight:= 0;
   end;

   // D7 ���� (�Ѱ��L��)
   if (fmChungYi.dbeD7.Text <> '' ) and
     ((sStrategy.D1_AntiWeight + sStrategy.D5_AntiWeight + sStrategy.D6_1_AntiWeight)
     >= StrToInt(fmChungYi.dbeD7.Text)) then
   begin
    Floated:= False;
    D7_True:= True;
   end;
  end;  }
 end;

 if LastInventory then  // ���d��, �|���B�z��
 begin
  if (fmChungYi.ListV_Interest.Items[0].SubItems.strings[1]= 'B') and  // buy ���
     (CloseP < StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])) then
  begin // E7(E4_1)
   if (fmChungYi.dbeE7.Text <> '') then
    if (StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3]) - CloseP) > StrToFloat(fmChungYi.dbeE7.Text) then sStrategy.E4_1_Weight:= 1 else sStrategy.E4_1_Weight:= 0;
   // E4_2
   if TradePrice < LastLow then sStrategy.E4_2_Weight:= 1 else sStrategy.E4_2_Weight:= 0;
   // E8                                                    // �q 8:50:00 �}�l
   if (fmChungYi.dbeE8.Text <> '') and (TickTime > '08:50:00') and ((StrToTime(TickTime)- 53/144)/(1/288) <= StrToInt(fmChungYi.dbeE8.Text)) then
    if CloseP < ThisOpen then sStrategy.E4_3_Weight:= 1 else sStrategy.E4_3_Weight:= 0;
   // E9                                                 // �q 8:50:00 �}�l
   if (fmChungYi.dbeE9.Text <> '') and (TickTime > '08:50:00') and ((StrToTime(TickTime)- 53/144)/(1/288) <= StrToInt(fmChungYi.dbeE9.Text)) then
    if FirstLow > CloseP then
     sStrategy.E4_4_Weight:= 1 else sStrategy.E4_4_Weight:= 0;
   // E11 (LastInventory) �Ѱ��ĤG�n��
   if CloseP >= StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3]) then
    LastInventory:= False;
  end;

  if (fmChungYi.ListV_Interest.Items[0].SubItems.strings[1]= 'S') and  // Sell ���
     (CloseP > StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])) then
  begin // E7(E4_1)
   if (fmChungYi.dbeE7.Text <> '') then
    if (CloseP - StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3])) > StrToFloat(fmChungYi.dbeE7.Text) then sStrategy.E4_1_Weight:= 1 else sStrategy.E4_1_Weight:= 0;
   // E4_2
   if TradePrice > LastHigh then sStrategy.E4_2_Weight:= 1 else sStrategy.E4_2_Weight:= 0;
   // E8
   if (fmChungYi.dbeE8.Text <> '') and ((StrToTime(TickTime)- 53/144)/(1/288) <= StrToInt(fmChungYi.dbeE8.Text)) then
    if CloseP > ThisOpen then sStrategy.E4_3_Weight:= 1 else sStrategy.E4_3_Weight:= 0;
   // E9
   if (fmChungYi.dbeE9.Text <> '') and ((StrToTime(TickTime)- 53/144)/(1/288) <= StrToInt(fmChungYi.dbeE8.Text)) then
    if FirstHigh < CloseP then
     sStrategy.E4_4_Weight:= 1 else sStrategy.E4_4_Weight:= 0;
   // E11 (LastInventory) �Ѱ��ĤG�n��
   if CloseP <= StrToFloat(fmChungYi.ListV_Interest.Items[0].SubItems.strings[3]) then
    LastInventory:= False;
  end;

  // E11 ����
  if (fmChungYi.dbeE11.Text <> '') then
   if (sStrategy.E4_1_Weight + sStrategy.E4_2_Weight + sStrategy.E4_3_Weight + sStrategy.E4_4_Weight)
     >= StrToInt(fmChungYi.dbeE11.Text) then
   begin
    sStrategy.E11_Light:= 1;
    if NowBuySell <> '' then
    begin
     if NowBuySell = 'B' then fmChungYi.NormalOrder('Balance', 'S', 'E11')
     else if NowBuySell = 'S' then fmChungYi.NormalOrder('Balance', 'B', 'E11');
     if CloseP >= Ave5P then ReSetK('1') else ReSetK('-1');
    end;
   end else sStrategy.E11_Light:= 0;

 end;
 BreakLoop:= False; // ��Ӭy�{������, �U������]�� False
end;

// C1 ������Ĳ�o���� (C ����, ���t�U��)
procedure Trigger_C_Strategy(TradePrice, NowHigh, NowLow: Extended);
begin
 if (fmChungYi.dbeC1_1.Text <> '') then
 begin
  if NowBuySell= 'B' then
   if (CloseP - Ave5P) >= StrToInt(fmChungYi.dbeC1_1.Text) then
   begin
    sStrategy.BreakPoint:= True;
    sStrategy.C1_Weight:= 1;
   end else begin
    sStrategy.BreakPoint:= False;
    sStrategy.C1_Weight:= 0;
   end;

  if NowBuySell= 'S' then
   if (Ave5P - CloseP) >= StrToInt(fmChungYi.dbeC1_1.Text) then
   begin
    sStrategy.BreakPoint:= True;
    sStrategy.C1_Weight:= 1;
   end else begin
    sStrategy.BreakPoint:= False;
    sStrategy.C1_Weight:= 0;
   end;
 end;

 if not sStrategy.BreakPoint and (NowBuySell<> '') then // �p�G�e������, �h���ݦA����U�� (�]�������u�ݤ@���ߧY�i)
  if ((fmChungYi.dbeC1.Text <> '') and (NowHigh - NowLow > StrToInt(fmChungYi.dbeC1.Text))) then
  begin
   sStrategy.BreakPoint:= True;
   sStrategy.C1_Weight:= 1;
  end else begin
   sStrategy.BreakPoint:= False;
   sStrategy.C1_Weight:= 0;
  end;
end;

 // C ����
procedure Trigger_C2_Strategy(TradePrice, NowHigh, NowLow, AvePrice: Extended);
begin
  // C2 �����q�̰���
 if (NowHigh - NowLow) > sStrategy.Diff_C2 then sStrategy.Diff_C2:= NowHigh - NowLow;

 if fmChungYi.dbcbC_Open.Checked then
 begin
  if sStrategy.BreakPoint then
  begin // C2 ����
   if NowBuySell <> '' then  // �L�w�s���Ҽ{
   begin
    if fmChungYi.dbeC2.Text <> '' then
    begin
     if NowBuySell= 'B' then
      if (NowHigh - TradePrice) > sStrategy.Diff_C2 * StrToInt(fmChungYi.dbeC2.Text)/100 then
       sStrategy.C2_Weight:= 1 else sStrategy.C2_Weight:= 0;
     if NowBuySell= 'S' then
      if (TradePrice - NowLow) > sStrategy.Diff_C2 * StrToInt(fmChungYi.dbeC2.Text)/100 then
       sStrategy.C2_Weight:= 1 else sStrategy.C2_Weight:= 0;
    end;

    if fmChungYi.dbeC3.Text <> '' then
    begin  // C3 ������ (70%�W�U��Ƥ��)
     if NowBuySell= 'B' then
      if (NowHigh - TradePrice) < sStrategy.Diff_C2 * StrToInt(fmChungYi.dbeC3.Text)/100 then
      begin
       sStrategy.C3_Out_Start:= True;
       sStrategy.C3_In_Start:= False;
      end else begin
       sStrategy.C3_In_Start:= True;
       sStrategy.C3_Out_Start:= False;
      end;

     if NowBuySell= 'S' then
      if (TradePrice - NowLow) < sStrategy.Diff_C2 * StrToInt(fmChungYi.dbeC3.Text)/100 then
      begin
       sStrategy.C3_In_Start:= True;
       sStrategy.C3_Out_Start:= False;
      end else begin
       sStrategy.C3_Out_Start:= True;
       sStrategy.C3_In_Start:= False;
      end;
    end;

   // C4 ������ (�X��H��)
    if fmChungYi.dbeC4.Text <> '' then
    if StrToInt(fmChungYi.dbeC4.Text) >=( 300 - sStrategy.C4_Count) then
    begin
     if NowBuySell= 'B' then
      if sStrategy.C4_High > NowHigh then
      begin
       sStrategy.C4_LastHigh:= sStrategy.C4_High;
       sStrategy.C4_Weight:= 1;
       sStrategy.C4_Count:= 0;
      end;

     if NowBuySell= 'S' then
      if sStrategy.C4_Low < NowLow then
      begin
       sStrategy.C4_LastHigh:= sStrategy.C4_Low;
       sStrategy.C4_Weight:= 1;
       sStrategy.C4_Count:= 0;
      end;
    end;

    // C5 ������
    if fmChungYi.dbeC5.Text <> '' then
    begin
     // C5 �����q�̰��C��
     if (NowHigh - Ave5P) > sStrategy.Diff_C5H then sStrategy.Diff_C5H:= NowHigh - Ave5P;
     if (Ave5P - NowLow) > sStrategy.Diff_C5H then sStrategy.Diff_C5L:= Ave5P - NowLow;

     if NowBuySell= 'B' then
      if ((TradePrice - Ave5P) < sStrategy.Diff_C5H * StrToInt(fmChungYi.dbeC5.Text)/100) and (sStrategy.UpDown= 'Down') then
       sStrategy.C5_Weight:= 1 else sStrategy.C5_Weight:= 0;
     if NowBuySell= 'S' then
      if ((Ave5P - NowLow) < sStrategy.Diff_C5L * StrToInt(fmChungYi.dbeC5.Text)/100) and (sStrategy.UpDown= 'Up') then
       sStrategy.C5_Weight:= 1 else sStrategy.C5_Weight:= 0;

    end;
   end; // �L�w�s���Ҽ{
  end else begin // �u�^ 70%�H�W��, ���� C �񭫥������p
   sStrategy.C1_Weight:= 0;
   sStrategy.C2_Weight:= 0;
   sStrategy.C3_Weight:= 0;
   sStrategy.C4_Weight:= 0;
   sStrategy.C5_Weight:= 0;
  end;
 end;
end;

// D ����
procedure Trigger_D1_Strategy(AvePrice, Ave10, Ave20, TradePrice: Extended);
begin
 // D1
 if (fmChungYi.dbeD1_1.Text <> '') and (sStrategy.D1_K_Ave_High > 0) then
 begin
  if sStrategy.D1_K_Ave_High < Ave5P then sStrategy.D1_K_Ave_High:= Ave5P;
  if sStrategy.D1_K_Ave_Low > Ave5P then sStrategy.D1_K_Ave_Low:= Ave5P;

  if sStrategy.D1_K_Ave_High - sStrategy.D1_K_Ave_Low < StrToInt(fmChungYi.dbeD1_1.Text) then
  begin
   sStrategy.D1_Weight:= 1;
   sStrategy.D1_AntiWeight:= 0;
  end else begin
   sStrategy.D1_Weight:= 0;
   sStrategy.D1_AntiWeight:= 1;
  end;
 end;

 // D2  (���������)
 if fmChungYi.dbeD2.Text <> '' then
 if (abs(Ave5P - Ave10) < StrToInt(fmChungYi.dbeD2.Text)) and
    (abs(Ave5P - Ave20) < StrToInt(fmChungYi.dbeD2.Text)) and
    (abs(Ave10 - Ave20) < StrToInt(fmChungYi.dbeD2.Text)) then
  sStrategy.D2_Weight:= 1 else sStrategy.D2_Weight:= 0;
 // D3
 if (fmChungYi.dbeD3.Text <> '') and (fmChungYi.dbeD3_1.Text <> '')
  and (SQLList.Count >= StrToInt(fmChungYi.dbeD3.Text)) then
 begin
  if sStrategy.D3_K_High < CloseP then sStrategy.D3_K_High:= CloseP;
  if sStrategy.D3_K_Low > CloseP then sStrategy.D3_K_Low := CloseP;

  if (sStrategy.D3_K_High - sStrategy.D3_K_Low) < StrToInt(fmChungYi.dbeD3_1.Text) then
   sStrategy.D3_Weight:= 1 else sStrategy.D3_Weight:= 0;
 end;
 // D4
 if (fmChungYi.dbeD4.Text <> '') and (fmChungYi.dbeD4_1.Text <> '')
  and (SQLList.Count >= StrToInt(fmChungYi.dbeD4.Text)) then
 begin
  if (((sStrategy.D4_K_High + sStrategy.D4_K_Low)/2 - StrToInt(fmChungYi.dbeD4_1.Text)) <
     CloseP) and
     (((sStrategy.D4_K_High + sStrategy.D4_K_Low)/2 + StrToInt(fmChungYi.dbeD4_1.Text)) >
     CloseP) then
   sStrategy.D4_Weight:= 1
   else sStrategy.D4_Weight:= 0;
 end;
 // D5
 if (fmChungYi.dbeD5.Text <> '') then
  if (NowLow > sStrategy.D5_K_Low) and (NowHigh < sStrategy.D5_K_High) then
  begin
   sStrategy.D5_Weight:= 1;
   sStrategy.D5_AntiWeight:= 0;
  end else begin
   sStrategy.D5_Weight:= 0;
   sStrategy.D5_AntiWeight:= 1;
  end;
 // D6
 if (fmChungYi.dbeD6.Text <> '') then
  if (sStrategy.D6_Total_Qty / StrToInt(fmChungYi.dbeD6.Text)) > MinuteQty then
   sStrategy.D6_Weight:= 1 else sStrategy.D6_Weight:= 0;
end;

// E ���� (�P�w�O�_�d��)
procedure Trigger_E_Strategy();
var E1_4G, E1_4R: Integer;
    E1_1U, E1_1D: Integer;
    I: Integer;
    R_Qty, G_Qty: Integer;
begin
{ // E1_1 ����l�q
 if fmChungYi.dbeE1.Text <> '' then
 begin
  sStrategy.E_Profit:= GetBalance();
  if sStrategy.E_Profit >= StrToInt(fmChungYi.dbeE1.Text) then sStrategy.E1_1_Weight:= 1 else sStrategy.E1_1_Weight:= 0;
 end; }

 //E1_2
 if fmChungYi.cbOpen2.Checked then
 begin
  if NowBuySell= 'B' then
  begin
   sStrategy.E1_2_Weight:= 0;
   if (LastOpen < LastClose) and (ThisOpen < CloseP) then sStrategy.E1_2_Weight:= 1;
   if (LastOpen > LastClose) and (ThisOpen > CloseP) then sStrategy.E1_2_Weight:= 1;
  end;

  if NowBuySell= 'S' then
  begin
   sStrategy.E1_2_Weight:= 0;
   if (LastOpen < LastClose) and (ThisOpen > CloseP) then sStrategy.E1_2_Weight:= 1;
   if (LastOpen > LastClose) and (ThisOpen < CloseP) then sStrategy.E1_2_Weight:= 1;
  end;
 end;

 // E1_1 U/D �ƶq���
 if (fmChungYi.dbeE1.Text <> '') and (fmChungYi.cbOpen1.Checked) then
 begin
  DataModule1.asqQU_Temp.Close;
  DataModule1.asqQU_Temp.SQL.Text:= 'select count(NextUpDown) as UQty from ' +
    ' (select * from Figure order by sn desc limit ' + IntToStr(StrToInt(fmChungYi.dbeE1.Text) + 1) + ') where NextUpDown="U"';
  DataModule1.asqQU_Temp.Open;
  E1_1U:= StrToInt(DataModule1.asqQU_Temp.FieldByName('UQty').Text);

  DataModule1.asqQU_Temp.Close;
  DataModule1.asqQU_Temp.SQL.Text:= 'select count(NextUpDown) as DQty from ' +
    ' (select * from Figure order by sn desc limit ' + IntToStr(StrToInt(fmChungYi.dbeE1.Text) + 1) + ') where NextUpDown="D"';
  DataModule1.asqQU_Temp.Open;
  E1_1D:= StrToInt(DataModule1.asqQU_Temp.FieldByName('DQty').Text);

  if E1_1U = E1_1D then
   sStrategy.E1_1_Weight:= sStrategy.E1_2_Weight
  else
  begin
   if NowBuySell= 'B' then
    if E1_1U < E1_1D then
     sStrategy.E1_1_Weight:= 1;

   if NowBuySell= 'S' then
    if E1_1U > E1_1D then
     sStrategy.E1_1_Weight:= 1;
  end;
 end;

  // E1_4
  if (fmChungYi.cbOpen4.Checked) then
  begin
   SQLList.SaveToFile('IndexTable_' + fmQuote.cbbStockNO.Text + '.Txt');
   fmQuote.SaveIndexTable(); // �s�J IndexTable
   sStrategy.E_1_4G:= 0;
   sStrategy.E_1_4R:= 0;
   R_Qty:= 0;
   G_Qty:= 0;

   DataModule1.asqQU_Temp.SQL.Text:= 'select Red, TradeQty from IndexTable where TradeDate="' + DateToStr(fmQuote.dtpDate.Date)
    + '" order by TradeQty desc limit 4';
   DataModule1.asqQU_Temp.Open;

   DataModule1.asqQU_Temp.First;
   for I := 1 to 4 do
   begin
    if DataModule1.asqQU_Temp.FieldByName('Red').Text= 'R' then
    begin
     sStrategy.E_1_4R:= sStrategy.E_1_4R + 1;
     R_Qty:= R_Qty + DataModule1.asqQU_Temp.FieldByName('TradeQty').AsInteger;
    end else if DataModule1.asqQU_Temp.FieldByName('Red').Text= 'G' then
    begin
     sStrategy.E_1_4G:= sStrategy.E_1_4G + 1;
     G_Qty:= G_Qty + DataModule1.asqQU_Temp.FieldByName('TradeQty').AsInteger;
    end;
    DataModule1.asqQU_Temp.Next;
   end;


   if MinuteQty > (G_Qty + R_Qty)/4 then
   begin
    if (CloseP > OpenP) then sStrategy.E_1_4R:= sStrategy.E_1_4R + 1
    else if (CloseP < OpenP) then sStrategy.E_1_4G:= sStrategy.E_1_4G + 1;
   end;

   sStrategy.E1_4_Weight:= 0;
   if NowBuySell <> '' then
   begin
    if (NowBuySell= 'B') and (G_Qty < R_Qty) then
     sStrategy.E1_4_Weight:= 1;
    if (NowBuySell= 'S') and (G_Qty > R_Qty) then
     sStrategy.E1_4_Weight:= 1;
   end;
  end;

 // E1_5
  if (fmChungYi.cbOpen5.Checked) then
  begin
   if CloseP > OpenP then sStrategy.E_1_5R:= sStrategy.E_1_5R + MinuteQty;
   if CloseP < OpenP then sStrategy.E_1_5G:= sStrategy.E_1_5G + MinuteQty;

   sStrategy.E1_5_Weight:= 0;
   if NowBuySell <> '' then
   begin
    if (NowBuySell= 'B') and (sStrategy.E_1_5G < sStrategy.E_1_5R) then
     sStrategy.E1_5_Weight:= 1;
    if (NowBuySell= 'S') and (sStrategy.E_1_5G > sStrategy.E_1_5R) then
     sStrategy.E1_5_Weight:= 1;
   end;
  end;

  // E3 ���d�� =0
  if (fmChungYi.dbeE3.Text <> '') and  // (fmChungYi.cbOpen3.Checked) and
     ((sStrategy.E1_1_Weight + sStrategy.E1_2_Weight + sStrategy.E1_3_Weight + sStrategy.E1_4_Weight + sStrategy.E1_5_Weight)
    < StrToInt(fmChungYi.dbeE3.Text)) then
  begin
   sStrategy.E3_Light:= 0;
   fmChungYi.cbAutoBalance.Checked:= False;

   // E5 ���� (��ϦV�d��)
   if fmChungYi.dbcbE5.Checked= True then
   begin
    if NowBuySell = 'B' then fmChungYi.NormalOrder('Order', 'S', 'E5')
    else if NowBuySell = 'S' then fmChungYi.NormalOrder('Order', 'B', 'E5');
    // E5 �P E3 �ۤ�, E3=0, E5 �G�O
    if sStrategy.E3_Light= 0 then fmChungYi.Label34.Font.Color:= clRed else fmChungYi.Label34.Font.Color:=clWindowText;

   end else
   begin //(����)
    if NowBuySell = 'B' then fmChungYi.NormalOrder('Balance', 'S', 'E5')
    else if NowBuySell = 'S' then fmChungYi.NormalOrder('Balance', 'B', 'E5');
   end;
  end else sStrategy.E3_Light:= 1;

  if sStrategy.E3_Light= 1 then fmChungYi.Label33.Font.Color:= clRed else fmChungYi.Label33.Font.Color:=clWindowText;
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

// �ϧΧP�_ E1_3
procedure LastPhase();
var DownQty, upQty: Integer;
    IsTestMode: String;
begin
  DownQty:= 0;
  upQty:= 0;
  DataModule1.asqQU_Temp.SQL.Text:= 'delete from Figure where TradeDate="' + DateToStr(fmQuote.dtpDate.Date) + '"';
  DataModule1.asqQU_Temp.Open;

 // �g�J���骺�ϧΰO��
   if(DB_Handle.CheckTestMode) then
     IsTestMode:= '1'
   else IsTestMode:= '0';

   DataModule1.asqQU_Figure.SQL.Text:= 'insert into Figure values("' + IntToStr(FigureSN + 1) + '","'
     + fmQuote.cbbStockNO.Text + '","' + DateToStr(fmQuote.dtpDate.Date) + '","'
     + FloatToStr(LastClose) +'","' + FloatToStr(ThisOpen) + '","' + FigureStr + '","", "' + IsTestMode + '")';
   DataModule1.asqQU_Figure.Open;

   // �PŪ�U�@�骺�Ͷ�
   sStrategy.E1_3_Weight:= 0;
   if fmChungYi.cbOpen3.Checked then
   begin
    DataModule1.asqQU_Temp.SQL.Text:= 'select NextUpDown, count(*) as Qty from Figure where P_span="' + FigureStr + '" and NextUpDown="U"';
    DataModule1.asqQU_Temp.Open;
    if DataModule1.asqQU_Temp.FieldByName('Qty').Text<> '0' then
     UpQty:= DataModule1.asqQU_Temp.FieldByName('Qty').AsInteger;

    DataModule1.asqQU_Temp.SQL.Text:= 'select NextUpDown, count(*) as Qty from Figure where P_span="' + FigureStr + '" and NextUpDown="D"';
    DataModule1.asqQU_Temp.Open;
    if DataModule1.asqQU_Temp.FieldByName('Qty').Text<> '0' then
     DownQty:= DataModule1.asqQU_Temp.FieldByName('Qty').AsInteger;

    if NowBuySell <> '' then
    begin
     if (NowBuySell= 'B') and (DownQty < UpQty) then
      sStrategy.E1_3_Weight:= 1;
     if (NowBuySell= 'S') and (DownQty > UpQty) then
      sStrategy.E1_3_Weight:= 1;
    end;
   end;

   DataModule1.asqQU_Figure.SQL.Text:= 'select * from Figure ';
   DataModule1.asqQU_Figure.Open;
end;

procedure WeightLight(); // �C��Ĳ�o
begin
 if A2Pass then
  if fmChungYi.dbckA2_3.Checked and (SellOK or BuyOK) then
   fmChungYi.Label10.Font.Color:= clRed else fmChungYi.Label10.Font.Color:=clWindowText;

 if sStrategy.C1_Weight= 1 then fmChungYi.Label18.Font.Color:= clRed else fmChungYi.Label18.Font.Color:=clWindowText;
 if sStrategy.C2_Weight= 1 then fmChungYi.Label20.Font.Color:= clRed else fmChungYi.Label20.Font.Color:=clWindowText;
 if sStrategy.C3_Weight= 1 then fmChungYi.Label21.Font.Color:= clRed else fmChungYi.Label21.Font.Color:=clWindowText;
 if sStrategy.C4_Weight= 1 then fmChungYi.Label22.Font.Color:= clRed else fmChungYi.Label22.Font.Color:=clWindowText;
 if sStrategy.C5_Weight= 1 then fmChungYi.Label23.Font.Color:= clRed else fmChungYi.Label23.Font.Color:=clWindowText;

 if sStrategy.D1_Weight= 1 then fmChungYi.Label25.Font.Color:= clFuchsia else fmChungYi.Label25.Font.Color:=clWindowText;
 if sStrategy.D2_Weight= 1 then fmChungYi.Label26.Font.Color:= clRed else fmChungYi.Label26.Font.Color:=clWindowText;
 if sStrategy.D3_Weight= 1 then fmChungYi.Label27.Font.Color:= clRed else fmChungYi.Label27.Font.Color:=clWindowText;
 if sStrategy.D4_Weight= 1 then fmChungYi.Label28.Font.Color:= clRed else fmChungYi.Label28.Font.Color:=clWindowText;
 if sStrategy.D5_Weight= 1 then fmChungYi.Label12.Font.Color:= clFuchsia else fmChungYi.Label12.Font.Color:=clWindowText;
 if sStrategy.D6_Weight= 1 then fmChungYi.Label29.Font.Color:= clRed else fmChungYi.Label29.Font.Color:=clWindowText;
 if sStrategy.D6_1_Weight= 1 then fmChungYi.Label7.Font.Color:= clFuchsia else fmChungYi.Label7.Font.Color:=clWindowText;
 if sStrategy.D6_1_AntiWeight= 1 then fmChungYi.Label30.Font.Color:= clBlue else fmChungYi.Label30.Font.Color:=clWindowText;

 if sStrategy.E1_1_Weight= 1 then fmChungYi.Label32.Font.Color:= clRed else fmChungYi.Label32.Font.Color:=clWindowText;
  // �b�U�I�PŪ
 // if sStrategy.E3_Light= 1 then fmChungYi.Label33.Font.Color:= clRed else fmChungYi.Label33.Font.Color:=clWindowText;
 if sStrategy.E4_1_Weight= 1 then fmChungYi.Label35.Font.Color:= clRed else fmChungYi.Label35.Font.Color:=clWindowText;
 if sStrategy.E4_2_Weight= 1 then fmChungYi.Label31.Font.Color:= clRed else fmChungYi.Label31.Font.Color:=clWindowText;
 if sStrategy.E4_3_Weight= 1 then fmChungYi.Label36.Font.Color:= clRed else fmChungYi.Label36.Font.Color:=clWindowText;
 if sStrategy.E4_4_Weight= 1 then fmChungYi.Label37.Font.Color:= clRed else fmChungYi.Label37.Font.Color:=clWindowText;
 if sStrategy.E11_Light= 1 then fmChungYi.Label38.Font.Color:= clRed else fmChungYi.Label38.Font.Color:=clWindowText;
 // �d�ܧPŪ
 if sStrategy.E1_2_Weight= 1 then fmChungYi.Label50.Font.Color:= clRed else fmChungYi.Label50.Font.Color:=clWindowText;
 if sStrategy.E1_3_Weight= 1 then fmChungYi.Label51.Font.Color:= clRed else fmChungYi.Label51.Font.Color:=clWindowText;
 if sStrategy.E1_4_Weight= 1 then fmChungYi.Label52.Font.Color:= clRed else fmChungYi.Label52.Font.Color:=clWindowText;
 if sStrategy.E1_5_Weight= 1 then fmChungYi.Label53.Font.Color:= clRed else fmChungYi.Label53.Font.Color:=clWindowText;

 if sStrategy.B2_Light= 1 then fmChungYi.dbrgB2or3.Font.Color:= clRed else fmChungYi.dbrgB2or3.Font.Color:=clWindowText;
 if sStrategy.A2_1_Light= 1 then fmChungYi.Label8.Font.Color:= clRed else fmChungYi.Label8.Font.Color:=clWindowText;
 if not A4TimePass then fmChungYi.Label4.Font.Color:= clRed else fmChungYi.Label4.Font.Color:=clWindowText;
 if A4_2Float then fmChungYi.dbrgA4_2or3.Color:= clRed else fmChungYi.dbrgA4_2or3.Color:=clBtnFace;
 if A4_3Floated then fmChungYi.dbrgA4_2or3.Font.Color:= clRed else fmChungYi.dbrgA4_2or3.Font.Color:=clWindowText;

 if sStrategy.A11_Light= 1 then fmChungYi.Label13.Font.Color:= clRed else fmChungYi.Label13.Font.Color:=clWindowText;
 if sStrategy.A13_Light= 1 then fmChungYi.Label43.Font.Color:= clRed else fmChungYi.Label43.Font.Color:=clWindowText;
 if sStrategy.A14_Light= 1 then fmChungYi.Label44.Font.Color:= clRed else fmChungYi.Label44.Font.Color:=clWindowText;

 if (fmChungYi.dbckA2_5.Checked) then
 begin
  if BuyOK then
   fmChungYi.Label45.Font.Color:= clRed else fmChungYi.Label45.Font.Color:=clGreen;
// if SellOK then
//   fmChungYi.Label45.Font.Color:= clGreen else fmChungYi.Label45.Font.Color:=clWindowText;
 end;

 if A2Pass then
 begin
  if fmChungYi.dbckA2_1.Checked then fmChungYi.Label8.Font.Color:= clRed else fmChungYi.Label8.Font.Color:=clWindowText;
 end;
end;

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
end.
