unit DB_Upgrade;

interface

uses Classes, SysUtils, ASGSQLite3, StdCtrls, db, DB_GetData;

procedure CreateDB();
procedure PrepareConnect();
procedure TansferDB(InputSQL_query: TASQLite3Query);
procedure DropTempTables(InputSQL_query: TASQLite3Query);
procedure AlterTableNM(InputSQL_query: TASQLite3Query);
procedure InsertTable(TempSQL_query: TASQLite3Query; TableNM: String; TempQuery2: TASQLite3Query);

implementation

uses DMRecord;

procedure CreateDB();
begin
  DataModule1.Cre_Configu.ExecSQL;
  DataModule1.Cre_TradeRecord.ExecSQL;
//  Cre_TradeRecord.StartTransaction;
//  Cre_TradeRecord.Commit;
  DataModule1.Cre_Param.ExecSQL;
//  Cre_Param.Commit;

  DataModule1.Cre_Index.ExecSQL;
//  Cre_Index.Commit;
  DataModule1.Cre_Record.ExecSQL;

  DataModule1.Cre_Figure.ExecSQL;
  DataModule1.Cre_StartEnd.ExecSQL;
  DataModule1.Cre_Inventory.ExecSQL;
  DataModule1.Cre_Option.ExecSQL;
  DataModule1.Cre_NewParam.ExecSQL;
end;

procedure PrepareConnect();
var SQL_Str: String;
    Qty: Integer;
begin

 DataModule1.asq_Configu.Active:= True;
 DataModule1.asq_Configu.Close;
 DataModule1.asq_Configu.SQL.Text:= 'select * from tbConfigure';
 DataModule1.asq_Configu.Open;
 Qty:= DataModule1.asq_Configu.RecordCount;

 if (Qty = 0) or (DataModule1.asq_Configu.FieldByName('DB_Version').AsString <> DB_Ver) then begin
   DB_Upgrade.DropTempTables(DataModule1.asqQU_Temp);

   DB_Upgrade.AlterTableNM(DataModule1.asqQU_Temp);
   CreateDB();

   DB_Upgrade.InsertTable(DataModule1.asqQU_Temp, 'TradeRecord', DataModule1.asqQU_Temp2);
   DB_Upgrade.InsertTable(DataModule1.asqQU_Temp, 'Parameter', DataModule1.asqQU_Temp2);
   DB_Upgrade.InsertTable(DataModule1.asqQU_Temp, 'Figure', DataModule1.asqQU_Temp2);
   DB_Upgrade.InsertTable(DataModule1.asqQU_Temp, 'IndexTable', DataModule1.asqQU_Temp2);
   DB_Upgrade.InsertTable(DataModule1.asqQU_Temp, 'RecordMsg', DataModule1.asqQU_Temp2);
   DB_Upgrade.InsertTable(DataModule1.asqQU_Temp, 'tbStartEnd', DataModule1.asqQU_Temp2);
   DB_Upgrade.InsertTable(DataModule1.asqQU_Temp, 'tbConfigure', DataModule1.asqQU_Temp2);
   DB_Upgrade.InsertTable(DataModule1.asqQU_Temp, 'tbOption', DataModule1.asqQU_Temp2);
   DB_Upgrade.InsertTable(DataModule1.asqQU_Temp, 'tbNewParam', DataModule1.asqQU_Temp2);

   if DataModule1.asq_Configu.RecordCount> 0 then begin
     DataModule1.asqQU_Temp.SQL.Text:= 'Update tbConfigure set DB_Version="' + DB_Ver + '"' ;
     DataModule1.asqQU_Temp.ExecSQL;

   end else begin
     DataModule1.asq_Configu.Close;
     SQL_Str:= 'insert into tbConfigure (DB_Version) values (' + DB_Ver + ') ';
     DataModule1.asqQU_Temp.SQL.Text:= SQL_Str;
     DataModule1.asqQU_Temp.ExecSQL;
   end;

   DB_Upgrade.DropTempTables(DataModule1.asqQU_Temp);
 end;

end;

procedure TansferDB(InputSQL_query: TASQLite3Query);
var SQL_Str: String;
begin
  DropTempTables(InputSQL_query);
  AlterTableNM(InputSQL_query);

end;

procedure DropTempTables(InputSQL_query: TASQLite3Query);
begin
  InputSQL_query.SQL.Text:= 'DROP TABLE IF EXISTS back_TradeRecord ';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'DROP TABLE IF EXISTS back_Parameter ';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'DROP TABLE IF EXISTS back_Figure ';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'DROP TABLE IF EXISTS back_IndexTable ';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'DROP TABLE IF EXISTS back_RecordMsg ';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'DROP TABLE IF EXISTS back_tbStartEnd ';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'DROP TABLE IF EXISTS back_tbConfigure ';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'DROP TABLE IF EXISTS back_tbOption ';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'DROP TABLE IF EXISTS back_tbNewParam ';
  InputSQL_query.ExecSQL;

end;

procedure AlterTableNM(InputSQL_query: TASQLite3Query);
var SQL_Str: String;
begin

  InputSQL_query.SQL.Text:= 'ALTER TABLE TradeRecord RENAME TO back_TradeRecord';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'ALTER TABLE Parameter RENAME TO back_Parameter';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'ALTER TABLE Figure RENAME TO back_Figure';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'ALTER TABLE IndexTable RENAME TO back_IndexTable';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'ALTER TABLE RecordMsg RENAME TO back_RecordMsg';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'ALTER TABLE tbStartEnd RENAME TO back_tbStartEnd';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'ALTER TABLE tbConfigure RENAME TO back_tbConfigure';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'ALTER TABLE tbOption RENAME TO back_tbOption';
  InputSQL_query.ExecSQL;
  InputSQL_query.SQL.Text:= 'ALTER TABLE tbNewParam RENAME TO back_tbNewParam';
  InputSQL_query.ExecSQL;

end;

procedure InsertTable(TempSQL_query: TASQLite3Query; TableNM: String; TempQuery2: TASQLite3Query);
var i, j, col_qty: Integer;
    columnNM, SQL_Str, temp_str: String;
    RecNo: Integer;
begin
//  InputSQL_query.Active:= true;
  TempSQL_query.SQL.Text:= 'select * from back_' + TableNM;
  TempSQL_query.Open;
  TempSQL_query.Active:= false;
  TempSQL_query.Active:= true;

  columnNM:= '';
  col_qty:= TempSQL_query.FieldCount;
  for i:= 1 to col_qty - 1 do begin
    temp_str:= TempSQL_query.Fields[i].FieldName;
    if TempSQL_query.Fields[i].FieldKind <> fkData then
      continue;

    if(i = col_qty - 1) then
      columnNM:= columnNM + TempSQL_query.Fields[i].FieldName
    else
      columnNM:= columnNM + TempSQL_query.Fields[i].FieldName + ', ';

  end;

  SQL_Str:= 'INSERT INTO ' + TableNM + '(' + columnNM + ') ' + ' SELECT ' + columnNM
				+ ' from back_' + TableNM + ';';

  TempQuery2.SQL.Text:= SQL_Str;
  TempQuery2.ExecSQL;

end;

end.
