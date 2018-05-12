unit ChungYi_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, Grids, DBGrids, ComCtrls,
  ExtCtrls, ToolWin, DBCtrls, Mask, SHDocVw, mshtml, ShellAPI, Public_Variant,
  SKCOMLib_TLB, ComObj, OleServer, StockHandle, OverSeasOrder, String_Handle,
  SQLFunction;

type
  TfmChungYi = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnLogOn: TButton;
    edUserid: TEdit;
    edPassWord: TEdit;
    PageControl_Main: TPageControl;
    tsAccount: TTabSheet;
    ListView1: TListView;
    tsAutoOrder: TTabSheet;
    CoolBar2: TCoolBar;
    Panel3: TPanel;
    btnAutoBuy: TButton;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    cbbCommNO: TComboBox;
    edtQty: TEdit;
    btnBalance: TButton;
    cbAutoBalance: TCheckBox;
    cbbBalance: TComboBox;
    btnOpenInterest: TButton;
    ListView3: TListView;
    tsOrderRecord: TTabSheet;
    Panel5: TPanel;
    Label11: TLabel;
    RecordStart: TDateTimePicker;
    RecordEnd: TDateTimePicker;
    cbRecordDate: TCheckBox;
    DBGrid_Record: TDBGrid;
    tsOpenInterest: TTabSheet;
    StringGrid1: TStringGrid;
    ListV_Interest: TListView;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    edtPrice: TEdit;
    rgTradeType: TRadioGroup;
    rgBuySell: TRadioGroup;
    cbAccount: TComboBox;
    tsParam: TTabSheet;
    Panel2: TPanel;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    Label15: TLabel;
    Label19: TLabel;
    GroupBox6: TGroupBox;
    Label18: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    GroupBox7: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    GroupBox8: TGroupBox;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    dbcbA6: TDBComboBox;
    Label40: TLabel;
    dbrA1: TDBRadioGroup;
    dbcbB_Open: TDBCheckBox;
    dbcbC_Open: TDBCheckBox;
    dbcbD_Open: TDBCheckBox;
    dbcbE_Open: TDBCheckBox;
    Label13: TLabel;
    dbeA11: TDBEdit;
    dbeB1: TDBEdit;
    dbeB2: TDBEdit;
    dbeB3: TDBEdit;
    dbeB5: TDBEdit;
    dbeC1: TDBEdit;
    dbeC2: TDBEdit;
    dbeC3: TDBEdit;
    dbeC4: TDBEdit;
    dbeC5: TDBEdit;
    dbeD1: TDBEdit;
    dbeD2: TDBEdit;
    dbeD3: TDBEdit;
    dbeD4: TDBEdit;
    dbeD6: TDBEdit;
    dbeD7: TDBEdit;
    dbeE1: TDBEdit;
    dbeE3: TDBEdit;
    dbeE7: TDBEdit;
    dbeE8: TDBEdit;
    dbeE9: TDBEdit;
    dbeE11: TDBEdit;
    Label14: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    dbeA7: TDBEdit;
    dbeA8: TDBEdit;
    dbeA9: TDBEdit;
    Label43: TLabel;
    Label44: TLabel;
    dbeA13: TDBEdit;
    dbeA14: TDBEdit;
    dbeC7: TDBEdit;
    dbnaviParam: TDBNavigator;
    DBGrid_Param: TDBGrid;
    dbrgB2or3: TDBRadioGroup;
    dbeD1_1: TDBEdit;
    dbeD3_1: TDBEdit;
    dbeD4_1: TDBEdit;
    Label12: TLabel;
    BalanceTimer: TTimer;
    BackupBuyTimer: TTimer;
    OpenInterestTimer: TTimer;
    lbFail: TLabel;
    dbcbE5: TDBCheckBox;
    dbeD6_1: TDBEdit;
    dbeD5: TDBEdit;
    Label16: TLabel;
    dbeA3: TDBEdit;
    dbeA5: TDBEdit;
    Label17: TLabel;
    dbeA7_1: TDBEdit;
    dbeA8_1: TDBEdit;
    dbeA9_1: TDBEdit;
    dbeA13_1: TDBEdit;
    dbcbA13_Check: TDBCheckBox;
    dbcbA14_Check: TDBCheckBox;
    Label39: TLabel;
    dbeModuleNM: TDBEdit;
    Label46: TLabel;
    dbeDesc: TDBEdit;
    WebBrowser1: TWebBrowser;
    dbeA3_1: TDBEdit;
    dbeA5_1: TDBEdit;
    dbcbA11_Check: TDBCheckBox;
    Label7: TLabel;
    dbckA2_1: TDBCheckBox;
    dbeA2_1_1: TDBEdit;
    Label8: TLabel;
    Label10: TLabel;
    dbckA2_3: TDBCheckBox;
    Label45: TLabel;
    dbckA2_5: TDBCheckBox;
    dbeA2_5_1: TDBEdit;
    tsTrend: TTabSheet;
    Panel6: TPanel;
    dptFigure: TDateTimePicker;
    DBGrid_Figure: TDBGrid;
    comboStockNO: TComboBox;
    Label48: TLabel;
    cbbDate: TCheckBox;
    dbeA4_2: TDBEdit;
    dbeA4_2_1: TDBEdit;
    dbeA4_2_2: TDBEdit;
    dbeC1_1: TDBEdit;
    dbeD6_A: TDBEdit;
    dbrgA4_2or3: TDBRadioGroup;
    dbeA4_3_1: TDBEdit;
    dbeA4_3_2: TDBEdit;
    Label31: TLabel;
    Label4: TLabel;
    dbcbA4_1Check: TDBCheckBox;
    dbcbA4_23Check: TDBCheckBox;
    dtpDeleteS: TDateTimePicker;
    Label47: TLabel;
    dtpDeleteE: TDateTimePicker;
    btnDelete: TButton;
    btnDeleteOrder: TButton;
    dtpDeleteOrderS: TDateTimePicker;
    Label49: TLabel;
    dtpDeleteOrderE: TDateTimePicker;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    lbBuy: TLabel;
    lbSell: TLabel;
    GetDateTimer: TTimer;
    btnCancelByNO: TButton;
    lbDateQty: TLabel;
    cbOpen2: TCheckBox;
    cbOpen3: TCheckBox;
    cbOpen4: TCheckBox;
    cbOpen5: TCheckBox;
    cbOpen1: TCheckBox;
    SKCenterLib1: TSKCenterLib;
    tsTimeScope: TTabSheet;
    Panel4: TPanel;
    dbeStart: TDBEdit;
    dbcheckEnable: TDBCheckBox;
    dbeEnd: TDBEdit;
    Label56: TLabel;
    Label55: TLabel;
    dbeStockNO: TDBEdit;
    Label54: TLabel;
    dbnavStartEnd: TDBNavigator;
    dbgridStartEnd: TDBGrid;
    dbcheckFlag: TDBCheckBox;
    BS_Qty: TDBEdit;
    Label57: TLabel;
    Label58: TLabel;
    dbcomboOrderType: TDBComboBox;
    ccbProduct: TComboBox;
    Label59: TLabel;
    tsParam_New: TTabSheet;
    Panel7: TPanel;
    Label60: TLabel;
    Label61: TLabel;
    dbnNewParam: TDBNavigator;
    dbg_NewParam: TDBGrid;
    dbeModelNM: TDBEdit;
    dbeDesc_new: TDBEdit;
    Group_Special_1: TGroupBox;
    Label63: TLabel;
    Label64: TLabel;
    Label66: TLabel;
    Label68: TLabel;
    dbcSpec_1_Check: TDBCheckBox;
    dbeSpec_1_1: TDBEdit;
    dbeSpec_1_2: TDBEdit;
    dbeSpec_1_3: TDBEdit;
    dbeSpec_1_Rate: TDBEdit;
    GroupPreOrder: TGroupBox;
    Label62: TLabel;
    dbcPreOrder_Check: TDBCheckBox;
    dbePreOrder_Rate: TDBEdit;
    dbePreOrder_1: TDBEdit;
    dbcPreOrder_1_Check: TDBCheckBox;
    dbcPreOrder_2_Check: TDBCheckBox;
    dbePreOrder_2: TDBEdit;
    dbcPreOrder_3_Check: TDBCheckBox;
    dbcPreOrder_4_Check: TDBCheckBox;
    dbcPreOrder_5_Check: TDBCheckBox;
    dbePreOrder_5: TDBEdit;
    Group_Profit: TGroupBox;
    Label65: TLabel;
    dbcProfit_Check: TDBCheckBox;
    dbeProfit_Rate: TDBEdit;
    dbeProfit_1_1: TDBEdit;
    dbcProfit_1_Check: TDBCheckBox;
    dbeProfit_1_2: TDBEdit;
    dbcProfit_2_Check: TDBCheckBox;
    dbeProfit_2_1: TDBEdit;
    dbeProfit_2_2: TDBEdit;
    Label67: TLabel;
    dbeProfit_2_3: TDBEdit;
    dbcProfit_3_Check: TDBCheckBox;
    dbeProfit_3_1_1: TDBEdit;
    Label69: TLabel;
    dbeProfit_3_1_2: TDBEdit;
    Label70: TLabel;
    Label71: TLabel;
    dbeProfit_3_2_1: TDBEdit;
    dbeProfit_3_2_2: TDBEdit;
    Label72: TLabel;
    Label73: TLabel;
    dbeProfit_3_3_1: TDBEdit;
    dbeProfit_3_3_2: TDBEdit;
    Label74: TLabel;
    Label75: TLabel;
    dbeProfit_3_4_1: TDBEdit;
    dbeProfit_3_4_2: TDBEdit;
    Label76: TLabel;
    Label77: TLabel;
    dbeProfit_3_5_1: TDBEdit;
    dbeProfit_3_5_2: TDBEdit;
    Label78: TLabel;
    Group_Special_2: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    dbcSpec_2_Check: TDBCheckBox;
    dbeSpec_2_1: TDBEdit;
    dbeSpec_2_2: TDBEdit;
    dbeSpec_2_3: TDBEdit;
    dbeSpec_2_Rate: TDBEdit;
    Group_InventAnti: TGroupBox;
    Label79: TLabel;
    dbcInventAnti_Check: TDBCheckBox;
    dbeInventAnti_Rate: TDBEdit;
    dbeInventAnti_1: TDBEdit;
    dbcInventAnti_1_Check: TDBCheckBox;
    dbcInventAnti_2_Check: TDBCheckBox;
    dbeInventAnti_2_1: TDBEdit;
    dbeInventAnti_2_2: TDBEdit;
    dbcInventAnti_3_Check: TDBCheckBox;
    dbeInventAnti_3: TDBEdit;
    dbcInventAnti_4_Check: TDBCheckBox;
    dbeInventAnti_4: TDBEdit;
    dbcInventAnti_5_Check: TDBCheckBox;
    dbeInventAnti_5: TDBEdit;
    Group_Float: TGroupBox;
    Label80: TLabel;
    dbcFloat_Check: TDBCheckBox;
    dbeFloat_Rate: TDBEdit;
    dbcFloat_1_Check: TDBCheckBox;
    dbeFloat_1_2: TDBEdit;
    dbcFloat_2_Check: TDBCheckBox;
    dbeFloat_2_1: TDBEdit;
    dbcFloat_3_Check: TDBCheckBox;
    dbeFloat_3_2: TDBEdit;
    Group_Internal: TGroupBox;
    Label81: TLabel;
    dbcInternal_Check: TDBCheckBox;
    dbeInternal_Rate: TDBEdit;
    Group_Engine: TGroupBox;
    Label82: TLabel;
    dbcEngine_Check: TDBCheckBox;
    dbeEngine_Rate: TDBEdit;
    Group_KeepOrder: TGroupBox;
    Label83: TLabel;
    dbcKeepOrder_Check: TDBCheckBox;
    dbeKeepOrder_Rate: TDBEdit;
    dbcKeepOrder_1_Check: TDBCheckBox;
    dbeKeepOrder_1_1: TDBEdit;
    Label84: TLabel;
    dbeKeepOrder_1_2: TDBEdit;
    dbcKeepOrder_2_Check: TDBCheckBox;
    dbcKeepOrder_3_Check: TDBCheckBox;
    dbcKeepOrder_4_Check: TDBCheckBox;
    dbeKeepOrder_4_1: TDBEdit;
    Label85: TLabel;
    dbeKeepOrder_4_2: TDBEdit;
    dbcKeepOrder_5_Check: TDBCheckBox;
    dbcKeepOrder_6_Check: TDBCheckBox;
    tsTableDDE: TTabSheet;
    Panel8: TPanel;
    dbcb_1st_Item: TDBComboBox;
    dbcb_2nd_Item: TDBComboBox;
    dbcb_3rd_Item: TDBComboBox;
    dbcb_4th_Item: TDBComboBox;
    dbg_TradeRecord: TDBGrid;
    dbe_X: TDBEdit;
    dbe_Y: TDBEdit;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    dbe_Z: TDBEdit;
    dbnOption: TDBNavigator;
    grid_Calculate: TStringGrid;
    grid_test: TStringGrid;
    Label90: TLabel;
    grid_3rd_1: TStringGrid;
    dtpChouEnd: TDateTimePicker;
    Label89: TLabel;
    dtpChouStart: TDateTimePicker;
    dbcShowA4: TDBCheckBox;
    btnOuputTable: TButton;
    ChouTimer: TTimer;
    dbeFloat_1_1: TDBEdit;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    dbeFloat_3_1: TDBEdit;
    Label95: TLabel;
    Label96: TLabel;
    dbcFloat_4_Check: TDBCheckBox;
    dbeFloat_4_1: TDBEdit;
    Label97: TLabel;
    dbeFloat_4_2: TDBEdit;
    Label98: TLabel;
    dbcFloat_5_Check: TDBCheckBox;
    dbeFloat_5_1: TDBEdit;
    Label99: TLabel;
    dbcFloat_6_Check: TDBCheckBox;
    dbcInternal_1_Check: TDBCheckBox;
    dbeInternal_1_1: TDBEdit;
    Label100: TLabel;
    dbeInternal_1_2: TDBEdit;
    Label101: TLabel;
    dbcInternal_2_Check: TDBCheckBox;
    dbeInternal_2_1: TDBEdit;
    Label102: TLabel;
    dbeInternal_2_3: TDBEdit;
    Label103: TLabel;
    dbeInternal_2_Rate: TDBEdit;
    Label110: TLabel;
    dbeInternal_2_2: TDBEdit;
    dbcInternal_3_Check: TDBCheckBox;
    dbeInternal_3_1: TDBEdit;
    dbeInternal_3_2: TDBEdit;
    Label109: TLabel;
    dbeInternal_3_3: TDBEdit;
    Label111: TLabel;
    dbeInternal_3_Rate: TDBEdit;
    dbcInternal_4_Check: TDBCheckBox;
    dbcInternal_5_Check: TDBCheckBox;
    dbcInternal_6_Check: TDBCheckBox;
    dbcInternal_7_Check: TDBCheckBox;
    dbeInternal_7_Rate: TDBEdit;
    Label112: TLabel;
    dbcInternal_8_Check: TDBCheckBox;
    dbeInternal_8_Rate: TDBEdit;
    dbcInternal_9_Check: TDBCheckBox;
    dbeInternal_9_Rate: TDBEdit;
    dbcInternal_10_Check: TDBCheckBox;
    dbeInternal_10_1_1: TDBEdit;
    Label114: TLabel;
    dbeInternal_10_1_2: TDBEdit;
    Label115: TLabel;
    dbeInternal_10_1_3: TDBEdit;
    Label113: TLabel;
    Label116: TLabel;
    dbeInternal_10_Rate: TDBEdit;
    Label104: TLabel;
    dbcInternal_11_Check: TDBCheckBox;
    dbeInternal_11_1_1: TDBEdit;
    Label117: TLabel;
    dbeInternal_11_1_2: TDBEdit;
    Label118: TLabel;
    dbeEngine_1_1: TDBEdit;
    Label119: TLabel;
    dbcEngine_2_Check: TDBCheckBox;
    dbeEngine_2_1: TDBEdit;
    Label120: TLabel;
    dbcEngine_3_Check: TDBCheckBox;
    dbeEngine_3_1: TDBEdit;
    Label121: TLabel;
    Label122: TLabel;
    dbeEngine_3_2: TDBEdit;
    dbcEngine_4_Check: TDBCheckBox;
    dbeEngine_4_1: TDBEdit;
    Label123: TLabel;
    dbcEngine_5_Check: TDBCheckBox;
    dbcEngine_6_Check: TDBCheckBox;
    dbeEngine_6_1: TDBEdit;
    Label124: TLabel;
    dbcEngine_7_Check: TDBCheckBox;
    dbeEngine_7_1: TDBEdit;
    Label125: TLabel;
    dbcEngine_8_Check: TDBCheckBox;
    dbeEngine_8_1: TDBEdit;
    Label126: TLabel;
    dbcEngine_9_Check: TDBCheckBox;
    dbeEngine_9_1: TDBEdit;
    Label127: TLabel;
    dbcEngine_10_Check: TDBCheckBox;
    dbeEngine_10_1: TDBEdit;
    Label128: TLabel;
    dbcEngine_11_Check: TDBCheckBox;
    dbeEngine_11_1: TDBEdit;
    Label129: TLabel;
    btnCredit: TButton;
    dbcTestMode: TDBCheckBox;
    dbcEngine_12_Check: TDBCheckBox;
    dbeEngine_12_1: TDBEdit;
    Label130: TLabel;
    dbcEngine_13_Check: TDBCheckBox;
    dbcEngine_14_Check: TDBCheckBox;
    dbeEngine_14_1: TDBEdit;
    Label131: TLabel;
    dbcEngine_15_Check: TDBCheckBox;
    dbeEngine_15_1: TDBEdit;
    Label132: TLabel;
    dbcEngine_16_Check: TDBCheckBox;
    dbeEngine_16_1: TDBEdit;
    Label133: TLabel;
    dbcEngine_17_Check: TDBCheckBox;
    dbeEngine_17_1: TDBEdit;
    Label134: TLabel;
    dbcEngine_18_Check: TDBCheckBox;
    dbeEngine_18_1: TDBEdit;
    Label135: TLabel;
    dbcEngine_19_Check: TDBCheckBox;
    dbeEngine_19_1: TDBEdit;
    Label136: TLabel;
    dbcEngine_20_Check: TDBCheckBox;
    dbeEngine_20_1: TDBEdit;
    Label137: TLabel;
    dbcEngine_21_Check: TDBCheckBox;
    dbeEngine_21_1: TDBEdit;
    Label138: TLabel;
    Label139: TLabel;
    tsDDE_Result: TTabSheet;
    Panel9: TPanel;
    grid_3rd: TStringGrid;
    cbToLast: TCheckBox;
    tableToLast: TCheckBox;
    grid_2nd: TStringGrid;
    SKReplyLib1: TSKReplyLib;
    dbeTimeShit: TDBEdit;
    Label140: TLabel;
    radiog_Period: TRadioGroup;
    dbcEngine_1_Check: TDBCheckBox;
    procedure btnLogOnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAutoBuyClick(Sender: TObject);
    procedure btnOpenInterestClick(Sender: TObject);
    procedure btnBalanceClick(Sender: TObject);
    procedure cbAutoBalanceClick(Sender: TObject);
    procedure BalanceTimerTimer(Sender: TObject);
    procedure BackupBuyTimerTimer(Sender: TObject);
    procedure dbnaviParamClick(Sender: TObject; Button: TNavigateBtn);
 //   procedure NormalOrder(OrderType: String; BuySell: String; OrderParam: String='');
    procedure cbbDateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDeleteOrderClick(Sender: TObject);
    procedure cbbCommNOChange(Sender: TObject);
    procedure edtQtyChange(Sender: TObject);
    procedure GetDateTimerTimer(Sender: TObject);
    procedure btnCancelByNOClick(Sender: TObject);
    procedure cbOpen1Click(Sender: TObject);
    procedure dbnavStartEndClick(Sender: TObject; Button: TNavigateBtn);
    procedure ccbProductDropDown(Sender: TObject);
    procedure ccbProductChange(Sender: TObject);
    procedure dbcTestModeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tsOrderRecordShow(Sender: TObject);
    procedure tsTableDDEShow(Sender: TObject);
    procedure dbcbItemChange(Sender: TObject);
    procedure PageControl_MainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure dbe_XExit(Sender: TObject);
    procedure ChouTimerTimer(Sender: TObject);
    procedure ShowMainTable();
    procedure Num_Only_KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
    procedure tsTableDDEExit(Sender: TObject);
    procedure UpdateGridTable(UpdateOnly: boolean);
    procedure tsDDE_ResultShow(Sender: TObject);
    procedure SKReplyLib1Connect(ASender: TObject; const bstrUserID: WideString;
      nErrorCode: Integer);
    procedure SKReplyLib1Data(ASender: TObject; const bstrUserID,
      bstrData: WideString);
    procedure btnOuputTableClick(Sender: TObject);
    procedure radiog_PeriodClick(Sender: TObject);
    procedure PageControl_MainChange(Sender: TObject);
    procedure SKReplyLib1SolaceReplyDisconnect(ASender: TObject;
      const bstrUserID: WideString; nErrorCode: Integer);


  private
    { Private declarations }
  public
    HtmlFileList: TStringList;
    procedure AddAccount(strAccount: String);
  end;

var
  fmChungYi: TfmChungYi;
  SignalList: TStringList;
  FileName, CurrDir: String;
  BuySellSum: Integer;
  Userid, PassWord: AnsiString;
//  TradeQty: Integer= 0; // 下單口數
  StockAccount, FutureAccount: AnsiString; // 證券帳號
  TimeGate: Integer= 0; // 控制計時只能執行一次
  BalanceGate: Boolean; // 是否手動平倉, 控制 TradeQty

  hSKQ: THandle = 0;
  InsertMode: boolean;
  ShiftTime: Extended;
  HisTable_List: TStringList; // for ras data table

  CheckTimer: Integer;

implementation

uses Registry, RegistryGetSet, DMRecord, DataParsing, Quote,
     String_Form, Quote_uSKQ, Stock_OptionOrder, Strategy, StringList_Fun, SetParameter,
     DB_Handle, DB_Type, getK_Value, AdjustField, Calculate_Grid, TopValue, Strategy_Special,
     K_Line_Save, GeneralValue, SystemFun, OrderHandle, Initial_Setting;

{$R *.dfm}

procedure OnAccount( bstrAccount : PWideChar); stdcall;
begin
   fmChungYi.AddAccount( WideString( bstrAccount));
end;

// 查詢證券即時庫存內容
Procedure OnRealBalanceReport( bstrReport: PWideChar); stdcall;
begin
  RealReport(WideString( bstrReport), 'Stock');
end;
// 查詢傳入帳號目前的未平倉內容
Procedure OnOpenInterest( bstrReport: PWideChar); stdcall;
begin
  RealReport(WideString( bstrReport), 'Interest');
end;

procedure TfmChungYi.FormCreate(Sender: TObject);
var NowStock, NowQty: String;
begin
 fmChungYi.Caption:= '群益下單介面  ' + Public_Variant.Version_Str;
 ShowMainTable();
 TempList:= TStringList.Create;
 TempList.LoadFromFile('Account.txt');
 if TempList.Count = 2 then
 begin
  edUserid.Text:= TempList.Strings[0];
  edPassWord.Text:= TempList.Strings[1];
 end;
 //鎖定程式日期時間格式不受系統變化影響
 Application.UpdateFormatSettings := false;
 //設定程式本身所使用的日期時間格式
 LongDateFormat  := 'yyyy/MM/dd';
 ShortDateFormat := 'yyyy/MM/dd';
 LongTimeFormat  := 'hh:nn:ss';
 ShortTimeFormat := 'hh:nn:ss';
 DateSeparator := '/';
 TimeSeparator := ':';
 // 取得原始紀錄還有 ?天資料
 DataModule1.asqQU_Temp.SQL.Text:= 'select Count(distinct TradeDate) as DateQty from TradeRecord';
 DataModule1.asqQU_Temp.Open;
 lbDateQty.Caption:= '原始紀錄還有 ' + DataModule1.asqQU_Temp.FieldByName('DateQty').Text + ' 天資料';
 HtmlFileList:= TStringList.Create;
 DataModule1.Connection();

 PageControl_Main.ActivePageIndex := 0;
 OpenInterestQty:= 0;
  SignalList:= TStringList.Create;
  BalanceList:= TStringList.Create;

  CurrDir:= GetCurrentDir();

 RecordEnd.Date:= Date;
 BalanceGate:= False;
 sStrategy.C_Order:= False;
 dptFigure.Date:= Date;
 dtpDeleteS.Date:= Date;
 dtpDeleteE.Date:= Date;
 dtpDeleteOrderS.Date:= Date;
 dtpDeleteOrderE.Date:= Date;
 dtpChouStart.Date:= Date;
 dtpChouEnd.Date:= Date;

 // 取得目前產品
 GetNowStock(NowStock, NowQty, ShiftTime);
 cbbCommNO.Text:= NowStock;
 edtQty.Text:= NowQty;
 StockHandle.GetStockStartEnd_Str(cbbCommNO.Text);
// ParameterSetting();
end;

// 取得日期 timer
procedure TfmChungYi.GetDateTimerTimer(Sender: TObject);
var SystemTime: String;
begin // 先取得交易日期

// if(Public_Variant.UserNM= 'MrHuang') then begin
   SystemTime:= FormatDateTime('hh:mm:ss', Time);
   if SystemTime >= Public_Variant.StartTime then begin
     GetDateTimer.Enabled:= False;

    ThisTradeDate:= DateToStr(Date);
    if(Public_Variant.UserNM<> 'JackyChou') then begin
      if DayOfWeek(Date)= 1 then ThisTradeDate:= DateToStr(Date - 2);
      if DayOfWeek(Date)= 7 then ThisTradeDate:= DateToStr(Date - 1);
    end;

    btnLogOn.Click;

    if(Public_Variant.UserNM= 'MrHuang') then begin
      StrategyBegin();
      if(IsSpecial_OrderToday) and GoStrategy_Special_1 then
        Special_1_Active(cbbCommNO.Text);
    end;
   end;
// end;

end;

procedure TfmChungYi.AddAccount( strAccount : String);
var
   Items : TStringList;
   ListItem : TListItem ;
begin
   try
       Items := TStringList.Create;
       SeparateTerms( strAccount, ',', Items);

       // 證券、海外期貨帳號不處理
    //   if (Items[0] = 'OF') then  Exit;
       if ((Items[0] = 'TS') or (Items[0] = 'OF')) then
       begin
        StockAccount:= Items[1]+Items[3]; // 取得證券帳號
        exit
       end;

       if ListView1.FindCaption( 0, Items[3], false, false, true) = nil then
       begin
           ListView1.Items.BeginUpdate;

           ListItem := ListView1.Items.Add;

           ListItem.Caption := Items[3];
           ListItem.SubItems.Add( Items[1]);
           ListItem.SubItems.Add( Items[2]);
           ListItem.SubItems.Add( Items[4]);

           cbAccount.Items.Add( Items[1]+Items[3]);
           FutureAccount:= Items[1]+Items[3]; // 取得期貨帳號
           if cbAccount.ItemIndex = -1 then
               cbAccount.ItemIndex := 0;
       end;
   finally
       ListView1.Items.EndUpdate;

       if Assigned( Items) then Items.Free;
   end;
end;


procedure TfmChungYi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(SignalList) then FreeAndNil(SignalList);
 if Assigned(BalanceList) then FreeAndNil(BalanceList);
 if Assigned(HtmlFileList) then FreeAndNil(HtmlFileList);
 if Assigned(TempList) then FreeAndNil(TempList);
end;


procedure TfmChungYi.btnLogOnClick(Sender: TObject);
var iCode : integer;
    ResultCode: Integer;
    LogInfo: String;
 //   SKCenterLib: SKCenterLib_Class;
begin
   Userid:= Trim(WideString(edUserid.Text));
   PassWord:= Trim(WideString(edPassword.Text));
 {  // 下單初始化
   iCode := SKOrderLib_Initialize(PAnsiChar(Userid) , PAnsiChar(PassWord));
   // 回報初始化, 指定回報連線的使用者登入帳號
   iCode := SKReplyLib_Initialize(PAnsiChar(Userid) , PAnsiChar(PassWord));
   iCode:= RegisterOnConnectCallBack(@OnConnect); // 此時 iCode應 = 1
   iCode := SKReplyLib_ConnectByID(PAnsiChar(Userid));
   }
   // 報價單開啟
   Application.CreateForm(TfmQuote, fmQuote);
   fmQuote.Show;
   fmQuote.edtLogID.Text:= Userid;
   fmQuote.edtPass.Text:= PassWord;

   iCode:= 0;
   if iCode <> SK_SUCCESS then
    ShowMessage( '初始失敗, 代碼: ' + IntToStr( iCode))
   else begin

       fmChungYi.Caption:= '輸入註冊的帳號密碼 (目前 ID 為: ' + edUserid.Text + ')  ' + Public_Variant.Version_Str;
       edUserid.Enabled:= False;
       edPassword.Enabled:= False;

       // new COM API
       // COM part: Login
       ResultCode:= SKCenterLib1.SKCenterLib_Login(WideString(Userid) , WideString(PassWord));
       LogInfo:= SKCenterLib1.SKCenterLib_GetLastLogInfo;


       ResultCode:= fmQuote.SKOrderLib1.SKOrderLib_Initialize();
       iCode:= fmQuote.SKOrderLib1.GetUserAccount;
       iCode := fmQuote.SKOrderLib1.ReadCertByID(PAnsiChar(Userid));
       SKReplyLib1.Connect();
    //   iCode := SKReplyLib1.SKReplyLib_ConnectByID(Userid);

       if(Public_Variant.FuturOrderType= '期貨') then begin
          fmQuote.SKQuoteLib1.SKQuoteLib_EnterMonitor();
       end else if(Public_Variant.FuturOrderType= '外期') then begin
          fmQuote.SKOSQuoteLib1.SKOSQuoteLib_EnterMonitor();
       end;
   //    ResultCode:= fmQuote.SKOrderLib1.SKOrderLib_Initialize();
       ResultCode:= fmQuote.SKOrderLib1.SKOrderLib_LoadOSCommodity();
       ResultCode:= fmQuote.SKOrderLib1.GetOverseaFutures();
       TempList.SaveToFile('OverSea_ProductNO.txt');
       TempList.Clear;

   end;
end;

// 依商品代號取消委託單
procedure TfmChungYi.btnCancelByNOClick(Sender: TObject);
var iCode : integer;
    msg_response: PWideString;
begin
  if(Public_Variant.FuturOrderType= '期貨') then begin
 //   iCode := fmQuote.SKOrderLib1.CancelOrderByStockNo(WideString(Userid), false, WideString(FutureAccount), StrockNM_W_Comma, PWideString(msg_response));
  end else begin
 //   fmQuote.SKOrderLib1.OverSeaCancelOrderBySeqNo(Userid, false, WideString(FutureAccount), WideString(StrockNM_W_Comma), msg_response);
  end;

   if iCode <> SK_SUCCESS then
    ShowMessage( '取消失敗, Code: ' + IntToStr( iCode));
end;

// 刪除原始記錄
procedure TfmChungYi.btnDeleteClick(Sender: TObject);
var ThreadId, tmpThreadHandle: Cardinal;
    execinfo:   TSHELLEXECUTEINFO;
    par, test: String;
begin
 DataModule1.asqQU_Temp.SQL.Text:= 'delete from TradeRecord where TradeDate between "'
   + DateToStr(dtpDeleteS.Date) + '" and "' + DateToStr(dtpDeleteE.Date) +  '"';
 DataModule1.asqQU_Temp.Open;
 par:= '/c sqlite3 ' + ExtractFilePath(Application.ExeName) + '"vacuum;"';
    FillChar(execinfo,SizeOf(execinfo),0);
    execinfo.cbSize:=sizeof(execinfo);
    execinfo.lpVerb:=nil;
    execinfo.lpParameters := PChar(par);
    execinfo.lpFile:=Pchar('cmd.exe');
    execinfo.fMask:=SEE_MASK_NOCLOSEPROCESS;
    execinfo.nShow:=SW_HIDE;
    ShellExecuteEx(@execinfo);
    try
   //   WaitForSingleObject(execinfo.hProcess,INFINITE);
    finally
      test:= '';
    end;


 DataModule1.asqQU_Temp.SQL.Text:= 'select Count(distinct TradeDate) as DateQty from TradeRecord';
 DataModule1.asqQU_Temp.Open;
 lbDateQty.Caption:= '原始紀錄還有 ' + DataModule1.asqQU_Temp.FieldByName('DateQty').Text + ' 天資料';
end;

// 刪除下單記錄
procedure TfmChungYi.btnDeleteOrderClick(Sender: TObject);
begin
 DataModule1.asqQU_Temp.SQL.Text:= 'delete from RecordMsg where TradeDate between "'
   + DateToStr(dtpDeleteOrderS.Date) + '" and "' + DateToStr(dtpDeleteOrderE.Date) +  '"';
 DataModule1.asqQU_Temp.Open;

 DataModule1.asqQU_Record.SQL.Text:= 'select * from RecordMsg';
 DataModule1.asqQU_Record.Open;
end;

// 手動平倉
procedure TfmChungYi.btnBalanceClick(Sender: TObject);
var InvenResult: TInventory_Stock;
begin
 OrderHandle.btnBalance();
end;

procedure TfmChungYi.cbAutoBalanceClick(Sender: TObject);
begin
 if cbAutoBalance.Checked then
 begin
  BalanceTimer.Enabled:= True;
//  cbAutobuy.Checked:= False;
 end else BalanceTimer.Enabled:= False;
 BalanceTimer.Interval:= 1000;
 cbbBalance.Enabled:= not cbAutoBalance.Checked;
end;

// 自動平倉 timer
procedure TfmChungYi.BalanceTimerTimer(Sender: TObject);
begin
 // 判斷自動平倉
 if isnum(Copy(cbbBalance.Text, 1, 2)) and isnum(Copy(cbbBalance.Text, 4, 2))
    and (Copy(cbbBalance.Text, 3, 1)= ':') then
 begin
  if cbbBalance.Text + ':00' = FormatDateTime('hh:mm:ss', Now) then
  begin
   btnBalance.Click;
  end;
  if Copy(TimeToStr(Now), 10, 2)='00' then
   BalanceTimer.Interval:= 60000;
 end;
end;

// 期貨下單
procedure TfmChungYi.btnAutoBuyClick(Sender: TObject);
begin
 OrderType:= 'Order';
 fmChungYi.lbFail.Visible:= False;
 if rgBuySell.ItemIndex= 0 then
   OrderHandle.NormalOrder('Order', 'B')
 else if rgBuySell.ItemIndex= 1 then
   OrderHandle.NormalOrder('Order', 'S');
end;

// 未平倉部位
procedure TfmChungYi.btnOpenInterestClick(Sender: TObject);
begin
  if(Public_Variant.FuturOrderType= '期貨') then
    fmQuote.SKOrderLib1.GetOpenInterest(WideString(Userid), WideString(FutureAccount))
  else if(Public_Variant.FuturOrderType= '外期') then
    fmQuote.SKOrderLib1.GetOverSeaFutureOpenInterest(WideString(Userid), WideString(FutureAccount)) ;
end;

procedure TfmChungYi.btnOuputTableClick(Sender: TObject);
var  Table2_List, Table3_List: TStringList;
begin
  Table2_List:= TStringList.Create;
  Table3_List:= TStringList.Create;
  getAll_Grid(grid_2nd, Table2_List);
  getAll_Grid(grid_3rd, Table3_List);

  Table2_List.SaveToFile(Public_Variant.PathDir + 'table\Table2.txt');
  Table3_List.SaveToFile(Public_Variant.PathDir + 'table\Table3.txt');
  FreeAndNil(Table2_List);
  FreeAndNil(Table3_List);
end;

// 重新下單 timer
procedure TfmChungYi.BackupBuyTimerTimer(Sender: TObject);
begin
 BackupBuyTimer.Enabled:= False;
 btnAutoBuy.Click;
end;


procedure TfmChungYi.PageControl_MainChange(Sender: TObject);
begin
{  if(PageControl_Main.ActivePageIndex <> 8)
    and (PageControl_Main.ActivePageIndex <> 9) then
    if Assigned(HisTable_List) then FreeAndNil(HisTable_List);
    }
end;

procedure TfmChungYi.PageControl_MainChanging(Sender: TObject; var AllowChange: Boolean);
begin
  InsertMode:= false;
  ChouTimer.Enabled:= false;
end;

procedure TfmChungYi.radiog_PeriodClick(Sender: TObject);
begin
  if(radiog_Period.ItemIndex= 0) then begin
    dtpChouStart.Date:= Date;
    dtpChouEnd.Date:= Date;
    dtpChouStart.Enabled:= false;
    dtpChouEnd.Enabled:= false;
  end else begin
    dtpChouStart.Enabled:= true;
    dtpChouEnd.Enabled:= true;
  end;
  tsTableDDEShow(nil);
end;

procedure TfmChungYi.tsTableDDEExit(Sender: TObject);
begin
  GridClear(grid_test);
  grid_test.RowCount:= 2;
end;

procedure TfmChungYi.tsTableDDEShow(Sender: TObject);
var i: Integer;
begin
  DataModule1.asq_Option.Active:= true;
  InsertMode:= true;
  HisTable_List:= TStringList.Create;
  if(radiog_Period.ItemIndex= -1) then begin
    radiog_Period.ItemIndex:= 0;
  end;

  if(radiog_Period.ItemIndex= 0) then begin   // on time
    HisTable_List:= AllSQLList;
  end else begin  // history
    DataModule1.asq_Option.Active:= True;
    DataModule1.asq_Option.Open;
    DataModule1.asqQU_TradeRecord.Active:= True;
{
 DataModule1.asqQU_TradeRecord.SQL.Text:=
   'select * from TradeRecord where StockNO="' + cbbCommNO.Text + '" '
   + ' and TradeDate between "' +  DateToStr(dtpChouStart.Date) + '" and "' + DateToStr(dtpChouEnd.Date) +  '"'
   + ' order by SN asc limit 100000';
  DataModule1.asqQU_TradeRecord.Open;
 }

    QuickSqliteOutput(DataModule1.asqQU_TradeRecord, 'TableRawData_' + cbbCommNO.Text + '.Txt',
    'select * from TradeRecord where TradeDate between "' +  DateToStr(dtpChouStart.Date) + '" and "' + DateToStr(dtpChouEnd.Date) + '" and StockNO="' + cbbCommNO.Text + '"', ',', True);
    HisTable_List.LoadFromFile('TableRawData_' + cbbCommNO.Text + '.Txt');
  end;


  // Table adjust
  grid_Calculate.ColWidths[0]:= 50;
  grid_2nd.ColWidths[0]:= 50;
  grid_3rd.ColWidths[0]:= 50;
  for i := 1 to grid_Calculate.ColCount - 1 do
    grid_Calculate.ColWidths[i]:= 50;
  for i := 1 to grid_2nd.ColCount - 1 do
    grid_2nd.ColWidths[i]:= 50;
  for i := 1 to grid_3rd.ColCount - 1 do
    grid_3rd.ColWidths[i]:= 50;

  grid_Calculate.ColWidths[1]:= 130; // DateTime
  grid_2nd.ColWidths[1]:= 130;
  grid_3rd.ColWidths[1]:= 130;



  MoveField_GridList(dbg_TradeRecord);
  Initial_StringGrid(grid_test, dbcb_1st_Item, dbcb_2nd_Item, dbcb_3rd_Item, dbcb_4th_Item);
  UpdateGridTable(false);
  ChouTimer.Enabled:= true;
end;

procedure TfmChungYi.UpdateGridTable(UpdateOnly: boolean);
var IsShowA4: boolean;
begin
  IsShowA4:= DataModule1.asq_Option.FieldByName('Option5').AsString= 'T';
  RunTable_1st_fromList(grid_Calculate, grid_2nd, grid_3rd,  StrToFloat(dbe_X.Text), StrToFloat(dbe_Y.Text),
      StrToFloat(dbe_Z.Text), IsShowA4, grid_test, UpdateOnly, tableToLast.Checked);
end;

procedure TfmChungYi.tsDDE_ResultShow(Sender: TObject);
begin
//  MoveField_GridList(dbg_TradeRecord);
//  Initial_StringGrid(grid_test, dbcb_1st_Item, dbcb_2nd_Item, dbcb_3rd_Item, dbcb_4th_Item);
  UpdateGridTable(true);
  ChouTimer.Enabled:= true;
end;

procedure TfmChungYi.tsOrderRecordShow(Sender: TObject);
var IsTestMode: String;
begin
  if(DB_Handle.CheckTestMode) then
    IsTestMode:= '1'
  else IsTestMode:= '0';

  DataModule1.asqQU_Record.SQL.Text:= 'select * from RecordMsg where TestMode="' + IsTestMode + '"';
  DataModule1.asqQU_Record.Open;
end;

procedure TfmChungYi.dbcbItemChange(Sender: TObject);
var IsShowA4: boolean;
begin
  tsTableDDEShow(nil);
  {
  IsShowA4:= DataModule1.asq_Option.FieldByName('Option5').AsString= 'T';
  MoveField(dbg_TradeRecord);
  RunTable_1st(dbg_TradeRecord, grid_Calculate, grid_2nd, grid_3rd,
    StrToFloat(dbe_X.Text), StrToFloat(dbe_Y.Text), StrToFloat(dbe_Z.Text), IsShowA4);
  MoveField(dbg_TradeRecord);
  }
end;

procedure TfmChungYi.dbcTestModeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DataModule1.asq_Configu.Edit;
  DataModule1.asq_Configu.Post;
end;


procedure TfmChungYi.Num_Only_KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key<> 48) and (Key<> 49) and (Key<> 50) and (Key<> 51) and (Key<> 52)
      and (Key<> 53) and (Key<> 54) and (Key<> 55) and (Key<> 56)
      and (Key<> 57) and (Key<> 58) and (Key<> 8) and (Key<> 13)
      and (Key<> 37) and (Key<> 38)  and (Key<> 39) and (Key<> 40)
      and (Key<> 229)
      and (Key<> 96) and (Key<> 97) and (Key<> 98) and (Key<> 99) and (Key<> 100) and (Key<> 101) and (Key<> 102) and (Key<> 103)
      and (Key<> 104) and (Key<> 105)
      then // 229 is the right number keypad , 96~105 is the right number keypad
      Key:= 0;
end;

procedure TfmChungYi.dbe_XExit(Sender: TObject);
begin
  if(TDBEDit(Sender).Text= '') then TDBEDit(Sender).Text:= '0';
end;

procedure TfmChungYi.dbnaviParamClick(Sender: TObject; Button: TNavigateBtn);
begin
 if Button = nbInsert then
 begin
  dbnaviParam.BtnClick(nbCancel);
  DataModule1.asqQU_Param.Append;
 end;

end;

procedure TfmChungYi.dbnavStartEndClick(Sender: TObject; Button: TNavigateBtn);
var i, nowRecordNO: Integer;
    NowStock, NowQty: String;
begin
 if Button = nbInsert then begin
   dbnavStartEnd.BtnClick(nbCancel);
   DataModule1.asq_StartEnd.Append;
 end;

 if Button = nbPost then begin
    if(DataModule1.asq_StartEnd.FieldByName('Flag').AsString<> 'True') then
      exit;
    nowRecordNO:= DataModule1.asq_StartEnd.RecNo;
    DataModule1.asq_StartEnd.First;
    for i:= 0 to DataModule1.asq_StartEnd.RecordCount - 1 do begin
      if(DataModule1.asq_StartEnd.RecNo <> nowRecordNO) then begin
        DataModule1.asq_StartEnd.Edit;
        DataModule1.asq_StartEnd.FieldByName('Flag').AsString:= 'False';
        DataModule1.asq_StartEnd.Post;
      end;
      DataModule1.asq_StartEnd.Next;
    end;
    DataModule1.asq_StartEnd.RecNo:= nowRecordNO;

    // 取得目前產品
    GetNowStock(NowStock, NowQty, ShiftTime);
    cbbCommNO.Text:= NowStock;
    edtQty.Text:= NowQty;
    // Must re-start
 //   StockHandle.GetStockStartEnd_Str(cbbCommNO.Text);
 end;

end;

// 記錄目前選擇的產品
procedure TfmChungYi.cbbCommNOChange(Sender: TObject);
begin
// SetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' +  ExtractFilePath(Application.ExeName), 'TX00_MTX00', rdString, cbbCommNO.Text);
 fmQuote.cbbStockNO.Text:= cbbCommNO.Text;
end;

procedure TfmChungYi.edtQtyChange(Sender: TObject);
begin
 SetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'edtQty', rdString, edtQty.Text);
end;

procedure TfmChungYi.cbOpen1Click(Sender: TObject);
var CheckState: String;
begin
 if TCheckbox(Sender).Checked then CheckState:= 'T' else CheckState:= 'F';
 SetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), TCheckbox(Sender).Name, rdString, CheckState);
end;

procedure TfmChungYi.ccbProductChange(Sender: TObject);
var sql_str: String;
begin
  if ccbProduct.Text= '全部' then
    sql_str:= 'select * from RecordMsg'
  else sql_str:= 'select * from RecordMsg where StockNM= "' + ccbProduct.Text + '"'  ;

  DataModule1.asqQU_Record.SQL.Text:= sql_str;
  DataModule1.asqQU_Record.Open;
end;

procedure TfmChungYi.ccbProductDropDown(Sender: TObject);
var sql_str: String;
begin
  ccbProduct.Items.Clear;
  sql_str:= 'select distinct StockNM from RecordMsg ';
  getList_fromDB(DataModule1.asqQU_Temp, sql_str, 'StockNM', ccbProduct);
  ccbProduct.Items.Add('全部');
end;

procedure TfmChungYi.ChouTimerTimer(Sender: TObject);
var SQL_Str, temp_str: String;
    Filed_Index: TIntegerArray;
begin

 Filed_Index:= MoveField_GridList(dbg_TradeRecord);

 if(HisTable_List= nil) then
   Abort;

  if(not ChkNumStr(stringreplace(dbe_X.Text, '-', '', [rfReplaceAll, rfIgnoreCase]))
     or not ChkNumStr(stringreplace(dbe_Y.Text, '-', '', [rfReplaceAll, rfIgnoreCase]))
     or not ChkNumStr(stringreplace(dbe_Z.Text, '-', '', [rfReplaceAll, rfIgnoreCase]))) then
    abort;
  InsertData_Grid(grid_test, HisTable_List, Filed_Index, cbToLast.Checked);

  UpdateGridTable(true);
end;

procedure TfmChungYi.cbbDateClick(Sender: TObject);
begin
 if cbbDate.Checked then
  DataModule1.asqQU_Figure.SQL.Text:= 'select * from Figure where TradeDate="' + DateToStr(dptFigure.Date)
     + '" and StockNO="' + comboStockNO.Text + '"'
 else DataModule1.asqQU_Figure.SQL.Text:= 'select * from Figure where StockNO="' + comboStockNO.Text + '"';

 DataModule1.asqQU_Figure.Open;
end;

procedure TfmChungYi.ShowMainTable();
begin
  Initial_Setting.Initial_UI();

end;

// 回報部分, 連接
procedure TfmChungYi.SKReplyLib1Connect(ASender: TObject;
  const bstrUserID: WideString; nErrorCode: Integer);
begin
//  ShowMessage( '代碼: ' + IntToStr(nErrorCode)) ;
end;

// 委託回報
procedure TfmChungYi.SKReplyLib1Data(ASender: TObject; const bstrUserID,
  bstrData: WideString);
begin
  TradeReportParsing(WideString(bstrData));
end;

procedure TfmChungYi.SKReplyLib1SolaceReplyDisconnect(ASender: TObject;
  const bstrUserID: WideString; nErrorCode: Integer);
begin
  DB_Handle.UpdateRestart('1');
end;

end.
