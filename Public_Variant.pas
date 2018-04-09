unit Public_Variant;

interface

uses Classes, Quote_uSKQ;

const SKQuoteLib = 'SKQuoteLib.dll';
const SKReplyLib = 'SKReplyLib.dll';
const SKOrderLib = 'SKOrderLib.dll';


const SK_SUCCESS : Integer                             = 0;
const SK_FAIL : Integer                                = -1;
const SK_ERROR_INITIALIZE_FAIL	: Integer               = -4;
const SK_ERROR_OVERSEA_ACCOUNT_NOT_EXIST : Integer     = -2;
const SK_ERROR_ACCOUNT_NOT_EXIST : Integer             = 1001;
const SK_ERROR_ACCOUNT_MARKET_NOT_MATCH : Integer      = 1002;
const SK_ERROR_PERIOD_OUT_OF_RANGE	: Integer           = 1003;
const SK_ERROR_FLAG_OUT_OF_RANGE : Integer             = 1004;
const SK_ERROR_BUYSELL_OUT_OF_RANGE : Integer          = 1005;
const SK_ERROR_ORDER_SERVER_INVALID : Integer          = 1006;
const SK_ERROR_PERMISSION_DENIED : Integer             = 1007;
const SK_ERROR_TRADE_TYPR_OUT_OF_RANGE	: Integer       = 1008;
const SK_ERROR_DAY_TRADE_OUT_OF_RANGE : Integer        = 1009;
const SK_ERROR_ORDER_SIGN_INVALID : Integer            = 1010;
const SK_ERROR_NEW_CLOSE_OUT_OF_RANGE : Integer        = 1011;
const SK_ERROR_PRODUCT_INVALID	: Integer               = 1012;
const SK_ERROR_QTY_INVALID	: Integer                   = 1013;
const SK_ERROR_DAYTRADE_DENIED	: Integer               = 1014;
const SK_ERROR_SPCIAL_TRADE_TYPE_INVALID : Integer     = 1015;
const SK_ERROR_PRICE_INVALID : Integer                 = 1016;
const SK_ERROR_INDEX_OUT_OF_RANGE : Integer            = 1017;
const SK_ERROR_QUERY_IN_PROCESSING	: Integer           = 1018;
const SK_ERROR_LOGIN_INVALID : Integer                 = 1019;
const SK_ERROR_REGISTER_CALLBACK : Integer             = 1020;

type  // �Ȧs��
  TPointData = record
    StockNO: String;
    StockNM: String;
    TradeDate: String;
    TickTime: String;
    P_Open: Extended;
    P_Close: Extended;
    P_Present: Extended;
    P_Lowest: Extended;
    P_Highest: Extended;
    Q_Highest: Extended;
    Q_Lowest: Extended;
    Q_Present: Extended;
  end;

type  // �����Ȧs��
  TStrategy = record
    UpDown: String; // �ثe�b�W�ΤU
    B_HighU, B_HighD, B_LowU, B_LowD: Extended;
    BreakPoint: Boolean;
    Diff_C2, Diff_C5H, Diff_C5L: Extended;
    A2_1_AveQty: Extended; //
    A2_5_1B, A2_5_2B, A2_5_3B, A2_5_1S, A2_5_2S, A2_5_3S: Integer;
    A4_3_High, A4_3_Low: Extended;
    C1_Weight, C2_Weight, C3_Weight, C4_Weight, C5_Weight: Integer;
    D1_Weight, D2_Weight, D3_Weight, D4_Weight, D5_Weight, D6_Weight, D6_1_Weight: Integer;
    D1_AntiWeight, D5_AntiWeight, D6_1_AntiWeight: Integer;
    C3_Out_Start, C3_In_Start: Boolean;
    C3_Out_Count: Integer;
    C3_In_Count: Integer;
    C4_Count: Integer;
    C4_High, C4_LastHigh, C4_Low: Extended;
    C4_Continue: Boolean;
    C_Order: Boolean;
    // D1_K_Ave_High: �H K �έp��̰�����, D1_Ave_High: ���ȷ��̰�
    D1_K_Ave_High, D1_K_Ave_Low, D1_Ave_High, D1_Ave_Low: Extended;
    // �H K �έp��̰���
    D3_K_High, D3_K_Low, D4_K_High, D4_K_Low, D5_K_High, D5_K_Low: Extended;
    // �H K �έp�⦨��q
    D6_Total_Qty, D6A_Total_Qty: Extended;
    E1_1_Weight, E1_2_Weight, E1_4_Weight, E1_3_Weight, E1_5_Weight: Integer;
    E4_1_Weight, E4_2_Weight, E4_3_Weight, E4_4_Weight: Integer;
    E_Profit, E_Buy, E_Sell: Extended;
    E_1_4R, E_1_4G, E_1_5R, E_1_5G: Integer;
    E3_Light, E11_Light, B2_Light, A2_1_Light, A11_Light, A13_Light, A14_Light: Integer;
    RedQty, GreenQty: Integer;
  end;


type  // �ǻ�������Ѽ�
  TStockPass = record
    MarketNO: SmallInt;
    StockNO: SmallInt;
    iPtr: Integer;
    FromQty: Integer;
    ToQty: Integer;
    TotalQty: Integer;
    NowIndex: Integer;
  end;

var
 PathDir: String;

 SystemTime: Integer; // �t�ήɶ�
 TradePrice: String; // �����
 OpenInterestQty: Integer; // ����U���n���o�����ܤ��e�X��
 TriggerInternal: Boolean; // �����ƬO�_�g�Ѥ���Ĳ�o, ���� IE / �������U��Ĳ�o���p
 OpenStock: Boolean; // �O�_�}���Ҩ����\��

 GetResult: Boolean;
 BalanceList: TStringList; // �x�s�Ҩ�w�s
 SetData, KLineSetData: TPointData;
 sStrategy: TStrategy;

 TempList: TStringList;
 StartTime, EndTime, FuturOrderType: String;

 SQLStr, TickTime: String;
 DateList: TStringList; //  �^���ثe��Ʈw������ǦC
 SQLList, AllSQLList, SubAllList: TStringList; // �x�s�U�����
 AveList: TStringList; // �O���C�@ K �Χ���
 HistoryKList: TStringList; // ���v K �u�O�� (��u)
 MinuteQtyList: TStringList; // �O���C�@ K �Φ���q
 BuyQtyList, SellQtyList: TStringList; // �O���R��q

 HighList, LowList: TStringList; // �O���C�@ K �ΰ��C��
 K_List: TStringList; // �O���C�@ K �έ�
 K_OpenList, K_CloseList: TStringList; // �O���C�@ K �� open close ��
 Last_K: Extended; // �̪�@�� K ��
 LastSN, LastIndexSN, FigureSN: Integer; // �O�� traderecord, Indextable, �ϧΪ��̫�@���Ǹ�
 StopGate: Boolean; // ����U����, ���צ�᭱�e�i�Ӹ��
 TotalQty: Integer; // �ثe�`�@�U������

 // K �u���
 // �ثe�ɶ� (����)
 CurrMin, Curr5Min, Curr10Min, Curr20Min: TTime;
 AddStrTrue: Boolean;  // �O�_�s�J��� (�f�t CurrMin)
 OpenP, CloseP: Extended; // �C�����}�L��, ���L��
 NowHigh: Extended= 0;  // �ثeK�γ̰�
 NowLow: Extended= 0;
 FirstLow, FirstHigh: Extended; // �Ĥ@��K�ΧC�I
 MinuteQty: Integer= 0; // �C�����ֿn����q
 AveP, Ave5P, Ave10P, Ave20P: Extended; // �C��������
 KLineGap: Integer; // 1, 3, 5 ���u���j

 FirstTime: Boolean= True; // �O�_���C���U�����Ĥ@��

 OrderState: Boolean; // �O�_���U�檬�A
 NowSecond: Integer= 0 ; // �O���ثe�g�L��� (������)
 RunC_Strategy: Boolean;
 Floated: Boolean; // �O�_���L��
 LastHigh, LastLow: Extended; // �Q��̰�/�C��
 LastDate: String; // �Q����
 LastClose, LastOpen: Extended; // �Q��}���L��
 ThisOpen: Extended; // ����}�L��
 FloatOffSet: Integer; // �B�ʪ��A, ���u�d��[���I��
 FloatHasAdd1, FloatHasAdd2, FloatHasAdd3: Integer; // �w�[�L���I��
 A13HighReturn: Boolean; // �O�_�w�F��n�D��
 A13LowReturn: Boolean;
 A13High: Extended; // A13 �F�찪�I�ɪ���
 A13Low: Extended= 0;
 ThisLastHigh, ThisLastLow, ThisLastOpen: Extended; // ����W�@��K�γ̰� / �C / �}�l��

 FigureStr: String; // �O���ϧΪ����C�I�϶�
 HourHigh, HourLow: Extended; // �C�p�ɪ����C�I
 HourHTime, HourLTime: String; // �C�p�ɪ����C�I���ɶ�
 HasFigure: Boolean= False; // �O�_�w�e�L

 ThisTradeDate: String; // ��������
 PrepareData: Boolean; // �O�_�B�z���e�U�����
 LastMinute: Boolean; // �̫�@������ƪ��PŪ
 LastTime: Boolean= True; // �P�_ 13:44:00 �ɶ��I�u�����@��

 A2Pass: Boolean= True; // �T�T A2 �O�_����
 B5: TBest5;
 A2_BestBuyQty, A2_BestSellQty: Extended;
 A2_5Open, A2_5Close: Extended;
 D7_True: boolean= False;
 BuyOK: Boolean= True; // �f�t A2_5Open, A2_5Close
 SellOK: Boolean= True; // �f�t A2_5Open, A2_5Close
 A4Max, A4Min, A4_2Max, A4_2Min, OffSet_MaxMin: Extended; //
 A4TimePass: Boolean= True;
 A4_3Floated: Boolean= False; // �P�_ A4_3 ���Ck�t�Ҳ�
 A4_2Float: Boolean= False; // �P�_ A4_2 ���Ck�t�Ҳ�
 A4_Weight1: Integer= 0;
 A4_Weight2: Integer= 0;
 A4_Weight3: Integer= 0;
 A4_Weight4: Integer= 0;
 A4_Weight5: Integer= 0;
 BreakLoop: Boolean= False; // �p�G�e���w�U��, �U��������������
 A4_1TimeGate: TTime= 0; //  ���o�i�U�檺�ɶ�

 Ave5P_4Total, Ave10P_4Total, Ave20P_4Total: Extended;
 NowBuySell: String; // �ثe�O�R�ν�
 OrderParamList: TStringList;
 StartOrder: Boolean= False; // �P�_�O�_K�李
 UpDown: String;
 InsideHighLow: Boolean; // B1 ����, �}�L�I�O�_�b���C�d��
 OutsideUpDown: String;
 B_Order: Integer= 0; // �b B �����U�U�檺����, ���i�j�� 2
 B_OrderOK: Boolean= False; // B2 / B3 �w�U��, ���ɥi�U�Ϥϳ�
 LastInventory: Boolean; //�Q��O�_�d��
 LastCost: Extended; // �d�ܦ���
 HasDone: Boolean= False; // �O�_�w�I���U��

 PhotoTime: TTime= 0; // �ϧθ�Ʈw���I�^���ɶ�
 A13_14_Open: boolean= True; // A13, A14 ���ܫ�, �ݤU�@�� A4 �~�i�i��

 Temp: String;
 TempFloat: Extended;

 Temp1, Temp2, Temp3, Temp4: String;

 Order_AfterInventory: boolean;
 OrderType: String;
 StartOverseas_Inventory: boolean;

implementation

end.
