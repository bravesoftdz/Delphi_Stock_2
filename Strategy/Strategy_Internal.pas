unit Strategy_Internal;

interface

uses Classes, SysUtils, ASGSQLite3, StdCtrls, Graphics, Public_Variant;

function GetInternal_Check(): boolean;
function GoStrategy_Internal(): boolean;  // Strategy is created
function Initial_Internal(CommNO: String): String;
function SellRate(): Integer;
function BuyRate(): Integer;

//function getFa(K_Qty): Extended;
//function getFb(K_Qty): Extended;
//function getAve_Max(K_Qty): Extended;
//function getAve_Min(K_Qty): Extended;

implementation

uses DB_GetData, DMRecord, DB_Type, DB_Handle, getK_Value, ChungYi_Main, TopValue,
     StringList_Fun, GeneralValue;

function GoStrategy_Internal(): boolean;  // Strategy is created
var i: Integer;
begin
  if (DataModule1.asq_NewParam.RecordCount = 0) or (not GetInternal_Check) then begin
      Result:= false ;

      fmChungYi.Group_Internal.Color:= clBtnFace;
      fmChungYi.dbcInternal_Check.Color:= clWindow;
      for i := 1 to 21 do begin
        ConvertObj('dbcInternal_', IntToStr(i) + '_Check', clWindow);
      end;

  end else
    Result:= true;
end;

function GetInternal_Check(): boolean;
begin
  Result:= DataModule1.asq_NewParam.FieldByName('Internal_Check').AsString= 'T';
end;


function Initial_Internal(CommNO: String): String;
var InvenResult: TInventory_Stock;
    BuyQty, SellQty: Integer;
    BuySell: String;
    DB_Rate: Integer;
begin
  SellQty:= 0;
  BuyQty:= 0;
  InvenResult:= DB_Handle.CheckInventory(CommNO);
  DB_Rate:= DataModule1.asq_NewParam.FieldByName('Internal_Rate').AsInteger;
  if InvenResult.LeftQty > 0 then begin
    if (InvenResult.LastBuySell='B') then begin
      SellQty:= SellRate();
    end else begin
      BuyQty:= BuyRate();
    end;

    if(SellQty >= DB_Rate) or (BuyQty >= DB_Rate) then begin
      if(SellQty >= DB_Rate) then
        Result:= 'S'
      else
        Result:= 'B';
      fmChungYi.Group_Internal.Color:= clRed;
    end else
      fmChungYi.Group_Internal.Color:= clBtnFace;

  end else begin
    SellQty:= SellRate();
    BuyQty:= BuyRate();
    if(BuyQty > SellQty) and (BuyQty >= DB_Rate) then begin
      Result:= 'B';
    end else if(SellQty > BuyQty) and (SellQty >= DB_Rate) then begin
      Result:= 'S';
    end else
      fmChungYi.Group_Internal.Color:= clBtnFace;
  end;

  if(SellQty >= DB_Rate) or (BuyQty >= DB_Rate) then begin
    if(SellQty >= DB_Rate) then
      Result:= 'S'
    else
      Result:= 'B';
    fmChungYi.Group_Internal.Color:= clRed;
  end else
    fmChungYi.Group_Internal.Color:= clBtnFace;
end;

function SellRate(): Integer;
var InvenResult: TInventory_Stock;
    Rule_A: array of boolean;
    Internal_Rate: Integer;
    D09: Extended;
    i, K_Qty: Integer;
    Fa, Fb: Extended;
    NO_Small: array of Integer;
begin
    Internal_Rate:= 0;
    setLength(Rule_A, 12);
  // #1
      if(DataModule1.asq_NewParam.FieldByName('Internal_1_Check').AsString= 'T') then begin
        Fa:= getFa(K_Qty);
        Fb:= getFb(K_Qty);
        Rule_A[1]:= (sStrategy_new.D01_K_NowClose < (Fb - Fa) * 0.0025 + Fa)
           and ((sStrategy_new.J02_NowCloseAve < sStrategy_new.J03_PreCloseAve)
              or (sStrategy_new.D47_K_PreOpen - sStrategy_new.D45_K_PreLow < sStrategy_new.D43_K_PreHigh - sStrategy_new.D41_K_PreClose));
      end;
      // #2
      if(DataModule1.asq_NewParam.FieldByName('Internal_2_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('Internal_2_1').AsInteger;
        Fa:= getFa(K_Qty);
        Fb:= getFb(K_Qty);

        if (sStrategy_new.D47_K_PreOpen - sStrategy_new.D45_K_PreLow) < (sStrategy_new.D43_K_PreHigh - sStrategy_new.D41_K_PreClose) then
          NO_Small[1]:= 1;
        if (sStrategy_new.J12_NowHighAve + sStrategy_new.J17_NowLowAve) / 2 < sStrategy_new.J03_PreCloseAve then
          NO_Small[2]:= 1;
        if (sStrategy_new.D01_K_NowClose < Fa - DataModule1.asq_NewParam.FieldByName('Internal_2_2').AsFloat)
                       and (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen) then
           NO_Small[3]:= 1;

        K_Qty:= DataModule1.asq_NewParam.FieldByName('Internal_2_3').AsInteger;
        Fa:= getFa(K_Qty);
        Fb:= getFb(K_Qty);
        if sStrategy_new.D01_K_NowClose < Fb then
          NO_Small[4]:= 1;
        if (sStrategy_new.J17_NowLowAve < sStrategy_new.J18_PreLowAve)
                       and (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen) then
          NO_Small[5]:= 1;

        Rule_A[2]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_2_Rate').AsInteger;
      end;
      // #3
      if(DataModule1.asq_NewParam.FieldByName('Internal_3_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('Internal_3_1').AsInteger;
        Fa:= getFa(K_Qty);
        Fb:= getFb(K_Qty);

        if (sStrategy_new.D47_K_PreOpen - sStrategy_new.D45_K_PreLow) < (sStrategy_new.D43_K_PreHigh - sStrategy_new.D41_K_PreClose) then
          NO_Small[1]:= 1;
        if (sStrategy_new.D01_K_NowClose < Fa - DataModule1.asq_NewParam.FieldByName('Internal_3_2').AsFloat)
          and (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen)  then
          NO_Small[2]:= 1;
        if (sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2
          < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow) /2 - DataModule1.asq_NewParam.FieldByName('Internal_3_3').AsFloat then
           NO_Small[3]:= 1;
        if sStrategy_new.J02_NowCloseAve <  sStrategy_new.J22_NowOpenAve then
          NO_Small[4]:= 1;
        if (sStrategy_new.J12_NowHighAve + sStrategy_new.J17_NowLowAve) /2 < sStrategy_new.J03_PreCloseAve then
          NO_Small[5]:= 1;

        Rule_A[3]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_3_Rate').AsInteger;
      end;
      // #4
      if(DataModule1.asq_NewParam.FieldByName('Internal_4_Check').AsString= 'T') then
        Rule_A[4]:= (sStrategy_new.J28_PreAllQtyAve < sStrategy_new.D26_K_NowQty)
            and (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen);
      // #5
      if(DataModule1.asq_NewParam.FieldByName('Internal_5_Check').AsString= 'T') then
        Rule_A[5]:= (sStrategy_new.J32_BuyQtyAve < sStrategy_new.J37_SellQtyAve)
            and (sStrategy_new.D01_K_NowClose < sStrategy_new.D21_K_NowOpen);
      // #6
      if(DataModule1.asq_NewParam.FieldByName('Internal_6_Check').AsString= 'T') then
        Rule_A[6]:= (sStrategy_new.D61_BestBuyAve < sStrategy_new.D62_BestSellAve);
      // #7
      if(DataModule1.asq_NewParam.FieldByName('Internal_7_Check').AsString= 'T') then begin
        if (sStrategy_new.J02_NowCloseAve) < (sStrategy_new.J03_PreCloseAve) then
          NO_Small[1]:= 1;
        if (sStrategy_new.J02_NowCloseAve) < (sStrategy_new.J51_NowCloseAve) then
          NO_Small[2]:= 1;
        if (sStrategy_new.J02_NowCloseAve) < (sStrategy_new.J55_NowCloseAve) then
           NO_Small[3]:= 1;
        if sStrategy_new.J02_NowCloseAve <  sStrategy_new.J57_NowCloseAve then
          NO_Small[4]:= 1;
        if sStrategy_new.J02_NowCloseAve <  sStrategy_new.J59_NowCloseAve then
          NO_Small[5]:= 1;

        Rule_A[7]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_7_Rate').AsInteger;
      end;
      // #8
      if(DataModule1.asq_NewParam.FieldByName('Internal_8_Check').AsString= 'T') then begin
        if (sStrategy_new.J02_NowCloseAve) < (sStrategy_new.J03_PreCloseAve) then
          NO_Small[1]:= 1;
        if (sStrategy_new.J12_NowHighAve) < (sStrategy_new.J13_PreHighAve) then
          NO_Small[2]:= 1;
        if (sStrategy_new.J17_NowLowAve) < (sStrategy_new.J18_PreLowAve) then
           NO_Small[3]:= 1;
        if sStrategy_new.J22_NowOpenAve <  sStrategy_new.J23_PreOpenAve then
          NO_Small[4]:= 1;
        if sStrategy_new.J02_NowCloseAve <  sStrategy_new.J22_NowOpenAve then
          NO_Small[5]:= 1;

        Rule_A[8]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_8_Rate').AsInteger;
      end;
      // #9
      if(DataModule1.asq_NewParam.FieldByName('Internal_9_Check').AsString= 'T') then begin
        if (sStrategy_new.J02_NowCloseAve) < (sStrategy_new.J03_PreCloseAve) then
          NO_Small[1]:= 1;
        if (sStrategy_new.J51_NowCloseAve) < (sStrategy_new.J52_PreCloseAve) then
          NO_Small[2]:= 1;
        if (sStrategy_new.J55_NowCloseAve) < (sStrategy_new.J56_PreCloseAve) then
           NO_Small[3]:= 1;
        if sStrategy_new.J57_NowCloseAve <  sStrategy_new.J58_PreCloseAve then
          NO_Small[4]:= 1;
        if sStrategy_new.J59_NowCloseAve <  sStrategy_new.J60_PreCloseAve then
          NO_Small[5]:= 1;

        Rule_A[9]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_9_Rate').AsInteger;
      end;
      // #10
      if(DataModule1.asq_NewParam.FieldByName('Internal_10_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('Internal_10_1_3').AsInteger;
        Fa:= getAve_Max(K_Qty);
        Fb:= getAve_Min(K_Qty);

        if (sStrategy_new.D01_K_NowClose) < (sStrategy_new.D21_K_NowOpen - DataModule1.asq_NewParam.FieldByName('Internal_10_1_1').AsFloat) then
          NO_Small[1]:= 1;
        if (sStrategy_new.J02_NowCloseAve < sStrategy_new.J03_PreCloseAve - DataModule1.asq_NewParam.FieldByName('Internal_10_1_2').AsFloat) then
          NO_Small[2]:= 1;
        if (sStrategy_new.J12_NowHighAve + sStrategy_new.J17_NowLowAve)/2 < (sStrategy_new.J03_PreCloseAve) then
           NO_Small[3]:= 1;
        if (sStrategy_new.J12_NowHighAve <  sStrategy_new.J13_PreHighAve)
          and (sStrategy_new.D01_K_NowClose <  sStrategy_new.D21_K_NowOpen) then
          NO_Small[4]:= 1;
        if sStrategy_new.J02_NowCloseAve < Fb then
          NO_Small[5]:= 1;

        Rule_A[10]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_10_Rate').AsInteger;
      end;
      // #11
      if(DataModule1.asq_NewParam.FieldByName('Internal_11_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('Internal_11_1_2').AsInteger;
        Fa:= getAve_Max(K_Qty);
        Fb:= getAve_Min(K_Qty);

        if (sStrategy_new.J02_NowCloseAve) < (sStrategy_new.J22_NowOpenAve) then
          NO_Small[1]:= 1;
        if (sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 - DataModule1.asq_NewParam.FieldByName('Internal_11_1_1').AsFloat then
          NO_Small[2]:= 1;
        if sStrategy_new.J02_NowCloseAve < sStrategy_new.J03_PreCloseAve then
           NO_Small[3]:= 1;
        if sStrategy_new.J02_NowCloseAve <  (Fa + Fb)/2 then
          NO_Small[4]:= 1;
        if (sStrategy_new.J32_BuyQtyAve < sStrategy_new.J37_SellQtyAve)
          and (sStrategy_new.J28_PreAllQtyAve < sStrategy_new.J27_NowAllQtyAve) then
          NO_Small[5]:= 1;

        Rule_A[11]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_11_Rate').AsInteger;
      end;

    for i := 1 to 21 do begin
      if Rule_A[i] then begin
        Internal_Rate:= Internal_Rate + 1;
        ConvertObj('dbcInternal_', IntToStr(i) + '_Check', clRed);
      end else
        ConvertObj('dbcInternal_', IntToStr(i) + '_Check', clWindow);
    end;

end;

function BuyRate(): Integer;
var InvenResult: TInventory_Stock;
    Rule_B: array of boolean;
    Internal_Rate: Integer;
    D09: Extended;
    i, K_Qty: Integer;
    Fa, Fb: Extended;
    NO_Small: array of Integer;
begin
    Internal_Rate:= 0;
    setLength(Rule_B, 12);

  // #1
      if(DataModule1.asq_NewParam.FieldByName('Internal_1_Check').AsString= 'T') then begin
        Fa:= getFa(K_Qty);
        Fb:= getFb(K_Qty);
        Rule_B[1]:= (sStrategy_new.D01_K_NowClose > (Fa - Fb) * 0.0025 + Fb)
           and ((sStrategy_new.J02_NowCloseAve > sStrategy_new.J03_PreCloseAve)
              or (sStrategy_new.D47_K_PreOpen - sStrategy_new.D45_K_PreLow > sStrategy_new.D43_K_PreHigh - sStrategy_new.D41_K_PreClose));
      end;
      // #2
      if(DataModule1.asq_NewParam.FieldByName('Internal_2_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('Internal_2_1').AsInteger;
        Fa:= getFa(K_Qty);
        Fb:= getFb(K_Qty);

        if (sStrategy_new.D47_K_PreOpen - sStrategy_new.D45_K_PreLow) > (sStrategy_new.D43_K_PreHigh - sStrategy_new.D41_K_PreClose) then
          NO_Small[1]:= 1;
        if (sStrategy_new.J12_NowHighAve + sStrategy_new.J17_NowLowAve) / 2 > sStrategy_new.J03_PreCloseAve then
          NO_Small[2]:= 1;
        if (sStrategy_new.D01_K_NowClose > Fb - DataModule1.asq_NewParam.FieldByName('Internal_2_2').AsFloat)
                       and (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen) then
           NO_Small[3]:= 1;

        K_Qty:= DataModule1.asq_NewParam.FieldByName('Internal_2_3').AsInteger;
        Fa:= getFa(K_Qty);
        Fb:= getFb(K_Qty);
        if sStrategy_new.D01_K_NowClose > Fa then
          NO_Small[4]:= 1;
        if (sStrategy_new.J17_NowLowAve > sStrategy_new.J18_PreLowAve)
                       and (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen) then
          NO_Small[5]:= 1;

        Rule_B[2]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_2_Rate').AsInteger;
      end;
      // #3
      if(DataModule1.asq_NewParam.FieldByName('Internal_3_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('Internal_3_1').AsInteger;
        Fa:= getFa(K_Qty);
        Fb:= getFb(K_Qty);

        if (sStrategy_new.D47_K_PreOpen - sStrategy_new.D45_K_PreLow) > (sStrategy_new.D43_K_PreHigh - sStrategy_new.D41_K_PreClose) then
          NO_Small[1]:= 1;
        if (sStrategy_new.D01_K_NowClose > Fb + DataModule1.asq_NewParam.FieldByName('Internal_3_2').AsFloat)
          and (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen)  then
          NO_Small[2]:= 1;
        if (sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2
          > (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow) /2 + DataModule1.asq_NewParam.FieldByName('Internal_3_3').AsFloat then
           NO_Small[3]:= 1;
        if sStrategy_new.J02_NowCloseAve >  sStrategy_new.J22_NowOpenAve then
          NO_Small[4]:= 1;
        if (sStrategy_new.J12_NowHighAve + sStrategy_new.J17_NowLowAve) /2 > sStrategy_new.J03_PreCloseAve then
          NO_Small[5]:= 1;

        Rule_B[3]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_2_Rate').AsInteger;
      end;
      // #4
      if(DataModule1.asq_NewParam.FieldByName('Internal_4_Check').AsString= 'T') then
        Rule_B[4]:= (sStrategy_new.D26_K_NowQty > sStrategy_new.J28_PreAllQtyAve)
            and (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen);
      // #5
      if(DataModule1.asq_NewParam.FieldByName('Internal_5_Check').AsString= 'T') then
        Rule_B[5]:= (sStrategy_new.J32_BuyQtyAve > sStrategy_new.J37_SellQtyAve)
            and (sStrategy_new.D01_K_NowClose > sStrategy_new.D21_K_NowOpen);
      // #6
      if(DataModule1.asq_NewParam.FieldByName('Internal_6_Check').AsString= 'T') then
        Rule_B[6]:= (sStrategy_new.D61_BestBuyAve > sStrategy_new.D62_BestSellAve);
      // #7
      if(DataModule1.asq_NewParam.FieldByName('Internal_7_Check').AsString= 'T') then begin
        if (sStrategy_new.J02_NowCloseAve) > (sStrategy_new.J03_PreCloseAve) then
          NO_Small[1]:= 1;
        if (sStrategy_new.J02_NowCloseAve) < (sStrategy_new.J51_NowCloseAve) then
          NO_Small[2]:= 1;
        if (sStrategy_new.J02_NowCloseAve) > (sStrategy_new.J55_NowCloseAve) then
           NO_Small[3]:= 1;
        if sStrategy_new.J02_NowCloseAve >  sStrategy_new.J57_NowCloseAve then
          NO_Small[4]:= 1;
        if sStrategy_new.J02_NowCloseAve >  sStrategy_new.J59_NowCloseAve then
          NO_Small[5]:= 1;

        Rule_B[7]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_7_Rate').AsInteger;
      end;
      // #8
      if(DataModule1.asq_NewParam.FieldByName('Internal_8_Check').AsString= 'T') then begin
        if (sStrategy_new.J02_NowCloseAve) > (sStrategy_new.J03_PreCloseAve) then
          NO_Small[1]:= 1;
        if (sStrategy_new.J12_NowHighAve) > (sStrategy_new.J13_PreHighAve) then
          NO_Small[2]:= 1;
        if (sStrategy_new.J17_NowLowAve) > (sStrategy_new.J18_PreLowAve) then
           NO_Small[3]:= 1;
        if sStrategy_new.J22_NowOpenAve >  sStrategy_new.J23_PreOpenAve then
          NO_Small[4]:= 1;
        if sStrategy_new.J02_NowCloseAve >  sStrategy_new.J22_NowOpenAve then
          NO_Small[5]:= 1;

        Rule_B[8]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_8_Rate').AsInteger;
      end;
       // #9
      if(DataModule1.asq_NewParam.FieldByName('Internal_9_Check').AsString= 'T') then begin
        if (sStrategy_new.J02_NowCloseAve) > (sStrategy_new.J03_PreCloseAve) then
          NO_Small[1]:= 1;
        if (sStrategy_new.J51_NowCloseAve) > (sStrategy_new.J52_PreCloseAve) then
          NO_Small[2]:= 1;
        if (sStrategy_new.J55_NowCloseAve) > (sStrategy_new.J56_PreCloseAve) then
           NO_Small[3]:= 1;
        if sStrategy_new.J57_NowCloseAve >  sStrategy_new.J58_PreCloseAve then
          NO_Small[4]:= 1;
        if sStrategy_new.J59_NowCloseAve >  sStrategy_new.J60_PreCloseAve then
          NO_Small[5]:= 1;

        Rule_B[9]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_9_Rate').AsInteger;
      end;
      // #10
      if(DataModule1.asq_NewParam.FieldByName('Internal_10_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('Internal_10_1_3').AsInteger;
        Fa:= getAve_Max(K_Qty);
        Fb:= getAve_Min(K_Qty);

        if (sStrategy_new.D01_K_NowClose) > (sStrategy_new.D21_K_NowOpen + DataModule1.asq_NewParam.FieldByName('Internal_10_1_1').AsFloat) then
          NO_Small[1]:= 1;
        if (sStrategy_new.J02_NowCloseAve > sStrategy_new.J03_PreCloseAve + DataModule1.asq_NewParam.FieldByName('Internal_10_1_2').AsFloat) then
          NO_Small[2]:= 1;
        if (sStrategy_new.J12_NowHighAve + sStrategy_new.J17_NowLowAve)/2 > (sStrategy_new.J03_PreCloseAve) then
           NO_Small[3]:= 1;
        if (sStrategy_new.J12_NowHighAve >  sStrategy_new.J13_PreHighAve)
          and (sStrategy_new.D01_K_NowClose >  sStrategy_new.D21_K_NowOpen) then
          NO_Small[4]:= 1;
        if sStrategy_new.J02_NowCloseAve > Fb then
          NO_Small[5]:= 1;

        Rule_B[10]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_10_Rate').AsInteger;
      end;
      // #11
      if(DataModule1.asq_NewParam.FieldByName('Internal_11_Check').AsString= 'T') then begin
        K_Qty:= DataModule1.asq_NewParam.FieldByName('Internal_11_1_2').AsInteger;
        Fa:= getAve_Max(K_Qty);
        Fb:= getAve_Min(K_Qty);

        if (sStrategy_new.J02_NowCloseAve) > (sStrategy_new.J22_NowOpenAve) then
          NO_Small[1]:= 1;
        if (sStrategy_new.D11_K_NowHigh + sStrategy_new.D16_K_NowLow)/2 < (sStrategy_new.D43_K_PreHigh + sStrategy_new.D45_K_PreLow)/2 + DataModule1.asq_NewParam.FieldByName('Internal_11_1_1').AsFloat then
          NO_Small[2]:= 1;
        if sStrategy_new.J02_NowCloseAve > sStrategy_new.J03_PreCloseAve then
           NO_Small[3]:= 1;
        if sStrategy_new.J02_NowCloseAve >  (Fa + Fb)/2 then
          NO_Small[4]:= 1;
        if (sStrategy_new.J32_BuyQtyAve > sStrategy_new.J37_SellQtyAve)
          and (sStrategy_new.J28_PreAllQtyAve > sStrategy_new.J27_NowAllQtyAve) then
          NO_Small[5]:= 1;

        Rule_B[11]:= (NO_Small[1] + NO_Small[2] + NO_Small[3] + NO_Small[4] + NO_Small[5]) >= DataModule1.asq_NewParam.FieldByName('Internal_11_Rate').AsInteger;
      end;


      for i := 1 to 11 do begin
        if Rule_B[i] then begin
          Internal_Rate:= Internal_Rate + 1;
          ConvertObj('dbcInternal_', IntToStr(i) + '_Check', clRed);
        end else
          ConvertObj('dbcInternal_', IntToStr(i) + '_Check', clWindow);
      end;
end;
end.
