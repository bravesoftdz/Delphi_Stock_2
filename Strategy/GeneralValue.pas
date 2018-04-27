unit GeneralValue;

interface

uses DBCtrls, Graphics, Classes, SysUtils;

function getFa(K_Qty: Integer): Extended;
function getFb(K_Qty: Integer): Extended;
function getAve_Max(K_Qty: Integer): Extended;
function getAve_Min(K_Qty: Integer): Extended;
procedure ConvertObj(input_pre, input_last: String; color_no: Integer);

implementation

uses DB_GetData, getK_Value, StringList_Fun, Public_Variant, K_Line_Save;

function getFa(K_Qty: Integer): Extended;
begin
  Result:= GetMax_fromN(HighList, HighList.Count - 1 - K_Qty + 1, K_Qty);
end;

function getFb(K_Qty: Integer): Extended;
begin
  Result:= GetMin_fromN(LowList, LowList.Count - 1 - K_Qty + 1, K_Qty);
end;

function getAve_Max(K_Qty: Integer): Extended;
begin
  Result:= GetMax_fromN(AveList, AveList.Count - 1 - K_Qty + 1, K_Qty);
end;

function getAve_Min(K_Qty: Integer): Extended;
begin
  Result:= GetMin_fromN(AveList, AveList.Count - 1 - K_Qty + 1, K_Qty);
end;

procedure ConvertObj(input_pre, input_last: String; color_no: Integer);
var getNM: String;
    Obj: TDBCheckBox;
begin
  getNM:= input_pre + input_last ;
  Obj:= TDBCheckBox(getNM).Create(nil);
  Obj.Color:= color_no;
end;
end.
