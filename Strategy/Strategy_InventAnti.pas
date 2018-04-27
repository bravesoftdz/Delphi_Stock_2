unit Strategy_InventAnti;

interface

uses Classes, SysUtils, ASGSQLite3, StdCtrls, Graphics, Public_Variant;

function GetInventAnti_Check(): boolean;
function GoStrategy_InventAnti(): boolean;  // Strategy is created
function InventAnti_Active(CommNO: String): boolean;

implementation

uses DB_GetData, DMRecord, DB_Type, DB_Handle, getK_Value, ChungYi_Main, TopValue,
     StringList_Fun;

function GoStrategy_InventAnti(): boolean;  // Strategy is created
begin
  if (DataModule1.asq_NewParam.RecordCount = 0) or (not GetInventAnti_Check) then begin
      Result:= false ;
      fmChungYi.Group_InventAnti.Color:= clBtnFace;
      fmChungYi.dbcInventAnti_1_Check.Color:= clWindow;
      fmChungYi.dbcInventAnti_2_Check.Color:= clWindow;
      fmChungYi.dbcInventAnti_3_Check.Color:= clWindow;
      fmChungYi.dbcInventAnti_4_Check.Color:= clWindow;
      fmChungYi.dbcInventAnti_5_Check.Color:= clWindow;
  end else
    Result:= true;
end;

function GetInventAnti_Check(): boolean;
begin
  Result:= DataModule1.asq_NewParam.FieldByName('InventAnti_Check').AsString= 'T';
end;

function InventAnti_Active(CommNO: String): boolean;
var InvenResult: TInventory_Stock;
    Rule_1, Rule_2, Rule_3, Rule_4, Rule_5: boolean;
    InventAnti_Rate: Integer;
    D09: Extended;
    K_Qty: Integer;
begin
  InventAnti_Rate:= 0;
  InvenResult:= DB_Handle.CheckInventory(CommNO);
  D09:= InvenResult.LastPrice;
  K_Qty:= DataModule1.asq_NewParam.FieldByName('InventAnti_2_2').AsInteger;
  if(K_Qty = 0) then
    exit;

  if InvenResult.LeftQty > 0 then begin
    if (InvenResult.LastBuySell='B') then begin
      // #1
      if(DataModule1.asq_NewParam.FieldByName('InventAnti_1_Check').AsString= 'T') then
        Rule_1:= (sStrategy_new.D01_K_NowClose < D09 - DataModule1.asq_NewParam.FieldByName('InventAnti_1').AsFloat);
      // #2
      if(DataModule1.asq_NewParam.FieldByName('InventAnti_2_Check').AsString= 'T') then
        Rule_2:= (sStrategy_new.D01_K_NowClose < D09 - DataModule1.asq_NewParam.FieldByName('InventAnti_2_1').AsFloat)
            and (sStrategy_new.D01_K_NowClose < GetMin_fromN(LowList, LowList.Count - 1 - K_Qty + 1, K_Qty));
      // #3
      if(DataModule1.asq_NewParam.FieldByName('InventAnti_3_Check').AsString= 'T') then
        Rule_3:= (sStrategy_new.D01_K_NowClose < D09 - DataModule1.asq_NewParam.FieldByName('InventAnti_3_1').AsFloat)
            and (sStrategy_new.J02_NowCloseAve < D09);
      // #4
      if(DataModule1.asq_NewParam.FieldByName('InventAnti_4_Check').AsString= 'T') then
        Rule_4:= (sStrategy_new.D01_K_NowClose < D09 - DataModule1.asq_NewParam.FieldByName('InventAnti_4_1').AsFloat)
            and (sStrategy_new.D61_BestBuyAve < sStrategy_new.D62_BestSellAve);
      // #5
      if(DataModule1.asq_NewParam.FieldByName('InventAnti_5_Check').AsString= 'T') then
        Rule_5:= (sStrategy_new.D01_K_NowClose < D09 - DataModule1.asq_NewParam.FieldByName('InventAnti_5_1').AsFloat)
            and (sStrategy_new.J02_NowCloseAve < sStrategy_new.J03_PreCloseAve);
    end else begin
      // #1
      if(DataModule1.asq_NewParam.FieldByName('InventAnti_1_Check').AsString= 'T') then
        Rule_1:= (sStrategy_new.D01_K_NowClose > D09 - DataModule1.asq_NewParam.FieldByName('InventAnti_1').AsFloat);
      // #2
      if(DataModule1.asq_NewParam.FieldByName('InventAnti_2_Check').AsString= 'T') then
        Rule_2:= (sStrategy_new.D01_K_NowClose < D09 - DataModule1.asq_NewParam.FieldByName('InventAnti_2_1').AsFloat)
            and (sStrategy_new.D01_K_NowClose < GetMax_fromN(LowList, HighList.Count - 1 - K_Qty + 1, K_Qty));
      // #3
      if(DataModule1.asq_NewParam.FieldByName('InventAnti_3_Check').AsString= 'T') then
        Rule_3:= (sStrategy_new.D01_K_NowClose > D09 + DataModule1.asq_NewParam.FieldByName('InventAnti_3_1').AsFloat)
            and (sStrategy_new.J02_NowCloseAve > D09);
      // #4
      if(DataModule1.asq_NewParam.FieldByName('InventAnti_4_Check').AsString= 'T') then
        Rule_4:= (sStrategy_new.D01_K_NowClose > D09 + DataModule1.asq_NewParam.FieldByName('InventAnti_4_1').AsFloat)
            and (sStrategy_new.D61_BestBuyAve > sStrategy_new.D62_BestSellAve);
      // #5
      if(DataModule1.asq_NewParam.FieldByName('InventAnti_5_Check').AsString= 'T') then
        Rule_5:= (sStrategy_new.D01_K_NowClose > D09 + DataModule1.asq_NewParam.FieldByName('InventAnti_5_1').AsFloat)
            and (sStrategy_new.J02_NowCloseAve > sStrategy_new.J03_PreCloseAve);
    end;
  end else begin
    Result:= false;
    Exit;
  end;

  if Rule_1 then begin
    InventAnti_Rate:= InventAnti_Rate + 1;
    fmChungYi.dbcInventAnti_1_Check.Color:= clRed;
  end else
    fmChungYi.dbcInventAnti_1_Check.Color:= clWindow;

  if Rule_2 then begin
    InventAnti_Rate:= InventAnti_Rate + 1;
    fmChungYi.dbcInventAnti_2_Check.Color:= clRed;
  end else
    fmChungYi.dbcInventAnti_2_Check.Color:= clWindow;

  if Rule_3 then begin
    InventAnti_Rate:= InventAnti_Rate + 1;
    fmChungYi.dbcInventAnti_3_Check.Color:= clRed;
  end else
    fmChungYi.dbcInventAnti_3_Check.Color:= clWindow;

  if Rule_4 then begin
    InventAnti_Rate:= InventAnti_Rate + 1;
    fmChungYi.dbcInventAnti_4_Check.Color:= clRed;
  end else
    fmChungYi.dbcInventAnti_4_Check.Color:= clWindow;

  if Rule_5 then begin
    InventAnti_Rate:= InventAnti_Rate + 1;
    fmChungYi.dbcInventAnti_5_Check.Color:= clRed;
  end else
    fmChungYi.dbcInventAnti_5_Check.Color:= clWindow;

  if(InventAnti_Rate >= DataModule1.asq_NewParam.FieldByName('InventAnti_Rate').AsInteger) then begin
    Result:= true;
    fmChungYi.Group_InventAnti.Color:= clRed;
  end else
    fmChungYi.Group_InventAnti.Color:= clBtnFace;

end;

end.
