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

  // 先取目前已下載資料
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

      // 每分鐘
      if Copy(FormatDateTime('hh:mm:ss', CurrMin), 1, 5) <> Copy(TickTime, 1, 5) then begin

       PassTime:= PassTime + StrTotime(TickTime)- CurrMin;

       CurrMin:= StrTotime(TickTime);  // 更新時間


       // 5 分鐘  (第一次吻合的時間不下載)
       if ((Copy(TickTime, 5, 1)= '5') or (Copy(TickTime, 5, 1)= '0')) and (TickTime <> StartTime) then
       begin
        AddStrTrue:= True;
        Curr5Min:= CurrMin;
       end;
       // 判定是否留倉  13:44:00 ----> 0.5722222222
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
       // 記錄K值
       K_List.Add(FloatToStr(CloseP - OpenP));
       Last_K:= CloseP - OpenP;

       HighList.Add(FloatToStr(NowHigh));
       LowList.Add(FloatToStr(NowLow));

       MinuteQtyList.Add(FloatToStr(MinuteQty));


       K_OpenList.Add(FloatToStr(OpenP));
       K_CloseList.Add(FloatToStr(CloseP));

       // 取得均線前 4, 9, 19 加總值 (等 CloseP List 加入後再加, 給下一個)
    //   DataModule1.GetAve();

       AddStrTrue:= False;
       if CloseP > OpenP then begin
        RedGreen:= 'R'; // 紅棒
       end else
       if CloseP < OpenP then begin
        RedGreen:= 'G';  // 綠棒
       end else RedGreen:= 'E';   // 灰棒


       SQLStr:= SubAllList.Strings[1] + ',' + DateToStr(fmQuote.dtpDate.Date) + ',' + FormatDateTime('hh:mm:ss', CurrMin) + ','
        + FloatToStr(OpenP) + ',' + FloatToStr(NowHigh) + ',' + FloatToStr(NowLow) + ','
        + FloatToStr(CloseP) + ',' + IntToStr(MinuteQty) + ',' + FloatToStr(Ave5P) + ',' + RedGreen;
       LastIndexSN:= LastIndexSN + 1;
       SQLList.Add(IntToStr(LastIndexSN) + ',' + SQLStr);
     {
       if TickTime < '08:50:10' then // 第一根K棒高低點
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
       // 每次計算分鐘線的終點時, 參數歸 0

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


      // 中間每一筆均更新
      if CloseP= 0 then OpenP:= StrToFloat(SubAllList.Strings[6]); // 成交價 (即開盤價)
      CloseP:= StrToFloat(SubAllList.Strings[6]); // 成交價 (即收盤價)
      MinuteQty:= MinuteQty + StrToInt(SubAllList.Strings[7]); // 每分鐘累積成交量

      Ave5P:= (Ave5P_4Total + CloseP) / 5;

      if UpDown = '' then  // 判斷K棒當收在均線上 or下方
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

   // RunStrategey(CloseP, Ave5P);   // 測試用, 須移除
   end;
  end;

end;
// 畫昨天K線
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
//  fmQuote.DrawTrendChart(LastTimeStr, SubAllList.Strings[8], SubAllList.Strings[9]); // 畫趨勢圖 (均線)
  end;   }
end;
end.
