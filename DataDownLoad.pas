unit DataDownLoad;

interface

procedure GetOriginalData();
procedure DrawLastDate();

implementation

uses Quote, Quote_uSKQ, Public_Variant, SysUtils, Math, GeneralFunction, Strategy,
     ChungYi_Main, StringList_Fun, DMRecord, Graphics, getK_Value, ChouRule;

procedure GetOriginalData();
var LastTicktime: String;
  I: Integer;
  RedGreen: String;
  SQLStr, AllSQL: String;
  PassTime: Extended;
begin
  PassTime:= 0;
  fmQuote.ClearNowData();

  // �����ثe�w�U�����
  SubAllList.Text:= AllSQLList.Strings[0];
  SubAllList.Delimiter:= ',';
  SubAllList.DelimitedText:= SubAllList.Text;
  if SubAllList.Strings[2]= ThisTradeDate then
  begin
   for I:= 0 to AllSQLList.Count - 1 do begin
    SubAllList.Text:= AllSQLList.Strings[I];
    SubAllList.Delimiter:= ',';
    SubAllList.DelimitedText:= SubAllList.Text;
    TickTime:= SubAllList.Strings[3];

      if(I= AllSQLList.Count - 1) and (not TimeLimit(TickTime)) then
        TotalTickQty:= StrToFloat(SubAllList.Strings[12]);

      // �C����
      if Copy(FormatDateTime('hh:mm:ss', CurrMin), 1, 5) <> Copy(TickTime, 1, 5) then begin

       PassTime:= PassTime + StrTotime(TickTime)- CurrMin;

       CurrMin:= StrTotime(TickTime);  // ��s�ɶ�


       // 5 ����  (�Ĥ@���k�X���ɶ����U��)
       if ((Copy(TickTime, 5, 1)= '5') or (Copy(TickTime, 5, 1)= '0')) and (TickTime <> StartTime) then
       begin
        AddStrTrue:= True;
        Curr5Min:= CurrMin;
       end;
       // �P�w�O�_�d��  13:44:00 ----> 0.5722222222
       if ((CurrMin - 0.5722222222)> 0) and ((CurrMin - 0.5722222222)< 1/8640) and LastTime then
       begin

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

       HighList.Add(FloatToStr(NowHigh));
       LowList.Add(FloatToStr(NowLow));

       MinuteQtyList.Add(FloatToStr(MinuteQty));


       K_OpenList.Add(FloatToStr(OpenP));
       K_CloseList.Add(FloatToStr(CloseP));

       // ���o���u�e 4, 9, 19 �[�`�� (�� CloseP List �[�J��A�[, ���U�@��)
    //   DataModule1.GetAve();

       AddStrTrue:= False;
       if CloseP > OpenP then begin
        RedGreen:= 'R'; // ����
       end else
       if CloseP < OpenP then begin
        RedGreen:= 'G';  // ���
       end else RedGreen:= 'E';   // �Ǵ�


       SQLStr:= SubAllList.Strings[1] + ',' + DateToStr(fmQuote.dtpDate.Date) + ',' + FormatDateTime('hh:mm:ss', CurrMin) + ','
        + FloatToStr(OpenP) + ',' + FloatToStr(NowHigh) + ',' + FloatToStr(NowLow) + ','
        + FloatToStr(CloseP) + ',' + IntToStr(MinuteQty) + ',' + FloatToStr(Ave5P) + ',' + RedGreen;
       LastIndexSN:= LastIndexSN + 1;
       SQLList.Add(IntToStr(LastIndexSN) + ',' + SQLStr);
     {
       if TickTime < '08:50:10' then // �Ĥ@��K�ΰ��C�I
       begin
        FirstLow:= NowLow;
        FirstHigh:= NowHigh;
       end;
       }
       ThisLastHigh:= NowHigh;
       ThisLastLow:= NowLow;
       ThisLastOpen:= OpenP;

       GetAll_K_Value_5_minute(AveCount);
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
       getK_Value.NowBuyQty:= 0;
       getK_Value.NowSellQty:= 0;
      end;
   //======================================================================================


      // �����C�@������s
      if CloseP= 0 then OpenP:= StrToFloat(SubAllList.Strings[6]); // ����� (�Y�}�L��)
      CloseP:= StrToFloat(SubAllList.Strings[6]); // ����� (�Y���L��)
      MinuteQty:= MinuteQty + StrToInt(SubAllList.Strings[7]); // �C�����ֿn����q

      Ave5P:= (Ave5P_4Total + CloseP) / 5;

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
      else if NowLow > CloseP then begin
            NowLow:= CloseP;
            HourLow:= NowLow;
            HourLTime:= TickTime;
      end;

      GetAll_K_Value(AveCount);

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
