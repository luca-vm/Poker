object frmAccountsAndStats: TfrmAccountsAndStats
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmAccountsAndStats'
  ClientHeight = 706
  ClientWidth = 860
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblAccounts: TLabel
    Left = 352
    Top = 8
    Width = 140
    Height = 45
    Caption = 'Accounts'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -37
    Font.Name = 'Impact'
    Font.Style = []
    ParentFont = False
  end
  object lblStats: TLabel
    Left = 383
    Top = 342
    Width = 77
    Height = 45
    Caption = 'Stats'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -37
    Font.Name = 'Impact'
    Font.Style = []
    ParentFont = False
  end
  object dbgAccounts: TDBGrid
    Left = 80
    Top = 59
    Width = 689
    Height = 189
    DataSource = dmLoginStats.dsrAccounts
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clRed
    TitleFont.Height = -27
    TitleFont.Name = 'Times New Roman'
    TitleFont.Style = []
  end
  object dbgStats: TDBGrid
    Left = 80
    Top = 393
    Width = 689
    Height = 189
    DataSource = dmLoginStats.dsrStats
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clRed
    TitleFont.Height = -27
    TitleFont.Name = 'Times New Roman'
    TitleFont.Style = []
  end
  object dbnAccounts: TDBNavigator
    Left = 240
    Top = 264
    Width = 340
    Height = 41
    DataSource = dmLoginStats.dsrAccounts
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object dbnStats: TDBNavigator
    Left = 240
    Top = 596
    Width = 340
    Height = 41
    DataSource = dmLoginStats.dsrStats
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object bmbClose: TBitBtn
    Left = 752
    Top = 616
    Width = 83
    Height = 43
    Kind = bkClose
    TabOrder = 4
    OnClick = bmbCloseClick
  end
end
