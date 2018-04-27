unit Strategy_Special_2;

interface

uses Classes, SysUtils, ASGSQLite3, StdCtrls, Graphics, Public_Variant;

function GoStrategy_Special_2(): boolean;
function GetSpecial2_Check(): boolean;
function IsSpecial_2_Order(): boolean;
function Special_2_Active(CommNO: String): boolean;


implementation

uses DB_GetData, DMRecord, DB_Type, DB_Handle, getK_Value, ChungYi_Main, TopValue;


function GoStrategy_Special_2(): boolean;  // Strategy is created
begin
  if (DataModule1.asq_NewParam.RecordCount = 0) or (not GetSpecial2_Check)
    or IsSpecial_OrderToday then begin
      Result:= false ;
      fmChungYi.Group_Special_2.Color:= clBtnFace;
      fmChungYi.dbeSpec_2_1.Color:= clWindow;
      fmChungYi.dbeSpec_2_2.Color:= clWindow;
      fmChungYi.dbeSpec_2_3.Color:= clWindow;
  end else
    Result:= true;
end;

function GetSpecial2_Check(): boolean;
begin
  Result:= DataModule1.asq_NewParam.FieldByName('Spec_2_Check').AsString= 'T';
end;

function IsSpecial_2_Order(): boolean;
var sql_str: String;
begin
  sql_str:= 'select * from RecordMsg order by SN desc limit 1';
  DB_GetData.GetFree_Sql(sql_str, DataModule1.asqQU_Temp);
  if(DataModule1.asqQU_Temp.RecordCount > 0)
    and (DataModule1.asqQU_Temp.FieldByName('OrderStrategy').AsString= OrderSpecial_2) then begin
      Result:= true;
  end else Result:= false;
end;

function Special_2_Active(CommNO: String): boolean;
var InvenResult: TInventory_Stock;
    Rule_1, Rule_2, Rule_3: boolean;
    Special_2_Rate: Integer;
begin

  Special_2_Rate:= 0;
  InvenResult:= DB_Handle.CheckInventory(CommNO);
  if InvenResult.LeftQty > 0 then begin
    if (InvenResult.LastBuySell='B') then begin
      // #1
      Rule_1:= sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen - DataModule1.asq_NewParam.FieldByName('Spec_1_1').AsFloat;
      // #2
      Rule_2:= (sStrategy_new.D01_K_NowClose + sStrategy_new.D11_K_NowHigh)/2 < (sStrategy_new.D21_K_NowOpen + sStrategy_new.D11_K_NowHigh)/2 - DataModule1.asq_NewParam.FieldByName('Spec_1_2').AsFloat;
      // #3
      Rule_3:= (sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 - DataModule1.asq_NewParam.FieldByName('Spec_1_3').AsFloat;
    end else begin
      // #1
      Rule_1:= sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen + DataModule1.asq_NewParam.FieldByName('Spec_1_1').AsFloat;
      // #2
      Rule_2:= (sStrategy_new.D01_K_NowClose + sStrategy_new.D16_K_NowLow)/2 > (sStrategy_new.D21_K_NowOpen + sStrategy_new.D16_K_NowLow)/2 + DataModule1.asq_NewParam.FieldByName('Spec_1_2').AsFloat;
      // #2
      Rule_3:= (sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 > (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 + DataModule1.asq_NewParam.FieldByName('Spec_1_3').AsFloat;
    end;
  end else begin

  end;

  if Rule_1 then begin
    Special_2_Rate:= Special_2_Rate + 1;
    fmChungYi.dbeSpec_2_1.Color:= clRed;
  end else
    fmChungYi.dbeSpec_2_1.Color:= clWindow;

  if Rule_2 then begin
    Special_2_Rate:= Special_2_Rate + 1;
    fmChungYi.dbeSpec_2_2.Color:= clRed;
  end else
    fmChungYi.dbeSpec_2_2.Color:= clWindow;

  if Rule_3 then begin
    Special_2_Rate:= Special_2_Rate + 1;
    fmChungYi.dbeSpec_2_3.Color:= clRed;
  end else
    fmChungYi.dbeSpec_2_3.Color:= clWindow;

  if(Special_2_Rate >= DataModule1.asq_NewParam.FieldByName('Spec_2_Rate').AsInteger) then begin
    Result:= true;
    fmChungYi.Group_Special_2.Color:= clRed;
  end else
    fmChungYi.Group_Special_2.Color:= clBtnFace;

end;

end.
