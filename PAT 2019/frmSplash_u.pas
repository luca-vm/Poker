unit frmSplash_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, ComCtrls;

type
  TfrmSplash = class(TForm)
    imgSplash: TImage;
    lblSplash: TLabel;
    prbLoading: TProgressBar;
    lblLoading: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    iStart, iPos : Integer;
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

procedure TfrmSplash.FormActivate(Sender: TObject);  //Coded and designed by Luca von Mayer 11F 2019 Parktown Boys' High School
   var
  K, L : Integer;
begin
  frmSplash.DoubleBuffered := True; //https://stackoverflow.com/questions/8704540/delphi-form-flickering
  iStart := 1;
  prbLoading.Min := 1;
  prbLoading.Max := 100;
  prbLoading.Position := 0;

  for K := 1 to 30 do
    begin
      Inc(iStart);

        if iStart >= 5 then
     begin
          iPos := prbLoading.Position;
          prbLoading.Position := iPos +  6;
          lblLoading.Caption := IntToStr(prbLoading.Position) + '%...';

          if prbLoading.Position >= 100 then
            lblLoading.Caption := 'Done...';

          Sleep(50);
          Refresh;
     end
     else
     begin
       Sleep(50);
       Refresh;
       lblLoading.Caption := 'Waiting...';
     end;
    end;


end;

end.
