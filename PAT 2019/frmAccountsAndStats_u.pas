unit frmAccountsAndStats_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dmLoginStats_u, Grids, DBGrids, DB, StdCtrls, ExtCtrls, DBCtrls,
  Buttons, frmPokerLVM_u;

type
  TfrmAccountsAndStats = class(TForm)
    lblAccounts: TLabel;
    dbgAccounts: TDBGrid;
    lblStats: TLabel;
    dbgStats: TDBGrid;
    dbnAccounts: TDBNavigator;
    dbnStats: TDBNavigator;
    bmbClose: TBitBtn;
    procedure bmbCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAccountsAndStats: TfrmAccountsAndStats;

implementation

{$R *.dfm}

procedure TfrmAccountsAndStats.bmbCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
