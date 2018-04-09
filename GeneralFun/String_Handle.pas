unit String_Handle;

interface

uses Classes, SysUtils, ASGSQLite3, StdCtrls;

function getString_List(inputString: String): TStringList;
procedure getList_fromDB(asqQU_Temp: TASQLite3Query; sql_str: String; fieldNM: String;
   var ccb_box: TComboBox);

implementation

function getString_List(inputString: String): TStringList;
var getList: TStringList;
    i: Integer;
begin

  inputString:= stringreplace(inputString, ' ', '***___???', [rfReplaceAll, rfIgnoreCase]);

  getList := TStringList.Create;
  getList.CommaText:= inputString;
  getList.Delimiter:= ',';

  if(getList.Count > 0) then
  begin
   for i := 0 to getList.Count - 1 do
   begin
    getList[i]:= stringreplace(getList[i], '***___???', ' ', [rfReplaceAll, rfIgnoreCase]);
   end;
  end;

  result:= getList;
  FreeAndNil(getList);
end;

procedure getList_fromDB(asqQU_Temp: TASQLite3Query; sql_str: String; fieldNM: String;
   var ccb_box: TComboBox);
var
    i: Integer;
begin

  asqQU_Temp.Close;
  asqQU_Temp.SQL.Text:= sql_str;
  asqQU_Temp.Open;

  ccb_box.Items.Clear;
  asqQU_Temp.First;
  for I := 0 to asqQU_Temp.RecordCount - 1 do begin
    if asqQU_Temp.FieldByName(fieldNM).Text = '' then begin
      asqQU_Temp.Next;
      continue;
    end;
    ccb_box.Items.Add(asqQU_Temp.FieldByName(fieldNM).Text);
    asqQU_Temp.Next;
  end;
{
  if asqQU_Temp.FieldByName(fieldNM).Text <> '' then begin
    for I := 0 to asqQU_Temp.RecordCount - 1 do begin
      ccb_box.Items.Add(asqQU_Temp.FieldByName(fieldNM).Text);
      asqQU_Temp.Next;
    end;
  end;
  }
end;

end.
