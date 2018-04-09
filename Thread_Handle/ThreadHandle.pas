unit ThreadHandle;

interface

uses Classes;

procedure StartGetData;
procedure StopGetData;

implementation


type
  TGetData=class(TThread)
  protected
    // the main body of the thread
    procedure Execute; override;
  end;

procedure TGetData.Execute;
begin
  // execute codes inside the following block until the thread is terminated
  while not Terminated do
  begin
    // play beep sound

    // yield the processor to other process/thread


  end;
end;

procedure StartGetData;
begin

  with TGetData.Create(False) do
    // Tell the TBeeper instance to automatically destroy itself once it's been terminated
    FreeOnTerminate := True;
end;

procedure StopGetData;
begin

end;

end.
