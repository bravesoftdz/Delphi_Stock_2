unit DMRecord;

interface

uses
  SysUtils, Classes, DBXpress, FMTBcd, DB, DBClient, Provider, SqlExpr, Windows,
  WideStrings, DBXMySql, ASGSQLite3, Forms, DB_Upgrade;

type
  TDataModule1 = class(TDataModule)
    asqDB_StockRecord: TASQLite3DB;
    asqQU_SN: TASQLite3Query;
    asqQU_TradeRecord: TASQLite3Query;
    asqUpSQL_TradeRecord: TASQLite3UpdateSQL;
    dsTradeRecord: TDataSource;
    asqQU_Temp: TASQLite3Query;
    asqUpSQL_Temp: TASQLite3UpdateSQL;
    dsTemp: TDataSource;
    asqQU_Param: TASQLite3Query;
    asqUpSQL_Param: TASQLite3UpdateSQL;
    dsParam: TDataSource;
    asqQU_Index: TASQLite3Query;
    asqUpSQL_Index: TASQLite3UpdateSQL;
    dsIndex: TDataSource;
    dsRecord: TDataSource;
    asqQU_Record: TASQLite3Query;
    asqQU_RecordSN: TIntegerField;
    asqQU_RecordTradeDate: TStringField;
    asqQU_RecordTradeTime: TTimeField;
    asqQU_RecordAccount: TStringField;
    asqQU_RecordStockNM: TStringField;
    asqQU_RecordBuySell: TStringField;
    asqQU_RecordCriteria: TStringField;
    asqQU_RecordPrice: TFloatField;
    asqQU_RecordQty: TIntegerField;
    asqQU_RecordTradeSN: TStringField;
    asqQU_RecordMsg: TStringField;
    asqUpSQL_Record: TASQLite3UpdateSQL;
    asqQU_Figure: TASQLite3Query;
    asqUpSQL_Figure: TASQLite3UpdateSQL;
    dsFigure: TDataSource;
    asqQU_FigureSN: TIntegerField;
    asqQU_FigureStockNO: TStringField;
    asqQU_FigureTradeDate: TDateField;
    asqQU_FigureLast_Close: TStringField;
    asqQU_FigureOpen_P: TStringField;
    asqQU_FigureP_Span: TStringField;
    asqQU_FigureNextUpDown: TStringField;
    asqQU_IndexSN: TIntegerField;
    asqQU_IndexStockNO: TStringField;
    asqQU_IndexTradeDate: TDateField;
    asqQU_IndexTradeTime: TTimeField;
    asqQU_IndexP_Open: TFloatField;
    asqQU_IndexP_High: TFloatField;
    asqQU_IndexP_Low: TFloatField;
    asqQU_IndexP_Close: TFloatField;
    asqQU_IndexTradeQty: TIntegerField;
    asqQU_IndexAve_Price: TFloatField;
    asqQU_IndexRed: TStringField;
    asqQU_ParamSN: TIntegerField;
    asqQU_ParamModuleNM: TStringField;
    asqQU_ParamDesc: TStringField;
    asqQU_ParamA1: TStringField;
    asqQU_ParamA2: TStringField;
    asqQU_ParamA2_1: TStringField;
    asqQU_ParamA2_1_1: TStringField;
    asqQU_ParamA2_3: TStringField;
    asqQU_ParamA2_3_1: TStringField;
    asqQU_ParamA2_5: TStringField;
    asqQU_ParamA2_5_1: TStringField;
    asqQU_ParamA3: TStringField;
    asqQU_ParamA3_1: TStringField;
    asqQU_ParamA4Radio: TStringField;
    asqQU_ParamA4_1: TStringField;
    asqQU_ParamA4_2: TStringField;
    asqQU_ParamA4_2_1: TStringField;
    asqQU_ParamA4_2_2: TStringField;
    asqQU_ParamA4_3_1: TStringField;
    asqQU_ParamA4_3_2: TStringField;
    asqQU_ParamA5: TStringField;
    asqQU_ParamA5_1: TStringField;
    asqQU_ParamA6: TStringField;
    asqQU_ParamA7: TStringField;
    asqQU_ParamA7_1: TStringField;
    asqQU_ParamA8: TStringField;
    asqQU_ParamA8_1: TStringField;
    asqQU_ParamA9: TStringField;
    asqQU_ParamA9_1: TStringField;
    asqQU_ParamA11: TStringField;
    asqQU_ParamA11_Check: TStringField;
    asqQU_ParamA13: TStringField;
    asqQU_ParamA13_1: TStringField;
    asqQU_ParamA13_Check: TStringField;
    asqQU_ParamA14: TStringField;
    asqQU_ParamA14_Check: TStringField;
    asqQU_ParamA15: TStringField;
    asqQU_ParamB_Open: TStringField;
    asqQU_ParamB1: TStringField;
    asqQU_ParamB2orB3: TStringField;
    asqQU_ParamB2: TStringField;
    asqQU_ParamB2_1: TStringField;
    asqQU_ParamB3: TStringField;
    asqQU_ParamB5: TStringField;
    asqQU_ParamC_Open: TStringField;
    asqQU_ParamC1: TStringField;
    asqQU_ParamC1_1: TStringField;
    asqQU_ParamC2: TStringField;
    asqQU_ParamC3: TStringField;
    asqQU_ParamC4: TStringField;
    asqQU_ParamC5: TStringField;
    asqQU_ParamC7: TStringField;
    asqQU_ParamD_Open: TStringField;
    asqQU_ParamD1: TStringField;
    asqQU_ParamD1_1: TStringField;
    asqQU_ParamD2: TStringField;
    asqQU_ParamD3: TStringField;
    asqQU_ParamD3_1: TStringField;
    asqQU_ParamD4: TStringField;
    asqQU_ParamD4_1: TStringField;
    asqQU_ParamD5: TStringField;
    asqQU_ParamD6: TStringField;
    asqQU_ParamD6_A: TStringField;
    asqQU_ParamD6_1: TStringField;
    asqQU_ParamD7: TStringField;
    asqQU_ParamD8: TStringField;
    asqQU_ParamE_Open: TStringField;
    asqQU_ParamE1: TStringField;
    asqQU_ParamE3: TStringField;
    asqQU_ParamE5: TStringField;
    asqQU_ParamE7: TStringField;
    asqQU_ParamE8: TStringField;
    asqQU_ParamE9: TStringField;
    asqQU_ParamE11: TStringField;
    asqQU_ParamA4_23Check: TStringField;
    asqQU_ParamA4_1Check: TStringField;
    asq_StartEnd: TASQLite3Query;
    asqUpSQL_StartEnd: TASQLite3UpdateSQL;
    dsStartEnd: TDataSource;
    asq_StartEndSN: TIntegerField;
    asq_StartEndStockNO: TStringField;
    asq_StartEndStartTime: TStringField;
    asq_StartEndEndTime: TStringField;
    asq_StartEndEnable: TStringField;
    asq_StartEndFlag: TStringField;
    asq_StartEndBuySellQty: TIntegerField;
    asq_StartEndBuySellType: TStringField;
    asq_StartEndFuterOrderType: TStringField;
    Cre_TradeRecord: TASQLite3Query;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    DateField1: TDateField;
    TimeField1: TTimeField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    IntegerField2: TIntegerField;
    FloatField4: TFloatField;
    Cre_Param: TASQLite3Query;
    IntegerField3: TIntegerField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    StringField16: TStringField;
    StringField17: TStringField;
    StringField18: TStringField;
    StringField19: TStringField;
    StringField20: TStringField;
    StringField21: TStringField;
    StringField22: TStringField;
    StringField23: TStringField;
    StringField24: TStringField;
    StringField25: TStringField;
    StringField26: TStringField;
    StringField27: TStringField;
    StringField28: TStringField;
    StringField29: TStringField;
    StringField30: TStringField;
    StringField31: TStringField;
    StringField32: TStringField;
    StringField33: TStringField;
    StringField34: TStringField;
    StringField35: TStringField;
    StringField36: TStringField;
    StringField37: TStringField;
    StringField38: TStringField;
    StringField39: TStringField;
    StringField40: TStringField;
    StringField41: TStringField;
    StringField42: TStringField;
    StringField43: TStringField;
    StringField44: TStringField;
    StringField45: TStringField;
    StringField46: TStringField;
    StringField47: TStringField;
    StringField48: TStringField;
    StringField49: TStringField;
    StringField50: TStringField;
    StringField51: TStringField;
    StringField52: TStringField;
    StringField53: TStringField;
    StringField54: TStringField;
    StringField55: TStringField;
    StringField56: TStringField;
    StringField57: TStringField;
    StringField58: TStringField;
    StringField59: TStringField;
    StringField60: TStringField;
    StringField61: TStringField;
    StringField62: TStringField;
    StringField63: TStringField;
    StringField64: TStringField;
    StringField65: TStringField;
    StringField66: TStringField;
    StringField67: TStringField;
    StringField68: TStringField;
    StringField69: TStringField;
    StringField70: TStringField;
    StringField71: TStringField;
    StringField72: TStringField;
    StringField73: TStringField;
    StringField74: TStringField;
    StringField75: TStringField;
    StringField76: TStringField;
    Cre_Index: TASQLite3Query;
    IntegerField4: TIntegerField;
    StringField77: TStringField;
    DateField2: TDateField;
    TimeField2: TTimeField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    IntegerField5: TIntegerField;
    FloatField9: TFloatField;
    StringField78: TStringField;
    Cre_Record: TASQLite3Query;
    IntegerField6: TIntegerField;
    StringField79: TStringField;
    TimeField3: TTimeField;
    StringField80: TStringField;
    StringField81: TStringField;
    StringField82: TStringField;
    StringField83: TStringField;
    FloatField10: TFloatField;
    IntegerField7: TIntegerField;
    StringField84: TStringField;
    StringField85: TStringField;
    Cre_Figure: TASQLite3Query;
    IntegerField8: TIntegerField;
    StringField86: TStringField;
    DateField3: TDateField;
    StringField87: TStringField;
    StringField88: TStringField;
    StringField89: TStringField;
    StringField90: TStringField;
    Cre_StartEnd: TASQLite3Query;
    IntegerField9: TIntegerField;
    StringField91: TStringField;
    StringField92: TStringField;
    StringField93: TStringField;
    StringField94: TStringField;
    StringField95: TStringField;
    IntegerField10: TIntegerField;
    StringField96: TStringField;
    StringField97: TStringField;
    Cre_Configu: TASQLite3Query;
    asq_Configu: TASQLite3Query;
    asqUpSQL_Configu: TASQLite3UpdateSQL;
    asqQU_Temp2: TASQLite3Query;
    Cre_Inventory: TASQLite3Query;
    asq_Inventory: TASQLite3Query;
    asqUpSQL_Inventory: TASQLite3UpdateSQL;
    dsConfigu: TDataSource;
    Cre_Option: TASQLite3Query;
    asq_Option: TASQLite3Query;
    asqUpSQL_Option: TASQLite3UpdateSQL;
    dsOption: TDataSource;
    asqUpSQL_NewParam: TASQLite3UpdateSQL;
    asq_NewParam: TASQLite3Query;
    dsNewParam: TDataSource;
    Cre_NewParam: TASQLite3Query;
    cds_Temp: TClientDataSet;
    Provider_Temp: TDataSetProvider;


    function AssignSN(TableNM: String): Integer;
    procedure Connection();
    function GetProgramDir(): String;
    procedure asqQU_RecordSNGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure asqQU_RecordSNSetText(Sender: TField; const Text: string);
    procedure DataModuleCreate(Sender: TObject);
    procedure asq_StartEndBeforePost(DataSet: TDataSet);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

  DB_Ver: String= '12';

implementation

uses Public_Variant, Quote, ChungYi_Main, Strategy, DB_Handle, K_Calculate, getK_Value,
     K_Line_Save;

{$R *.dfm}

// 指定序號
function TDataModule1.AssignSN(TableNM: String): Integer;
begin
 DataModule1.asqQU_SN.Close;
 DataModule1.asqQU_SN.SQL.Text:= 'select SN from ' + TableNM + ' Order by SN Desc limit 1';
 DataModule1.asqQU_SN.Open;

 if DataModule1.asqQU_SN.FieldByName('SN').Text = '' then
  Result:= 0
 else Result:= StrToInt(DataModule1.asqQU_SN.FieldByName('SN').Text);
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
//  DB_Ver:= '4';
  Public_Variant.PathDir:= ExtractFilePath(Application.ExeName);
  asqDB_StockRecord.DriverDLL:= PathDir + 'bin\sqlite3.dll';
  asqDB_StockRecord.DefaultExt := 'db3';

  asqDB_StockRecord.Database:= PathDir + 'FutureParam.db3';
  asqDB_StockRecord.Connected:= true;



  DB_Upgrade.CreateDB();
  asqDB_StockRecord.Open;

  DB_Upgrade.PrepareConnect();
end;

procedure TDataModule1.Connection();
var zqExec : TASQLite3Query;
begin
{ asqDB_StockRecord.DriverDLL := 'sqlite3.dll';
 asqDB_StockRecord.DefaultExt := 'db3';
 asqDB_StockRecord.Database := Utf8Encode('FutureParam.db3');
 asqDB_StockRecord.Connected := True;
 asqDB_StockRecord.Open;
 }

 // 資料庫 active
 DataModule1.asqQU_Param.Active := True;
 DataModule1.asq_StartEnd.Active := True;
 DataModule1.asqQU_Record.Active := True;

 DataModule1.asqQU_Figure.Active:= True;
 DataModule1.asqQU_Figure.Close;
 DataModule1.asqQU_Figure.SQL.Text:= 'select * from Figure';
 DataModule1.asqQU_Figure.Open;

 DataModule1.asqQU_Record.SQL.Text:= 'select * from RecordMsg';
 DataModule1.asqQU_Record.Open;

 DataModule1.asq_Configu.Active:= True;
 DataModule1.asq_Configu.Open;
 DataModule1.asq_NewParam.Active:= True;
 DataModule1.asq_NewParam.Open;
end;

procedure TDataModule1.asqQU_RecordSNGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
 Text := UTF8ToAnsi(Sender.AsAnsiString);
end;

procedure TDataModule1.asqQU_RecordSNSetText(Sender: TField;
  const Text: string);
begin
  Sender.AsAnsiString := AnsiToUtf8(Text);
end;

procedure TDataModule1.asq_StartEndBeforePost(DataSet: TDataSet);
begin
{ if(DataSet.FieldByName('Flag').AsString= 'True') then begin
   asq_StartEnd.SQL.Text:= 'Update tbStartEnd set Flag="False" where SN<>' + DataSet.FieldByName('SN').AsString ;
   asq_StartEnd.Open;
 end;
 }
end;

// 取得 Windows 檔案系統目錄
function TDataModule1.GetProgramDir(): String;
var
        s   :   string;
begin
        SetLength(s,255);
        GetWindowsDirectory(Pchar(s),255);
        SetLength(s,StrLen(Pchar(s)));
        Result:= Copy(s, 0, 2) + '\Program Files';
end;

end.
