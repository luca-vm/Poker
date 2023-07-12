unit frmBaseGameLVM_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPokerLVM_u, StdCtrls, jpeg, ExtCtrls, pngimage, Buttons, Math,
  Spin;

type
  TfrmBaseGameLVM = class(TForm)
    imgTable: TImage;
    imgCardStack: TImage;
    pnlMenu: TPanel;
    lblPlayer2: TLabel;
    lblPlayer3: TLabel;
    lblPlayer4: TLabel;
    lblCurrentPlayer: TLabel;
    bmbClose: TBitBtn;
    lblMovesList: TLabel;
    lblOption1: TLabel;
    lblOption2: TLabel;
    lblOption3: TLabel;
    lblComCards: TLabel;
    imgCom1: TImage;
    imgCom2: TImage;
    imgCom3: TImage;
    imgCom4: TImage;
    imgCom5: TImage;
    lblPot: TLabel;
    lblPotAmmount: TLabel;
    lblShowCards: TLabel;
    pnlRaise: TPanel;
    lblRaise: TLabel;
    sedRaise: TSpinEdit;
    chkAllIn: TCheckBox;
    lblAllIn: TLabel;
    lblChangeMind: TLabel;
    lblGo: TLabel;
    tmrFlashGo: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure bmbCloseClick(Sender: TObject);
    procedure lblOption1MouseEnter(Sender: TObject);
    procedure lblOption2MouseEnter(Sender: TObject);
    procedure lblOption3MouseEnter(Sender: TObject);
    procedure lblOption1MouseLeave(Sender: TObject);
    procedure lblOption2MouseLeave(Sender: TObject);
    procedure lblOption3MouseLeave(Sender: TObject);
    procedure lblOption2Click(Sender: TObject);
    procedure lblShowCardsMouseEnter(Sender: TObject);
    procedure lblShowCardsMouseLeave(Sender: TObject);
    procedure lblOption1Click(Sender: TObject);
    procedure lblChangeMindClick(Sender: TObject);
    procedure lblGoClick(Sender: TObject);
    procedure tmrFlashGoTimer(Sender: TObject);
  private
//P: Player C: Card
   imgP1C1 : TImage;
   imgP1C2 : TImage;
   imgP2C1 : TImage;
   imgP2C2 : TImage;
   imgP3C1 : TImage;
   imgP3C2 : TImage;
   imgP4C1 : TImage;
   imgP4C2 : TImage;


   arrCards : array[1..52] of string;
   arrDealCards : array[1..13] of string;


   bSinglePlayer, bMultiPlayer, bHints : Boolean;
   sCardColour, sMap,sLoginUsername, sLoginPassword, sBigBlind, sSmallBlind,sPlayer1, sPlayer2, sPlayer3, sPlayer4, sCurrentPlayer : string;
   iNumPlayers, iNumPlayersTurn : Integer;
   rBuyin, rPot, rRaise, rP1Parkbucks, rP2Parkbucks, rP3Parkbucks, rP4Parkbucks : Real;

   //Cards
   sCommunityCard1, sCommunityCard2 , sCommunityCard3, sCommunityCard4 ,sCommunityCard5,
   sPlayer1Card1, sPlayer1Card2, sPlayer2Card1, sPlayer2Card2, sPlayer3Card1, sPlayer3Card2,
   sPlayer4Card1, sPlayer4Card2 : string;

   iCheck : Integer;

   procedure DealCards;
   procedure SelectBlinds;
//   procedure Showdown;

  public
  end;

var
  frmBaseGameLVM: TfrmBaseGameLVM;

implementation

{$R *.dfm}

procedure TfrmBaseGameLVM.bmbCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmBaseGameLVM.DealCards;
 var
  K, iRandom, J, iCards, iMoveP1C1, iMoveP1C2, iMoveP2C1,
  iMoveP2C2, iMoveP3C1, iMoveP3C2, iMoveP4C1, iMoveP4C2 : Integer;
begin
   if iNumPlayers = 2 then
        iCards := 9
    else if iNumPlayers = 3 then
              iCards := 11
          else
              iCards := 13;


  for J := 1 to 52 do
    begin
      arrCards[J] := 'Free';
    end;

    for K := 1 to iCards do
      begin
        iRandom := RandomRange(1,53);

        if arrCards[iRandom] = 'Free' then
        begin
          arrCards[iRandom] := 'Taken';
          arrDealCards[K] := IntToStr(iRandom);
        end
        else
        begin
          repeat
           iRandom := RandomRange(1,53);
          until (arrCards[iRandom] = 'Free');

           arrCards[iRandom] := 'Taken';
          arrDealCards[K] := IntToStr(iRandom);
        end;
      end;


   sCommunityCard1 := arrDealCards[1];
   sCommunityCard2 := arrDealCards[2];
   sCommunityCard3 := arrDealCards[3];
   sCommunityCard4 := arrDealCards[4];
   sCommunityCard5 := arrDealCards[5];

   sPlayer1Card1 := arrDealCards[6];
   sPlayer1Card2 := arrDealCards[7];

   if iNumPlayers = 2 then
   begin
     sPlayer2Card1 := arrDealCards[8];
     sPlayer2Card2 := arrDealCards[9];
   end
   else if iNumPlayers = 3 then
        begin
          sPlayer2Card1 := arrDealCards[8];
          sPlayer2Card2 := arrDealCards[9];
          sPlayer3Card1 := arrDealCards[10];
          sPlayer3Card2 := arrDealCards[11];
        end
        else if (iNumPlayers = 4) or (iNumPlayers = 1) then
             begin
               sPlayer2Card1 := arrDealCards[8];
               sPlayer2Card2 := arrDealCards[9];
               sPlayer3Card1 := arrDealCards[10];
               sPlayer3Card2 := arrDealCards[11];
               sPlayer4Card1 := arrDealCards[12];
               sPlayer4Card2 := arrDealCards[13];
             end;
   //Dynamically create and move cards

   imgP1C1 := TImage.Create(frmBaseGameLVM);
    with imgP1C1 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP1C1';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;

    imgP1C2 := TImage.Create(frmBaseGameLVM);
    with imgP1C2 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP1C2';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;

   if iNumPlayers = 2 then
   begin
     imgP2C1 := TImage.Create(frmBaseGameLVM);
    with imgP2C1 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP2C1';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;

    imgP2C2 := TImage.Create(frmBaseGameLVM);
    with imgP2C2 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP2C2';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;

   end
   else
   if iNumPlayers = 3 then
   begin
    imgP2C1 := TImage.Create(frmBaseGameLVM);
    with imgP2C1 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP2C1';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;

    imgP2C2 := TImage.Create(frmBaseGameLVM);
    with imgP2C2 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP2C2';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;

    imgP3C1 := TImage.Create(frmBaseGameLVM);
    with imgP3C1 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP3C1';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;

    imgP3C2 := TImage.Create(frmBaseGameLVM);
    with imgP3C2 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP3C2';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;
    end
    else
   if (iNumPlayers = 4) or (iNumPlayers = 1) then
   begin
    imgP2C1 := TImage.Create(frmBaseGameLVM);
    with imgP2C1 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP2C1';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;

    imgP2C2 := TImage.Create(frmBaseGameLVM);
    with imgP2C2 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP2C2';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;

    imgP3C1 := TImage.Create(frmBaseGameLVM);
    with imgP3C1 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP3C1';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;

    imgP3C2 := TImage.Create(frmBaseGameLVM);
    with imgP3C2 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP3C2';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;

    imgP4C1 := TImage.Create(frmBaseGameLVM);
    with imgP4C1 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP4C1';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;

    imgP4C2 := TImage.Create(frmBaseGameLVM);
    with imgP4C2 do
    begin
      Parent := frmBaseGameLVM;
      Name := 'imgP4C2';
      Height := 151;
      Left := 1152;
      Top := 237;
      Width := 99;
      Stretch := True;
     Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
    end;
    end;


    //P1C1
   for iMoveP1C1 :=  1 to 35 do
    begin
      imgP1C1.Left  := imgP1C1.Left - 18;
      imgP1C1.Top :=  imgP1C1.Top + 7;

      imgP1C1.Height  := imgP1C1.Height + 3;
      imgP1C1.Width :=  imgP1C1.Width + 3;

       Sleep(5);
       Refresh;
    End;

    with imgP1C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

   //P1C2
   for iMoveP1C2 :=  1 to 30 do
    begin
      imgP1C2.Left  := imgP1C2.Left - 18;
      imgP1C2.Top :=  imgP1C2.Top + 7;

      imgP1C2.Height  := imgP1C2.Height + 3;
      imgP1C2.Width :=  imgP1C2.Width + 3;

       Sleep(5);
       Refresh;
    End;

    with imgP1C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

  if (iNumPlayers = 1) or (iNumPlayers = 4) then
 begin
    //P2C1
   for iMoveP2C1 :=  1 to 20 do
    begin
      imgP2C1.Left  := imgP2C1.Left - 55;
      imgP2C1.Top :=  imgP2C1.Top - 1;

      imgP2C1.Height  := imgP2C1.Height + 1;
      imgP2C1.Width :=  imgP2C1.Width + 1;

       Sleep(5);
       Refresh;
    End;

    with imgP2C1 do
      begin
        Height := 151;
        Left := 86;
        Top := 347;
        Width := 99;
      end;

    //P2C2
   for iMoveP2C2 :=  1 to 20 do
    begin
      imgP2C2.Left  := imgP2C2.Left - 50;
      imgP2C2.Top :=  imgP2C2.Top - 1;

      imgP2C2.Height  := imgP2C2.Height + 1;
      imgP2C2.Width :=  imgP2C2.Width + 1;

       Sleep(5);
       Refresh;
    End;

    with imgP2C2 do
      begin
        Height := 151;
        Left := 191;
        Top := 347;
        Width := 99;
      end;

    //P3C1
   for iMoveP3C1 :=  1 to 20 do
    begin
      imgP3C1.Left  := imgP3C1.Left - 43;
      imgP3C1.Top :=  imgP3C1.Top - 3;

      imgP3C1.Height  := imgP3C1.Height + 1;
      imgP3C1.Width :=  imgP3C1.Width + 1;

       Sleep(5);
       Refresh;
    End;

    with imgP3C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

   //P3C2
   for iMoveP3C2 :=  1 to 20 do
    begin
      imgP3C2.Left  := imgP3C2.Left - 38;
      imgP3C2.Top :=  imgP3C2.Top - 3;

      imgP3C2.Height  := imgP3C2.Height + 1;
      imgP3C2.Width :=  imgP3C2.Width + 1;

       Sleep(5);
       Refresh;
    End;

    with imgP3C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

   //P4C1
   for iMoveP4C1 :=  1 to 20 do
    begin
      imgP4C1.Left  := imgP4C1.Left - 27;
      imgP4C1.Top :=  imgP4C1.Top - 6;

      imgP4C1.Height  := imgP4C1.Height + 1;
      imgP4C1.Width :=  imgP4C1.Width + 1;

       Sleep(5);
       Refresh;
    End;

     with imgP4C1 do
      begin
        Height := 151;
        Left := 584;
        Top := 50;
        Width := 99;
      end;

    //P4C2
   for iMoveP4C2 :=  1 to 20 do
    begin
      imgP4C2.Left  := imgP4C2.Left - 24;
      imgP4C2.Top :=  imgP4C2.Top - 6;

      imgP4C2.Height  := imgP4C2.Height + 1;
      imgP4C2.Width :=  imgP4C2.Width + 1;

       Sleep(5);
       Refresh;
    End;

     with imgP4C2 do
      begin
        Height := 151;
        Left := 689;
        Top := 50;
        Width := 99;
      end;
 end
 else
 if iNumPlayers = 2 then
 begin
   //P2C1
   for iMoveP2C1 :=  1 to 20 do
    begin
      imgP2C1.Left  := imgP2C1.Left - 43;
      imgP2C1.Top :=  imgP2C1.Top - 3;

      imgP2C1.Height  := imgP2C1.Height + 1;
      imgP2C1.Width :=  imgP2C1.Width + 1;

       Sleep(5);
       Refresh;
    End;

    with imgP2C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

   //P2C2
   for iMoveP2C2 :=  1 to 20 do
    begin
      imgP2C2.Left  := imgP2C2.Left - 38;
      imgP2C2.Top :=  imgP2C2.Top - 3;

      imgP2C2.Height  := imgP2C2.Height + 1;
      imgP2C2.Width :=  imgP2C2.Width + 1;

       Sleep(5);
       Refresh;
    End;

     with imgP2C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;
 end
 else if iNumPlayers = 3 then
 begin
   //P2C1
   for iMoveP2C1 :=  1 to 20 do
    begin
      imgP2C1.Left  := imgP2C1.Left - 43;
      imgP2C1.Top :=  imgP2C1.Top - 3;

      imgP2C1.Height  := imgP2C1.Height + 1;
      imgP2C1.Width :=  imgP2C1.Width + 1;

       Sleep(5);
       Refresh;
    End;

    with imgP2C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

   //P2C2
   for iMoveP2C2 :=  1 to 20 do
    begin
      imgP2C2.Left  := imgP2C2.Left - 38;
      imgP2C2.Top :=  imgP2C2.Top - 3;

      imgP2C2.Height  := imgP2C2.Height + 1;
      imgP2C2.Width :=  imgP2C2.Width + 1;

       Sleep(5);
       Refresh;
    End;

     with imgP2C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

    //P3C1
   for iMoveP3C1 :=  1 to 20 do
    begin
      imgP3C1.Left  := imgP3C1.Left - 27;
      imgP3C1.Top :=  imgP3C1.Top - 6;

      imgP3C1.Height  := imgP3C1.Height + 1;
      imgP3C1.Width :=  imgP3C1.Width + 1;

       Sleep(5);
       Refresh;
    End;

     with imgP3C1 do
      begin
        Height := 151;
        Left := 584;
        Top := 50;
        Width := 99;
      end;

    //P3C2
   for iMoveP3C2 :=  1 to 20 do
    begin
      imgP3C2.Left  := imgP3C2.Left - 24;
      imgP3C2.Top :=  imgP3C2.Top - 6;

      imgP3C2.Height  := imgP3C2.Height + 1;
      imgP3C2.Width :=  imgP3C2.Width + 1;

       Sleep(5);
       Refresh;
    End;

     with imgP3C2 do
      begin
        Height := 151;
        Left := 689;
        Top := 50;
        Width := 99;
      end;
 end;
end;

procedure TfrmBaseGameLVM.FormActivate(Sender: TObject);
begin
     iCheck := 0;

     //Convert other forms vaiables into variables for ths form for easier use
     iNumPlayers := frmPokerLVM.iNumPlayers;
     bSinglePlayer := frmPokerLVM.bSinglePlayer;
     bMultiPlayer := frmPokerLVM.bMultiPlayer;
     bHints := frmPokerLVM.bHints;
     sCardColour := frmPokerLVM.sCardColour;
     sMap := frmPokerLVM.sMap;
     sLoginUsername := frmPokerLVM.sLoginUsername;

     sPlayer1 := sLoginUsername;
     sCurrentPlayer := sPlayer1;


 if iNumPlayers <> 1 then
  begin
     sPlayer2 := frmPokerLVM.sPlayer2;
     sPlayer3 := frmPokerLVM.sPlayer3;
     sPlayer4 := frmPokerLVM.sPlayer4;
  end
  else
  begin
     sPlayer2 := 'Computer2';
     sPlayer3 := 'Computer3';
     sPlayer4 := 'Computer4';
  end;
     iNumPlayers := frmPokerLVM.iNumPlayers;
     rBuyin := frmPokerLVM.rBuyin;

     rP1Parkbucks := rBuyin;
     rP2Parkbucks := rBuyin;
     rP3Parkbucks := rBuyin;
     rP4Parkbucks := rBuyin;


  imgCardStack.Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
  imgCom1.Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
  imgCom2.Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
  imgCom3.Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
  imgCom4.Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
  imgCom5.Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');

   if sMap = '1'
     then
      imgTable.Picture.LoadFromFile('TableTops\TableTop' +  sMap + '.png')
      else
      imgTable.Picture.LoadFromFile('TableTops\TableTop' +  sMap + '.jpg');

   if iNumPlayers <> 1 then
   begin
    lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rBuyin,ffFixed,6,2);
    lblPlayer3.Caption := sPlayer3 + ': P' + FloatToStrF(rBuyin,ffFixed,6,2);
    lblPlayer4.Caption := sPlayer4 + ': P' + FloatToStrF(rBuyin,ffFixed,6,2);
    lblCurrentPlayer.Caption := sLoginUsername + ': P' + FloatToStrF(rBuyin,ffFixed,6,2);
   end
   else
   begin
    lblPlayer2.Caption := 'Computer1: P' + FloatToStrF(rBuyin,ffFixed,6,2);
    lblPlayer3.Caption := 'Computer2: P' + FloatToStrF(rBuyin,ffFixed,6,2);
    lblPlayer4.Caption := 'Computer3: P' + FloatToStrF(rBuyin,ffFixed,6,2);
    lblCurrentPlayer.Caption := sLoginUsername + ': P' + FloatToStrF(rBuyin,ffFixed,6,2);
   end;

   if iNumPlayers = 3 then
    begin
      lblCurrentPlayer.Top := 651;
      lblPlayer4.Visible := False;
    end;

   if iNumPlayers = 2 then
    begin
       lblPlayer4.Visible := False;
       lblPlayer3.Visible := False;
       lblCurrentPlayer.Top := 672;
    end;

  lblOption1.Visible := False;
  lblOption3.Visible := False;
  lblOption2.Visible := True;
  lblOption2.Caption := '- Select Blinds';

  MessageDlg('Play by selecting from a number of options found in the bottom rigth corner. Good Luck!',mtInformation,[mbOK],0);

end;

procedure TfrmBaseGameLVM.lblChangeMindClick(Sender: TObject);
begin
  lblOption1.Visible := True;
  lblOption2.Visible := True;
  lblOption3.Visible := True;
  pnlRaise.Visible := False;
  tmrFlashGo.Enabled := False;
end;

procedure TfrmBaseGameLVM.lblGoClick(Sender: TObject);
begin


  lblOption1.Visible := True;
  lblOption2.Visible := True;
  lblOption3.Visible := True;
  pnlRaise.Visible := False;
  tmrFlashGo.Enabled := False;


  if sCurrentPlayer = sPlayer1 then
  begin
    if rRaise < rP1Parkbucks  then
     begin
      rRaise := sedRaise.Value;
      rP1Parkbucks := rP1Parkbucks - rRaise;
      rPot := rPot + rRaise;
      lblCurrentPlayer.Caption := sPlayer1 + ': ' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
      lblPot.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
     end
     else
     begin
      MessageDlg('You do not have the Parkbucks required to make this raise, please re-enter',mtError,[mbOK],0);
      sedRaise.Clear;
      sedRaise.SetFocus;
      Exit;
     end;
  end
  else
  if sCurrentPlayer = sPlayer2 then
  begin
    if rRaise < rP2Parkbucks  then
     begin
      rRaise := sedRaise.Value;
      rP2Parkbucks := rP2Parkbucks - rRaise;
      rPot := rPot + rRaise;
      lblCurrentPlayer.Caption := sPlayer2 + ': ' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
      lblPot.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
     end
     else
     begin
      MessageDlg('You do not have the Parkbucks required to make this raise, please re-enter',mtError,[mbOK],0);
      sedRaise.Clear;
      sedRaise.SetFocus;
      Exit;
     end;
  end
  else
  if sCurrentPlayer = sPlayer3 then
  begin
    if rRaise < rP3Parkbucks  then
     begin
      rRaise := sedRaise.Value;
      rP3Parkbucks := rP3Parkbucks - rRaise;
      rPot := rPot + rRaise;
      lblCurrentPlayer.Caption := sPlayer3 + ': ' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
      lblPot.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
     end
     else
     begin
      MessageDlg('You do not have the Parkbucks required to make this raise, please re-enter',mtError,[mbOK],0);
      sedRaise.Clear;
      sedRaise.SetFocus;
      Exit;
     end;
  end
  else
  if sCurrentPlayer = sPlayer4 then
  begin
    if rRaise < rP4Parkbucks  then
     begin
      rRaise := sedRaise.Value;
      rP4Parkbucks := rP4Parkbucks - rRaise;
      rPot := rPot + rRaise;
      lblCurrentPlayer.Caption := sPlayer4 + ': ' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
      lblPot.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
     end
     else
     begin
      MessageDlg('You do not have the Parkbucks required to make this raise, please re-enter',mtError,[mbOK],0);
      sedRaise.Clear;
      sedRaise.SetFocus;
      Exit;
     end;
  end;
 end;


procedure TfrmBaseGameLVM.lblOption1Click(Sender: TObject);
begin
  if lblOption1.Caption = '- Check' then
    begin
      Inc(iCheck);
    end;

 { if iCheck = iNumPlayers - 1 then
   begin
     Showdown;
   end; }
end;

procedure TfrmBaseGameLVM.lblOption1MouseEnter(Sender: TObject);
begin
  with lblOption1 do
    begin
      Font.Color := clFuchsia;
      Font.Size := 30;
    end;
end;

procedure TfrmBaseGameLVM.lblOption1MouseLeave(Sender: TObject);
begin
  with lblOption1 do
    begin
      Font.Color := clYellow;
      Font.Size := 24;
    end;
end;

procedure TfrmBaseGameLVM.lblOption2Click(Sender: TObject);
 var
  k : Integer;
begin
  if lblOption2.Caption = '- Select Blinds' then
    begin
      SelectBlinds;
      lblOption2.Caption := '- Deal cards';
    end
    else
    if lblOption2.Caption = '- Deal cards' then
    begin
       DealCards;
       Sleep(1500);
       lblOption1.Visible := True;
       lblOption3.Visible := True;
       lblShowCards.Visible := True;
       lblOption1.Caption := '- Check';
       lblOption2.Caption := '- Raise';
       lblOption3.Caption := '- Fold';
    end
    else
    if lblOption2.Caption = '- Raise' then
      begin
        lblOption1.Visible := False;
        lblOption2.Visible := False;
        lblOption3.Visible := False;

        tmrFlashGo.Enabled := True;

        with pnlRaise do
          begin
            Height := 178;
            Left := 1152;
            Top := 496;
            Width := 170;
            Visible := True;
          end;

        sedRaise.Height := 63;
        sedRaise.Width := 89;

        lblOption1.Caption := ('- Call(P' + FloatToStrF(rRaise,ffFixed,6,2) + ')' );
      end;

end;

procedure TfrmBaseGameLVM.lblOption2MouseEnter(Sender: TObject);
begin
   with lblOption2 do
    begin
      Font.Color := clFuchsia;
      Font.Size := 30;
    end;
end;

procedure TfrmBaseGameLVM.lblOption2MouseLeave(Sender: TObject);
begin
   with lblOption2 do
    begin
      Font.Color := clYellow;
      Font.Size := 24;
    end;
end;

procedure TfrmBaseGameLVM.lblOption3MouseEnter(Sender: TObject);
begin
   with lblOption3 do
    begin
      Font.Color := clFuchsia;
      Font.Size := 30;
    end;
end;

procedure TfrmBaseGameLVM.lblOption3MouseLeave(Sender: TObject);
begin
   with lblOption3 do
    begin
      Font.Color := clYellow;
      Font.Size := 24;
    end;
end;

procedure TfrmBaseGameLVM.lblShowCardsMouseEnter(Sender: TObject);
begin
  lblShowCards.Width := lblShowCards.Width + 10;
  lblShowCards.Height := lblShowCards.Width + 10;
  lblShowCards.Font.Size :=  24;
  lblShowCards.Font.Color := clAqua;

  imgP1C1.Picture.LoadFromFile('Cards\' + sPlayer1Card1 + '.png');
  imgP1C2.Picture.LoadFromFile('Cards\' + sPlayer1Card2 + '.png');
end;

procedure TfrmBaseGameLVM.lblShowCardsMouseLeave(Sender: TObject);
begin
  lblShowCards.Width := lblShowCards.Width - 10;
  lblShowCards.Height := lblShowCards.Width - 10;
  lblShowCards.Font.Size := 22;
  lblShowCards.Font.Color := clAqua;

  imgP1C1.Picture.LoadFromFile('Cards\' + sCardColour + '_back.png');
  imgP1C2.Picture.LoadFromFile('Cards\' + sCardColour + '_back.png');
end;

procedure TfrmBaseGameLVM.SelectBlinds;
  var
  iRandom : Integer;
  rDonated1, rDonated2 : Real;
begin

  if (iNumPlayers = 1) or (iNumPlayers = 4) then
      begin
        iRandom := RandomRange(1,5);

        case iRandom of
          1: begin
               sBigBlind := sLoginUsername;
               sSmallBlind := sPlayer2;
               rDonated1 := (10/100 * rP1Parkbucks);
               rDonated2 := (5/100 * rP2Parkbucks);
               rP1Parkbucks := rP1Parkbucks - (10/100 * rP1Parkbucks);
               rP2Parkbucks := rP2Parkbucks - (5/100 * rP2Parkbucks);
               lblCurrentPlayer.Caption := sLoginUsername + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
               lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
               rPot :=  rDonated1 + rDonated2;
             end;
          2: begin
               sBigBlind := sPlayer2;
               sSmallBlind := sPlayer3;
               rDonated1 := (10/100 * rP2Parkbucks);
               rDonated2 := (5/100 * rP3Parkbucks);
               rP2Parkbucks := rP2Parkbucks - (10/100 * rP2Parkbucks);
               rP3Parkbucks := rP3Parkbucks - (5/100 * rP3Parkbucks);
               lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
               lblPlayer3.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
              rPot :=  rDonated1 + rDonated2;
             end;
          3: begin
               sBigBlind := sPlayer3;
               sSmallBlind := sPlayer4;
               rDonated1 := (10/100 * rP3Parkbucks);
               rDonated2 := (5/100 * rP4Parkbucks);
               rP3Parkbucks := rP3Parkbucks - (10/100 * rP3Parkbucks);
               rP4Parkbucks := rP4Parkbucks - (5/100 * rP4Parkbucks);
               lblPlayer3.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
               lblPlayer4.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
               rPot :=  rDonated1 + rDonated2;
             end;
          4: begin
               sBigBlind := sPlayer4;
               sSmallBlind := sLoginUsername;
               rDonated1 := (10/100 * rP4Parkbucks);
               rDonated2 := (5/100 * rP1Parkbucks);
               rP4Parkbucks := rP4Parkbucks - (10/100 * rP4Parkbucks);
               rP1Parkbucks := rP1Parkbucks - (5/100 * rP1Parkbucks);
               lblPlayer4.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
               lblCurrentPlayer.Caption := sLoginUsername + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
               rPot :=  rDonated1 + rDonated2;
             end;
        end;
      end
      else
  if iNumPlayers = 2 then
  begin
    iRandom := RandomRange(1,3);

    case iRandom of
        1: begin
               sBigBlind := sLoginUsername;
               sSmallBlind := sPlayer2;
               rDonated1 := (10/100 * rP1Parkbucks);
               rDonated2 := (5/100 * rP2Parkbucks);
               rP1Parkbucks := rP1Parkbucks - (10/100 * rP1Parkbucks);
               rP2Parkbucks := rP2Parkbucks - (5/100 * rP2Parkbucks);
               lblCurrentPlayer.Caption := sLoginUsername + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
               lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
               rPot :=  rDonated1 + rDonated2;
             end;
        2: begin
               sBigBlind := sPlayer2;
               sSmallBlind := sLoginUsername;
               rDonated1 := (10/100 * rP2Parkbucks);
               rDonated2 := (5/100 * rP1Parkbucks);
               rP2Parkbucks := rP2Parkbucks - (10/100 * rP2Parkbucks);
               rP1Parkbucks := rP1Parkbucks - (5/100 * rP1Parkbucks);
               lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
               lblCurrentPlayer.Caption := sLoginUsername + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
              rPot :=  rDonated1 + rDonated2;
             end;
        end;
  end
  else
  if iNumPlayers = 3 then
  begin
     iRandom := RandomRange(1,4);

   case iRandom of
          1: begin
               sBigBlind := sLoginUsername;
               sSmallBlind := sPlayer2;
               rDonated1 := (10/100 * rP1Parkbucks);
               rDonated2 := (5/100 * rP2Parkbucks);
               rP1Parkbucks := rP1Parkbucks - (10/100 * rP1Parkbucks);
               rP2Parkbucks := rP2Parkbucks - (5/100 * rP2Parkbucks);
               lblCurrentPlayer.Caption := sLoginUsername + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
               lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
               rPot :=  rDonated1 + rDonated2;
             end;
          2: begin
               sBigBlind := sPlayer2;
               sSmallBlind := sPlayer3;
               rDonated1 := (10/100 * rP2Parkbucks);
               rDonated2 := (5/100 * rP3Parkbucks);
               rP2Parkbucks := rP2Parkbucks - (10/100 * rP2Parkbucks);
               rP3Parkbucks := rP3Parkbucks - (5/100 * rP3Parkbucks);
               lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
               lblPlayer3.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
               rPot :=  rDonated1 + rDonated2;
             end;
          3: begin
               sBigBlind := sPlayer3;
               sSmallBlind := sLoginUsername;
               rDonated1 := (10/100 * rP3Parkbucks);
               rDonated2 := (5/100 * rP1Parkbucks);
               rP3Parkbucks := rP3Parkbucks - (10/100 * rP3Parkbucks);
               rP1Parkbucks := rP1Parkbucks - (5/100 * rP1Parkbucks);
               lblPlayer3.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
               lblCurrentPlayer.Caption := sLoginUsername + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
               rPot :=  rDonated1 + rDonated2;
             end;
   end;
  end;

   MessageDlg('Blinds selected!' + #13 + 'Big Blind: ' + sBigBlind + #13 + 'Small Blind: ' + sSmallBlind,mtInformation,[mbOK],0);
   lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
end;

procedure TfrmBaseGameLVM.tmrFlashGoTimer(Sender: TObject);
begin
 if lblGo.Font.Color = clTeal
    then lblGo.Font.Color := clFuchsia
      else if lblGo.Font.Color = clFuchsia
            then lblGo.Font.Color := clTeal;

end;


end.
