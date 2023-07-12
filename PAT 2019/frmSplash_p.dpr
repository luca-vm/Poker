program frmSplash_p;

uses
  Forms,
  frmPokerLVM_u in 'frmPokerLVM_u.pas' {frmPokerLVM},
  frmBaseGameLVM_u in 'frmBaseGameLVM_u.pas' {frmBaseGameLVM},
  dmLoginStats_u in 'dmLoginStats_u.pas' {dmLoginStats: TDataModule},
  frmSplash_u in 'frmSplash_u.pas' {frmSplash},
  SysUtils;

{$R *.res}

begin
  Application.Initialize;
  frmSplash := TfrmSplash.Create(Application);
  frmSplash.Show();
  frmSplash.Refresh();
  Sleep(1500);
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPokerLVM, frmPokerLVM);
  Application.CreateForm(TfrmBaseGameLVM, frmBaseGameLVM);
  Application.CreateForm(TdmLoginStats, dmLoginStats);
  frmSplash.Free;
  Application.Run;
end.
