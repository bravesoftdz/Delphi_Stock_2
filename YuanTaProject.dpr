program YuanTaProject;

uses
  Forms,
  ChungYi_Main in 'ChungYi_Main.pas' {fmChungYi},
  DMRecord in 'DMRecord.pas' {DataModule1: TDataModule},
  SQLFunction in '..\..\Functions\SQLFunction.pas',
  Quote in 'Quote.pas' {fmQuote},
  Quote_uSKQ in '..\..\Functions\Captal_API\Quote_uSKQ.pas',
  MathFunction in '..\..\Functions\MathFunction.pas',
  Public_Variant in 'Public_Variant.pas',
  GeneralFunction in 'GeneralFunction.pas',
  Strategy in 'Strategy.pas',
  DataDownLoad in 'DataDownLoad.pas',
  StringList_Fun in '..\..\Functions\StringList_Fun.pas',
  DataParsing in 'DataParsing.pas',
  Stock_OptionOrder in 'Stock_OptionOrder.pas',
  RegistryGetSet in '..\..\Functions\RegistryGetSet.pas',
  String_Form in '..\..\Functions\String_Form.pas',
  SQLFunc in 'SQLFunc.pas',
  SetParameter in 'SetParameter.pas',
  ASGRout3 in '..\..\..\sqlite2010\sqlite2009\ASGRout3.pas',
  ASGSQLite3 in '..\..\..\sqlite2010\sqlite2009\ASGSQLite3.pas',
  ASGSQLiteData in '..\..\..\sqlite2010\sqlite2009\ASGSQLiteData.pas',
  SKCOMLib_TLB in 'C:\Users\Steven\Documents\RAD Studio\6.0\Imports\SKCOMLib_TLB.pas',
  StockHandle in 'StockHandle\StockHandle.pas',
  OverSeasOrder in 'OverseaOrder\OverSeasOrder.pas',
  String_Handle in 'GeneralFun\String_Handle.pas',
  DB_Handle in 'DB_Handle\DB_Handle.pas',
  DB_Upgrade in 'DB_Handle\DB_Upgrade.pas',
  DB_GetData in 'DB_Handle\DB_GetData.pas',
  DB_Type in 'DB_Handle\DB_Type.pas',
  CheckNetwork in 'GeneralFun\CheckNetwork.pas',
  K_Calculate in 'K_Value\K_Calculate.pas',
  getK_Value in 'K_Value\getK_Value.pas',
  Strategy_Special_2 in 'Strategy\Strategy_Special_2.pas',
  ThreadHandle in 'Thread_Handle\ThreadHandle.pas',
  AdjustField in 'MrChou\AdjustField.pas',
  Calculate_Grid in 'MrChou\Calculate_Grid.pas',
  TopValue in 'Strategy\TopValue.pas',
  Strategy_Profit in 'Strategy\Strategy_Profit.pas',
  Strategy_Float in 'Strategy\Strategy_Float.pas',
  Strategy_Special in 'Strategy\Strategy_Special.pas',
  Strategy_Engine in 'Strategy\Strategy_Engine.pas',
  Strategy_Internal in 'Strategy\Strategy_Internal.pas',
  K_Line_Save in 'K_Value\K_Line_Save.pas',
  Strategy_KeepOrder in 'Strategy\Strategy_KeepOrder.pas',
  Strategy_PreOrder in 'Strategy\Strategy_PreOrder.pas',
  GeneralValue in 'Strategy\GeneralValue.pas',
  Strategy_InventAnti in 'Strategy\Strategy_InventAnti.pas',
  Initial_K in 'K_Value\Initial_K.pas',
  SystemFun in '..\..\Functions\SystemFun.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Public_Variant.UserNM:= 'JackyChou';
//  Public_Variant.UserNM:= 'MrHuang';
  Application.CreateForm(TfmChungYi, fmChungYi);
  //  Application.CreateForm(TFMD, FMD);
  Application.Run;
end.
