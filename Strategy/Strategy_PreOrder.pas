unit Strategy_PreOrder;

interface

uses Classes, SysUtils, ASGSQLite3, StdCtrls, Graphics, Public_Variant;

function GetPreOrder_Check(): boolean;
function GoStrategy_PreOrder(): boolean;  // Strategy is created
function PreOrder_Active(CommNO: String): boolean;

implementation

uses DB_GetData, DMRecord, DB_Type, DB_Handle, getK_Value, ChungYi_Main, TopValue,
     StringList_Fun;

function GoStrategy_PreOrder(): boolean;  // Strategy is created
begin
  if (DataModule1.asq_NewParam.RecordCount = 0) or (not GetPreOrder_Check) then begin
      Result:= false ;
      fmChungYi.GroupPreOrder.Color:= clBtnFace;
      fmChungYi.dbcPreOrder_1_Check.Color:= clWindow;
      fmChungYi.dbcPreOrder_2_Check.Color:= clWindow;
      fmChungYi.dbcPreOrder_3_Check.Color:= clWindow;
      fmChungYi.dbcPreOrder_4_Check.Color:= clWindow;
      fmChungYi.dbcPreOrder_5_Check.Color:= clWindow;
  end else
    Result:= true;
end;

function GetPreOrder_Check(): boolean;
begin
  Result:= DataModule1.asq_NewParam.FieldByName('PreOrder_Check').AsString= 'T';
end;

function PreOrder_Active(CommNO: String): boolean;
var InvenResult: TInventory_Stock;
    Rule_1, Rule_2, Rule_3, Rule_4, Rule_5: boolean;
    PreOrder_Rate: Integer;
    D09: Extended;
    K_Qty: Integer;
begin
  PreOrder_Rate:= 0;
  InvenResult:= DB_Handle.CheckInventory(CommNO);
  D09:= InvenResult.LastPrice;
  K_Qty:= DataModule1.asq_NewParam.FieldByName('PreOrder_1').AsInteger;
  if(K_Qty = 0) then
    exit;

  if InvenResult.LeftQty > 0 then begin
    if (InvenResult.LastBuySell='B') then begin
      // #1
      if(DataModule1.asq_NewParam.FieldByName('PreOrder_1_Check').AsString= 'T') then
        Rule_1:= sStrategy_new.D01_K_NowClose < D09 - DataModule1.asq_NewParam.FieldByName('PreOrder_1').AsFloat;
      // #2
      if(DataModule1.asq_NewParam.FieldByName('PreOrder_2_Check').AsString= 'T') then
        Rule_2:= sStrategy_new.D01_K_NowClose < sStrategy_new.D76_LastClose - DataModule1.asq_NewParam.FieldByName('PreOrder_2').AsFloat;
      // #3
      if(DataModule1.asq_NewParam.FieldByName('PreOrder_3_Check').AsString= 'T') then
        Rule_3:= sStrategy_new.D01_K_NowClose < sStrategy_new.D75_LastLow;
      // #4
      if(DataModule1.asq_NewParam.FieldByName('PreOrder_4_Check').AsString= 'T') then
        Rule_4:= sStrategy_new.D01_K_NowClose < sStrategy_new.D72_1stLow;
      // #5
      if(DataModule1.asq_NewParam.FieldByName('PreOrder_5_Check').AsString= 'T') then
        Rule_5:= sStrategy_new.D01_K_NowClose < GetMin_fromN(LowList, HighList.Count - 1 - K_Qty + 1, K_Qty);
    end else begin
      // #1
      if(DataModule1.asq_NewParam.FieldByName('PreOrder_1_Check').AsString= 'T') then
        Rule_1:= sStrategy_new.D01_K_NowClose > D09 + DataModule1.asq_NewParam.FieldByName('PreOrder_1').AsFloat;
      // #2
      if(DataModule1.asq_NewParam.FieldByName('PreOrder_2_Check').AsString= 'T') then
        Rule_2:= sStrategy_new.D01_K_NowClose > sStrategy_new.D76_LastClose + DataModule1.asq_NewParam.FieldByName('PreOrder_2').AsFloat;
      // #3
      if(DataModule1.asq_NewParam.FieldByName('PreOrder_3_Check').AsString= 'T') then
        Rule_3:= sStrategy_new.D01_K_NowClose > sStrategy_new.D75_LastLow;
      // #4
      if(DataModule1.asq_NewParam.FieldByName('PreOrder_4_Check').AsString= 'T') then
        Rule_4:= sStrategy_new.D01_K_NowClose > sStrategy_new.D72_1stLow;
      // #5
      if(DataModule1.asq_NewParam.FieldByName('PreOrder_5_Check').AsString= 'T') then
        Rule_5:= sStrategy_new.D01_K_NowClose > GetMax_fromN(HighList, HighList.Count - 1 - K_Qty + 1, K_Qty);
    end;
  end else begin
    Result:= false;
    Exit;
  end;

  if Rule_1 then begin
    PreOrder_Rate:= PreOrder_Rate + 1;
    fmChungYi.dbcPreOrder_1_Check.Color:= clRed;
  end else
    fmChungYi.dbcPreOrder_1_Check.Color:= clWindow;

  if Rule_2 then begin
    PreOrder_Rate:= PreOrder_Rate + 1;
    fmChungYi.dbcPreOrder_2_Check.Color:= clRed;
  end else
    fmChungYi.dbcPreOrder_2_Check.Color:= clWindow;

  if Rule_3 then begin
    PreOrder_Rate:= PreOrder_Rate + 1;
    fmChungYi.dbcPreOrder_3_Check.Color:= clRed;
  end else
    fmChungYi.dbcPreOrder_3_Check.Color:= clWindow;

  if Rule_4 then begin
    PreOrder_Rate:= PreOrder_Rate + 1;
    fmChungYi.dbcPreOrder_4_Check.Color:= clRed;
  end else
    fmChungYi.dbcPreOrder_4_Check.Color:= clWindow;

  if Rule_5 then begin
    PreOrder_Rate:= PreOrder_Rate + 1;
    fmChungYi.dbcPreOrder_5_Check.Color:= clRed;
  end else
    fmChungYi.dbcPreOrder_5_Check.Color:= clWindow;

  if(PreOrder_Rate >= DataModule1.asq_NewParam.FieldByName('PreOrder_Rate').AsInteger) then begin
    Result:= true;
    fmChungYi.GroupPreOrder.Color:= clRed;
  end else
    fmChungYi.GroupPreOrder.Color:= clBtnFace;

end;

end.
