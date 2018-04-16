unit AdjustField;

interface

uses Classes, DBCtrls, DBGrids, SKCOMLib_TLB, SysUtils, DMRecord, Public_Variant;

procedure MoveField(mdbGrid: TDBGrid);
procedure AddChou_Field(var InputStr: String; SK: SKSTOCK; iDot: Double; IsInsert: boolean;
    LastSN: Integer);
function TransferField(mdbCombo: TDBComboBox): Integer;
function FindField(mdbCombo: TDBComboBox; mdbGrid: TDBGrid): Integer;

implementation

uses Quote, ChungYi_Main;
{
procedure MoveField(mdbCombo: TDBComboBox; mdbGrid: TDBGrid);
var getIndex: String;
    i: Integer;
begin
  for i := 0 to mdbGrid.Columns.Count - 1 do begin
    mdbGrid.Columns[i].Visible:= false;
  end;

  getIndex:= TransferField(mdbCombo);
  if(getIndex= '2,3') then begin
    mdbGrid.Columns[2].Visible:= true;
    mdbGrid.Columns[3].Visible:= true;
  end else begin
    mdbGrid.Columns[StrToInt(getIndex)].Visible:= true;
  end;

end;
 }

procedure AddChou_Field(var InputStr: String; SK: SKSTOCK; iDot: Double; IsInsert: boolean;
    LastSN: Integer);
var SQL_Str, temp_str: String;
    i: Integer;
begin
//  InputStr:= IntToStr(LastSN) + ',' + InputStr + ',' + FloatToStr(SK.nBc) + ',' + FloatToStr(SK.nAc)
//    + ',' + FloatToStr(SK.nTickQty);
  InputStr:= InputStr + ',' + FloatToStr(SK.nBc) + ',' + FloatToStr(SK.nAc)
    + ',' + FloatToStr(SK.nTickQty);

  if(IsInsert) then begin
    TempList.Text:= InputStr;
    TempList.Delimiter:= ',';
    TempList.DelimitedText:= TempList.Text;
    for i := 0 to TempList.Count - 1 do begin
      if i < TempList.Count - 1 then
        temp_str:= temp_str + '"' + TempList.Strings[i] + '",'
      else
        temp_str:= temp_str + '"' + TempList.Strings[i] + '"';
    end;

    SQL_Str:= 'insert into TradeRecord (StockNO, TradeDate, TickTime, BuyPrice, SellPrice, '
     + ' TradePrice, Qty, AveP, BuyQty, SellQty, TickQty) values (' + temp_str + ') ';
//    SQL_Str:= 'insert into TradeRecord values (' + temp_str + ') ';
    DataModule1.asqQU_Temp.SQL.Text:= SQL_Str;
    DataModule1.asqQU_Temp.ExecSQL;

    AllSQLList.Clear;
  end;

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

function TransferField(mdbCombo: TDBComboBox): Integer;
begin
  if(mdbCombo.Text= 'A. 時間') then
    Result:= 2
  else if(mdbCombo.Text= 'B. 買進') then
    Result:= 4
  else if(mdbCombo.Text= 'C. 賣出') then
    Result:= 5
  else if(mdbCombo.Text= 'D. 成交') then
    Result:= 6
  else if(mdbCombo.Text= 'E. 單量') then
    Result:= 11
  else if(mdbCombo.Text= 'F. 總量') then
    Result:= 7
  else if(mdbCombo.Text= 'G. 委買') then
    Result:= 9
  else if(mdbCombo.Text= 'H. 委賣') then
    Result:= 10
  else if(mdbCombo.Text= 'I. 均價') then
    Result:= 8;
end;

function FindField(mdbCombo: TDBComboBox; mdbGrid: TDBGrid): Integer;
var i: Integer;
begin
  for i := 0 to mdbGrid.Columns.Count - 1 do begin
    if((mdbGrid.Columns.Items[i].FieldName= 'TradeDate') and (mdbCombo.Text= 'A. 時間')) then begin
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
    end else if((mdbGrid.Columns.Items[i].FieldName= 'Qty') and (mdbCombo.Text= 'F. 總量')) then begin
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
