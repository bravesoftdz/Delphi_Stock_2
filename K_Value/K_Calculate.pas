unit K_Calculate;

interface

uses Classes, SysUtils, Public_Variant;

function GetAve_withQty(CountQty: Integer; OriginalList: TStringList; IsInclude: boolean): Extended;
procedure TransferTo5Minute(K_LineList_Min: TStringList);

implementation

uses StringList_Fun, getK_Value;


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
end.
