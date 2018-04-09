unit ChungYi_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, Grids, DBGrids, ComCtrls,
  ExtCtrls, ToolWin, DBCtrls, Mask, SHDocVw, mshtml, ShellAPI, Public_Variant,
  SKCOMLib_TLB, ComObj, OleServer, StockHandle, OverSeasOrder, String_Handle;

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
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ListView1: TListView;
    TabSheet2: TTabSheet;
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
    TabSheet3: TTabSheet;
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
    btnCredit: TButton;
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
    tabSheetTimeScope: TTabSheet;
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
    dbcTestMode: TDBCheckBox;
    tsParameter: TTabSheet;
    Panel7: TPanel;
    Label60: TLabel;
    Label61: TLabel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DBEdit51: TDBEdit;
    DBEdit52: TDBEdit;
    GroupBox10: TGroupBox;
    Label63: TLabel;
    Label64: TLabel;
    Label66: TLabel;
    Label68: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit6: TDBEdit;
    GroupBox9: TGroupBox;
    Label62: TLabel;
    DBCheckBox2: TDBCheckBox;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBEdit7: TDBEdit;
    DBCheckBox5: TDBCheckBox;
    DBEdit8: TDBEdit;
    DBCheckBox6: TDBCheckBox;
    DBEdit9: TDBEdit;
    DBCheckBox7: TDBCheckBox;
    DBEdit10: TDBEdit;
    GroupBox14: TGroupBox;
    Label65: TLabel;
    DBCheckBox8: TDBCheckBox;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBCheckBox9: TDBCheckBox;
    DBEdit13: TDBEdit;
    DBCheckBox14: TDBCheckBox;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    Label67: TLabel;
    DBEdit16: TDBEdit;
    DBCheckBox15: TDBCheckBox;
    DBEdit17: TDBEdit;
    Label69: TLabel;
    DBEdit18: TDBEdit;
    Label70: TLabel;
    Label71: TLabel;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    Label72: TLabel;
    Label73: TLabel;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    Label74: TLabel;
    Label75: TLabel;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    Label76: TLabel;
    Label77: TLabel;
    DBEdit25: TDBEdit;
    DBEdit53: TDBEdit;
    Label78: TLabel;
    GroupBox15: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    DBCheckBox16: TDBCheckBox;
    DBEdit54: TDBEdit;
    DBEdit55: TDBEdit;
    DBEdit56: TDBEdit;
    DBEdit57: TDBEdit;
    GroupBox11: TGroupBox;
    Label79: TLabel;
    DBCheckBox10: TDBCheckBox;
    DBEdit26: TDBEdit;
    DBEdit27: TDBEdit;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox17: TDBCheckBox;
    DBEdit28: TDBEdit;
    DBCheckBox19: TDBCheckBox;
    DBEdit30: TDBEdit;
    DBCheckBox20: TDBCheckBox;
    DBEdit31: TDBEdit;
    DBCheckBox18: TDBCheckBox;
    DBEdit29: TDBEdit;
    DBCheckBox21: TDBCheckBox;
    DBEdit32: TDBEdit;
    GroupBox12: TGroupBox;
    Label80: TLabel;
    DBCheckBox22: TDBCheckBox;
    DBEdit33: TDBEdit;
    DBCheckBox23: TDBCheckBox;
    DBCheckBox24: TDBCheckBox;
    DBEdit35: TDBEdit;
    DBCheckBox25: TDBCheckBox;
    DBEdit36: TDBEdit;
    DBCheckBox26: TDBCheckBox;
    DBEdit37: TDBEdit;
    DBCheckBox27: TDBCheckBox;
    DBEdit38: TDBEdit;
    DBCheckBox28: TDBCheckBox;
    DBEdit39: TDBEdit;
    GroupBox13: TGroupBox;
    Label81: TLabel;
    DBCheckBox12: TDBCheckBox;
    DBEdit34: TDBEdit;
    DBCheckBox13: TDBCheckBox;
    DBCheckBox29: TDBCheckBox;
    DBEdit40: TDBEdit;
    DBCheckBox30: TDBCheckBox;
    DBEdit41: TDBEdit;
    DBCheckBox31: TDBCheckBox;
    DBEdit42: TDBEdit;
    DBCheckBox32: TDBCheckBox;
    DBEdit43: TDBEdit;
    DBCheckBox33: TDBCheckBox;
    DBEdit44: TDBEdit;
    GroupBox16: TGroupBox;
    Label82: TLabel;
    DBCheckBox34: TDBCheckBox;
    DBEdit45: TDBEdit;
    DBCheckBox35: TDBCheckBox;
    DBCheckBox36: TDBCheckBox;
    DBEdit46: TDBEdit;
    DBCheckBox37: TDBCheckBox;
    DBEdit47: TDBEdit;
    DBCheckBox38: TDBCheckBox;
    DBEdit48: TDBEdit;
    DBCheckBox39: TDBCheckBox;
    DBEdit49: TDBEdit;
    DBCheckBox40: TDBCheckBox;
    DBEdit50: TDBEdit;
    GroupBox17: TGroupBox;
    Label83: TLabel;
    DBCheckBox41: TDBCheckBox;
    DBEdit58: TDBEdit;
    DBCheckBox43: TDBCheckBox;
    DBEdit59: TDBEdit;
    Label84: TLabel;
    DBEdit60: TDBEdit;
    DBCheckBox42: TDBCheckBox;
    DBCheckBox44: TDBCheckBox;
    DBCheckBox45: TDBCheckBox;
    DBEdit61: TDBEdit;
    Label85: TLabel;
    DBEdit62: TDBEdit;
    DBCheckBox46: TDBCheckBox;
    DBCheckBox47: TDBCheckBox;
    TabSheet4: TTabSheet;
    Panel8: TPanel;
    dbcb_1st_Item: TDBComboBox;
    procedure btnLogOnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAutoBuyClick(Sender: TObject);
    procedure btnOpenInterestClick(Sender: TObject);
    procedure btnCreditClick(Sender: TObject);
    procedure btnBalanceClick(Sender: TObject);
    procedure cbAutoBalanceClick(Sender: TObject);
    procedure BalanceTimerTimer(Sender: TObject);
    procedure BackupBuyTimerTimer(Sender: TObject);
    procedure OpenInterestTimerTimer(Sender: TObject);
    procedure dbnaviParamClick(Sender: TObject; Button: TNavigateBtn);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure NormalOrder(OrderType: String; BuySell: String; OrderParam: String='');
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
    procedure dbnConfigureClick(Sender: TObject; Button: TNavigateBtn);
    procedure dbcTestModeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tsOrderRecordShow(Sender: TObject);

  private
    { Private declarations }
  public
    HtmlFileList: TStringList;
    procedure AddAccount(strAccount: String);
  end;

  function SKOrderLib_Initialize( Name: PAnsiChar; Password: PAnsiChar) : integer; stdcall; external Public_Variant.SKOrderLib;
  function RegisterOnAccountCallBack( CallBack : Pointer) : integer; stdcall; external Public_Variant.SKOrderLib;
  function GetUserAccount() : integer; stdcall; external Public_Variant.SKOrderLib;
  function SKOrderLib_ReadCertByID( ID: PAnsiChar) : integer; stdcall; external Public_Variant.SKOrderLib;
  // 期貨委託
  function SendFutureOrder( Account: PAnsiChar; Symbol : PAnsiChar; TradeType : Smallint;
       DayTrade : Smallint; BuySell : Smallint; Price : PAnsiChar; iQty: Integer;
       Msg : PAnsiChar; MsgLen : PInt) : integer; stdcall; external Public_Variant.SKOrderLib;
  // 證券委託
  function SendStockOrder( Account: PAnsiChar; Symbol : PAnsiChar; intPeriod : Smallint;
       intFlag : Smallint; BuySell : Smallint; Price : PAnsiChar; iQty: Integer;
       Msg : PAnsiChar; MsgLen : PInt) : integer; stdcall; external Public_Variant.SKOrderLib;
  // 選擇權委託
  function SendOptionOrder( Account: PAnsiChar; Symbol : PAnsiChar; TradeType : Smallint;
       DayTrade : Smallint; BuySell : Smallint; Price : PAnsiChar; iQty: Integer;
       Msg : PAnsiChar; MsgLen : PInt) : integer; stdcall; external Public_Variant.SKOrderLib;
  function CancelOrderBySeqNo( Account: PAnsiChar; OrderNo: PAnsiChar): integer; stdcall; external Public_Variant.SKOrderLib;
  function CancelOrderByStockNo( Account: PAnsiChar; Symbol: PAnsiChar): integer; stdcall; external Public_Variant.SKOrderLib;

  // 查詢傳入帳號目前的未平倉內容
  function GetOpenInterest(Account: PAnsiChar): integer; stdcall; external Public_Variant.SKOrderLib;
  function RegisterOnOpenInterestCallBack(CallBack : Pointer) : integer; stdcall; external Public_Variant.SKOrderLib;
  // 查詢證券即時庫存內容
  function GetRealBalanceReport(Account: PAnsiChar): integer; stdcall; external Public_Variant.SKOrderLib;
  function RegisterOnRealBalanceReportCallBack(CallBack : Pointer) : integer; stdcall; external Public_Variant.SKOrderLib;

  // 停損單處理
  function RegisterOnStopLossReportCallBack( CallBack : Pointer) : integer; stdcall; external Public_Variant.SKOrderLib;
  function GetStopLossReport(Account: PAnsiChar; RequestType:integer; Kind: PAnsiChar) : integer; stdcall; external Public_Variant.SKOrderLib;
  function SendFutureStopLoss( Account: PAnsiChar; Symbol : PAnsiChar; TradeType : Smallint;
       DayTrade : Smallint; BuySell : Smallint; Price : PAnsiChar; iQty: Integer;
       TriggerPrice : PAnsiChar; Msg : PAnsiChar; MsgLen : PInt) : integer; stdcall; external Public_Variant.SKOrderLib;
  // 根據查詢回來的停損單內容做取消
  function CancelFutureStopLoss( Account, BookNo, Symbol, BuySell, Price, Qty,
       TriggerPrice, TradeType, DayTrade:PAnsiChar;  Msg: PAnsiChar; MsgLen: PInt) : integer; stdcall; external Public_Variant.SKOrderLib;

 // 回報部分
  function SKReplyLib_Initialize( Name: PAnsiChar; Password: PAnsiChar) : integer; stdcall; external Public_Variant.SKReplyLib;
  function SKReplyLib_ConnectByID(Name: PAnsiChar) : integer; stdcall; external Public_Variant.SKReplyLib;
  function SKReplyLib_CloseByID(Name: PAnsiChar) : integer; stdcall; external Public_Variant.SKReplyLib;
  function RegisterOnConnectCallBack(CallBack : Pointer) : integer; stdcall; external Public_Variant.SKReplyLib;
  function RegisterOnDataCallBack(CallBack : Pointer) : integer; stdcall; external Public_Variant.SKReplyLib;

var
  fmChungYi: TfmChungYi;
  SignalList, DateList: TStringList;
  FileName, CurrDir: String;
  BuySellSum: Integer;
  Userid, PassWord: AnsiString;
  TradeQty: Integer= 0; // 下單口數
  StockAccount, FutureAccount: AnsiString; // 證券帳號
  TimeGate: Integer= 0; // 控制計時只能執行一次
  BalanceGate: Boolean; // 是否手動平倉, 控制 TradeQty

  hSKQ: THandle = 0;

implementation

uses Registry, RegistryGetSet, DMRecord, DataParsing, Quote,
     String_Form, Quote_uSKQ, Stock_OptionOrder, Strategy, StringList_Fun, SetParameter,
     DB_Handle, DB_Type, getK_Value;

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

// 回報部分, 連接
Procedure OnConnect(bstrReport: PWideChar; ErrorCode: Integer); stdcall;
begin
 GetAccount_Error(WideString(bstrReport), ErrorCode);
end;

Procedure OnData(bstrReport: PWideChar); stdcall;
begin
   TradeReportParsing(WideString(bstrReport));
end;

procedure TfmChungYi.FormCreate(Sender: TObject);
var NowStock, NowQty: String;
begin
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

 PageControl1.ActivePageIndex := 0;
 OpenInterestQty:= 0;
  SignalList:= TStringList.Create;
  DateList:= TStringList.Create;
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

 // 取得目前產品
 GetNowStock(NowStock, NowQty);
 if(NowStock= '') then
   NowStock:= 'TX00';
 cbbCommNO.Text:= NowStock;
 edtQty.Text:= NowQty;
 StockHandle.GetStockStartEnd_Str(NowStock);
// ParameterSetting();
end;


// 取得日期 timer
procedure TfmChungYi.GetDateTimerTimer(Sender: TObject);
var SystemTime: String;
begin // 先取得交易日期
 SystemTime:= FormatDateTime('hh:mm:ss', Time);

// if SystemTime >= '08:41:00' then
 if SystemTime >= Public_Variant.StartTime then
 begin
  GetDateTimer.Enabled:= False;
 // WebBrowser1.Navigate('http://tw.futures.finance.yahoo.com/future/l/future_1.html');
  ThisTradeDate:= DateToStr(Date);
  if DayOfWeek(Date)= 1 then ThisTradeDate:= DateToStr(Date - 2);
  if DayOfWeek(Date)= 7 then ThisTradeDate:= DateToStr(Date - 1);
  btnLogOn.Click;
 end;
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
 if Assigned(DateList) then FreeAndNil(DateList);
 if Assigned(BalanceList) then FreeAndNil(BalanceList);
 if Assigned(HtmlFileList) then FreeAndNil(HtmlFileList);
 if Assigned(TempList) then FreeAndNil(TempList);
end;

procedure TfmChungYi.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
{
 Sleep(1000);
 if btnLogOn.Enabled= False then
 begin
  HtmlFileList.Add(Webbrowser1.OleObject.document.body.OuterHtml);
  // 判斷日期
  ThisTradeDate:= LineGetbetweenStr(HtmlFileList.Text, '距離台股開盤還有', 0, 0, '>', '" 0')[0];
  if ThisTradeDate= '' then ThisTradeDate:= LineGetbetweenStr(HtmlFileList.Text, '資料日期', 0, 0, '資料日期： ', ' ')[0];
  if ThisTradeDate= '' then
  begin
   if DayOfWeek(Date)= 1 then fmQuote.dtpDate.DateTime:= Date - 2;
   if DayOfWeek(Date)= 7 then fmQuote.dtpDate.DateTime:= Date - 1;
   ThisTradeDate:= DateToStr(fmQuote.dtpDate.DateTime);
  end;
  btnLogOn.Enabled:= True;
  if TempList.Count = 2 then btnLogOn.Click;
 end;     }
end;

procedure TfmChungYi.btnLogOnClick(Sender: TObject);
var iCode : integer;
    ResultCode: Integer;
    LogInfo: String;
 //   SKCenterLib: SKCenterLib_Class;
begin
   Userid:= Trim(AnsiString(edUserid.Text));
   PassWord:= Trim(AnsiString(edPassword.Text));
   // 下單初始化
   iCode := SKOrderLib_Initialize(PAnsiChar(Userid) , PAnsiChar(PassWord));
   // 回報初始化, 指定回報連線的使用者登入帳號
   iCode := SKReplyLib_Initialize(PAnsiChar(Userid) , PAnsiChar(PassWord));
   iCode:= RegisterOnConnectCallBack(@OnConnect); // 此時 iCode應 = 1
   iCode := SKReplyLib_ConnectByID(PAnsiChar(Userid));
   // 報價單開啟
   Application.CreateForm(TfmQuote, fmQuote);
   fmQuote.Show;
   fmQuote.edtLogID.Text:= Userid;
   fmQuote.edtPass.Text:= PassWord;
   fmQuote.btnLogin.Click;

   if iCode <> SK_SUCCESS then
    ShowMessage( '初始失敗, 代碼: ' + IntToStr( iCode))
   else begin
       if(ResultCode<> 0) then
         ShowMessage( '初始失敗, 代碼: ' + IntToStr( ResultCode));


      // ShowMessage('帳號初始成功!');
       RegisterOnAccountCallBack(@OnAccount);
       // 讀取帳號
       GetUserAccount;
       // 讀取憑證
       btnCreditClick(nil);

       // 委託回報
       iCode:= RegisterOnDataCallBack(@OnData); // 此時 iCode應 = 1
       // 註冊未平倉及證券庫存
    //   iCode:= RegisterOnOpenInterestCallBack(@OnOpenInterest);
    //   iCode:= iCode + RegisterOnRealBalanceReportCallBack(@OnRealBalanceReport);
       // 獲取未平倉內容
     //  fmChungYi.OpenInterestTimer.Enabled:= True;
     //  GetOpenInterest(PAnsiChar(AnsiString(FutureAccount)));
       fmChungYi.Caption:= '輸入註冊的帳號密碼 (目前 ID 為: ' + edUserid.Text + ')';
       edUserid.Enabled:= False;
       edPassword.Enabled:= False;

       // new COM API
       // COM part: Login
       ResultCode:= SKCenterLib1.SKCenterLib_Login(WideString(Userid) , WideString(PassWord));
       LogInfo:= SKCenterLib1.SKCenterLib_GetLastLogInfo;


       ResultCode:= fmQuote.SKOrderLib1.SKOrderLib_Initialize();
       iCode:= fmQuote.SKOrderLib1.GetUserAccount;
       iCode := fmQuote.SKOrderLib1.ReadCertByID(PAnsiChar(Userid));

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
begin
   iCode := CancelOrderByStockNo( PAnsiChar(AnsiString(cbAccount.Text)), PAnsiChar(AnsiString(cbbCommNO.Text)));
   if iCode <> SK_SUCCESS then
    ShowMessage( '取消失敗, Code: ' + IntToStr( iCode));
end;

procedure TfmChungYi.btnCreditClick(Sender: TObject);
var iCode : integer;
begin
   iCode := SKOrderLib_ReadCertByID(PAnsiChar(Userid));

   if iCode <> SK_SUCCESS then
   begin
    ShowMessage('憑證讀取失敗, 代碼: ' + IntToStr( iCode));
   end else begin
   // ShowMessage('憑證讀取成功!');
   end;
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

 OrderType:= 'Balance';
 InvenResult:= DB_Handle.CheckInventory(cbbCommNO.Text);

 if InvenResult.LeftQty > 0 then begin
  if InvenResult.LastBuySell = 'B' then fmChungYi.NormalOrder('Balance', 'S', 'Manual')
  else fmChungYi.NormalOrder('Balance', 'B', 'Manual');
 end else begin
   ShowMessage('無留倉單');
 end;
end;

// 下單參數
procedure TfmChungYi.NormalOrder(OrderType: String; BuySell: String; OrderParam: String='');
var J: Integer;
    InvenResult: TInventory_Stock;
    LeftQty: Integer;
begin
   if(edtQty.Text= '') then
     edtQty.Text:= '1';
   InvenResult:= DB_Handle.CheckInventory(cbbCommNO.Text);

//   if TickTime < '13:44:01' then begin// 13:44:01 以後不下單
   if TickTime < Public_Variant.EndTime then begin// 13:44:01 以後不下單
     KeepListData(); // 保留檢查資料
     if (edtQty.Text= '0') or (edtQty.Text= '') then edtQty.Text:= '1';

     if BuySell= 'B' then begin
       rgBuySell.ItemIndex:= 0;
       NowBuySell:= 'B';
      end;
     if BuySell= 'S' then begin
       rgBuySell.ItemIndex:= 1;
       NowBuySell:= 'S';
      end;
   end else
     exit;

    OrderParamList.Add(TickTime + ',' + BuySell + ',' + FloatToStr(CloseP) + ',' + OrderParam);
    OrderParamList.SaveToFile('OrderParamList.txt');


    if InvenResult.LeftQty > 0 then begin// 有庫存
      if OrderType= 'Balance' then begin// 平倉 // NowBuySell 表目前庫存
        TradeQty:= InvenResult.LeftQty;
      //  NowBuySell:= ''; // 平倉時, NowBuySell 清空, 新倉則在下面註記
      end;

      if OrderType= 'Order' then begin  // 反向單
        TradeQty:= StrToInt(edtQty.Text) + InvenResult.LeftQty;
      end;

      if(InvenResult.LastBuySell='S') then begin
        rgBuySell.ItemIndex:= 0;
        NowBuySell:= 'B'
      end else if(InvenResult.LastBuySell='B') then begin
        rgBuySell.ItemIndex:= 1;
        NowBuySell:= 'S';
      end;

    end else begin   // 無庫存, 只能新倉
      cbbCommNO.Text:= cbbCommNO.Text;
      TradeQty:= StrToInt(edtQty.Text);
      NowBuySell:= BuySell;
    end;

    LeftQty:= TradeQty - InvenResult.LeftQty;
    if(Public_Variant.FuturOrderType= '期貨') then
      FutureOrder(LeftQty, NowBuySell, TradeQty)
    else if(Public_Variant.FuturOrderType= '外期') then
      OverSeasOrder.OverseasFutureOrder(CloseP, LeftQty, NowBuySell, TradeQty);

    BreakLoop:= True; // 下完單後, 下單跳離設為 True
    A13LowReturn:= False;
    A13HighReturn:= False;
    B_OrderOK:= False; // 一下單後, B_OrderOK 立刻轉為 false, 反反向不可下單

    Get_D53_D53(6);
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
   NormalOrder('Order', 'B')
 else if rgBuySell.ItemIndex= 1 then
   NormalOrder('Order', 'S');
end;

// 未平倉部位
procedure TfmChungYi.btnOpenInterestClick(Sender: TObject);
begin
// GetOpenInterest(PAnsiChar(AnsiString(FutureAccount)));
  if(Public_Variant.FuturOrderType= '期貨') then
    fmQuote.SKOrderLib1.GetOpenInterest(WideString(Userid), WideString(FutureAccount))
  else if(Public_Variant.FuturOrderType= '外期') then
    fmQuote.SKOrderLib1.GetOverSeaFutureOpenInterest(WideString(Userid), WideString(FutureAccount)) ;
end;

// 重新下單 timer
procedure TfmChungYi.BackupBuyTimerTimer(Sender: TObject);
begin
 BackupBuyTimer.Enabled:= False;
 btnAutoBuy.Click;
end;

// 獲取未平倉內容 timer
procedure TfmChungYi.OpenInterestTimerTimer(Sender: TObject);
begin
 GetOpenInterest(PAnsiChar(AnsiString(FutureAccount)));
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

procedure TfmChungYi.dbcTestModeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DataModule1.asq_Configu.Edit;
  DataModule1.asq_Configu.Post;
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
 end;

end;

procedure TfmChungYi.dbnConfigureClick(Sender: TObject; Button: TNavigateBtn);
begin

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

procedure TfmChungYi.cbbDateClick(Sender: TObject);
begin
 if cbbDate.Checked then
  DataModule1.asqQU_Figure.SQL.Text:= 'select * from Figure where TradeDate="' + DateToStr(dptFigure.Date)
     + '" and StockNO="' + comboStockNO.Text + '"'
 else DataModule1.asqQU_Figure.SQL.Text:= 'select * from Figure where StockNO="' + comboStockNO.Text + '"';

 DataModule1.asqQU_Figure.Open;
end;

end.
