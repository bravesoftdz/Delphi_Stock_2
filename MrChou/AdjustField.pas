unit AdjustField;

interface

uses Classes, DBCtrls, DBGrids, SKCOMLib_TLB, SysUtils, DMRecord, Public_Variant, MIDAS,
    DBClient, Forms, Grids, ChouRule;

type
  TIntegerArray = array of Integer;

procedure MoveField(mdbGrid: TDBGrid);
procedure AddChou_Field(var InputStr: String; SK: SKSTOCK; iDot: Double; IsInsert: boolean;
    LastSN: Integer; TK: SKTICK; TickNO: Integer);
function FindField(mdbCombo: TDBComboBox; mdbGrid: TDBGrid): Integer;
function MoveField_GridList(mdbGrid: TDBGrid): TIntegerArray;
function FindField_Grid(mdbCombo: TDBComboBox): Integer;

implementation

uses Quote, ChungYi_Main;

procedure AddChou_Field(var InputStr: String; SK: SKSTOCK; iDot: Double; IsInsert: boolean;
    LastSN: Integer; TK: SKTICK; TickNO: Integer);
var SQL_Str, temp_str: String;
    i: Integer;
begin
  if not TimeLimit(TickTime) then begin
    TotalTickQty:= TotalTickQty + TK.nQty;
  end else
    TK.nQty:= 0;

  InputStr:= InputStr + ',' + FloatToStr(SK.nBc) + ',' + FloatToStr(SK.nAc)
    + ',' + FloatToStr(TK.nQty) + ','  + FloatToStr(TotalTickQty) + ',' + FloatToStr(TickNO);

end;

procedure MoveField(mdbGrid: TDBGrid);
var getIndex1, getIndex2, getIndex3, getIndex4: Integer;
    i: Integer;
begin
  for i := 0 to mdbGrid.Columns.Count - 1 do begin
    mdbGrid.Columns[i].Visible:= false;
  end;

  getIndex1:= FindField(fmChungYi.dbcb_1st_Item, mdbGrid);
  getIndex2:= FindField(fmChungYi.dbcb_2nd_Item, mdbGrid);
  getIndex3:= FindField(fmChungYi.dbcb_3rd_Item, mdbGrid);
  getIndex4:= FindField(fmChungYi.dbcb_4th_Item, mdbGrid);

  mdbGrid.Columns[getIndex1].Index:= 0;
  mdbGrid.Columns[getIndex2].Index:= 1;
  mdbGrid.Columns[getIndex3].Index:= 2;
  mdbGrid.Columns[getIndex4].Index:= 3;

  mdbGrid.Columns[0].Visible:= true;
  mdbGrid.Columns[1].Visible:= true;
  mdbGrid.Columns[2].Visible:= true;
  mdbGrid.Columns[3].Visible:= true;
end;

function MoveField_GridList(mdbGrid: TDBGrid): TIntegerArray;
begin
  SetLength(Result, 4);
  Result[0]:= FindField_Grid(fmChungYi.dbcb_1st_Item);
  Result[1]:= FindField_Grid(fmChungYi.dbcb_2nd_Item);
  Result[2]:= FindField_Grid(fmChungYi.dbcb_3rd_Item);
  Result[3]:= FindField_Grid(fmChungYi.dbcb_4th_Item);
end;

function FindField(mdbCombo: TDBComboBox; mdbGrid: TDBGrid): Integer;
var i: Integer;
begin
  for i := 0 to mdbGrid.Columns.Count - 1 do begin
 //   if((mdbGrid.Columns.Items[i].FieldName= 'TradeDate') and (mdbCombo.Text= 'A. 時間')) then begin
    if((mdbGrid.Columns.Items[i].FieldName= 'TradeDate_new') and (mdbCombo.Text= 'A. 時間')) then begin
        Result:= i;
        break;
    end else if((mdbGrid.Columns.Items[i].FieldName= 'BuyPrice') and (mdbCombo.Text= 'B. 買進')) then begin
        Result:= i;
        break;
    end else if((mdbGrid.Columns.Items[i].FieldName= 'SellPrice') and (mdbCombo.Text= 'C. 賣出')) then begin
        Result:= i;
        break;
    end else if((mdbGrid.Columns.Items[i].FieldName= 'TradePrice') and (mdbCombo.Text= 'D. 成交')) then begin
        Result:= i;
        break;
    end else if((mdbGrid.Columns.Items[i].FieldName= 'TickQty') and (mdbCombo.Text= 'E. 單量')) then begin
        Result:= i;
        break;
    end else if((mdbGrid.Columns.Items[i].FieldName= 'AllQty') and (mdbCombo.Text= 'F. 總量')) then begin
        Result:= i;
        break;
    end else if((mdbGrid.Columns.Items[i].FieldName= 'BuyQty') and (mdbCombo.Text= 'G. 委買')) then begin
        Result:= i;
        break;
    end else if((mdbGrid.Columns.Items[i].FieldName= 'SellQty') and (mdbCombo.Text= 'H. 委賣')) then begin
        Result:= i;
        break;
    end else if((mdbGrid.Columns.Items[i].FieldName= 'AveP') and (mdbCombo.Text= 'I. 均價')) then begin
        Result:= i;
        break;
    end;

  end;
end;

function FindField_Grid(mdbCombo: TDBComboBox): Integer;
begin
//  for i := 0 to mdbGrid.Columns.Count - 1 do begin
    if(mdbCombo.Text= 'A. 時間') then begin
        Result:= 2;
    end else if(mdbCombo.Text= 'B. 買進') then begin
        Result:= 4;
    end else if(mdbCombo.Text= 'C. 賣出') then begin
        Result:= 5;
    end else if(mdbCombo.Text= 'D. 成交') then begin
        Result:= 6;
    end else if(mdbCombo.Text= 'E. 單量') then begin
        Result:= 11;
    end else if(mdbCombo.Text= 'F. 總量') then begin
        Result:= 12;
    end else if(mdbCombo.Text= 'G. 委買') then begin
        Result:= 9;
    end else if(mdbCombo.Text= 'H. 委賣') then begin
        Result:= 10;
    end else if(mdbCombo.Text= 'I. 均價') then begin
        Result:= 8;
    end;

end;
{
A. 時間
B. 買進
C. 賣出
D. 成交
E. 單量
F. 總量
G. 委買
H. 委賣
I. 均價

}
end.
