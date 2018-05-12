unit Strategy_Engine;

interface

uses Classes, SysUtils, ASGSQLite3, StdCtrls, Graphics, Public_Variant;

function GetEngine_Check(): boolean;
function GoStrategy_Engine(): boolean;  // Strategy is created
function Engine_Active_UnderBuy(): Integer;
function Engine_Active_UnderSell(): Integer;
function Initial_Engine(CommNO: String): String;

implementation

uses DB_GetData, DMRecord, DB_Type, DB_Handle, getK_Value, ChungYi_Main, TopValue,
     StringList_Fun, GeneralValue;

function GoStrategy_Engine(): boolean;  // Strategy is created
var i: Integer;
begin
  if (DataModule1.asq_NewParam.RecordCount = 0) or (not GetEngine_Check) then begin
      Result:= false ;

      fmChungYi.Group_Engine.Color:= clBtnFace;
      fmChungYi.dbcEngine_Check.Color:= clWindow;
      for i := 1 to 21 do begin
        ConvertObj('dbcEngine_', IntToStr(i) + '_Check', clWindow);
      end;

  end else
    Result:= true;
end;

function GetEngine_Check(): boolean;
begin
  Result:= DataModule1.asq_NewParam.FieldByName('Engine_Check').AsString= 'T';
end;

function Initial_Engine(CommNO: String): String;
var InvenResult: TInventory_Stock;
    BuyQty, SellQty: Integer;
    BuySell: String;
    DB_Rate: Integer;
begin
  SellQty:= 0;
  BuyQty:= 0;
  InvenResult:= DB_Handle.CheckInventory(CommNO);
  DB_Rate:= DataModule1.asq_NewParam.FieldByName('Engine_Rate').AsInteger;
  if InvenResult.LeftQty > 0 then begin
    if (InvenResult.LastBuySell='B') then begin
      SellQty:= Engine_Active_UnderSell();
    end else begin
      BuyQty:= Engine_Active_UnderBuy();
    end;

    if(SellQty >= DB_Rate) or (BuyQty >= DB_Rate) then begin
      if(SellQty >= DB_Rate) then
        Result:= 'S'
      else
        Result:= 'B';
      fmChungYi.Group_Engine.Color:= clRed;
    end else
      fmChungYi.Group_Engine.Color:= clBtnFace;

  end else begin
    SellQty:= Engine_Active_UnderBuy();
    BuyQty:= Engine_Active_UnderSell();
    if(BuyQty > SellQty) and (BuyQty >= DB_Rate) then begin
      Result:= 'B';
    end else if(SellQty > BuyQty) and (SellQty >= DB_Rate) then begin
      Result:= 'S';
    end else
      fmChungYi.Group_Engine.Color:= clBtnFace;
  end;

  if(SellQty >= DB_Rate) or (BuyQty >= DB_Rate) then begin
    if(SellQty >= DB_Rate) then
      Result:= 'S'
    else
      Result:= 'B';
    fmChungYi.Group_Engine.Color:= clRed;
  end else
    fmChungYi.Group_Engine.Color:= clBtnFace;
end;

function Engine_Active_UnderBuy(): Integer;
var InvenResult: TInventory_Stock;
    Rule_A: array of boolean;
    Engine_Rate: Integer;
    D09: Extended;
    i, K_Qty: Integer;
    Fa, Fb: Extended;
begin
  Engine_Rate:= 0;
  SetLength(Rule_A, 22);
  D09:= InvenResult.LastPrice;


  // #1
  if(DataModule1.asq_NewParam.FieldByName('Engine_1_Check').AsString= 'T') then
    Rule_A[1]:= ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < sStrategy_new.J51_NowCloseAve - DataModule1.asq_NewParam.FieldByName('Engine_1_1').AsFloat)
            and (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen) and (sStrategy_new.D01_K_NowClose < sStrategy_new.J02_NowCloseAve);
  // #2
  if(DataModule1.asq_NewParam.FieldByName('Engine_2_Check').AsString= 'T') then
    Rule_A[2]:= (sStrategy_new.J02_NowCloseAve < sStrategy_new.J03_PreCloseAve)
             and (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen - 2)
             and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D54_Inventory_Min)/2 - DataModule1.asq_NewParam.FieldByName('Engine_2_1').AsFloat);
  // #3
  if(DataModule1.asq_NewParam.FieldByName('Engine_3_Check').AsString= 'T') then begin
    K_Qty:= DataModule1.asq_NewParam.FieldByName('Engine_3_1').AsInteger;
    if(K_Qty = 0) then
      exit;
    Fa:= getAve_Max(K_Qty);
    Fb:= getAve_Min(K_Qty);
    Rule_A[3]:= (sStrategy_new.J02_NowCloseAve < Fb)
         and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D54_Inventory_Min)/2 - DataModule1.asq_NewParam.FieldByName('Engine_3_2').AsFloat);
  end;
  // #4
  if(DataModule1.asq_NewParam.FieldByName('Engine_4_Check').AsString= 'T') then begin
    K_Qty:= DataModule1.asq_NewParam.FieldByName('Engine_3_1').AsInteger;
    if(K_Qty = 0) then
      exit;
    Fa:= getFa(K_Qty);
    Fb:= getFb(K_Qty);
    Rule_A[4]:= sStrategy_new.D01_K_NowClose < Fb;
  end;
  // #5
  if(DataModule1.asq_NewParam.FieldByName('Engine_5_Check').AsString= 'T') then
    Rule_A[5]:= sStrategy_new.D47_K_PreOpen - sStrategy_new.D45_K_PreLow < sStrategy_new.D43_K_PreHigh - sStrategy_new.D41_K_PreClose;
  // #6
  if(DataModule1.asq_NewParam.FieldByName('Engine_6_Check').AsString= 'T') then
    Rule_A[6]:= sStrategy_new.J02_NowCloseAve - sStrategy_new.J03_PreCloseAve < sStrategy_new.D01_K_NowClose - sStrategy_new.D21_K_NowOpen - DataModule1.asq_NewParam.FieldByName('Engine_6_1').AsFloat;
    // #7
  if(DataModule1.asq_NewParam.FieldByName('Engine_7_Check').AsString= 'T') then
    Rule_A[7]:= (sStrategy_new.J02_NowCloseAve < sStrategy_new.J22_NowOpenAve)
          and (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen -2)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 - DataModule1.asq_NewParam.FieldByName('Engine_7_1').AsFloat);
  // #8
  if(DataModule1.asq_NewParam.FieldByName('Engine_8_Check').AsString= 'T') then
    Rule_A[8]:= ((sStrategy_new.J12_NowHighAve - sStrategy_new.J17_NowLowAve)/2 < sStrategy_new.J03_PreCloseAve)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 - DataModule1.asq_NewParam.FieldByName('Engine_8_1').AsFloat) ;
  // #9
  if(DataModule1.asq_NewParam.FieldByName('Engine_9_Check').AsString= 'T') then
    Rule_A[9]:= ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < sStrategy_new.J51_NowCloseAve - DataModule1.asq_NewParam.FieldByName('Engine_9_1').AsFloat)
          and (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen - 2);
  // #10
  if(DataModule1.asq_NewParam.FieldByName('Engine_10_Check').AsString= 'T') then
    Rule_A[10]:= (sStrategy_new.J02_NowCloseAve < sStrategy_new.J51_NowCloseAve)
          and (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen -2)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 - DataModule1.asq_NewParam.FieldByName('Engine_10_1').AsFloat);
  // #11
  if(DataModule1.asq_NewParam.FieldByName('Engine_11_Check').AsString= 'T') then
    Rule_A[11]:= (sStrategy_new.J02_NowCloseAve < sStrategy_new.J03_PreCloseAve)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 - DataModule1.asq_NewParam.FieldByName('Engine_11_1').AsFloat);
  // #12
  if(DataModule1.asq_NewParam.FieldByName('Engine_12_Check').AsString= 'T') then
    Rule_A[12]:= (sStrategy_new.J02_NowCloseAve < sStrategy_new.J51_NowCloseAve)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 - DataModule1.asq_NewParam.FieldByName('Engine_12_1').AsFloat);
  // #13
  if(DataModule1.asq_NewParam.FieldByName('Engine_13_Check').AsString= 'T') then
    Rule_A[13]:= (sStrategy_new.J02_NowCloseAve < sStrategy_new.J03_PreCloseAve)
          and (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen);
  // #14
  if(DataModule1.asq_NewParam.FieldByName('Engine_14_Check').AsString= 'T') then
    Rule_A[14]:= (sStrategy_new.J02_NowCloseAve < sStrategy_new.D01_K_NowClose)
          and (sStrategy_new.D01_K_NowClose < sStrategy_new.D11_K_NowHigh - DataModule1.asq_NewParam.FieldByName('Engine_14_1').AsFloat)
          or (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen - 2);
  // #15
  if(DataModule1.asq_NewParam.FieldByName('Engine_15_Check').AsString= 'T') then
    Rule_A[15]:= (sStrategy_new.J02_NowCloseAve < sStrategy_new.D01_K_NowClose)
          and (sStrategy_new.D01_K_NowClose < sStrategy_new.D43_K_PreHigh - DataModule1.asq_NewParam.FieldByName('Engine_15_1').AsFloat);
  // #16
  if(DataModule1.asq_NewParam.FieldByName('Engine_16_Check').AsString= 'T') then
    Rule_A[16]:= (sStrategy_new.J02_NowCloseAve < sStrategy_new.D01_K_NowClose)
          and (sStrategy_new.D21_K_NowOpen - sStrategy_new.D11_K_NowHigh > DataModule1.asq_NewParam.FieldByName('Engine_16_1').AsFloat)
          and (sStrategy_new.D01_K_NowClose < (sStrategy_new.D21_K_NowOpen - sStrategy_new.D11_K_NowHigh)*0.382 + sStrategy_new.D11_K_NowHigh);
  // #17
  if(DataModule1.asq_NewParam.FieldByName('Engine_17_Check').AsString= 'T') then
    Rule_A[17]:= ((sStrategy_new.J12_NowHighAve + sStrategy_new.J17_NowLowAve)/2 < sStrategy_new.J03_PreCloseAve)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 - DataModule1.asq_NewParam.FieldByName('Engine_17_1').AsFloat);
  // #18
  if(DataModule1.asq_NewParam.FieldByName('Engine_18_Check').AsString= 'T') then
    Rule_A[18]:= (sStrategy_new.J02_NowCloseAve < sStrategy_new.J03_PreCloseAve)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 - DataModule1.asq_NewParam.FieldByName('Engine_18_1').AsFloat);
  // #19
  if(DataModule1.asq_NewParam.FieldByName('Engine_19_Check').AsString= 'T') then
    Rule_A[19]:= (sStrategy_new.D11_K_NowHigh - sStrategy_new.D21_K_NowOpen < sStrategy_new.D21_K_NowOpen - sStrategy_new.D16_K_NowLow)
          and (sStrategy_new.D11_K_NowHigh < sStrategy_new.D21_K_NowOpen - DataModule1.asq_NewParam.FieldByName('Engine_19_1').AsFloat);
  // #20
  if(DataModule1.asq_NewParam.FieldByName('Engine_20_Check').AsString= 'T') then
    Rule_A[20]:= ((sStrategy_new.D21_K_NowOpen + sStrategy_new.D01_K_NowClose)/2 < (sStrategy_new.D47_K_PreOpen + sStrategy_new.D41_K_PreClose)/2 - DataModule1.asq_NewParam.FieldByName('Engine_20_1').AsFloat)
          and (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen - 2);
  // #21
  if(DataModule1.asq_NewParam.FieldByName('Engine_21_Check').AsString= 'T') then
    Rule_A[21]:= (sStrategy_new.J02_NowCloseAve < sStrategy_new.D01_K_NowClose)
          and (sStrategy_new.D01_K_NowClose < sStrategy_new.D43_K_PreHigh - DataModule1.asq_NewParam.FieldByName('Engine_21_1').AsFloat);

  for i := 1 to 21 do begin
    if Rule_A[i] then begin
      Engine_Rate:= Engine_Rate + 1;
      ConvertObj('dbcEngine_', IntToStr(i) + '_Check', clRed);
    end else
      ConvertObj('dbcEngine_', IntToStr(i) + '_Check', clWindow);
  end;

end;

function Engine_Active_UnderSell(): Integer;
var InvenResult: TInventory_Stock;
    Rule_B: array of boolean;
    Engine_Rate: Integer;
    D09: Extended;
    i, K_Qty: Integer;
    Fa, Fb: Extended;
begin
  Engine_Rate:= 0;
  SetLength(Rule_B, 22);
  D09:= InvenResult.LastPrice;
  K_Qty:= DataModule1.asq_NewParam.FieldByName('Engine_1').AsInteger;
  if(K_Qty = 0) then
    exit;

  // #1
  if(DataModule1.asq_NewParam.FieldByName('Engine_1_Check').AsString= 'T') then
    Rule_B[1]:= ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 > sStrategy_new.J51_NowCloseAve + DataModule1.asq_NewParam.FieldByName('Engine_1_1').AsFloat)
            and (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen) and (sStrategy_new.D01_K_NowClose > sStrategy_new.J02_NowCloseAve);
  // #2
  if(DataModule1.asq_NewParam.FieldByName('Engine_2_Check').AsString= 'T') then
    Rule_B[2]:= (sStrategy_new.J02_NowCloseAve > sStrategy_new.J03_PreCloseAve)
             and (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen + 2)
             and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 > (sStrategy_new.D43_K_PreHigh + sStrategy_new.D54_Inventory_Min)/2 + DataModule1.asq_NewParam.FieldByName('Engine_2_1').AsFloat);
  // #3
  if(DataModule1.asq_NewParam.FieldByName('Engine_3_Check').AsString= 'T') then begin
    K_Qty:= DataModule1.asq_NewParam.FieldByName('Engine_3_1').AsInteger;
    if(K_Qty = 0) then
      exit;
    Fa:= getAve_Max(K_Qty);
    Fb:= getAve_Min(K_Qty);
    Rule_B[3]:= (sStrategy_new.J02_NowCloseAve > Fb)
         and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 > (sStrategy_new.D43_K_PreHigh + sStrategy_new.D54_Inventory_Min)/2 + DataModule1.asq_NewParam.FieldByName('Engine_3_2').AsFloat);
  end;
  // #4
  if(DataModule1.asq_NewParam.FieldByName('Engine_4_Check').AsString= 'T') then begin
    K_Qty:= DataModule1.asq_NewParam.FieldByName('Engine_3_1').AsInteger;
    if(K_Qty = 0) then
      exit;
    Fa:= getFa(K_Qty);
    Fb:= getFb(K_Qty);
    Rule_B[4]:= sStrategy_new.D01_K_NowClose > Fa;
  end;
  // #5
  if(DataModule1.asq_NewParam.FieldByName('Engine_5_Check').AsString= 'T') then
    Rule_B[5]:= sStrategy_new.D47_K_PreOpen - sStrategy_new.D45_K_PreLow > sStrategy_new.D43_K_PreHigh - sStrategy_new.D41_K_PreClose;
  // #6
  if(DataModule1.asq_NewParam.FieldByName('Engine_6_Check').AsString= 'T') then
    Rule_B[6]:= sStrategy_new.J02_NowCloseAve - sStrategy_new.J03_PreCloseAve > sStrategy_new.D01_K_NowClose - sStrategy_new.D21_K_NowOpen - DataModule1.asq_NewParam.FieldByName('Engine_6_1').AsFloat;
  // #7
  if(DataModule1.asq_NewParam.FieldByName('Engine_7_Check').AsString= 'T') then
    Rule_B[7]:= (sStrategy_new.J02_NowCloseAve > sStrategy_new.J22_NowOpenAve)
          and (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen + 2)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 + DataModule1.asq_NewParam.FieldByName('Engine_7_1').AsFloat);
  // #8
  if(DataModule1.asq_NewParam.FieldByName('Engine_8_Check').AsString= 'T') then
    Rule_B[8]:= ((sStrategy_new.J12_NowHighAve - sStrategy_new.J17_NowLowAve)/2 > sStrategy_new.J03_PreCloseAve)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 > (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 + DataModule1.asq_NewParam.FieldByName('Engine_8_1').AsFloat) ;
  // #9
  if(DataModule1.asq_NewParam.FieldByName('Engine_9_Check').AsString= 'T') then
    Rule_B[9]:= ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 > sStrategy_new.J51_NowCloseAve - DataModule1.asq_NewParam.FieldByName('Engine_9_1').AsFloat)
          and (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen + 2);
  // #10
  if(DataModule1.asq_NewParam.FieldByName('Engine_10_Check').AsString= 'T') then
    Rule_B[10]:= (sStrategy_new.J02_NowCloseAve > sStrategy_new.J51_NowCloseAve)
          and (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen + 2)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 > (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 + DataModule1.asq_NewParam.FieldByName('Engine_10_1').AsFloat);
  // #11
  if(DataModule1.asq_NewParam.FieldByName('Engine_11_Check').AsString= 'T') then
    Rule_B[11]:= (sStrategy_new.J02_NowCloseAve > sStrategy_new.J03_PreCloseAve)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 > (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 + DataModule1.asq_NewParam.FieldByName('Engine_11_1').AsFloat);
  // #12
  if(DataModule1.asq_NewParam.FieldByName('Engine_12_Check').AsString= 'T') then
    Rule_B[12]:= (sStrategy_new.J02_NowCloseAve > sStrategy_new.J51_NowCloseAve)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 > (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 + DataModule1.asq_NewParam.FieldByName('Engine_12_1').AsFloat);
  // #13
  if(DataModule1.asq_NewParam.FieldByName('Engine_13_Check').AsString= 'T') then
    Rule_B[13]:= (sStrategy_new.J02_NowCloseAve > sStrategy_new.J03_PreCloseAve)
          and (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen);
  // #14
  if(DataModule1.asq_NewParam.FieldByName('Engine_14_Check').AsString= 'T') then
    Rule_B[14]:= (sStrategy_new.J02_NowCloseAve > sStrategy_new.D01_K_NowClose)
          and (sStrategy_new.D01_K_NowClose > sStrategy_new.D16_K_NowLow + DataModule1.asq_NewParam.FieldByName('Engine_14_1').AsFloat)
          or (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen + 2);
  // #15
  if(DataModule1.asq_NewParam.FieldByName('Engine_15_Check').AsString= 'T') then
    Rule_B[15]:= (sStrategy_new.J02_NowCloseAve > sStrategy_new.D01_K_NowClose)
          and (sStrategy_new.D01_K_NowClose > sStrategy_new.D45_K_PreLow + DataModule1.asq_NewParam.FieldByName('Engine_15_1').AsFloat);
  // #16
  if(DataModule1.asq_NewParam.FieldByName('Engine_16_Check').AsString= 'T') then
    Rule_B[16]:= (sStrategy_new.J02_NowCloseAve > sStrategy_new.D01_K_NowClose)
          and (sStrategy_new.D21_K_NowOpen - sStrategy_new.D16_K_NowLow > DataModule1.asq_NewParam.FieldByName('Engine_16_1').AsFloat)
          and (sStrategy_new.D01_K_NowClose > (sStrategy_new.D21_K_NowOpen - sStrategy_new.D16_K_NowLow)*0.382 + sStrategy_new.D16_K_NowLow);
  // #17
  if(DataModule1.asq_NewParam.FieldByName('Engine_17_Check').AsString= 'T') then
    Rule_B[17]:= ((sStrategy_new.J12_NowHighAve + sStrategy_new.J17_NowLowAve)/2 > sStrategy_new.J03_PreCloseAve)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 > (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 + DataModule1.asq_NewParam.FieldByName('Engine_17_1').AsFloat);
  // #18
  if(DataModule1.asq_NewParam.FieldByName('Engine_18_Check').AsString= 'T') then
    Rule_B[18]:= (sStrategy_new.J02_NowCloseAve > sStrategy_new.J03_PreCloseAve)
          and ((sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 > (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 + DataModule1.asq_NewParam.FieldByName('Engine_18_1').AsFloat);
  // #19
  if(DataModule1.asq_NewParam.FieldByName('Engine_19_Check').AsString= 'T') then
    Rule_B[19]:= (sStrategy_new.D11_K_NowHigh - sStrategy_new.D21_K_NowOpen > sStrategy_new.D21_K_NowOpen - sStrategy_new.D16_K_NowLow)
          and (sStrategy_new.D11_K_NowHigh > sStrategy_new.D21_K_NowOpen - DataModule1.asq_NewParam.FieldByName('Engine_19_1').AsFloat);
  // #20
  if(DataModule1.asq_NewParam.FieldByName('Engine_20_Check').AsString= 'T') then
    Rule_B[20]:= ((sStrategy_new.D21_K_NowOpen + sStrategy_new.D01_K_NowClose)/2 > (sStrategy_new.D47_K_PreOpen + sStrategy_new.D41_K_PreClose)/2 + DataModule1.asq_NewParam.FieldByName('Engine_20_1').AsFloat)
          and (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen + 2);
  // #21
  if(DataModule1.asq_NewParam.FieldByName('Engine_21_Check').AsString= 'T') then
    Rule_B[21]:= (sStrategy_new.J02_NowCloseAve > sStrategy_new.D01_K_NowClose)
          and (sStrategy_new.D01_K_NowClose > sStrategy_new.D43_K_PreHigh + DataModule1.asq_NewParam.FieldByName('Engine_21_1').AsFloat);

  for i := 1 to 21 do begin
    if Rule_B[i] then begin
      Engine_Rate:= Engine_Rate + 1;
      ConvertObj('dbcEngine_', IntToStr(i) + '_Check', clYellow);
    end else
      ConvertObj('dbcEngine_', IntToStr(i) + '_Check', clWindow);
  end;

end;

end.
