unit frmPokerLVM_u;  //Coded and designed by Luca von Mayer 11F 2019 Parktown Boys' High School

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, GIFImg, StdCtrls, pngimage, Math, ComCtrls, Spin,
  dmLoginStats_u, Grids, DBGrids, DB, Buttons;

type
  TfrmPokerLVM = class(TForm)
    imgMultiPlayer: TImage;
    pnlMultiPlayer: TPanel;
    pnlLogin: TPanel;
    edtUsername: TEdit;
    lblUsername: TLabel;
    lblLogin: TLabel;
    lblPassword: TLabel;
    edtPassword: TEdit;
    lblNew: TLabel;
    lblCreate: TLabel;
    btnLogin: TButton;
    tmrFlashStart: TTimer;
    pnlStart: TPanel;
    lblStart: TLabel;
    tmrFlashMulti: TTimer;
    imgBackgroundGIF: TImage;
    pnlCustomise: TPanel;
    lblCustomiseHeading: TLabel;
    cbbCard: TComboBox;
    lblCard: TLabel;
    imgCardSelect: TImage;
    lblReady: TLabel;
    tmrFlashReady: TTimer;
    cbbMap: TComboBox;
    lblMap: TLabel;
    imgMap: TImage;
    lblRules: TLabel;
    memView: TMemo;
    lblHands: TLabel;
    lblMulti: TLabel;
    sedMulti: TSpinEdit;
    edtRepeatPassword: TEdit;
    lblRepeatPassword: TLabel;
    lblName: TLabel;
    edtName: TEdit;
    bmbClose: TBitBtn;
    lblBuy: TLabel;
    sedBuyin: TSpinEdit;
    lblNames: TLabel;
    edtPlayer2: TEdit;
    edtPlayer3: TEdit;
    edtPlayer4: TEdit;

    procedure imgMultiPlayerMouseEnter(Sender: TObject);
    procedure imgMultiPlayerMouseLeave(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure imgMultiPlayerClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure tmrFlashMultiTimer(Sender: TObject);
    procedure tmrFlashStartTimer(Sender: TObject);
    procedure cbbCardChange(Sender: TObject);
    procedure tmrFlashReadyTimer(Sender: TObject);
    procedure lblReadyClick(Sender: TObject);
    procedure cbbMapChange(Sender: TObject);
    procedure lblRulesClick(Sender: TObject);
    procedure lblHandsClick(Sender: TObject);
    procedure lblCreateClick(Sender: TObject);
    procedure bmbCloseClick(Sender: TObject);
    procedure sedMultiChange(Sender: TObject);

  private
    arrRules : array[1..21] of string;
    arrHands : array[1..11] of string;
    imgStart : TImage;
    pnlHeading : TPanel;
    pnlSubHeading : TPanel;
    procedure Start(Sender : TObject);
    procedure LoadTextfile(sFile : string; iMax : Integer);
  public
   bMultiPlayer : Boolean;
   sCardColour, sMap, sLoginUsername, sPlayer2, sPlayer3, sPlayer4 : string;
   iNumPlayers : Integer;
   rBuyin : Real;
  end;

var
  frmPokerLVM: TfrmPokerLVM;

implementation

uses frmBaseGameLVM_u;

{$R *.dfm}

procedure TfrmPokerLVM.bmbCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPokerLVM.btnLoginClick(Sender: TObject);
  var
  sFullName, sUsername, sName, sSurname, sPassword, sRepeatedPassword, sAccountID, sFirst2, sLast2, sLoginPassword : string;
  K, L, iRandomNum :  Integer;
  bContainsLetter, bContainsDigit, bCorrectUsername, bCorrectPassword : Boolean;
begin
 if edtRepeatPassword.Visible = False then
 begin
   //Login
  sLoginUsername := edtUsername.Text;
  sLoginPassword := edtPassword.Text;

  with dmLoginStats do
    begin
      if tblAccounts.Locate('Username',sLoginUsername,[]) then
      begin
        bCorrectUsername := True;

        if  tblAccounts['Password'] = sLoginPassword then
        begin
          bCorrectPassword := True
        end
        else
        begin
          MessageDlg('Incorrect password, please re-enter',mtError,[mbOK],0);
          edtPassword.Clear;
          edtPassword.SetFocus;
          Exit;
        end;
      end
       else
        begin
          MessageDlg('Incorrect username, please re-enter',mtError,[mbOK],0);
          edtUsername.Clear;
          edtUsername.SetFocus;
          Exit;
        end;

        end;
    end;

  if (bCorrectUsername = True) and (bCorrectPassword = True)then
  begin
   MessageDlg('Login successful!',mtInformation,[mbOK],0);

   imgStart.Free;
   imgStart := nil;
   pnlSubHeading.Free;
   pnlSubHeading := nil;
   pnlLogin.Free;
   pnlLogin := nil;
   tmrFlashStart.Free;
   tmrFlashStart := nil;
   tmrFlashMulti.Enabled := False;

    Sleep(1000);

    with imgBackgroundGIF do
    begin
      Width := 1386;
      Height := 650;
      Left := 0;
      Top := 100;
      Picture.LoadFromFile('Images\SelectPlayerGIF.gif');
    end;

  (imgBackgroundGIF.Picture.Graphic as TGIFImage).Animate := True; //Borrowed code: https://stackoverflow.com/questions/9573572/how-to-use-animated-gif-in-a-delphi-form

   pnlHeading.Font.Size := 36;
   pnlHeading.Left := 200;
   pnlHeading.Width := 1015;
   pnlHeading.Caption := 'Select Number of Players';

   pnlMultiPlayer.Visible := True;
  end
 else
 begin
  sFullName := edtName.Text;
  sPassword := edtPassword.Text;
  sRepeatedPassword := edtRepeatPassword.Text;
  sUsername := edtUsername.Text;

    //Validation of Name
    if sFullName = '' then
        begin
         MessageDlg('All fields are compulsory, please enter name.',mtError,[mbOK],0);
         edtName.Clear;
         edtName.SetFocus;
         Exit;
        end;

   for K := 1 to Length(sFullName) do
     begin
       if not((sFullName[K] in['A'..'Z']) or (sFullName[K] in['a'..'z']) or (sFullName[K] = ' '))  then
       begin
        MessageDlg('The name you entered contains numbered digits or symbols, please re-enter.',mtError,[mbOK],0);
        edtName.Clear;
        edtName.SetFocus;
        Exit;
       end;

       if (sFullName[K] = ' ') and (sFullName[K+1] = ' ') then
       begin
        MessageDlg('The name you entered contains a double space, please re-enter.',mtError,[mbOK],0);
        edtName.Clear;
        edtName.SetFocus;
        Exit;
       end;

     end;


   sName := Copy(sFullName,1,Pos(' ',sFullName)-1);
   sSurname := Copy(sFullName,Pos(' ',sFullName),Length(sFullName));

   //Validation of Password
   if (sPassword = '') or (sRepeatedPassword = '')then
        begin
         MessageDlg('All fields are compulsory, please enter password.',mtError,[mbOK],0);
         edtPassword.Clear;
         edtRepeatPassword.Clear;
         edtPassword.SetFocus;
         Exit;
        end;
   if Length(sPassword) < 8 then
    begin
     MessageDlg('Password has to be 8 or more characters, please re-enter',mtError,[mbOK],0);
     edtPassword.Clear;
     edtRepeatPassword.Clear;
     edtPassword.SetFocus;
     Exit;
    end;

   for L := 1 to Length(sPassword) do
     begin
       if (sPassword[L] in['A'..'Z']) or (sPassword[L] in['a'..'z']) then
        bContainsLetter := True;

       if sPassword[L] in['0'..'9']  then
          bContainsDigit := True;
     end;

   if not((bContainsLetter = True) and (bContainsDigit = True)) then
        begin
          MessageDlg('Password has to contain atleast 1 letter and 1 number, please re-enter',mtError,[mbOK],0);
          edtPassword.Clear;
          edtRepeatPassword.Clear;
          edtPassword.SetFocus;
          Exit;
        end;

   if not(edtPassword.Text = edtRepeatPassword.Text) then
    begin
      MessageDlg('Passwords do not match, please re-enter.',mtError,[mbOK],0);
      edtPassword.Clear;
      edtRepeatPassword.Clear;
      edtPassword.SetFocus;
      Exit;
    end;

   //Validation of Username
   if sUsername = '' then
        begin
         MessageDlg('All fields are compulsory, please enter username.',mtError,[mbOK],0);
         edtUsername.Clear;
         edtUsername.SetFocus;
         Exit;
        end;

   if Length(sUsername) > 10 then
     begin
      MessageDlg('Username cannot be more than 1o characters, please enter username.',mtError,[mbOK],0);
      edtUsername.Clear;
      edtUsername.SetFocus;
      Exit;
     end;

    //Create AccountID
     sFirst2 := Copy(sUsername,1,2);
     sLast2 := Copy(sUsername,Length(sUsername) - 1,2);
     iRandomNum := RandomRange(1000,9999);
     sAccountID := sFirst2 + sLast2 + IntToStr(iRandomNum);


   //Add to the account database
    with dmLoginStats do
    begin
      tblAccounts.Last;
      tblAccounts.Insert;
      tblAccounts['AccountID'] := sAccountID;
      tblAccounts['FirstName'] := sName;
      tblAccounts['Surname'] := sSurname;
      tblAccounts['Username'] := sUsername;
      tblAccounts['Password'] := sPassword;
      tblAccounts.Post;

      tblStats.Last;
      tblStats.Insert;
      tblStats['AccountID'] := sAccountID;
      tblStats.Post;
    end;

   btnLogin.Enabled := False;
   MessageDlg('Account created!',mtInformation,[mbOK],0);
 end;

end;



procedure TfrmPokerLVM.cbbCardChange(Sender: TObject);
begin
 case cbbCard.ItemIndex of
    0 :  sCardColour := 'blue';
    1 :  sCardColour := 'gray';
    2 :  sCardColour := 'green';
    3 :  sCardColour := 'purple';
    4 :  sCardColour := 'red';
    5 :  sCardColour := 'yellow';
  end;

  imgCardSelect.Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
end;

procedure TfrmPokerLVM.cbbMapChange(Sender: TObject);
begin
  case cbbMap.ItemIndex of
    0 :  sMap := '1';
    1 :  sMap  := '2';
    2 :  sMap  := '3';
    3 :  sMap  := '4';
    4 :  sMap  := '5';
  end;

  if cbbMap.ItemIndex = 0
     then
      imgMap.Picture.LoadFromFile('TableTops\TableTop' +  sMap + '.png')
      else
      imgMap.Picture.LoadFromFile('TableTops\TableTop' +  sMap + '.jpg');
end;

procedure TfrmPokerLVM.FormActivate(Sender: TObject);
begin
   dmLoginStats.tblAccounts.Open;
   dmLoginStats.tblStats.Open;

  //Dynamically create imgStart
  imgStart := TImage.Create(frmPokerLVM);
    with imgStart do
    begin
      Parent := frmPokerLVM;
      Name := 'imgStart';
      Width := 1386;
      Height := 749;
      Left := 0;
      Top := 0;
      Stretch := True;
      Picture.LoadFromFile('Images\StartScreen.png');
    end;

 //Dynamically create pnlHeading
  pnlHeading := TPanel.Create(frmPokerLVM);
    with pnlHeading do
    begin
      Parent := frmPokerLVM;
      Name := 'pnlHeading';
      Caption := 'Texas Hold ' + #39 + 'em';
      Color := clBtnFace;
      Brush.Color := clBtnFace;
      Width := 905;
      Height := 89;
      Left := 248;
      Top := 0;
      Font.Color := clRed;
      Font.Size := 48;
      Font.Name := 'Wide Latin';
      BevelOuter := bvNone;
    end;

 //Dynamically create pnlSubHeading
 pnlSubHeading := TPanel.Create(frmPokerLVM);
    with pnlSubHeading do
    begin
      Parent := frmPokerLVM;
      Name := 'pnlSubHeading';
      Caption := 'a game by Luca von Mayer';
      Color := clBtnFace;
      Brush.Color := clBtnFace;
      Width := 401;
      Height := 49;
      Left := 496;
      Top := 103;
      Font.Color := clRed;
      Font.Size := 26;
      Font.Name := 'Impact';
      BevelOuter := bvNone;
    end;

 //Movement of start
    with pnlStart do
    begin
      Width := 201;
      Height := 113;
      Left := 592;
      Top := 408;
      Color := $00010217;
      Caption := '';
      BevelOuter := bvNone;
      OnClick := Start;
    end;

    with lblStart do
    begin
      Width := 201;
      Height := 113;
      Left := 0;
      Top := 0;
      Caption := 'Start';
      Font.Color := clRed;
      Font.Name := 'Impact';
      Font.Size := 72;
      OnClick := Start;
    end;



  pnlMultiPlayer.Visible := False;
  pnlLogin.Visible := False;

end;



procedure TfrmPokerLVM.imgMultiPlayerClick(Sender: TObject);
begin
  bMultiPlayer := True;

  pnlMultiPlayer.Free;
  tmrFlashMulti.Free;
  (imgBackgroundGIF.Picture.Graphic as TGIFImage).Animate := True;

  with pnlCustomise do
    begin
      Height := 433;
      Left := 368;
      Top := 141;
      Width := 649;
    end;

  pnlCustomise.Visible := True;
  tmrFlashReady.Enabled := True;
  lblMulti.Visible := True;
  sedMulti.Visible := True;
  cbbCard.ItemIndex := 1;
  cbbMap.ItemIndex := 0;
  sCardColour := 'gray';
  sMap := '1';
  lblNames.Visible := True;
  edtPlayer2.Visible := True;
end;

procedure TfrmPokerLVM.imgMultiPlayerMouseEnter(Sender: TObject);
begin
  tmrFlashMulti.Enabled := True;
  Sleep(30);
  pnlMultiPlayer.Width := 290;
  pnlMultiPlayer.Height := 520;
  imgMultiPlayer.Width := 260;
  imgMultiPlayer.Height := 488;
  pnlMultiPlayer.Top := 98;
  pnlMultiPlayer.Left := 553;
  pnlHeading.Caption := 'Multi Player';
  (imgBackgroundGIF.Picture.Graphic as TGIFImage).Animate := False;;
end;

procedure TfrmPokerLVM.imgMultiPlayerMouseLeave(Sender: TObject);
begin
  tmrFlashMulti.Enabled := False;
  Sleep(30);
  pnlMultiPlayer.Width := 250;
  pnlMultiPlayer.Height := 460;
  imgMultiPlayer.Width := 217;
  imgMultiPlayer.Height := 425;
  pnlMultiPlayer.Top := 128;
  pnlMultiPlayer.Left := 568;
  pnlMultiPlayer.Color := clBlack;
  pnlHeading.Left := 200;
  pnlHeading.Width := 1015;
  pnlHeading.Caption := 'Select Number of Players';
  (imgBackgroundGIF.Picture.Graphic as TGIFImage).Animate := True;
end;




procedure TfrmPokerLVM.lblCreateClick(Sender: TObject);
begin
 if edtRepeatPassword.Visible = False then
 begin
  btnLogin.Enabled := True;
  lblRepeatPassword.Visible := True;
  lblNew.Visible := False;
  btnLogin.Caption := 'Create account';
  lblLogin.Caption := 'Create account';
  lblCreate.Caption := 'Return to login';
  edtRepeatPassword.Visible := True;
  lblName.Visible := True;
  edtName.Visible := True;


  with edtRepeatPassword do
    begin
      Top := 168;
      Left := 120;
      Height := 21;
      Width := 121;
    end;

  with lblRepeatPassword do
    begin
      Left := 8;
      Height := 15;
      Width := 95;
      Top := 168;
      Caption := 'Repeat Password:';
      Font.Color := clWhite;
      Font.Name := 'Times New Roman';
      Font.Size := 10;
    end;

  with edtName do
    begin
      Top := 56;
      Left := 120;
      Height := 21;
      Width := 121;
    end;

  with lblName do
    begin
      Left := 8;
      Height := 15;
      Width := 95;
      Top := 56;
      Caption := 'Full Name';
      Font.Color := clWhite;
      Font.Name := 'Times New Roman';
      Font.Size := 10;
    end;

  edtName.SetFocus;
  lblUsername.Top := 93;
  edtUsername.Top := 93;
  edtPassword.Top := 130;
  lblPassword.Top := 130;
  btnLogin.Top := 195;

 end
 else
 begin
  lblNew.Visible := True;
  btnLogin.Caption := 'Login';
  lblLogin.Caption := '         Login';
  lblCreate.Caption := 'Create account';
  edtRepeatPassword.Visible := False;
  lblRepeatPassword.Visible := False;
  btnLogin.Top := 160;
  lblName.Visible := False;;
  edtName.Visible := False;
  edtUsername.Top := 64;
  lblUsername.Top := 64;
  edtPassword.Top := 112;
  lblPassword.Top := 112;
  edtUsername.SetFocus;
 end;


end;

procedure TfrmPokerLVM.lblHandsClick(Sender: TObject);
  var
  K : Integer;
begin
  lblCustomiseHeading.Caption := '   Hands';
  lblReady.Caption := ' Back';
  lblCard.Visible := False;
  cbbCard.Visible := False;
  imgCardSelect.Visible := False;
  lblMap.Visible := False;
  cbbMap.Visible := False;
  imgMap.Visible := False;
  lblRules.Visible := False;
  lblHands.Visible := False;
  sedMulti.Visible := False;
  lblMulti.Visible := False;
  lblBuy.Visible := False;
  sedBuyin.Visible := False;
  lblNames.Visible := False;
  edtPlayer2.Visible := False;
  edtPlayer3.Visible := False;
  edtPlayer4.Visible := False;



    with memView do
      begin
        Visible := True;
        Caption := '';
        Top := 50;
        Left := 15;
        Height := 300;
        Width := 620;
      end;

  LoadTextfile('Hands',11);

   for K := 1 to 11 do
      begin
        memView.Lines.Add(arrHands[K]);
      end;


end;

procedure TfrmPokerLVM.lblReadyClick(Sender: TObject);
begin
   if memView.Visible = False then
    begin
       //Validation of player names
      if Length(edtPlayer2.Text) > 10 then
     begin
      MessageDlg('Name cannot be greter than 10 characters, please re-enter',mtError,[mbOK],0);
      edtPlayer2.Clear;
      edtPlayer2.SetFocus;
      Exit;
     end
     else
     begin
      sPlayer2 := edtPlayer2.Text;
     end;

     if Length(edtPlayer3.Text) > 10 then
     begin
      MessageDlg('Name cannot be greter than 10 characters, please re-enter',mtError,[mbOK],0);
      edtPlayer3.Clear;
      edtPlayer3.SetFocus;
      Exit;
     end
     else
     begin
      sPlayer3 := edtPlayer3.Text;
     end;

     if Length(edtPlayer4.Text) > 10 then
     begin
      MessageDlg('Name cannot be greter than 10 characters, please re-enter',mtError,[mbOK],0);
      edtPlayer4.Clear;
      edtPlayer4.SetFocus;
      Exit;
     end
     else
     begin
      sPlayer4 := edtPlayer4.Text;
     end;

     if bMultiPlayer = True then
        iNumPlayers := sedMulti.Value
      else iNumPlayers := 1;

      rBuyin := sedBuyin.Value;
      tmrFlashReady.Enabled := False;

      Sleep(1000);
      frmPokerLVM.Hide;
      frmBaseGameLVM.Show;
    end
    else
      begin
        lblCustomiseHeading.Caption := 'Options';
        lblReady.Caption := 'Ready';
        lblCard.Visible := True;
        cbbCard.Visible := True;
        imgCardSelect.Visible := True;
        lblMap.Visible := True;
        cbbMap.Visible := True;
        imgMap.Visible := True;
        lblRules.Visible := True;
        lblHands.Visible := True;
        memView.Clear;
        memView.Visible := False;
        lblBuy.Visible := True;
        sedBuyin.Visible := True;

        if bMultiPlayer = True then
          begin
            sedMulti.Visible := True;
            lblMulti.Visible := True;
            lblNames.Visible := True;
            edtPlayer2.Visible := True;

              if sedMulti.Value = 2 then
                begin
                  edtPlayer3.Visible := False;
                  edtPlayer4.Visible := False;
                end;

              if sedMulti.Value = 3 then
                begin
                  edtPlayer3.Visible := True;
                  edtPlayer4.Visible := False;
                end;

              if sedMulti.Value = 4 then
                begin
                  edtPlayer3.Visible := True;
                  edtPlayer4.Visible := True;
                end;
          end;
      end;




end;

procedure TfrmPokerLVM.lblRulesClick(Sender: TObject);
  var
  K : Integer;
begin
  lblCustomiseHeading.Caption := '   Rules';
  lblReady.Caption := ' Back';
  lblCard.Visible := False;
  cbbCard.Visible := False;
  imgCardSelect.Visible := False;
  lblMap.Visible := False;
  cbbMap.Visible := False;
  imgMap.Visible := False;
  lblRules.Visible := False;
  lblHands.Visible := False;
  sedMulti.Visible := False;
  lblMulti.Visible := False;
  lblBuy.Visible := False;
  sedBuyin.Visible := False;
  lblNames.Visible := False;
  edtPlayer2.Visible := False;
  edtPlayer3.Visible := False;
  edtPlayer4.Visible := False;

    with memView do
      begin
        Visible := True;
        Caption := '';
        Top := 50;
        Left := 15;
        Height := 300;
        Width := 620;
      end;

   LoadTextfile('Rules',18);

   for K := 1 to 21 do
      begin
        memView.Lines.Add(arrRules[K]);
      end;



end;

procedure TfrmPokerLVM.LoadTextfile(sFile : string; iMax : Integer);
 var
  tFile : TextFile;
  iCounter : Integer;
begin
  AssignFile(tFile,sFile + '.txt');

     try
      Reset(tFile);
     except
      MessageDlg('Textfile does not exist!',mtError,[mbOK],0);
      Exit;
     end;

  iCounter := 0;
  while (not Eof(tFile)) and (iCounter <= iMax) do
    begin
      Inc(iCounter);

      if sFile = 'Rules' then
        Readln(tFile,arrRules[iCounter])
      else
        Readln(tFile,arrHands[iCounter]);
    end;

  CloseFile(tFile);

end;

procedure TfrmPokerLVM.sedMultiChange(Sender: TObject);
begin
  if sedMulti.Value = 2 then
    begin
      edtPlayer3.Visible := False;
      edtPlayer4.Visible := False;
    end;

  if sedMulti.Value = 3 then
    begin
      edtPlayer3.Visible := True;
      edtPlayer4.Visible := False;
    end;

  if sedMulti.Value = 4 then
    begin
      edtPlayer3.Visible := True;
      edtPlayer4.Visible := True;
    end;

end;

procedure TfrmPokerLVM.Start;
begin
   pnlLogin.Visible := True;
   edtUsername.SetFocus;
   lblStart.Free;
   lblStart := nil;
   pnlStart.Free;
   pnlStart := nil;
   tmrFlashStart.Free;
   tmrFlashStart := nil;
end;




procedure TfrmPokerLVM.tmrFlashStartTimer(Sender: TObject);
begin
    if lblStart.Font.Color = clRed
    then lblStart.Font.Color := clBlack
      else if lblStart.Font.Color = clBlack
            then lblStart.Font.Color := clRed;
end;

procedure TfrmPokerLVM.tmrFlashMultiTimer(Sender: TObject);
begin
  if pnlMultiPlayer.Color = clRed
    then pnlMultiPlayer.Color := clBlack
      else if pnlMultiPlayer.Color = clBlack
            then pnlMultiPlayer.Color := clRed;

end;

procedure TfrmPokerLVM.tmrFlashReadyTimer(Sender: TObject);
begin
  if lblReady.Font.Color = clTeal
    then lblReady.Font.Color := clPurple
      else if lblReady.Font.Color = clPurple
            then lblReady.Font.Color := clTeal;
end;

end.
