program frmBaseGameLVM_p;

uses
  Forms,
  frmPokerLVM_u in 'frmPokerLVM_u.pas' {frmPokerLVM},
  frmBaseGameLVM_u in 'frmBaseGameLVM_u.pas' {frmBaseGameLVM};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPokerLVM, frmPokerLVM);
  Application.CreateForm(TfrmBaseGameLVM, frmBaseGameLVM);
  Application.Run;
end.
