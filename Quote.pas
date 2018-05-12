unit Quote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, CheckLst, Math, Quote_uSKQ, Series,
  TeEngine, TeeProcs, Chart, BubbleCh, MathFunction, Menus,
  JvComponentBase, JvEmbeddedForms, Public_Variant, ShellAPI, OleServer,
  SKCOMLib_TLB, StrUtils, StockHandle, DataParsing;

type
  TfmQuote = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtPass: TEdit;
    edtLogID: TEdit;
    GroupBox2: TGroupBox;
    btnDownLoad: TButton;
    Memo1: TMemo;
    cbbStockNO: TComboBox;
    btnDataBase: TButton;
    Label3: TLabel;
    dtpDate: TDateTimePicker;
    MainChart: TChart;
    lbShow: TLabel;
    Series1: TLineSeries;
    Series3: TBarSeries;
    Panel1: TPanel;
    Series2: TPointSeries;
    Series4: TPointSeries;
    Series5: TPointSeries;
    Series6: TPointSeries;
    lbOpen: TLabel;
    jedfMainQuote: TJvEmbeddedFormLink;
    lbHigh: TLabel;
    LastTimer: TTimer;
    lbLow: TLabel;
    lbClose: TLabel;
    lbTickTime: TLabel;
    lbTest: TLabel;
    Series9: TLineSeries;
    btnKLine: TButton;
    Panel2: TPanel;
    Label4: TLabel;
    lbNowOpen: TLabel;
    lbNowHigh: TLabel;
    lbNowLow: TLabel;
    lbNowClose: TLabel;
    lbNowMA5: TLabel;
    lbBalance: TLabel;
    btnHistoryKLine: TButton;
    TimerSystem: TTimer;
    lbSystemTime: TLabel;
    Label5: TLabel;
    DownLoadTimer: TTimer;
    edtStart: TEdit;
    Label6: TLabel;
    edtEnd: TEdit;
    Label7: TLabel;
    SKOSQuoteLib1: TSKOSQuoteLib;
    SKQuoteLib1: TSKQuoteLib;
    SKOrderLib1: TSKOrderLib;
    procedure btnDownLoadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDataBaseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DrawTrendChart(TickTimeStr, QtyStr, PriceStr: String);
    procedure DrawK_Line(TickTimeStr, QtyStr, PriceStr, OpenP, CloseP, HighValue, LowValue: String);
    procedure MainChartAfterDraw(Sender: TObject);
    procedure DrawCross(AX,AY:Integer);
    procedure MainChartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MinuteK_Line();

    procedure ClearNowData();
    procedure cbbStockNOChange(Sender: TObject);
    procedure dtpDateChange(Sender: TObject);
    procedure LastTimerTimer(Sender: TObject);
    procedure btnKLineClick(Sender: TObject);
 //   procedure btnHistoryKLineClick(Sender: TObject);
    procedure SaveIndexTable();
    procedure TimerSystemTimer(Sender: TObject);
    procedure DownLoadTimerTimer(Sender: TObject);
    procedure SKOSQuoteLib1NotifyTicks(ASender: TObject; sStockIdx: SmallInt;
      nPtr, nTime, nClose, nQty: Integer);
    procedure SKQuoteLib1NotifyTicks(ASender: TObject; sMarketNo,
      sIndex: SmallInt; nPtr, nTimehms, nTimemillismicros, nBid, nAsk, nClose,
      nQty, nSimulate: Integer);
    procedure SKOSQuoteLib1KLineData(ASender: TObject; const bstrStockNo,
      bstrData: WideString);

    procedure InputTicks(sMarket: SmallInt; iPtr: Integer; SK: SKSTOCK; TK: SKTICK;
  StockNO, StockName: String; sIndex: SmallInt; IsHistory: boolean);
    procedure cbbStockNODropDown(Sender: TObject);
    procedure SKOrderLib1OverseaFutureOpenInterest(ASender: TObject;
      const bstrData: WideString);
    procedure SKOSQuoteLib1Connect(ASender: TObject; nCode,
      nSocketCode: Integer);
    procedure SKQuoteLib1Connection(ASender: TObject; nKind, nCode: Integer);
    procedure SKOSQuoteLib1NotifyServerTime(ASender: TObject; sHour, sMinute,
      sSecond: SmallInt);
    procedure SKQuoteLib1NotifyKLineData(ASender: TObject; const bstrStockNo,
      bstrData: WideString);
    procedure SKQuoteLib1NotifyServerTime(ASender: TObject; sHour, sMinute,
      sSecond: SmallInt; nTotal: Integer);
    procedure GetServerTime(sHour, sMinute, sSecond: SmallInt);
    procedure ClearVariable();
    procedure SKOrderLib1Account(ASender: TObject; const bstrLogInID,
      bstrAccountData: WideString);
    procedure SKOrderLib1OverseaFuture(ASender: TObject;
      const bstrData: WideString);
    procedure SKOrderLib1OpenInterest(ASender: TObject;
      const bstrData: WideString);
    procedure SKOSQuoteLib1NotifyBest5(ASender: TObject; sStockIdx: SmallInt;
      nBestBid1, nBestBidQty1, nBestBid2, nBestBidQty2, nBestBid3, nBestBidQty3,
      nBestBid4, nBestBidQty4, nBestBid5, nBestBidQty5, nBestAsk1, nBestAskQty1,
      nBestAsk2, nBestAskQty2, nBestAsk3, nBestAskQty3, nBestAsk4, nBestAskQty4,
      nBestAsk5, nBestAskQty5: Integer);
    procedure SKQuoteLib1NotifyBest5(ASender: TObject; sMarketNo,
      sStockIdx: SmallInt; nBestBid1, nBestBidQty1, nBestBid2, nBestBidQty2,
      nBestBid3, nBestBidQty3, nBestBid4, nBestBidQty4, nBestBid5, nBestBidQty5,
      nExtendBid, nExtendBidQty, nBestAsk1, nBestAskQty1, nBestAsk2,
      nBestAskQty2, nBestAsk3, nBestAskQty3, nBestAsk4, nBestAskQty4, nBestAsk5,
      nBestAskQty5, nExtendAsk, nExtendAskQty, nSimulate: Integer);
    procedure SKQuoteLib1NotifyHistoryTicks(ASender: TObject; sMarketNo,
      sStockIdx: SmallInt; nPtr, nTimehms, nTimemillismicros, nBid, nAsk,
      nClose, nQty, nSimulate: Integer);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmQuote: TfmQuote;
  SK: TStock;
  SK_New: SKSTOCK;
  TK_New: SKTICK;
  ForeingSK: SKFOREIGN;
  hSKQ: THandle = 0;
  iSKQStatus: integer = 0;
//  K_LineList_Min: TStringList;
  HaveGot: Boolean= False; //  判斷 KeyValue 是否已填入資料庫
  GetQty, ToQty: Integer; // GetQty: 判斷要抓多少個Tickle的基準
  CountQty: Integer;
  SerTime: TSerTime; // 系統時間

  OldX:Integer=-100;
  OldY:Integer;

  TQty_History: Integer; // 歷史總量紀錄
  // 海期
  TQty_History_OS: Integer; // 歷史總量紀錄

  // Replace "--" with ","
  StrockNM_W_Comma: String;
  StockList: TStringList;
  Dialog: TForm;
  SpeedTime: boolean;

  TotalTickQty: Extended;   // total tick qty

implementation

uses DMRecord, GeneralFunction, Strategy, ChungYi_Main, DataDownLoad, StringList_Fun,
     SQLFunction, Stock_OptionOrder, CheckNetwork, DB_Handle, DB_GetData, getK_Value,
     AdjustField, K_Line_Save, K_Calculate, Initial_K, ChouRule, Strategy_PreOrder,
     First_Check_Strategy, OrderHandle;

{$R *.dfm}

procedure OnConnection(iKind, iCode: Integer);
//~~策略王 報價 連線成功
begin
  fmQuote.Memo1.Lines.Add(FormatDateTime('hh:nn:ss:zzz ', now) + '-> ' + '報價 連線成功 !! (iKind = ' + IntToStr(iKind) + ', iCode = ' + IntToStr(iCode));
end;

procedure TfmQuote.InputTicks(sMarket: SmallInt; iPtr: Integer; SK: SKSTOCK; TK: SKTICK;
  StockNO, StockName: String; sIndex: SmallInt; IsHistory: boolean);
var // iSt: integer;
  iDot: Double;
  sID, stmp: string;
  RedGreen: String;
  I, iSt: Integer;
  AllSQL: String;
  LockTimeStr: String; // 第一次下載時, 不需進入計算的時間. 如08:45, 09:00
  Time20: String;
  TK_Forering:SKFOREIGNTICK;
  WriteFile: boolean;
  TotalQty: Integer; // 目前總共下載筆數
begin

//  iSt := SKQuoteLib1.SKQuoteLib_GetStockByIndex(sMarket, sIndex, SK);
  sID := Trim(StockNO);
  iDot := Power(10, SK.sDecimal);
  ToQty:= iPtr;

  if PrepareData then begin // 是否處理之前下載資料
   PrepareData:= False;
//   LastClose:= SK.nClose / 100;
   LastClose:= SK.nRef / 100;
   ThisOpen:= SK.nOpen / 100;
 //  sStrategy_new.D66_TodayOpen:= SK.nOpen / 100;

   GetOriginalData();
  end else
    TotalQty:= 0;

  if(AllSQLList <> nil) and (AllSQLList.Count > 0) then begin
    SubAllList.Text:= AllSQLList.Strings[AllSQLList.Count - 1];
    SubAllList.Delimiter:= ',';
    SubAllList.DelimitedText:= SubAllList.Text;
    TotalQty:= StrToInt(SubAllList.Strings[13]);
 //   TotalQty:= AllSQLList.Count;
  end;

  GetQty:= TotalQty;   // 判斷共有幾筆, 從哪一點開始下載
  for I:= GetQty to ToQty do begin
   iSt:= 0;

   if iSt = 0 then begin
      if(ContainsText(StrockNM_W_Comma, ',')) then begin
        // foreing
        iSt := iSt + SKOSQuoteLib1.SKOSQuoteLib_GetTick(sIndex, I, TK_Forering);
        TK.nTimehms:= TK_Forering.nTime;
        TK.nClose:= TK_Forering.nClose;
        TK.nQty:= TK_Forering.nQty;
      end else
        iSt := iSt + SKQuoteLib1.SKQuoteLib_GetTick(sMarket, sIndex, I, TK);

      TotalQty:= TotalQty + 1;
      if(TK.nClose= 0) then
        continue;

      if(sStrategy_new.D67_TodayHighest < TK.nClose / iDot) then
        sStrategy_new.D67_TodayHighest:= TK.nClose / iDot;
      if(sStrategy_new.D68_TodayLowest = 0) then sStrategy_new.D68_TodayLowest:=  TK.nClose / iDot
      else if(sStrategy_new.D68_TodayLowest > TK.nClose / iDot) then
        sStrategy_new.D68_TodayLowest:=  TK.nClose / iDot;

      TickTime:= TimeTransfer(IntToStr(TK.nTimehms));
      if TimeLimit(TickTime) then
        continue;

      if(ShiftTime <> 0) then
        TickTime:= TimeToStr(StrToTime(TickTime) + ShiftTime / 24);

  //    TotalTickQty:= TotalTickQty + TK.nQty;

      // 每分鐘
      if Copy(FormatDateTime('hh:mm:ss', CurrMin), 1, 5) <> Copy(TickTime, 1, 5) then begin
       WriteFile:= true;

       CurrMin:= StrTotime(TickTime);  // 更新時間
       if FirstTime then begin
        LockTimeStr:= TickTime;
        FirstTime:= False;
       end;

       // 5 分鐘  (第一次吻合的時間不下載)
       if ((Copy(TickTime, 5, 1)= '5') or (Copy(TickTime, 5, 1)= '0')) and (TickTime <> StartTime) then begin
        AddStrTrue:= True;
        Curr5Min:= CurrMin;

       end;

       // 判定是否留倉  13:44:00 ----> 0.5722222222
       if ((CurrMin - 0.5722222222)> 0) and ((CurrMin - 0.5722222222)< 1/8640) and LastTime then begin
      //  LastPhase(); // E1_3 圖形趨勢
      //  Strategy.Trigger_E_Strategy();  // E1_1, E1_2, E1_4, E1_5
        LastTime:= False;
       end;
      end;

      if AddStrTrue and (TickTime <> LockTimeStr) then begin
       // 記錄K值
       K_List.Add(FloatToStr(CloseP - OpenP));
       Last_K:= CloseP - OpenP;

       // Record Qty
       BuyQtyList.Add(FloatToStr(getK_Value.NowBuyQty));
       SellQtyList.Add(FloatToStr(getK_Value.NowSellQty));

       // K 最高 / 最低成交值, 量
       HighList.Add(FloatToStr(NowHigh));
       LowList.Add(FloatToStr(NowLow));

       MinuteQtyList.Add(FloatToStr(MinuteQty));

       K_OpenList.Add(FloatToStr(OpenP));
       K_CloseList.Add(FloatToStr(CloseP));

       // 取得均線前 4, 9, 19 加總值 (等 CloseP List 加入後再加, 給下一個)
   //    DataModule1.GetAve();

       AddStrTrue:= False;
       if CloseP > OpenP then begin
        RedGreen:= 'R'; // 紅棒
       end else
       if CloseP < OpenP then begin
        RedGreen:= 'G';  // 綠棒
       end else RedGreen:= 'E';   // 灰棒

       SQLStr:= fmQuote.cbbStockNO.Text + ',' + DateToStr(fmQuote.dtpDate.Date) + ',' + FormatDateTime('hh:mm:ss', CurrMin) + ','
        + FloatToStr(OpenP) + ',' + FloatToStr(NowHigh) + ',' + FloatToStr(NowLow) + ','
        + FloatToStr(CloseP) + ',' + IntToStr(MinuteQty) + ',' + FloatToStr(Ave5P) + ',' + RedGreen;
       LastIndexSN:= LastIndexSN + 1;
       SQLList.Add(IntToStr(LastIndexSN) + ',' + SQLStr);
  //     SQLList.SaveToFile('IndexTable_' + fmQuote.cbbStockNO.Text + '.Txt');
  //     AllSQLList.SaveToFile('AllTXF00Data_' + fmQuote.cbbStockNO.Text + '.Txt');


       // 本日前一根收盤價
       if (sStrategy_new.D69_TodayClose = 0) and (StrToTime(TickTime) >= StrToTime(EndTime) - 300/86400) then begin // 最後一根根K棒高低點
         sStrategy_new.D69_TodayClose:= CloseP;
       end;

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

       KeepListData();
      end;
   //======================================================================================

    //  if(SpeedTime) then begin
        if(Copy(TickTime, 1, 2)= '00') then begin
          SpeedTime:= false;
          ThisTradeDate:= DateToStr(Date);
          fmQuote.dtpDate.Date:= StrToDate(ThisTradeDate);
        end;
   //   end;

       // 下載所有資料
      AllSQL:= fmQuote.cbbStockNO.Text + ',' + DateToStr(fmQuote.dtpDate.Date) + ',' + TickTime + ','
        + FormatFloat('0.000', TK.nBid / iDot) + ', ' +
        FormatFloat('0.000', TK.nAsk / iDot) + ', ' + FormatFloat('0.000', TK.nClose / iDot) + ', ' +
        IntToStr(TK.nQty) + ', ' + FloatToStr(Ave5P);



      LastSN:= LastSN + 1;
      AddChou_Field(AllSQL, SK, iDot, InsertMode, LastSN, TK, TotalQty);

      if(AllSQLList= nil) then
        Abort;

      AllSQLList.Add(IntToStr(LastSN) + ',' + AllSQL);

      if(AllSQLList.Count > 0) then begin
     //   AllSQLList.Add(IntToStr(LastSN) + ',' + AllSQL);
        // 最後一秒抓取資料的判讀
        if Ticktime= LastMiniute then begin
          fmQuote.LastTimer.Enabled:= True;
          AllSQLList.SaveToFile('AllTXF00Data_' + fmQuote.cbbStockNO.Text + '.Txt');
          // 處理 IndexTable
          if LastMinute then LastIndexSN:= LastIndexSN + 1; // 只有第一次加, 給 13:45:00
          LastMinute:= False;

          SQLStr:= fmQuote.cbbStockNO.Text + ',' + DateToStr(fmQuote.dtpDate.Date) + ',' + '13:45:00' + ','
            + FloatToStr(OpenP) + ',' + FloatToStr(NowHigh) + ',' + FloatToStr(NowLow) + ','
            + FloatToStr(CloseP) + ',' + IntToStr(MinuteQty) + ',' + FloatToStr(Ave5P) + ',' + RedGreen;
        end;
      end;


      // 中間每一筆均更新
      if CloseP= 0 then OpenP:= TK.nClose / iDot; // 成交價 (即開盤價)
      CloseP:= TK.nClose / iDot; // 成交價 (即收盤價)
      MinuteQty:= MinuteQty + TK.nQty; // 每分鐘累積成交量

      Ave5P:= (Ave5P_4Total + CloseP) / 5;
  //    Ave10P:= Round((Ave10P_4Total + CloseP) / 10);
  //    Ave20P:= Round((Ave20P_4Total + CloseP) / 20);

      FirstTime:= False;

      if NowHigh < TK.nClose / iDot then begin
       NowHigh:= TK.nClose / iDot;
       HourHigh:= NowHigh;
       HourHTime:= TickTime;
      end;

      if NowLow = 0 then NowLow:= TK.nClose / iDot
      else if NowLow > TK.nClose / iDot then begin
            NowLow:= TK.nClose / iDot;
            HourLow:= NowLow;
            HourLTime:= TickTime;
      end;

      // 最高/低平均值
   //   if sStrategy.D1_Ave_High < Ave5P then sStrategy.D1_Ave_High:= Ave5P;
   //   if sStrategy.D1_Ave_Low = 0 then sStrategy.D1_Ave_Low:= Ave5P
   //   else if sStrategy.D1_Ave_Low > Ave5P then sStrategy.D1_Ave_Low:= Ave5P;

      // 顯示即時資訊
      fmQuote.lbNowOpen.Caption:= '開盤: ' + FloatToStr(OpenP);
      fmQuote.lbNowHigh.Caption:= '最高: ' + FloatToStr(NowHigh);
      fmQuote.lbNowLow.Caption:= '最低: ' + FloatToStr(NowLow);
      fmQuote.lbNowClose.Caption:= '收盤: ' + FloatToStr(CloseP);
      fmQuote.lbNowMA5.Caption:= 'MA5: ' + FloatToStr(Ave5P);

      GetAll_K_Value(AveCount);

   //   WeightLight(); // 燈號
   //   RunStrategey(CloseP, Ave5P); // 須刪除
   end;
  end;
   // 已經過去的訊號不需觸發下單, 所以不設在迴圈內
//  RunStrategey(CloseP, Ave5P);

  if(not IsHistory) and WriteFile then begin
    WriteFile:= false;
    SQLList.SaveToFile('IndexTable_' + fmQuote.cbbStockNO.Text + '.Txt');
    AllSQLList.SaveToFile('AllTXF00Data_' + fmQuote.cbbStockNO.Text + '.Txt');
  end;

  StopGate:= False;

end;

procedure TfmQuote.LastTimerTimer(Sender: TObject);
begin  // 最後一秒後, 轉入資料庫
 LastTimer.Enabled:= False;

 SQLList.Add(IntToStr(LastIndexSN) + ',' + SQLStr);
 SQLList.SaveToFile('IndexTable_' + fmQuote.cbbStockNO.Text + '.Txt');
 fmQuote.MinuteK_Line();
 btnDataBase.Click;
end;

//
procedure TfmQuote.FormCreate(Sender: TObject);
begin
  dtpDate.Date:= StrToDate(ThisTradeDate);
  StopGate:= False;

  K_Line_Initial();
  Initial_K_Value();

  dtpDate.Date:= StrToDate(ThisTradeDate);
  cbbStockNO.Text:= fmChungYi.cbbCommNO.Text;
  StrockNM_W_Comma:= stringreplace(fmQuote.cbbStockNO.Text, '__', ',', [rfReplaceAll, rfIgnoreCase]);

  Floated:= False;
  DataModule1.asqQU_Temp.SQL.Text:= 'select SN from IndexTable where TradeDate="'
    + DateToStr(fmQuote.dtpDate.Date) + '" and StockNO="' + cbbStockNO.Text + '"';
  DataModule1.asqQU_Temp.Open;
  if DataModule1.asqQU_Temp.FieldByName('SN').Text <> '' then HaveGot:= True;
  // 記錄圖形的最後一筆序號
  FigureSN:= DataModule1.AssignSN('Figure');
  sStrategy.E_1_5G:= 0; // 綠棒累積成交量
  sStrategy.E_1_5R:= 0; // 紅棒累積成交量

  // 填入 start / end time
  edtStart.Text:= StartTime;
  edtEnd.Text:= EndTime;
  LastMiniute:= TimeToStr((StrToTime(EndTime) - 1/86400));
end;

procedure TfmQuote.FormClose(Sender: TObject; var Action: TCloseAction);
var iST: integer;
begin

  K_Line_Close();

  TimerSystem.Enabled:= False;
//  if hSKQ <> 0 then iST := SKQuoteLib_LeaveMonitor;
  SKOSQuoteLib1.SKOSQuoteLib_LeaveMonitor();
  SKQuoteLib1.SKQuoteLib_LeaveMonitor();
end;

procedure TfmQuote.btnDownLoadClick(Sender: TObject);
var I: Integer;
    Page: Smallint;
begin
  TotalTickQty:= 0;
  Check_Gate1(cbbStockNO.Text);
  {
  GetOpenOrder();  // 以資料庫方式  獲取未平倉內容 (裡面會判斷是否為 TestMode)
  if(GoStrategy_PreOrder()) then // 前倉單判讀
    PreOrder_Active(cbbStockNO.Text);
    }
  ClearVariable();

  btnKLine.Click; // 取得歷史K現序列, 及日期序列

//  B1_Strategy();
  sStrategy.E3_Light:= 1; // 13:44:00 時進行 E3 處理, 如 E3 = 0, 後面皆不進單

  if KLineGap= 0 then KLineGap:= 60;  // 如果沒有選擇, 以1分鐘現為準

  // 取得初步的 Last SN  LastSN:= DataModule1.AssignSN('TradeRecord');
  LastIndexSN:= DataModule1.AssignSN('IndexTable');

  // 先判斷目前文字檔
  if FileExists('AllTXF00Data_' + cbbStockNO.Text + '.Txt') then begin
   AllSQLList.LoadFromFile('AllTXF00Data_' + cbbStockNO.Text + '.Txt');

   // 判斷是否已載入資料庫
   if AllSQLList.Count > 0 then begin
    TempList.Text:= AllSQLList.Strings[AllSQLList.Count - 1];
    TempList.Delimiter:= ',';
    TempList.DelimitedText:= TempList.Text;
    if ThisTradeDate = TempList.Strings[2] then PrepareData:= True;
    if (LastSN < StrToInt(TempList.Strings[0])) then
    begin
     fmQuote.btnDatabase.Click; // 點擊資料庫存入
     fmQuote.SaveIndexTable(); // 存入 IndexTable
    end;
   end ;
  end;

   // 將今日 TradeReocrd 資料輸出文字檔
  QuickSqliteOutput(DataModule1.asqQU_TradeRecord, 'AllTXF00Data_' + cbbStockNO.Text + '.Txt',
   'select * from TradeRecord where TradeDate="' + ThisTradeDate + '" and StockNO="' + cbbStockNO.Text + '"', ',', True);
  AllSQLList.LoadFromFile('AllTXF00Data_' + cbbStockNO.Text + '.Txt');

  // 將今日 IndexTable 輸出文字檔
  QuickSqliteOutput(DataModule1.asqQU_Index, 'IndexTable_' + cbbStockNO.Text + '.Txt',
   'select * from IndexTable where TradeDate="' + ThisTradeDate + '" and StockNO="' + cbbStockNO.Text + '"', ',', True);

  // 針對歷史資料庫
  if AllSQLList.Count > 0 then
  begin
   TempList.Text:= AllSQLList.Strings[AllSQLList.Count - 1];
   TempList.Delimiter:= ',';
   TempList.DelimitedText:= TempList.Text;
   if ThisTradeDate = TempList.Strings[2] then PrepareData:= True;
  end;

  // 取得最後的 SN
  LastSN:= DataModule1.AssignSN('TradeRecord');
  LastIndexSN:= DataModule1.AssignSN('IndexTable');

  if Trim(cbbStockNO.Text) <> '' then
  begin

    // New COM
      // no hsitory ticks
  //  iSKQStatus := SKQuoteLib1.SKQuoteLib_RequestLiveTick(Page, PChar(WideString(StrockNM_W_Comma)));



    // TX_MX
    // this must be added to get buy / sell qty
    iSKQStatus := SKOSQuoteLib1.SKOSQuoteLib_RequestStocks(Page, PChar(WideString(StrockNM_W_Comma)));
    iSKQStatus := SKQuoteLib1.SKQuoteLib_RequestStocks(Page, PChar(WideString(StrockNM_W_Comma)));

  // with history ticks
    iSKQStatus := SKQuoteLib1.SKQuoteLib_RequestTicks(Page, PChar(WideString(StrockNM_W_Comma)));
    // 海期
    iSKQStatus := SKOSQuoteLib1.SKOSQuoteLib_RequestTicks(Page, PChar(WideString(StrockNM_W_Comma)));
  end;

 // SQLList.Clear; // 每次下載均先清空
  FirstTime:= True;
  LastMinute:= True;
  StopGate:= False; // 立刻下載
end;

{
//繪製歷史K線
procedure TfmQuote.btnHistoryKLineClick(Sender: TObject);
begin
  btnKLine.Click; // 取得歷史K現序列, 及日期序列
  B1_Strategy();
  sStrategy.E3_Light:= 1; // 13:44:00 時進行 E3 處理, 如 E3 = 0, 後面皆不進單

   // 將今日 TradeReocrd 資料輸出文字檔
  QuickSqliteOutput(DataModule1.asqQU_TradeRecord, 'AllTXF00Data_' + cbbStockNO.Text + '.Txt',
   'select * from TradeRecord where TradeDate="' + ThisTradeDate + '" and StockNO="' + cbbStockNO.Text + '"', ',', True);
  AllSQLList.LoadFromFile('AllTXF00Data_' + cbbStockNO.Text + '.Txt');
  TotalQty:= AllSQLList.Count;
  // 將今日 IndexTable 輸出文字檔
  QuickSqliteOutput(DataModule1.asqQU_Index, 'IndexTable_' + cbbStockNO.Text + '.Txt',
   'select * from IndexTable where TradeDate="' + ThisTradeDate + '" and StockNO="' + cbbStockNO.Text + '"', ',', True);

  // 針對歷史資料庫
  if AllSQLList.Count > 0 then begin
   TempList.Text:= AllSQLList.Strings[AllSQLList.Count - 1];
   TempList.Delimiter:= ',';
   TempList.DelimitedText:= TempList.Text;
   if ThisTradeDate = TempList.Strings[2] then GetOriginalData();
  end;
end;
 }

procedure TfmQuote.btnKLineClick(Sender: TObject);
var GiveStockNO: PChar;
    I: Integer;
begin
 iSKQStatus := SKQuoteLib1.SKQuoteLib_RequestKLine(PChar(WideString(StrockNM_W_Comma)), 0, 0);

 // Overseas K Line
 iSKQStatus := SKOSQuoteLib1.SKOSQuoteLib_RequestKLine(PChar(WideString(StrockNM_W_Comma)), 0);

 TempList.Clear;
 K_LineList_Min.SaveToFile('K_LineData_Min.txt');

 K_LineList_Min.Clear;
// iSKQStatus := SKQuoteLib_GetKLine(GiveStockNO, 3); // 取得日線
 iSKQStatus := SKQuoteLib1.SKQuoteLib_RequestKLine(PChar(WideString(StrockNM_W_Comma)), 3, 0);

 // Overseas K Line 日線
 iSKQStatus := SKOSQuoteLib1.SKOSQuoteLib_RequestKLine(PChar(WideString(StrockNM_W_Comma)), 1);


 HistoryKList.Text:= K_LineList_Min.Text;
 HistoryKList.SaveToFile('HistoryKList_Day.txt');

 K_LineList_Min.LoadFromFile('K_LineData_Min.txt'); // 重新載入 K 線
 GetDdate(AveCount);
 fmQuote.lbBalance.Caption:= '當日損益: ' + FloatToStr(GetBalance());
 // 取得過去下單記錄 10 筆
 DataModule1.asqQU_Temp.SQL.Text:= 'select Price, TradeDate, TradeTime from RecordMsg order by TradeDate, TradeTime Desc limit 10';
 DataModule1.asqQU_Temp.Open;
 DataModule1.asqQU_Temp.First;
 if DataModule1.asqQU_Temp.RecordCount > 0 then
  for I := 0 to DataModule1.asqQU_Temp.RecordCount do
  begin
    sK_LineList.OrderList.Add(DataModule1.asqQU_Temp.FieldByName('Price').Text);
    sK_LineList.Order_TimeList.Add(DataModule1.asqQU_Temp.FieldByName('TradeDate').AsString
      + ' ' + DataModule1.asqQU_Temp.FieldByName('TradeTime').AsString);
    DataModule1.asqQU_Temp.Next;
  end;

  Get_D53_D53(6);
end;

procedure TfmQuote.TimerSystemTimer(Sender: TObject);
var sql_str: String;
begin
  if(not InternetConnected) then begin
    DB_Handle.UpdateRestart('1');

    if(Dialog <> nil) then
      FreeAndNil(Dialog);
    Dialog := CreateMessageDialog( '網路斷線, 初始失敗', mtInformation, [mbOK]);
    Dialog.Show;

  end else begin
    sql_str:= 'select * from tbConfigure ';
    DB_GetData.GetFree_Sql(sql_str, DataModule1.asqQU_Temp);
    if(DataModule1.asqQU_Temp.FieldByName('IsRestart').AsString='1') then begin
      DB_Handle.UpdateRestart('0');

      if(Dialog <> nil) then begin
        Dialog.Close;
        FreeAndNil(Dialog);
      end;
      ShellExecute(Handle, nil, PChar(Application.ExeName), nil, nil, SW_SHOWNORMAL);
      Application.Terminate; // or, if this is the main form, simply Close;
    end;

  end;

//  SystemTime:= SKOSQuoteLib1.SKOSQuoteLib_RequestServerTime();
//  SKQuoteLib1.SKQuoteLib_RequestServerTime();

end;
// 按下 "及時監控" timer
procedure TfmQuote.DownLoadTimerTimer(Sender: TObject);
begin
 DownLoadTimer.Enabled:= False;
 btnDownLoad.Click;

end;

// 清除現有資料
procedure TfmQuote.ClearNowData();
begin
 MainChart.Series[0].Clear;
 MainChart.Series[3].Clear;
 MainChart.Series[4].Clear;
 MainChart.Series[5].Clear;
 MainChart.Series[6].Clear;
 MainChart.Series[1].Clear; // 均線
end;

// 每次變動時, 已抓取數量歸零
procedure TfmQuote.cbbStockNOChange(Sender: TObject);
//var getStartTime, getEndTime: String;
begin
 fmChungYi.cbbCommNO.Text:= fmQuote.cbbStockNO.Text;
 TotalTickQty:= 0;
 StrockNM_W_Comma:= stringreplace(cbbStockNO.Text, '__', ',', [rfReplaceAll, rfIgnoreCase]);

 StockHandle.GetStockStartEnd_Str(cbbStockNO.Text);
 edtStart.Text:= Public_Variant.StartTime;
 edtEnd.Text:= Public_Variant.EndTime;


 SKQuoteLib1.SKQuoteLib_LeaveMonitor();
 SKOSQuoteLib1.SKOSQuoteLib_LeaveMonitor();
 if(Public_Variant.FuturOrderType= '期貨') then begin
   SKQuoteLib1.SKQuoteLib_EnterMonitor();
 end else if(Public_Variant.FuturOrderType= '外期') then begin
   SKOSQuoteLib1.SKOSQuoteLib_EnterMonitor();
 //  SKOSQuoteLib1.SKOSQuoteLib_Initialize();
 end;

 SKOrderLib1.SKOrderLib_Initialize();
end;

procedure TfmQuote.cbbStockNODropDown(Sender: TObject);
begin
  StockHandle.GetStockStartEndList(cbbStockNO);
end;

// 1, 3, 5... 分線
procedure TfmQuote.MinuteK_Line();
var I: Integer;
    Test: String;
begin
 // 畫 K Line
  DrawK_Line(TimeToStr(CurrMin), '', '', FloatToStr(OpenP), FloatToStr(CloseP), FloatToStr(NowHigh), FloatToStr(NowLow));
  DrawTrendChart(TimeToStr(CurrMin), IntToStr(MinuteQty), FloatToStr(Ave5P)); // 畫趨勢圖 (均線)
 // 畫收盤價
// MainChart.Series[2].AddXY(StrToTime('08:45:00'), LastClose, '昨收盤價');
// MainChart.Series[2].AddXY(StrToTime('13:45:00'), LastClose, '昨收盤價');
end;

// 畫趨勢圖 TickTimeStr: 時間, QtyStr: 成交量, PriceStr: 成交價
procedure TfmQuote.DrawTrendChart(TickTimeStr, QtyStr, PriceStr: String);
begin
 // 畫成交量
// MainChart.RightAxis.Maximum:= StrToFloat(QtyStr)*3; // 成交量最大值
// MainChart.Series[1].Add(StrToTime(TickTimeStr), StrToFloat(QtyStr));
 MainChart.Series[0].AddXY(StrToTime(TickTimeStr), StrToFloat(PriceStr));
end;

procedure TfmQuote.dtpDateChange(Sender: TObject);
begin
 ThisTradeDate:= DateToStr(dtpDate.Date);
end;

// 畫 K 線 TickTimeStr: 時間, QtyStr: 成交量, PriceStr: 成交價, HighValue: 最高價
//  LowValue: 最低價, OffSet: 位置差距
procedure TfmQuote.DrawK_Line(TickTimeStr, QtyStr, PriceStr, OpenP, CloseP, HighValue, LowValue: String);
var p: TPoint;
    DetDate, getDateTime: TDateTime;
    getTime, Test: TTime;
    Time_Str: String;
begin

  getTime:= StrToTime(TickTimeStr);
  DetDate:= fmQuote.dtpDate.Date;
  Time_Str:= DateToStr(fmQuote.dtpDate.Date);
  DetDate:= StrToDate(Time_Str);
//  Time_Str:= DateTimeToStr(getDateTime);

//  Test:= StrtoTime(TickTimeStr);
  if(StrToTime(TickTimeStr) > StrtoTime('13:50:00')) then begin
    DetDate:= DetDate - 1;
   MainChart.BottomAxis.Maximum:= DetDate + 1 + StrtoTime('13:50:00');
   MainChart.BottomAxis.Minimum:= DetDate + StrtoTime('13:50:00');
  end else begin
    MainChart.BottomAxis.Maximum:= DetDate + StrtoTime('13:50:00');
    MainChart.BottomAxis.Minimum:= DetDate -1 + StrtoTime('13:50:00');
  end;
  getDateTime:= DetDate + getTime;

  Time_Str:= DateTimeToStr(MainChart.BottomAxis.Maximum);
  Time_Str:= DateTimeToStr(MainChart.BottomAxis.Minimum);
  Time_Str:= DateTimeToStr(getDateTime);

{
  if(MainChart.LeftAxis.Maximum < StrToFloat(HighValue) + 5) then
     MainChart.LeftAxis.Maximum:= StrToFloat(HighValue) + 5;

  if(MainChart.LeftAxis.Minimum= 0) then
     MainChart.LeftAxis.Minimum:= StrToFloat(LowValue) - 5;
  if(MainChart.LeftAxis.Minimum > StrToFloat(LowValue) - 5) then
     MainChart.LeftAxis.Minimum:= StrToFloat(LowValue) - 5;
 }

//  MainChart.LeftAxis.Maximum:= sStrategy_new.D67_TodayHighest + 5;
//  MainChart.LeftAxis.Minimum:= sStrategy_new.D68_TodayLowest - 5;

  MainChart.Series[3].AddXY(getDateTime, StrToFloat(OpenP));
  MainChart.Series[4].AddXY(getDateTime, StrToFloat(CloseP));
  MainChart.Series[5].AddXY(getDateTime, StrToFloat(HighValue));
  MainChart.Series[6].AddXY(getDateTime, StrToFloat(LowValue));

 {
  MainChart.Series[3].AddXY(StrToTime(TickTimeStr), StrToFloat(OpenP));
  MainChart.Series[4].AddXY(StrToTime(TickTimeStr), StrToFloat(CloseP));
  MainChart.Series[5].AddXY(StrToTime(TickTimeStr), StrToFloat(HighValue));
  MainChart.Series[6].AddXY(StrToTime(TickTimeStr), StrToFloat(LowValue));
  }
  MainChart.Refresh;
end;

procedure TfmQuote.DrawCross(AX,AY:Integer); {画十字线鼠标}
begin
  With MainChart,Canvas do
    begin
      Pen.Color:=clWhite;        {画笔颜色}
  //    Pen.Style:=CrossHairStyle;        {画笔类型}
      Pen.Mode:=pmXor;                  {如何画线}
      Pen.Width:=1;                     {画笔宽度}
      MoveTo(ax,ChartRect.Top-Height3D);
      LineTo(ax,ChartRect.Bottom-Height3D);
      MoveTo(ChartRect.Left+Width3D,ay);
      LineTo(ChartRect.Right+Width3D,ay);
    end;
end;

procedure TfmQuote.MainChartAfterDraw(Sender: TObject);
var
  XValueNO:integer; {X轴点}
  p: TPoint;
  Temp1, Temp2, Temp3, Temp4: Integer;
begin
 if SQLList.Count >= 1 then
 begin
  for XValueNO:= 0 to SQLList.Count - 1  do
  With MainChart,Canvas do
    begin
     Pen.Style:=pssolid;        {画笔类型}
     Pen.Width:=1;
     Pen.Color:= clWhite;
     if (MainChart.Series[3].CalcyPos(XValueNO) < MainChart.Series[4].CalcyPos(XValueNO)) then
     begin
      Brush.Color:=clgreen;
      Pen.Color:=clgreen;
     end else begin
      Brush.Color:=clRed;
      Pen.Color:=clRed;
     end;

     MoveTo(MainChart.Series[5].CalcXPos(XValueNO) ,MainChart.Series[5].CalcyPos(XValueNO));
     LineTo(MainChart.Series[6].CalcXPos(XValueNO) ,MainChart.Series[6].CalcyPos(XValueNO));
     Rectangle(MainChart.Series[3].CalcXPos(XValueNO)-2,MainChart.Series[3].CalcyPos(XValueNO),
     MainChart.Series[3].CalcXPos(XValueNO)+2,MainChart.Series[4].CalcyPos(XValueNO));
    end;
 end;
end;

procedure TfmQuote.MainChartMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var tmpX,tmpY:Double;
  X_Index: Integer;
  P : TChartClickedPart;
  TimeVal: TTime;
begin
  if (OldX<>-1) then
    begin
      DrawCross(OldX,OldY);   //画小十字鼠标
      OldX:=-1;
    end;
  //检查鼠标是否在图表区
  if PtInRect( MainChart.ChartRect, Point(X-MainChart.Width3D,Y+MainChart.Height3D)) then
    begin
     DrawCross(x,y);   //在当前位置画十字准线
     OldX:=x;   //保存旧位置
     OldY:=y;
     // 計算移動時, 所對應的 X 軸值
     MainChart.Series[0].GetCursorValues(tmpX,tmpY); //取得滑鼠的值
     TimeVal:= StrToTime(MainChart.Series[0].GetHorizAxis.LabelValue(tmpx) + ':00');
     X_Index:= Round((TimeVal - StrToTime('08:45:00'))* 288) - 1;
  //   lbTest.Caption:= IntToStr(X_Index);
     lbTest.Caption:= IntToStr(X_Index + 1);

   //  MainChart.CalcClickedPart(Point(X,Y), P);
   //  X_Index:= P.PointIndex;
     if  (X_Index >= 0) and (SQLList.Count > X_Index) then
     begin
    //  lbTest.Caption:= IntToStr(P.PointIndex);
    //  lbTickTime.Caption:= '時間: ' + TimeToStr(P.ASeries.XValue[X_Index]);
      lbTickTime.Caption:= '時間: ' + TimeToStr(StrToTime(MainChart.Series[0].GetHorizAxis.LabelValue(tmpx)) - 1/288);
      SubAllList.Text:= SQLList.Strings[X_Index];
      SubAllList.Delimiter:= ',';
      SubAllList.DelimitedText:= SubAllList.Text;
      lbOpen.Caption:= '開盤價: ' + SubAllList.Strings[4];
      lbHigh.Caption:= '最高價: ' + SubAllList.Strings[5];
      lbLow.Caption:= '最低價: ' + SubAllList.Strings[6];
      lbClose.Caption:= '收盤價: ' + SubAllList.Strings[7];
     end;
    end;
end;

procedure TfmQuote.btnDataBaseClick(Sender: TObject); // Save TradeRecord Table
var ThreadId, tmpThreadHandle: Cardinal;
    execinfo:   TSHELLEXECUTEINFO;
    par: String;
    FileList: TStringList;
begin  // Dos command: sqlite3 D:\Delphi\Stock_API\FutureOrder_2009\RecordMsg.db3 "select * from UseRecord;"

 FileList:= TStringList.Create;

 FileList.Add('.separator ","');
 FileList.Add('.import AllTXF00Data_' + cbbStockNO.Text + '.Txt TradeRecord');
 FileList.SaveToFile('Sqlite_InputFile.txt');
 FreeAndNil(FileList);
 DataModule1.asqQU_Temp.SQL.Text:= 'delete from TradeRecord where TradeDate="' + DateToStr(fmQuote.dtpDate.Date) + '"';
 DataModule1.asqQU_Temp.Open;
 par:= '/c sqlite3 ' + ExtractFilePath(Application.ExeName) + 'FutureParam.db3 < Sqlite_InputFile.txt';
    FillChar(execinfo,SizeOf(execinfo),0);
    execinfo.cbSize:=sizeof(execinfo);
    execinfo.lpVerb:=nil;
    execinfo.lpParameters := PChar(par);
    execinfo.lpFile:=Pchar('cmd.exe');
    execinfo.fMask:=SEE_MASK_NOCLOSEPROCESS;
    execinfo.nShow:=SW_HIDE;
    ShellExecuteEx(@execinfo);
    WaitForSingleObject(execinfo.hProcess,INFINITE);
end;

procedure TfmQuote.SaveIndexTable();
var ThreadId, tmpThreadHandle: Cardinal;
    execinfo:   TSHELLEXECUTEINFO;
    par: String;
    FileList: TStringList;
begin  // Dos command: sqlite3 D:\Delphi\Stock_API\FutureOrder_2009\RecordMsg.db3 "select * from UseRecord;"
 FileList:= TStringList.Create;

 FileList.Add('.separator ","');
 FileList.Add('.import IndexTable_' + cbbStockNO.Text + '.Txt IndexTable');
 FileList.SaveToFile('Sqlite_InputFile_IndexTable.txt');
 FreeAndNil(FileList);

 DataModule1.asqQU_Temp.SQL.Text:= 'delete from IndexTable where TradeDate="' + DateToStr(fmQuote.dtpDate.Date) + '"';
 DataModule1.asqQU_Temp.Open;
 par:= '/c sqlite3 ' + ExtractFilePath(Application.ExeName) + 'FutureParam.db3 < Sqlite_InputFile_IndexTable.txt';
    FillChar(execinfo,SizeOf(execinfo),0);
    execinfo.cbSize:=sizeof(execinfo);
    execinfo.lpVerb:=nil;
    execinfo.lpParameters := PChar(par);
    execinfo.lpFile:=Pchar('cmd.exe');
    execinfo.fMask:=SEE_MASK_NOCLOSEPROCESS;
    execinfo.nShow:=SW_HIDE;
    ShellExecuteEx(@execinfo);
    WaitForSingleObject(execinfo.hProcess,INFINITE);
end;

procedure TfmQuote.SKQuoteLib1Connection(ASender: TObject; nKind,
  nCode: Integer);
begin
  fmQuote.Memo1.Lines.Add(FormatDateTime('hh:nn:ss:zzz ', now) + '-> ' + '台期報價 連線成功 !!' );
end;

procedure TfmQuote.SKQuoteLib1NotifyServerTime(ASender: TObject; sHour, sMinute,
  sSecond: SmallInt; nTotal: Integer);
begin
  GetServerTime(sHour, sMinute, sSecond);
end;

// 國內 K line data

procedure TfmQuote.SKQuoteLib1NotifyBest5(ASender: TObject; sMarketNo,
  sStockIdx: SmallInt; nBestBid1, nBestBidQty1, nBestBid2, nBestBidQty2,
  nBestBid3, nBestBidQty3, nBestBid4, nBestBidQty4, nBestBid5, nBestBidQty5,
  nExtendBid, nExtendBidQty, nBestAsk1, nBestAskQty1, nBestAsk2, nBestAskQty2,
  nBestAsk3, nBestAskQty3, nBestAsk4, nBestAskQty4, nBestAsk5, nBestAskQty5,
  nExtendAsk, nExtendAskQty, nSimulate: Integer);
begin
sStrategy_new.D61_BestBuyAve:= (nBestBidQty1 + nBestBidQty2 + nBestBidQty3 + nBestBidQty4 + nBestBidQty3)/5;
  sStrategy_new.D62_BestSellAve:= (nBestAskQty1 + nBestAskQty2 + nBestAskQty3 + nBestAskQty4 + nBestAskQty5)/ 5;
end;

procedure TfmQuote.SKQuoteLib1NotifyKLineData(ASender: TObject;
  const bstrStockNo, bstrData: WideString);
var i: Integer;
    getText: String;
    Offset: Integer;
begin
 TempList.Text:= bstrData;
 TempList.Delimiter:= ',';
 TempList.DelimitedText:= TempList.Text;

 Offset:= 0;
 if(TempList.Count= 6) then  // minute K line has 7 column (time coloumn), the others have 6 columns
   Offset:= 1;

 TempList.Strings[0]:= Copy(TempList.Strings[0], 7, 4) + '/' + Copy(TempList.Strings[0], 1, 5);
 for i := 2 - Offset to 5 - Offset do begin
   TempList.Strings[i]:= Copy(TempList.Strings[i], 1, Length(TempList.Strings[i])-2);
 end;


 for i := 0 to TempList.Count - 1 do begin
     if(i > 0) then
       getText:= getText + ',' + TempList.Strings[i]
     else getText:= TempList.Strings[i];
 end;

 K_LineList_Min.Add(getText);
end;

procedure TfmQuote.SKQuoteLib1NotifyHistoryTicks(ASender: TObject; sMarketNo,
  sStockIdx: SmallInt; nPtr, nTimehms, nTimemillismicros, nBid, nAsk, nClose,
  nQty, nSimulate: Integer);
var HistoryTickTime: String;
    i, iSt: Integer;
begin
{
  if(TotalQty > nPtr) then
    exit;

//  SKQuoteLib1.SKQuoteLib_GetStockByIndex(sMarketNo, sStockIdx, SK_New);
//  SKQuoteLib1.SKQuoteLib_GetStockByNo(WideString(StrockNM_W_Comma), SK_New);

  HistoryTickTime:= TimeTransfer(IntToStr(nTimehms));
  TQty_History_OS:= TQty_History_OS + nQty;

  fmQuote.Memo1.Lines.Add('TickTime: ' + HistoryTickTime + '-> Quote : ' +
      intToStr(SK_New.sStockIdx) + ', ' +  intToStr(SK_New.sDecimal) + ', ' +  intToStr(SK_New.sTypeNo) + ', ' +
      SK_New.bstrMarketNo + ', ' +  SK_New.bstrStockNo + ', ' +  SK_New.bstrStockName + ', ' +
      FormatFloat('0.000', SK_New.nOpen / 100) + ', ' +  FormatFloat('0.000', SK_New.nHigh / 100) + ', ' +
      FormatFloat('0.000', SK_New.nLow / 100) + ', ' +   FormatFloat('0.000', SK_New.nClose / 100) + ', ' +
      FormatFloat('0', SK_New.nTickQty) + ', ' +  FormatFloat('0.000', SK_New.nBc / 100) + ', ' +  FormatFloat('0.000', SK_New.nAc / 100) + ', '
      + FormatFloat('0', SK_New.nTQty) + ',' + FormatFloat('0', TQty_History) + ',' + intToStr(nPtr));


  if(nClose > 0) then begin
    getK_Value.NowBuyQty:= 0;
    getK_Value.NowSellQty:= 0;
    InputTicks(sMarketNo, nPtr, SK_New, TK_New, SK_New.bstrStockNo, SK_New.bstrStockName, sStockIdx, true);
  end;
 }
end;

procedure TfmQuote.SKQuoteLib1NotifyTicks(ASender: TObject; sMarketNo,
  sIndex: SmallInt; nPtr, nTimehms, nTimemillismicros, nBid, nAsk, nClose, nQty,
  nSimulate: Integer);

var HistoryTickTime: String;
    i, iSt: Integer;
begin
  HistoryTickTime:= TimeTransfer(IntToStr(nTimehms));

  SKQuoteLib1.SKQuoteLib_GetStockByIndex(sMarketNo, sIndex, SK_New);
//  SKQuoteLib1.SKQuoteLib_GetStockByNo(WideString(StrockNM_W_Comma), SK_New);

//  HistoryTickTime:= TimeTransfer(IntToStr(nTimehms));
  TQty_History_OS:= TQty_History_OS + nQty;


  fmQuote.Memo1.Lines.Add('TickTime: ' + HistoryTickTime + '-> Quote : ' +
      intToStr(SK_New.sStockIdx) + ', ' +  intToStr(SK_New.sDecimal) + ', ' +  intToStr(SK_New.sTypeNo) + ', ' +
      SK_New.bstrMarketNo + ', ' +  SK_New.bstrStockNo + ', ' +  SK_New.bstrStockName + ', ' +
      FormatFloat('0.000', SK_New.nOpen / 100) + ', ' +  FormatFloat('0.000', SK_New.nHigh / 100) + ', ' +
      FormatFloat('0.000', SK_New.nLow / 100) + ', ' +   FormatFloat('0.000', SK_New.nClose / 100) + ', ' +
      FormatFloat('0', SK_New.nTickQty) + ', ' +  FormatFloat('0.000', SK_New.nBc / 100) + ', ' +  FormatFloat('0.000', SK_New.nAc / 100) + ', '
      + FormatFloat('0', SK_New.nTQty) + ',' + FormatFloat('0', TQty_History) + ',' + intToStr(nPtr));


  if(nClose > 0) then begin
    getK_Value.NowBuyQty:= getK_Value.NowBuyQty + SK_New.nBc;
    getK_Value.NowSellQty:= getK_Value.NowSellQty + SK_New.nAc;
    InputTicks(sMarketNo, nPtr, SK_New, TK_New, SK_New.bstrStockNo, SK_New.bstrStockName, sIndex, false);
  end;

end;

// 取得帳號
procedure TfmQuote.SKOrderLib1Account(ASender: TObject; const bstrLogInID,
  bstrAccountData: WideString);
begin
  fmChungYi.AddAccount( WideString(bstrAccountData));
end;

// 查詢期貨未平倉
procedure TfmQuote.SKOrderLib1OpenInterest(ASender: TObject;
  const bstrData: WideString);
begin
 RealReport(WideString( bstrData), 'Interest');
end;

 // 取得商品代碼
procedure TfmQuote.SKOrderLib1OverseaFuture(ASender: TObject;
  const bstrData: WideString);
var ProduictNO: String;
begin
//  ProduictNO:= bstrData;
  TempList.Add(bstrData);
end;

// Best 5
procedure TfmQuote.SKOSQuoteLib1NotifyBest5(ASender: TObject;
  sStockIdx: SmallInt; nBestBid1, nBestBidQty1, nBestBid2, nBestBidQty2,
  nBestBid3, nBestBidQty3, nBestBid4, nBestBidQty4, nBestBid5, nBestBidQty5,
  nBestAsk1, nBestAskQty1, nBestAsk2, nBestAskQty2, nBestAsk3, nBestAskQty3,
  nBestAsk4, nBestAskQty4, nBestAsk5, nBestAskQty5: Integer);
begin
  sStrategy_new.D61_BestBuyAve:= (nBestBidQty1 + nBestBidQty2 + nBestBidQty3 + nBestBidQty4 + nBestBidQty3)/5;
  sStrategy_new.D62_BestSellAve:= (nBestAskQty1 + nBestAskQty2 + nBestAskQty3 + nBestAskQty4 + nBestAskQty5)/ 5;
end;

procedure TfmQuote.SKOSQuoteLib1NotifyServerTime(ASender: TObject; sHour,
  sMinute, sSecond: SmallInt);
var Hr, MM, SS: Integer;
    Today_Str, getDate, temp: String;
begin
 GetServerTime(sHour, sMinute, sSecond);

end;

procedure TfmQuote.GetServerTime(sHour, sMinute, sSecond: SmallInt);
var Hr, MM, SS: Integer;
    Today_Str, getDate: String;
    nowSystemTime: Extended;
begin

 try

  Hr:= sHour;
  MM:= sMinute;
  SS:= sSecond;
  lbSystemTime.Caption:= IntToStr(Hr) + ':' + IntToStr(MM) + ':' + IntToStr(SS);
  nowSystemTime:= StrToTime(lbSystemTime.Caption);
   // 自動下載
  if not HasDone and (nowSystemTime >= StrTotime(Public_Variant.StartTime)) and (nowSystemTime <= StrTotime(Public_Variant.EndTime)) then
  begin
   HasDone:= True;
   DownLoadTimer.Enabled:= True;
  end;

 except
  Sleep(1000);
 end;

 if SpeedTime or ((Hr= 23) and (MM= 59)) then
   SpeedTime:= true
 else
   SpeedTime:= false;

 Today_Str:= DateToStr(fmQuote.dtpDate.Date);
 getDate:= DateToStr(now);
// if(getDate > Today_Str) then
//   fmQuote.dtpDate.Date:= StrtoDate(getDate);
end;

procedure TfmQuote.SKOSQuoteLib1NotifyTicks(ASender: TObject;
  sStockIdx: SmallInt; nPtr, nTime, nClose, nQty: Integer);
var HistoryTickTime: String;
    SK_2: SKSTOCK;
    TK_2: SKTick;
    MarketNO: Integer;
begin
  HistoryTickTime:= TimeTransfer(IntToStr(nTime));
  if TimeLimit(HistoryTickTime) then
    exit;

  SKOSQuoteLib1.SKOSQuoteLib_GetStockByIndex(sStockIdx, ForeingSK);
  SK_2.sStockidx:= sStockIdx;
   SK_2.sDecimal:= ForeingSK.sDecimal;
 //  StrPLCopy(SK_2.bstrStockNo, ForeingSK.bstrStockNo, Length(ForeingSK.bstrStockNo));
 //  StrPLCopy(SK_2.bstrStockName, ForeingSK.bstrStockNo, Length(ForeingSK.bstrStockNo));
   SK_2.nOpen:= ForeingSK.nOpen;
   SK_2.nHigh:= ForeingSK.nHigh;
   SK_2.nLow:= ForeingSK.nLow;
   SK_2.nClose:= ForeingSK.nClose;
   SK_2.nTickQty:= nQty;
   SK_2.nRef:= ForeingSK.nRef;
   SK_2.nBid:= ForeingSK.nBid;
   SK_2.nTQty:= TQty_History;
   SK_2.nAsk:= ForeingSK.nAsk;
   SK_2.nBc:= ForeingSK.nBc;
   SK_2.nAc:= ForeingSK.nAc;

   TK_2.nPtr:= nPtr;
   TK_2.nTimehms:= nTime;
   TK_2.nBid:= ForeingSK.nBid;
   TK_2.nAsk:= ForeingSK.nAsk;
   TK_2.nClose:= nClose;
   TK_2.nQty:= nQty;

   if(ForeingSK.bstrMarketNo <> '') then
     MarketNO:= StrToInt(ForeingSK.bstrMarketNo)
   else MarketNO:= 0;


//  HistoryTickTime:= TimeTransfer(IntToStr(nTime));
  if(ShiftTime <> 0) then
        HistoryTickTime:= TimeToStr(StrToTime(HistoryTickTime) + ShiftTime / 24);
  TQty_History_OS:= TQty_History_OS + nQty;

  fmQuote.Memo1.Lines.Add(FormatDateTime('hh:nn:ss:zzz ', now) + 'TickTime: ' + HistoryTickTime + '-> Quote : ' +
      intToStr(ForeingSK.sStockIdx) + ', ' +  intToStr(ForeingSK.sDecimal) + ', ' +  intToStr(ForeingSK.nDenominator) + ', ' +
      ForeingSK.bstrMarketNo + ', ' +  ForeingSK.bstrStockNo + ', ' +  ForeingSK.bstrStockName + ', ' +
      FormatFloat('0.000', ForeingSK.nOpen / 100) + ', ' +  FormatFloat('0.000', ForeingSK.nHigh / 100) + ', ' +
      FormatFloat('0.000', ForeingSK.nLow / 100) + ', ' +   FormatFloat('0.000', ForeingSK.nClose / 100) + ', ' +
      FormatFloat('0', ForeingSK.nTickQty) + ', ' +   FormatFloat('0.000', ForeingSK.nRef / 100) + ', ' + FormatFloat('0', ForeingSK.nTQty)
       + ',' + intToStr(nPtr));

   if(nClose > 0) then begin
     getK_Value.NowBuyQty:= getK_Value.NowBuyQty + SK_2.nBc;
     getK_Value.NowSellQty:= getK_Value.NowSellQty + SK_2.nAc;

     InputTicks(MarketNO, nPtr, SK_2, TK_2, SK_New.bstrStockNo, ForeingSK.bstrStockName, sStockIdx, false);
   end;

end;


// Overseas connect OK
procedure TfmQuote.SKOSQuoteLib1Connect(ASender: TObject; nCode,
  nSocketCode: Integer);
begin
  fmQuote.Memo1.Lines.Add(FormatDateTime('hh:nn:ss:zzz ', now) + '-> ' + '外期報價 連線成功 !!' );
  SKOSQuoteLib1.SKOSQuoteLib_RequestServerTime();
end;

// Overseas K Line callback
procedure TfmQuote.SKOSQuoteLib1KLineData(ASender: TObject; const bstrStockNo,
  bstrData: WideString);
  var
    i: Integer;
    getText: String;
begin
   TempList.Text:= bstrData;
   TempList.Delimiter:= ',';
   TempList.DelimitedText:= TempList.Text;

   if(TempList.Count= 8) then // there is one more time column
      TempList.Delete(2) // delete the 開盤參考價, make it same as TX100 / TX50
   else  TempList.Delete(1);

   TempList.Strings[0]:= Copy(TempList.Strings[0], 1, 4) + '/' + Copy(TempList.Strings[0], 5, 2) + '/' + Copy(TempList.Strings[0], 7, 2);
   for i := 0 to TempList.Count - 1 do begin
     if(i > 0) then
       getText:= getText + ',' + TempList.Strings[i]
     else getText:= TempList.Strings[i];
   end;
   K_LineList_Min.Add(getText);

end;

// Overseas 查詢傳入帳號目前的未平倉內容
procedure TfmQuote.SKOrderLib1OverseaFutureOpenInterest(ASender: TObject;
  const bstrData: WideString);
begin
  RealReport(WideString(bstrData), 'OverSeas');
end;


procedure TfmQuote.ClearVariable();
begin
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

  AllSQLList.Clear;
  SubAllList.Clear;
  SQLList.Clear;

  AveList.Clear;
  MinuteQtyList.Clear;
  HighList.Clear;
  LowList.Clear;
  K_List.Clear;
  K_OpenList.Clear;
  K_CloseList.Clear;
  sK_LineList.OrderList.Clear;
  sK_LineList.Order_TimeList.Clear;
  if(sK_LineList.K_5_MinuteList <> nil) then
    sK_LineList.K_5_MinuteList.Clear;
  DateList.Clear;
  K_LineList_Min.Clear;

  OrderParamList.Clear;
  HistoryKList.Clear;

  MainChart.LeftAxis.Minimum:= 0;
  sStrategy_new.D67_TodayHighest:= 0;
  sStrategy_new.D68_TodayLowest:= 0;
  TQty_History_OS:= 0;
end;

initialization

finalization
  FreeLibrary(hSKQ);

end.

