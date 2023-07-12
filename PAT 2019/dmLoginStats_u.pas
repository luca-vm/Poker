unit dmLoginStats_u;   //Coded and designed by Luca von Mayer 11F 2019 Parktown Boys' High School

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
