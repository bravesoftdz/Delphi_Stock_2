unit Initial_Setting;

interface

uses UxTheme, Windows, Forms, Messages, Controls;

procedure Initial_UI();

implementation

uses Public_Variant, ChungYi_Main;

procedure Initial_UI();
begin
  if(UserNM= 'JackyChou') then begin
    fmChungYi.tsAutoOrder.TabVisible:= false;
    fmChungYi.tsParam_New.TabVisible:= false;
  //  tsOrderRecord.TabVisible:= false;
    fmChungYi.tsOpenInterest.TabVisible:= false;
  end else if(UserNM= 'MrHuang') then begin
    fmChungYi.tsTableDDE.TabVisible:= false;
    fmChungYi.tsDDE_Result.TabVisible:= false;

 {   SetThemeAppProperties(0);
    SendMessage(Application.Handle,WM_THEMECHANGED,0,0);
    SendMessage(Application.Handle,CM_RECREATEWND,0,0);
    }
  end;
end;
end.
