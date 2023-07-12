unit dmLoginStats_u;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TdmLoginStats = class(TDataModule)
    conLoginStats: TADOConnection;
    tblAccounts: TADOTable;
    tblStats: TADOTable;
    dsrAccounts: TDataSource;
    dsrStats: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmLoginStats: TdmLoginStats;

implementation

{$R *.dfm}

end.
