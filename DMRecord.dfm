object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 425
  Width = 1037
  object asqDB_StockRecord: TASQLite3DB
    TimeOut = 0
    CharacterEncoding = 'UTF8'
    Database = 'FutureParam.db3'
    DefaultExt = '.db3'
    Version = '3.7.4'
    DriverDLL = 'sqlite3.dll'
    Connected = False
    MustExist = False
    ExecuteInlineSQL = True
    Left = 120
    Top = 24
  end
  object asqQU_SN: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      'Select * from RecordMsg')
    Left = 16
    Top = 120
  end
  object asqQU_TradeRecord: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      'select * from TradeRecord')
    UpdateSQL = asqUpSQL_TradeRecord
    Left = 88
    Top = 176
  end
  object asqUpSQL_TradeRecord: TASQLite3UpdateSQL
    InsertSQL.Strings = (
      'insert into TradeRecord *')
    UpdateSQL.Strings = (
      'Update TradeRecord * ')
    DeleteSQL.Strings = (
      'Delete from TradeRecord where SN=:SN')
    Left = 88
    Top = 248
  end
  object dsTradeRecord: TDataSource
    DataSet = asqQU_TradeRecord
    Left = 88
    Top = 304
  end
  object asqQU_Temp: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      'select * from TradeRecord')
    UpdateSQL = asqUpSQL_Temp
    Left = 971
    Top = 104
  end
  object asqUpSQL_Temp: TASQLite3UpdateSQL
    InsertSQL.Strings = (
      'insert into TradeRecord *')
    UpdateSQL.Strings = (
      'Update TradeRecord * where SN:=SN')
    DeleteSQL.Strings = (
      'Delete from TradeRecord where SN=:SN')
    Left = 984
    Top = 248
  end
  object dsTemp: TDataSource
    DataSet = asqQU_Temp
    Left = 974
    Top = 328
  end
  object asqQU_Param: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      'select * from Parameter')
    UpdateSQL = asqUpSQL_Param
    Left = 184
    Top = 168
    object asqQU_ParamSN: TIntegerField
      FieldName = 'SN'
    end
    object asqQU_ParamModuleNM: TStringField
      FieldName = 'ModuleNM'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object asqQU_ParamDesc: TStringField
      FieldName = 'Desc'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object asqQU_ParamA1: TStringField
      FieldName = 'A1'
      Size = 255
    end
    object asqQU_ParamA2: TStringField
      FieldName = 'A2'
      Size = 255
    end
    object asqQU_ParamA2_1: TStringField
      FieldName = 'A2_1'
      Size = 255
    end
    object asqQU_ParamA2_1_1: TStringField
      FieldName = 'A2_1_1'
      Size = 255
    end
    object asqQU_ParamA2_3: TStringField
      FieldName = 'A2_3'
      Size = 255
    end
    object asqQU_ParamA2_3_1: TStringField
      FieldName = 'A2_3_1'
      Size = 255
    end
    object asqQU_ParamA2_5: TStringField
      FieldName = 'A2_5'
      Size = 255
    end
    object asqQU_ParamA2_5_1: TStringField
      FieldName = 'A2_5_1'
      Size = 255
    end
    object asqQU_ParamA3: TStringField
      FieldName = 'A3'
      Size = 255
    end
    object asqQU_ParamA3_1: TStringField
      FieldName = 'A3_1'
      Size = 255
    end
    object asqQU_ParamA4_1Check: TStringField
      FieldName = 'A4_1Check'
      Size = 255
    end
    object asqQU_ParamA4_23Check: TStringField
      FieldName = 'A4_23Check'
      Size = 255
    end
    object asqQU_ParamA4Radio: TStringField
      FieldName = 'A4Radio'
      Size = 255
    end
    object asqQU_ParamA4_1: TStringField
      FieldName = 'A4_1'
      Size = 255
    end
    object asqQU_ParamA4_2: TStringField
      FieldName = 'A4_2'
      Size = 255
    end
    object asqQU_ParamA4_2_1: TStringField
      FieldName = 'A4_2_1'
      Size = 255
    end
    object asqQU_ParamA4_2_2: TStringField
      FieldName = 'A4_2_2'
      Size = 255
    end
    object asqQU_ParamA4_3_1: TStringField
      FieldName = 'A4_3_1'
      Size = 255
    end
    object asqQU_ParamA4_3_2: TStringField
      FieldName = 'A4_3_2'
      Size = 255
    end
    object asqQU_ParamA5: TStringField
      FieldName = 'A5'
      Size = 255
    end
    object asqQU_ParamA5_1: TStringField
      FieldName = 'A5_1'
      Size = 255
    end
    object asqQU_ParamA6: TStringField
      FieldName = 'A6'
      Size = 255
    end
    object asqQU_ParamA7: TStringField
      FieldName = 'A7'
      Size = 255
    end
    object asqQU_ParamA7_1: TStringField
      FieldName = 'A7_1'
      Size = 255
    end
    object asqQU_ParamA8: TStringField
      FieldName = 'A8'
      Size = 255
    end
    object asqQU_ParamA8_1: TStringField
      FieldName = 'A8_1'
      Size = 255
    end
    object asqQU_ParamA9: TStringField
      FieldName = 'A9'
      Size = 255
    end
    object asqQU_ParamA9_1: TStringField
      FieldName = 'A9_1'
      Size = 255
    end
    object asqQU_ParamA11: TStringField
      FieldName = 'A11'
      Size = 255
    end
    object asqQU_ParamA11_Check: TStringField
      FieldName = 'A11_Check'
      Size = 255
    end
    object asqQU_ParamA13: TStringField
      FieldName = 'A13'
      Size = 255
    end
    object asqQU_ParamA13_1: TStringField
      FieldName = 'A13_1'
      Size = 255
    end
    object asqQU_ParamA13_Check: TStringField
      FieldName = 'A13_Check'
      Size = 255
    end
    object asqQU_ParamA14: TStringField
      FieldName = 'A14'
      Size = 255
    end
    object asqQU_ParamA14_Check: TStringField
      FieldName = 'A14_Check'
      Size = 255
    end
    object asqQU_ParamA15: TStringField
      FieldName = 'A15'
      Size = 255
    end
    object asqQU_ParamB_Open: TStringField
      FieldName = 'B_Open'
      Size = 255
    end
    object asqQU_ParamB1: TStringField
      FieldName = 'B1'
      Size = 255
    end
    object asqQU_ParamB2orB3: TStringField
      FieldName = 'B2orB3'
      Size = 255
    end
    object asqQU_ParamB2: TStringField
      FieldName = 'B2'
      Size = 255
    end
    object asqQU_ParamB2_1: TStringField
      FieldName = 'B2_1'
      Size = 255
    end
    object asqQU_ParamB3: TStringField
      FieldName = 'B3'
      Size = 255
    end
    object asqQU_ParamB5: TStringField
      FieldName = 'B5'
      Size = 255
    end
    object asqQU_ParamC_Open: TStringField
      FieldName = 'C_Open'
      Size = 255
    end
    object asqQU_ParamC1: TStringField
      FieldName = 'C1'
      Size = 255
    end
    object asqQU_ParamC1_1: TStringField
      FieldName = 'C1_1'
      Size = 255
    end
    object asqQU_ParamC2: TStringField
      FieldName = 'C2'
      Size = 255
    end
    object asqQU_ParamC3: TStringField
      FieldName = 'C3'
      Size = 255
    end
    object asqQU_ParamC4: TStringField
      FieldName = 'C4'
      Size = 255
    end
    object asqQU_ParamC5: TStringField
      FieldName = 'C5'
      Size = 255
    end
    object asqQU_ParamC7: TStringField
      FieldName = 'C7'
      Size = 255
    end
    object asqQU_ParamD_Open: TStringField
      FieldName = 'D_Open'
      Size = 255
    end
    object asqQU_ParamD1: TStringField
      FieldName = 'D1'
      Size = 255
    end
    object asqQU_ParamD1_1: TStringField
      FieldName = 'D1_1'
      Size = 255
    end
    object asqQU_ParamD2: TStringField
      FieldName = 'D2'
      Size = 255
    end
    object asqQU_ParamD3: TStringField
      FieldName = 'D3'
      Size = 255
    end
    object asqQU_ParamD3_1: TStringField
      FieldName = 'D3_1'
      Size = 255
    end
    object asqQU_ParamD4: TStringField
      FieldName = 'D4'
      Size = 255
    end
    object asqQU_ParamD4_1: TStringField
      FieldName = 'D4_1'
      Size = 255
    end
    object asqQU_ParamD5: TStringField
      FieldName = 'D5'
      Size = 255
    end
    object asqQU_ParamD6: TStringField
      FieldName = 'D6'
      Size = 255
    end
    object asqQU_ParamD6_A: TStringField
      FieldName = 'D6_A'
      Size = 255
    end
    object asqQU_ParamD6_1: TStringField
      FieldName = 'D6_1'
      Size = 255
    end
    object asqQU_ParamD7: TStringField
      FieldName = 'D7'
      Size = 255
    end
    object asqQU_ParamD8: TStringField
      FieldName = 'D8'
      Size = 255
    end
    object asqQU_ParamE_Open: TStringField
      FieldName = 'E_Open'
      Size = 255
    end
    object asqQU_ParamE1: TStringField
      FieldName = 'E1'
      Size = 255
    end
    object asqQU_ParamE3: TStringField
      FieldName = 'E3'
      Size = 255
    end
    object asqQU_ParamE5: TStringField
      FieldName = 'E5'
      Size = 255
    end
    object asqQU_ParamE7: TStringField
      FieldName = 'E7'
      Size = 255
    end
    object asqQU_ParamE8: TStringField
      FieldName = 'E8'
      Size = 255
    end
    object asqQU_ParamE9: TStringField
      FieldName = 'E9'
      Size = 255
    end
    object asqQU_ParamE11: TStringField
      FieldName = 'E11'
      Size = 255
    end
  end
  object asqUpSQL_Param: TASQLite3UpdateSQL
    InsertSQL.Strings = (
      'insert into Parameter *')
    UpdateSQL.Strings = (
      'Update Parameter * where SN=:SN')
    DeleteSQL.Strings = (
      'Delete from Parameter where SN=:SN')
    Left = 184
    Top = 240
  end
  object dsParam: TDataSource
    DataSet = asqQU_Param
    Left = 184
    Top = 296
  end
  object asqQU_Index: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      'select * from IndexTable')
    UpdateSQL = asqUpSQL_Index
    Left = 264
    Top = 192
    object asqQU_IndexSN: TIntegerField
      FieldName = 'SN'
    end
    object asqQU_IndexStockNO: TStringField
      FieldName = 'StockNO'
      Size = 255
    end
    object asqQU_IndexTradeDate: TDateField
      FieldName = 'TradeDate'
    end
    object asqQU_IndexTradeTime: TTimeField
      FieldName = 'TradeTime'
    end
    object asqQU_IndexP_Open: TFloatField
      FieldName = 'P_Open'
    end
    object asqQU_IndexP_High: TFloatField
      FieldName = 'P_High'
    end
    object asqQU_IndexP_Low: TFloatField
      FieldName = 'P_Low'
    end
    object asqQU_IndexP_Close: TFloatField
      FieldName = 'P_Close'
    end
    object asqQU_IndexTradeQty: TIntegerField
      FieldName = 'TradeQty'
    end
    object asqQU_IndexAve_Price: TFloatField
      FieldName = 'Ave_Price'
    end
    object asqQU_IndexRed: TStringField
      FieldName = 'Red'
      Size = 255
    end
  end
  object asqUpSQL_Index: TASQLite3UpdateSQL
    InsertSQL.Strings = (
      'insert intoIndexTable *')
    UpdateSQL.Strings = (
      'Update IndexTable * ')
    DeleteSQL.Strings = (
      'Delete from IndexTable where SN=:SN')
    Left = 264
    Top = 264
  end
  object dsIndex: TDataSource
    DataSet = asqQU_Index
    Left = 264
    Top = 320
  end
  object dsRecord: TDataSource
    DataSet = asqQU_Record
    Left = 336
    Top = 296
  end
  object asqQU_Record: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      'Select * from RecordMsg')
    UpdateSQL = asqUpSQL_Record
    Left = 336
    Top = 168
    object asqQU_RecordSN: TIntegerField
      FieldName = 'SN'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
    end
    object asqQU_RecordTradeDate: TStringField
      DisplayLabel = #26085#26399
      FieldName = 'TradeDate'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object asqQU_RecordTradeTime: TTimeField
      DisplayLabel = #26178#38291
      FieldName = 'TradeTime'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
    end
    object asqQU_RecordAccount: TStringField
      DisplayLabel = #24115#34399
      FieldName = 'Account'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object asqQU_RecordStockNM: TStringField
      DisplayLabel = #21830#21697
      FieldName = 'StockNM'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object asqQU_RecordBuySell: TStringField
      DisplayLabel = #36023#36067
      FieldName = 'BuySell'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object asqQU_RecordCriteria: TStringField
      DisplayLabel = #26781#20214
      FieldName = 'Criteria'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object asqQU_RecordPrice: TFloatField
      DisplayLabel = #20729#26684
      FieldName = 'Price'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
    end
    object asqQU_RecordQty: TIntegerField
      DisplayLabel = #21475#25976
      FieldName = 'Qty'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
    end
    object asqQU_RecordTradeSN: TStringField
      DisplayLabel = #20132#26131#24207#34399
      FieldName = 'TradeSN'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object asqQU_RecordMsg: TStringField
      DisplayLabel = #35338#24687
      FieldName = 'Msg'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
  end
  object asqUpSQL_Record: TASQLite3UpdateSQL
    InsertSQL.Strings = (
      'insert into RecordMsg *')
    UpdateSQL.Strings = (
      'Update RecordMsg * ')
    DeleteSQL.Strings = (
      'Delete from RecordMsg where SN=:SN')
    Left = 336
    Top = 232
  end
  object asqQU_Figure: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      'select * from Figure')
    UpdateSQL = asqUpSQL_Figure
    Left = 424
    Top = 192
    object asqQU_FigureSN: TIntegerField
      FieldName = 'SN'
    end
    object asqQU_FigureStockNO: TStringField
      DisplayLabel = #29986#21697#20195#34399
      FieldName = 'StockNO'
      Size = 255
    end
    object asqQU_FigureTradeDate: TDateField
      DisplayLabel = #20132#26131#26085#26399
      FieldName = 'TradeDate'
    end
    object asqQU_FigureLast_Close: TStringField
      DisplayLabel = #26152#26085#25910#30436#20729
      FieldName = 'Last_Close'
      Size = 255
    end
    object asqQU_FigureOpen_P: TStringField
      DisplayLabel = #38283#30436#20729
      FieldName = 'Open_P'
      Size = 255
    end
    object asqQU_FigureP_Span: TStringField
      DisplayLabel = #36264#21218#20540
      FieldName = 'P_Span'
      Size = 255
    end
    object asqQU_FigureNextUpDown: TStringField
      DisplayLabel = #38548#22825#36264#21218
      FieldName = 'NextUpDown'
      Size = 255
    end
  end
  object asqUpSQL_Figure: TASQLite3UpdateSQL
    InsertSQL.Strings = (
      'insert into Figure *')
    UpdateSQL.Strings = (
      'Update Figure * ')
    DeleteSQL.Strings = (
      'Delete from Figure where SN=:SN')
    Left = 424
    Top = 264
  end
  object dsFigure: TDataSource
    DataSet = asqQU_Figure
    Left = 424
    Top = 320
  end
  object asq_StartEnd: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    BeforePost = asq_StartEndBeforePost
    RawSQL = False
    SQL.Strings = (
      'select * from tbStartEnd')
    UpdateSQL = asqUpSQL_StartEnd
    Left = 520
    Top = 192
    object asq_StartEndSN: TIntegerField
      FieldName = 'SN'
    end
    object asq_StartEndStockNO: TStringField
      FieldName = 'StockNO'
      Size = 255
    end
    object asq_StartEndStartTime: TStringField
      FieldName = 'StartTime'
      Size = 255
    end
    object asq_StartEndEndTime: TStringField
      FieldName = 'EndTime'
      Size = 255
    end
    object asq_StartEndEnable: TStringField
      FieldName = 'Enable'
      Size = 255
    end
    object asq_StartEndFlag: TStringField
      FieldName = 'Flag'
      Size = 255
    end
    object asq_StartEndBuySellQty: TIntegerField
      FieldName = 'BuySellQty'
    end
    object asq_StartEndBuySellType: TStringField
      FieldName = 'BuySellType'
      Size = 255
    end
    object asq_StartEndFuterOrderType: TStringField
      FieldName = 'FuterOrderType'
      Size = 255
    end
  end
  object asqUpSQL_StartEnd: TASQLite3UpdateSQL
    InsertSQL.Strings = (
      'insert into tbStartEnd *')
    UpdateSQL.Strings = (
      'Update tbStartEnd * where SN=:SN'
      '')
    DeleteSQL.Strings = (
      'Delete from tbStartEnd where SN=:SN')
    Left = 520
    Top = 264
  end
  object dsStartEnd: TDataSource
    DataSet = asq_StartEnd
    Left = 520
    Top = 320
  end
  object Cre_TradeRecord: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      
        'Create table IF not EXISTS TradeRecord(SN Integer Primary Key Au' +
        'toincrement, StockNO varchar(5) , TradeDate Date , TickTime Time' +
        ' , BuyPrice Float , SellPrice Float , TradePrice Float , Qty Int' +
        'eger , AveP Float, BuyQty Float,  SellQty Float, TickQty Float);'
      
        'CREATE INDEX  IF not EXISTS StockNO ON TradeRecord (SN, StockNO,' +
        ' TradeDate,  TickTime );')
    UpdateSQL = asqUpSQL_TradeRecord
    Left = 88
    Top = 104
    object IntegerField1: TIntegerField
      FieldName = 'SN'
    end
    object StringField1: TStringField
      FieldName = 'StockNO'
      Size = 255
    end
    object DateField1: TDateField
      FieldName = 'TradeDate'
    end
    object TimeField1: TTimeField
      FieldName = 'TickTime'
    end
    object FloatField1: TFloatField
      FieldName = 'BuyPrice'
    end
    object FloatField2: TFloatField
      FieldName = 'SellPrice'
    end
    object FloatField3: TFloatField
      FieldName = 'TradePrice'
    end
    object IntegerField2: TIntegerField
      FieldName = 'Qty'
    end
    object FloatField4: TFloatField
      FieldName = 'AveP'
    end
  end
  object Cre_Param: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      
        'Create table IF not EXISTS  Parameter(SN Integer Primary Key Aut' +
        'oincrement, ModuleNM varchar(20) , Desc varchar(20) , A1 varchar' +
        '(10) , A2 varchar(10) , A2_1 varchar(1) , A2_1_1 varchar(10) , A' +
        '2_3 varchar(1) , A2_3_1 varchar(10) , A2_5 varchar(1) , A2_5_1 v' +
        'archar(10) , A3 varchar(10) , A3_1 varchar(10) , A4Radio varchar' +
        '(1) , A4_23Check varchar(1) , A4_1Check varchar(1) , A4_1 varcha' +
        'r(10) , A4_2 varchar(10) , A4_2_1 varchar(10) , A4_2_2 varchar(1' +
        '0) , A4_3_1 varchar(10) , A4_3_2 varchar(10) , A5 varchar(10) , ' +
        'A5_1 varchar(10) , A6 varchar(10) , A7 varchar(10) , A7_1 varcha' +
        'r(10) , A8 varchar(10) , A8_1 varchar(10) , A9 varchar(10) , A9_' +
        '1 varchar(10) , A11 varchar(10) , A11_Check varchar(1) , A13 var' +
        'char(10) , A13_1 varchar(10) , A13_Check varchar(1) , A14 varcha' +
        'r(10) , A14_Check varchar(1) , A15 varchar(10) , B_Open varchar(' +
        '1) , B1 varchar(10) , B2orB3 varchar(1) , B2 varchar(10) , B2_1 ' +
        'varchar(10) , B3 varchar(10) , B5 varchar(10) , C_Open varchar(1' +
        ') , C1 varchar(10) , C1_1 varchar(10) , C2 varchar(10) , C3 varc' +
        'har(10) , C4 varchar(10) , C5 varchar(10) , C7 varchar(10) , D_O' +
        'pen varchar(1) , D1 varchar(10) , D1_1 varchar(10) , D2 varchar(' +
        '10) , D3 varchar(10) , D3_1 varchar(10) , D4 varchar(10) , D4_1 ' +
        'varchar(10) , D5 varchar(10) , D6 varchar(10) , D6_A varchar(10)' +
        ' , D6_1 varchar(10) , D7 varchar(10) , D8 varchar(10) , E_Open v' +
        'archar(1) , E1 varchar(10) , E3 varchar(10) , E5 varhcar(1) , E7' +
        ' varchar(10) , E8 varchar(10) , E9 varchar(10) , E11 varchar(10)' +
        ' );')
    UpdateSQL = asqUpSQL_Param
    Left = 184
    Top = 104
    object IntegerField3: TIntegerField
      FieldName = 'SN'
    end
    object StringField2: TStringField
      FieldName = 'ModuleNM'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object StringField3: TStringField
      FieldName = 'Desc'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object StringField4: TStringField
      FieldName = 'A1'
      Size = 255
    end
    object StringField5: TStringField
      FieldName = 'A2'
      Size = 255
    end
    object StringField6: TStringField
      FieldName = 'A2_1'
      Size = 255
    end
    object StringField7: TStringField
      FieldName = 'A2_1_1'
      Size = 255
    end
    object StringField8: TStringField
      FieldName = 'A2_3'
      Size = 255
    end
    object StringField9: TStringField
      FieldName = 'A2_3_1'
      Size = 255
    end
    object StringField10: TStringField
      FieldName = 'A2_5'
      Size = 255
    end
    object StringField11: TStringField
      FieldName = 'A2_5_1'
      Size = 255
    end
    object StringField12: TStringField
      FieldName = 'A3'
      Size = 255
    end
    object StringField13: TStringField
      FieldName = 'A3_1'
      Size = 255
    end
    object StringField14: TStringField
      FieldName = 'A4_1Check'
      Size = 255
    end
    object StringField15: TStringField
      FieldName = 'A4_23Check'
      Size = 255
    end
    object StringField16: TStringField
      FieldName = 'A4Radio'
      Size = 255
    end
    object StringField17: TStringField
      FieldName = 'A4_1'
      Size = 255
    end
    object StringField18: TStringField
      FieldName = 'A4_2'
      Size = 255
    end
    object StringField19: TStringField
      FieldName = 'A4_2_1'
      Size = 255
    end
    object StringField20: TStringField
      FieldName = 'A4_2_2'
      Size = 255
    end
    object StringField21: TStringField
      FieldName = 'A4_3_1'
      Size = 255
    end
    object StringField22: TStringField
      FieldName = 'A4_3_2'
      Size = 255
    end
    object StringField23: TStringField
      FieldName = 'A5'
      Size = 255
    end
    object StringField24: TStringField
      FieldName = 'A5_1'
      Size = 255
    end
    object StringField25: TStringField
      FieldName = 'A6'
      Size = 255
    end
    object StringField26: TStringField
      FieldName = 'A7'
      Size = 255
    end
    object StringField27: TStringField
      FieldName = 'A7_1'
      Size = 255
    end
    object StringField28: TStringField
      FieldName = 'A8'
      Size = 255
    end
    object StringField29: TStringField
      FieldName = 'A8_1'
      Size = 255
    end
    object StringField30: TStringField
      FieldName = 'A9'
      Size = 255
    end
    object StringField31: TStringField
      FieldName = 'A9_1'
      Size = 255
    end
    object StringField32: TStringField
      FieldName = 'A11'
      Size = 255
    end
    object StringField33: TStringField
      FieldName = 'A11_Check'
      Size = 255
    end
    object StringField34: TStringField
      FieldName = 'A13'
      Size = 255
    end
    object StringField35: TStringField
      FieldName = 'A13_1'
      Size = 255
    end
    object StringField36: TStringField
      FieldName = 'A13_Check'
      Size = 255
    end
    object StringField37: TStringField
      FieldName = 'A14'
      Size = 255
    end
    object StringField38: TStringField
      FieldName = 'A14_Check'
      Size = 255
    end
    object StringField39: TStringField
      FieldName = 'A15'
      Size = 255
    end
    object StringField40: TStringField
      FieldName = 'B_Open'
      Size = 255
    end
    object StringField41: TStringField
      FieldName = 'B1'
      Size = 255
    end
    object StringField42: TStringField
      FieldName = 'B2orB3'
      Size = 255
    end
    object StringField43: TStringField
      FieldName = 'B2'
      Size = 255
    end
    object StringField44: TStringField
      FieldName = 'B2_1'
      Size = 255
    end
    object StringField45: TStringField
      FieldName = 'B3'
      Size = 255
    end
    object StringField46: TStringField
      FieldName = 'B5'
      Size = 255
    end
    object StringField47: TStringField
      FieldName = 'C_Open'
      Size = 255
    end
    object StringField48: TStringField
      FieldName = 'C1'
      Size = 255
    end
    object StringField49: TStringField
      FieldName = 'C1_1'
      Size = 255
    end
    object StringField50: TStringField
      FieldName = 'C2'
      Size = 255
    end
    object StringField51: TStringField
      FieldName = 'C3'
      Size = 255
    end
    object StringField52: TStringField
      FieldName = 'C4'
      Size = 255
    end
    object StringField53: TStringField
      FieldName = 'C5'
      Size = 255
    end
    object StringField54: TStringField
      FieldName = 'C7'
      Size = 255
    end
    object StringField55: TStringField
      FieldName = 'D_Open'
      Size = 255
    end
    object StringField56: TStringField
      FieldName = 'D1'
      Size = 255
    end
    object StringField57: TStringField
      FieldName = 'D1_1'
      Size = 255
    end
    object StringField58: TStringField
      FieldName = 'D2'
      Size = 255
    end
    object StringField59: TStringField
      FieldName = 'D3'
      Size = 255
    end
    object StringField60: TStringField
      FieldName = 'D3_1'
      Size = 255
    end
    object StringField61: TStringField
      FieldName = 'D4'
      Size = 255
    end
    object StringField62: TStringField
      FieldName = 'D4_1'
      Size = 255
    end
    object StringField63: TStringField
      FieldName = 'D5'
      Size = 255
    end
    object StringField64: TStringField
      FieldName = 'D6'
      Size = 255
    end
    object StringField65: TStringField
      FieldName = 'D6_A'
      Size = 255
    end
    object StringField66: TStringField
      FieldName = 'D6_1'
      Size = 255
    end
    object StringField67: TStringField
      FieldName = 'D7'
      Size = 255
    end
    object StringField68: TStringField
      FieldName = 'D8'
      Size = 255
    end
    object StringField69: TStringField
      FieldName = 'E_Open'
      Size = 255
    end
    object StringField70: TStringField
      FieldName = 'E1'
      Size = 255
    end
    object StringField71: TStringField
      FieldName = 'E3'
      Size = 255
    end
    object StringField72: TStringField
      FieldName = 'E5'
      Size = 255
    end
    object StringField73: TStringField
      FieldName = 'E7'
      Size = 255
    end
    object StringField74: TStringField
      FieldName = 'E8'
      Size = 255
    end
    object StringField75: TStringField
      FieldName = 'E9'
      Size = 255
    end
    object StringField76: TStringField
      FieldName = 'E11'
      Size = 255
    end
  end
  object Cre_Index: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      
        'Create table IF not EXISTS IndexTable(SN Integer Primary Key Aut' +
        'oincrement, StockNO varchar(10) , TradeDate Date , TradeTime Tim' +
        'e , P_Open Float , P_High Float , P_Low Float , P_Close Float , ' +
        'TradeQty Integer , Ave_Price Float , Red varchar(1) );')
    UpdateSQL = asqUpSQL_Index
    Left = 264
    Top = 104
    object IntegerField4: TIntegerField
      FieldName = 'SN'
    end
    object StringField77: TStringField
      FieldName = 'StockNO'
      Size = 255
    end
    object DateField2: TDateField
      FieldName = 'TradeDate'
    end
    object TimeField2: TTimeField
      FieldName = 'TradeTime'
    end
    object FloatField5: TFloatField
      FieldName = 'P_Open'
    end
    object FloatField6: TFloatField
      FieldName = 'P_High'
    end
    object FloatField7: TFloatField
      FieldName = 'P_Low'
    end
    object FloatField8: TFloatField
      FieldName = 'P_Close'
    end
    object IntegerField5: TIntegerField
      FieldName = 'TradeQty'
    end
    object FloatField9: TFloatField
      FieldName = 'Ave_Price'
    end
    object StringField78: TStringField
      FieldName = 'Red'
      Size = 255
    end
  end
  object Cre_Record: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      
        'CREATE TABLE IF not EXISTS RecordMsg(SN Integer , TradeDate varc' +
        'har(10) , TradeTime Time , Account varchar(20) , StockNM varchar' +
        '(20) , BuySell varchar(4) , Criteria varchar(20) , Price float ,' +
        ' Qty Integer , TradeSN varchar(10) , Msg varchar(20), TestMode v' +
        'archar(1), LeftQty Integer, NO_K varchar(1), OrderStrategy varch' +
        'ar(10) );')
    UpdateSQL = asqUpSQL_Record
    Left = 336
    Top = 104
    object IntegerField6: TIntegerField
      FieldName = 'SN'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
    end
    object StringField79: TStringField
      DisplayLabel = #26085#26399
      FieldName = 'TradeDate'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object TimeField3: TTimeField
      DisplayLabel = #26178#38291
      FieldName = 'TradeTime'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
    end
    object StringField80: TStringField
      DisplayLabel = #24115#34399
      FieldName = 'Account'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object StringField81: TStringField
      DisplayLabel = #21830#21697
      FieldName = 'StockNM'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object StringField82: TStringField
      DisplayLabel = #36023#36067
      FieldName = 'BuySell'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object StringField83: TStringField
      DisplayLabel = #26781#20214
      FieldName = 'Criteria'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object FloatField10: TFloatField
      DisplayLabel = #20729#26684
      FieldName = 'Price'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
    end
    object IntegerField7: TIntegerField
      DisplayLabel = #21475#25976
      FieldName = 'Qty'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
    end
    object StringField84: TStringField
      DisplayLabel = #20132#26131#24207#34399
      FieldName = 'TradeSN'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
    object StringField85: TStringField
      DisplayLabel = #35338#24687
      FieldName = 'Msg'
      OnGetText = asqQU_RecordSNGetText
      OnSetText = asqQU_RecordSNSetText
      Size = 255
    end
  end
  object Cre_Figure: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      
        'Create table IF not EXISTS Figure(SN Integer , StockNO varchar(1' +
        '0) , TradeDate Date , Last_Close varchar(10) , Open_P varchar(10' +
        ') , P_Span varchar(30) , NextUpDown varchar(1), TestMode varchar' +
        '(1) );')
    UpdateSQL = asqUpSQL_Figure
    Left = 424
    Top = 104
    object IntegerField8: TIntegerField
      FieldName = 'SN'
    end
    object StringField86: TStringField
      DisplayLabel = #29986#21697#20195#34399
      FieldName = 'StockNO'
      Size = 255
    end
    object DateField3: TDateField
      DisplayLabel = #20132#26131#26085#26399
      FieldName = 'TradeDate'
    end
    object StringField87: TStringField
      DisplayLabel = #26152#26085#25910#30436#20729
      FieldName = 'Last_Close'
      Size = 255
    end
    object StringField88: TStringField
      DisplayLabel = #38283#30436#20729
      FieldName = 'Open_P'
      Size = 255
    end
    object StringField89: TStringField
      DisplayLabel = #36264#21218#20540
      FieldName = 'P_Span'
      Size = 255
    end
    object StringField90: TStringField
      DisplayLabel = #38548#22825#36264#21218
      FieldName = 'NextUpDown'
      Size = 255
    end
  end
  object Cre_StartEnd: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    BeforePost = asq_StartEndBeforePost
    RawSQL = False
    SQL.Strings = (
      
        'Create table IF not EXISTS tbStartEnd(SN Integer Primary Key Aut' +
        'oincrement, StockNO varchar(32), StartTime varchar(8), EndTime v' +
        'archar(8), BuySellQty Integer, BuySellType varchar(6), Enable va' +
        'rchar(1), Flag varchar(1), FuterOrderType varchar(16));')
    UpdateSQL = asqUpSQL_StartEnd
    Left = 512
    Top = 104
    object IntegerField9: TIntegerField
      FieldName = 'SN'
    end
    object StringField91: TStringField
      FieldName = 'StockNO'
      Size = 255
    end
    object StringField92: TStringField
      FieldName = 'StartTime'
      Size = 255
    end
    object StringField93: TStringField
      FieldName = 'EndTime'
      Size = 255
    end
    object StringField94: TStringField
      FieldName = 'Enable'
      Size = 255
    end
    object StringField95: TStringField
      FieldName = 'Flag'
      Size = 255
    end
    object IntegerField10: TIntegerField
      FieldName = 'BuySellQty'
    end
    object StringField96: TStringField
      FieldName = 'BuySellType'
      Size = 255
    end
    object StringField97: TStringField
      FieldName = 'FuterOrderType'
      Size = 255
    end
  end
  object Cre_Configu: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    BeforePost = asq_StartEndBeforePost
    RawSQL = False
    SQL.Strings = (
      
        'Create table IF not EXISTS tbConfigure(SN Integer Primary Key Au' +
        'toincrement , DB_Version Integer, CustomerType varchar(10), Test' +
        'Mode varchar(1), IsRestart varchar(1));')
    UpdateSQL = asqUpSQL_Configu
    Left = 600
    Top = 104
  end
  object asq_Configu: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    BeforePost = asq_StartEndBeforePost
    RawSQL = False
    SQL.Strings = (
      'select * from tbConfigure')
    UpdateSQL = asqUpSQL_Configu
    Left = 600
    Top = 192
  end
  object asqUpSQL_Configu: TASQLite3UpdateSQL
    InsertSQL.Strings = (
      'insert into tbConfigure *')
    UpdateSQL.Strings = (
      'Update tbConfigure * where SN=:SN'
      '')
    DeleteSQL.Strings = (
      'Delete from tbConfigure where SN=:SN')
    Left = 608
    Top = 280
  end
  object asqQU_Temp2: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      'select * from TradeRecord')
    UpdateSQL = asqUpSQL_Temp
    Left = 971
    Top = 184
  end
  object Cre_Inventory: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    BeforePost = asq_StartEndBeforePost
    RawSQL = False
    SQL.Strings = (
      
        'Create table IF not EXISTS tbInventory(SN Integer Primary Key Au' +
        'toincrement , StockNO varchar(10) , TradeDate Date , LeftQty Int' +
        'eger , LeftBuySell varchar(1), Ordern_P varchar(10), TestMode va' +
        'rchar(1));')
    UpdateSQL = asqUpSQL_Inventory
    Left = 688
    Top = 104
  end
  object asq_Inventory: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    BeforePost = asq_StartEndBeforePost
    RawSQL = False
    SQL.Strings = (
      'select * from tbInventory')
    UpdateSQL = asqUpSQL_Inventory
    Left = 688
    Top = 192
  end
  object asqUpSQL_Inventory: TASQLite3UpdateSQL
    InsertSQL.Strings = (
      'insert into tbConfigure *')
    UpdateSQL.Strings = (
      'Update tbConfigure * where SN=:SN'
      '')
    DeleteSQL.Strings = (
      'Delete from tbConfigure where SN=:SN')
    Left = 696
    Top = 264
  end
  object dsConfigu: TDataSource
    DataSet = asq_Configu
    Left = 608
    Top = 336
  end
  object Cre_Option: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    BeforePost = asq_StartEndBeforePost
    RawSQL = False
    SQL.Strings = (
      
        'Create table IF not EXISTS tbOption(SN Integer Primary Key Autoi' +
        'ncrement , Option1 varchar(16) ,Option2 varchar(16)  ,Option3 va' +
        'rchar(16) ,Option4 varchar(16) , Option5 varchar(16) , Option6 v' +
        'archar(16), Field_X Integer,  Field_Y Integer, Field_Z Integer )' +
        ';')
    UpdateSQL = asqUpSQL_Option
    Left = 776
    Top = 104
  end
  object asq_Option: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      'select * from tbOption')
    UpdateSQL = asqUpSQL_Option
    Left = 771
    Top = 176
  end
  object asqUpSQL_Option: TASQLite3UpdateSQL
    InsertSQL.Strings = (
      'insert into tbOption *')
    UpdateSQL.Strings = (
      'Update tbOption * ')
    DeleteSQL.Strings = (
      'Delete from tbOption where SN=:SN')
    Left = 774
    Top = 256
  end
  object dsOption: TDataSource
    DataSet = asq_Option
    Left = 782
    Top = 320
  end
  object asqUpSQL_NewParam: TASQLite3UpdateSQL
    InsertSQL.Strings = (
      'insert into tbNewParam *')
    UpdateSQL.Strings = (
      'Update tbNewParam * where SN=:SN'
      '')
    DeleteSQL.Strings = (
      'Delete from tbNewParam where SN=:SN')
    Left = 864
    Top = 272
  end
  object asq_NewParam: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    RawSQL = False
    SQL.Strings = (
      'select * from tbNewParam')
    UpdateSQL = asqUpSQL_NewParam
    Left = 851
    Top = 208
  end
  object dsNewParam: TDataSource
    DataSet = asq_NewParam
    Left = 862
    Top = 336
  end
  object Cre_NewParam: TASQLite3Query
    AutoCommit = False
    SQLiteDateFormat = True
    Connection = asqDB_StockRecord
    MaxResults = 0
    StartResult = 0
    TypeLess = False
    SQLCursor = True
    ReadOnly = False
    UniDirectional = False
    BeforePost = asq_StartEndBeforePost
    RawSQL = False
    SQL.Strings = (
      
        'CREATE TABLE IF not EXISTS tbNewParam(SN Integer Primary Key Aut' +
        'oincrement, ModuleNM varchar(20) , Desc varchar(20) , '
      
        '  Spec_1_Check varchar(1), Spec_1_1 varchar(10), Spec_1_2 varcha' +
        'r(10), Spec_1_3 varchar(10), Spec_1_Rate varchar(10),'
      
        '  PreOrder_Check varchar(1), PreOrder_Rate varchar(10), PreOrder' +
        '_1_Check varchar(1), PreOrder_1 varchar(10), PreOrder_2_Check va' +
        'rchar(1), PreOrder_2 varchar(10), PreOrder_3_Check varchar(1), P' +
        'reOrder_3 varchar(10),'
      
        '       PreOrder_4_Check varchar(1), PreOrder_4 varchar(10), PreO' +
        'rder_5_Check varchar(1), PreOrder_5 varchar(10), '
      
        '  Profit_Check varchar(1), Profit_Rate varchar(10), Profit_1_Che' +
        'ck varchar(1), Profit_1_1 varchar(10), Profit_1_2 varchar(10), '
      
        '       Profit_2_Check varchar(1), Profit_2_1 varchar(10), Profit' +
        '_2_2 varchar(10), Profit_2_3 varchar(10), '
      
        '       Profit_3_Check varchar(10), Profit_3_1_1 varchar(10), Pro' +
        'fit_3_1_2 varchar(10), Profit_3_2_1 varchar(10), Profit_3_2_2 va' +
        'rchar(10),'
      
        #9#9'Profit_3_3_1 varchar(10), Profit_3_3_2 varchar(10), Profit_3_4' +
        '_1 varchar(10), Profit_3_4_2 varchar(10), Profit_3_5_1 varchar(1' +
        '0), Profit_3_5_2 varchar(10),'
      
        '  Spec_2_Check varchar(1), Spec_2_1 varchar(10), Spec_2_2 varcha' +
        'r(10), Spec_2_3 varchar(10), Spec_2_Rate varchar(10), '
      
        '  InventAnti_Check varchar(1), InventAnti_Rate varchar(10), Inve' +
        'ntAnti_1_Check varchar(1), InventAnti_1 varchar(10), InventAnti_' +
        '2_Check varchar(1), InventAnti_2_1 varchar(10), InventAnti_2_2 v' +
        'archar(10),'
      
        '       InventAnti_3_Check varchar(1), InventAnti_3 varchar(10), ' +
        'InventAnti_4_Check varchar(1), InventAnti_4 varchar(10), InventA' +
        'nti_5_Check varchar(1), InventAnti_5 varchar(10), '
      
        '  Float_Check varchar(1), Float_Rate varchar(10), Float_1_Check ' +
        'varchar(1), Float_1_1 varchar(10), Float_1_2 varchar(10), Float_' +
        '2_Check varchar(1), Float_2_1 varchar(10), '
      
        '       Float_3_Check varchar(1), Float_3_1 varchar(10), Float_3_' +
        '2 varchar(10), Float_4_Check varchar(1), Float_4_1 varchar(10), ' +
        'Float_4_2 varchar(10),'
      
        '       Float_5_Check varchar(1), Float_5_1 varchar(10), Float_6_' +
        'Check varchar(1),'
      
        '  Internal_Check varchar(1), Internal_Rate varchar(10), Internal' +
        '_1_Check varchar(1), Internal_1_1 varchar(10), Internal_1_2 varc' +
        'har(10),'
      
        '       Internal_2_Check varchar(1), Internal_2_1 varchar(10), In' +
        'ternal_2_2 varchar(10), Internal_2_3 varchar(10), Internal_2_Rat' +
        'e varchar(10),'
      
        '       Internal_3_Check varchar(1), Internal_3_1 varchar(10), In' +
        'ternal_3_2 varchar(10), Internal_3_3 varchar(10), Internal_3_Rat' +
        'e varchar(10),'
      
        '       Internal_4_Check varchar(1), Internal_5_Check varchar(1),' +
        ' Internal_6_Check varchar(1), '
      
        '       Internal_7_Check varchar(1), Internal_7_Rate varchar(10),' +
        ' Internal_8_Check varchar(1), Internal_8_Rate varchar(10), Inter' +
        'nal_9_Check varchar(1), Internal_9_Rate varchar(10),'
      
        '       Internal_10_Check varchar(1), Internal_10_1_1 varchar(10)' +
        ', Internal_10_1_2 varchar(10), Internal_10_1_3 varchar(10), Inte' +
        'rnal_10_Rate varchar(10),'
      
        '       Internal_11_Check varchar(1), Internal_11_1_1 varchar(10)' +
        ', Internal_11_1_2 varchar(10),'
      
        '  Engine_Check varchar(1), Engine_Rate varchar(10), Engine_1_Che' +
        'ck varchar(1), Engine_1_1 varchar(10), Engine_2_Check varchar(1)' +
        ', Engine_2_1 varchar(10),'
      
        '       Engine_3_Check varchar(1), Engine_3_1 varchar(10), Engine' +
        '_3_2 varchar(10), Engine_4_Check varchar(1), Engine_4_1 varchar(' +
        '10), Engine_5_Check varchar(1), Engine_6_Check varchar(1), Engin' +
        'e_6_1 varchar(10),'
      
        '       Engine_7_Check varchar(1), Engine_7_1 varchar(10), Engine' +
        '_8_Check varchar(1), Engine_8_1 varchar(10), Engine_9_Check varc' +
        'har(1), Engine_9_1 varchar(10),'
      
        '       Engine_10_Check varchar(1), Engine_10_1 varchar(10), Engi' +
        'ne_11_Check varchar(1), Engine_11_1 varchar(10),'
      
        '       Engine_12_Check varchar(1), Engine_12_1 varchar(10), Engi' +
        'ne_13_Check varchar(1), Engine_14_Check varchar(1), Engine_14_1 ' +
        'varchar(10), Engine_15_Check varchar(1), Engine_15_1 varchar(10)' +
        ','
      
        '       Engine_16_Check varchar(1), Engine_16_1 varchar(10), Engi' +
        'ne_17_Check varchar(1), Engine_17_1 varchar(10), Engine_18_Check' +
        ' varchar(1), Engine_18_1 varchar(10),'
      
        '       Engine_19_Check varchar(1), Engine_19_1 varchar(10), Engi' +
        'ne_20_Check varchar(1), Engine_20_1 varchar(10), Engine_21_Check' +
        ' varchar(1), Engine_21_1 varchar(10),'
      
        '  KeepOrder_Check varchar(1), KeepOrder_Rate varchar(10), KeepOr' +
        'der_1_Check varchar(1), KeepOrder_1_1 varchar(10), KeepOrder_1_2' +
        ' varchar(10), KeepOrder_2_Check varchar(1),'
      
        '       KeepOrder_3_Check varchar(1), KeepOrder_4_Check varchar(1' +
        '), KeepOrder_4_1 varchar(10), KeepOrder_4_2 varchar(10),  KeepOr' +
        'der_5_Check varchar(1),  KeepOrder_6_Check varchar(1));')
    UpdateSQL = asqUpSQL_Option
    Left = 848
    Top = 112
  end
  object cds_Temp: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'SN'
        DataType = ftInteger
      end
      item
        Name = 'StockNO'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'TradeDate'
        DataType = ftDate
      end
      item
        Name = 'TickTime'
        DataType = ftTime
      end
      item
        Name = 'BuyPrice'
        DataType = ftFloat
      end
      item
        Name = 'SellPrice'
        DataType = ftFloat
      end
      item
        Name = 'TradePrice'
        DataType = ftFloat
      end
      item
        Name = 'Qty'
        DataType = ftInteger
      end
      item
        Name = 'AveP'
        DataType = ftFloat
      end
      item
        Name = 'BuyQty'
        DataType = ftFloat
      end
      item
        Name = 'SellQty'
        DataType = ftFloat
      end
      item
        Name = 'TickQty'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'Provider_Temp'
    StoreDefs = True
    Left = 584
    Top = 40
  end
  object Provider_Temp: TDataSetProvider
    DataSet = asqQU_TradeRecord
    Left = 488
    Top = 40
  end
end
