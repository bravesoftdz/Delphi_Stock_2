unit getK_Value;

interface

uses Classes, SysUtils, K_Calculate, Public_Variant, StringList_Fun;

function GetNow_K_Value(): Extended;
function GetPrevous_K_Value(): Extended;
function GetAll_K_Value(K_Qty: Integer): Extended;
function Get_K_BuySellQty(K_Qty: Integer): Extended;
procedure Get_Highest();
procedure Get_Lowest();
procedure Get_LastDay();
procedure Get_D53_D53(K_Qty: Integer);

type  // new 策略暫存值
  TStrategy_New = record
    J02_NowCloseAve, J12_NowHighAve, J17_NowLowAve, J22_NowOpenAve, J27_NowAllQtyAve: Extended;
    J03_PreCloseAve, J13_NowHighAve, J18_PreLowAve, J23_PreOpenAve, J28_PreAllQtyAve: Extended;

    J32_BuyQtyAve, J37_SellQtyAve: Extended;

    J51_NowCloseAve, J55_NowCloseAve, J57_NowCloseAve, J59_NowCloseAve: Extended;
    J52_PreCloseAve, J56_PreCloseAve, J58_PreCloseAve, J60_PreCloseAve: Extended;

    D01_K_NowClose, D11_K_NowHigh, D16_K_NowLow, D21_K_NowOpen, D26_K_NowQty: Extended;
    D41_K_PreClose, D42_K_Pre2Close, D43_K_PreHigh, D44_K_Pre2High, D45_K_PreLow,
      D46_K_Pre2Low, D47_K_PreOpen, D48_K_Pre2Open: Extended;

    D31_K_NowBuy, D36_K_NowSell: Extended;

    D53_Inventory_Max, D54_Inventory_Min: Extended;
    D66_TodayOpen, D67_TodayHighest, D68_TodayLowest: Extended;
    D61_BestBuyAve, D62_BestSellAve: Extended;
    D71_1stHigh, D72_1stLow: Extended;

  //  TodayHigh, TodayLow: Extended;
  end;

type
  TK_LineList = record
    OrderList: TStringList; // 記錄已交易資料
    Order_TimeList: TStringList; // 記錄已交易時間
    K_5_MinuteList: TStringList; // 轉換 5 分鐘 K line
    K_5_MinuteList_DateTime: TStringList; // 只存 DateTime
  end;

var NowBuyQty, NowSellQty: Extended;
    sStrategy_new: TStrategy_New;
    sK_LineList: TK_LineList;

implementation

type
  TOrder_Data = record
    Price: Extended;
    BuySell: String;
  end;

// var sStrategy_new: TStrategy_New;


function GetAll_K_Value(K_Qty: Integer): Extended;
begin
  sStrategy_new.J02_NowCloseAve:= GetAve_withQty(K_Qty, K_CloseList, true);
  sStrategy_new.J03_PreCloseAve:= GetAve_withQty(K_Qty, K_CloseList, false);
  sStrategy_new.J12_NowHighAve:= GetAve_withQty(K_Qty, HighList, true);
  sStrategy_new.J13_NowHighAve:= GetAve_withQty(K_Qty, HighList, false);
  sStrategy_new.J17_NowLowAve:= GetAve_withQty(K_Qty, LowList, true);
  sStrategy_new.J18_PreLowAve:= GetAve_withQty(K_Qty, LowList, false);
  sStrategy_new.J22_NowOpenAve:= GetAve_withQty(K_Qty, K_OpenList, true);
  sStrategy_new.J23_PreOpenAve:= GetAve_withQty(K_Qty, K_OpenList, false);

  sStrategy_new.J27_NowAllQtyAve:= GetAve_withQty(K_Qty, MinuteQtyList, true);
  sStrategy_new.J28_PreAllQtyAve:= GetAve_withQty(K_Qty, MinuteQtyList, false);

  if(BuyQtyList.Count > K_Qty) then
    sStrategy_new.J32_BuyQtyAve:= GetAve_withQty(K_Qty, BuyQtyList, true);
  if(SellQtyList.Count > K_Qty) then
    sStrategy_new.J37_SellQtyAve:= GetAve_withQty(K_Qty, SellQtyList, true);

  sStrategy_new.J51_NowCloseAve:= GetAve_withQty(10, K_CloseList, true);
  sStrategy_new.J52_PreCloseAve:= GetAve_withQty(10, K_CloseList, false);
  sStrategy_new.J55_NowCloseAve:= GetAve_withQty(15, K_CloseList, true);
  sStrategy_new.J56_PreCloseAve:= GetAve_withQty(15, K_CloseList, false);
  sStrategy_new.J57_NowCloseAve:= GetAve_withQty(30, K_CloseList, true);
  sStrategy_new.J58_PreCloseAve:= GetAve_withQty(30, K_CloseList, false);
  sStrategy_new.J59_NowCloseAve:= GetAve_withQty(60, K_CloseList, true);
  sStrategy_new.J60_PreCloseAve:= GetAve_withQty(60, K_CloseList, false);

  Get_K_BuySellQty(K_Qty);
  GetNow_K_Value();
  GetPrevous_K_Value();

  sStrategy_new.D71_1stHigh:= StrToFloat(HighList.Strings[0]);
  sStrategy_new.D72_1stLow:= StrToFloat(LowList.Strings[0]);

  Get_Highest();
  Get_Lowest();
end;

function GetNow_K_Value(): Extended;
var GoOther: boolean;
begin
  if(K_CloseList.Count > 0) then begin
    GoOther:= true;
    sStrategy_new.D01_K_NowClose:= StrToFloat(K_CloseList.Strings[K_CloseList.Count - 1]);
  end;
  if(K_OpenList.Count > 0) then
    sStrategy_new.D21_K_NowOpen:= StrToFloat(K_CloseList.Strings[K_OpenList.Count - 1]);
  if(HighList.Count > 0) then
    sStrategy_new.D11_K_NowHigh:= StrToFloat(K_CloseList.Strings[HighList.Count - 1]);
  if(LowList.Count > 0) then
    sStrategy_new.D16_K_NowLow:= StrToFloat(K_CloseList.Strings[LowList.Count - 1]);
  if(MinuteQtyList.Count > 0) then
    sStrategy_new.D26_K_NowQty:= StrToFloat(K_CloseList.Strings[MinuteQtyList.Count - 1]);

  if GoOther then begin
 //   sStrategy_new.D31_K_NowBuy;
    sStrategy_new.D36_K_NowSell:= 0;
    if (sStrategy_new.D21_K_NowOpen < sStrategy_new.D01_K_NowClose) then begin
      sStrategy_new.D31_K_NowBuy:= StrToFloat(BuyQtyList.Strings[BuyQtyList.Count - 1])
    end else if (sStrategy_new.D21_K_NowOpen > sStrategy_new.D01_K_NowClose) then begin
      sStrategy_new.D36_K_NowSell:= StrToFloat(BuyQtyList.Strings[SellQtyList.Count - 1])
    end ;

  end;

end;


function GetPrevous_K_Value(): Extended;
begin
  if(K_CloseList.Count > 1) then
    sStrategy_new.D41_K_PreClose:= StrToFloat(K_CloseList.Strings[K_CloseList.Count - 2]);
  if(HighList.Count > 1) then
    sStrategy_new.D43_K_PreHigh:= StrToFloat(K_CloseList.Strings[HighList.Count - 2]);
  if(LowList.Count > 1) then
    sStrategy_new.D45_K_PreLow:= StrToFloat(K_CloseList.Strings[LowList.Count - 2]);
  if(K_OpenList.Count > 1) then
    sStrategy_new.D47_K_PreOpen:= StrToFloat(K_CloseList.Strings[K_OpenList.Count - 2]);


  if(K_CloseList.Count > 2) then
    sStrategy_new.D42_K_Pre2Close:= StrToFloat(K_CloseList.Strings[K_CloseList.Count - 3]);
  if(HighList.Count > 2) then
    sStrategy_new.D44_K_Pre2High:= StrToFloat(K_CloseList.Strings[HighList.Count - 3]);
  if(LowList.Count > 2) then
    sStrategy_new.D46_K_Pre2Low:= StrToFloat(K_CloseList.Strings[LowList.Count - 3]);
  if(K_OpenList.Count > 2) then
    sStrategy_new.D48_K_Pre2Open:= StrToFloat(K_CloseList.Strings[K_OpenList.Count - 3]);

end;

function Get_K_BuySellQty(K_Qty: Integer): Extended;
begin
  if(BuyQtyList.Count > K_Qty) then
    sStrategy_new.J32_BuyQtyAve:= GetAve_withQty(K_Qty, BuyQtyList, true);
  if(SellQtyList.Count > K_Qty) then
    sStrategy_new.J37_SellQtyAve:= GetAve_withQty(K_Qty, SellQtyList, true);
end;

procedure Get_Highest();
begin
{  sStrategy_new.D67_TodayHighest:= StringList_Fun.GetMax(HighList, HighList.Count - 1, 'Start');
  if(sStrategy_new.D67_TodayHighest < sStrategy_new.D11_K_NowHigh) then
    sStrategy_new.D67_TodayHighest:= sStrategy_new.D11_K_NowHigh;
    }
end;

procedure Get_Lowest();
begin
{
  sStrategy_new.D68_TodayLowest:= StringList_Fun.GetMin(LowList, LowList.Count - 1, 'Start');
  if(sStrategy_new.D16_K_NowLow < sStrategy_new.D68_TodayLowest) then
    sStrategy_new.D68_TodayLowest:=  sStrategy_new.D16_K_NowLow;
    }
end;

procedure Get_LastDay();
var LastDate: String;
begin
  if(HistoryKList.Count > 0) then begin
    TempList:= TStringList.Create;
    TempList.Text:= HistoryKList.Strings[HistoryKList.Count - 1];
    TempList.Delimiter:= ',';
    TempList.DelimitedText:= TempList.Text;

    LastDate:= TempList.Strings[0];
    if(LastDate= ThisTradeDate) then begin  // if the value equal the last one, get the one before the last one
      TempList.Text:= HistoryKList.Strings[HistoryKList.Count - 2];
      TempList.Delimiter:= ',';
      TempList.DelimitedText:= TempList.Text;
    end;
    FreeAndNil(TempList);
  end;
end;

procedure Get_D53_D53(K_Qty: Integer);
var CountK: Integer;
    K_DateTime_Str, Date_Str, Time_Str: String;
    NowTime: TDateTime;
    timeDiff: Integer;
    index_K: Integer;
begin
{
  getTime:= StrToDateTime('2018/04/06 08:50:00');
  Tran_Time:=  StrToDateTime('2018/04/06 08:45:00');
  timeDiff:= (getTime - Tran_Time) * 24 * 60;
  sK_LineList.OrderList.Add(FloatToStr(timeDiff));
 }
  if(sK_LineList.Order_TimeList.Count > 0) then begin
    K_DateTime_Str:= sK_LineList.Order_TimeList[sK_LineList.Order_TimeList.Count - 1];
    Date_Str:= Copy(K_DateTime_Str, 1, 10);
    Time_Str:= Copy(K_DateTime_Str, 12, 5);
    K_DateTime_Str:= Date_Str + ' ' + Time_Str;
    sK_LineList.K_5_MinuteList_DateTime.Find(K_DateTime_Str, index_K);
    // index_K is the current order K

    sStrategy_new.D53_Inventory_Max:= GetMax_fromN(HighList, index_K, K_Qty);
    sStrategy_new.D54_Inventory_Min:= GetMin_fromN(LowList, index_K, K_Qty);
  end;
end;
end.
