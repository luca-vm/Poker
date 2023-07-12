object dmLoginStats: TdmLoginStats
  OldCreateOrder = False
  Height = 221
  Width = 436
  object conLoginStats: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=dbLog' +
      'inStats.mdb;Mode=ReadWrite;Persist Security Info=False;Jet OLEDB' +
      ':System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Databas' +
      'e Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking' +
      ' Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bul' +
      'k Transactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Cr' +
      'eate System Database=False;Jet OLEDB:Encrypt Database=False;Jet ' +
      'OLEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Witho' +
      'ut Replica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 80
  end
  object tblAccounts: TADOTable
    Connection = conLoginStats
    CursorType = ctStatic
    TableName = 'tblAccounts'
    Left = 144
    Top = 64
  end
  object tblStats: TADOTable
    Connection = conLoginStats
    CursorType = ctStatic
    TableName = 'tblStats'
    Left = 248
    Top = 64
  end
  object dsrAccounts: TDataSource
    DataSet = tblAccounts
    Left = 144
    Top = 128
  end
  object dsrStats: TDataSource
    DataSet = tblStats
    Left = 248
    Top = 128
  end
end
