unit K_Calculate;

interface

uses Classes, SysUtils, Public_Variant;

function GetAve_withQty(CountQty: Integer; OriginalList: TStringList; IsInclude: boolean): Extended;
procedure TransferTo5Minute(K_LineList_Min: TStringList);
procedure GetDdate(AveQty: Integer);
procedure AverageList_5(AveQty: Integer);
procedure DayHistoryCloseList();

implementation

uses StringList_Fun, getK_Value, K_Line_Save;


function GetAve_withQty(CountQty: Integer; OriginalList: TStringList; IsInclude: boolean): Extended;
begin
  if IsInclude then
    Result:= StringList_Fun.GetSumValue(OriginalList, CountQty, 0, true)
  else
    Result:= StringList_Fun.GetSumValue(OriginalList, CountQty, 1, true);
end;

procedure TransferTo5Minute(K_LineList_Min: TStringList);
var i: Integer;
    nowDate, nowTime: String;
    nowHigh, nowLow, nowOpen, fiveHigh, fiveLow, fiveOpen, fiveClose, fiveQty: Extended;
begin
  if(K_LineList_Min.Count = 0) then begin
   exit;
 end;

 fiveHigh:= 0;
 fiveLow:= 0;
 fiveOpen:= 0;
 fiveQty:= 0;

 sK_LineList.K_5_MinuteList:= TStringList.Create;
 sK_LineList.K_5_MinuteList_DateTime:= TStringList.Create;
 for i := 0 to K_LineList_Min.Count - 1 do begin
   TempList.Text:= K_LineList_Min.Strings[i];
   TempList.Delimiter:= ',';
   TempList.DelimitedText:= TempList.Text;

   nowDate:= TempList.Strings[0];
   nowTime:= TempList.Strings[1];
   nowOpen:= StrToFloat(TempList.Strings[2]);
   nowHigh:= StrToFloat(TempList.Strings[3]);
   nowLow:= StrToFloat(TempList.Strings[4]);


   if(fiveHigh < nowHigh) then
     fiveHigh:= nowHigh;
   if(fiveLow > nowLow) then
     fiveLow:= nowLow;
   fiveQty:= fiveQty + StrToFloat(TempList.Strings[6]);

   if((i + 1) mod 5 = 0) then begin
     sK_LineList.K_5_MinuteList.Add(nowDate + ',' + nowTime + ',' + FloatToStr(fiveOpen) + ','
       + FloatToStr(fiveHigh) + ',' + FloatToStr(fiveLow) + ',' + TempList.Strings[5] + ','
       + FloatToStr(fiveQty));
     sK_LineList.K_5_MinuteList_DateTime.Add(nowDate + ' ' + nowTime);

       fiveHigh:= 0;
       fiveLow:= 0;
       fiveOpen:= 0;
       fiveQty:= 0;
   end else if ((i + 1) mod 5 = 1) then begin
     fiveOpen:= nowOpen;
     fiveLow:= nowLow;
   end;

 end;

// sK_LineList.K_5_MinuteList.SaveToFile('K_5_Minute.txt');
end;

procedure GetDdate(AveQty: Integer);
var TempDate, AddDate, Ave5P: String;
    I: Integer;
begin
 if(K_LineList_Min.Count = 0) then begin
   exit;
 end;

 TransferTo5Minute(K_LineList_Min);

 TempList.Text:= K_LineList_Min.Strings[K_LineList_Min.Count - 1];
 TempList.Delimiter:= ',';
 TempList.DelimitedText:= TempList.Text;
 TempDate:= TempList.Strings[0];

 // 眔琎ぱら戳
 if TempDate = ThisTradeDate then begin // 絃

  // 眔琎ら程蔼基
  TempList.Text:= HistoryKList.Strings[HistoryKList.Count - 2];
  TempList.Delimiter:= ',';
  TempList.DelimitedText:= TempList.Text;
  LastHigh:= StrToFloat(TempList.Strings[2]);
  LastLow:= StrToFloat(TempList.Strings[3]);
  LastOpen:= StrToFloat(TempList.Strings[1]);
 end else begin // 絃い
  LastDate:= TempDate;
  // 眔琎ら程蔼基, 秨絃基
  TempList.Text:= HistoryKList.Strings[HistoryKList.Count - 1];
  TempList.Delimiter:= ',';
  TempList.DelimitedText:= TempList.Text;
  LastHigh:= StrToFloat(TempList.Strings[2]);
  LastLow:= StrToFloat(TempList.Strings[3]);
  LastOpen:= StrToFloat(TempList.Strings[1]);
 end;

 sStrategy_new.D73_LastOpen:= LastOpen;

 for I := 0 to sK_LineList.K_5_MinuteList.Count - 1  do begin
  TempList.Text:= sK_LineList.K_5_MinuteList.Strings[I];
  TempList.Delimiter:= ',';
  TempList.DelimitedText:= TempList.Text;

  TempDate:= TempList.Strings[0];

  if TempDate <> AddDate then begin
   AddDate:= TempDate;
   DateList.Add(AddDate);  // 眔ら戳
  end;

  if TempDate = ThisTradeDate then
    break;

  K_OpenList.Add(TempList.Strings[2]);
  HighList.Add(TempList.Strings[3]);
  LowList.Add(TempList.Strings[4]);
  K_CloseList.Add(TempList.Strings[5]);
  MinuteQtyList.Add(TempList.Strings[6]);
  K_List.Add(FloatToStr(StrToFloat(K_OpenList.Strings[K_OpenList.Count - 1])
             - StrToFloat(K_CloseList.Strings[K_CloseList.Count - 1])));

 end;

 AverageList_5(AveQty);
 GetPreAve(AveQty); // 眔А絬玡 4, 9, 19 羆

 DayHistoryCloseList();
 KeepListData();

 {
 TransferTo5Minute(K_LineList_Min);

 TempList.Text:= K_LineList_Min.Strings[K_LineList_Min.Count - 1];
 TempList.Delimiter:= ',';
 TempList.DelimitedText:= TempList.Text;

// TempDate:= Copy(TempList.Strings[0], 7, 4) + '/' + Copy(TempList.Strings[0], 1, 5);
 TempDate:= TempList.Strings[0];

 // 眔琎ぱら戳
 if TempDate = ThisTradeDate then begin // 絃

  IndexNO:= 61;
  TempList.Text:= K_LineList_Min.Strings[K_LineList_Min.Count - 62];
  TempList.Delimiter:= ',';
  TempList.DelimitedText:= TempList.Text;

  TempList.SaveToFile('LastK_1340.txt');
  LastDate:= TempList.Strings[0];

  // 眔琎ら程蔼基
  TempList.Text:= HistoryKList.Strings[HistoryKList.Count - 2];
  TempList.Delimiter:= ',';
  TempList.DelimitedText:= TempList.Text;
  LastHigh:= StrToFloat(TempList.Strings[2])/100;
  LastLow:= StrToFloat(TempList.Strings[3])/100;
  LastClose:= StrToFloat(TempList.Strings[4])/100;
  LastOpen:= StrToFloat(TempList.Strings[1])/100;
 end else begin // 絃い
  LastDate:= TempDate;
  IndexNO:= 1;
  // 眔琎ら程蔼基, 秨絃基
  TempList.Text:= HistoryKList.Strings[HistoryKList.Count - 1];
  TempList.Delimiter:= ',';
  TempList.DelimitedText:= TempList.Text;
  LastHigh:= StrToFloat(TempList.Strings[2])/100;
  LastLow:= StrToFloat(TempList.Strings[3])/100;
  LastClose:= StrToFloat(TempList.Strings[4])/100;
  LastOpen:= StrToFloat(TempList.Strings[1])/100;
 end;

 for I := 0 to K_LineList_Min.Count - IndexNO  do begin
  TempList.Text:= K_LineList_Min.Strings[I];
  TempList.Delimiter:= ',';
  TempList.DelimitedText:= TempList.Text;

  TempDate:= TempList.Strings[0];

  if TempDate <> AddDate then begin
   AddDate:= TempDate;
   DateList.Add(AddDate);  // 眔ら戳
  end;

  K_OpenList.Add(TempList.Strings[2]);
  HighList.Add(TempList.Strings[3]);
  LowList.Add(TempList.Strings[4]);
  K_CloseList.Add(TempList.Strings[5]);
  MinuteQtyList.Add(TempList.Strings[6]);
  K_List.Add(FloatToStr(StrToFloat(K_OpenList.Strings[K_OpenList.Count - 1])
             - StrToFloat(K_CloseList.Strings[K_CloseList.Count - 1])));

 end;


 // А絬
 for I := 0 to K_CloseList.Count - IndexNO - 4 do
 begin
  Ave5P:= FloatToStr(Round((StrToFloat(K_CloseList.Strings[I])
           + StrToFloat(K_CloseList.Strings[I + 1])
           + StrToFloat(K_CloseList.Strings[I + 2])
           + StrToFloat(K_CloseList.Strings[I + 3])
           + StrToFloat(K_CloseList.Strings[I + 4]))/5));
  AveList.Add(Ave5P);
 end;
 GetAve(); // 眔А絬玡 4, 9, 19 羆

 KeepListData();
 }
end;

procedure DayHistoryCloseList();
var TempList: TStringList;
    i, ShiftQty: Integer;
    TempDate: String;
begin
  TempList:= TStringList.Create;
  ShiftQty:= 0;
  TempList.Text:= HistoryKList.Strings[HistoryKList.Count - 1];
  TempList.Delimiter:= ',';
  TempList.DelimitedText:= TempList.Text;
  TempDate:= TempList.Strings[0];
  if TempDate = ThisTradeDate then
    ShiftQty:= 1;

  for I := 0 to HistoryKList.Count - 1 - ShiftQty  do begin
    TempList.Text:= sK_LineList.K_5_MinuteList.Strings[I];
    TempList.Delimiter:= ',';
    TempList.DelimitedText:= TempList.Text;

    TempDate:= TempList.Strings[0];
    K_Line_Save.DayCloseList.Add(TempList.Strings[4]);
  end;

  FreeAndNil(TempList);
end;

procedure AverageList_5(AveQty: Integer);
var i, j: Integer;
    temp_5P: Extended;
begin
  // А絬
 temp_5P:= 0;
 for i := 0 to K_CloseList.Count - AveQty do begin
  for j := 0 to AveCount - 1 do begin
    temp_5P:= temp_5P + StrToFloat(K_CloseList.Strings[i + j]);
  end;

  AveList.Add(FloatToStr(temp_5P/AveQty));
  temp_5P:= 0;
 end;
end;
end.
