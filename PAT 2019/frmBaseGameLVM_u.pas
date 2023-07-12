unit frmBaseGameLVM_u;  //Coded and designed by Luca von Mayer 11F 2019 Parktown Boys' High School

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPokerLVM_u, StdCtrls, jpeg, ExtCtrls, pngimage, Buttons, Math, Spin,
  dmLoginStats_u, Grids, DBGrids, DB, frmAccountsAndStats_u;

type
  TfrmBaseGameLVM = class(TForm)
    imgTable: TImage;
    imgCardStack: TImage;
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
    pnlEndRound: TPanel;
    lblRoundEnd: TLabel;
    lblNextRound: TLabel;
    lblEndGame: TLabel;
    lblStats: TLabel;
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
    procedure lblOption3Click(Sender: TObject);
    procedure lblEndGameMouseEnter(Sender: TObject);
    procedure lblNextRoundMouseEnter(Sender: TObject);
    procedure lblStatsMouseEnter(Sender: TObject);
    procedure lblNextRoundMouseLeave(Sender: TObject);
    procedure lblEndGameMouseLeave(Sender: TObject);
    procedure lblStatsMouseLeave(Sender: TObject);
    procedure lblNextRoundClick(Sender: TObject);
    procedure lblEndGameClick(Sender: TObject);
    procedure lblStatsClick(Sender: TObject);

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


   bSinglePlayer,bP1Raiser, bP2Raiser, bP3Raiser, bP4Raiser, bMultiPlayer, bFoldP1, bFoldP2, bFoldP3, bFoldP4, bCall, bFlop1, bFlop2, bFlop3, bTurn, bRiver : Boolean;
   sCardColour, sMap,sLoginUsername, sLoginPassword, sBigBlind, sSmallBlind,sPlayer1, sPlayer2, sPlayer3, sPlayer4, sCurrentPlayer : string;
   iNumPlayers, iNumPlayersTurn, iNumFold, iRound, iCheck, iCall,  iCount   : Integer;
   rBuyin, rPot, rRaise, rP1Parkbucks, rP2Parkbucks, rP3Parkbucks, rP4Parkbucks : Real;

   //Cards
   sCommunityCard1, sCommunityCard2 , sCommunityCard3, sCommunityCard4 ,sCommunityCard5,
   sPlayer1Card1, sPlayer1Card2, sPlayer2Card1, sPlayer2Card2, sPlayer3Card1, sPlayer3Card2,
   sPlayer4Card1, sPlayer4Card2 : string;

   //Card Info
   sP1C1Suit,sP1C2Suit,sP2C1Suit,sP2C2Suit,sP3C1Suit,sP3C2Suit,sP4C1Suit,sP4C2Suit,
   sCC1Suit,sCC2Suit,sCC3Suit,sCC4Suit,sCC5Suit,

   sP1C1Num, sP1C2Num, sP2C1Num, sP2C2Num, sP3C1Num, sP3C2Num, sP4C1Num,sP4C2Num,
   sCC1Num,sCC2Num,sCC3Num,sCC4Num,sCC5Num : string;

   //Hand Ranks
   rP1HandRank, rP2HandRank, rP3HandRank, rP4HandRank, rTwoPairValue, r3OAKValue, rP1C1Value, rP1C2Value, rP2C1Value, rP2C2Value, rP3C1Value, rP3C2Value, rP4C1Value, rP4C2Value  : Real;

   //Card counters
   i2s, i3s, i4s, i5s, i6s, i7s, i8s, i9s, i10s, iJs, iQs, iKs, iAs : Integer;
   iHearts, iClubs, iSpades, iDiamonds : Integer;

   iNumPairs: Integer;
   b3OAK : Boolean;

   sWinner : string;

   procedure DealCards;
   procedure SelectBlinds;
   procedure NextTurnMove;
   procedure CheckFold;
   procedure WinByFold;
   procedure WinByShowdown;
   procedure RoundEnd;
   procedure ChangeLayout;
   procedure NextTurnMoveFolded;
   procedure Flop;
   procedure Turn;
   procedure River;
   procedure Showdown;
   procedure GetCardInfo(sCardNum : string);
   procedure DetermineHand(sPlayer : string);
   procedure Kickers;
   procedure Option1;
   procedure Option2;
   procedure Option3;

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

procedure TfrmBaseGameLVM.ChangeLayout;
begin
  Sleep(2000);

  //Deleting folded cards
  if bFoldP1 then
  begin
    imgP1C1.Free;
    imgP1C1 := nil;

    imgP1C2.Free;
    imgP1C2 := nil;
  end;

  if bFoldP2 then
  begin
    imgP2C1.Free;
    imgP2C1 := nil;

    imgP2C2.Free;
    imgP2C2 := nil;
  end;

  if bFoldP3 then
  begin
    imgP3C1.Free;
    imgP3C1 := nil;

    imgP3C2.Free;
    imgP3C2 := nil;
  end;

  if bFoldP4 then
  begin
    imgP4C1.Free;
    imgP4C1 := nil;

    imgP4C2.Free;
    imgP4C2 := nil;
  end;

  //Moving remaining cards to new position
  if (not bFoldP1) and (not bFoldP2) then
    begin

        sCurrentPlayer := sPlayer1;

      //P1 in Pos 1
        with imgP1C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP1C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      //P2 in Pos 3
      with imgP2C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

     with imgP2C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);

      lblPlayer3.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
      lblPlayer4.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);

    end
    else
  if (not bFoldP1) and  (not bFoldP3) then
    begin
      if sCurrentPlayer = sPlayer4 then
        sCurrentPlayer := sPlayer1
      else if sCurrentPlayer = sPlayer2 then
           sCurrentPlayer := sPlayer3;

      if sCurrentPlayer = sPlayer1 then
     begin
      //P1 in Pos 1
        with imgP1C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP1C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      //P3 in Pos 3
      with imgP3C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

     with imgP3C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      lblPlayer2.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);

      lblPlayer3.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
      lblPlayer4.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
     end
     else
     if sCurrentPlayer = sPlayer3 then
     begin
      //P1 in Pos 1
        with imgP3C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP3C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      //P3 in Pos 3
      with imgP1C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

     with imgP1C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      lblPlayer2.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);

      lblPlayer3.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
      lblPlayer4.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
     end;
    end
    else
  if (not bFoldP1) and  (not bFoldP4) then
    begin
       sCurrentPlayer := sPlayer4;

      //P1 in Pos 1
        with imgP4C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP4C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      //P4 in Pos 3
      with imgP1C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

     with imgP1C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      lblPlayer2.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);

      lblPlayer3.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
      lblPlayer4.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
    end
    else
  if (not bFoldP2) and  (not bFoldP3) then
    begin
       sCurrentPlayer := sPlayer2;

      //P2 in Pos 1
        with imgP2C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP2C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      //P3 in Pos 3
      with imgP3C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

     with imgP3C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      lblPlayer2.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);

      lblPlayer3.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
      lblPlayer4.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
    end
    else
  if (not bFoldP2) and  (not bFoldP4) then
    begin
        if sCurrentPlayer = sPlayer3 then
       sCurrentPlayer := sPlayer4
      else if sCurrentPlayer = sPlayer1 then
           sCurrentPlayer := sPlayer2;

     if sCurrentPlayer = sPlayer2 then
     begin
      //P2 in Pos 1
        with imgP2C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP2C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      //P4 in Pos 3
      with imgP4C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

     with imgP4C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      lblPlayer2.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);

      lblPlayer3.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
      lblPlayer4.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
     end
     else
     if sCurrentPlayer = sPlayer4 then
     begin
      //P4 in Pos 1
        with imgP4C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP4C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      //P2 in Pos 3
      with imgP2C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

     with imgP2C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);

      lblPlayer3.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
      lblPlayer4.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
     end;

    end
    else
    if (not bFoldP3) and  (not bFoldP4) then
    begin
     sCurrentPlayer := sPlayer3;

      //P3 in Pos 1
        with imgP3C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP3C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      //P4 in Pos 3
      with imgP4C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

     with imgP4C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      lblPlayer2.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);

      lblPlayer3.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
      lblPlayer4.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
    end;



end;

procedure TfrmBaseGameLVM.CheckFold;
  var
  sCurrent : string;
begin
   sCurrent := sCurrentPlayer;

   // Check if next player has folded so thier turn can be skipped
 if (iNumPlayers = 4) or (iNumPlayers = 1) then
 begin
  if sCurrent = sPlayer1 then
    begin

      if bFoldP2 then
          NextTurnMove;
    end
    else
  if sCurrent = sPlayer2 then
    begin

      if bFoldP3 then
        NextTurnMove;
    end
    else
  if sCurrent = sPlayer3 then
    begin

      if bFoldP4 then
        NextTurnMove;
    end
    else
  if sCurrent = sPlayer4 then
    begin

      if bFoldP1 then
        NextTurnMove;

    end;
 end
 else if iNumPlayers = 3 then
 begin
  if sCurrent = sPlayer1 then
    begin
      if bFoldP2 then
        NextTurnMove;
    end
    else
  if sCurrent = sPlayer2 then
    begin
      if bFoldP3 then
        NextTurnMove;
    end
    else
  if sCurrent = sPlayer3 then
    begin
      if bFoldP1 then
        NextTurnMove;
    end;
 end;
 
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


procedure TfrmBaseGameLVM.DetermineHand(sPlayer: string);
begin
   i2s := 0;
   i3s := 0;
   i4s := 0;
   i5s := 0;
   i6s := 0;
   i7s := 0;
   i8s := 0;
   i9s := 0;
   i10s := 0;
   iJs := 0;
   iQs := 0;
   iKs := 0;
   iAs := 0;
   iHearts := 0;
   iClubs  := 0;
   iSpades := 0;
   iDiamonds := 0;
   iNumPairs := 0;
   rTwoPairValue := 0;
   rP1C1Value := 0;
   rP1C2Value := 0;
   rP2C1Value := 0;
   rP2C2Value := 0;
   b3OAK := False;
   r3OAKValue := 0;



  if sPlayer = 'Player1' then
  begin
     // Counts amount of 2 cards
     if sP1C1Num = '2' then
      Inc(i2s);
     if sP1C2Num = '2' then
      Inc(i2s);
     if (sCC1Num = '2') then
      Inc(i2s);
       if (sCC2Num = '2') then
      Inc(i2s);
      if (sCC3Num = '2') then
      Inc(i2s);
      if (sCC4Num = '2') then
      Inc(i2s);
      if (sCC5Num = '2') then
      Inc(i2s);


    //Counts amount of 3 cards
    if sP1C1Num = '3' then
      Inc(i3s);
     if sP1C2Num = '3' then
      Inc(i3s);
     if (sCC1Num = '3') then
      Inc(i3s);
       if (sCC2Num = '3') then
      Inc(i3s);
      if (sCC3Num = '3') then
      Inc(i3s);
      if (sCC4Num = '3') then
      Inc(i3s);
      if (sCC5Num = '3') then
      Inc(i3s);

    //Counts amount of 4 cards
    if sP1C1Num = '4' then
      Inc(i4s);
     if sP1C2Num = '4' then
      Inc(i4s);
     if (sCC1Num = '4') then
      Inc(i4s);
       if (sCC2Num = '4') then
      Inc(i4s);
      if (sCC3Num = '4') then
      Inc(i4s);
      if (sCC4Num = '4') then
      Inc(i4s);
      if (sCC5Num = '4') then
      Inc(i4s);

    //Counts amount of 5 cards
   if sP1C1Num = '5' then
      Inc(i5s);
     if sP1C2Num = '5' then
      Inc(i5s);
     if (sCC1Num = '5') then
      Inc(i5s);
       if (sCC2Num = '5') then
      Inc(i5s);
      if (sCC3Num = '5') then
      Inc(i5s);
      if (sCC4Num = '5') then
      Inc(i5s);
      if (sCC5Num = '5') then
      Inc(i5s);

    //Counts amount of 6 cards
    if sP1C1Num = '6' then
      Inc(i6s);
     if sP1C2Num = '6' then
      Inc(i6s);
     if (sCC1Num = '6') then
      Inc(i6s);
       if (sCC2Num = '6') then
      Inc(i6s);
      if (sCC3Num = '6') then
      Inc(i6s);
      if (sCC4Num = '6') then
      Inc(i6s);
      if (sCC5Num = '6') then
      Inc(i6s);

    //Counts amount of 7 cards
    if sP1C1Num = '7' then
      Inc(i7s);
     if sP1C2Num = '7' then
      Inc(i7s);
     if (sCC1Num = '7') then
      Inc(i7s);
       if (sCC2Num = '7') then
      Inc(i7s);
      if (sCC3Num = '7') then
      Inc(i7s);
      if (sCC4Num = '7') then
      Inc(i7s);
      if (sCC5Num = '7') then
      Inc(i7s);

    //Counts amount of 8 cards
    if sP1C1Num = '8' then
      Inc(i8s);
     if sP1C2Num = '8' then
      Inc(i8s);
     if (sCC1Num = '8') then
      Inc(i8s);
       if (sCC2Num = '8') then
      Inc(i8s);
      if (sCC3Num = '8') then
      Inc(i8s);
      if (sCC4Num = '8') then
      Inc(i8s);
      if (sCC5Num = '8') then
      Inc(i8s);

    //Counts amount of 9 cards
     if sP1C1Num = '9' then
      Inc(i9s);
     if sP1C2Num = '9' then
      Inc(i9s);
     if (sCC1Num = '9') then
      Inc(i9s);
       if (sCC2Num = '9') then
      Inc(i9s);
      if (sCC3Num = '9') then
      Inc(i9s);
      if (sCC4Num = '9') then
      Inc(i9s);
      if (sCC5Num = '9') then
      Inc(i9s);


    //Counts amount of 10 cards
     if sP1C1Num = '10' then
      Inc(i10s);
     if sP1C2Num = '10' then
      Inc(i10s);
     if (sCC1Num = '10') then
      Inc(i10s);
       if (sCC2Num = '10') then
      Inc(i10s);
      if (sCC3Num = '10') then
      Inc(i10s);
      if (sCC4Num = '10') then
      Inc(i10s);
      if (sCC5Num = '10') then
      Inc(i10s);


    //Counts amount of J cards
     if sP1C1Num = 'J' then
      Inc(iJs);
     if sP1C2Num = 'J' then
      Inc(iJs);
     if (sCC1Num = 'J') then
      Inc(iJs);
       if (sCC2Num = 'J') then
      Inc(iJs);
      if (sCC3Num = 'J') then
      Inc(iJs);
      if (sCC4Num = 'J') then
      Inc(iJs);
      if (sCC5Num = 'J') then
      Inc(iJs);

    //Counts amount of Q cards
     if sP1C1Num = 'Q' then
      Inc(iQs);
     if sP1C2Num = 'Q' then
      Inc(iQs);
     if (sCC1Num = 'Q') then
      Inc(iQs);
       if (sCC2Num = 'Q') then
      Inc(iQs);
      if (sCC3Num = 'Q') then
      Inc(iQs);
      if (sCC4Num = 'Q') then
      Inc(iQs);
      if (sCC5Num = 'Q') then
      Inc(iQs);


    //Counts amount of K cards
     if sP1C1Num = 'K' then
      Inc(iKs);
     if sP1C2Num = 'K' then
      Inc(iKs);
     if (sCC1Num = 'K') then
      Inc(iKs);
       if (sCC2Num = 'K') then
      Inc(iKs);
      if (sCC3Num = 'K') then
      Inc(iKs);
      if (sCC4Num = 'K') then
      Inc(iKs);
      if (sCC5Num = 'K') then
      Inc(iKs);


     //Counts amount of A cards
     if sP1C1Num = 'A' then
      Inc(iAs);
     if sP1C2Num = 'A' then
      Inc(iAs);
     if (sCC1Num = 'A') then
      Inc(iAs);
       if (sCC2Num = 'A') then
      Inc(iAs);
      if (sCC3Num = 'A') then
      Inc(iAs);
      if (sCC4Num = 'A') then
      Inc(iAs);
      if (sCC5Num = 'A') then
      Inc(iAs);

      //Counts amount of Hearts
       if sP1C1Suit = 'Hearts' then
       Inc(iHearts);
       if sP1C2Suit = 'Hearts' then
       Inc(iHearts);
       if sCC1Suit = 'Hearts' then
       Inc(iHearts);
       if sCC2Suit = 'Hearts' then
       Inc(iHearts);
       if sCC3Suit = 'Hearts' then
       Inc(iHearts);
       if sCC4Suit = 'Hearts' then
       Inc(iHearts);
       if sCC5Suit = 'Hearts' then
       Inc(iHearts);

      //Counts amount of Spades
       if sP1C1Suit = 'Spades' then
       Inc(iSpades);
       if sP1C2Suit = 'Spades' then
       Inc(iSpades);
       if sCC1Suit = 'Spades' then
       Inc(iSpades);
       if sCC2Suit = 'Spades' then
       Inc(iSpades);
       if sCC3Suit = 'Spades' then
       Inc(iSpades);
       if sCC4Suit = 'Spades' then
       Inc(iSpades);
       if sCC5Suit = 'Spades' then
       Inc(iSpades);

       //Counts amount of Clubs
       if sP1C1Suit = 'Clubs' then
       Inc(iClubs);
       if sP1C2Suit = 'Clubs' then
       Inc(iClubs);
       if sCC1Suit = 'Clubs' then
       Inc(iClubs);
       if sCC2Suit = 'Clubs' then
       Inc(iClubs);
       if sCC3Suit = 'Clubs' then
       Inc(iClubs);
       if sCC4Suit = 'Clubs' then
       Inc(iClubs);
       if sCC5Suit = 'Clubs' then
       Inc(iClubs);

        //Counts amount of Diamonds
       if sP1C1Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sP1C2Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC1Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC2Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC3Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC4Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC5Suit = 'Diamonds' then
       Inc(iDiamonds);


     //Determine hands

     // 4 of a kind
     if iAs = 4 then
        rP1HandRank := 8.22
     else
     if iKs = 4 then
        rP1HandRank := 8.21
     else
     if iJs = 4 then
        rP1HandRank := 8.20
     else
     if i10s = 4 then
        rP1HandRank := 8.19
     else
     if i9s = 4 then
        rP1HandRank := 8.18
     else
     if i8s = 4 then
        rP1HandRank := 8.17
     else
     if i7s = 4 then
        rP1HandRank := 8.16
     else
     if i6s = 4 then
        rP1HandRank := 8.15
     else
     if i5s = 4 then
        rP1HandRank := 8.14
     else
     if i4s = 4 then
        rP1HandRank := 8.13
     else
     if i3s = 4 then
        rP1HandRank := 8.12
     else
     if i2s = 4 then
        rP1HandRank := 8.11

        else
        //3 of a kind
     if iAs = 3 then
      begin
        rP1HandRank := 3.22;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP1HandRank;
      end
     else
     if iKs = 3 then
       begin
        rP1HandRank := 3.21;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP1HandRank;
      end
     else
     if iJs = 3 then
       begin
        rP1HandRank := 3.20;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP1HandRank;
      end
     else
     if i10s = 3 then
       begin
        rP1HandRank := 3.19;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP1HandRank;
      end
     else
     if i9s = 3 then
       begin
        rP1HandRank := 3.18;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP1HandRank;
      end
     else
     if i8s = 3 then
        begin
        rP1HandRank := 3.17;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP1HandRank;
      end
     else
     if i7s = 3 then
        begin
        rP1HandRank := 3.16;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP1HandRank;
      end
     else
     if i6s = 3 then
        begin
        rP1HandRank := 3.15;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP1HandRank;
      end
     else
     if i5s = 3 then
        begin
        rP1HandRank := 3.14;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP1HandRank;
      end
     else
     if i4s = 3 then
        begin
        rP1HandRank := 3.13;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP1HandRank;
      end
     else
     if i3s = 3 then
        begin
        rP1HandRank := 3.12;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP1HandRank;
      end
     else
     if i2s = 3 then
        begin
        rP1HandRank := 3.11;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP1HandRank;
      end;

        //Pair  or Two-Pair
     if iAs = 2 then
     begin
        rP1HandRank := 2.22;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP1HandRank;
     end;
     if iKs = 2 then
       begin
        rP1HandRank := 2.21;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP1HandRank;
     end;

     if iJs = 2 then
        begin
        rP1HandRank := 2.20;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP1HandRank;
     end;

     if i10s = 2 then
        begin
        rP1HandRank := 2.19;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP1HandRank;
     end;

     if i9s = 2 then
        begin
        rP1HandRank := 2.18;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP1HandRank;
     end;

     if i8s = 2 then
       begin
        rP1HandRank := 2.17;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP1HandRank;
     end;

     if i7s = 2 then
        begin
        rP1HandRank := 2.16;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP1HandRank;
     end;

     if i6s = 2 then
        begin
        rP1HandRank := 2.15;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP1HandRank;
     end;

     if i5s = 2 then
        begin
        rP1HandRank := 2.14;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP1HandRank;
     end;

     if i4s = 2 then
        begin
        rP1HandRank := 2.13;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP1HandRank;
     end;

     if i3s = 2 then
         begin
        rP1HandRank := 2.12;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP1HandRank;
     end;

     if i2s = 2 then
        begin
        rP1HandRank := 2.11;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP1HandRank;
     end;


      //Implements Hands

    // Royal Flush
    if (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iHearts >= 5)) or (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iDiamonds >= 5)) or (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iSpades >= 5)) or (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iClubs >= 5)) then
    begin
      rP1HandRank := 10;
    end
    else

      //Straight Flush
    if (((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iHearts >= 5)) or (((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iDiamonds >= 5)) or (((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iSpades >= 5)) or(((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iClubs >= 5))  then
    begin
      rP1HandRank := 9.11;
    end
    else
    if (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iHearts >= 5)) or (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iDiamonds >= 5)) or (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iSpades >= 5)) or (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iClubs >= 5))   then
    begin
      rP1HandRank := 9.12;
    end
    else
    if (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iHearts >= 5)) or (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iDiamonds >= 0)) or (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iSpades >= 5)) or (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iClubs >= 5)) then
    begin
      rP1HandRank := 9.13;
    end
    else
    if (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iHearts >= 5)) or (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iDiamonds >= 5)) or (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iSpades >= 5)) or (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iClubs >= 5)) then
    begin
      rP1HandRank := 9.14;
    end
    else
    if (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iHearts >= 5)) or (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iDiamonds >= 5)) or (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iSpades >= 5)) or (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iClubs >= 5)) then
    begin
      rP1HandRank := 9.15;
    end
    else
    if (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iHearts >= 5)) or (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iDiamonds >= 5)) or (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iSpades >= 5)) or (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iClubs >= 5)) then
    begin
      rP1HandRank := 9.16;
    end
    else
    if (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iHearts >= 5)) or (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iDiamonds >= 5)) or (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iSpades >= 5)) or (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iClubs >= 5)) then
    begin
      rP1HandRank := 9.17;
    end
    else
    if (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iHearts >= 5)) or (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iDiamonds >= 5)) or (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iSpades >= 5)) or (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iClubs >= 5)) then
    begin
      rP1HandRank := 9.18;
    end
    else
    if (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iHearts >= 5)) or (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iDiamonds >= 5)) or (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iSpades >= 5)) or (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iClubs >= 5)) then
    begin
      rP1HandRank := 9.19;
    end
    else

      //Flush
    if (iHearts >= 5) or (iSpades >= 5) or (iDiamonds >= 5) or (iClubs >= 5) then
      rP1HandRank := 6
      else



     //Full House
    if (b3OAK) and (iNumPairs >= 1) then
      rP1HandRank := r3OAKValue + rP1HandRank + 2
    else



    //Straight
    if (iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) then
    begin
      rP1HandRank := 5.11;
    end
    else
    if (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) then
    begin
      rP1HandRank := 5.12;
    end
    else
    if (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) then
    begin
      rP1HandRank := 5.13;
    end
    else
    if (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) then
    begin
      rP1HandRank := 5.14;
    end
    else
    if (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) then
    begin
      rP1HandRank := 5.15;
    end
    else
    if (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) then
    begin
      rP1HandRank := 5.16;
    end
    else
    if (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) then
    begin
      rP1HandRank := 5.17;
    end
    else
    if (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) then
    begin
      rP1HandRank := 5.18;
    end
    else
    if (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) then
    begin
      rP1HandRank := 5.19;
    end
    else
    if (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0) then
    begin
      rP1HandRank := 5.20;
    end
    else


     //Two-Pair
    if iNumPairs >= 2 then
      rP1HandRank := rTwoPairValue;



      //High Card
     if rP1HandRank = 0 then
      begin
        //Cards 1
        if sP1C1Num = '2' then
        rP1C1Value := 1.11
        else
        if sP1C1Num = '3' then
        rP1C1Value := 1.12
        else
        if sP1C1Num = '4' then
        rP1C1Value := 1.13
        else
        if sP1C1Num = '5' then
        rP1C1Value := 1.14
        else
        if sP1C1Num = '6' then
        rP1C1Value := 1.15
        else
        if sP1C1Num = '7' then
        rP1C1Value := 1.16
        else
        if sP1C1Num = '8' then
        rP1C1Value := 1.17
        else
        if sP1C1Num = '9' then
        rP1C1Value := 1.18
        else
        if sP1C1Num = '10' then
        rP1C1Value := 1.19
        else
        if sP1C1Num = 'J' then
        rP1C1Value := 1.20
        else
        if sP1C1Num = 'Q' then
        rP1C1Value := 1.21
        else
        if sP1C1Num = 'K' then
        rP1C1Value := 1.22
        else
        if sP1C1Num = 'A' then
        rP1C1Value := 1.23;

        //Cards 2
        if sP1C2Num = '2' then
        rP1C2Value := 1.11
        else
        if sP1C2Num = '3' then
        rP1C2Value := 1.12
        else
        if sP1C2Num = '4' then
        rP1C2Value := 1.13
        else
        if sP1C2Num = '5' then
        rP1C2Value := 1.14
        else
        if sP1C2Num = '6' then
        rP1C2Value := 1.15
        else
        if sP1C2Num = '7' then
        rP1C2Value := 1.16
        else
        if sP1C2Num = '8' then
        rP1C2Value := 1.17
        else
        if sP1C2Num = '9' then
        rP1C2Value := 1.18
        else
        if sP1C2Num = '10' then
        rP1C2Value := 1.19
        else
        if sP1C2Num = 'J' then
        rP1C2Value := 1.20
        else
        if sP1C2Num = 'Q' then
        rP1C2Value := 1.21
        else
        if sP1C2Num = 'K' then
        rP1C2Value := 1.22
        else
        if sP1C2Num = 'A' then
        rP1C2Value := 1.23;


        if rP1C1Value > rP1C2Value then
          rP1HandRank := rP1C1Value
        else
        if rP1C2Value > rP1C1Value then
          rP1HandRank := rP1C2Value;

      end;
  end
  else
  if sPlayer = sPlayer2 then
  begin
    // Counts amount of 2 cards
     if sP2C1Num = '2' then
      Inc(i2s);
     if sP2C2Num = '2' then
      Inc(i2s);
     if (sCC1Num = '2') then
      Inc(i2s);
       if (sCC2Num = '2') then
      Inc(i2s);
      if (sCC3Num = '2') then
      Inc(i2s);
      if (sCC4Num = '2') then
      Inc(i2s);
      if (sCC5Num = '2') then
      Inc(i2s);


    //Counts amount of 3 cards
    if sP2C1Num = '3' then
      Inc(i3s);
     if sP2C2Num = '3' then
      Inc(i3s);
     if (sCC1Num = '3') then
      Inc(i3s);
       if (sCC2Num = '3') then
      Inc(i3s);
      if (sCC3Num = '3') then
      Inc(i3s);
      if (sCC4Num = '3') then
      Inc(i3s);
      if (sCC5Num = '3') then
      Inc(i3s);

    //Counts amount of 4 cards
    if sP2C1Num = '4' then
      Inc(i4s);
     if sP2C2Num = '4' then
      Inc(i4s);
     if (sCC1Num = '4') then
      Inc(i4s);
       if (sCC2Num = '4') then
      Inc(i4s);
      if (sCC3Num = '4') then
      Inc(i4s);
      if (sCC4Num = '4') then
      Inc(i4s);
      if (sCC5Num = '4') then
      Inc(i4s);

    //Counts amount of 5 cards
   if sP2C1Num = '5' then
      Inc(i5s);
     if sP2C2Num = '5' then
      Inc(i5s);
     if (sCC1Num = '5') then
      Inc(i5s);
       if (sCC2Num = '5') then
      Inc(i5s);
      if (sCC3Num = '5') then
      Inc(i5s);
      if (sCC4Num = '5') then
      Inc(i5s);
      if (sCC5Num = '5') then
      Inc(i5s);

    //Counts amount of 6 cards
    if sP2C1Num = '6' then
      Inc(i6s);
     if sP2C2Num = '6' then
      Inc(i6s);
     if (sCC1Num = '6') then
      Inc(i6s);
       if (sCC2Num = '6') then
      Inc(i6s);
      if (sCC3Num = '6') then
      Inc(i6s);
      if (sCC4Num = '6') then
      Inc(i6s);
      if (sCC5Num = '6') then
      Inc(i6s);

    //Counts amount of 7 cards
    if sP2C1Num = '7' then
      Inc(i7s);
     if sP2C2Num = '7' then
      Inc(i7s);
     if (sCC1Num = '7') then
      Inc(i7s);
       if (sCC2Num = '7') then
      Inc(i7s);
      if (sCC3Num = '7') then
      Inc(i7s);
      if (sCC4Num = '7') then
      Inc(i7s);
      if (sCC5Num = '7') then
      Inc(i7s);

    //Counts amount of 8 cards
    if sP2C1Num = '8' then
      Inc(i8s);
     if sP2C2Num = '8' then
      Inc(i8s);
     if (sCC1Num = '8') then
      Inc(i8s);
       if (sCC2Num = '8') then
      Inc(i8s);
      if (sCC3Num = '8') then
      Inc(i8s);
      if (sCC4Num = '8') then
      Inc(i8s);
      if (sCC5Num = '8') then
      Inc(i8s);

    //Counts amount of 9 cards
     if sP2C1Num = '9' then
      Inc(i9s);
     if sP2C2Num = '9' then
      Inc(i9s);
     if (sCC1Num = '9') then
      Inc(i9s);
       if (sCC2Num = '9') then
      Inc(i9s);
      if (sCC3Num = '9') then
      Inc(i9s);
      if (sCC4Num = '9') then
      Inc(i9s);
      if (sCC5Num = '9') then
      Inc(i9s);


    //Counts amount of 10 cards
     if sP2C1Num = '10' then
      Inc(i10s);
     if sP2C2Num = '10' then
      Inc(i10s);
     if (sCC1Num = '10') then
      Inc(i10s);
       if (sCC2Num = '10') then
      Inc(i10s);
      if (sCC3Num = '10') then
      Inc(i10s);
      if (sCC4Num = '10') then
      Inc(i10s);
      if (sCC5Num = '10') then
      Inc(i10s);


    //Counts amount of J cards
     if sP2C1Num = 'J' then
      Inc(iJs);
     if sP2C2Num = 'J' then
      Inc(iJs);
     if (sCC1Num = 'J') then
      Inc(iJs);
       if (sCC2Num = 'J') then
      Inc(iJs);
      if (sCC3Num = 'J') then
      Inc(iJs);
      if (sCC4Num = 'J') then
      Inc(iJs);
      if (sCC5Num = 'J') then
      Inc(iJs);

    //Counts amount of Q cards
     if sP2C1Num = 'Q' then
      Inc(iQs);
     if sP2C2Num = 'Q' then
      Inc(iQs);
     if (sCC1Num = 'Q') then
      Inc(iQs);
       if (sCC2Num = 'Q') then
      Inc(iQs);
      if (sCC3Num = 'Q') then
      Inc(iQs);
      if (sCC4Num = 'Q') then
      Inc(iQs);
      if (sCC5Num = 'Q') then
      Inc(iQs);


    //Counts amount of K cards
     if sP2C1Num = 'K' then
      Inc(iKs);
     if sP2C2Num = 'K' then
      Inc(iKs);
     if (sCC1Num = 'K') then
      Inc(iKs);
       if (sCC2Num = 'K') then
      Inc(iKs);
      if (sCC3Num = 'K') then
      Inc(iKs);
      if (sCC4Num = 'K') then
      Inc(iKs);
      if (sCC5Num = 'K') then
      Inc(iKs);


     //Counts amount of A cards
     if sP2C1Num = 'A' then
      Inc(iAs);
     if sP2C2Num = 'A' then
      Inc(iAs);
     if (sCC1Num = 'A') then
      Inc(iAs);
       if (sCC2Num = 'A') then
      Inc(iAs);
      if (sCC3Num = 'A') then
      Inc(iAs);
      if (sCC4Num = 'A') then
      Inc(iAs);
      if (sCC5Num = 'A') then
      Inc(iAs);


      //Counts amount of Hearts
       if sP2C1Suit = 'Hearts' then
       Inc(iHearts);
       if sP2C2Suit = 'Hearts' then
       Inc(iHearts);
       if sCC1Suit = 'Hearts' then
       Inc(iHearts);
       if sCC2Suit = 'Hearts' then
       Inc(iHearts);
       if sCC3Suit = 'Hearts' then
       Inc(iHearts);
       if sCC4Suit = 'Hearts' then
       Inc(iHearts);
       if sCC5Suit = 'Hearts' then
       Inc(iHearts);

      //Counts amount of Spades
       if sP2C1Suit = 'Spades' then
       Inc(iSpades);
       if sP2C2Suit = 'Spades' then
       Inc(iSpades);
       if sCC1Suit = 'Spades' then
       Inc(iSpades);
       if sCC2Suit = 'Spades' then
       Inc(iSpades);
       if sCC3Suit = 'Spades' then
       Inc(iSpades);
       if sCC4Suit = 'Spades' then
       Inc(iSpades);
       if sCC5Suit = 'Spades' then
       Inc(iSpades);

       //Counts amount of Clubs
       if sP2C1Suit = 'Clubs' then
       Inc(iClubs);
       if sP2C2Suit = 'Clubs' then
       Inc(iClubs);
       if sCC1Suit = 'Clubs' then
       Inc(iClubs);
       if sCC2Suit = 'Clubs' then
       Inc(iClubs);
       if sCC3Suit = 'Clubs' then
       Inc(iClubs);
       if sCC4Suit = 'Clubs' then
       Inc(iClubs);
       if sCC5Suit = 'Clubs' then
       Inc(iClubs);

        //Counts amount of Diamonds
       if sP2C1Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sP2C2Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC1Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC2Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC3Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC4Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC5Suit = 'Diamonds' then
       Inc(iDiamonds);

    //Determine hands

     // 4 of a kind
     if iAs = 4 then
        rP2HandRank := 8.22
     else
     if iKs = 4 then
        rP2HandRank := 8.21
     else
     if iJs = 4 then
        rP2HandRank := 8.20
     else
     if i10s = 4 then
        rP2HandRank := 8.19
     else
     if i9s = 4 then
        rP2HandRank := 8.18
     else
     if i8s = 4 then
        rP2HandRank := 8.17
     else
     if i7s = 4 then
        rP2HandRank := 8.16
     else
     if i6s = 4 then
        rP2HandRank := 8.15
     else
     if i5s = 4 then
        rP2HandRank := 8.14
     else
     if i4s = 4 then
        rP2HandRank := 8.13
     else
     if i3s = 4 then
        rP2HandRank := 8.12
     else
     if i2s = 4 then
        rP2HandRank := 8.11

        else
        //3 of a kind
     if iAs = 3 then
      begin
        rP2HandRank := 3.22;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP2HandRank;
      end
     else
     if iKs = 3 then
       begin
        rP2HandRank := 3.21;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP2HandRank;
      end
     else
     if iJs = 3 then
       begin
        rP2HandRank := 3.20;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP2HandRank;
      end
     else
     if i10s = 3 then
       begin
        rP2HandRank := 3.19;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP2HandRank;
      end
     else
     if i9s = 3 then
       begin
        rP2HandRank := 3.18;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP2HandRank;
      end
     else
     if i8s = 3 then
        begin
        rP2HandRank := 3.17;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP2HandRank;
      end
     else
     if i7s = 3 then
        begin
        rP2HandRank := 3.16;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP2HandRank;
      end
     else
     if i6s = 3 then
        begin
        rP2HandRank := 3.15;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP2HandRank;
      end
     else
     if i5s = 3 then
        begin
        rP2HandRank := 3.14;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP2HandRank;
      end
     else
     if i4s = 3 then
        begin
        rP2HandRank := 3.13;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP2HandRank;
      end
     else
     if i3s = 3 then
        begin
        rP2HandRank := 3.12;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP2HandRank;
      end
     else
     if i2s = 3 then
        begin
        rP2HandRank := 3.11;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP2HandRank;
      end;



        //Pair  or Two-Pair
     if iAs = 2 then
     begin
        rP2HandRank := 2.22;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP2HandRank;
     end;
     if iKs = 2 then
       begin
        rP2HandRank := 2.21;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP2HandRank;
     end;

     if iJs = 2 then
        begin
        rP2HandRank := 2.20;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP2HandRank;
     end;

     if i10s = 2 then
        begin
        rP2HandRank := 2.19;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP2HandRank;
     end;

     if i9s = 2 then
        begin
        rP2HandRank := 2.18;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP2HandRank;
     end;

     if i8s = 2 then
       begin
        rP2HandRank := 2.17;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP2HandRank;
     end;

     if i7s = 2 then
        begin
        rP2HandRank := 2.16;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP2HandRank;
     end;

     if i6s = 2 then
        begin
        rP2HandRank := 2.15;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP2HandRank;
     end;

     if i5s = 2 then
        begin
        rP2HandRank := 2.14;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP2HandRank;
     end;

     if i4s = 2 then
        begin
        rP2HandRank := 2.13;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP2HandRank;
     end;

     if i3s = 2 then
         begin
        rP2HandRank := 2.12;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP2HandRank;
     end;

     if i2s = 2 then
        begin
        rP2HandRank := 2.11;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP2HandRank;
     end;


     //Implements Hands

   // Royal Flush
    if (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iHearts >= 5)) or (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iDiamonds >= 5)) or (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iSpades >= 5)) or (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iClubs >= 5)) then
    begin
      rP2HandRank := 10;
    end
    else

      //Straight Flush
    if (((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iHearts >= 5)) or (((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iDiamonds >= 5)) or (((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iSpades >= 5)) or(((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iClubs >= 5))  then
    begin
      rP2HandRank := 9.11;
    end
    else
    if (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iHearts >= 5)) or (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iDiamonds >= 5)) or (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iSpades >= 5)) or (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iClubs >= 5))   then
    begin
      rP2HandRank := 9.12;
    end
    else
    if (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iHearts >= 5)) or (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iDiamonds >= 0)) or (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iSpades >= 5)) or (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iClubs >= 5)) then
    begin
      rP2HandRank := 9.13;
    end
    else
    if (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iHearts >= 5)) or (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iDiamonds >= 5)) or (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iSpades >= 5)) or (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iClubs >= 5)) then
    begin
      rP2HandRank := 9.14;
    end
    else
    if (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iHearts >= 5)) or (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iDiamonds >= 5)) or (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iSpades >= 5)) or (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iClubs >= 5)) then
    begin
      rP2HandRank := 9.15;
    end
    else
    if (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iHearts >= 5)) or (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iDiamonds >= 5)) or (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iSpades >= 5)) or (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iClubs >= 5)) then
    begin
      rP2HandRank := 9.16;
    end
    else
    if (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iHearts >= 5)) or (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iDiamonds >= 5)) or (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iSpades >= 5)) or (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iClubs >= 5)) then
    begin
      rP2HandRank := 9.17;
    end
    else
    if (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iHearts >= 5)) or (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iDiamonds >= 5)) or (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iSpades >= 5)) or (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iClubs >= 5)) then
    begin
      rP2HandRank := 9.18;
    end
    else
    if (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iHearts >= 5)) or (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iDiamonds >= 5)) or (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iSpades >= 5)) or (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iClubs >= 5)) then
    begin
      rP2HandRank := 9.19;
    end
    else



      //Flush
    if (iHearts >= 5) or (iSpades >= 5) or (iDiamonds >= 5) or (iClubs >= 5) then
      rP2HandRank := 6
      else



     //Full House
    if (b3OAK) and (iNumPairs >= 1) then
      rP2HandRank := r3OAKValue + rP2HandRank + 2
    else


   //Straight
    if (iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) then
    begin
      rP2HandRank := 5.11;
    end
    else
    if (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) then
    begin
      rP2HandRank := 5.12;
    end
    else
    if (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) then
    begin
      rP2HandRank := 5.13;
    end
    else
    if (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) then
    begin
      rP2HandRank := 5.14;
    end
    else
    if (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) then
    begin
      rP2HandRank := 5.15;
    end
    else
    if (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) then
    begin
      rP2HandRank := 5.16;
    end
    else
    if (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) then
    begin
      rP2HandRank := 5.17;
    end
    else
    if (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) then
    begin
      rP2HandRank := 5.18;
    end
    else
    if (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) then
    begin
      rP2HandRank := 5.19;
    end
    else
    if (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0) then
    begin
      rP2HandRank := 5.20;
    end
    else


     //Two-Pair
    if iNumPairs >= 2 then
      rP2HandRank := rTwoPairValue;

      //High Card
     if rP2HandRank = 0 then
      begin
        //Cards 1
        if sP2C1Num = '2' then
        rP2C1Value := 1.11
        else
        if sP2C1Num = '3' then
        rP2C1Value := 1.12
        else
        if sP2C1Num = '4' then
        rP2C1Value := 1.13
        else
        if sP2C1Num = '5' then
        rP2C1Value := 1.14
        else
        if sP2C1Num = '6' then
        rP2C1Value := 1.15
        else
        if sP2C1Num = '7' then
        rP2C1Value := 1.16
        else
        if sP2C1Num = '8' then
        rP2C1Value := 1.17
        else
        if sP2C1Num = '9' then
        rP2C1Value := 1.18
        else
        if sP2C1Num = '10' then
        rP2C1Value := 1.19
        else
        if sP2C1Num = 'J' then
        rP2C1Value := 1.20
        else
        if sP2C1Num = 'Q' then
        rP2C1Value := 1.21
        else
        if sP2C1Num = 'K' then
        rP2C1Value := 1.22
        else
        if sP2C1Num = 'A' then
        rP2C1Value := 1.23;

        //Cards 2
        if sP2C2Num = '2' then
        rP2C2Value := 1.11
        else
        if sP2C2Num = '3' then
        rP2C2Value := 1.12
        else
        if sP2C2Num = '4' then
        rP2C2Value := 1.13
        else
        if sP2C2Num = '5' then
        rP2C2Value := 1.14
        else
        if sP2C2Num = '6' then
        rP2C2Value := 1.15
        else
        if sP2C2Num = '7' then
        rP2C2Value := 1.16
        else
        if sP2C2Num = '8' then
        rP2C2Value := 1.17
        else
        if sP2C2Num = '9' then
        rP2C2Value := 1.18
        else
        if sP2C2Num = '10' then
        rP2C2Value := 1.19
        else
        if sP2C2Num = 'J' then
        rP2C2Value := 1.20
        else
        if sP2C2Num = 'Q' then
        rP2C2Value := 1.21
        else
        if sP2C2Num = 'K' then
        rP2C2Value := 1.22
        else
        if sP2C2Num = 'A' then
        rP2C2Value := 1.23;


        if rP2C1Value > rP2C2Value then
          rP2HandRank := rP2C1Value
        else
        if rP2C2Value > rP2C1Value then
          rP2HandRank := rP2C2Value;

      end;

  end
  else
  if sPlayer = sPlayer3 then
  begin
    // Counts amount of 2 cards
     if sP3C1Num = '2' then
      Inc(i2s);
     if sP3C2Num = '2' then
      Inc(i2s);
     if (sCC1Num = '2') then
      Inc(i2s);
       if (sCC2Num = '2') then
      Inc(i2s);
      if (sCC3Num = '2') then
      Inc(i2s);
      if (sCC4Num = '2') then
      Inc(i2s);
      if (sCC5Num = '2') then
      Inc(i2s);


    //Counts amount of 3 cards
    if sP3C1Num = '3' then
      Inc(i3s);
     if sP3C2Num = '3' then
      Inc(i3s);
     if (sCC1Num = '3') then
      Inc(i3s);
       if (sCC2Num = '3') then
      Inc(i3s);
      if (sCC3Num = '3') then
      Inc(i3s);
      if (sCC4Num = '3') then
      Inc(i3s);
      if (sCC5Num = '3') then
      Inc(i3s);

    //Counts amount of 4 cards
    if sP3C1Num = '4' then
      Inc(i4s);
     if sP3C2Num = '4' then
      Inc(i4s);
     if (sCC1Num = '4') then
      Inc(i4s);
       if (sCC2Num = '4') then
      Inc(i4s);
      if (sCC3Num = '4') then
      Inc(i4s);
      if (sCC4Num = '4') then
      Inc(i4s);
      if (sCC5Num = '4') then
      Inc(i4s);

    //Counts amount of 5 cards
   if sP3C1Num = '5' then
      Inc(i5s);
     if sP3C2Num = '5' then
      Inc(i5s);
     if (sCC1Num = '5') then
      Inc(i5s);
       if (sCC2Num = '5') then
      Inc(i5s);
      if (sCC3Num = '5') then
      Inc(i5s);
      if (sCC4Num = '5') then
      Inc(i5s);
      if (sCC5Num = '5') then
      Inc(i5s);

    //Counts amount of 6 cards
    if sP3C1Num = '6' then
      Inc(i6s);
     if sP3C2Num = '6' then
      Inc(i6s);
     if (sCC1Num = '6') then
      Inc(i6s);
       if (sCC2Num = '6') then
      Inc(i6s);
      if (sCC3Num = '6') then
      Inc(i6s);
      if (sCC4Num = '6') then
      Inc(i6s);
      if (sCC5Num = '6') then
      Inc(i6s);

    //Counts amount of 7 cards
    if sP3C1Num = '7' then
      Inc(i7s);
     if sP3C2Num = '7' then
      Inc(i7s);
     if (sCC1Num = '7') then
      Inc(i7s);
       if (sCC2Num = '7') then
      Inc(i7s);
      if (sCC3Num = '7') then
      Inc(i7s);
      if (sCC4Num = '7') then
      Inc(i7s);
      if (sCC5Num = '7') then
      Inc(i7s);

    //Counts amount of 8 cards
    if sP3C1Num = '8' then
      Inc(i8s);
     if sP3C2Num = '8' then
      Inc(i8s);
     if (sCC1Num = '8') then
      Inc(i8s);
       if (sCC2Num = '8') then
      Inc(i8s);
      if (sCC3Num = '8') then
      Inc(i8s);
      if (sCC4Num = '8') then
      Inc(i8s);
      if (sCC5Num = '8') then
      Inc(i8s);

    //Counts amount of 9 cards
     if sP3C1Num = '9' then
      Inc(i9s);
     if sP3C2Num = '9' then
      Inc(i9s);
     if (sCC1Num = '9') then
      Inc(i9s);
       if (sCC2Num = '9') then
      Inc(i9s);
      if (sCC3Num = '9') then
      Inc(i9s);
      if (sCC4Num = '9') then
      Inc(i9s);
      if (sCC5Num = '9') then
      Inc(i9s);


    //Counts amount of 10 cards
     if sP3C1Num = '10' then
      Inc(i10s);
     if sP3C2Num = '10' then
      Inc(i10s);
     if (sCC1Num = '10') then
      Inc(i10s);
       if (sCC2Num = '10') then
      Inc(i10s);
      if (sCC3Num = '10') then
      Inc(i10s);
      if (sCC4Num = '10') then
      Inc(i10s);
      if (sCC5Num = '10') then
      Inc(i10s);


    //Counts amount of J cards
     if sP3C1Num = 'J' then
      Inc(iJs);
     if sP3C2Num = 'J' then
      Inc(iJs);
     if (sCC1Num = 'J') then
      Inc(iJs);
       if (sCC2Num = 'J') then
      Inc(iJs);
      if (sCC3Num = 'J') then
      Inc(iJs);
      if (sCC4Num = 'J') then
      Inc(iJs);
      if (sCC5Num = 'J') then
      Inc(iJs);

    //Counts amount of Q cards
     if sP3C1Num = 'Q' then
      Inc(iQs);
     if sP3C2Num = 'Q' then
      Inc(iQs);
     if (sCC1Num = 'Q') then
      Inc(iQs);
       if (sCC2Num = 'Q') then
      Inc(iQs);
      if (sCC3Num = 'Q') then
      Inc(iQs);
      if (sCC4Num = 'Q') then
      Inc(iQs);
      if (sCC5Num = 'Q') then
      Inc(iQs);


    //Counts amount of K cards
     if sP3C1Num = 'K' then
      Inc(iKs);
     if sP3C2Num = 'K' then
      Inc(iKs);
     if (sCC1Num = 'K') then
      Inc(iKs);
       if (sCC2Num = 'K') then
      Inc(iKs);
      if (sCC3Num = 'K') then
      Inc(iKs);
      if (sCC4Num = 'K') then
      Inc(iKs);
      if (sCC5Num = 'K') then
      Inc(iKs);


     //Counts amount of A cards
     if sP3C1Num = 'A' then
      Inc(iAs);
     if sP3C2Num = 'A' then
      Inc(iAs);
     if (sCC1Num = 'A') then
      Inc(iAs);
       if (sCC2Num = 'A') then
      Inc(iAs);
      if (sCC3Num = 'A') then
      Inc(iAs);
      if (sCC4Num = 'A') then
      Inc(iAs);
      if (sCC5Num = 'A') then
      Inc(iAs);


      //Counts amount of Hearts
       if sP3C1Suit = 'Hearts' then
       Inc(iHearts);
       if sP3C2Suit = 'Hearts' then
       Inc(iHearts);
       if sCC1Suit = 'Hearts' then
       Inc(iHearts);
       if sCC2Suit = 'Hearts' then
       Inc(iHearts);
       if sCC3Suit = 'Hearts' then
       Inc(iHearts);
       if sCC4Suit = 'Hearts' then
       Inc(iHearts);
       if sCC5Suit = 'Hearts' then
       Inc(iHearts);

      //Counts amount of Spades
       if sP3C1Suit = 'Spades' then
       Inc(iSpades);
       if sP3C2Suit = 'Spades' then
       Inc(iSpades);
       if sCC1Suit = 'Spades' then
       Inc(iSpades);
       if sCC2Suit = 'Spades' then
       Inc(iSpades);
       if sCC3Suit = 'Spades' then
       Inc(iSpades);
       if sCC4Suit = 'Spades' then
       Inc(iSpades);
       if sCC5Suit = 'Spades' then
       Inc(iSpades);

       //Counts amount of Clubs
       if sP3C1Suit = 'Clubs' then
       Inc(iClubs);
       if sP3C2Suit = 'Clubs' then
       Inc(iClubs);
       if sCC1Suit = 'Clubs' then
       Inc(iClubs);
       if sCC2Suit = 'Clubs' then
       Inc(iClubs);
       if sCC3Suit = 'Clubs' then
       Inc(iClubs);
       if sCC4Suit = 'Clubs' then
       Inc(iClubs);
       if sCC5Suit = 'Clubs' then
       Inc(iClubs);

        //Counts amount of Diamonds
       if sP3C1Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sP3C2Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC1Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC2Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC3Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC4Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC5Suit = 'Diamonds' then
       Inc(iDiamonds);

    //Determine hands

     // 4 of a kind
     if iAs = 4 then
        rP3HandRank := 8.22
     else
     if iKs = 4 then
        rP3HandRank := 8.21
     else
     if iJs = 4 then
        rP3HandRank := 8.20
     else
     if i10s = 4 then
        rP3HandRank := 8.19
     else
     if i9s = 4 then
        rP3HandRank := 8.18
     else
     if i8s = 4 then
        rP3HandRank := 8.17
     else
     if i7s = 4 then
        rP3HandRank := 8.16
     else
     if i6s = 4 then
        rP3HandRank := 8.15
     else
     if i5s = 4 then
        rP3HandRank := 8.14
     else
     if i4s = 4 then
        rP3HandRank := 8.13
     else
     if i3s = 4 then
        rP3HandRank := 8.12
     else
     if i2s = 4 then
        rP3HandRank := 8.11

        else
        //3 of a kind
     if iAs = 3 then
      begin
        rP3HandRank := 3.22;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP3HandRank;
      end
     else
     if iKs = 3 then
       begin
        rP3HandRank := 3.21;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP3HandRank;
      end
     else
     if iJs = 3 then
       begin
        rP3HandRank := 3.20;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP3HandRank;
      end
     else
     if i10s = 3 then
       begin
        rP3HandRank := 3.19;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP3HandRank;
      end
     else
     if i9s = 3 then
       begin
        rP3HandRank := 3.18;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP3HandRank;
      end
     else
     if i8s = 3 then
        begin
        rP3HandRank := 3.17;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP3HandRank;
      end
     else
     if i7s = 3 then
        begin
        rP3HandRank := 3.16;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP3HandRank;
      end
     else
     if i6s = 3 then
        begin
        rP3HandRank := 3.15;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP3HandRank;
      end
     else
     if i5s = 3 then
        begin
        rP3HandRank := 3.14;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP3HandRank;
      end
     else
     if i4s = 3 then
        begin
        rP3HandRank := 3.13;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP3HandRank;
      end
     else
     if i3s = 3 then
        begin
        rP3HandRank := 3.12;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP3HandRank;
      end
     else
     if i2s = 3 then
        begin
        rP3HandRank := 3.11;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP3HandRank;
      end;



        //Pair  or Two-Pair
     if iAs = 2 then
     begin
        rP3HandRank := 2.22;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP3HandRank;
     end;
     if iKs = 2 then
       begin
        rP3HandRank := 2.21;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP3HandRank;
     end;

     if iJs = 2 then
        begin
        rP3HandRank := 2.20;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP3HandRank;
     end;

     if i10s = 2 then
        begin
        rP3HandRank := 2.19;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP3HandRank;
     end;

     if i9s = 2 then
        begin
        rP3HandRank := 2.18;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP3HandRank;
     end;

     if i8s = 2 then
       begin
        rP3HandRank := 2.17;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP3HandRank;
     end;

     if i7s = 2 then
        begin
        rP3HandRank := 2.16;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP3HandRank;
     end;

     if i6s = 2 then
        begin
        rP3HandRank := 2.15;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP3HandRank;
     end;

     if i5s = 2 then
        begin
        rP3HandRank := 2.14;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP3HandRank;
     end;

     if i4s = 2 then
        begin
        rP3HandRank := 2.13;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP3HandRank;
     end;

     if i3s = 2 then
         begin
        rP3HandRank := 2.12;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP3HandRank;
     end;

     if i2s = 2 then
        begin
        rP3HandRank := 2.11;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP3HandRank;
     end;


     //Implements Hands

   // Royal Flush
    if (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iHearts >= 5)) or (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iDiamonds >= 5)) or (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iSpades >= 5)) or (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iClubs >= 5)) then
    begin
      rP3HandRank := 10;
    end
    else

      //Straight Flush
    if (((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iHearts >= 5)) or (((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iDiamonds >= 5)) or (((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iSpades >= 5)) or(((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iClubs >= 5))  then
    begin
      rP3HandRank := 9.11;
    end
    else
    if (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iHearts >= 5)) or (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iDiamonds >= 5)) or (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iSpades >= 5)) or (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iClubs >= 5))   then
    begin
      rP3HandRank := 9.12;
    end
    else
    if (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iHearts >= 5)) or (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iDiamonds >= 0)) or (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iSpades >= 5)) or (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iClubs >= 5)) then
    begin
      rP3HandRank := 9.13;
    end
    else
    if (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iHearts >= 5)) or (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iDiamonds >= 5)) or (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iSpades >= 5)) or (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iClubs >= 5)) then
    begin
      rP3HandRank := 9.14;
    end
    else
    if (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iHearts >= 5)) or (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iDiamonds >= 5)) or (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iSpades >= 5)) or (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iClubs >= 5)) then
    begin
      rP3HandRank := 9.15;
    end
    else
    if (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iHearts >= 5)) or (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iDiamonds >= 5)) or (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iSpades >= 5)) or (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iClubs >= 5)) then
    begin
      rP3HandRank := 9.16;
    end
    else
    if (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iHearts >= 5)) or (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iDiamonds >= 5)) or (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iSpades >= 5)) or (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iClubs >= 5)) then
    begin
      rP3HandRank := 9.17;
    end
    else
    if (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iHearts >= 5)) or (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iDiamonds >= 5)) or (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iSpades >= 5)) or (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iClubs >= 5)) then
    begin
      rP3HandRank := 9.18;
    end
    else
    if (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iHearts >= 5)) or (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iDiamonds >= 5)) or (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iSpades >= 5)) or (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iClubs >= 5)) then
    begin
      rP3HandRank := 9.19;
    end
    else



      //Flush
    if (iHearts >= 5) or (iSpades >= 5) or (iDiamonds >= 5) or (iClubs >= 5) then
      rP3HandRank := 6
      else



     //Full House
    if (b3OAK) and (iNumPairs >= 1) then
      rP3HandRank := r3OAKValue + rP3HandRank + 2
    else


   //Straight
    if (iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) then
    begin
      rP3HandRank := 5.11;
    end
    else
    if (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) then
    begin
      rP3HandRank := 5.12;
    end
    else
    if (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) then
    begin
      rP3HandRank := 5.13;
    end
    else
    if (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) then
    begin
      rP3HandRank := 5.14;
    end
    else
    if (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) then
    begin
      rP3HandRank := 5.15;
    end
    else
    if (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) then
    begin
      rP3HandRank := 5.16;
    end
    else
    if (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) then
    begin
      rP3HandRank := 5.17;
    end
    else
    if (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) then
    begin
      rP3HandRank := 5.18;
    end
    else
    if (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) then
    begin
      rP3HandRank := 5.19;
    end
    else
    if (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0) then
    begin
      rP3HandRank := 5.20;
    end
    else


     //Two-Pair
    if iNumPairs >= 2 then
      rP3HandRank := rTwoPairValue;

      //High Card
     if rP3HandRank = 0 then
      begin
        //Cards 1
        if sP3C1Num = '2' then
        rP3C1Value := 1.11
        else
        if sP3C1Num = '3' then
        rP3C1Value := 1.12
        else
        if sP3C1Num = '4' then
        rP3C1Value := 1.13
        else
        if sP3C1Num = '5' then
        rP3C1Value := 1.14
        else
        if sP3C1Num = '6' then
        rP3C1Value := 1.15
        else
        if sP3C1Num = '7' then
        rP3C1Value := 1.16
        else
        if sP3C1Num = '8' then
        rP3C1Value := 1.17
        else
        if sP3C1Num = '9' then
        rP3C1Value := 1.18
        else
        if sP3C1Num = '10' then
        rP3C1Value := 1.19
        else
        if sP3C1Num = 'J' then
        rP3C1Value := 1.20
        else
        if sP3C1Num = 'Q' then
        rP3C1Value := 1.21
        else
        if sP3C1Num = 'K' then
        rP3C1Value := 1.22
        else
        if sP3C1Num = 'A' then
        rP3C1Value := 1.23;

        //Cards 2
        if sP3C2Num = '2' then
        rP3C2Value := 1.11
        else
        if sP3C2Num = '3' then
        rP3C2Value := 1.12
        else
        if sP3C2Num = '4' then
        rP3C2Value := 1.13
        else
        if sP3C2Num = '5' then
        rP3C2Value := 1.14
        else
        if sP3C2Num = '6' then
        rP3C2Value := 1.15
        else
        if sP3C2Num = '7' then
        rP3C2Value := 1.16
        else
        if sP3C2Num = '8' then
        rP3C2Value := 1.17
        else
        if sP3C2Num = '9' then
        rP3C2Value := 1.18
        else
        if sP3C2Num = '10' then
        rP3C2Value := 1.19
        else
        if sP3C2Num = 'J' then
        rP3C2Value := 1.20
        else
        if sP3C2Num = 'Q' then
        rP3C2Value := 1.21
        else
        if sP3C2Num = 'K' then
        rP3C2Value := 1.22
        else
        if sP3C2Num = 'A' then
        rP3C2Value := 1.23;


        if rP3C1Value > rP3C2Value then
          rP3HandRank := rP3C1Value
        else
        if rP3C2Value > rP3C1Value then
          rP3HandRank := rP3C2Value;

      end;

  end
  else
  if sPlayer = sPlayer4 then
 begin
    // Counts amount of 2 cards
     if sP4C1Num = '2' then
      Inc(i2s);
     if sP4C2Num = '2' then
      Inc(i2s);
     if (sCC1Num = '2') then
      Inc(i2s);
       if (sCC2Num = '2') then
      Inc(i2s);
      if (sCC3Num = '2') then
      Inc(i2s);
      if (sCC4Num = '2') then
      Inc(i2s);
      if (sCC5Num = '2') then
      Inc(i2s);


    //Counts amount of 3 cards
    if sP4C1Num = '3' then
      Inc(i3s);
     if sP4C2Num = '3' then
      Inc(i3s);
     if (sCC1Num = '3') then
      Inc(i3s);
       if (sCC2Num = '3') then
      Inc(i3s);
      if (sCC3Num = '3') then
      Inc(i3s);
      if (sCC4Num = '3') then
      Inc(i3s);
      if (sCC5Num = '3') then
      Inc(i3s);

    //Counts amount of 4 cards
    if sP4C1Num = '4' then
      Inc(i4s);
     if sP4C2Num = '4' then
      Inc(i4s);
     if (sCC1Num = '4') then
      Inc(i4s);
       if (sCC2Num = '4') then
      Inc(i4s);
      if (sCC3Num = '4') then
      Inc(i4s);
      if (sCC4Num = '4') then
      Inc(i4s);
      if (sCC5Num = '4') then
      Inc(i4s);

    //Counts amount of 5 cards
   if sP4C1Num = '5' then
      Inc(i5s);
     if sP4C2Num = '5' then
      Inc(i5s);
     if (sCC1Num = '5') then
      Inc(i5s);
       if (sCC2Num = '5') then
      Inc(i5s);
      if (sCC3Num = '5') then
      Inc(i5s);
      if (sCC4Num = '5') then
      Inc(i5s);
      if (sCC5Num = '5') then
      Inc(i5s);

    //Counts amount of 6 cards
    if sP4C1Num = '6' then
      Inc(i6s);
     if sP4C2Num = '6' then
      Inc(i6s);
     if (sCC1Num = '6') then
      Inc(i6s);
       if (sCC2Num = '6') then
      Inc(i6s);
      if (sCC3Num = '6') then
      Inc(i6s);
      if (sCC4Num = '6') then
      Inc(i6s);
      if (sCC5Num = '6') then
      Inc(i6s);

    //Counts amount of 7 cards
    if sP4C1Num = '7' then
      Inc(i7s);
     if sP4C2Num = '7' then
      Inc(i7s);
     if (sCC1Num = '7') then
      Inc(i7s);
       if (sCC2Num = '7') then
      Inc(i7s);
      if (sCC3Num = '7') then
      Inc(i7s);
      if (sCC4Num = '7') then
      Inc(i7s);
      if (sCC5Num = '7') then
      Inc(i7s);

    //Counts amount of 8 cards
    if sP4C1Num = '8' then
      Inc(i8s);
     if sP4C2Num = '8' then
      Inc(i8s);
     if (sCC1Num = '8') then
      Inc(i8s);
       if (sCC2Num = '8') then
      Inc(i8s);
      if (sCC3Num = '8') then
      Inc(i8s);
      if (sCC4Num = '8') then
      Inc(i8s);
      if (sCC5Num = '8') then
      Inc(i8s);

    //Counts amount of 9 cards
     if sP4C1Num = '9' then
      Inc(i9s);
     if sP4C2Num = '9' then
      Inc(i9s);
     if (sCC1Num = '9') then
      Inc(i9s);
       if (sCC2Num = '9') then
      Inc(i9s);
      if (sCC3Num = '9') then
      Inc(i9s);
      if (sCC4Num = '9') then
      Inc(i9s);
      if (sCC5Num = '9') then
      Inc(i9s);


    //Counts amount of 10 cards
     if sP4C1Num = '10' then
      Inc(i10s);
     if sP4C2Num = '10' then
      Inc(i10s);
     if (sCC1Num = '10') then
      Inc(i10s);
       if (sCC2Num = '10') then
      Inc(i10s);
      if (sCC3Num = '10') then
      Inc(i10s);
      if (sCC4Num = '10') then
      Inc(i10s);
      if (sCC5Num = '10') then
      Inc(i10s);


    //Counts amount of J cards
     if sP4C1Num = 'J' then
      Inc(iJs);
     if sP4C2Num = 'J' then
      Inc(iJs);
     if (sCC1Num = 'J') then
      Inc(iJs);
       if (sCC2Num = 'J') then
      Inc(iJs);
      if (sCC3Num = 'J') then
      Inc(iJs);
      if (sCC4Num = 'J') then
      Inc(iJs);
      if (sCC5Num = 'J') then
      Inc(iJs);

    //Counts amount of Q cards
     if sP4C1Num = 'Q' then
      Inc(iQs);
     if sP4C2Num = 'Q' then
      Inc(iQs);
     if (sCC1Num = 'Q') then
      Inc(iQs);
       if (sCC2Num = 'Q') then
      Inc(iQs);
      if (sCC3Num = 'Q') then
      Inc(iQs);
      if (sCC4Num = 'Q') then
      Inc(iQs);
      if (sCC5Num = 'Q') then
      Inc(iQs);


    //Counts amount of K cards
     if sP4C1Num = 'K' then
      Inc(iKs);
     if sP4C2Num = 'K' then
      Inc(iKs);
     if (sCC1Num = 'K') then
      Inc(iKs);
       if (sCC2Num = 'K') then
      Inc(iKs);
      if (sCC3Num = 'K') then
      Inc(iKs);
      if (sCC4Num = 'K') then
      Inc(iKs);
      if (sCC5Num = 'K') then
      Inc(iKs);


     //Counts amount of A cards
     if sP4C1Num = 'A' then
      Inc(iAs);
     if sP4C2Num = 'A' then
      Inc(iAs);
     if (sCC1Num = 'A') then
      Inc(iAs);
       if (sCC2Num = 'A') then
      Inc(iAs);
      if (sCC3Num = 'A') then
      Inc(iAs);
      if (sCC4Num = 'A') then
      Inc(iAs);
      if (sCC5Num = 'A') then
      Inc(iAs);


      //Counts amount of Hearts
       if sP4C1Suit = 'Hearts' then
       Inc(iHearts);
       if sP4C2Suit = 'Hearts' then
       Inc(iHearts);
       if sCC1Suit = 'Hearts' then
       Inc(iHearts);
       if sCC2Suit = 'Hearts' then
       Inc(iHearts);
       if sCC3Suit = 'Hearts' then
       Inc(iHearts);
       if sCC4Suit = 'Hearts' then
       Inc(iHearts);
       if sCC5Suit = 'Hearts' then
       Inc(iHearts);

      //Counts amount of Spades
       if sP4C1Suit = 'Spades' then
       Inc(iSpades);
       if sP4C2Suit = 'Spades' then
       Inc(iSpades);
       if sCC1Suit = 'Spades' then
       Inc(iSpades);
       if sCC2Suit = 'Spades' then
       Inc(iSpades);
       if sCC3Suit = 'Spades' then
       Inc(iSpades);
       if sCC4Suit = 'Spades' then
       Inc(iSpades);
       if sCC5Suit = 'Spades' then
       Inc(iSpades);

       //Counts amount of Clubs
       if sP4C1Suit = 'Clubs' then
       Inc(iClubs);
       if sP4C2Suit = 'Clubs' then
       Inc(iClubs);
       if sCC1Suit = 'Clubs' then
       Inc(iClubs);
       if sCC2Suit = 'Clubs' then
       Inc(iClubs);
       if sCC3Suit = 'Clubs' then
       Inc(iClubs);
       if sCC4Suit = 'Clubs' then
       Inc(iClubs);
       if sCC5Suit = 'Clubs' then
       Inc(iClubs);

        //Counts amount of Diamonds
       if sP4C1Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sP4C2Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC1Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC2Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC3Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC4Suit = 'Diamonds' then
       Inc(iDiamonds);
       if sCC5Suit = 'Diamonds' then
       Inc(iDiamonds);

    //Determine hands

     // 4 of a kind
     if iAs = 4 then
        rP4HandRank := 8.22
     else
     if iKs = 4 then
        rP4HandRank := 8.21
     else
     if iJs = 4 then
        rP4HandRank := 8.20
     else
     if i10s = 4 then
        rP4HandRank := 8.19
     else
     if i9s = 4 then
        rP4HandRank := 8.18
     else
     if i8s = 4 then
        rP4HandRank := 8.17
     else
     if i7s = 4 then
        rP4HandRank := 8.16
     else
     if i6s = 4 then
        rP4HandRank := 8.15
     else
     if i5s = 4 then
        rP4HandRank := 8.14
     else
     if i4s = 4 then
        rP4HandRank := 8.13
     else
     if i3s = 4 then
        rP4HandRank := 8.12
     else
     if i2s = 4 then
        rP4HandRank := 8.11

        else
        //3 of a kind
     if iAs = 3 then
      begin
        rP4HandRank := 3.22;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP4HandRank;
      end
     else
     if iKs = 3 then
       begin
        rP4HandRank := 3.21;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP4HandRank;
      end
     else
     if iJs = 3 then
       begin
        rP4HandRank := 3.20;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP4HandRank;
      end
     else
     if i10s = 3 then
       begin
        rP4HandRank := 3.19;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP4HandRank;
      end
     else
     if i9s = 3 then
       begin
        rP4HandRank := 3.18;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP4HandRank;
      end
     else
     if i8s = 3 then
        begin
        rP4HandRank := 3.17;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP4HandRank;
      end
     else
     if i7s = 3 then
        begin
        rP4HandRank := 3.16;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP4HandRank;
      end
     else
     if i6s = 3 then
        begin
        rP4HandRank := 3.15;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP4HandRank;
      end
     else
     if i5s = 3 then
        begin
        rP4HandRank := 3.14;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP4HandRank;
      end
     else
     if i4s = 3 then
        begin
        rP4HandRank := 3.13;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP4HandRank;
      end
     else
     if i3s = 3 then
        begin
        rP4HandRank := 3.12;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP4HandRank;
      end
     else
     if i2s = 3 then
        begin
        rP4HandRank := 3.11;
        b3OAK := True;
        r3OAKValue := r3OAKValue + rP4HandRank;
      end;



        //Pair  or Two-Pair
     if iAs = 2 then
     begin
        rP4HandRank := 2.22;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP4HandRank;
     end;
     if iKs = 2 then
       begin
        rP4HandRank := 2.21;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP4HandRank;
     end;

     if iJs = 2 then
        begin
        rP4HandRank := 2.20;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP4HandRank;
     end;

     if i10s = 2 then
        begin
        rP4HandRank := 2.19;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP4HandRank;
     end;

     if i9s = 2 then
        begin
        rP4HandRank := 2.18;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP4HandRank;
     end;

     if i8s = 2 then
       begin
        rP4HandRank := 2.17;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP4HandRank;
     end;

     if i7s = 2 then
        begin
        rP4HandRank := 2.16;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP4HandRank;
     end;

     if i6s = 2 then
        begin
        rP4HandRank := 2.15;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP4HandRank;
     end;

     if i5s = 2 then
        begin
        rP4HandRank := 2.14;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP4HandRank;
     end;

     if i4s = 2 then
        begin
        rP4HandRank := 2.13;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP4HandRank;
     end;

     if i3s = 2 then
         begin
        rP4HandRank := 2.12;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP4HandRank;
     end;

     if i2s = 2 then
        begin
        rP4HandRank := 2.11;
        Inc(iNumPairs);
        rTwoPairValue := rTwoPairValue + rP4HandRank;
     end;


     //Implements Hands

   // Royal Flush
    if (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iHearts >= 5)) or (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iDiamonds >= 5)) or (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iSpades >= 5)) or (((i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0))  and (iClubs >= 5)) then
    begin
      rP4HandRank := 10;
    end
    else

      //Straight Flush
    if (((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iHearts >= 5)) or (((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iDiamonds >= 5)) or (((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iSpades >= 5)) or(((iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0)) and (iClubs >= 5))  then
    begin
      rP4HandRank := 9.11;
    end
    else
    if (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iHearts >= 5)) or (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iDiamonds >= 5)) or (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iSpades >= 5)) or (((i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0)) and (iClubs >= 5))   then
    begin
      rP4HandRank := 9.12;
    end
    else
    if (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iHearts >= 5)) or (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iDiamonds >= 0)) or (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iSpades >= 5)) or (((i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0)) and (iClubs >= 5)) then
    begin
      rP4HandRank := 9.13;
    end
    else
    if (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iHearts >= 5)) or (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iDiamonds >= 5)) or (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iSpades >= 5)) or (((i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0)) and (iClubs >= 5)) then
    begin
      rP4HandRank := 9.14;
    end
    else
    if (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iHearts >= 5)) or (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iDiamonds >= 5)) or (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iSpades >= 5)) or (((i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0)) and (iClubs >= 5)) then
    begin
      rP4HandRank := 9.15;
    end
    else
    if (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iHearts >= 5)) or (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iDiamonds >= 5)) or (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iSpades >= 5)) or (((i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0)) and (iClubs >= 5)) then
    begin
      rP4HandRank := 9.16;
    end
    else
    if (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iHearts >= 5)) or (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iDiamonds >= 5)) or (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iSpades >= 5)) or (((i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0)) and (iClubs >= 5)) then
    begin
      rP4HandRank := 9.17;
    end
    else
    if (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iHearts >= 5)) or (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iDiamonds >= 5)) or (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iSpades >= 5)) or (((i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0)) and (iClubs >= 5)) then
    begin
      rP4HandRank := 9.18;
    end
    else
    if (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iHearts >= 5)) or (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iDiamonds >= 5)) or (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iSpades >= 5)) or (((i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0)) and (iClubs >= 5)) then
    begin
      rP4HandRank := 9.19;
    end
    else



      //Flush
    if (iHearts >= 5) or (iSpades >= 5) or (iDiamonds >= 5) or (iClubs >= 5) then
      rP4HandRank := 6
      else



     //Full House
    if (b3OAK) and (iNumPairs >= 1) then
      rP4HandRank := r3OAKValue + rP4HandRank + 2
    else


   //Straight
    if (iAs > 0) and (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) then
    begin
      rP4HandRank := 5.11;
    end
    else
    if (i2s > 0) and (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) then
    begin
      rP4HandRank := 5.12;
    end
    else
    if (i3s > 0) and (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) then
    begin
      rP4HandRank := 5.13;
    end
    else
    if (i4s > 0) and (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) then
    begin
      rP4HandRank := 5.14;
    end
    else
    if (i5s > 0) and (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) then
    begin
      rP4HandRank := 5.15;
    end
    else
    if (i6s > 0) and (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) then
    begin
      rP4HandRank := 5.16;
    end
    else
    if (i7s > 0) and (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) then
    begin
      rP4HandRank := 5.17;
    end
    else
    if (i8s > 0) and (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) then
    begin
      rP4HandRank := 5.18;
    end
    else
    if (i9s > 0) and (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) then
    begin
      rP4HandRank := 5.19;
    end
    else
    if (i10s > 0) and (iJs > 0) and (iQs > 0) and (iKs > 0) and (iAs > 0) then
    begin
      rP4HandRank := 5.20;
    end
    else


     //Two-Pair
    if iNumPairs >= 2 then
      rP4HandRank := rTwoPairValue;

      //High Card
     if rP4HandRank = 0 then
      begin
        //Cards 1
        if sP4C1Num = '2' then
        rP4C1Value := 1.11
        else
        if sP4C1Num = '3' then
        rP4C1Value := 1.12
        else
        if sP4C1Num = '4' then
        rP4C1Value := 1.13
        else
        if sP4C1Num = '5' then
        rP4C1Value := 1.14
        else
        if sP4C1Num = '6' then
        rP4C1Value := 1.15
        else
        if sP4C1Num = '7' then
        rP4C1Value := 1.16
        else
        if sP4C1Num = '8' then
        rP4C1Value := 1.17
        else
        if sP4C1Num = '9' then
        rP4C1Value := 1.18
        else
        if sP4C1Num = '10' then
        rP4C1Value := 1.19
        else
        if sP4C1Num = 'J' then
        rP4C1Value := 1.20
        else
        if sP4C1Num = 'Q' then
        rP4C1Value := 1.21
        else
        if sP4C1Num = 'K' then
        rP4C1Value := 1.22
        else
        if sP4C1Num = 'A' then
        rP4C1Value := 1.23;

        //Cards 2
        if sP4C2Num = '2' then
        rP4C2Value := 1.11
        else
        if sP4C2Num = '3' then
        rP4C2Value := 1.12
        else
        if sP4C2Num = '4' then
        rP4C2Value := 1.13
        else
        if sP4C2Num = '5' then
        rP4C2Value := 1.14
        else
        if sP4C2Num = '6' then
        rP4C2Value := 1.15
        else
        if sP4C2Num = '7' then
        rP4C2Value := 1.16
        else
        if sP4C2Num = '8' then
        rP4C2Value := 1.17
        else
        if sP4C2Num = '9' then
        rP4C2Value := 1.18
        else
        if sP4C2Num = '10' then
        rP4C2Value := 1.19
        else
        if sP4C2Num = 'J' then
        rP4C2Value := 1.20
        else
        if sP4C2Num = 'Q' then
        rP4C2Value := 1.21
        else
        if sP4C2Num = 'K' then
        rP4C2Value := 1.22
        else
        if sP4C2Num = 'A' then
        rP4C2Value := 1.23;


        if rP4C1Value > rP4C2Value then
          rP4HandRank := rP4C1Value
        else
        if rP4C2Value > rP4C1Value then
          rP4HandRank := rP4C2Value;

      end;

  end

end;

procedure TfrmBaseGameLVM.Flop;
begin
   lblOption1.Visible := False;
   lblOption3.Visible := False;
   lblOption2.Caption := '- Reveal Flop';
end;

procedure TfrmBaseGameLVM.FormActivate(Sender: TObject);
begin

     //Convert other forms vaiables into variables for ths form for easier use
     iNumPlayers := frmPokerLVM.iNumPlayers;
     bMultiPlayer := frmPokerLVM.bMultiPlayer;
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

  bFoldP1 := False;
  bFoldP2 := False;
  bFoldP3 := False;
  bFoldP4 := False;
  bCall := False;
  iCheck := 0;
  iNumFold := 0;
  rRaise := 0;
  iRound := 0;
  iCount := 0;
  bFlop1 := False;
  bFlop2 := False;
  bFlop3 := False;
  bTurn  := False;
  bRiver := False;


  MessageDlg('Play by selecting from a number of options found in the bottom right corner. Good Luck!',mtInformation,[mbOK],0);

end;

procedure TfrmBaseGameLVM.GetCardInfo(sCardNum: string);
  var
  sSuit, sCardNumb : string;
begin

      if sCardNum = '1' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := '2';
      end
      else
      if sCardNum = '2' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := '3';
      end
      else
      if sCardNum = '3' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := '4';
      end
      else
      if sCardNum = '4' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := '5';
      end
      else
      if sCardNum = '5' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := '6';
      end
      else
      if sCardNum = '6' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := '7';
      end
      else
      if sCardNum = '7' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := '8';
      end
      else
      if sCardNum = '8' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := '9';
      end
      else
      if sCardNum = '9' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := '10';
      end
      else
      if sCardNum = '10' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := 'J';
      end
      else
      if sCardNum = '11' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := 'Q';
      end
      else
      if sCardNum = '12' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := 'K';
      end
      else
      if sCardNum = '13' then
      begin
        Inc(iCount);
        sSuit := 'Clubs';
        sCardNumb := 'A';
      end
      else
      if sCardNum = '14' then
      begin
        Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := '2';
      end
      else
      if sCardNum = '15' then
      begin
        Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := '3';
      end
      else
      if sCardNum = '16' then
      begin
        Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := '4';
      end
      else
      if sCardNum = '17' then
      begin
        Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := '5';
      end
      else
      if sCardNum = '18' then
      begin
       Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := '6';
      end
      else
      if sCardNum = '19' then
      begin
       Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := '7';
      end
      else
      if sCardNum = '20' then
      begin
        Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := '8';
      end
      else
      if sCardNum = '21' then
      begin
        Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := '9';
      end
      else
      if sCardNum = '22' then
      begin
        Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := '10';
      end
      else
      if sCardNum = '23' then
      begin
       Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := 'J';
      end
      else
      if sCardNum = '24' then
      begin
        Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := 'Q';
      end
      else
      if sCardNum = '25' then
      begin
        Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := 'K';
      end
      else
      if sCardNum = '26' then
      begin
        Inc(iCount);
        sSuit := 'Diamonds';
        sCardNumb := 'A';
      end
      else
      if sCardNum = '27' then
      begin
        Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := '2';
      end
      else
      if sCardNum = '28' then
      begin
        Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := '3';
      end
      else
      if sCardNum = '29' then
      begin
       Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := '4';
      end
      else
      if sCardNum = '30' then
      begin
        Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := '5';
      end
      else
      if sCardNum = '31' then
      begin
        Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := '6';
      end
      else
      if sCardNum = '32' then
      begin
        Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := '7';
      end
      else
      if sCardNum = '33' then
      begin
       Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := '8';
      end
      else
      if sCardNum = '34' then
      begin
        Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := '9';
      end
      else
      if sCardNum = '35' then
      begin
       Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := '10';
      end
      else
      if sCardNum = '36' then
      begin
       Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := 'J';
      end
      else
      if sCardNum = '37' then
      begin
       Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := 'Q';
      end
      else
      if sCardNum = '38' then
      begin
       Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := 'K';
      end
      else
      if sCardNum = '39' then
      begin
       Inc(iCount);
        sSuit := 'Hearts';
        sCardNumb := 'A';
      end
      else
      if sCardNum = '40' then
      begin
       Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := '2';
      end
      else
      if sCardNum = '41' then
      begin
        Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := '3';
      end
      else
      if sCardNum = '42' then
      begin
        Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := '4';
      end
      else
      if sCardNum = '43' then
      begin
        Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := '5';
      end
      else
      if sCardNum = '44' then
      begin
       Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := '6';
      end
      else
      if sCardNum = '45' then
      begin
        Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := '7';
      end
      else
      if sCardNum = '46' then
      begin
       Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := '8';
      end
      else
      if sCardNum = '47' then
      begin
        Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := '9';
      end
      else
      if sCardNum = '48' then
      begin
        Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := '10';
      end
      else
      if sCardNum = '49' then
      begin
        Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := 'J';
      end
      else
      if sCardNum = '50' then
      begin
        Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := 'Q';
      end
      else
      if sCardNum = '51' then
      begin
       Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := 'K';
      end
      else
      if sCardNum = '52' then
      begin
        Inc(iCount);
        sSuit := 'Spades';
        sCardNumb := 'A';
      end;

   //Placment into variables
  if iCount = 1 then
    begin
      sCC1Suit := sSuit;
      sCC1Num := sCardNumb;
    end
    else
  if iCount = 2 then
    begin
      sCC2Suit := sSuit;
      sCC2Num := sCardNumb;
    end
    else
  if iCount = 3 then
    begin
      sCC3Suit := sSuit;
      sCC3Num := sCardNumb;
    end
    else
  if iCount = 4 then
    begin
      sCC4Suit := sSuit;
      sCC4Num := sCardNumb;
    end
    else
  if iCount = 5 then
    begin
      sCC5Suit := sSuit;
      sCC5Num := sCardNumb;
    end;



 if (iNumPlayers = 4) or (iNumPlayers = 1)  then
 begin
     if iCount = 6 then
    begin
      sP1C1Suit := sSuit;
      sP1C1Num := sCardNumb;
    end
    else
  if iCount = 7 then
    begin
       sP1C2Suit := sSuit;
      sP1C2Num := sCardNumb;
    end
    else
  if iCount = 8 then
    begin
      sP2C1Suit := sSuit;
      sP2C1Num := sCardNumb;
    end
    else
  if iCount = 9 then
    begin
      sP2C2Suit := sSuit;
      sP2C2Num := sCardNumb;
    end
    else
  if iCount = 10 then
    begin
      sP3C1Suit := sSuit;
      sP3C1Num := sCardNumb;
    end
  else
  if iCount = 11 then
    begin
      sP3C2Suit := sSuit;
      sP3C2Num := sCardNumb;
    end
    else
  if iCount = 12 then
    begin
      sP4C1Suit := sSuit;
      sP4C1Num := sCardNumb;
    end
    else
  if iCount = 13 then
    begin
      sP4C2Suit := sSuit;
      sP4C2Num := sCardNumb;
    end;

   end
   else
   if iNumPlayers = 3 then
 begin
     if iCount = 6 then
    begin
      sP1C1Suit := sSuit;
      sP1C1Num := sCardNumb;
    end
    else
  if iCount = 7 then
    begin
       sP1C2Suit := sSuit;
      sP1C2Num := sCardNumb;
    end
    else
  if iCount = 8 then
    begin
      sP2C1Suit := sSuit;
      sP2C1Num := sCardNumb;
    end
    else
  if iCount = 9 then
    begin
      sP2C2Suit := sSuit;
      sP2C2Num := sCardNumb;
    end
    else
  if iCount = 10 then
    begin
      sP3C1Suit := sSuit;
      sP3C1Num := sCardNumb;
    end
  else
  if iCount = 11 then
    begin
      sP3C2Suit := sSuit;
      sP3C2Num := sCardNumb;
    end;
   end
   else
 if iNumPlayers = 2 then
 begin
     if iCount = 6 then
    begin
      sP1C1Suit := sSuit;
      sP1C1Num := sCardNumb;
    end
    else
  if iCount = 7 then
    begin
       sP1C2Suit := sSuit;
      sP1C2Num := sCardNumb;
    end
    else
  if iCount = 8 then
    begin
      sP2C1Suit := sSuit;
      sP2C1Num := sCardNumb;
    end
    else
  if iCount = 9 then
    begin
      sP2C2Suit := sSuit;
      sP2C2Num := sCardNumb;
    end;
   end;



  end;


procedure TfrmBaseGameLVM.Kickers;
  var
  rP1C1Kicker,  rP1C2Kicker,  rP2C1Kicker,  rP2C2Kicker, rP1Kicker, rP2Kicker, rP3C1Kicker,  rP3C2Kicker,  rP4C1Kicker,  rP4C2Kicker, rP3Kicker, rP4Kicker  : Real;
begin
  if iNumPlayers = 2 then
  begin
  // P1
  //Cards 1
        if sP1C1Num = '2' then
        rP1C1Kicker:= 1.11
        else
        if sP1C1Num = '3' then
        rP1C1Kicker := 1.12
        else
        if sP1C1Num = '4' then
        rP1C1Kicker := 1.13
        else
        if sP1C1Num = '5' then
        rP1C1Kicker := 1.14
        else
        if sP1C1Num = '6' then
        rP1C1Kicker := 1.15
        else
        if sP1C1Num = '7' then
        rP1C1Kicker := 1.16
        else
        if sP1C1Num = '8' then
        rP1C1Kicker := 1.17
        else
        if sP1C1Num = '9' then
        rP1C1Kicker := 1.18
        else
        if sP1C1Num = '10' then
        rP1C1Kicker := 1.19
        else
        if sP1C1Num = 'J' then
        rP1C1Kicker := 1.20
        else
        if sP1C1Num = 'Q' then
        rP1C1Kicker := 1.21
        else
        if sP1C1Num = 'K' then
        rP1C1Kicker := 1.22
        else
        if sP1C1Num = 'A' then
        rP1C1Kicker := 1.23;

        //Cards 2
        if sP1C2Num = '2' then
        rP1C2Kicker := 1.11
        else
        if sP1C2Num = '3' then
        rP1C2Kicker := 1.12
        else
        if sP1C2Num = '4' then
        rP1C2Kicker := 1.13
        else
        if sP1C2Num = '5' then
        rP1C2Kicker := 1.14
        else
        if sP1C2Num = '6' then
        rP1C2Kicker := 1.15
        else
        if sP1C2Num = '7' then
        rP1C2Kicker := 1.16
        else
        if sP1C2Num = '8' then
        rP1C2Kicker := 1.17
        else
        if sP1C2Num = '9' then
        rP1C2Kicker := 1.18
        else
        if sP1C2Num = '10' then
        rP1C2Kicker := 1.19
        else
        if sP1C2Num = 'J' then
        rP1C2Kicker := 1.20
        else
        if sP1C2Num = 'Q' then
        rP1C2Kicker := 1.21
        else
        if sP1C2Num = 'K' then
        rP1C2Kicker := 1.22
        else
        if sP1C2Num = 'A' then
        rP1C2Kicker := 1.23;


        if rP1C1Kicker > rP1C2Kicker then
          rP1Kicker := rP1C1Kicker
        else
        if rP1C2Kicker > rP1C1Kicker then
          rP1Kicker := rP1C2Kicker;

   // P2
  //Cards 1
        if sP2C1Num = '2' then
        rP2C1Kicker:= 1.11
        else
        if sP2C1Num = '3' then
        rP2C1Kicker := 1.12
        else
        if sP2C1Num = '4' then
        rP2C1Kicker := 1.13
        else
        if sP2C1Num = '5' then
        rP2C1Kicker := 1.14
        else
        if sP2C1Num = '6' then
        rP2C1Kicker := 1.15
        else
        if sP2C1Num = '7' then
        rP2C1Kicker := 1.16
        else
        if sP2C1Num = '8' then
        rP2C1Kicker := 1.17
        else
        if sP2C1Num = '9' then
        rP2C1Kicker := 1.18
        else
        if sP2C1Num = '10' then
        rP2C1Kicker := 1.19
        else
        if sP2C1Num = 'J' then
        rP2C1Kicker := 1.20
        else
        if sP2C1Num = 'Q' then
        rP2C1Kicker := 1.21
        else
        if sP2C1Num = 'K' then
        rP2C1Kicker := 1.22
        else
        if sP2C1Num = 'A' then
        rP2C1Kicker := 1.23;

        //Cards 2
        if sP2C2Num = '2' then
        rP2C2Kicker := 1.11
        else
        if sP2C2Num = '3' then
        rP2C2Kicker := 1.12
        else
        if sP2C2Num = '4' then
        rP2C2Kicker := 1.13
        else
        if sP2C2Num = '5' then
        rP2C2Kicker := 1.14
        else
        if sP2C2Num = '6' then
        rP1C2Kicker := 1.15
        else
        if sP2C2Num = '7' then
        rP1C2Kicker := 1.16
        else
        if sP2C2Num = '8' then
        rP1C2Kicker := 1.17
        else
        if sP2C2Num = '9' then
        rP1C2Kicker := 1.18
        else
        if sP2C2Num = '10' then
        rP1C2Kicker := 1.19
        else
        if sP2C2Num = 'J' then
        rP1C2Kicker := 1.20
        else
        if sP2C2Num = 'Q' then
        rP1C2Kicker := 1.21
        else
        if sP2C2Num = 'K' then
        rP1C2Kicker := 1.22
        else
        if sP2C2Num = 'A' then
        rP1C2Kicker := 1.23;


        if rP2C1Kicker > rP2C2Kicker then
          rP2Kicker := rP2C1Kicker
        else
        if rP2C2Kicker > rP2C1Kicker then
          rP2Kicker := rP2C2Kicker;


    //Winner
    if rP1Kicker > rP2Kicker then
          sWinner := sPlayer1
        else
        if rP2Kicker > rP1Kicker then
           sWinner := sPlayer2;
  end
  else
  if iNumPlayers = 3 then
  begin
   //  P1
  //Cards 1
        if sP1C1Num = '2' then
        rP1C1Kicker:= 1.11
        else
        if sP1C1Num = '3' then
        rP1C1Kicker := 1.12
        else
        if sP1C1Num = '4' then
        rP1C1Kicker := 1.13
        else
        if sP1C1Num = '5' then
        rP1C1Kicker := 1.14
        else
        if sP1C1Num = '6' then
        rP1C1Kicker := 1.15
        else
        if sP1C1Num = '7' then
        rP1C1Kicker := 1.16
        else
        if sP1C1Num = '8' then
        rP1C1Kicker := 1.17
        else
        if sP1C1Num = '9' then
        rP1C1Kicker := 1.18
        else
        if sP1C1Num = '10' then
        rP1C1Kicker := 1.19
        else
        if sP1C1Num = 'J' then
        rP1C1Kicker := 1.20
        else
        if sP1C1Num = 'Q' then
        rP1C1Kicker := 1.21
        else
        if sP1C1Num = 'K' then
        rP1C1Kicker := 1.22
        else
        if sP1C1Num = 'A' then
        rP1C1Kicker := 1.23;

        //Cards 2
        if sP1C2Num = '2' then
        rP1C2Kicker := 1.11
        else
        if sP1C2Num = '3' then
        rP1C2Kicker := 1.12
        else
        if sP1C2Num = '4' then
        rP1C2Kicker := 1.13
        else
        if sP1C2Num = '5' then
        rP1C2Kicker := 1.14
        else
        if sP1C2Num = '6' then
        rP1C2Kicker := 1.15
        else
        if sP1C2Num = '7' then
        rP1C2Kicker := 1.16
        else
        if sP1C2Num = '8' then
        rP1C2Kicker := 1.17
        else
        if sP1C2Num = '9' then
        rP1C2Kicker := 1.18
        else
        if sP1C2Num = '10' then
        rP1C2Kicker := 1.19
        else
        if sP1C2Num = 'J' then
        rP1C2Kicker := 1.20
        else
        if sP1C2Num = 'Q' then
        rP1C2Kicker := 1.21
        else
        if sP1C2Num = 'K' then
        rP1C2Kicker := 1.22
        else
        if sP1C2Num = 'A' then
        rP1C2Kicker := 1.23;


        if rP1C1Kicker > rP1C2Kicker then
          rP1Kicker := rP1C1Kicker
        else
        if rP1C2Kicker > rP1C1Kicker then
          rP1Kicker := rP1C2Kicker;

   // P2
  //Cards 1
        if sP2C1Num = '2' then
        rP2C1Kicker:= 1.11
        else
        if sP2C1Num = '3' then
        rP2C1Kicker := 1.12
        else
        if sP2C1Num = '4' then
        rP2C1Kicker := 1.13
        else
        if sP2C1Num = '5' then
        rP2C1Kicker := 1.14
        else
        if sP2C1Num = '6' then
        rP2C1Kicker := 1.15
        else
        if sP2C1Num = '7' then
        rP2C1Kicker := 1.16
        else
        if sP2C1Num = '8' then
        rP2C1Kicker := 1.17
        else
        if sP2C1Num = '9' then
        rP2C1Kicker := 1.18
        else
        if sP2C1Num = '10' then
        rP2C1Kicker := 1.19
        else
        if sP2C1Num = 'J' then
        rP2C1Kicker := 1.20
        else
        if sP2C1Num = 'Q' then
        rP2C1Kicker := 1.21
        else
        if sP2C1Num = 'K' then
        rP2C1Kicker := 1.22
        else
        if sP2C1Num = 'A' then
        rP2C1Kicker := 1.23;

        //Cards 2
        if sP2C2Num = '2' then
        rP2C2Kicker := 1.11
        else
        if sP2C2Num = '3' then
        rP2C2Kicker := 1.12
        else
        if sP2C2Num = '4' then
        rP2C2Kicker := 1.13
        else
        if sP2C2Num = '5' then
        rP2C2Kicker := 1.14
        else
        if sP2C2Num = '6' then
        rP1C2Kicker := 1.15
        else
        if sP2C2Num = '7' then
        rP1C2Kicker := 1.16
        else
        if sP2C2Num = '8' then
        rP1C2Kicker := 1.17
        else
        if sP2C2Num = '9' then
        rP1C2Kicker := 1.18
        else
        if sP2C2Num = '10' then
        rP1C2Kicker := 1.19
        else
        if sP2C2Num = 'J' then
        rP1C2Kicker := 1.20
        else
        if sP2C2Num = 'Q' then
        rP1C2Kicker := 1.21
        else
        if sP2C2Num = 'K' then
        rP1C2Kicker := 1.22
        else
        if sP2C2Num = 'A' then
        rP1C2Kicker := 1.23;


        if rP2C1Kicker > rP2C2Kicker then
          rP2Kicker := rP2C1Kicker
        else
        if rP2C2Kicker > rP2C1Kicker then
          rP2Kicker := rP2C2Kicker;

   // P3
  //Cards 1
        if sP3C1Num = '2' then
        rP3C1Kicker:= 1.11
        else
        if sP3C1Num = '3' then
        rP3C1Kicker := 1.12
        else
        if sP3C1Num = '4' then
        rP3C1Kicker := 1.13
        else
        if sP3C1Num = '5' then
        rP3C1Kicker := 1.14
        else
        if sP3C1Num = '6' then
        rP3C1Kicker := 1.15
        else
        if sP3C1Num = '7' then
        rP3C1Kicker := 1.16
        else
        if sP3C1Num = '8' then
        rP3C1Kicker := 1.17
        else
        if sP3C1Num = '9' then
        rP3C1Kicker := 1.18
        else
        if sP3C1Num = '10' then
        rP3C1Kicker := 1.19
        else
        if sP3C1Num = 'J' then
        rP3C1Kicker := 1.20
        else
        if sP3C1Num = 'Q' then
        rP3C1Kicker := 1.21
        else
        if sP3C1Num = 'K' then
        rP3C1Kicker := 1.22
        else
        if sP3C1Num = 'A' then
        rP3C1Kicker := 1.23;

        //Cards 2
        if sP3C2Num = '2' then
        rP3C2Kicker := 1.11
        else
        if sP3C2Num = '3' then
        rP3C2Kicker := 1.12
        else
        if sP3C2Num = '4' then
        rP3C2Kicker := 1.13
        else
        if sP3C2Num = '5' then
        rP3C2Kicker := 1.14
        else
        if sP3C2Num = '6' then
        rP3C2Kicker := 1.15
        else
        if sP3C2Num = '7' then
        rP3C2Kicker := 1.16
        else
        if sP3C2Num = '8' then
        rP3C2Kicker := 1.17
        else
        if sP3C2Num = '9' then
        rP3C2Kicker := 1.18
        else
        if sP3C2Num = '10' then
        rP3C2Kicker := 1.19
        else
        if sP3C2Num = 'J' then
        rP3C2Kicker := 1.20
        else
        if sP3C2Num = 'Q' then
        rP3C2Kicker := 1.21
        else
        if sP3C2Num = 'K' then
        rP3C2Kicker := 1.22
        else
        if sP3C2Num = 'A' then
        rP3C2Kicker := 1.23;


        if rP3C1Kicker > rP3C2Kicker then
          rP3Kicker := rP3C1Kicker
        else
        if rP3C2Kicker > rP3C1Kicker then
          rP3Kicker := rP3C2Kicker;

    //Winner
    if (rP1Kicker > rP2Kicker) and (rP1Kicker > rP3Kicker) then
          sWinner := sPlayer1
        else
        if (rP2Kicker > rP1Kicker) and (rP2Kicker > rP3Kicker) then
           sWinner := sPlayer2
           else
           if (rP3Kicker > rP1Kicker) and (rP3Kicker > rP2Kicker) then
            sWinner := sPlayer3;
  end
  else
  if (iNumPlayers = 4) or (iNumPlayers = 4) then
  begin
    //  P1
  //Cards 1
        if sP1C1Num = '2' then
        rP1C1Kicker:= 1.11
        else
        if sP1C1Num = '3' then
        rP1C1Kicker := 1.12
        else
        if sP1C1Num = '4' then
        rP1C1Kicker := 1.13
        else
        if sP1C1Num = '5' then
        rP1C1Kicker := 1.14
        else
        if sP1C1Num = '6' then
        rP1C1Kicker := 1.15
        else
        if sP1C1Num = '7' then
        rP1C1Kicker := 1.16
        else
        if sP1C1Num = '8' then
        rP1C1Kicker := 1.17
        else
        if sP1C1Num = '9' then
        rP1C1Kicker := 1.18
        else
        if sP1C1Num = '10' then
        rP1C1Kicker := 1.19
        else
        if sP1C1Num = 'J' then
        rP1C1Kicker := 1.20
        else
        if sP1C1Num = 'Q' then
        rP1C1Kicker := 1.21
        else
        if sP1C1Num = 'K' then
        rP1C1Kicker := 1.22
        else
        if sP1C1Num = 'A' then
        rP1C1Kicker := 1.23;

        //Cards 2
        if sP1C2Num = '2' then
        rP1C2Kicker := 1.11
        else
        if sP1C2Num = '3' then
        rP1C2Kicker := 1.12
        else
        if sP1C2Num = '4' then
        rP1C2Kicker := 1.13
        else
        if sP1C2Num = '5' then
        rP1C2Kicker := 1.14
        else
        if sP1C2Num = '6' then
        rP1C2Kicker := 1.15
        else
        if sP1C2Num = '7' then
        rP1C2Kicker := 1.16
        else
        if sP1C2Num = '8' then
        rP1C2Kicker := 1.17
        else
        if sP1C2Num = '9' then
        rP1C2Kicker := 1.18
        else
        if sP1C2Num = '10' then
        rP1C2Kicker := 1.19
        else
        if sP1C2Num = 'J' then
        rP1C2Kicker := 1.20
        else
        if sP1C2Num = 'Q' then
        rP1C2Kicker := 1.21
        else
        if sP1C2Num = 'K' then
        rP1C2Kicker := 1.22
        else
        if sP1C2Num = 'A' then
        rP1C2Kicker := 1.23;


        if rP1C1Kicker > rP1C2Kicker then
          rP1Kicker := rP1C1Kicker
        else
        if rP1C2Kicker > rP1C1Kicker then
          rP1Kicker := rP1C2Kicker;

   // P2
  //Cards 1
        if sP2C1Num = '2' then
        rP2C1Kicker:= 1.11
        else
        if sP2C1Num = '3' then
        rP2C1Kicker := 1.12
        else
        if sP2C1Num = '4' then
        rP2C1Kicker := 1.13
        else
        if sP2C1Num = '5' then
        rP2C1Kicker := 1.14
        else
        if sP2C1Num = '6' then
        rP2C1Kicker := 1.15
        else
        if sP2C1Num = '7' then
        rP2C1Kicker := 1.16
        else
        if sP2C1Num = '8' then
        rP2C1Kicker := 1.17
        else
        if sP2C1Num = '9' then
        rP2C1Kicker := 1.18
        else
        if sP2C1Num = '10' then
        rP2C1Kicker := 1.19
        else
        if sP2C1Num = 'J' then
        rP2C1Kicker := 1.20
        else
        if sP2C1Num = 'Q' then
        rP2C1Kicker := 1.21
        else
        if sP2C1Num = 'K' then
        rP2C1Kicker := 1.22
        else
        if sP2C1Num = 'A' then
        rP2C1Kicker := 1.23;

        //Cards 2
        if sP2C2Num = '2' then
        rP2C2Kicker := 1.11
        else
        if sP2C2Num = '3' then
        rP2C2Kicker := 1.12
        else
        if sP2C2Num = '4' then
        rP2C2Kicker := 1.13
        else
        if sP2C2Num = '5' then
        rP2C2Kicker := 1.14
        else
        if sP2C2Num = '6' then
        rP1C2Kicker := 1.15
        else
        if sP2C2Num = '7' then
        rP1C2Kicker := 1.16
        else
        if sP2C2Num = '8' then
        rP1C2Kicker := 1.17
        else
        if sP2C2Num = '9' then
        rP1C2Kicker := 1.18
        else
        if sP2C2Num = '10' then
        rP1C2Kicker := 1.19
        else
        if sP2C2Num = 'J' then
        rP1C2Kicker := 1.20
        else
        if sP2C2Num = 'Q' then
        rP1C2Kicker := 1.21
        else
        if sP2C2Num = 'K' then
        rP1C2Kicker := 1.22
        else
        if sP2C2Num = 'A' then
        rP1C2Kicker := 1.23;


        if rP2C1Kicker > rP2C2Kicker then
          rP2Kicker := rP2C1Kicker
        else
        if rP2C2Kicker > rP2C1Kicker then
          rP2Kicker := rP2C2Kicker;

   // P3
  //Cards 1
        if sP3C1Num = '2' then
        rP3C1Kicker:= 1.11
        else
        if sP3C1Num = '3' then
        rP3C1Kicker := 1.12
        else
        if sP3C1Num = '4' then
        rP3C1Kicker := 1.13
        else
        if sP3C1Num = '5' then
        rP3C1Kicker := 1.14
        else
        if sP3C1Num = '6' then
        rP3C1Kicker := 1.15
        else
        if sP3C1Num = '7' then
        rP3C1Kicker := 1.16
        else
        if sP3C1Num = '8' then
        rP3C1Kicker := 1.17
        else
        if sP3C1Num = '9' then
        rP3C1Kicker := 1.18
        else
        if sP3C1Num = '10' then
        rP3C1Kicker := 1.19
        else
        if sP3C1Num = 'J' then
        rP3C1Kicker := 1.20
        else
        if sP3C1Num = 'Q' then
        rP3C1Kicker := 1.21
        else
        if sP3C1Num = 'K' then
        rP3C1Kicker := 1.22
        else
        if sP3C1Num = 'A' then
        rP3C1Kicker := 1.23;

        //Cards 2
        if sP3C2Num = '2' then
        rP3C2Kicker := 1.11
        else
        if sP3C2Num = '3' then
        rP3C2Kicker := 1.12
        else
        if sP3C2Num = '4' then
        rP3C2Kicker := 1.13
        else
        if sP3C2Num = '5' then
        rP3C2Kicker := 1.14
        else
        if sP3C2Num = '6' then
        rP3C2Kicker := 1.15
        else
        if sP3C2Num = '7' then
        rP3C2Kicker := 1.16
        else
        if sP3C2Num = '8' then
        rP3C2Kicker := 1.17
        else
        if sP3C2Num = '9' then
        rP3C2Kicker := 1.18
        else
        if sP3C2Num = '10' then
        rP3C2Kicker := 1.19
        else
        if sP3C2Num = 'J' then
        rP3C2Kicker := 1.20
        else
        if sP3C2Num = 'Q' then
        rP3C2Kicker := 1.21
        else
        if sP3C2Num = 'K' then
        rP3C2Kicker := 1.22
        else
        if sP3C2Num = 'A' then
        rP3C2Kicker := 1.23;


        if rP3C1Kicker > rP3C2Kicker then
          rP3Kicker := rP3C1Kicker
        else
        if rP3C2Kicker > rP3C1Kicker then
          rP3Kicker := rP3C2Kicker;
   // P4
  //Cards 1
        if sP4C1Num = '2' then
        rP4C1Kicker:= 1.11
        else
        if sP4C1Num = '3' then
        rP4C1Kicker := 1.12
        else
        if sP4C1Num = '4' then
        rP4C1Kicker := 1.13
        else
        if sP4C1Num = '5' then
        rP4C1Kicker := 1.14
        else
        if sP4C1Num = '6' then
        rP4C1Kicker := 1.15
        else
        if sP4C1Num = '7' then
        rP4C1Kicker := 1.16
        else
        if sP4C1Num = '8' then
        rP4C1Kicker := 1.17
        else
        if sP4C1Num = '9' then
        rP4C1Kicker := 1.18
        else
        if sP4C1Num = '10' then
        rP4C1Kicker := 1.19
        else
        if sP4C1Num = 'J' then
        rP4C1Kicker := 1.20
        else
        if sP4C1Num = 'Q' then
        rP4C1Kicker := 1.21
        else
        if sP4C1Num = 'K' then
        rP4C1Kicker := 1.22
        else
        if sP4C1Num = 'A' then
        rP4C1Kicker := 1.23;

        //Cards 2
        if sP4C2Num = '2' then
        rP4C2Kicker := 1.11
        else
        if sP4C2Num = '3' then
        rP4C2Kicker := 1.12
        else
        if sP4C2Num = '4' then
        rP4C2Kicker := 1.13
        else
        if sP4C2Num = '5' then
        rP4C2Kicker := 1.14
        else
        if sP4C2Num = '6' then
        rP4C2Kicker := 1.15
        else
        if sP4C2Num = '7' then
        rP4C2Kicker := 1.16
        else
        if sP4C2Num = '8' then
        rP4C2Kicker := 1.17
        else
        if sP4C2Num = '9' then
        rP4C2Kicker := 1.18
        else
        if sP4C2Num = '10' then
        rP4C2Kicker := 1.19
        else
        if sP4C2Num = 'J' then
        rP4C2Kicker := 1.20
        else
        if sP4C2Num = 'Q' then
        rP4C2Kicker := 1.21
        else
        if sP4C2Num = 'K' then
        rP4C2Kicker := 1.22
        else
        if sP4C2Num = 'A' then
        rP4C2Kicker := 1.23;


        if rP4C1Kicker > rP4C2Kicker then
          rP4Kicker := rP4C1Kicker
        else
        if rP4C2Kicker > rP4C1Kicker then
          rP4Kicker := rP4C2Kicker;

    //Winner
    if (rP1Kicker > rP2Kicker) and (rP1Kicker > rP3Kicker) and (rP1Kicker > rP4Kicker) then
          sWinner := sPlayer1
        else
        if (rP2Kicker > rP1Kicker) and (rP2Kicker > rP3Kicker) and (rP4Kicker > rP4Kicker) then
           sWinner := sPlayer2
           else
           if (rP3Kicker > rP1Kicker) and (rP3Kicker > rP2Kicker)and (rP3Kicker > rP4Kicker) then
            sWinner := sPlayer3
            else
            if (rP4Kicker > rP1Kicker) and (rP4Kicker > rP2Kicker)and (rP4Kicker > rP3Kicker) then
            sWinner := sPlayer4;
            
  end;  
  




end;

procedure TfrmBaseGameLVM.lblChangeMindClick(Sender: TObject);
begin
  lblOption1.Visible := True;
  lblOption2.Visible := True;
  lblOption3.Visible := True;
  pnlRaise.Visible := False;
  tmrFlashGo.Enabled := False;
end;

procedure TfrmBaseGameLVM.lblEndGameClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmBaseGameLVM.lblEndGameMouseEnter(Sender: TObject);
begin
  with lblEndGame do
    begin
      Font.Color := clFuchsia;
      Font.Size := 22;
    end;
end;

procedure TfrmBaseGameLVM.lblEndGameMouseLeave(Sender: TObject);
begin
   with lblEndGame do
    begin
      Font.Color := clYellow;
      Font.Size := 18;
    end;
end;

procedure TfrmBaseGameLVM.lblGoClick(Sender: TObject);
begin
  if not bCall then
  rRaise := 0;

 if (rRaise = 0) or (sedRaise.Value >= Ceil(rRaise))  then
 begin
    if bRiver  then
   iCall := iNumPlayers * 3
   else
   if bTurn then
   iCall := iNumPlayers * 2
   else
   if bFlop1 then
   iCall := iNumPlayers
   else
   begin
     iCall := 0;
   end;


  Inc(iCall);
  bCall := True;
  rRaise := sedRaise.Value;

  if sCurrentPlayer = sPlayer1 then
  begin
    if chkAllIn.Checked = True then
      begin
       rRaise := rP1Parkbucks;
       rP1Parkbucks := rP1Parkbucks - rRaise;
       rPot := rPot + rRaise;
       lblCurrentPlayer.Caption := sPlayer1 + ': ' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
       lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
      end
    else
    if rRaise <= rP1Parkbucks  then
     begin
      rP1Parkbucks := rP1Parkbucks - rRaise;
      rPot := rPot + rRaise;
      lblCurrentPlayer.Caption := sPlayer1 + ': ' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
      lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
     end
     else
     begin
      MessageDlg('You do not have the Parkbucks required to make this raise, please re-enter',mtError,[mbOK],0);
      Exit;
     end;
  end
  else
  if sCurrentPlayer = sPlayer2 then
  begin
    if chkAllIn.Checked = True then
      begin
       rRaise := rP2Parkbucks;
       rP2Parkbucks := rP2Parkbucks - rRaise;
       rPot := rPot + rRaise;
       lblCurrentPlayer.Caption := sPlayer2 + ': ' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
       lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
      end
    else
    if rRaise <= rP2Parkbucks  then
     begin
      rP2Parkbucks := rP2Parkbucks - rRaise;
      rPot := rPot + rRaise;
      lblCurrentPlayer.Caption := sPlayer2 + ': ' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
      lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
     end
     else
     begin
      MessageDlg('You do not have the Parkbucks required to make this raise, please re-enter',mtError,[mbOK],0);
      Exit;
     end;
  end
  else
  if sCurrentPlayer = sPlayer3 then
  begin
    if chkAllIn.Checked = True then
      begin
       rRaise := rP3Parkbucks;
       rP3Parkbucks := rP3Parkbucks - rRaise;
       rPot := rPot + rRaise;
       lblCurrentPlayer.Caption := sPlayer3 + ': ' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
       lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
      end
    else
    if rRaise <= rP3Parkbucks  then
     begin
      rP3Parkbucks := rP3Parkbucks - rRaise;
      rPot := rPot + rRaise;
      lblCurrentPlayer.Caption := sPlayer3 + ': ' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
      lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
     end
     else
     begin
      MessageDlg('You do not have the Parkbucks required to make this raise, please re-enter',mtError,[mbOK],0);
      Exit;
     end;
  end
  else
  if sCurrentPlayer = sPlayer4 then
  begin
    if chkAllIn.Checked = True then
      begin
       rRaise := rP4Parkbucks;
       rP4Parkbucks := rP4Parkbucks - rRaise;
       rPot := rPot + rRaise;
       lblCurrentPlayer.Caption := sPlayer4 + ': ' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
       lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
      end
    else
    if rRaise <= rP4Parkbucks  then
     begin
      rP4Parkbucks := rP4Parkbucks - rRaise;
      rPot := rPot + rRaise;
      lblCurrentPlayer.Caption := sPlayer4 + ': ' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
      lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
     end
     else
     begin
      MessageDlg('You do not have the Parkbucks required to make this raise, please re-enter',mtError,[mbOK],0);
      Exit;
     end;
  end;

  lblOption1.Caption := ('- Call (P' + FloatToStrF(rRaise,ffFixed,6,2) + ')' );

  lblOption1.Visible := True;
  lblOption2.Visible := True;
  lblOption3.Visible := True;
  pnlRaise.Visible := False;
  tmrFlashGo.Enabled := False;

   if ((iNumPlayers = 4)  or (iNumPlayers = 1)) and (iNumFold = 2) then
    begin
      NextTurnMoveFolded;
    end
    else
    begin
      CheckFold;
      NextTurnMove;
    end;

 end
 else
 if sedRaise.Value <= Ceil(rRaise) then
 begin
   MessageDlg('Raise by an ammount greater than the previous raise',mtError,[mbOK],0);
   Exit;
 end;



end;


procedure TfrmBaseGameLVM.lblNextRoundClick(Sender: TObject);
begin
   //Removes Cards
   imgP1C1.Free;
   imgP1C1 := nil;
   imgP1C2.Free;
   imgP1C2 := nil;

   if iNumPlayers = 2 then
   begin
    imgP2C1.Free;
    imgP2C1 := nil;

    imgP2C2.Free;
    imgP2C2 := nil;

   end
   else
   if iNumPlayers = 3 then
   begin
    imgP2C1.Free;
    imgP2C1 := nil;

    imgP2C2.Free;
    imgP2C2 := nil;

    imgP3C1.Free;
    imgP3C1 := nil;

    imgP3C2.Free;
    imgP3C2 := nil;
    end
    else
   if (iNumPlayers = 4) or (iNumPlayers = 1) then
   begin
    imgP2C1.Free;
    imgP2C1 := nil;

    imgP2C2.Free;
    imgP2C2 := nil;

    imgP3C1.Free;
    imgP3C1 := nil;

    imgP3C2.Free;
    imgP3C2 := nil;

    imgP4C1.Free;
    imgP4C1 := nil;

    imgP4C2.Free;
    imgP4C2 := nil;
    end;

  //GUI and variables are reset
  sCurrentPlayer := sPlayer1;
  bFoldP1 := False;
  bFoldP2 := False;
  bFoldP3 := False;
  bFoldP4 := False;
  iCheck := 0;
  iNumFold := 0;
  rRaise := 0;
  iNumFold := 0;
  rPot := 0;
  bCall := False;
  rRaise := 0;
  iRound := 0;
  iCount := 0;
  bFlop1 := False;
  bFlop2 := False;
  bFlop3 := False;
  bTurn  := False;
  bRiver := False;
  iRound := 0;
  iCall := 0;
  rP1HandRank := 0;
  rP2HandRank := 0;
  rP3HandRank := 0;
  rP4HandRank := 0;
  rTwoPairValue := 0;
  r3OAKValue := 0;
  rP1C1Value := 0;
  rP1C2Value := 0;
  rP2C1Value := 0;
  rP2C2Value := 0;
  rP3C1Value := 0;
  rP3C2Value := 0;
  rP4C1Value := 0;
  rP4C2Value := 0;


  lblOption1.Visible := False;
  lblOption3.Visible := False;
  lblOption2.Visible := True;
  lblOption2.Caption := '- Select Blinds';
  lblShowCards.Visible := False;
  lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);

  imgCom1.Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
  imgCom2.Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
  imgCom3.Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
  imgCom4.Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');
  imgCom5.Picture.LoadFromFile('Cards\' +  sCardColour + '_back.png');


  if iNumPlayers <> 1 then
   begin
    lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
    lblPlayer3.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
    lblPlayer4.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
    lblCurrentPlayer.Caption := sLoginUsername + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
   end
   else
   begin
    lblPlayer2.Caption := 'Computer1: P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
    lblPlayer3.Caption := 'Computer2: P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
    lblPlayer4.Caption := 'Computer3: P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
    lblCurrentPlayer.Caption := sLoginUsername + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
   end;

  pnlEndRound.Visible := False;

end;

procedure TfrmBaseGameLVM.lblNextRoundMouseEnter(Sender: TObject);
begin
  with lblNextRound do
    begin
      Font.Color := clFuchsia;
      Font.Size := 22;
    end;
end;

procedure TfrmBaseGameLVM.lblNextRoundMouseLeave(Sender: TObject);
begin
   with lblNextRound do
    begin
      Font.Color := clYellow;
      Font.Size := 18;
    end;
end;

procedure TfrmBaseGameLVM.lblOption1Click(Sender: TObject);
begin
 Option1;
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
begin
  Option2;
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

procedure TfrmBaseGameLVM.lblOption3Click(Sender: TObject);
begin
 Option3;
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

  if sCurrentPlayer = sPlayer1 then
 begin
  imgP1C1.Picture.LoadFromFile('Cards\' + sPlayer1Card1 + '.png');
  imgP1C2.Picture.LoadFromFile('Cards\' + sPlayer1Card2 + '.png');
 end
 else
 if sCurrentPlayer = sPlayer2 then
 begin
  imgP2C1.Picture.LoadFromFile('Cards\' + sPlayer2Card1 + '.png');
  imgP2C2.Picture.LoadFromFile('Cards\' + sPlayer2Card2 + '.png');
 end
 else
 if sCurrentPlayer = sPlayer3 then
 begin
  imgP3C1.Picture.LoadFromFile('Cards\' + sPlayer3Card1 + '.png');
  imgP3C2.Picture.LoadFromFile('Cards\' + sPlayer3Card2 + '.png');
 end
 else
 if sCurrentPlayer = sPlayer4 then
 begin
  imgP4C1.Picture.LoadFromFile('Cards\' + sPlayer4Card1 + '.png');
  imgP4C2.Picture.LoadFromFile('Cards\' + sPlayer4Card2 + '.png');
 end;

end;

procedure TfrmBaseGameLVM.lblShowCardsMouseLeave(Sender: TObject);
begin
  lblShowCards.Width := lblShowCards.Width - 10;
  lblShowCards.Height := lblShowCards.Width - 10;
  lblShowCards.Font.Size := 22;
  lblShowCards.Font.Color := clFuchsia;

  if sCurrentPlayer = sPlayer1 then
 begin
  imgP1C1.Picture.LoadFromFile('Cards\' + sCardColour + '_back.png');
  imgP1C2.Picture.LoadFromFile('Cards\' + sCardColour + '_back.png');
 end
 else
 if sCurrentPlayer = sPlayer2 then
 begin
  imgP2C1.Picture.LoadFromFile('Cards\' + sCardColour + '_back.png');
  imgP2C2.Picture.LoadFromFile('Cards\' + sCardColour + '_back.png');
 end
 else
 if sCurrentPlayer = sPlayer3 then
 begin
  imgP3C1.Picture.LoadFromFile('Cards\' + sCardColour + '_back.png');
  imgP3C2.Picture.LoadFromFile('Cards\' + sCardColour + '_back.png');
 end
 else
 if sCurrentPlayer = sPlayer4 then
 begin
  imgP4C1.Picture.LoadFromFile('Cards\' + sCardColour + '_back.png');
  imgP4C2.Picture.LoadFromFile('Cards\' + sCardColour + '_back.png');
 end;

end;

procedure TfrmBaseGameLVM.lblStatsClick(Sender: TObject);
begin
  Sleep(1500);
  frmBaseGameLVM.Hide;
  frmAccountsAndStats.Show;
end;

procedure TfrmBaseGameLVM.lblStatsMouseEnter(Sender: TObject);
begin
  with lblStats do
    begin
      Font.Color := clFuchsia;
      Font.Size := 22;
    end;
end;

procedure TfrmBaseGameLVM.lblStatsMouseLeave(Sender: TObject);
begin
   with lblStats do
    begin
      Font.Color := clYellow;
      Font.Size := 18;
    end;
end;

procedure TfrmBaseGameLVM.NextTurnMove;
  var
  K, L : Integer;
begin
  if (iNumPlayers = 4) then
 begin
  if sCurrentPlayer = sPlayer1 then
  begin
    lblShowCards.Visible := False;

   for K :=  1 to 20 do
    begin

      //from P1 pos to P4 pos
      //P1C1
      imgP1C1.Left  := imgP1C1.Left + 1;
      imgP1C1.Top :=  imgP1C1.Top - 14;

      imgP1C1.Height  := imgP1C1.Height - 2;
      imgP1C1.Width :=  imgP1C1.Width - 2;

      //P1C2
      imgP1C2.Left  := imgP1C2.Left + 1;
      imgP1C2.Top :=  imgP1C2.Top - 14;

      imgP1C2.Height  := imgP1C2.Height - 2;
      imgP1C2.Width :=  imgP1C2.Width - 2;


      //from P4 pos to P3 pos
      //P4C1
      imgP4C1.Left  := imgP4C1.Left - 15;
      imgP4C1.Top :=  imgP4C1.Top + 4;

      //P4C2
      imgP4C2.Left  := imgP4C2.Left - 15;
      imgP4C2.Top :=  imgP4C2.Top + 4;


      //from P3 pos to P2 pos
      //P3C1
      imgP3C1.Left  := imgP3C1.Left - 10;
      imgP3C1.Top :=  imgP3C1.Top + 10;

      //P3C2
      imgP3C2.Left  := imgP3C2.Left - 10;
      imgP3C2.Top :=  imgP3C2.Top + 10;


      //from P2 pos to P1 pos
      //P2C1
      imgP2C1.Left  := imgP2C1.Left + 19;
      imgP2C1.Top :=  imgP2C1.Top + 9;

      imgP2C1.Height  := imgP2C1.Height + 5;
      imgP2C1.Width :=  imgP2C1.Width + 5;

       //P2C2
      imgP2C2.Left  := imgP2C2.Left + 21;
      imgP2C2.Top :=  imgP2C2.Top + 9;

      imgP2C2.Height  := imgP2C2.Height + 5;
      imgP2C2.Width :=  imgP2C2.Width + 5;

       Sleep(5);
       Refresh;
    End;

    //P4 pos
   with imgP1C1 do
      begin
        Height := 151;
        Left := 584;
        Top := 50;
        Width := 99;
      end;

   with imgP1C2 do
      begin
        Height := 151;
        Left := 689;
        Top := 50;
        Width := 99;
      end;

   //P3 pos
   with imgP4C1 do
      begin
        Left := 286;
        Top := 130;
      end;

   with imgP4C2 do
      begin
        Left := 391;
        Top := 130;
      end;

   //P2 pos
   with imgP3C1 do
      begin
        Left := 86;
        Top := 347;
      end;

   with imgP3C2 do
      begin
        Left := 191;
        Top := 347;
      end;

    //P1 pos
   with imgP2C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

   with imgP2C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

   lblPlayer4.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
   lblPlayer3.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
   lblPlayer2.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
   lblCurrentPlayer.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);

   lblShowCards.Visible := True;

   if not bFoldP2 then
   begin
     MessageDlg(sPlayer2 + #39 + 's turn',mtInformation,[mbOK],0);
   end

  end
  else if sCurrentPlayer = sPlayer2 then
   begin
    lblShowCards.Visible := False;

   for L :=  1 to 20 do
    begin
      //P2C1
      imgP2C1.Left  := imgP2C1.Left + 1;
      imgP2C1.Top :=  imgP2C1.Top - 14;

      imgP2C1.Height  := imgP2C1.Height - 2;
      imgP2C1.Width :=  imgP2C1.Width - 2;

      //P2C2
      imgP2C2.Left  := imgP2C2.Left + 1;
      imgP2C2.Top :=  imgP2C2.Top - 14;

      imgP2C2.Height  := imgP2C2.Height - 2;
      imgP2C2.Width :=  imgP2C2.Width - 2;


      //P1C1
      imgP1C1.Left  := imgP1C1.Left - 15;
      imgP1C1.Top :=  imgP1C1.Top + 4;

      //P1C2
      imgP1C2.Left  := imgP1C2.Left - 15;
      imgP1C2.Top :=  imgP1C2.Top + 4;

      //P4C1
      imgP4C1.Left  := imgP4C1.Left - 10;
      imgP4C1.Top :=  imgP4C1.Top + 10;

      //P4C2
      imgP4C2.Left  := imgP4C2.Left - 10;
      imgP4C2.Top :=  imgP4C2.Top + 10;

      //P3C1
      imgP3C1.Left  := imgP3C1.Left + 19;
      imgP3C1.Top :=  imgP3C1.Top + 9;

      imgP3C1.Height  := imgP3C1.Height + 5;
      imgP3C1.Width :=  imgP3C1.Width + 5;

       //P2C2
      imgP3C2.Left  := imgP3C2.Left + 21;
      imgP3C2.Top :=  imgP3C2.Top + 9;

      imgP3C2.Height  := imgP3C2.Height + 5;
      imgP3C2.Width :=  imgP3C2.Width + 5;

       Sleep(5);
       Refresh;
    End;

   //P4 pos
   with imgP2C1 do
      begin
        Height := 151;
        Left := 584;
        Top := 50;
        Width := 99;
      end;

   with imgP2C2 do
      begin
        Height := 151;
        Left := 689;
        Top := 50;
        Width := 99;
      end;

   //P3 pos
   with imgP1C1 do
      begin
        Left := 286;
        Top := 130;
      end;

   with imgP1C2 do
      begin
        Left := 391;
        Top := 130;
      end;

   //P2 pos
   with imgP4C1 do
      begin
        Left := 86;
        Top := 347;
      end;

   with imgP4C2 do
      begin
        Left := 191;
        Top := 347;
      end;

    //P1 pos
   with imgP3C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

   with imgP3C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

   lblPlayer4.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
   lblPlayer3.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
   lblPlayer2.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
   lblCurrentPlayer.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);

   lblShowCards.Visible := True;

   if not bFoldP3 then
   begin
     MessageDlg(sPlayer3 + #39 + 's turn',mtInformation,[mbOK],0);
   end


  end
  else
  if sCurrentPlayer = sPlayer3 then
  begin
   lblShowCards.Visible := False;

   for K :=  1 to 20 do
    begin
      //from P1 pos to P4 pos
      //P3C1
      imgP3C1.Left  := imgP3C1.Left + 1;
      imgP3C1.Top :=  imgP3C1.Top - 14;

      imgP3C1.Height  := imgP3C1.Height - 2;
      imgP3C1.Width :=  imgP3C1.Width - 2;

      //P3C2
      imgP3C2.Left  := imgP3C2.Left + 1;
      imgP3C2.Top :=  imgP3C2.Top - 14;

      imgP3C2.Height  := imgP3C2.Height - 2;
      imgP3C2.Width :=  imgP3C2.Width - 2;

      //from P4 pos to P3 pos
      //P2C1
      imgP2C1.Left  := imgP2C1.Left - 15;
      imgP2C1.Top :=  imgP2C1.Top + 4;

      //P2C2
      imgP2C2.Left  := imgP2C2.Left - 15;
      imgP2C2.Top :=  imgP2C2.Top + 4;

      //from P3 pos to P2 pos
      //P1C1
      imgP1C1.Left  := imgP1C1.Left - 10;
      imgP1C1.Top :=  imgP1C1.Top + 10;

      //P1C2
      imgP1C2.Left  := imgP1C2.Left - 10;
      imgP1C2.Top :=  imgP1C2.Top + 10;

      //from P2 pos to P1 pos
      //P4C1
      imgP4C1.Left  := imgP4C1.Left + 19;
      imgP4C1.Top :=  imgP4C1.Top + 9;

      imgP4C1.Height  := imgP4C1.Height + 5;
      imgP4C1.Width :=  imgP4C1.Width + 5;

       //P4C2
      imgP4C2.Left  := imgP4C2.Left + 21;
      imgP4C2.Top :=  imgP4C2.Top + 9;

      imgP4C2.Height  := imgP4C2.Height + 5;
      imgP4C2.Width :=  imgP4C2.Width + 5;


       Sleep(5);
       Refresh;
    End;

    //P4 pos
   with imgP3C1 do
      begin
        Height := 151;
        Left := 584;
        Top := 50;
        Width := 99;
      end;

   with imgP3C2 do
      begin
        Height := 151;
        Left := 689;
        Top := 50;
        Width := 99;
      end;

   //P3 pos
   with imgP2C1 do
      begin
        Left := 286;
        Top := 130;
      end;

   with imgP2C2 do
      begin
        Left := 391;
        Top := 130;
      end;

   //P2 pos
   with imgP1C1 do
      begin
        Left := 86;
        Top := 347;
      end;

   with imgP1C2 do
      begin
        Left := 191;
        Top := 347;
      end;

    //P1 pos
   with imgP4C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

   with imgP4C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

   lblPlayer4.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
   lblPlayer3.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
   lblPlayer2.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
   lblCurrentPlayer.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);

   lblShowCards.Visible := True;

   if not bFoldP4 then
   begin
     MessageDlg(sPlayer4 + #39 + 's turn',mtInformation,[mbOK],0);
   end



  end
  else
  if sCurrentPlayer = sPlayer4 then
  begin
   lblShowCards.Visible := False;

   for K :=  1 to 20 do
    begin
      //from P1 pos to P4 pos
      //P4C1
      imgP4C1.Left  := imgP4C1.Left + 1;
      imgP4C1.Top :=  imgP4C1.Top - 14;

      imgP4C1.Height  := imgP4C1.Height - 2;
      imgP4C1.Width :=  imgP4C1.Width - 2;

      //P4C2
      imgP4C2.Left  := imgP4C2.Left + 1;
      imgP4C2.Top :=  imgP4C2.Top - 14;

      imgP4C2.Height  := imgP4C2.Height - 2;
      imgP4C2.Width :=  imgP4C2.Width - 2;

      //from P4 pos to P3 pos
      //P3C1
      imgP3C1.Left  := imgP3C1.Left - 15;
      imgP3C1.Top :=  imgP3C1.Top + 4;

      //P3C2
      imgP3C2.Left  := imgP3C2.Left - 15;
      imgP3C2.Top :=  imgP3C2.Top + 4;

      //from P3 pos to P2 pos
      //P1C1
      imgP2C1.Left  := imgP2C1.Left - 10;
      imgP2C1.Top :=  imgP2C1.Top + 10;

      //P1C2
      imgP2C2.Left  := imgP2C2.Left - 10;
      imgP2C2.Top :=  imgP2C2.Top + 10;

      //from P2 pos to P1 pos
      //P4C1
      imgP1C1.Left  := imgP1C1.Left + 19;
      imgP1C1.Top :=  imgP1C1.Top + 9;

      imgP1C1.Height  := imgP1C1.Height + 5;
      imgP1C1.Width :=  imgP1C1.Width + 5;

       //P4C2
      imgP1C2.Left  := imgP1C2.Left + 21;
      imgP1C2.Top :=  imgP1C2.Top + 9;

      imgP1C2.Height  := imgP1C2.Height + 5;
      imgP1C2.Width :=  imgP1C2.Width + 5;

       Sleep(5);
       Refresh;
    End;

    //P4 pos
   with imgP4C1 do
      begin
        Height := 151;
        Left := 584;
        Top := 50;
        Width := 99;
      end;

   with imgP4C2 do
      begin
        Height := 151;
        Left := 689;
        Top := 50;
        Width := 99;
      end;

   //P3 pos
   with imgP3C1 do
      begin
        Left := 286;
        Top := 130;
      end;

   with imgP3C2 do
      begin
        Left := 391;
        Top := 130;
      end;

   //P2 pos
   with imgP2C1 do
      begin
        Left := 86;
        Top := 347;
      end;

   with imgP2C2 do
      begin
        Left := 191;
        Top := 347;
      end;

    //P1 pos
   with imgP1C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

   with imgP1C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

   lblPlayer4.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
   lblPlayer3.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
   lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
   lblCurrentPlayer.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);

   lblShowCards.Visible := True;

   if not bFoldP1 then
   begin
     MessageDlg(sPlayer1 + #39 + 's turn',mtInformation,[mbOK],0);
   end

  end
 end
 else
 if iNumPlayers = 3 then
 begin
 if sCurrentPlayer = sPlayer1 then
  begin
   lblShowCards.Visible := False;

   for K :=  1 to 20 do
    begin
      //from P1 pos to P4 pos
      //P1C1
      imgP1C1.Left  := imgP1C1.Left + 1;
      imgP1C1.Top :=  imgP1C1.Top - 14;

      imgP1C1.Height  := imgP1C1.Height - 2;
      imgP1C1.Width :=  imgP1C1.Width - 2;

      //P1C2
      imgP1C2.Left  := imgP1C2.Left + 1;
      imgP1C2.Top :=  imgP1C2.Top - 14;

      imgP1C2.Height  := imgP1C2.Height - 2;
      imgP1C2.Width :=  imgP1C2.Width - 2;


      //from P4 pos to P3 pos
      //P3C1
      imgP3C1.Left  := imgP3C1.Left - 15;
      imgP3C1.Top :=  imgP3C1.Top + 4;

      //P3C2
      imgP3C2.Left  := imgP3C2.Left - 15;
      imgP3C2.Top :=  imgP3C2.Top + 4;

      //from P3 pos to P1 pos
      //P2C1
      imgP2C1.Left  := imgP2C1.Left + 11;
      imgP2C1.Top :=  imgP2C1.Top + 16;

      imgP2C1.Height  := imgP2C1.Height + 4;
      imgP2C1.Width :=  imgP2C1.Width + 4;

       //P2C2
      imgP2C2.Left  := imgP2C2.Left + 14;
      imgP2C2.Top :=  imgP2C2.Top + 16;

      imgP2C2.Height  := imgP2C2.Height + 4;
      imgP2C2.Width :=  imgP2C2.Width + 4;

       Sleep(5);
       Refresh;
    End;

    //P4 pos
   with imgP1C1 do
      begin
        Height := 151;
        Left := 584;
        Top := 50;
        Width := 99;
      end;

   with imgP1C2 do
      begin
        Height := 151;
        Left := 689;
        Top := 50;
        Width := 99;
      end;

   //P3 pos
   with imgP3C1 do
      begin
        Left := 286;
        Top := 130;
      end;

   with imgP3C2 do
      begin
        Left := 391;
        Top := 130;
      end;

   //P1 pos
   with imgP2C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

   with imgP2C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

   lblPlayer3.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
   lblPlayer2.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
   lblCurrentPlayer.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);

   lblShowCards.Visible := True;

   if not bFoldP2 then
   begin
     MessageDlg(sPlayer2 + #39 + 's turn',mtInformation,[mbOK],0);
   end


  end
  else if sCurrentPlayer = sPlayer2 then
    begin
    lblShowCards.Visible := False;

   for K :=  1 to 20 do
    begin
      //from P1 pos to P4 pos
      //P1C1
      imgP2C1.Left  := imgP2C1.Left + 1;
      imgP2C1.Top :=  imgP2C1.Top - 14;

      imgP2C1.Height  := imgP2C1.Height - 2;
      imgP2C1.Width :=  imgP2C1.Width - 2;

      //P1C2
      imgP2C2.Left  := imgP2C2.Left + 1;
      imgP2C2.Top :=  imgP2C2.Top - 14;

      imgP2C2.Height  := imgP2C2.Height - 2;
      imgP2C2.Width :=  imgP2C2.Width - 2;


      //from P4 pos to P3 pos
      //P3C1
      imgP1C1.Left  := imgP1C1.Left - 15;
      imgP1C1.Top :=  imgP1C1.Top + 4;

      //P3C2
      imgP1C2.Left  := imgP1C2.Left - 15;
      imgP1C2.Top :=  imgP1C2.Top + 4;

      //from P3 pos to P1 pos
      //P2C1
      imgP3C1.Left  := imgP3C1.Left + 11;
      imgP3C1.Top :=  imgP3C1.Top + 16;

      imgP3C1.Height  := imgP3C1.Height + 4;
      imgP3C1.Width :=  imgP3C1.Width + 4;

       //P2C2
      imgP3C2.Left  := imgP3C2.Left + 14;
      imgP3C2.Top :=  imgP3C2.Top + 16;

      imgP3C2.Height  := imgP3C2.Height + 4;
      imgP3C2.Width :=  imgP3C2.Width + 4;

       Sleep(5);
       Refresh;
    End;

    //P4 pos
   with imgP2C1 do
      begin
        Height := 151;
        Left := 584;
        Top := 50;
        Width := 99;
      end;

   with imgP2C2 do
      begin
        Height := 151;
        Left := 689;
        Top := 50;
        Width := 99;
      end;

   //P3 pos
   with imgP1C1 do
      begin
        Left := 286;
        Top := 130;
      end;

   with imgP1C2 do
      begin
        Left := 391;
        Top := 130;
      end;

   //P1 pos
   with imgP3C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

   with imgP3C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

   lblPlayer3.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
   lblPlayer2.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
   lblCurrentPlayer.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);

   lblShowCards.Visible := True;

   if not bFoldP3 then
   begin
     MessageDlg(sPlayer3 + #39 + 's turn',mtInformation,[mbOK],0);
   end



  end
  else if sCurrentPlayer = sPlayer3 then
    begin
    lblShowCards.Visible := False;

   for K :=  1 to 20 do
    begin
      //from P1 pos to P4 pos
      //P3C1
      imgP3C1.Left  := imgP3C1.Left + 1;
      imgP3C1.Top :=  imgP3C1.Top - 14;

      imgP3C1.Height  := imgP3C1.Height - 2;
      imgP3C1.Width :=  imgP3C1.Width - 2;

      //P3C2
      imgP3C2.Left  := imgP3C2.Left + 1;
      imgP3C2.Top :=  imgP3C2.Top - 14;

      imgP3C2.Height  := imgP3C2.Height - 2;
      imgP3C2.Width :=  imgP3C2.Width - 2;


      //from P4 pos to P3 pos
      //P2C1
      imgP2C1.Left  := imgP2C1.Left - 15;
      imgP2C1.Top :=  imgP2C1.Top + 4;

      //P2C2
      imgP2C2.Left  := imgP2C2.Left - 15;
      imgP2C2.Top :=  imgP2C2.Top + 4;

      //from P3 pos to P1 pos
      //P1C1
      imgP1C1.Left  := imgP1C1.Left + 11;
      imgP1C1.Top :=  imgP1C1.Top + 16;

      imgP1C1.Height  := imgP1C1.Height + 4;
      imgP1C1.Width :=  imgP1C1.Width + 4;

       //P1C2
      imgP1C2.Left  := imgP1C2.Left + 14;
      imgP1C2.Top :=  imgP1C2.Top + 16;

      imgP1C2.Height  := imgP1C2.Height + 4;
      imgP1C2.Width :=  imgP1C2.Width + 4;

       Sleep(5);
       Refresh;
    End;

    //P4 pos
   with imgP3C1 do
      begin
        Height := 151;
        Left := 584;
        Top := 50;
        Width := 99;
      end;

   with imgP3C2 do
      begin
        Height := 151;
        Left := 689;
        Top := 50;
        Width := 99;
      end;

   //P3 pos
   with imgP2C1 do
      begin
        Left := 286;
        Top := 130;
      end;

   with imgP2C2 do
      begin
        Left := 391;
        Top := 130;
      end;

   //P1 pos
   with imgP1C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

   with imgP1C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

   lblPlayer3.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
   lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
   lblCurrentPlayer.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);

   lblShowCards.Visible := True;

   if not bFoldP1 then
   begin
     MessageDlg(sPlayer1 + #39 + 's turn',mtInformation,[mbOK],0);
   end;


  end;
 end
 else
 if iNumPlayers = 2 then
 begin
 if sCurrentPlayer = sPlayer1 then
  begin
   lblShowCards.Visible := False;

   for K :=  1 to 20 do
    begin

      //from P1 pos to P3 pos
      //P2C1
      imgP1C1.Left  := imgP1C1.Left - 11;
      imgP1C1.Top :=  imgP1C1.Top - 16;

      imgP1C1.Height  := imgP1C1.Height - 4;
      imgP1C1.Width :=  imgP1C1.Width - 4;

       //P2C2
      imgP1C2.Left  := imgP1C2.Left - 14;
      imgP1C2.Top :=  imgP1C2.Top - 16;

      imgP1C2.Height  := imgP1C2.Height - 4;
      imgP1C2.Width :=  imgP1C2.Width - 4;

      //from P3 pos to P1 pos
      //P2C1
      imgP2C1.Left  := imgP2C1.Left + 11;
      imgP2C1.Top :=  imgP2C1.Top + 16;

      imgP2C1.Height  := imgP2C1.Height + 4;
      imgP2C1.Width :=  imgP2C1.Width + 4;

       //P2C2
      imgP2C2.Left  := imgP2C2.Left + 14;
      imgP2C2.Top :=  imgP2C2.Top + 16;

      imgP2C2.Height  := imgP2C2.Height + 4;
      imgP2C2.Width :=  imgP2C2.Width + 4;

       Sleep(5);
       Refresh;
    End;


   //P3 pos
   with imgP1C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

   with imgP1C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

   //P1 pos
   with imgP2C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

   with imgP2C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

   lblPlayer2.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
   lblCurrentPlayer.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);

    lblShowCards.Visible := True;

   MessageDlg(sPlayer2 + #39 + 's turn',mtInformation,[mbOK],0);
  end
  else if sCurrentPlayer = sPlayer2 then
  begin
    lblShowCards.Visible := False;

   for K :=  1 to 20 do
    begin

      //from P1 pos to P3 pos
      //P2C1
      imgP2C1.Left  := imgP2C1.Left - 11;
      imgP2C1.Top :=  imgP2C1.Top - 16;

      imgP2C1.Height  := imgP2C1.Height - 4;
      imgP2C1.Width :=  imgP2C1.Width - 4;

       //P2C2
      imgP2C2.Left  := imgP2C2.Left - 14;
      imgP2C2.Top :=  imgP2C2.Top - 16;

      imgP2C2.Height  := imgP2C2.Height - 4;
      imgP2C2.Width :=  imgP2C2.Width - 4;

      //from P3 pos to P1 pos
      //P2C1
      imgP1C1.Left  := imgP1C1.Left + 11;
      imgP1C1.Top :=  imgP1C1.Top + 16;

      imgP1C1.Height  := imgP1C1.Height + 4;
      imgP1C1.Width :=  imgP1C1.Width + 4;

       //P2C2
      imgP1C2.Left  := imgP1C2.Left + 14;
      imgP1C2.Top :=  imgP1C2.Top + 16;

      imgP1C2.Height  := imgP1C2.Height + 4;
      imgP1C2.Width :=  imgP1C2.Width + 4;

       Sleep(5);
       Refresh;
    End;


   //P3 pos
   with imgP2C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

   with imgP2C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

   //P1 pos
   with imgP1C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

   with imgP1C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

   lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
   lblCurrentPlayer.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);

    lblShowCards.Visible := True;

    MessageDlg(sPlayer1 + #39 + 's turn',mtInformation,[mbOK],0);
  end
 end;

  if iNumPlayers = 4 then
   begin
    if sCurrentPlayer = sPlayer1
     then
      sCurrentPlayer := sPlayer2
      else
    if sCurrentPlayer = sPlayer2
     then
      sCurrentPlayer := sPlayer3
      else
    if sCurrentPlayer = sPlayer3
     then
       sCurrentPlayer := sPlayer4
      else
    if sCurrentPlayer = sPlayer4
      then
      sCurrentPlayer := sPlayer1;
   end
   else
   if iNumPlayers = 3 then
   begin
    if sCurrentPlayer = sPlayer1
     then
      sCurrentPlayer := sPlayer2
      else
    if sCurrentPlayer = sPlayer2
     then
      sCurrentPlayer := sPlayer3
      else
    if sCurrentPlayer = sPlayer3
     then
       sCurrentPlayer := sPlayer1;
   end
    else
   if iNumPlayers = 2 then
   begin
    if sCurrentPlayer = sPlayer1
     then
      sCurrentPlayer := sPlayer2
      else
    if sCurrentPlayer = sPlayer2
     then
      sCurrentPlayer := sPlayer1;
   end;

    if (sCurrentPlayer = sPlayer1) and bP1Raiser then
    begin
      if bRiver then
      begin
         iCheck := iNumPlayers * 3;
         iCall := iNumPlayers * 3 ;
      end
      else if bTurn then
           begin
         iCheck := iNumPlayers * 4;
         iCall := iNumPlayers * 4;
      end
      else  if bFlop1 then
      begin
         iCheck := iNumPlayers * 2;
         iCall := iNumPlayers * 2;
      end
      else
      begin
         iCheck := iNumPlayers;
         iCall := iNumPlayers;
      end;
    end
    else
    if (sCurrentPlayer = sPlayer2) and bP2Raiser then
    begin
      if bRiver then
      begin
         iCheck := iNumPlayers * 3;
         iCall := iNumPlayers * 3 ;
      end
      else if bTurn then
           begin
         iCheck := iNumPlayers * 4;
         iCall := iNumPlayers * 4;
      end
      else  if bFlop1 then
      begin
         iCheck := iNumPlayers * 2;
         iCall := iNumPlayers * 2;
      end
      else
      begin
         iCheck := iNumPlayers;
         iCall := iNumPlayers;
      end;
    end
    else
    if (sCurrentPlayer = sPlayer3) and bP3Raiser then
    begin
     if bRiver then
      begin
         iCheck := iNumPlayers * 3;
         iCall := iNumPlayers * 3 ;
      end
      else if bTurn then
           begin
         iCheck := iNumPlayers * 4;
         iCall := iNumPlayers * 4;
      end
      else  if bFlop1 then
      begin
         iCheck := iNumPlayers * 2;
         iCall := iNumPlayers * 2;
      end
      else
      begin
         iCheck := iNumPlayers;
         iCall := iNumPlayers;
      end;
    end
    else
    if (sCurrentPlayer = sPlayer4) and bP4Raiser then
    begin
      if bRiver then
      begin
         iCheck := iNumPlayers * 3;
         iCall := iNumPlayers * 3 ;
      end
      else if bTurn then
           begin
         iCheck := iNumPlayers * 4;
         iCall := iNumPlayers * 4;
      end
      else  if bFlop1 then
      begin
         iCheck := iNumPlayers * 2;
         iCall := iNumPlayers * 2;
      end
      else
      begin
         iCheck := iNumPlayers;
         iCall := iNumPlayers;
      end;
    end;




end;

procedure TfrmBaseGameLVM.NextTurnMoveFolded;
  var
  K : Integer;
begin
  if (not bFoldP1) and  (not bFoldP2) then
    begin
      if sCurrentPlayer = sPlayer1 then
      begin
       lblShowCards.Visible := False;

      for K :=  1 to 20 do
      begin
      //from P1 pos to P3 pos
      //P1C1
      imgP1C1.Left  := imgP1C1.Left - 11;
      imgP1C1.Top :=  imgP1C1.Top - 16;

      imgP1C1.Height  := imgP1C1.Height - 4;
      imgP1C1.Width :=  imgP1C1.Width - 4;

       //P1C2
      imgP1C2.Left  := imgP1C2.Left - 14;
      imgP1C2.Top :=  imgP1C2.Top - 16;

      imgP1C2.Height  := imgP1C2.Height - 4;
      imgP1C2.Width :=  imgP1C2.Width - 4;

      //from P3 pos to P1 pos
      //P2C1
      imgP2C1.Left  := imgP2C1.Left + 11;
      imgP2C1.Top :=  imgP2C1.Top + 16;

      imgP2C1.Height  := imgP2C1.Height + 4;
      imgP2C1.Width :=  imgP2C1.Width + 4;

       //P2C2
      imgP2C2.Left  := imgP2C2.Left + 14;
      imgP2C2.Top :=  imgP2C2.Top + 16;

      imgP2C2.Height  := imgP2C2.Height + 4;
      imgP2C2.Width :=  imgP2C2.Width + 4;

       Sleep(5);
       Refresh;
      End;


      //P3 pos
      with imgP1C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

      with imgP1C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      //P1 pos
      with imgP2C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP2C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      lblPlayer2.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);

      lblShowCards.Visible := True;

      sCurrentPlayer := sPlayer2;

      MessageDlg(sPlayer2 + #39 + 's turn',mtInformation,[mbOK],0);
     end
     else if sCurrentPlayer = sPlayer2 then
      begin
    lblShowCards.Visible := False;

      for K :=  1 to 20 do
      begin

      //from P1 pos to P3 pos
      //P2C1
      imgP2C1.Left  := imgP2C1.Left - 11;
      imgP2C1.Top :=  imgP2C1.Top - 16;

      imgP2C1.Height  := imgP2C1.Height - 4;
      imgP2C1.Width :=  imgP2C1.Width - 4;

       //P2C2
      imgP2C2.Left  := imgP2C2.Left - 14;
      imgP2C2.Top :=  imgP2C2.Top - 16;

      imgP2C2.Height  := imgP2C2.Height - 4;
      imgP2C2.Width :=  imgP2C2.Width - 4;

      //from P3 pos to P1 pos
      //P1C1
      imgP1C1.Left  := imgP1C1.Left + 11;
      imgP1C1.Top :=  imgP1C1.Top + 16;

      imgP1C1.Height  := imgP1C1.Height + 4;
      imgP1C1.Width :=  imgP1C1.Width + 4;

       //P1C2
      imgP1C2.Left  := imgP1C2.Left + 14;
      imgP1C2.Top :=  imgP1C2.Top + 16;

      imgP1C2.Height  := imgP1C2.Height + 4;
      imgP1C2.Width :=  imgP1C2.Width + 4;

       Sleep(5);
       Refresh;
     End;


      //P3 pos
      with imgP2C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

      with imgP2C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      //P1 pos
      with imgP1C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP1C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);

       lblShowCards.Visible := True;

      sCurrentPlayer := sPlayer1;

    MessageDlg(sPlayer1 + #39 + 's turn',mtInformation,[mbOK],0);
   end;
  end
    else
  if (not bFoldP1) and  (not bFoldP3) then
    begin
      if sCurrentPlayer = sPlayer1 then
      begin
      lblShowCards.Visible := False;

      for K :=  1 to 20 do
      begin

      //from P1 pos to P3 pos
      //P1C1
      imgP1C1.Left  := imgP1C1.Left - 11;
      imgP1C1.Top :=  imgP1C1.Top - 16;

      imgP1C1.Height  := imgP1C1.Height - 4;
      imgP1C1.Width :=  imgP1C1.Width - 4;

       //P1C2
      imgP1C2.Left  := imgP1C2.Left - 14;
      imgP1C2.Top :=  imgP1C2.Top - 16;

      imgP1C2.Height  := imgP1C2.Height - 4;
      imgP1C2.Width :=  imgP1C2.Width - 4;

      //from P3 pos to P1 pos
      //P3C1
      imgP3C1.Left  := imgP3C1.Left + 11;
      imgP3C1.Top :=  imgP3C1.Top + 16;

      imgP3C1.Height  := imgP3C1.Height + 4;
      imgP3C1.Width :=  imgP3C1.Width + 4;

       //P3C2
      imgP3C2.Left  := imgP3C2.Left + 14;
      imgP3C2.Top :=  imgP3C2.Top + 16;

      imgP3C2.Height  := imgP3C2.Height + 4;
      imgP3C2.Width :=  imgP3C2.Width + 4;

       Sleep(5);
       Refresh;
      End;


      //P3 pos
      with imgP1C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

      with imgP1C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      //P1 pos
      with imgP3C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP3C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      lblPlayer2.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);

      lblShowCards.Visible := True;

       sCurrentPlayer := sPlayer3;

      MessageDlg(sPlayer2 + #39 + 's turn',mtInformation,[mbOK],0);
     end
     else if sCurrentPlayer = sPlayer3 then
      begin
      lblShowCards.Visible := False;

      for K :=  1 to 20 do
      begin

      //from P1 pos to P3 pos
      //P3C1
      imgP3C1.Left  := imgP3C1.Left - 11;
      imgP3C1.Top :=  imgP3C1.Top - 16;

      imgP3C1.Height  := imgP3C1.Height - 4;
      imgP3C1.Width :=  imgP3C1.Width - 4;

       //P3C2
      imgP3C2.Left  := imgP3C2.Left - 14;
      imgP3C2.Top :=  imgP3C2.Top - 16;

      imgP3C2.Height  := imgP3C2.Height - 4;
      imgP3C2.Width :=  imgP3C2.Width - 4;

      //from P3 pos to P1 pos
      //P1C1
      imgP1C1.Left  := imgP1C1.Left + 11;
      imgP1C1.Top :=  imgP1C1.Top + 16;

      imgP1C1.Height  := imgP1C1.Height + 4;
      imgP1C1.Width :=  imgP1C1.Width + 4;

       //P1C2
      imgP1C2.Left  := imgP1C2.Left + 14;
      imgP1C2.Top :=  imgP1C2.Top + 16;

      imgP1C2.Height  := imgP1C2.Height + 4;
      imgP1C2.Width :=  imgP1C2.Width + 4;

       Sleep(5);
       Refresh;
      End;


      //P3 pos
      with imgP3C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

      with imgP3C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      //P1 pos
      with imgP1C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP1C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      lblPlayer2.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);

      lblShowCards.Visible := False;

      sCurrentPlayer := sPlayer1;

      MessageDlg(sPlayer1 + #39 + 's turn',mtInformation,[mbOK],0);
     end;

    end
    else
  if (not bFoldP1) and  (not bFoldP4) then
    begin

      if sCurrentPlayer = sPlayer4 then
      begin
      lblShowCards.Visible := False;

      for K :=  1 to 20 do
      begin

      //from P1 pos to P3 pos
      //P4C1
      imgP4C1.Left  := imgP4C1.Left - 11;
      imgP4C1.Top :=  imgP4C1.Top - 16;

      imgP4C1.Height  := imgP4C1.Height - 4;
      imgP4C1.Width :=  imgP4C1.Width - 4;

       //P4C2
      imgP4C2.Left  := imgP4C2.Left - 14;
      imgP4C2.Top :=  imgP4C2.Top - 16;

      imgP4C2.Height  := imgP4C2.Height - 4;
      imgP4C2.Width :=  imgP4C2.Width - 4;

      //from P3 pos to P1 pos
      //P1C1
      imgP1C1.Left  := imgP1C1.Left + 11;
      imgP1C1.Top :=  imgP1C1.Top + 16;

      imgP1C1.Height  := imgP1C1.Height + 4;
      imgP1C1.Width :=  imgP1C1.Width + 4;

       //P1C2
      imgP1C2.Left  := imgP1C2.Left + 14;
      imgP1C2.Top :=  imgP1C2.Top + 16;

      imgP1C2.Height  := imgP1C2.Height + 4;
      imgP1C2.Width :=  imgP1C2.Width + 4;

       Sleep(5);
       Refresh;
      End;


      //P3 pos
      with imgP4C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

      with imgP4C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      //P1 pos
      with imgP1C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP1C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      lblPlayer2.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);

      lblShowCards.Visible := True;

      sCurrentPlayer := sPlayer1;

      MessageDlg(sPlayer1 + #39 + 's turn',mtInformation,[mbOK],0);
     end
     else if sCurrentPlayer = sPlayer1 then
      begin
      lblShowCards.Visible := False;

      for K :=  1 to 20 do
      begin

      //from P1 pos to P3 pos
      //P4C1
      imgP1C1.Left  := imgP1C1.Left - 11;
      imgP1C1.Top :=  imgP1C1.Top - 16;

      imgP1C1.Height  := imgP1C1.Height - 4;
      imgP1C1.Width :=  imgP1C1.Width - 4;

       //P3C2
      imgP1C2.Left  := imgP1C2.Left - 14;
      imgP1C2.Top :=  imgP1C2.Top - 16;

      imgP1C2.Height  := imgP1C2.Height - 4;
      imgP1C2.Width :=  imgP1C2.Width - 4;

      //from P3 pos to P1 pos
      //P4C1
      imgP4C1.Left  := imgP4C1.Left + 11;
      imgP4C1.Top :=  imgP4C1.Top + 16;

      imgP4C1.Height  := imgP4C1.Height + 4;
      imgP4C1.Width :=  imgP4C1.Width + 4;

       //P4C2
      imgP4C2.Left  := imgP4C2.Left + 14;
      imgP4C2.Top :=  imgP4C2.Top + 16;

      imgP4C2.Height  := imgP4C2.Height + 4;
      imgP4C2.Width :=  imgP4C2.Width + 4;

       Sleep(5);
       Refresh;
      End;


      //P3 pos
      with imgP1C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

      with imgP1C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      //P1 pos
      with imgP4C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP4C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      lblPlayer2.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);

      lblShowCards.Visible := True;

      sCurrentPlayer := sPlayer4;

      MessageDlg(sPlayer4 + #39 + 's turn',mtInformation,[mbOK],0);
     end;

    end
    else
  if (not bFoldP2) and  (not bFoldP3) then
    begin
      if sCurrentPlayer = sPlayer2 then
      begin
      lblShowCards.Visible := False;

      for K :=  1 to 20 do
      begin

      //from P1 pos to P3 pos
      //P2C1
      imgP2C1.Left  := imgP2C1.Left - 11;
      imgP2C1.Top :=  imgP2C1.Top - 16;

      imgP2C1.Height  := imgP2C1.Height - 4;
      imgP2C1.Width :=  imgP2C1.Width - 4;

       //P1C2
      imgP2C2.Left  := imgP2C2.Left - 14;
      imgP2C2.Top :=  imgP2C2.Top - 16;

      imgP2C2.Height  := imgP2C2.Height - 4;
      imgP2C2.Width :=  imgP2C2.Width - 4;

      //from P3 pos to P1 pos
      //P3C1
      imgP3C1.Left  := imgP3C1.Left + 11;
      imgP3C1.Top :=  imgP3C1.Top + 16;

      imgP3C1.Height  := imgP3C1.Height + 4;
      imgP3C1.Width :=  imgP3C1.Width + 4;

       //P3C2
      imgP3C2.Left  := imgP3C2.Left + 14;
      imgP3C2.Top :=  imgP3C2.Top + 16;

      imgP3C2.Height  := imgP3C2.Height + 4;
      imgP3C2.Width :=  imgP3C2.Width + 4;

       Sleep(5);
       Refresh;
      End;


      //P3 pos
      with imgP2C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

      with imgP2C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      //P1 pos
      with imgP3C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP3C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);

       lblShowCards.Visible := True;

      sCurrentPlayer := sPlayer3;

      MessageDlg(sPlayer3 + #39 + 's turn',mtInformation,[mbOK],0);
     end
     else if sCurrentPlayer = sPlayer3 then
      begin
      lblShowCards.Visible := False;

      for K :=  1 to 20 do
      begin

      //from P1 pos to P3 pos
      //P4C1
      imgP3C1.Left  := imgP3C1.Left - 11;
      imgP3C1.Top :=  imgP3C1.Top - 16;

      imgP3C1.Height  := imgP3C1.Height - 4;
      imgP3C1.Width :=  imgP3C1.Width - 4;

       //P3C2
      imgP3C2.Left  := imgP3C2.Left - 14;
      imgP3C2.Top :=  imgP3C2.Top - 16;

      imgP3C2.Height  := imgP3C2.Height - 4;
      imgP3C2.Width :=  imgP3C2.Width - 4;

      //from P3 pos to P1 pos
      //P2C1
      imgP2C1.Left  := imgP2C1.Left + 11;
      imgP2C1.Top :=  imgP2C1.Top + 16;

      imgP2C1.Height  := imgP2C1.Height + 4;
      imgP2C1.Width :=  imgP2C1.Width + 4;

       //P2C2
      imgP2C2.Left  := imgP2C2.Left + 14;
      imgP2C2.Top :=  imgP2C2.Top + 16;

      imgP2C2.Height  := imgP2C2.Height + 4;
      imgP2C2.Width :=  imgP2C2.Width + 4;

       Sleep(5);
       Refresh;
     End;


      //P3 pos
      with imgP3C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

      with imgP3C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      //P1 pos
      with imgP2C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP2C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      lblPlayer2.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);

      lblShowCards.Visible := True;

      sCurrentPlayer := sPlayer2;

     MessageDlg(sPlayer2 + #39 + 's turn',mtInformation,[mbOK],0);
     end;

    end
    else
  if (not bFoldP2) and  (not bFoldP4) then
    begin
     lblShowCards.Visible := False;

      if sCurrentPlayer = sPlayer2 then
      begin
      for K :=  1 to 20 do
      begin

      //from P1 pos to P3 pos
      //P2C1
      imgP2C1.Left  := imgP2C1.Left - 11;
      imgP2C1.Top :=  imgP2C1.Top - 16;

      imgP2C1.Height  := imgP2C1.Height - 4;
      imgP2C1.Width :=  imgP2C1.Width - 4;

       //P2C2
      imgP2C2.Left  := imgP2C2.Left - 14;
      imgP2C2.Top :=  imgP2C2.Top - 16;

      imgP2C2.Height  := imgP2C2.Height - 4;
      imgP2C2.Width :=  imgP2C2.Width - 4;

      //from P3 pos to P1 pos
      //P4C1
      imgP4C1.Left  := imgP4C1.Left + 11;
      imgP4C1.Top :=  imgP4C1.Top + 16;

      imgP4C1.Height  := imgP4C1.Height + 4;
      imgP4C1.Width :=  imgP4C1.Width + 4;

       //P4C2
      imgP4C2.Left  := imgP4C2.Left + 14;
      imgP4C2.Top :=  imgP4C2.Top + 16;

      imgP4C2.Height  := imgP4C2.Height + 4;
      imgP4C2.Width :=  imgP4C2.Width + 4;

       Sleep(5);
       Refresh;
      End;


      //P3 pos
      with imgP2C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

      with imgP2C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      //P1 pos
      with imgP4C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP4C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      lblPlayer2.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);

      lblShowCards.Visible := True;

       sCurrentPlayer := sPlayer4;

      MessageDlg(sPlayer4 + #39 + 's turn',mtInformation,[mbOK],0);
     end
     else if sCurrentPlayer = sPlayer4 then
      begin
      lblShowCards.Visible := False;

      for K :=  1 to 20 do
      begin

      //from P1 pos to P3 pos
      //P4C1
      imgP4C1.Left  := imgP4C1.Left - 11;
      imgP4C1.Top :=  imgP4C1.Top - 16;

      imgP4C1.Height  := imgP4C1.Height - 4;
      imgP4C1.Width :=  imgP4C1.Width - 4;

       //P4C2
      imgP4C2.Left  := imgP4C2.Left - 14;
      imgP4C2.Top :=  imgP4C2.Top - 16;

      imgP4C2.Height  := imgP4C2.Height - 4;
      imgP4C2.Width :=  imgP4C2.Width - 4;

      //from P3 pos to P1 pos
      //P2C1
      imgP2C1.Left  := imgP2C1.Left + 11;
      imgP2C1.Top :=  imgP2C1.Top + 16;

      imgP2C1.Height  := imgP2C1.Height + 4;
      imgP2C1.Width :=  imgP2C1.Width + 4;

       //P2C2
      imgP2C2.Left  := imgP2C2.Left + 14;
      imgP2C2.Top :=  imgP2C2.Top + 16;

      imgP2C2.Height  := imgP2C2.Height + 4;
      imgP2C2.Width :=  imgP2C2.Width + 4;

       Sleep(5);
       Refresh;
     End;


      //P3 pos
      with imgP4C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

      with imgP4C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      //P1 pos
      with imgP2C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP2C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      lblPlayer2.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer2 + ': P' + FloatToStrF(rP2Parkbucks,ffFixed,6,2);

      lblShowCards.Visible := True;

      sCurrentPlayer := sPlayer2;

     MessageDlg(sPlayer2 + #39 + 's turn',mtInformation,[mbOK],0);
     end;

    end
    else
    if (not bFoldP3) and  (not bFoldP4) then
    begin
    lblShowCards.Visible := True;

      if sCurrentPlayer = sPlayer3 then
      begin
      for K :=  1 to 20 do
      begin

      //from P1 pos to P3 pos
      //P3C1
      imgP3C1.Left  := imgP3C1.Left - 11;
      imgP3C1.Top :=  imgP3C1.Top - 16;

      imgP3C1.Height  := imgP3C1.Height - 4;
      imgP3C1.Width :=  imgP3C1.Width - 4;

       //P3C2
      imgP3C2.Left  := imgP3C2.Left - 14;
      imgP3C2.Top :=  imgP3C2.Top - 16;

      imgP3C2.Height  := imgP3C2.Height - 4;
      imgP3C2.Width :=  imgP3C2.Width - 4;

      //from P3 pos to P1 pos
      //P4C1
      imgP4C1.Left  := imgP4C1.Left + 11;
      imgP4C1.Top :=  imgP4C1.Top + 16;

      imgP4C1.Height  := imgP4C1.Height + 4;
      imgP4C1.Width :=  imgP4C1.Width + 4;

       //P4C2
      imgP4C2.Left  := imgP4C2.Left + 14;
      imgP4C2.Top :=  imgP4C2.Top + 16;

      imgP4C2.Height  := imgP4C2.Height + 4;
      imgP4C2.Width :=  imgP4C2.Width + 4;

       Sleep(5);
       Refresh;
      End;


      //P3 pos
      with imgP3C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

      with imgP3C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      //P1 pos
      with imgP4C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP4C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      lblPlayer2.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);

      lblShowCards.Visible := True;

      sCurrentPlayer := sPlayer4;

      MessageDlg(sPlayer4 + #39 + 's turn',mtInformation,[mbOK],0);
     end
     else if sCurrentPlayer = sPlayer4 then
      begin
      lblShowCards.Visible := False;

      for K :=  1 to 20 do
      begin

      //from P1 pos to P3 pos
      //P4C1
      imgP4C1.Left  := imgP4C1.Left - 11;
      imgP4C1.Top :=  imgP4C1.Top - 16;

      imgP4C1.Height  := imgP4C1.Height - 4;
      imgP4C1.Width :=  imgP4C1.Width - 4;

       //P4C2
      imgP4C2.Left  := imgP4C2.Left - 14;
      imgP4C2.Top :=  imgP4C2.Top - 16;

      imgP4C2.Height  := imgP4C2.Height - 4;
      imgP4C2.Width :=  imgP4C2.Width - 4;

      //from P3 pos to P1 pos
      //P3C1
      imgP3C1.Left  := imgP3C1.Left + 11;
      imgP3C1.Top :=  imgP3C1.Top + 16;

      imgP3C1.Height  := imgP3C1.Height + 4;
      imgP3C1.Width :=  imgP3C1.Width + 4;

       //P2C2
      imgP3C2.Left  := imgP3C2.Left + 14;
      imgP3C2.Top :=  imgP3C2.Top + 16;

      imgP3C2.Height  := imgP3C2.Height + 4;
      imgP3C2.Width :=  imgP3C2.Width + 4;

       Sleep(5);
       Refresh;
     End;


      //P3 pos
      with imgP4C1 do
      begin
        Height := 151;
        Left := 286;
        Top := 130;
        Width := 99;
      end;

      with imgP4C2 do
      begin
        Height := 151;
        Left := 391;
        Top := 130;
        Width := 99;
      end;

      //P1 pos
      with imgP3C1 do
      begin
        Height := 271;
        Left := 504;
        Top := 432;
        Width := 176
      end;

      with imgP3C2 do
      begin
        Height := 271;
        Left := 697;
        Top := 432;
        Width := 176
      end;

      lblPlayer2.Caption := sPlayer4 + ': P' + FloatToStrF(rP4Parkbucks,ffFixed,6,2);
      lblCurrentPlayer.Caption := sPlayer3 + ': P' + FloatToStrF(rP3Parkbucks,ffFixed,6,2);

      lblShowCards.Visible := True;

      sCurrentPlayer := sPlayer3;

     MessageDlg(sPlayer3 + #39 + 's turn',mtInformation,[mbOK],0);
   end;

  end;

   if (sCurrentPlayer = sPlayer1) and bP1Raiser then
    begin
      if bRiver then
      begin
         iCheck := iNumPlayers * 3;
         iCall := iNumPlayers * 3 ;
      end
      else if bTurn then
           begin
         iCheck := iNumPlayers * 4;
         iCall := iNumPlayers * 4;
      end
      else  if bFlop1 then
      begin
         iCheck := iNumPlayers * 2;
         iCall := iNumPlayers * 2;
      end
      else
      begin
         iCheck := iNumPlayers;
         iCall := iNumPlayers;
      end;
    end
    else
    if (sCurrentPlayer = sPlayer2) and bP2Raiser then
    begin
      if bRiver then
      begin
         iCheck := iNumPlayers * 3;
         iCall := iNumPlayers * 3 ;
      end
      else if bTurn then
           begin
         iCheck := iNumPlayers * 4;
         iCall := iNumPlayers * 4;
      end
      else  if bFlop1 then
      begin
         iCheck := iNumPlayers * 2;
         iCall := iNumPlayers * 2;
      end
      else
      begin
         iCheck := iNumPlayers;
         iCall := iNumPlayers;
      end;
    end
    else
    if (sCurrentPlayer = sPlayer3) and bP3Raiser then
    begin
     if bRiver then
      begin
         iCheck := iNumPlayers * 3;
         iCall := iNumPlayers * 3 ;
      end
      else if bTurn then
           begin
         iCheck := iNumPlayers * 4;
         iCall := iNumPlayers * 4;
      end
      else  if bFlop1 then
      begin
         iCheck := iNumPlayers * 2;
         iCall := iNumPlayers * 2;
      end
      else
      begin
         iCheck := iNumPlayers;
         iCall := iNumPlayers;
      end;
    end
    else
    if (sCurrentPlayer = sPlayer4) and bP4Raiser then
    begin
      if bRiver then
      begin
         iCheck := iNumPlayers * 3;
         iCall := iNumPlayers * 3 ;
      end
      else if bTurn then
           begin
         iCheck := iNumPlayers * 4;
         iCall := iNumPlayers * 4;
      end
      else  if bFlop1 then
      begin
         iCheck := iNumPlayers * 2;
         iCall := iNumPlayers * 2;
      end
      else
      begin
         iCheck := iNumPlayers;
         iCall := iNumPlayers;
      end;
    end;



end;

procedure TfrmBaseGameLVM.Option1;
begin

  if (iNumPlayers = 4)  then
  begin
     if iNumFold <> 2 then
   begin
    if (sCurrentPlayer = sPlayer1) and bFoldP4 then
    begin
      if bCall then
       Inc(iCall)
       else
       Inc(iCheck);
    end
    else
    if (sCurrentPlayer = sPlayer2) and bFoldP1 then
    begin
      if bCall then
       Inc(iCall)
       else
       Inc(iCheck);
    end
    else
    if (sCurrentPlayer = sPlayer3) and bFoldP2 then
    begin
      if bCall then
       Inc(iCall)
       else
       Inc(iCheck);
    end
    else
    if (sCurrentPlayer = sPlayer4) and bFoldP3 then
    begin
      if bCall then
       Inc(iCall)
       else
       Inc(iCheck);
    end;
   end
   else
   begin
     if bCall then
       Inc(iCall)
       else
       Inc(iCheck);

   end;
  end;



  if iNumPlayers = 3 then
  begin
    if (sCurrentPlayer = sPlayer1) and bFoldP3 then
    begin
      if bCall then
       Inc(iCall)
       else
       Inc(iCheck)
    end
    else
    if (sCurrentPlayer = sPlayer2) and bFoldP1 then
    begin
      if bCall then
       Inc(iCall)
       else
       Inc(iCheck)
    end
    else
    if (sCurrentPlayer = sPlayer3) and bFoldP2 then
    begin
      if bCall then
       Inc(iCall)
       else
       Inc(iCheck)
    end;
  end;

  if iNumPlayers = 2 then
  begin
    if (sCurrentPlayer = sPlayer1) and bFoldP2 then
    begin
      if bCall then
       Inc(iCall)
       else
       Inc(iCheck)
    end
    else
    if (sCurrentPlayer = sPlayer2) and bFoldP1 then
    begin
      if bCall then
       Inc(iCall)
       else
       Inc(iCheck)
    end;
  end;


  if (lblOption1.Caption = '- Check')  then
    begin
      Inc(iCheck);
    end;

  if  bCall then
    begin
      if sCurrentPlayer = sPlayer1 then
        begin
           if rP1Parkbucks <= rRaise then
               begin
                 rP1Parkbucks := 0;
                 rPot := rPot + rP1Parkbucks;
                 lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
               end
           else
           begin
            rP1Parkbucks := rP1Parkbucks - rRaise;
            rPot := rPot + rRaise;
            lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
           end;

        end
        else
      if sCurrentPlayer = sPlayer2 then
        begin
          if rP2Parkbucks <= rRaise then
               begin
                 rP2Parkbucks := 0;
                 rPot := rPot + rP2Parkbucks;
                 lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
               end
           else
           begin
            rP2Parkbucks := rP2Parkbucks - rRaise;
            rPot := rPot + rRaise;
            lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
           end;

          end
        else
      if sCurrentPlayer = sPlayer3 then
        begin
            if rP3Parkbucks <= rRaise then
               begin
                 rP3Parkbucks := 0;
                 rPot := rPot + rP3Parkbucks;
                 lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
               end
           else
           begin
            rP3Parkbucks := rP1Parkbucks - rRaise;
            rPot := rPot + rRaise;
            lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
           end;

        end
        else
      if sCurrentPlayer = sPlayer4 then
        begin
            if rP4Parkbucks <= rRaise then
               begin
                 rP4Parkbucks := 0;
                 rPot := rPot + rP4Parkbucks;
                 lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
               end
           else
           begin
            rP4Parkbucks := rP4Parkbucks - rRaise;
            rPot := rPot + rRaise;
            lblPotAmmount.Caption := 'P' + FloatToStrF(rPot,ffFixed,6,2);
           end;
        end;
          Inc(iCall);
    end;


   if (sCurrentPlayer = sPlayer1) and bP1Raiser then
    begin
      if bRiver then
      begin
         iCheck := iNumPlayers * 3;
         iCall := iNumPlayers * 3 ;
      end
      else if bTurn then
           begin
         iCheck := iNumPlayers * 4;
         iCall := iNumPlayers * 4;
      end
      else  if bFlop1 then
      begin
         iCheck := iNumPlayers * 2;
         iCall := iNumPlayers * 2;
      end
      else
      begin
         iCheck := iNumPlayers;
         iCall := iNumPlayers;
      end;
    end
    else
    if (sCurrentPlayer = sPlayer2) and bP2Raiser then
    begin
      if bRiver then
      begin
         iCheck := iNumPlayers * 3;
         iCall := iNumPlayers * 3 ;
      end
      else if bTurn then
           begin
         iCheck := iNumPlayers * 4;
         iCall := iNumPlayers * 4;
      end
      else  if bFlop1 then
      begin
         iCheck := iNumPlayers * 2;
         iCall := iNumPlayers * 2;
      end
      else
      begin
         iCheck := iNumPlayers;
         iCall := iNumPlayers;
      end;
    end
    else
    if (sCurrentPlayer = sPlayer3) and bP3Raiser then
    begin
     if bRiver then
      begin
         iCheck := iNumPlayers * 3;
         iCall := iNumPlayers * 3 ;
      end
      else if bTurn then
           begin
         iCheck := iNumPlayers * 4;
         iCall := iNumPlayers * 4;
      end
      else  if bFlop1 then
      begin
         iCheck := iNumPlayers * 2;
         iCall := iNumPlayers * 2;
      end
      else
      begin
         iCheck := iNumPlayers;
         iCall := iNumPlayers;
      end;
    end
    else
    if (sCurrentPlayer = sPlayer4) and bP4Raiser then
    begin
      if bRiver then
      begin
         iCheck := iNumPlayers * 3;
         iCall := iNumPlayers * 3 ;
      end
      else if bTurn then
           begin
         iCheck := iNumPlayers * 4;
         iCall := iNumPlayers * 4;
      end
      else  if bFlop1 then
      begin
         iCheck := iNumPlayers * 2;
         iCall := iNumPlayers * 2;
      end
      else
      begin
         iCheck := iNumPlayers;
         iCall := iNumPlayers;
      end;
    end;



   if (iCall > iNumPlayers * 4) or (iCheck > iNumPlayers * 4) then
    begin
      iCheck := iNumPlayers * 4;
      iCall := iNumPlayers * 4;
    end;


  if bCall then
 begin
 if (iCall / (iNumPlayers ) = 1)  then
  begin
     Flop;
     lblOption1.Caption := '- Check';
     bCall := False;
     iCheck := iNumPlayers;
  end
  else
 if (iCall / (iNumPlayers ) = 2)  then
  begin
     Turn;
     lblOption1.Caption := '- Check';
     bCall := False;
     iCheck := iNumPlayers * 2;
  end
  else
 if (iCall / (iNumPlayers ) = 3)  then
  begin
     River;
     lblOption1.Caption := '- Check';
     bCall := False;
     iCheck := iNumPlayers * 3;
  end
  else
 if (iCall / (iNumPlayers) = 4)  then
  begin
     lblOption1.Visible := False;
     lblOption3.Visible := False;
     lblOption2.Caption := '- Showdown';
  end;
 end
 else
 begin
   if (iCheck / iNumPlayers = 1) then
  begin
     Flop;
     lblOption1.Caption := '- Check';
     bCall := False;
     iCheck := iNumPlayers;
  end
  else
 if (iCheck / iNumPlayers = 2) then
  begin
     Turn;
     lblOption1.Caption := '- Check';
     bCall := False;
     iCheck := iNumPlayers * 2;
  end
  else
 if (iCheck / iNumPlayers = 3) then
  begin
     River;
     lblOption1.Caption := '- Check';
     bCall := False;
     iCheck := iNumPlayers * 3;
  end
  else
 if (iCheck / iNumPlayers = 4) then
  begin
     lblOption1.Visible := False;
     lblOption3.Visible := False;
     lblOption2.Caption := '- Showdown';
  end;
 end;

 if rP1Parkbucks < 0 then
 rP1Parkbucks := 0;
 if rP2Parkbucks < 0 then
 rP2Parkbucks := 0;
 if rP3Parkbucks < 0 then
 rP3Parkbucks := 0;
 if rP4Parkbucks < 0 then
 rP4Parkbucks := 0;



  if (iNumPlayers = 4) and (iNumFold = 2) then
    begin
      NextTurnMoveFolded;
    end
    else
    begin
      CheckFold;
      NextTurnMove;
    end;

end;

procedure TfrmBaseGameLVM.Option2;
  var
  K : Integer;
begin
  bP1Raiser := False;
  bP2Raiser := False;
  bP3Raiser := False;
  bP4Raiser := False;

  if sCurrentPlayer = sPlayer1 then
    bP1Raiser := True
  else
  if sCurrentPlayer = sPlayer2 then
    bP2Raiser := True
  else
  if sCurrentPlayer = sPlayer3 then
    bP3Raiser := True
  else
  if sCurrentPlayer = sPlayer4 then
    bP4Raiser := True;




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

        tmrFlashGo.Enabled := True;

      end
      else
      if lblOption2.Caption = '- Reveal Flop' then
           begin
            imgCom1.Picture.LoadFromFile('Cards\' + sCommunityCard1 + '.png');
            imgCom2.Picture.LoadFromFile('Cards\' + sCommunityCard2 + '.png');
            imgCom3.Picture.LoadFromFile('Cards\' + sCommunityCard3 + '.png');

            lblOption1.Visible := True;
            lblOption2.Caption := '- Raise';
            lblOption3.Visible := True;

            bFlop1 := True;
            bFlop2 := True;
            bFlop3 := True;
           end
      else
      if lblOption2.Caption = '- Reveal Turn' then
           begin
            imgCom4.Picture.LoadFromFile('Cards\' + sCommunityCard4 + '.png');

            lblOption1.Visible := True;
            lblOption2.Caption := '- Raise';
            lblOption3.Visible := True;

            bTurn  := True;
           end
      else
      if lblOption2.Caption = '- Reveal River' then
           begin
            imgCom5.Picture.LoadFromFile('Cards\' + sCommunityCard5 + '.png');

            lblOption1.Visible := True;
            lblOption2.Caption := '- Raise';
            lblOption3.Visible := True;

            bRiver := True;
           end;

      if lblOption2.Caption = '- Showdown' then
        begin
          Showdown;
          RoundEnd;
        end;

end;

procedure TfrmBaseGameLVM.Option3;
begin


 if sCurrentPlayer = sPlayer1 then
 begin
   bFoldP1 := True;
   Inc(iNumFold);

 end
 else
 if sCurrentPlayer = sPlayer2 then
 begin
   bFoldP2 := True;
   Inc(iNumFold);
 end
 else
 if sCurrentPlayer = sPlayer3 then
 begin
   bFoldP3 := True;
   Inc(iNumFold);
 end
 else
 if sCurrentPlayer = sPlayer4 then
 begin
   bFoldP4 := True;
   Inc(iNumFold);
 end;


 if (iNumPlayers =  4) and (iNumFold = 2) then
  begin
    ChangeLayout;
  end
  else
 if iNumFold = iNumPlayers - 1
 then
  WinByFold
  else
   begin
    CheckFold;
    NextTurnMove;
   end;
end;

procedure TfrmBaseGameLVM.River;
begin
   lblOption1.Visible := False;
   lblOption3.Visible := False;
   lblOption2.Caption := '- Reveal River';
end;

procedure TfrmBaseGameLVM.RoundEnd;
  var
  sAccountID : string;
  rWinRate, rParkbucksEarned : Real;
begin
    Sleep(1000);

  with pnlEndRound do
    begin
      Visible := True;
      Height := 257;
      Left := 544;
      Top := 145;
      Width := 281;
    end;


    //Update stats
    with dmLoginStats do
    begin
      tblStats.Open;
      tblAccounts.Open;

       if tblAccounts.Locate('Username',sLoginUsername,[])then
        begin
         sAccountID := tblAccounts['AccountID'];

         if tblStats.Locate('AccountID',sAccountID,[]) then
          begin
            tblStats.DisableControls;
            tblStats.Edit;

            if sWinner = sPlayer1 then
             tblStats['HandsWon'] := tblStats['HandsWon'] + 1
            else
            tblStats['HandsLost'] := tblStats['HandsLost'] + 1;

            if bFoldP1 then
            tblStats['Folds'] := tblStats['Folds'] + 1;

            rWinRate := (tblStats['HandsWon'] / tblStats['HandsLost']) * 100;

            tblStats['WinRate'] := rWinRate;

            rParkbucksEarned := rP1Parkbucks - rBuyin;

            tblStats['TotalParkbucksEarned'] := tblStats['TotalParkbucksEarned'] + rParkbucksEarned;

            tblStats.Post;
            tblStats.First;
            tblStats.EnableControls;

          end;

        end;
    end;

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
               sBigBlind := sPlayer1;
               sSmallBlind := sPlayer2;
               rDonated1 := (10/100 * rP1Parkbucks);
               rDonated2 := (5/100 * rP2Parkbucks);
               rP1Parkbucks := rP1Parkbucks - (10/100 * rP1Parkbucks);
               rP2Parkbucks := rP2Parkbucks - (5/100 * rP2Parkbucks);
               lblCurrentPlayer.Caption := sPlayer1 + ': P' + FloatToStrF(rP1Parkbucks,ffFixed,6,2);
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




procedure TfrmBaseGameLVM.Showdown;
  var
  sHand1, sHand2, sHand3, sHand4 : string;
begin

//Reveal all cards
if (iNumPlayers = 4) then
  begin
    if not bFoldP1 then
    begin
    imgP1C1.Picture.LoadFromFile('Cards\' + sPlayer1Card1 + '.png');
    imgP1C2.Picture.LoadFromFile('Cards\' + sPlayer1Card2 + '.png');
    end;

    if not bFoldP2 then
    begin
    imgP2C1.Picture.LoadFromFile('Cards\' + sPlayer2Card1 + '.png');
    imgP2C2.Picture.LoadFromFile('Cards\' + sPlayer2Card2 + '.png');
    end;

    if not bFoldP3 then
    begin
    imgP3C1.Picture.LoadFromFile('Cards\' + sPlayer3Card1 + '.png');
    imgP3C2.Picture.LoadFromFile('Cards\' + sPlayer3Card2 + '.png');
    end;

    if not bFoldP4 then
    begin
    imgP4C1.Picture.LoadFromFile('Cards\' + sPlayer4Card1 + '.png');
    imgP4C2.Picture.LoadFromFile('Cards\' + sPlayer4Card2 + '.png');
    end;
  end
  else
  if iNumPlayers = 3 then
  begin
   if not bFoldP1 then
    begin
    imgP1C1.Picture.LoadFromFile('Cards\' + sPlayer1Card1 + '.png');
    imgP1C2.Picture.LoadFromFile('Cards\' + sPlayer1Card2 + '.png');
    end;

    if not bFoldP2 then
    begin
    imgP2C1.Picture.LoadFromFile('Cards\' + sPlayer2Card1 + '.png');
    imgP2C2.Picture.LoadFromFile('Cards\' + sPlayer2Card2 + '.png');
    end;

    if not bFoldP3 then
    begin
    imgP3C1.Picture.LoadFromFile('Cards\' + sPlayer3Card1 + '.png');
    imgP3C2.Picture.LoadFromFile('Cards\' + sPlayer3Card2 + '.png');
    end;
  end
  else
  if iNumPlayers = 2 then
  begin
    imgP1C1.Picture.LoadFromFile('Cards\' + sPlayer1Card1 + '.png');
    imgP1C2.Picture.LoadFromFile('Cards\' + sPlayer1Card2 + '.png');

    imgP2C1.Picture.LoadFromFile('Cards\' + sPlayer2Card1 + '.png');
    imgP2C2.Picture.LoadFromFile('Cards\' + sPlayer2Card2 + '.png');
  end;

  //Hands
   GetCardInfo(sCommunityCard1);
   GetCardInfo(sCommunityCard2);
   GetCardInfo(sCommunityCard3);
   GetCardInfo(sCommunityCard4);
   GetCardInfo(sCommunityCard5);

  if (iNumPlayers = 4) then
  begin
    GetCardInfo(sPlayer1Card1);
    GetCardInfo(sPlayer1Card2);
    GetCardInfo(sPlayer2Card1);
    GetCardInfo(sPlayer2Card2);
    GetCardInfo(sPlayer2Card1);
    GetCardInfo(sPlayer3Card1);
    GetCardInfo(sPlayer3Card2);
    GetCardInfo(sPlayer4Card1);
    GetCardInfo(sPlayer4Card2);

    DetermineHand('Player1');
    DetermineHand('Player2');
    DetermineHand('Player3');
    DetermineHand('Player4');
  end
  else
  if iNumPlayers = 3 then
  begin
    GetCardInfo(sPlayer1Card1);
    GetCardInfo(sPlayer1Card2);
    GetCardInfo(sPlayer2Card1);
    GetCardInfo(sPlayer2Card2);
    GetCardInfo(sPlayer2Card1);
    GetCardInfo(sPlayer3Card1);
    GetCardInfo(sPlayer3Card2);

    DetermineHand('Player1');
    DetermineHand('Player2');
    DetermineHand('Player3');
  end
  else
  if iNumPlayers = 2 then
  begin
    GetCardInfo(sPlayer1Card1);
    GetCardInfo(sPlayer1Card2);
    GetCardInfo(sPlayer2Card1);
    GetCardInfo(sPlayer2Card2);
    GetCardInfo(sPlayer2Card1);

    DetermineHand('Player1');
    DetermineHand('Player2');
  end;

  if bFoldP1 then
  rP1HandRank := 0;
   if bFoldP2 then
  rP1HandRank := 0;
   if bFoldP3 then
  rP1HandRank := 0;
   if bFoldP4 then
  rP1HandRank := 0;


 if (iNumPlayers = 4) then
 begin

    //sHand P1
  if Floor(rP1HandRank) = 1 then
    sHand1 := 'HIGH CARD'
  else
  if Floor(rP1HandRank) = 2 then
    sHand1 := 'PAIR'
  else
  if Floor(rP1HandRank) = 3 then
    sHand1 := '3 OF A KIND'
  else
  if Floor(rP1HandRank) = 4 then
    sHand1 := 'TWO PAIR'
  else
  if Floor(rP1HandRank) = 5 then
    sHand1 := 'STRAIGHT'
  else
  if Floor(rP1HandRank) = 6 then
    sHand1 := 'FLUSH'
  else
  if Floor(rP1HandRank) = 7 then
    sHand1 := 'FULL HOUSE'
  else
  if Floor(rP1HandRank) = 8 then
    sHand1 := '4 OF A KIND'
  else
  if Floor(rP1HandRank) = 9 then
    sHand1 := 'STRAIGHT FLUSH'
  else
  if Floor(rP1HandRank) = 10 then
    sHand1 := 'ROYAL FLUSH';

  //sHand P2
  if Floor(rP2HandRank) = 1 then
    sHand2 := 'HIGH CARD'
  else
  if Floor(rP2HandRank) = 2 then
    sHand2 := 'PAIR'
  else
  if Floor(rP2HandRank) = 3 then
    sHand2 := '3 OF A KIND'
  else
  if Floor(rP2HandRank) = 4 then
    sHand2 := 'TWO PAIR'
  else
  if Floor(rP2HandRank) = 5 then
    sHand2 := 'STRAIGHT'
  else
  if Floor(rP2HandRank) = 6 then
    sHand2 := 'FLUSH'
  else
  if Floor(rP2HandRank) = 7 then
    sHand2 := 'FULL HOUSE'
  else
  if Floor(rP2HandRank) = 8 then
    sHand2 := '4 OF A KIND'
  else
  if Floor(rP2HandRank) = 9 then
    sHand2 := 'STRAIGHT FLUSH'
  else
  if Floor(rP2HandRank) = 10 then
    sHand2 := 'ROYAL FLUSH';

   //sHand P3
  if Floor(rP3HandRank) = 1 then
    sHand3 := 'HIGH CARD'
  else
  if Floor(rP3HandRank) = 2 then
    sHand3 := 'PAIR'
  else
  if Floor(rP3HandRank) = 3 then
    sHand3 := '3 OF A KIND'
  else
  if Floor(rP3HandRank) = 4 then
    sHand3 := 'TWO PAIR'
  else
  if Floor(rP3HandRank) = 5 then
    sHand3 := 'STRAIGHT'
  else
  if Floor(rP3HandRank) = 6 then
    sHand3 := 'FLUSH'
  else
  if Floor(rP3HandRank) = 7 then
    sHand3 := 'FULL HOUSE'
  else
  if Floor(rP3HandRank) = 8 then
    sHand3 := '4 OF A KIND'
  else
  if Floor(rP3HandRank) = 9 then
    sHand3 := 'STRAIGHT FLUSH'
  else
  if Floor(rP3HandRank) = 10 then
    sHand3 := 'ROYAL FLUSH';

  //sHand P4
  if Floor(rP4HandRank) = 1 then
    sHand4 := 'HIGH CARD'
  else
  if Floor(rP4HandRank) = 2 then
    sHand4 := 'PAIR'
  else
  if Floor(rP4HandRank) = 3 then
    sHand4 := '3 OF A KIND'
  else
  if Floor(rP4HandRank) = 4 then
    sHand4 := 'TWO PAIR'
  else
  if Floor(rP4HandRank) = 5 then
    sHand4 := 'STRAIGHT'
  else
  if Floor(rP4HandRank) = 6 then
    sHand4 := 'FLUSH'
  else
  if Floor(rP4HandRank) = 7 then
    sHand4 := 'FULL HOUSE'
  else
  if Floor(rP4HandRank) = 8 then
    sHand4 := '4 OF A KIND'
  else
  if Floor(rP4HandRank) = 9 then
    sHand4 := 'STRAIGHT FLUSH'
  else
  if Floor(rP4HandRank) = 10 then
    sHand4 := 'ROYAL FLUSH';


  sWinner := '';

   //Winner
 if (rP1HandRank > rP2HandRank) and (rP1HandRank > rP3HandRank) and (rP1HandRank > rP4HandRank) then
  begin
    sWinner := sPlayer1;
  end
  else
  if (rP2HandRank > rP1HandRank) and (rP2HandRank > rP3HandRank) and (rP2HandRank > rP4HandRank) then
    begin
      sWinner := sPlayer2;
    end
    else
  if (rP3HandRank > rP1HandRank) and (rP3HandRank > rP2HandRank) and (rP3HandRank > rP4HandRank) then
    begin
      sWinner := sPlayer3;
    end
  else
  if (rP4HandRank > rP1HandRank) and (rP4HandRank > rP2HandRank) and (rP4HandRank > rP3HandRank) then
    begin
      sWinner := sPlayer4;
    end
    else if (rP1HandRank = rP2HandRank) and (rP1HandRank = rP3HandRank) and (rP1HandRank = rP4HandRank) then
         Kickers;




  if sWinner  = sPlayer1 then
    begin
       MessageDlg(sPlayer1 + ' won the round with a ' + sHand1 ,mtInformation,[mbOK],0);
       WinByShowdown;
    end
  else if sWinner = sPlayer2 then
  begin
     MessageDlg(sPlayer2 + ' won the round with a ' + sHand2 ,mtInformation,[mbOK],0);
     WinByShowdown;
  end
  else if sWinner = sPlayer3 then
  begin
     MessageDlg(sPlayer3 + ' won the round with a ' + sHand3 ,mtInformation,[mbOK],0);
     WinByShowdown;
  end
  else if sWinner = sPlayer4 then
  begin
     MessageDlg(sPlayer4 + ' won the round with a ' + sHand4 ,mtInformation,[mbOK],0);
     WinByShowdown;
  end;
  end
  else
 if iNumPlayers = 3 then
 begin
     //sHand P1
  if Floor(rP1HandRank) = 1 then
    sHand1 := 'HIGH CARD'
  else
  if Floor(rP1HandRank) = 2 then
    sHand1 := 'PAIR'
  else
  if Floor(rP1HandRank) = 3 then
    sHand1 := '3 OF A KIND'
  else
  if Floor(rP1HandRank) = 4 then
    sHand1 := 'TWO PAIR'
  else
  if Floor(rP1HandRank) = 5 then
    sHand1 := 'STRAIGHT'
  else
  if Floor(rP1HandRank) = 6 then
    sHand1 := 'FLUSH'
  else
  if Floor(rP1HandRank) = 7 then
    sHand1 := 'FULL HOUSE'
  else
  if Floor(rP1HandRank) = 8 then
    sHand1 := '4 OF A KIND'
  else
  if Floor(rP1HandRank) = 9 then
    sHand1 := 'STRAIGHT FLUSH'
  else
  if Floor(rP1HandRank) = 10 then
    sHand1 := 'ROYAL FLUSH';

  //sHand P2
  if Floor(rP2HandRank) = 1 then
    sHand2 := 'HIGH CARD'
  else
  if Floor(rP2HandRank) = 2 then
    sHand2 := 'PAIR'
  else
  if Floor(rP2HandRank) = 3 then
    sHand2 := '3 OF A KIND'
  else
  if Floor(rP2HandRank) = 4 then
    sHand2 := 'TWO PAIR'
  else
  if Floor(rP2HandRank) = 5 then
    sHand2 := 'STRAIGHT'
  else
  if Floor(rP2HandRank) = 6 then
    sHand2 := 'FLUSH'
  else
  if Floor(rP2HandRank) = 7 then
    sHand2 := 'FULL HOUSE'
  else
  if Floor(rP2HandRank) = 8 then
    sHand2 := '4 OF A KIND'
  else
  if Floor(rP2HandRank) = 9 then
    sHand2 := 'STRAIGHT FLUSH'
  else
  if Floor(rP2HandRank) = 10 then
    sHand2 := 'ROYAL FLUSH';

   //sHand P3
  if Floor(rP3HandRank) = 1 then
    sHand3 := 'HIGH CARD'
  else
  if Floor(rP3HandRank) = 2 then
    sHand3 := 'PAIR'
  else
  if Floor(rP3HandRank) = 3 then
    sHand3 := '3 OF A KIND'
  else
  if Floor(rP3HandRank) = 4 then
    sHand3 := 'TWO PAIR'
  else
  if Floor(rP3HandRank) = 5 then
    sHand3 := 'STRAIGHT'
  else
  if Floor(rP3HandRank) = 6 then
    sHand3 := 'FLUSH'
  else
  if Floor(rP3HandRank) = 7 then
    sHand3 := 'FULL HOUSE'
  else
  if Floor(rP3HandRank) = 8 then
    sHand3 := '4 OF A KIND'
  else
  if Floor(rP3HandRank) = 9 then
    sHand3 := 'STRAIGHT FLUSH'
  else
  if Floor(rP3HandRank) = 10 then
    sHand3 := 'ROYAL FLUSH';

   //Winner
    if (rP1HandRank > rP2HandRank) and (rP1HandRank > rP3HandRank) then
   begin
    sWinner := sPlayer1;
   end
   else
   if (rP2HandRank > rP1HandRank) and (rP2HandRank > rP3HandRank) then
    begin
      sWinner := sPlayer2;
    end
    else
  if (rP3HandRank > rP1HandRank) and (rP3HandRank > rP2HandRank) then
    begin
      sWinner := sPlayer3;
    end
    else if (rP1HandRank = rP2HandRank) and (rP1HandRank = rP3HandRank) then
         Kickers;

  if sWinner  = sPlayer1 then
    begin
       MessageDlg(sPlayer1 + ' won the round with a ' + sHand1 ,mtInformation,[mbOK],0);
       WinByShowdown;
    end
  else if sWinner = sPlayer2 then
  begin
     MessageDlg(sPlayer2 + ' won the round with a ' + sHand2 ,mtInformation,[mbOK],0);
     WinByShowdown;
  end
  else if sWinner = sPlayer3 then
  begin
     MessageDlg(sPlayer3 + ' won the round with a ' + sHand3 ,mtInformation,[mbOK],0);
     WinByShowdown;
  end;

  end
  else
 if iNumPlayers = 2 then
 begin
    //sHand P1
  if Floor(rP1HandRank) = 1 then
    sHand1 := 'HIGH CARD'
  else
  if Floor(rP1HandRank) = 2 then
    sHand1 := 'PAIR'
  else
  if Floor(rP1HandRank) = 3 then
    sHand1 := '3 OF A KIND'
  else
  if Floor(rP1HandRank) = 4 then
    sHand1 := 'TWO PAIR'
  else
  if Floor(rP1HandRank) = 5 then
    sHand1 := 'STRAIGHT'
  else
  if Floor(rP1HandRank) = 6 then
    sHand1 := 'FLUSH'
  else
  if Floor(rP1HandRank) = 7 then
    sHand1 := 'FULL HOUSE'
  else
  if Floor(rP1HandRank) = 8 then
    sHand1 := '4 OF A KIND'
  else
  if Floor(rP1HandRank) = 9 then
    sHand1 := 'STRAIGHT FLUSH'
  else
  if Floor(rP1HandRank) = 10 then
    sHand1 := 'ROYAL FLUSH';

  //sHand P2
  if Floor(rP2HandRank) = 1 then
    sHand2 := 'HIGH CARD'
  else
  if Floor(rP2HandRank) = 2 then
    sHand2 := 'PAIR'
  else
  if Floor(rP2HandRank) = 3 then
    sHand2 := '3 OF A KIND'
  else
  if Floor(rP2HandRank) = 4 then
    sHand2 := 'TWO PAIR'
  else
  if Floor(rP2HandRank) = 5 then
    sHand2 := 'STRAIGHT'
  else
  if Floor(rP2HandRank) = 6 then
    sHand2 := 'FLUSH'
  else
  if Floor(rP2HandRank) = 7 then
    sHand2 := 'FULL HOUSE'
  else
  if Floor(rP2HandRank) = 8 then
    sHand2 := '4 OF A KIND'
  else
  if Floor(rP2HandRank) = 9 then
    sHand2 := 'STRAIGHT FLUSH'
  else
  if Floor(rP2HandRank) = 10 then
    sHand2 := 'ROYAL FLUSH';


   //Winner
    if (rP1HandRank > rP2HandRank) then
   begin
    sWinner := sPlayer1;
   end
   else
   if (rP2HandRank > rP1HandRank)  then
    begin
      sWinner := sPlayer2;
    end
    else if (rP1HandRank = rP2HandRank) then
         Kickers;

  if sWinner  = sPlayer1 then
    begin
       MessageDlg(sPlayer1 + ' won the round with a ' + sHand1 ,mtInformation,[mbOK],0);
       WinByShowdown;
    end
  else if sWinner = sPlayer2 then
  begin
     MessageDlg(sPlayer2 + ' won the round with a ' + sHand2 ,mtInformation,[mbOK],0);
     WinByShowdown;
  end;
 end;


  lblOption2.Visible := False;


end;

procedure TfrmBaseGameLVM.tmrFlashGoTimer(Sender: TObject);
begin
 if lblGo.Font.Color = clTeal
    then lblGo.Font.Color := clFuchsia
      else if lblGo.Font.Color = clFuchsia
            then lblGo.Font.Color := clTeal;

end;


procedure TfrmBaseGameLVM.Turn;
begin
   lblOption1.Visible := False;
   lblOption3.Visible := False;
   lblOption2.Caption := '- Reveal Turn';
end;

procedure TfrmBaseGameLVM.WinByFold;
begin
 if iNumPlayers = 2 then
   begin
      if bFoldP1 = False then
        begin
          rP1Parkbucks := rP1Parkbucks + rPot;
          rPot := 0;
          MessageDlg('Round winner: ' + sPlayer1, mtInformation,[mbOK],0);
          RoundEnd;
        end
        else
      if bFoldP2 = False then
        begin
          rP2Parkbucks := rP2Parkbucks + rPot;
          rPot := 0;
          MessageDlg('Round winner: ' + sPlayer2, mtInformation,[mbOK],0);
          RoundEnd;
        end;
   end
 else
 if iNumPlayers = 3 then
   begin
    if bFoldP1 = False then
        begin
          rP1Parkbucks := rP1Parkbucks + rPot;
          rPot := 0;
          MessageDlg('Round winner: ' + sPlayer1, mtInformation,[mbOK],0);
          RoundEnd;
        end
        else
    if bFoldP2 = False then
        begin
          rP2Parkbucks := rP2Parkbucks + rPot;
          rPot := 0;
          MessageDlg('Round winner: ' + sPlayer2, mtInformation,[mbOK],0);
          RoundEnd;
        end
        else
    if bFoldP3 = False then
        begin
          rP3Parkbucks := rP3Parkbucks + rPot;
          MessageDlg('Round winner: ' + sPlayer3, mtInformation,[mbOK],0);
          rPot := 0;
          RoundEnd;
        end;

   end
 else
 if (iNumPlayers = 4)  then
 begin
  if bFoldP1 = False then
        begin
          rP1Parkbucks := rP1Parkbucks + rPot;
          rPot := 0;
          MessageDlg('Round winner: ' + sPlayer1, mtInformation,[mbOK],0);
          RoundEnd;
        end
        else
    if bFoldP2 = False then
        begin
          rP2Parkbucks := rP2Parkbucks + rPot;
          rPot := 0;
          MessageDlg('Round winner: ' + sPlayer2, mtInformation,[mbOK],0);
          RoundEnd;
        end
        else
    if bFoldP3 = False then
        begin
          rP3Parkbucks := rP3Parkbucks + rPot;
          rPot := 0;
          MessageDlg('Round winner: ' + sPlayer3, mtInformation,[mbOK],0);
          RoundEnd;
        end
        else
    if bFoldP4 = False then
        begin
          rP4Parkbucks := rP4Parkbucks + rPot;
          rPot := 0;
          MessageDlg('Round winner: ' + sPlayer4, mtInformation,[mbOK],0);
          RoundEnd;
        end;

 end;

end;

procedure TfrmBaseGameLVM.WinByShowdown;
begin
 if iNumPlayers = 2 then
   begin
      if sWinner = sPlayer1 then
        begin
          rP1Parkbucks := rP1Parkbucks + rPot;
          rPot := 0;
          RoundEnd;
        end
        else
      if sWinner = sPlayer2 then
        begin
          rP2Parkbucks := rP2Parkbucks + rPot;
          rPot := 0;
          RoundEnd;
        end;
   end
 else
 if iNumPlayers = 3 then
   begin
    if sWinner = sPlayer1 then
        begin
          rP1Parkbucks := rP1Parkbucks + rPot;
          rPot := 0;
          RoundEnd;
        end
        else
    if sWinner = sPlayer2 then
        begin
          rP2Parkbucks := rP2Parkbucks + rPot;
          rPot := 0;
          RoundEnd;
        end
        else
    if sWinner = sPlayer3 then
        begin
          rP3Parkbucks := rP3Parkbucks + rPot;
          rPot := 0;
          RoundEnd;
        end;

   end
 else
 if (iNumPlayers = 4) or (iNumPlayers = 1) then
 begin
  if sWinner = sPlayer1 then
        begin
          rP1Parkbucks := rP1Parkbucks + rPot;
          rPot := 0;
          RoundEnd;
        end
        else
    if sWinner = sPlayer2 then
        begin
          rP2Parkbucks := rP2Parkbucks + rPot;
          rPot := 0;
          RoundEnd;
        end
        else
    if sWinner = sPlayer3 then
        begin
          rP3Parkbucks := rP3Parkbucks + rPot;
          rPot := 0;
          RoundEnd;
        end
        else
    if sWinner = sPlayer4 then
        begin
          rP4Parkbucks := rP4Parkbucks + rPot;
          rPot := 0;
          RoundEnd;
        end;

 end;


end;

end.
