unit OverseasDll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, IniFiles, SocketDLLUnit;




type



  TDLLSocketForm = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Label6: TLabel;
    Button9: TButton;
    Label10: TLabel;
    Memo4: TMemo;
    Label11: TLabel;
    Memo5: TMemo;
    Label12: TLabel;
    Memo6: TMemo;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Edit7: TEdit;
    Edit8: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ComboBox1: TComboBox;
    Memo7: TMemo;
    Label16: TLabel;
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    TickType, TickId: integer;
    procedure WMCopy(var Msg: TWMCopyData); message WM_COPYDATA;
    procedure HandleCopyDataString(copyDataStruct: PCopyDataStruct);
    procedure HandleCopyDataRecord(copyDataStruct: PCopyDataStruct);
    { Private declarations }
  public
    { Public declarations }
  end;


var
  DLLSocketForm: TDLLSocketForm;


implementation

{$R *.dfm}



procedure TDLLSocketForm.Button9Click(Sender: TObject);
begin
  TickType := 2; //2:�^�ǱĦr��覡  1:�^�Ǳ�Record�覡
  ApiSendCmd(1 {, 2});
end;

procedure TDLLSocketForm.WMCopy(var Msg: TWMCopyData);
begin
  TickId := Msg.CopyDataStruct.dwData;
  case TickType of
    1: HandleCopyDataRecord(Msg.CopyDataStruct);  //�^�Ǳ�Record�覡
    2: HandleCopyDataString(Msg.CopyDataStruct);  //�^�Ǳ�String�覡
  end;
end;

procedure TDLLSocketForm.HandleCopyDataRecord(
  copyDataStruct: PCopyDataStruct);
var
  BTStock: TStock;
  BTHead: THead;
  BTTick: TTick;
  BTBestBidAsk: TBestBidAsk;
  ShowStr: string;
begin
  if TickId = 1 then               //����(�}���C�Q��)
  begin
    BTHead := THead(copyDataStruct.lpData^);
    ShowStr := BTHead.Option + ',' + IntToStr(BTHead.StrickPrice) + ',' + BTHead.ExchangeId + ',' + BTHead.CommodityId + ',' + IntToStr(BTHead.SettleMentYear) + ',' + IntToStr(BTHead.SettleMentMonth) + ',OpenPrice:' + FloatToStr(BTHead.OpenPrice) + ',HighPrice:' + FloatToStr(BTHead.HighPrice) + ',LowPrice:' + FloatToStr(BTHead.LowPrice) + ',RefPrice:' + FloatToStr(BTHead.RefPrice) + ',bDenominator:' + FloatToStr(BTHead.bDenominator);
    Memo4.Lines.Add(ShowStr);
  end
  else
    if TickId = 2 then            //�污
    begin
      BTStock := TStock(copyDataStruct.lpData^);
      Memo1.Lines.Add(BtStock.ExchangeId + ',' + BtStock.CommodityId + IntToStr(BtStock.SettleMentYear) + ',' + IntToStr(BtStock.SettleMentMonth) + ',' + BtStock.Time + ',' + BtStock.Option + ',SalePrice:' + FloatToStr(BtStock.SalePrice));
    end
    else
      if TickId = 3 then          //����
      begin
        BTBestBidAsk := TBestBidAsk(copyDataStruct.lpData^);
        ShowStr := BTBestBidAsk.ExchangeId + ',' + BTBestBidAsk.CommodityId + ',' + BTBestBidAsk.Option + ',' + IntToStr(BTBestBidAsk.SettleMentYear) + ',' + IntToStr(BTBestBidAsk.SettleMentMonth);
        ShowStr := ShowStr + ',askprice5:' + FloatToStr(BTBestBidAsk.AskPrice5) + ',askprice4:' + FloatToStr(BTBestBidAsk.AskPrice4) + ',askprice3:' + FloatToStr(BTBestBidAsk.AskPrice3) + ',askprice2:' + FloatToStr(BTBestBidAsk.AskPrice2) + ',askprice1:' + FloatToStr(BTBestBidAsk.AskPrice1);
        ShowStr := ShowStr + ',askvol5:' + FloatToStr(BTBestBidAsk.AskVol5) + ',askvol4:' + FloatToStr(BTBestBidAsk.AskVol4) + ',askvol3:' + FloatToStr(BTBestBidAsk.AskVol3) + ',askvol2:' + FloatToStr(BTBestBidAsk.AskVol2) + ',askvol1:' + FloatToStr(BTBestBidAsk.AskVol1);
        ShowStr := ShowStr + ',buyrice5:' + FloatToStr(BTBestBidAsk.BidPrice5) + ',buyrice4:' + FloatToStr(BTBestBidAsk.BidPrice4) + ',buyrice3:' + FloatToStr(BTBestBidAsk.BidPrice3) + ',buyrice2:' + FloatToStr(BTBestBidAsk.BidPrice2) + ',buyrice1:' + FloatToStr(BTBestBidAsk.BidPrice1);
        ShowStr := ShowStr + ',buyvol5:' + FloatToStr(BTBestBidAsk.BidVol5) + ',buyvol4:' + FloatToStr(BTBestBidAsk.BidVol4) + ',buyvol3:' + FloatToStr(BTBestBidAsk.BidVol3) + ',buyvol2:' + FloatToStr(BTBestBidAsk.BidVol2) + ',buyvol1:' + FloatToStr(BTBestBidAsk.BidVol1);
        Memo5.Lines.Add(ShowStr);
      end
      else
        if TickId = 4 then       //�������
        begin
          BTTick := TTick(copyDataStruct.lpData^);
          ShowStr := BTTick.Option + ',' + IntToStr(BTTick.SettleMentYear) + ',' + IntToStr(BTTick.SettleMentMonth) + ',' + BTTick.ExchangeId + ',' + BTTick.CommodityId + ',' + BTTick.Option + ',StrikePrice:' + IntToStr(BTTick.StrickPrice) + ',' + BTTick.TickTime + ',�����:' + FloatToStr(BTTick.SalePrice) + ',��q:' + IntToStr(BTTick.SaleVol) + ',index:' + IntToStr(BTTick.index);
          Memo6.Lines.Add(ShowStr);
        end;
end;

procedure TDLLSocketForm.HandleCopyDataString(
  copyDataStruct: PCopyDataStruct);
var
  Tick: string;
begin
  Tick := PChar(copyDataStruct.lpData);
  if TickId = 1 then                        //����(�}���C�Q��)
    Memo4.Lines.Add(Format('%s ', [Tick]))
  else
    if TickId = 2 then                      //�污
      Memo1.Lines.Add(Format('%s ', [Tick]))
    else
      if TickId = 3 then                    //����
        Memo5.Lines.Add(Format('%s ', [Tick]))
      else
        if TickId = 4 then                  //�������
          Memo6.Lines.Add(Format('%s ', [Tick]));
end;




procedure TDLLSocketForm.Button10Click(Sender: TObject);
begin
  TickType := 1; //2:�^�ǱĦr��覡  1:�^�Ǳ�Record�覡
  ApiSendCmd(2 {, TickType});
end;

procedure TDLLSocketForm.Button11Click(Sender: TObject);
begin
  TickType := 1; //2:�^�ǱĦr��覡  1:�^�Ǳ�Record�覡
  ApiSendCmd(3 {, TickType});
end;

procedure TDLLSocketForm.Button12Click(Sender: TObject);
var
  UserID, UserPW, SOURCE: PAnsiChar;
  ApHandle: Integer;
begin
  Label6.Caption := 'API�v���{�Ҥ��A�еy�J..';
  Application.ProcessMessages;

  SOURCE := PAnsiChar( Combobox1.Text); //������ƨӷ� COMSTOCK �� PATS
  UserID := PAnsiChar( Edit7.Text); //�����Ҧr��
  UserPW := PAnsiChar( Edit8.Text); //�K�X
  ApHandle := DLLSocketForm.Handle; //�����ݪ��Handle

  if Certify( SOURCE, UserID, UserPW, ApHandle) = 1 then
    Label6.Caption := 'API�v���{�ҳq�L'
  else
    Label6.Caption := 'API�v���{�ҥ���';

  Application.ProcessMessages;

end;

procedure TDLLSocketForm.FormActivate(Sender: TObject);
begin
  Memo7.Lines.LoadFromFile('QuoteList.TXT');
end;

end.

