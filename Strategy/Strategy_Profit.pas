unit Strategy_Profit;

interface

uses Classes, SysUtils, ASGSQLite3, StdCtrls, Graphics, Public_Variant;

function GoStrategy_Profit(): boolean;
function GetProfit_Check(): boolean;
function Profit_Active(CommNO: String): boolean;

implementation

uses DB_GetData, DMRecord, DB_Type, DB_Handle, getK_Value, ChungYi_Main, TopValue,
     StringList_Fun;

function GoStrategy_Profit(): boolean;  // Strategy is created
begin
  if (DataModule1.asq_NewParam.RecordCount = 0) or (not GetProfit_Check) then begin
      Result:= false ;
      fmChungYi.Group_Profit.Color:= clBtnFace;
      fmChungYi.dbcProfit_1_Check.Color:= clWindow;
      fmChungYi.dbcProfit_2_Check.Color:= clWindow;
      fmChungYi.dbcProfit_3_Check.Color:= clWindow;
  end else
    Result:= true;
end;

function GetProfit_Check(): boolean;
begin
  Result:= DataModule1.asq_NewParam.FieldByName('Profit_Check').AsString= 'T';
end;

function Profit_Active(CommNO: String): boolean;
var InvenResult: TInventory_Stock;
    Rule_1, Rule_2, Rule_3: boolean;
    Profit_Rate: Integer;
    D09: Extended;
    K_Qty: Integer;
begin
  Profit_Rate:= 0;
  InvenResult:= DB_Handle.CheckInventory(CommNO);
  D09:= InvenResult.LastPrice;
  K_Qty:= DataModule1.asq_NewParam.FieldByName('PreOrder_1').AsInteger;
  if(K_Qty = 0) then
    exit;

  if InvenResult.LeftQty > 0 then begin
    if (InvenResult.LastBuySell='B') then begin
      // #1
      if(DataModule1.asq_NewParam.FieldByName('Profit_1_Check').AsString= 'T') then
        Rule_1:= (D09 - sStrategy_new.D53_Inventory_Max >= DataModule1.asq_NewParam.FieldByName('Profit_1_1').AsFloat)
          and (D09 < sStrategy_new.D01_K_NowClose)
          and (sStrategy_new.D01_K_NowClose <= (D09 - sStrategy_new.D53_Inventory_Max) * DataModule1.asq_NewParam.FieldByName('Profit_1_2').AsFloat + sStrategy_new.D53_Inventory_Max);
      // #2
      if(DataModule1.asq_NewParam.FieldByName('Profit_2_Check').AsString= 'T') then
        Rule_1:= (D09 - sStrategy_new.D53_Inventory_Max >= DataModule1.asq_NewParam.FieldByName('Profit_2_1').AsFloat)
          and (D09 < sStrategy_new.D01_K_NowClose)
          and (sStrategy_new.D01_K_NowClose <= (D09 - sStrategy_new.D53_Inventory_Max) * DataModule1.asq_NewParam.FieldByName('Profit_2_2').AsFloat + sStrategy_new.D53_Inventory_Max)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < sStrategy_new.J02_NowCloseAve - DataModule1.asq_NewParam.FieldByName('Profit_2_3').AsFloat)
            and (sStrategy_new.J02_NowCloseAve < sStrategy_new.J03_PreCloseAve);
      // #3
      if(DataModule1.asq_NewParam.FieldByName('Profit_3_Check').AsString= 'T') then begin
        // 3-1
        if (D09 - sStrategy_new.D53_Inventory_Max >= DataModule1.asq_NewParam.FieldByName('Profit_3_1_1').AsFloat)
           and (D09 < sStrategy_new.D01_K_NowClose) and (sStrategy_new.D01_K_NowClose <= (D09 - sStrategy_new.D53_Inventory_Max) * DataModule1.asq_NewParam.FieldByName('Profit_3_1_2').AsFloat + sStrategy_new.D53_Inventory_Max) then
            Rule_3:= true
        // 3-2
        else if (D09 - sStrategy_new.D53_Inventory_Max >= DataModule1.asq_NewParam.FieldByName('Profit_3_2_1').AsFloat)
           and (D09 < sStrategy_new.D01_K_NowClose) and (sStrategy_new.D01_K_NowClose <= (D09 - sStrategy_new.D53_Inventory_Max) * DataModule1.asq_NewParam.FieldByName('Profit_3_2_2').AsFloat + sStrategy_new.D53_Inventory_Max) then
            Rule_3:= true
        // 3-3
        else if (D09 - sStrategy_new.D53_Inventory_Max >= DataModule1.asq_NewParam.FieldByName('Profit_3_3_1').AsFloat)
           and (D09 < sStrategy_new.D01_K_NowClose) and (sStrategy_new.D01_K_NowClose <= (D09 - sStrategy_new.D53_Inventory_Max) * DataModule1.asq_NewParam.FieldByName('Profit_3_3_2').AsFloat + sStrategy_new.D53_Inventory_Max) then
            Rule_3:= true
        // 3-4
        else if (D09 - sStrategy_new.D53_Inventory_Max >= DataModule1.asq_NewParam.FieldByName('Profit_3_4_1').AsFloat)
           and (D09 < sStrategy_new.D01_K_NowClose) and (sStrategy_new.D01_K_NowClose <= (D09 - sStrategy_new.D53_Inventory_Max) * DataModule1.asq_NewParam.FieldByName('Profit_3_4_2').AsFloat + sStrategy_new.D53_Inventory_Max) then
            Rule_3:= true
        // 3-5
        else if (D09 - sStrategy_new.D53_Inventory_Max >= DataModule1.asq_NewParam.FieldByName('Profit_3_5_1').AsFloat)
           and (D09 < sStrategy_new.D01_K_NowClose) and (sStrategy_new.D01_K_NowClose <= (D09 - sStrategy_new.D53_Inventory_Max) * DataModule1.asq_NewParam.FieldByName('Profit_3_5_2').AsFloat + sStrategy_new.D53_Inventory_Max) then
            Rule_3:= true;
      end;
        Rule_3:= sStrategy_new.D01_K_NowClose < sStrategy_new.D75_LastLow;
    end else begin
      // #1
      if(DataModule1.asq_NewParam.FieldByName('Profit_1_Check').AsString= 'T') then
        Rule_1:= (D09 - sStrategy_new.D54_Inventory_Min >= DataModule1.asq_NewParam.FieldByName('Profit_1_1').AsFloat)
          and (D09 > sStrategy_new.D01_K_NowClose)
          and (sStrategy_new.D01_K_NowClose >= (D09 - sStrategy_new.D54_Inventory_Min) * DataModule1.asq_NewParam.FieldByName('Profit_1_2').AsFloat + sStrategy_new.D54_Inventory_Min);
      // #2
      if(DataModule1.asq_NewParam.FieldByName('Profit_2_Check').AsString= 'T') then
        Rule_1:= (D09 - sStrategy_new.D54_Inventory_Min >= DataModule1.asq_NewParam.FieldByName('Profit_2_1').AsFloat)
          and (D09 > sStrategy_new.D01_K_NowClose)
          and (sStrategy_new.D01_K_NowClose >= (D09 - sStrategy_new.D54_Inventory_Min) * DataModule1.asq_NewParam.FieldByName('Profit_2_2').AsFloat + sStrategy_new.D54_Inventory_Min)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 > sStrategy_new.J02_NowCloseAve - DataModule1.asq_NewParam.FieldByName('Profit_2_3').AsFloat)
            and (sStrategy_new.J02_NowCloseAve > sStrategy_new.J03_PreCloseAve);

      // #3
      if(DataModule1.asq_NewParam.FieldByName('Profit_3_Check').AsString= 'T') then begin
        // 3-1
        if (D09 - sStrategy_new.D54_Inventory_Min >= DataModule1.asq_NewParam.FieldByName('Profit_3_1_1').AsFloat)
           and (D09 > sStrategy_new.D01_K_NowClose) and (sStrategy_new.D01_K_NowClose >= (D09 - sStrategy_new.D54_Inventory_Min) * DataModule1.asq_NewParam.FieldByName('Profit_3_1_2').AsFloat + sStrategy_new.D53_Inventory_Max) then
            Rule_3:= true
        // 3-2
        else if (D09 - sStrategy_new.D54_Inventory_Min >= DataModule1.asq_NewParam.FieldByName('Profit_3_2_1').AsFloat)
           and (D09 > sStrategy_new.D01_K_NowClose) and (sStrategy_new.D01_K_NowClose >= (D09 - sStrategy_new.D54_Inventory_Min) * DataModule1.asq_NewParam.FieldByName('Profit_3_2_2').AsFloat + sStrategy_new.D53_Inventory_Max) then
            Rule_3:= true
        // 3-3
        else if (D09 - sStrategy_new.D54_Inventory_Min >= DataModule1.asq_NewParam.FieldByName('Profit_3_3_1').AsFloat)
           and (D09 > sStrategy_new.D01_K_NowClose) and (sStrategy_new.D01_K_NowClose >= (D09 - sStrategy_new.D54_Inventory_Min) * DataModule1.asq_NewParam.FieldByName('Profit_3_3_2').AsFloat + sStrategy_new.D53_Inventory_Max) then
            Rule_3:= true
        // 3-4
        else if (D09 - sStrategy_new.D54_Inventory_Min >= DataModule1.asq_NewParam.FieldByName('Profit_3_4_1').AsFloat)
           and (D09 > sStrategy_new.D01_K_NowClose) and (sStrategy_new.D01_K_NowClose >= (D09 - sStrategy_new.D54_Inventory_Min) * DataModule1.asq_NewParam.FieldByName('Profit_3_4_2').AsFloat + sStrategy_new.D53_Inventory_Max) then
            Rule_3:= true
        // 3-5
        else if (D09 - sStrategy_new.D54_Inventory_Min >= DataModule1.asq_NewParam.FieldByName('Profit_3_5_1').AsFloat)
           and (D09 > sStrategy_new.D01_K_NowClose) and (sStrategy_new.D01_K_NowClose >= (D09 - sStrategy_new.D54_Inventory_Min) * DataModule1.asq_NewParam.FieldByName('Profit_3_5_2').AsFloat + sStrategy_new.D53_Inventory_Max) then
            Rule_3:= true;
      end;
        Rule_3:= sStrategy_new.D01_K_NowClose > sStrategy_new.D75_LastLow;
    end;
  end else begin
    Result:= false;
    Exit;
  end;

  if Rule_1 then begin
    Profit_Rate:= Profit_Rate + 1;
    fmChungYi.dbcProfit_1_Check.Color:= clRed;
  end else
    fmChungYi.dbcProfit_1_Check.Color:= clWindow;

  if Rule_2 then begin
    Profit_Rate:= Profit_Rate + 1;
    fmChungYi.dbcProfit_2_Check.Color:= clRed;
  end else
    fmChungYi.dbcProfit_2_Check.Color:= clWindow;

  if Rule_3 then begin
    Profit_Rate:= Profit_Rate + 1;
    fmChungYi.dbcProfit_3_Check.Color:= clRed;
  end else
    fmChungYi.dbcProfit_3_Check.Color:= clWindow;

  if(Profit_Rate >= DataModule1.asq_NewParam.FieldByName('Profit_Rate').AsInteger) then begin
    Result:= true;
    fmChungYi.Group_Profit.Color:= clRed;
  end else
    fmChungYi.Group_Profit.Color:= clBtnFace;

end;

end.
