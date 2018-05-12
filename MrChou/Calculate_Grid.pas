unit Calculate_Grid;

interface

uses Classes, DBCtrls, DBGrids, Grids, SysUtils, DMRecord, Public_Variant, ASGSQLite3,
     DBClient, AdjustField;

procedure RunTable_1st(mdbGrid: TDBGrid; mStringGrid: TStringGrid; m2ndGrid, m3rdGrid: TStringGrid;
  X, Y, Z: Extended; ShowA4: boolean; In_Query: TClientDataSet);
procedure GridClear(mStringGrid: TStringGrid);
procedure getAll_Grid(mStringGrid: TStringGrid; var mList: TStringList);
procedure InsertData_Grid(mStringGrid: TStringGrid; mList: TStringList; Field_Index: TIntegerArray;
   toLast: boolean);
procedure Initial_StringGrid(mStringGrid: TStringGrid; cb_1: TDBComboBox; cb_2: TDBComboBox;
  cb_3: TDBComboBox; cb_4: TDBComboBox);
procedure RunTable_1st_fromList(mStringGrid: TStringGrid; m2ndGrid, m3rdGrid: TStringGrid;
  X, Y, Z: Extended; ShowA4: boolean; mInput_Grid: TStringGrid; UpdateOnly: boolean; toLast: boolean);

implementation


procedure RunTable_1st(mdbGrid: TDBGrid; mStringGrid: TStringGrid; m2ndGrid, m3rdGrid: TStringGrid;
  X, Y, Z: Extended; ShowA4: boolean; In_Query: TClientDataSet);
var List_2, List_4: array of TStringList;
    List_3: TStringList;
    Table2_List, Table3_List: TStringList;
    i, j, count_index: Integer;
    record_3, record_4: boolean;
    Table_2_Count: Integer;
    now_rowB, next_rowB, now_rowA, now_rowC, now_rowD, Substrat_B1, Substrat_B2: Extended;
    table1_index, table2_index, table2_no: Integer;
    DataQty: Integer;
begin
{
  record_3:= false;
  record_4:= false;
  Table_2_Count:= 0;
  table1_index:= 0;
  table2_index:= 0;
  table2_no:= 0;
  GridClear(mStringGrid);
  GridClear(m2ndGrid);
  GridClear(m3rdGrid);
  if(not ShowA4) then
    m3rdGrid.Visible:= false
  else m3rdGrid.Visible:= true;

  // 0: b2-b1 , e ; 6: b4-b3
  // 1, 2,3,4: a,b,c,d
  SetLength(List_2, 5);  // record a2, b2, c2, d2, b2-b1 to a1, b1, c1, d1, e1

  SetLength(List_4, 5); // record a4, b4, c4, d4, b4-b3 to a2, b2, c2, d2, e2

  for i := 0 to Length(List_2) - 1 do
    List_2[i]:= TStringList.Create;
  for i := 0 to Length(List_4) - 1 do
    List_4[i]:= TStringList.Create;

  List_3:= TStringList.Create;


 // mdbGrid.DataSource:= nil;
  In_Query.First;
  for i := 0 to In_Query.RecordCount - 2 do  begin

    now_rowA:= In_Query.Fields[0].AsDateTime;
    next_rowB:= In_Query.Fields[1].AsFloat;
    now_rowC:= In_Query.Fields[2].AsFloat;
    now_rowD:= In_Query.Fields[3].AsFloat;


    if(record_4) then begin // record b4
      Substrat_B2:= next_rowB - StrToFloat(List_3.Strings[List_3.Count - 1]);
      List_4[0].Add(FloatToStr(Substrat_B2));
      List_4[1].Add(DateTimeToStr(now_rowA));
      List_4[2].Add(FloatToStr(next_rowB));
      List_4[3].Add(FloatToStr(now_rowC));
      List_4[4].Add(FloatToStr(now_rowD));

      record_4:= false;
    end;

    if(record_3) then begin  // record b3
      List_3.Add(FloattoStr(next_rowB));
      record_3:= false;
      record_4:= true;
    end;


    if(i > 0) then begin
      Substrat_B1:= next_rowB - now_rowB;
      List_2[0].Add(FloatToStr(Substrat_B1));
      if((Substrat_B1 > X) or (Substrat_B1 < Y)) and (now_rowC > Z) then begin
        List_2[1].Add(DateTimeToStr(now_rowA));
        List_2[2].Add(FloatToStr(next_rowB));
        List_2[3].Add(FloatToStr(now_rowC));
        List_2[4].Add(FloatToStr(now_rowD));

        Table_2_Count:= Table_2_Count + 1 ;
        record_3:= true;
      end else begin
        List_2[1].Add('-');
        List_2[2].Add('-');
        List_2[3].Add('-');
        List_2[4].Add('-');
      end;
    end;

    now_rowB:= In_Query.Fields[1].AsFloat;
    In_Query.Next;
  end;

  In_Query.First;
//  mdbGrid.DataSource:= DataModule1.ds_cdsTemp;
//  mdbGrid.DataSource:= DataModule1.dsTradeRecord;

//  mStringGrid.Cells[0, 0]:= 'b2-b1';
  mStringGrid.Cells[0, 0]:= 'SN';
  mStringGrid.Cells[1, 0]:= 'a';
  mStringGrid.Cells[2, 0]:= 'b';
  mStringGrid.Cells[3, 0]:= 'c';
  mStringGrid.Cells[4, 0]:= 'd';

  m2ndGrid.RowCount:= List_2[1].Count + 1;  // table 2
  m2ndGrid.Cells[0, 0]:= 'SN';
  m2ndGrid.Cells[1, 0]:= 'a';
  m2ndGrid.Cells[2, 0]:= 'b';
  m2ndGrid.Cells[3, 0]:= 'c';
  m2ndGrid.Cells[4, 0]:= 'd';
  m2ndGrid.Cells[5, 0]:= 'e';  // 'b2-b1'

  m3rdGrid.RowCount:= List_4[1].Count + 1;  // table 3
  m3rdGrid.Cells[0, 0]:= 'SN';
  m3rdGrid.Cells[1, 0]:= 'a';
  m3rdGrid.Cells[2, 0]:= 'b';
  m3rdGrid.Cells[3, 0]:= 'c';
  m3rdGrid.Cells[4, 0]:= 'd';
  m3rdGrid.Cells[5, 0]:= 'e';  // 'b4-b3'

  for i := 0 to List_2[0].Count - 1 do begin  // table 1
    table1_index:= i mod 4 + 1;

    mStringGrid.Cells[1, table1_index]:= List_2[1].Strings[i];
    mStringGrid.Cells[2, table1_index]:= List_2[2].Strings[i];
    mStringGrid.Cells[3, table1_index]:= List_2[3].Strings[i];
    mStringGrid.Cells[4, table1_index]:= List_2[4].Strings[i];

  end;

  DataQty:= List_2[1].Count;
  for i := 0 to DataQty - 1 do begin   // table 2
    if(List_2[1].Strings[i] <> '-') then begin

      table2_index:= 2 * i + 1;
      table2_no:= table2_no + 1;
      // a2 to a1
      m2ndGrid.Cells[0, table2_no]:= IntToStr(table2_no);  // title
      m2ndGrid.Cells[1, table2_no]:= List_2[1].Strings[i];
      m2ndGrid.Cells[2, table2_no]:= List_2[2].Strings[i];
      m2ndGrid.Cells[3, table2_no]:= List_2[3].Strings[i];
      m2ndGrid.Cells[4, table2_no]:= List_2[4].Strings[i];
      m2ndGrid.Cells[5, table2_no]:= List_2[0].Strings[i];

    end;
  end;

  table2_no:= 0;
  for i := 0 to List_4[1].Count - 1 do begin
      table2_no:= table2_no + 1;
    // a4 to a2
      if(not ShowA4) then
        continue;
      m3rdGrid.Cells[0, table2_no]:= IntToStr(table2_no);  // title
      m3rdGrid.Cells[1, table2_no]:= List_4[1].Strings[i];
      m3rdGrid.Cells[2, table2_no]:= List_4[2].Strings[i];
      m3rdGrid.Cells[3, table2_no]:= List_4[3].Strings[i];
      m3rdGrid.Cells[4, table2_no]:= List_4[4].Strings[i];
      m3rdGrid.Cells[5, table2_no]:= List_4[0].Strings[i];
  end;


  Table2_List:= TStringList.Create;
  Table3_List:= TStringList.Create;
  getAll_Grid(m2ndGrid, Table2_List);
  getAll_Grid(m3rdGrid, Table3_List);

  Table2_List.SaveToFile(Public_Variant.PathDir + 'table\Table2.txt');
  Table3_List.SaveToFile(Public_Variant.PathDir + 'table\Table3.txt');
  FreeAndNil(Table2_List);
  FreeAndNil(Table3_List);


  for i := 0 to Length(List_2) - 1 do begin
    if List_2[i] <> nil then
      FreeAndNil(List_2[i]);
  end;

  if(List_3 <> nil) then
    FreeAndNil(List_3);
  for i := 0 to Length(List_4) - 1 do begin
    if List_4[i] <> nil then
      FreeAndNil(List_4[i]);
  end;

  // Table adjust
  mStringGrid.ColWidths[0]:= 50;
  m2ndGrid.ColWidths[0]:= 50;
  m3rdGrid.ColWidths[0]:= 50;
  for i := 1 to mStringGrid.ColCount - 1 do
    mStringGrid.ColWidths[i]:= 50;
  for i := 1 to m2ndGrid.ColCount - 1 do
    m2ndGrid.ColWidths[i]:= 50;
  for i := 1 to m3rdGrid.ColCount - 1 do
    m3rdGrid.ColWidths[i]:= 50;

  mStringGrid.ColWidths[1]:= 130; // DateTime
  m2ndGrid.ColWidths[1]:= 130;
  m3rdGrid.ColWidths[1]:= 130;
  }
end;

procedure GridClear(mStringGrid: TStringGrid);
var i: Integer;
begin
  if (mStringGrid.ColCount > 1) then begin
    for i := 1 to mStringGrid.ColCount - 1 do
      mStringGrid.Cols[i].Clear;
  end;

end;

procedure getAll_Grid(mStringGrid: TStringGrid; var mList: TStringList);
var i, j: Integer;
    temp_str: String;
begin
  for i := 0 to mStringGrid.RowCount - 1 do begin
    for j := 0 to mStringGrid.ColCount - 1 do begin
      if(j= mStringGrid.ColCount - 1) then
         temp_str:= temp_str + mStringGrid.Cells[j, i]
      else temp_str:= temp_str + mStringGrid.Cells[j, i] + ',';
    end;
    mList.Add(temp_str);
    temp_str:= '';
  end;
end;

// for raw data
procedure InsertData_Grid(mStringGrid: TStringGrid; mList: TStringList; Field_Index: TIntegerArray;
   toLast: boolean);
var i, j: Integer;
    StartIndex: Integer;
begin
  if(mStringGrid.RowCount = 2) then
    StartIndex:= 1
  else
    StartIndex:= mStringGrid.RowCount;

  mStringGrid.Cells[0, 0]:= 'SN';
  if mList.Count > 0 then begin
    mStringGrid.RowCount:= mList.Count;

    for i := StartIndex to mList.Count - 1 do begin
      TempList.Text:= mList.Strings[i];
      TempList.Delimiter:= ',';
      TempList.DelimitedText:= TempList.Text;

      mStringGrid.Cells[0, i]:= IntToStr(i + 1);
      for j := 0 to Length(Field_Index) - 1 do begin
        if Field_Index[j]= 2 then begin
          mStringGrid.Cells[j + 1, i]:= TempList.Strings[2] + ' ' + TempList.Strings[3];;
        end else
          mStringGrid.Cells[j + 1, i]:= TempList.Strings[Field_Index[j]];
      end;
    end;

  end;

  if(toLast) then
    mStringGrid.Row:= mStringGrid.RowCount - 1;
  mStringGrid.FixedRows:= 1;
end;


procedure RunTable_1st_fromList(mStringGrid: TStringGrid; m2ndGrid, m3rdGrid: TStringGrid;
  X, Y, Z: Extended; ShowA4: boolean; mInput_Grid: TStringGrid; UpdateOnly: boolean;
  toLast: boolean);
var List_2, List_4: array of TStringList;
    List_3: TStringList;
    Table2_List, Table3_List: TStringList;
    i, j, count_index: Integer;
    record_3, record_4: boolean;
    Table_2_Count: Integer;
    now_rowB, next_rowB, now_rowA, now_rowC, now_rowD, Substrat_B1, Substrat_B2: Extended;
    table1_index, table2_index, table2_no: Integer;
    DataQty: Integer;
begin
  record_3:= false;
  record_4:= false;
  Table_2_Count:= 0;
  table1_index:= 0;
  table2_index:= 0;
  table2_no:= 0;
  if(not UpdateOnly) then begin
    GridClear(mStringGrid);
    GridClear(m2ndGrid);
    GridClear(m3rdGrid);
  end;

  if(not ShowA4) then
    m3rdGrid.Visible:= false
  else m3rdGrid.Visible:= true;

//  AllSQLList
  // 0: b2-b1 , e ; 6: b4-b3
  // 1, 2,3,4: a,b,c,d
  SetLength(List_2, 5);  // record a2, b2, c2, d2, b2-b1 to a1, b1, c1, d1, e1

  SetLength(List_4, 5); // record a4, b4, c4, d4, b4-b3 to a2, b2, c2, d2, e2

  for i := 0 to Length(List_2) - 1 do
    List_2[i]:= TStringList.Create;
  for i := 0 to Length(List_4) - 1 do
    List_4[i]:= TStringList.Create;

  List_3:= TStringList.Create;


  for i := 0 to mInput_Grid.RowCount - 2 do  begin
    if(mInput_Grid.Cells[1 ,i + 1]= '') then
      break;

    now_rowA:= StrToDateTime(mInput_Grid.Cells[1 ,i + 1]);
    next_rowB:= StrToFloat(mInput_Grid.Cells[2 ,i + 1]);
    now_rowC:= StrToFloat(mInput_Grid.Cells[3 ,i + 1]);
    now_rowD:= StrToFloat(mInput_Grid.Cells[4 ,i + 1]);


    if(record_4) then begin // record b4
      Substrat_B2:= next_rowB - StrToFloat(List_3.Strings[List_3.Count - 1]);
      List_4[0].Add(FloatToStr(Substrat_B2));
      List_4[1].Add(DateTimeToStr(now_rowA));
      List_4[2].Add(FloatToStr(next_rowB));
      List_4[3].Add(FloatToStr(now_rowC));
      List_4[4].Add(FloatToStr(now_rowD));

      record_4:= false;
    end;

    if(record_3) then begin  // record b3
      List_3.Add(FloattoStr(next_rowB));
      record_3:= false;
      record_4:= true;
    end;


    if(i > 0) then begin
      Substrat_B1:= next_rowB - now_rowB;
    //  List_2[0].Add(FloatToStr(Substrat_B1));
      if((Substrat_B1 > X) or (Substrat_B1 < Y)) and (now_rowC > Z) then begin
        List_2[0].Add(FloatToStr(Substrat_B1));
        List_2[1].Add(DateTimeToStr(now_rowA));
        List_2[2].Add(FloatToStr(next_rowB));
        List_2[3].Add(FloatToStr(now_rowC));
        List_2[4].Add(FloatToStr(now_rowD));

        Table_2_Count:= Table_2_Count + 1 ;
        record_3:= true;
      end else begin
    //      List_2[0].Add(FloatToStr(Substrat_B1));
    //    List_2[1].Add('-');
    //    List_2[2].Add('-');
    //    List_2[3].Add('-');
    //    List_2[4].Add('-');
      end;
    end;

    now_rowB:= StrToFloat(mInput_Grid.Cells[2 ,i + 1]);
  end;


//  mStringGrid.Cells[0, 0]:= 'b2-b1';
  mStringGrid.Cells[0, 0]:= 'SN';
  mStringGrid.Cells[1, 0]:= 'a';
  mStringGrid.Cells[2, 0]:= 'b';
  mStringGrid.Cells[3, 0]:= 'c';
  mStringGrid.Cells[4, 0]:= 'd';

  m2ndGrid.RowCount:= List_2[1].Count + 1;  // table 2
  m2ndGrid.Cells[0, 0]:= 'SN';
  m2ndGrid.Cells[1, 0]:= 'a';
  m2ndGrid.Cells[2, 0]:= 'b';
  m2ndGrid.Cells[3, 0]:= 'c';
  m2ndGrid.Cells[4, 0]:= 'd';
  m2ndGrid.Cells[5, 0]:= 'e';  // 'b2-b1'

  m3rdGrid.RowCount:= List_4[1].Count + 1;  // table 3
  m3rdGrid.Cells[0, 0]:= 'SN';
  m3rdGrid.Cells[1, 0]:= 'a';
  m3rdGrid.Cells[2, 0]:= 'b';
  m3rdGrid.Cells[3, 0]:= 'c';
  m3rdGrid.Cells[4, 0]:= 'd';
  m3rdGrid.Cells[5, 0]:= 'e';  // 'b4-b3'

  for i := 0 to List_2[0].Count - 1 do begin  // table 1
    table1_index:= i mod 4 + 1;

    mStringGrid.Cells[1, table1_index]:= List_2[1].Strings[i];
    mStringGrid.Cells[2, table1_index]:= List_2[2].Strings[i];
    mStringGrid.Cells[3, table1_index]:= List_2[3].Strings[i];
    mStringGrid.Cells[4, table1_index]:= List_2[4].Strings[i];

  end;

  DataQty:= List_2[1].Count;
  for i := 0 to DataQty - 1 do begin   // table 2
    if(List_2[1].Strings[i] <> '-') then begin

      table2_index:= 2 * i + 1;
      table2_no:= table2_no + 1;
      // a2 to a1
      m2ndGrid.Cells[0, table2_no]:= IntToStr(table2_no);  // title
      m2ndGrid.Cells[1, table2_no]:= List_2[1].Strings[i];
      m2ndGrid.Cells[2, table2_no]:= List_2[2].Strings[i];
      m2ndGrid.Cells[3, table2_no]:= List_2[3].Strings[i];
      m2ndGrid.Cells[4, table2_no]:= List_2[4].Strings[i];
      m2ndGrid.Cells[5, table2_no]:= List_2[0].Strings[i];

    end;
  end;

  table2_no:= 0;
  if(ShowA4) then begin
    for i := 0 to List_4[1].Count - 1 do begin
      table2_no:= table2_no + 1;
    // a4 to a2
      m3rdGrid.Cells[0, table2_no]:= IntToStr(table2_no);  // title
      m3rdGrid.Cells[1, table2_no]:= List_4[1].Strings[i];
      m3rdGrid.Cells[2, table2_no]:= List_4[2].Strings[i];
      m3rdGrid.Cells[3, table2_no]:= List_4[3].Strings[i];
      m3rdGrid.Cells[4, table2_no]:= List_4[4].Strings[i];
      m3rdGrid.Cells[5, table2_no]:= List_4[0].Strings[i];
    end;
  end;


  for i := 0 to Length(List_2) - 1 do begin
    if List_2[i] <> nil then
      FreeAndNil(List_2[i]);
  end;

  if(List_3 <> nil) then
    FreeAndNil(List_3);
  for i := 0 to Length(List_4) - 1 do begin
    if List_4[i] <> nil then
      FreeAndNil(List_4[i]);
  end;

  {
  // Table adjust
  mStringGrid.ColWidths[0]:= 50;
  m2ndGrid.ColWidths[0]:= 50;
  m3rdGrid.ColWidths[0]:= 50;
  for i := 1 to mStringGrid.ColCount - 1 do
    mStringGrid.ColWidths[i]:= 50;
  for i := 1 to m2ndGrid.ColCount - 1 do
    m2ndGrid.ColWidths[i]:= 50;
  for i := 1 to m3rdGrid.ColCount - 1 do
    m3rdGrid.ColWidths[i]:= 50;

  mStringGrid.ColWidths[1]:= 130; // DateTime
  m2ndGrid.ColWidths[1]:= 130;
  m3rdGrid.ColWidths[1]:= 130;
   }
  if(m2ndGrid.RowCount > 1) then
    m2ndGrid.FixedRows:= 1;
  if(m3rdGrid.RowCount > 1) then
    m3rdGrid.FixedRows:= 1;
  if(toLast) then begin
    m2ndGrid.Row:= m2ndGrid.RowCount - 1;
    m3rdGrid.Row:= m3rdGrid.RowCount - 1;
  end;
end;


procedure Initial_StringGrid(mStringGrid: TStringGrid; cb_1: TDBComboBox; cb_2: TDBComboBox;
  cb_3: TDBComboBox; cb_4: TDBComboBox);
begin
  mStringGrid.RowCount:= 2;
  mStringGrid.ColCount:= 5;
  mStringGrid.ColWidths[1]:= 130;

  mStringGrid.Cells[1, 0]:= cb_1.Text;
  mStringGrid.Cells[2, 0]:= cb_2.Text;
  mStringGrid.Cells[3, 0]:= cb_3.Text;
  mStringGrid.Cells[4, 0]:= cb_4.Text;


end;
end.
