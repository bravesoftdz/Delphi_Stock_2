unit Strategy_Float;

interface

uses Classes, SysUtils, ASGSQLite3, StdCtrls, Graphics, Public_Variant;

function GetFloat_Check(): boolean;
function GoStrategy_Float(): boolean;  // Strategy is created
function Float_Active(CommNO: String): boolean;

implementation

uses DB_GetData, DMRecord, DB_Type, DB_Handle, getK_Value, ChungYi_Main, TopValue,
     StringList_Fun;

function GoStrategy_Float(): boolean;  // Strategy is created
begin
  if (DataModule1.asq_NewParam.RecordCount = 0) or (not GetFloat_Check) then begin
      Result:= false ;
      fmChungYi.Group_Float.Color:= clBtnFace;
      fmChungYi.dbcFloat_1_Check.Color:= clWindow;
      fmChungYi.dbcFloat_2_Check.Color:= clWindow;
      fmChungYi.dbcFloat_3_Check.Color:= clWindow;
      fmChungYi.dbcFloat_4_Check.Color:= clWindow;
      fmChungYi.dbcFloat_5_Check.Color:= clWindow;
  end else
    Result:= true;
end;

function GetFloat_Check(): boolean;
begin
  Result:= DataModule1.asq_NewParam.FieldByName('Float_Check').AsString= 'T';
end;

function Float_Active(CommNO: String): boolean;
var InvenResult: TInventory_Stock;
    Rule_1, Rule_2, Rule_3, Rule_4, Rule_5, Rule_6: boolean;
    Float_Rate: Integer;
    D09: Extended;
    K_Qty: Integer;
    a5_a4: Extended;
begin
  Float_Rate:= 0;
  InvenResult:= DB_Handle.CheckInventory(CommNO);
  D09:= InvenResult.LastPrice;
  K_Qty:= DataModule1.asq_NewParam.FieldByName('Float_1_1').AsInteger;
  if(K_Qty = 0) then
    exit;

  // #1
      if(DataModule1.asq_NewParam.FieldByName('Float_1_Check').AsString= 'T') then
        Rule_1:= (sStrategy_new.J02_NowCloseAve <= GetMin_fromN(AveList, AveList.Count - 1 - K_Qty + 1, K_Qty) + DataModule1.asq_NewParam.FieldByName('Float_1_2').AsFloat)
             and (GetMax_fromN(AveList, AveList.Count - 1 - K_Qty + 1, K_Qty) - DataModule1.asq_NewParam.FieldByName('Float_1_2').AsFloat <= sStrategy_new.J02_NowCloseAve);
      // #2
      if(DataModule1.asq_NewParam.FieldByName('Float_2_Check').AsString= 'T') then
        Rule_2:= (sStrategy_new.J02_NowCloseAve < (sStrategy_new.J12_NowHighAve + sStrategy_new.J17_NowLowAve)/2 + DataModule1.asq_NewParam.FieldByName('Float_2_1').AsFloat)
            and ((sStrategy_new.J12_NowHighAve + sStrategy_new.J17_NowLowAve)/2 + DataModule1.asq_NewParam.FieldByName('Float_2_1').AsFloat < sStrategy_new.J02_NowCloseAve);
      // #3
      if(DataModule1.asq_NewParam.FieldByName('Float_3_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('Float_3_1').AsInteger;
        Rule_3:= (sStrategy_new.D01_K_NowClose < GetMin_fromN(LowList, LowList.Count - 1 - K_Qty + 1, K_Qty) + DataModule1.asq_NewParam.FieldByName('Float_3_2').AsFloat)
            and (GetMax_fromN(HighList, HighList.Count - 1 - K_Qty + 1, K_Qty) - DataModule1.asq_NewParam.FieldByName('Float_3_2').AsFloat < sStrategy_new.D01_K_NowClose);
      end;
      // #4
      if(DataModule1.asq_NewParam.FieldByName('Float_4_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('Float_4_1').AsInteger;
        a5_a4:= (GetMin_fromN(LowList, LowList.Count - 1 - K_Qty + 1, K_Qty) + DataModule1.asq_NewParam.FieldByName('Float_4_2').AsFloat
               + GetMax_fromN(HighList, HighList.Count - 1 - K_Qty + 1, K_Qty) + DataModule1.asq_NewParam.FieldByName('Float_4_2').AsFloat)/2;
        Rule_4:= (sStrategy_new.D01_K_NowClose < a5_a4 + DataModule1.asq_NewParam.FieldByName('dbeFloat_4_1').AsFloat)
            and (a5_a4 - DataModule1.asq_NewParam.FieldByName('dbeFloat_4_1').AsFloat < sStrategy_new.D01_K_NowClose);
      end;
      // #5
      if(DataModule1.asq_NewParam.FieldByName('Float_5_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('Float_5_1').AsInteger;
        Rule_5:= (sStrategy_new.D01_K_NowClose < GetMax_fromN(HighList, HighList.Count - 1 - K_Qty + 1, K_Qty))
            and (GetMin_fromN(LowList, LowList.Count - 1 - K_Qty + 1, K_Qty) < sStrategy_new.D01_K_NowClose);
      end;
      // #6
      if(DataModule1.asq_NewParam.FieldByName('Float_6_Check').AsString= 'T') then begin
        Rule_6:= (sStrategy_new.D26_K_NowQty < sStrategy_new.J28_PreAllQtyAve);
      end;

  if Rule_1 then begin
    Float_Rate:= Float_Rate + 1;
    fmChungYi.dbcFloat_1_Check.Color:= clRed;
  end else
    fmChungYi.dbcFloat_1_Check.Color:= clWindow;

  if Rule_2 then begin
    Float_Rate:= Float_Rate + 1;
    fmChungYi.dbcFloat_2_Check.Color:= clRed;
  end else
    fmChungYi.dbcFloat_2_Check.Color:= clWindow;

  if Rule_3 then begin
    Float_Rate:= Float_Rate + 1;
    fmChungYi.dbcFloat_3_Check.Color:= clRed;
  end else
    fmChungYi.dbcFloat_3_Check.Color:= clWindow;

  if Rule_4 then begin
    Float_Rate:= Float_Rate + 1;
    fmChungYi.dbcFloat_4_Check.Color:= clRed;
  end else
    fmChungYi.dbcFloat_4_Check.Color:= clWindow;

  if Rule_5 then begin
    Float_Rate:= Float_Rate + 1;
    fmChungYi.dbcFloat_5_Check.Color:= clRed;
  end else
    fmChungYi.dbcFloat_5_Check.Color:= clWindow;

  if Rule_6 then begin
    Float_Rate:= Float_Rate + 1;
    fmChungYi.dbcFloat_6_Check.Color:= clRed;
  end else
    fmChungYi.dbcFloat_6_Check.Color:= clWindow;

  if(Float_Rate >= DataModule1.asq_NewParam.FieldByName('Float_Rate').AsInteger) then begin
    Result:= true;
    fmChungYi.Group_Float.Color:= clRed;
  end else
    fmChungYi.Group_Float.Color:= clBtnFace;

end;

end.
