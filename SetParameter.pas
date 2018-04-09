unit SetParameter;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Forms, Public_Variant;

procedure ParameterSetting(); // �]�w�Ѽ�

implementation

uses ChungYi_Main, Registry, RegistryGetSet;

procedure ParameterSetting(); // �]�w�Ѽ�, �ǻ��Ѽ�
var CommIndex: Integer;
    temp_str: String;
begin
 // �]�w�Ѽ�============================================================================
 try  // ���o�ثe���~
  GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName) , 'TX00_MTX00');
 except
  on e:Exception do SetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'TX00_MTX00', rdString, fmChungYi.cbbCommNO.Text);
 end;

 try  // ���o�򥻤f��
  GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'edtQty');
 except
  on e:Exception do SetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'edtQty', rdString, fmChungYi.edtQty.Text);
 end;

 try  //
  GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen1');
 except
  on e:Exception do SetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen1', rdString, 'T');
 end;
 try  //
  GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen2');
 except
  on e:Exception do SetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen2', rdString, 'T');
 end;
 try  //
  GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen3');
 except
  on e:Exception do SetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen3', rdString, 'T');
 end;
 try  //
  GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen4');
 except
  on e:Exception do SetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen4', rdString, 'T');
 end;
 try  //
  GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen5');
 except
  on e:Exception do SetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen5', rdString, 'T');
 end;

 // Ū���]�w��
 fmChungYi.cbbCommNO.Text:= GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'TX00_MTX00');
 fmChungYi.edtQty.Text:= GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'edtQty');

 if GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen1') = 'T' then
  fmChungYi.cbOpen1.Checked:= True else fmChungYi.cbOpen1.Checked:= False;
 if GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen2') = 'T' then
  fmChungYi.cbOpen2.Checked:= True else fmChungYi.cbOpen2.Checked:= False;
 if GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen3') = 'T' then
  fmChungYi.cbOpen3.Checked:= True else fmChungYi.cbOpen3.Checked:= False;
 if GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen4') = 'T' then
  fmChungYi.cbOpen4.Checked:= True else fmChungYi.cbOpen4.Checked:= False;
 if GetRegistryData(HKEY_LOCAL_MACHINE, '\SOFTWARE\YuanTa\' + ExtractFilePath(Application.ExeName), 'cbOpen5') = 'T' then
  fmChungYi.cbOpen5.Checked:= True else fmChungYi.cbOpen5.Checked:= False;

end;
end.
