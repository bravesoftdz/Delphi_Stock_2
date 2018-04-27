unit Strategy_KeepOrder;

interface

uses Classes, SysUtils, ASGSQLite3, StdCtrls, Graphics, Public_Variant;

function GetKeepOrder_Check(): boolean;
function GoStrategy_KeepOrder(): boolean;  // Strategy is created
function KeepOrder_Active(CommNO: String): boolean;

implementation

uses DB_GetData, DMRecord, DB_Type, DB_Handle, getK_Value, ChungYi_Main, TopValue,
     StringList_Fun, K_Line_Save, K_Calculate;

function GoStrategy_KeepOrder(): boolean;  // Strategy is created
begin
  if (DataModule1.asq_NewParam.RecordCount = 0) or (not GetKeepOrder_Check) then begin
      Result:= false ;
      fmChungYi.Group_KeepOrder.Color:= clBtnFace;
      fmChungYi.dbcKeepOrder_1_Check.Color:= clWindow;
      fmChungYi.dbcKeepOrder_2_Check.Color:= clWindow;
      fmChungYi.dbcKeepOrder_3_Check.Color:= clWindow;
      fmChungYi.dbcKeepOrder_4_Check.Color:= clWindow;
      fmChungYi.dbcKeepOrder_Check.Color:= clWindow;
  end else
    Result:= true;
end;

function GetKeepOrder_Check(): boolean;
begin
  Result:= DataModule1.asq_NewParam.FieldByName('KeepOrder_Check').AsString= 'T';
end;

function KeepOrder_Active(CommNO: String): boolean;
var InvenResult: TInventory_Stock;
    Rule: array of boolean;
    KeepOrder_Rate: Integer;
    D09: Extended;
    K_Qty: Integer;
    NO_Small: array of Integer;
    Y2, W2: Extended; // Y2: 當日均收, W2: 前日均收
begin
  KeepOrder_Rate:= 0;
  setLength(NO_Small, 5);
  setLength(Rule, 6);
  InvenResult:= DB_Handle.CheckInventory(CommNO);
  D09:= InvenResult.LastPrice;


  if InvenResult.LeftQty > 0 then begin
    if (InvenResult.LastBuySell='B') then begin
      // #1
      if(DataModule1.asq_NewParam.FieldByName('KeepOrder_1_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('KeepOrder_1_1').AsInteger;
        if(K_Qty = 0) then
          exit;
        Y2:= ((StringList_Fun.GetSumValue(DayCloseList, K_Qty - 1, 0, false) + sStrategy_new.D69_TodayClose)/K_Qty);
        W2:= GetAve_withQty(K_Qty, K_CloseList, true);
        Rule[1]:= (Y2 <= W2);
      end;
      // #2
      if(DataModule1.asq_NewParam.FieldByName('KeepOrder_2_Check').AsString= 'T') then begin
        if sStrategy_new.J02_NowCloseAve < sStrategy_new.J03_PreCloseAve then
          NO_Small[1]:= 1;
        if sStrategy_new.J51_NowCloseAve < sStrategy_new.J52_PreCloseAve then
          NO_Small[2]:= 1;
        if (sStrategy_new.J55_NowCloseAve < sStrategy_new.J56_PreCloseAve) then
           NO_Small[3]:= 1;
        if sStrategy_new.J57_NowCloseAve < sStrategy_new.J58_PreCloseAve then
          NO_Small[4]:= 1;
        if sStrategy_new.J59_NowCloseAve < sStrategy_new.J60_PreCloseAve then
          NO_Small[5]:= 1;

        Rule[2]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= 3;
      end;
      // #3
      if(DataModule1.asq_NewParam.FieldByName('KeepOrder_3_Check').AsString= 'T') then begin
        Rule[3]:= ((sStrategy_new.D73_LastOpen <= sStrategy_new.D76_LastClose)
              and (sStrategy_new.D69_TodayClose <= sStrategy_new.D66_TodayOpen))
              or ((sStrategy_new.D76_LastClose <= sStrategy_new.D73_LastOpen)
              and (sStrategy_new.D66_TodayOpen <= sStrategy_new.D69_TodayClose));
      end;
      // #4
      if(DataModule1.asq_NewParam.FieldByName('KeepOrder_4_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('KeepOrder_4_1').AsInteger;
        if(K_Qty = 0) then
          exit;
        Y2:= ((StringList_Fun.GetSumValue(DayCloseList, K_Qty - 1, 0, false) + sStrategy_new.D69_TodayClose)/K_Qty);
        if ((sStrategy_new.D01_K_NowClose < Y2) and (sStrategy_new.D01_K_NowClose < sStrategy_new.D66_TodayOpen))
          or ((Y2 < sStrategy_new.D01_K_NowClose) and (sStrategy_new.D01_K_NowClose < sStrategy_new.D66_TodayOpen)) then
          NO_Small[1]:= 1;
        if (Y2 + DataModule1.asq_NewParam.FieldByName('KeepOrder_4_2').AsFloat < sStrategy_new.D01_K_NowClose)
          or ((sStrategy_new.D01_K_NowClose < Y2 -1) and (Y2 - DataModule1.asq_NewParam.FieldByName('KeepOrder_4_2').AsFloat < sStrategy_new.D01_K_NowClose)) then
          NO_Small[2]:= 1;
        if (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen) then
           NO_Small[3]:= 1;

        Rule[4]:= (NO_Small[1] + NO_Small[2] + NO_Small[3]) >= 2;
      end;
      // #5
      if(DataModule1.asq_NewParam.FieldByName('KeepOrder_5_Check').AsString= 'T') then
        Rule[5]:= (getK_Value.NowBuyQty > 0) and(getK_Value.NowBuyQty <= getK_Value.NowSellQty);

      // #6
      if(DataModule1.asq_NewParam.FieldByName('KeepOrder_6_Check').AsString= 'T') then
        Rule[6]:= sStrategy_new.D69_TodayClose < sStrategy_new.D62_BestSellAve;
    end else begin
      // #1
      if(DataModule1.asq_NewParam.FieldByName('KeepOrder_1_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('KeepOrder_1_1').AsInteger;
        if(K_Qty = 0) then
          exit;
        Y2:= ((StringList_Fun.GetSumValue(DayCloseList, K_Qty - 1, 0, false) + sStrategy_new.D69_TodayClose)/K_Qty);
        W2:= GetAve_withQty(K_Qty, K_CloseList, true);
        Rule[1]:= (Y2 >= W2);
      end;
     // #2
      if(DataModule1.asq_NewParam.FieldByName('KeepOrder_2_Check').AsString= 'T') then begin
        if sStrategy_new.J02_NowCloseAve > sStrategy_new.J03_PreCloseAve then
          NO_Small[1]:= 1;
        if sStrategy_new.J51_NowCloseAve > sStrategy_new.J52_PreCloseAve then
          NO_Small[2]:= 1;
        if (sStrategy_new.J55_NowCloseAve > sStrategy_new.J56_PreCloseAve) then
           NO_Small[3]:= 1;
        if sStrategy_new.J57_NowCloseAve > sStrategy_new.J58_PreCloseAve then
          NO_Small[4]:= 1;
        if sStrategy_new.J59_NowCloseAve > sStrategy_new.J60_PreCloseAve then
          NO_Small[5]:= 1;

        Rule[2]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= 3;
      end;
      // #3
      if(DataModule1.asq_NewParam.FieldByName('KeepOrder_3_Check').AsString= 'T') then begin
        Rule[3]:= ((sStrategy_new.D73_LastOpen >= sStrategy_new.D76_LastClose)
              and (sStrategy_new.D69_TodayClose >= sStrategy_new.D66_TodayOpen))
              or ((sStrategy_new.D76_LastClose >= sStrategy_new.D73_LastOpen)
              and (sStrategy_new.D66_TodayOpen >= sStrategy_new.D69_TodayClose));
      end;
      // #4
      if(DataModule1.asq_NewParam.FieldByName('KeepOrder_4_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('KeepOrder_4_1').AsInteger;
        if(K_Qty = 0) then
          exit;
        Y2:= ((StringList_Fun.GetSumValue(DayCloseList, K_Qty - 1, 0, false) + sStrategy_new.D69_TodayClose)/K_Qty);
        if ((sStrategy_new.D01_K_NowClose > Y2) and (sStrategy_new.D01_K_NowClose > sStrategy_new.D66_TodayOpen))
          or ((Y2 > sStrategy_new.D01_K_NowClose) and (sStrategy_new.D01_K_NowClose > sStrategy_new.D66_TodayOpen)) then
          NO_Small[1]:= 1;
        if (Y2 - DataModule1.asq_NewParam.FieldByName('KeepOrder_4_2').AsFloat > sStrategy_new.D01_K_NowClose)
          or ((sStrategy_new.D01_K_NowClose > Y2 + 1) and (Y2 + DataModule1.asq_NewParam.FieldByName('KeepOrder_4_2').AsFloat > sStrategy_new.D01_K_NowClose)) then
          NO_Small[2]:= 1;
        if (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen) then
           NO_Small[3]:= 1;

        Rule[4]:= (NO_Small[1] + NO_Small[2] + NO_Small[3]) >= 2;
      end;
      // #5
      if(DataModule1.asq_NewParam.FieldByName('KeepOrder_5_Check').AsString= 'T') then
        Rule[5]:= (getK_Value.NowBuyQty > 0) and (getK_Value.NowBuyQty >= getK_Value.NowSellQty);

      // #6
      if(DataModule1.asq_NewParam.FieldByName('KeepOrder_6_Check').AsString= 'T') then
        Rule[6]:= sStrategy_new.D69_TodayClose < sStrategy_new.D62_BestSellAve;
    end;
  end else begin
    Result:= false;
    Exit;
  end;

  if Rule[1] then begin
    KeepOrder_Rate:= KeepOrder_Rate + 1;
    fmChungYi.dbcKeepOrder_1_Check.Color:= clRed;
  end else
    fmChungYi.dbcKeepOrder_1_Check.Color:= clWindow;

  if Rule[2] then begin
    KeepOrder_Rate:= KeepOrder_Rate + 1;
    fmChungYi.dbcKeepOrder_2_Check.Color:= clRed;
  end else
    fmChungYi.dbcKeepOrder_2_Check.Color:= clWindow;

  if Rule[3] then begin
    KeepOrder_Rate:= KeepOrder_Rate + 1;
    fmChungYi.dbcKeepOrder_3_Check.Color:= clRed;
  end else
    fmChungYi.dbcKeepOrder_3_Check.Color:= clWindow;

  if Rule[4] then begin
    KeepOrder_Rate:= KeepOrder_Rate + 1;
    fmChungYi.dbcKeepOrder_4_Check.Color:= clRed;
  end else
    fmChungYi.dbcKeepOrder_4_Check.Color:= clWindow;

  if Rule[5] then begin
    KeepOrder_Rate:= KeepOrder_Rate + 1;
    fmChungYi.dbcKeepOrder_5_Check.Color:= clRed;
  end else
    fmChungYi.dbcKeepOrder_5_Check.Color:= clWindow;

  if Rule[6] then begin
    KeepOrder_Rate:= KeepOrder_Rate + 1;
    fmChungYi.dbcKeepOrder_6_Check.Color:= clRed;
  end else
    fmChungYi.dbcKeepOrder_6_Check.Color:= clWindow;

  if(KeepOrder_Rate >= DataModule1.asq_NewParam.FieldByName('KeepOrder_Rate').AsInteger) then begin
    Result:= true;
    fmChungYi.Group_KeepOrder.Color:= clRed;
  end else
    fmChungYi.Group_KeepOrder.Color:= clBtnFace;

end;

end.
