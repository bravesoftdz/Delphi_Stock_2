unit DataDownLoad;

interface

procedure GetOriginalData();
procedure DrawLastDate();

implementation

uses Quote, Quote_uSKQ, Public_Variant, SysUtils, Math, GeneralFunction, Strategy,
     ChungYi_Main, StringList_Fun, DMRecord, Graphics;

procedure GetOriginalData();
var LastTicktime: String;
  I: Integer;
  RedGreen: String;
  SQLStr, AllSQL: String;
  Time20: String;
begin
  fmQuote.ClearNowData();

  // �����ثe�w�U�����
  SubAllList.Text:= AllSQLList.Strings[0];
  SubAllList.Delimiter:= ',';
  SubAllList.DelimitedText:= SubAllList.Text;
  if SubAllList.Strings[2]= ThisTradeDate then
  begin
   for I:= 0 to AllSQLList.Count - 1 do
   begin
    SubAllList.Text:= AllSQLList.Strings[I];
    SubAllList.Delimiter:= ',';
    SubAllList.DelimitedText:= SubAllList.Text;
    TickTime:= SubAllList.Strings[3];

      // �C����
      if Copy(FormatDateTime('hh:mm:ss', CurrMin), 1, 5) <> Copy(TickTime, 1, 5) then
      begin
       CurrMin:= StrTotime(TickTime);  // ��s�ɶ�






       // 5 ����  (�Ĥ@���k�X���ɶ����U��)
       if ((Copy(TickTime, 5, 1)= '5') or (Copy(TickTime, 5, 1)= '0')) and (TickTime <> '08:45:00') then
       begin
        AddStrTrue:= True;
        Curr5Min:= CurrMin;
       end;
       // �P�w�O�_�d��  13:44:00 ----> 0.5722222222
       if ((CurrMin - 0.5722222222)> 0) and ((CurrMin - 0.5722222222)< 1/8640) and LastTime then
       begin
        LastPhase();  // E1_3 �ϧ��Ͷ�
        Strategy.Trigger_E_Strategy();  // E1_1, E1_2, E1_4, E1_5
        LastTime:= False;
       end;
      end;

      if AddStrTrue and (CloseP > 0) then
  //    if AddStrTrue and (TickTime <> '08:45:00') then
      begin
       A13_14_Open:= True;
       if sStrategy.C3_Out_Count > sStrategy.C3_In_Count then sStrategy.C3_Weight:= 1;
       // �O��K��
       K_List.Add(FloatToStr(CloseP - OpenP));
       Last_K:= CloseP - OpenP;

       // A3: �O��K�Χ���
       AveList.Add(FloatToStr(Ave5P));
       // D1: ���o�X�� K �νd�򤺪��̰� / �̧C����
       if (fmChungYi.dbeD1.Text <> '') then
       begin
        sStrategy.D1_K_Ave_High:= GetMax(AveList, StrToInt(fmChungYi.dbeD1.Text), 'End');
        sStrategy.D1_K_Ave_Low:= GetMin(AveList, StrToInt(fmChungYi.dbeD1.Text), 'End');
       end;

       // D3: ���o�X�� K �νd�򤺪��̰� / �̧C�����
       HighList.Add(FloatToStr(NowHigh));
       LowList.Add(FloatToStr(NowLow));

       if fmChungYi.dbeD3.Text <> '' then
       begin
        sStrategy.D3_K_High:= GetMax(HighList, StrToInt(fmChungYi.dbeD3.Text), 'End');
        sStrategy.D3_K_Low:= GetMin(LowList, StrToInt(fmChungYi.dbeD3.Text), 'End');
       end;

       // D4: ���o�X�� K �νd�򤺪��̰� / �̧C�����
       if fmChungYi.dbeD4.Text <> '' then
       begin
        sStrategy.D4_K_High:= GetMax(HighList, StrToInt(fmChungYi.dbeD4.Text), 'End');
        sStrategy.D4_K_Low:= GetMin(LowList, StrToInt(fmChungYi.dbeD4.Text), 'End');
       end;

       // A4-3: ���o�X�� K �νd�򤺪��̰� / �̧C�����
       if fmChungYi.dbeA4_3_1.Text <> '' then
       begin
        sStrategy.A4_3_High:= GetMax(HighList, StrToInt(fmChungYi.dbeA4_3_1.Text), 'End');
        sStrategy.A4_3_Low:= GetMin(LowList, StrToInt(fmChungYi.dbeA4_3_1.Text), 'End');
       end;

       // D5: ���o�X�� K �νd�򤺪��̰� / �̧C�����
       if fmChungYi.dbeD5.Text <> '' then
       begin
        sStrategy.D5_K_High:= GetMax(HighList, StrToInt(fmChungYi.dbeD5.Text), 'End');
        sStrategy.D5_K_Low:= GetMin(LowList, StrToInt(fmChungYi.dbeD5.Text), 'End');
       end;

       //D6 ���o�X�� K �νd�򤺪�����q, D6, D6A: �������X�ڦ���q
       MinuteQtyList.Add(FloatToStr(MinuteQty));
       if fmChungYi.dbeD6.Text <> '' then
        sStrategy.D6_Total_Qty:= GetTotal(MinuteQtyList, StrToInt(fmChungYi.dbeD6.Text), 'End');


       K_OpenList.Add(FloatToStr(OpenP));
       K_CloseList.Add(FloatToStr(CloseP));

       // A4_1 Time ����
       if (fmChungYi.dbcbA4_1Check.Checked) and (fmChungYi.dbeA4_2_2.Text <> '') then
        A4_1TimeGate:= StrToTime(TickTime) + StrToInt(fmChungYi.dbeA4_2_2.Text)/86400;

       // ���o���u�e 4, 9, 19 �[�`�� (�� CloseP List �[�J��A�[, ���U�@��)
       DataModule1.GetAve();

       AddStrTrue:= False;
       if CloseP > OpenP then
       begin
        RedGreen:= 'R'; // ����
        sStrategy.E_1_5R:= sStrategy.E_1_5R + MinuteQty;
       end else
       if CloseP < OpenP then
       begin
        RedGreen:= 'G';  // ���
        sStrategy.E_1_5G:= sStrategy.E_1_5G + MinuteQty;
       end else RedGreen:= 'E';   // �Ǵ�

       SQLStr:= SubAllList.Strings[1] + ',' + DateToStr(fmQuote.dtpDate.Date) + ',' + FormatDateTime('hh:mm:ss', CurrMin) + ','
        + FloatToStr(OpenP) + ',' + FloatToStr(NowHigh) + ',' + FloatToStr(NowLow) + ','
        + FloatToStr(CloseP) + ',' + IntToStr(MinuteQty) + ',' + FloatToStr(Ave5P) + ',' + RedGreen;
       LastIndexSN:= LastIndexSN + 1;
       SQLList.Add(IntToStr(LastIndexSN) + ',' + SQLStr);

       if TickTime < '08:50:10' then // �Ĥ@��K�ΰ��C�I
       begin
        FirstLow:= NowLow;
        FirstHigh:= NowHigh;
       end;
       ThisLastHigh:= NowHigh;
       ThisLastLow:= NowLow;
       ThisLastOpen:= OpenP;

       fmQuote.MinuteK_Line();
       // �C���p������u�����I��, �Ѽ��k 0

       NowSecond:= 0;
       sStrategy.C1_Weight:= 0;
       sStrategy.C2_Weight:= 0;
       sStrategy.C3_Weight:= 0;
       sStrategy.C5_Weight:= 0;
       sStrategy.C3_In_Count:= 0;
       sStrategy.C3_Out_Count:= 0;
       sStrategy.C4_Count:= 0;
       sStrategy.D1_Ave_High:= 0;
       sStrategy.D1_Ave_Low:= 0;
       MinuteQty:= 0;
       NowHigh:= 0;
       NowLow:= 0;
       CloseP:= 0;
      end;
   //======================================================================================






















      // �����C�@������s
      if CloseP= 0 then OpenP:= StrToFloat(SubAllList.Strings[6]); // ����� (�Y�}�L��)
      CloseP:= StrToFloat(SubAllList.Strings[6]); // ����� (�Y���L��)
      MinuteQty:= MinuteQty + StrToInt(SubAllList.Strings[7]); // �C�����ֿn����q

      Ave5P:= Round((Ave5P_4Total + CloseP) / 5);
      Ave10P:= Round((Ave10P_4Total + CloseP) / 10);
      Ave20P:= Round((Ave20P_4Total + CloseP) / 20);

      if UpDown = '' then  // �P�_K�η��b���u�W or�U��
      begin
       if (CloseP >= Ave5P) then UpDown:= '1'
       else if (CloseP < Ave5P) then UpDown:= '-1';
      end;



      if NowHigh < CloseP then
      begin
       NowHigh:= CloseP;
       HourHigh:= NowHigh;
       HourHTime:= TickTime;
      end;

      if NowLow = 0 then NowLow:= CloseP
      else if NowLow > CloseP then
           begin
            NowLow:= CloseP;
            HourLow:= NowLow;
            HourLTime:= TickTime;
           end;

      // �̰�/�C������
      if sStrategy.D1_Ave_High < Ave5P then sStrategy.D1_Ave_High:= Ave5P;
      if sStrategy.D1_Ave_Low = 0 then sStrategy.D1_Ave_Low:= Ave5P
      else if sStrategy.D1_Ave_Low > Ave5P then sStrategy.D1_Ave_Low:= Ave5P;



      //A2_1 ���o�X�� K �νd�򤺪�����q
      if TickTime='08:49:59' then
       temp:='';
      if (fmChungYi.dbckA2_1.Checked) and (fmChungYi.dbeA2_1_1.Text <> '') then
      begin
       if (MinuteQtyList.Count >= StrToInt(fmChungYi.dbeA2_1_1.Text)) then
       begin
        A2Pass:= False;
        sStrategy.A2_1_AveQty:= Round(GetTotal(MinuteQtyList, StrToInt(fmChungYi.dbeA2_1_1.Text), 'End') / StrToInt(fmChungYi.dbeA2_1_1.Text));
        if sStrategy.A2_1_AveQty < MinuteQty then
        begin
         A2Pass:= True;
         sStrategy.A2_1_Light:= 1;
        end else begin
         A2Pass:= False;
         sStrategy.A2_1_Light:= 0;
        end;
       end;
      end else A2Pass:= True;

      //A2_3 ���o�̪��ɪ�����q
      if (fmChungYi.dbckA2_3.Checked) and A2Pass then // �Y A2_1 ���Ŀ�, �� A2_1����
      begin
       fmChungYi.lbBuy.Caption:= FloatToStr(A2_BestBuyQty);
       fmChungYi.lbSell.Caption:= FloatToStr(A2_BestSellQty);
       if fmChungYi.ListV_Interest.Items.Count > 0 then
       begin
        if fmChungYi.ListV_Interest.Items[0].SubItems.strings[1]= 'B' then
         if A2_BestBuyQty < A2_BestSellQty then begin
          A2Pass:= True;
         end else A2Pass:= False;
        if fmChungYi.ListV_Interest.Items[0].SubItems.strings[1]= 'S' then
         if A2_BestBuyQty > A2_BestSellQty then A2Pass:= True else A2Pass:= False;
       end;

      end;

      // �}���t A2-5
      if (fmChungYi.dbckA2_5.Checked) then
      begin
       if NowHigh > ThisLastHigh then sStrategy.A2_5_1B:= 1 else sStrategy.A2_5_1B:= 0;
       if CloseP > ThisLastOpen then sStrategy.A2_5_2B:= 1 else sStrategy.A2_5_2B:= 0;
       if NowLow > ThisLastLow then sStrategy.A2_5_3B:= 1 else sStrategy.A2_5_3B:= 0;

       if NowLow < ThisLastLow then sStrategy.A2_5_1S:= 1 else sStrategy.A2_5_1S:= 0;
       if CloseP < ThisLastOpen then sStrategy.A2_5_2S:= 1 else sStrategy.A2_5_2S:= 0;
       if NowHigh < ThisLastHigh then sStrategy.A2_5_3S:= 1 else sStrategy.A2_5_3S:= 0;

       if sStrategy.A2_5_1S + sStrategy.A2_5_2S + sStrategy.A2_5_3S >= 2 then SellOK:= True else SellOK:= False;
       if sStrategy.A2_5_1B + sStrategy.A2_5_2B + sStrategy.A2_5_3B >= 2 then BuyOK:= True else BuyOK:= False;
      end else begin
       SellOK:= True;
       BuyOK:= True;
      end;

      // A4_1 Time ����
      if (fmChungYi.dbcbA4_1Check.Checked) then
      begin
       if StrToTime(TickTime) > A4_1TimeGate then
        A4TimePass:= True
       else A4TimePass:= False;
      end;

      // C1 �w�g�L�h���T�����ݧP�_ : �O�_�L�h���T���w�ŦX����
      Trigger_C_Strategy(CloseP, NowHigh, NowLow);
      Trigger_C2_Strategy(CloseP, NowHigh, NowLow, Ave5P);

      Trigger_D1_Strategy(Ave5P, Ave10P, Ave20P, CloseP);
      WeightLight(); // �O��

   // RunStrategey(CloseP, Ave5P);   // ���ե�, ������
   end;
  end;

end;
// �e�Q��K�u
procedure DrawLastDate();
var I, J: Integer;
    LastTimeStr: String;
begin
{  for J := LastDateList.Count - 12 to LastDateList.Count - 1 do
  begin
   SubAllList.Text:= LastDateList.Strings[J];
   SubAllList.Delimiter:= ',';
   SubAllList.DelimitedText:= SubAllList.Text;
   LastTimeStr:= TimeToStr((StrToTime(SubAllList.Strings[3]) - 5/24));

   fmQuote.DrawK_Line(LastTimeStr, '', '', SubAllList.Strings[4], SubAllList.Strings[7], SubAllList.Strings[5], SubAllList.Strings[6]);
//  fmQuote.DrawTrendChart(LastTimeStr, SubAllList.Strings[8], SubAllList.Strings[9]); // �e�Ͷչ� (���u)
  end;   }
end;
end.
