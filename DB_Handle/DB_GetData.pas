unit DB_GetData;

interface

uses Classes, SysUtils, ASGSQLite3, StdCtrls;

function GetAll_Sql(where_str, condition, TableNM: String; InputSQL_query: TASQLite3Query;
    IsString: boolean): TASQLite3Query ;
function GetSpecific_Sql(fieldNM, where_str, condition, TableNM: String; InputSQL_query: TASQLite3Query;
    IsString: boolean): TASQLite3Query;
function GetFree_Sql(Sql_Str: String; InputSQL_query: TASQLite3Query): TASQLite3Query;
function DB_Param(where_str: String; condition: String; IsString: boolean): String;

implementation

function GetAll_Sql(where_str, condition, TableNM: String; InputSQL_query: TASQLite3Query;
    IsString: boolean): TASQLite3Query ;
var Param_Str: String;
begin
 InputSQL_query.Active:= True;
 InputSQL_query.Close;
 if(where_str= '') then
   InputSQL_query.SQL.Text:= 'select * from ' + TableNM
 else begin
   Param_Str:= DB_Param(where_str, condition, IsString);
   InputSQL_query.SQL.Text:= 'select * from ' + TableNM + ' where ' + Param_Str;
 end;

 InputSQL_query.Open;
 Result:= InputSQL_query;

end;

function GetSpecific_Sql(fieldNM, where_str, condition, TableNM: String; InputSQL_query: TASQLite3Query;
    IsString: boolean): TASQLite3Query;
var Param_Str: String;
begin
 InputSQL_query.Active:= True;
 InputSQL_query.Close;
 if(where_str= '') then
   InputSQL_query.SQL.Text:= 'select ' + fieldNM + ' from ' + TableNM
 else begin
   Param_Str:= DB_Param(where_str, condition, IsString);
   InputSQL_query.SQL.Text:= 'select ' + fieldNM + ' from ' + TableNM + ' where ' + Param_Str;
 end;

 InputSQL_query.Open;
 Result:= InputSQL_query;

end;

function GetFree_Sql(Sql_Str: String; InputSQL_query: TASQLite3Query): TASQLite3Query;
var Param_Str: String;
begin
 InputSQL_query.Active:= True;
 InputSQL_query.Close;
 InputSQL_query.SQL.Text:= Sql_Str;
 InputSQL_query.Open;
 Result:= InputSQL_query;

end;

function DB_Param(where_str: String; condition: String; IsString: boolean): String;
var i: Integer;
    where_List, condition_List: TStringList;
begin
  where_str:= stringreplace(where_str, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  Trim(condition);

  where_List:= TStringList.Create;
  where_List.Text:= where_str;
  where_List.Delimiter:= '?';
  where_List.StrictDelimiter:= True;
  where_List.DelimitedText:= where_List.Text;

  condition_List:= TStringList.Create;
  condition_List.Text:= condition;
  condition_List.Delimiter:= ',';
  condition_List.StrictDelimiter:= True;
  condition_List.DelimitedText:= condition_List.Text;

  for i := 0 to where_List.Count - 2 do
  begin
    if(IsString) then begin
      if(i= where_List.Count - 2) then
        Result:= Result + where_List.Strings[i] + '"' + Trim(condition_List[i]) + '" '
      else
        Result:= Result + where_List.Strings[i] + '"' + condition_List[i] + '" and '
    end else begin
      if(i= where_List.Count - 2) then
        Result:= Result + where_List.Strings[i] + Trim(condition_List[i])
      else
        Result:= Result + where_List.Strings[i] + condition_List[i] + ' and '
    end;
  end;


  FreeAndNil(where_List);
  FreeAndNil(condition_List);

end;

end.
