object fmYuanTa: TfmYuanTa
  Left = 0
  Top = 0
  Caption = #20803#22823#19979#21934#20171#38754
  ClientHeight = 616
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object YuantaOrd1: TYuantaOrd
    Left = 0
    Top = 264
    Width = 32
    Height = 32
    OnLogonS = YuantaOrd1LogonS
    OnUserDefinsFuncResult = YuantaOrd1UserDefinsFuncResult
    OnOrdRptF = YuantaOrd1OrdRptF
    OnOrdMatF = YuantaOrd1OrdMatF
    OnOrdResult = YuantaOrd1OrdResult
    ControlData = {00000100560A00002B05000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 745
    Height = 73
    Align = alTop
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 16
      Top = 8
      Width = 705
      Height = 57
      Caption = #36899#32218#36039#35338
      TabOrder = 0
      object Label1: TLabel
        Left = 18
        Top = 26
        Width = 35
        Height = 13
        Caption = #30331#20837'ID'
      end
      object Label2: TLabel
        Left = 154
        Top = 26
        Width = 48
        Height = 13
        Caption = #30331#20837#23494#30908
      end
      object Label3: TLabel
        Left = 302
        Top = 26
        Width = 48
        Height = 13
        Caption = #26399#36008#24115#34399
      end
      object btnLogOn: TButton
        Left = 502
        Top = 21
        Width = 75
        Height = 25
        Caption = #30331#20837
        TabOrder = 0
        OnClick = btnLogOnClick
      end
      object edtID: TEdit
        Left = 61
        Top = 23
        Width = 88
        Height = 21
        PasswordChar = '*'
        TabOrder = 1
      end
      object edtPassWord: TEdit
        Left = 207
        Top = 23
        Width = 89
        Height = 21
        PasswordChar = '*'
        TabOrder = 2
      end
      object btnLogOut: TButton
        Left = 588
        Top = 21
        Width = 75
        Height = 25
        Caption = #30331#20986
        TabOrder = 3
        OnClick = btnLogOutClick
      end
      object cbAccount: TComboBox
        Left = 356
        Top = 23
        Width = 126
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
      end
    end
    object YuantaQuote1: TYuantaQuote
      Left = 685
      Top = 0
      Width = 49
      Height = 50
      TabOrder = 1
      OnRegError = YuantaQuote1RegError
      OnGetMktAll = YuantaQuote1GetMktAll
      ControlData = {00000100100500002B05000000000000}
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 73
    Width = 745
    Height = 543
    ActivePage = TabSheet3
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = #24115#34399#31649#29702
      object ListView1: TListView
        Left = 0
        Top = 0
        Width = 737
        Height = 512
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        Columns = <
          item
            Caption = #24115#34399
            Width = 80
          end
          item
            Caption = #20998#20844#21496
            Width = 80
          end
          item
            Caption = #20998#20844#21496#20195#34399
            Width = 80
          end
          item
            Caption = 'ID'
            Width = 100
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        GridLines = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet2: TTabSheet
      Caption = #33258#21205#19979#21934#35373#23450
      ImageIndex = 1
      object CoolBar2: TCoolBar
        Left = 0
        Top = 0
        Width = 737
        Height = 172
        Bands = <
          item
            Control = Panel3
            ImageIndex = -1
            MinHeight = 166
            Width = 735
          end>
        EdgeInner = esNone
        EdgeOuter = esNone
        object Panel3: TPanel
          Left = 12
          Top = 0
          Width = 721
          Height = 166
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object btnAutoBuy: TButton
            Left = 528
            Top = 22
            Width = 86
            Height = 25
            Caption = #25163#21205#26399#36008#19979#21934
            TabOrder = 0
            OnClick = btnAutoBuyClick
          end
          object GroupBox4: TGroupBox
            Left = 0
            Top = 4
            Width = 289
            Height = 53
            Caption = #19979#21934#21443#25976#35373#23450
            TabOrder = 1
            object Label5: TLabel
              Left = 131
              Top = 27
              Width = 72
              Height = 14
              Caption = #19979#21934#22522#26412#21475#25976
            end
            object Label6: TLabel
              Left = 7
              Top = 27
              Width = 48
              Height = 14
              Caption = #21830#21697#36984#25799
            end
            object cbbCommNO: TComboBox
              Left = 61
              Top = 23
              Width = 64
              Height = 22
              ItemHeight = 14
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Text = 'TX00'
              Items.Strings = (
                'TX00'
                'MTX00')
            end
            object edtQty: TEdit
              Left = 209
              Top = 24
              Width = 67
              Height = 20
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 1
              Text = '0'
            end
          end
          object btnBalance: TButton
            Left = 295
            Top = 24
            Width = 86
            Height = 25
            Caption = #25163#21205#24179#20489
            TabOrder = 2
          end
          object cbAutoBalance: TCheckBox
            Left = 457
            Top = 26
            Width = 65
            Height = 17
            Caption = #33258#21205#24179#20489
            TabOrder = 3
          end
          object cbbBalance: TComboBox
            Left = 387
            Top = 25
            Width = 64
            Height = 22
            ItemHeight = 14
            TabOrder = 4
            Items.Strings = (
              '09:00'
              '09:30'
              '10:00'
              '10:30'
              '11:00'
              '11:30'
              '12:00'
              '12:30'
              '13:00'
              '13:30')
          end
          object btnOpenInterest: TButton
            Left = 620
            Top = 22
            Width = 86
            Height = 25
            Caption = #26410#24179#20489#24235#23384
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = btnOpenInterestClick
          end
          object GroupBox2: TGroupBox
            Left = 0
            Top = 59
            Width = 705
            Height = 102
            Caption = #19979#21934#22996#35351
            TabOrder = 6
            object Label4: TLabel
              Left = 131
              Top = 27
              Width = 36
              Height = 14
              Caption = #21830#21697#39006
            end
            object Label8: TLabel
              Left = 7
              Top = 27
              Width = 36
              Height = 14
              Caption = #21151#33021#21029
            end
            object Label9: TLabel
              Left = 379
              Top = 27
              Width = 24
              Height = 14
              Caption = #20729#26684
              Visible = False
            end
            object Label7: TLabel
              Left = 486
              Top = 27
              Width = 99
              Height = 14
              Caption = #22996#35351#26360'('#21034#21934'/'#25913#20729')'
              Visible = False
            end
            object Label10: TLabel
              Left = 252
              Top = 27
              Width = 48
              Height = 14
              Caption = #22996#35351#26041#24335
            end
            object cbbFuctionType: TComboBox
              Left = 61
              Top = 24
              Width = 64
              Height = 22
              ItemHeight = 14
              TabOrder = 0
              Text = '01-'#22996#35351
              Items.Strings = (
                '01-'#22996#35351
                '02-'#28187#37327
                '03-'#21034#21934)
            end
            object cbbCommType: TComboBox
              Left = 174
              Top = 24
              Width = 64
              Height = 22
              ItemHeight = 14
              TabOrder = 1
              Text = '0-'#26399#36008
              Items.Strings = (
                '0-'#26399#36008
                '1-'#36984#25799#27402
                '4-'#26399#36008#20729#24046)
            end
            object edtPrice: TEdit
              Left = 409
              Top = 25
              Width = 67
              Height = 20
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 2
              Visible = False
            end
            object rgTradeType: TRadioGroup
              Left = 7
              Top = 61
              Width = 144
              Height = 38
              Caption = #19979#21934#26781#20214
              Columns = 3
              ItemIndex = 2
              Items.Strings = (
                'ROD'
                'IOC'
                'FOK')
              TabOrder = 3
            end
            object rgBuySell: TRadioGroup
              Left = 157
              Top = 61
              Width = 87
              Height = 38
              Caption = #36023#36067#21029
              Columns = 2
              ItemIndex = 0
              Items.Strings = (
                'Buy'
                'Sell')
              TabOrder = 4
            end
            object edtOrderNO: TEdit
              Left = 591
              Top = 25
              Width = 67
              Height = 20
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 5
              Visible = False
            end
            object cbbOrderType: TComboBox
              Left = 306
              Top = 24
              Width = 64
              Height = 22
              ItemHeight = 14
              TabOrder = 6
              Text = '0-'#26032#20489
              Items.Strings = (
                '0-'#26032#20489
                '1-'#24179#20489
                '2-'#30070#27798
                ' -'#33258#21205)
            end
          end
        end
      end
      object ListView3: TListView
        Left = 0
        Top = 172
        Width = 737
        Height = 340
        Align = alClient
        Columns = <
          item
            Caption = #24115#34399
            Width = 100
          end
          item
            Caption = #26178#38291
            Width = 100
          end
          item
            Caption = #21830#21697
            Width = 80
          end
          item
            Caption = #36023#36067#21029
          end
          item
            Caption = #26781#20214
          end
          item
            Caption = #20729#26684
            Width = 80
          end
          item
            Caption = #21475#25976
          end
          item
            Caption = #24207#34399
            Width = 80
          end
          item
            Caption = #35338#24687
            Width = 300
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        GridLines = True
        RowSelect = True
        ParentFont = False
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
    object TabSheet6: TTabSheet
      Caption = #22577#20729
      ImageIndex = 2
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 737
        Height = 73
        Align = alTop
        Caption = 'Panel4'
        ShowCaption = False
        TabOrder = 0
        object btnQuote: TButton
          Left = 12
          Top = 8
          Width = 86
          Height = 25
          Caption = #21830#21697#35387#20874
          TabOrder = 0
          OnClick = btnQuoteClick
        end
        object btnCancelQuote: TButton
          Left = 12
          Top = 39
          Width = 86
          Height = 25
          Caption = #21462#28040#21830#21697
          TabOrder = 1
          OnClick = btnCancelQuoteClick
        end
        object btnQuoteCurve: TButton
          Left = 104
          Top = 8
          Width = 86
          Height = 25
          Caption = #22577#20729#26354#32218
          TabOrder = 2
          OnClick = btnQuoteCurveClick
        end
      end
      object lvQuote: TListView
        Left = 0
        Top = 73
        Width = 737
        Height = 439
        Align = alClient
        Columns = <
          item
            Caption = #24115#34399
            Width = 100
          end
          item
            Caption = #26178#38291
            Width = 100
          end
          item
            Caption = #21830#21697
            Width = 80
          end
          item
            Caption = #36023#36067#21029
          end
          item
            Caption = #26781#20214
          end
          item
            Caption = #20729#26684
            Width = 80
          end
          item
            Caption = #21475#25976
          end
          item
            Caption = #24207#34399
            Width = 80
          end
          item
            Caption = #35338#24687
            Width = 300
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        GridLines = True
        RowSelect = True
        ParentFont = False
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
    object TabSheet4: TTabSheet
      Caption = #19979#21934#35352#37636#21450#25613#30410
      ImageIndex = 3
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 737
        Height = 49
        Align = alTop
        TabOrder = 0
        object Label11: TLabel
          Left = 205
          Top = 20
          Width = 9
          Height = 16
          Caption = '~'
        end
        object RecordStart: TDateTimePicker
          Left = 93
          Top = 16
          Width = 105
          Height = 22
          Date = 40939.531195381950000000
          Time = 40939.531195381950000000
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object RecordEnd: TDateTimePicker
          Left = 221
          Top = 16
          Width = 105
          Height = 22
          Date = 40939.531195381950000000
          Time = 40939.531195381950000000
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object cbRecordDate: TCheckBox
          Left = 0
          Top = 19
          Width = 87
          Height = 17
          Caption = #32000#37636#39023#31034#21312#38291
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
      object DBGrid_Record: TDBGrid
        Left = 0
        Top = 49
        Width = 737
        Height = 463
        Align = alClient
        DataSource = DataModule1.dsTradeRecord
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'SN'
            Font.Charset = CHINESEBIG5_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#32048#26126#39636
            Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TradeDate'
            Font.Charset = CHINESEBIG5_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#32048#26126#39636
            Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TradeTime'
            Font.Charset = CHINESEBIG5_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#32048#26126#39636
            Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Account'
            Font.Charset = CHINESEBIG5_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#32048#26126#39636
            Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'StockNM'
            Font.Charset = CHINESEBIG5_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#32048#26126#39636
            Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BuySell'
            Font.Charset = CHINESEBIG5_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#32048#26126#39636
            Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Criteria'
            Font.Charset = CHINESEBIG5_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#32048#26126#39636
            Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Price'
            Font.Charset = CHINESEBIG5_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#32048#26126#39636
            Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Qty'
            Font.Charset = CHINESEBIG5_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#32048#26126#39636
            Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Balance'
            Font.Charset = CHINESEBIG5_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#32048#26126#39636
            Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TradeSN'
            Font.Charset = CHINESEBIG5_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#32048#26126#39636
            Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Msg'
            Font.Charset = CHINESEBIG5_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#32048#26126#39636
            Font.Style = []
            Width = 100
            Visible = True
          end>
      end
    end
    object tsOpenInterest: TTabSheet
      Caption = #26410#24179#20489#20839#23481
      ImageIndex = 5
      object StringGrid1: TStringGrid
        Left = 0
        Top = 0
        Width = 737
        Height = 512
        Align = alClient
        FixedCols = 0
        TabOrder = 0
        ColWidths = (
          140
          169
          111
          104
          170)
      end
      object ListV_Interest: TListView
        Left = 0
        Top = 0
        Width = 737
        Height = 512
        Align = alClient
        Columns = <
          item
            Caption = #24115#34399
            Width = 100
          end
          item
            Caption = #21830#21697
            Width = 80
          end
          item
            Caption = #36023#36067#21029
          end
          item
            Caption = #26410#24179#20489#37096#20301
            Width = 300
          end
          item
            Caption = #24179#22343#25104#26412
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        GridLines = True
        RowSelect = True
        ParentFont = False
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
    object TabSheet3: TTabSheet
      Caption = #21443#25976#35373#23450
      ImageIndex = 5
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 737
        Height = 512
        Align = alClient
        Caption = 'Panel2'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #26032#32048#26126#39636
        Font.Style = []
        ParentFont = False
        ShowCaption = False
        TabOrder = 0
        object GroupBox3: TGroupBox
          Left = 12
          Top = 41
          Width = 717
          Height = 117
          Caption = 'K'#31359#22343#27169#32068
          TabOrder = 0
          object Label40: TLabel
            Left = 138
            Top = 22
            Width = 80
            Height = 12
            Caption = 'A6.'#21453'/'#38918#24335#20999#25563
          end
          object Label13: TLabel
            Left = 557
            Top = 22
            Width = 90
            Height = 12
            Caption = 'A11.TURN'#40670#31684#22285
          end
          object Label14: TLabel
            Left = 227
            Top = 22
            Width = 96
            Height = 12
            Caption = 'A7.'#21069'K/'#30070'K'#25910#31684#22285
          end
          object Label41: TLabel
            Left = 336
            Top = 22
            Width = 92
            Height = 12
            Caption = 'A8.'#36914#22580'/'#22343#25910#31684#22285
          end
          object Label42: TLabel
            Left = 440
            Top = 22
            Width = 100
            Height = 12
            Caption = 'A9.K'#39640#20302'/'#22343#25910#31684#22285
          end
          object Label43: TLabel
            Left = 139
            Top = 66
            Width = 106
            Height = 12
            Caption = 'A13.'#37782#36914#22580'/K'#25910#22238#27284
          end
          object Label44: TLabel
            Left = 257
            Top = 66
            Width = 106
            Height = 12
            Caption = 'A14.'#37782#36914#22580'/K'#25910#31684#22285
          end
          object Label45: TLabel
            Left = 378
            Top = 66
            Width = 95
            Height = 12
            Caption = 'A15.'#37782#21033#26041#24335#20999#25563
          end
          object dbcbA6: TDBComboBox
            Left = 138
            Top = 40
            Width = 71
            Height = 20
            DataField = 'A6'
            DataSource = DataModule1.dsParam
            ItemHeight = 12
            Items.Strings = (
              #38918#21521
              #21453#21521)
            TabOrder = 0
          end
          object dbrA1: TDBRadioGroup
            Left = 18
            Top = 23
            Width = 103
            Height = 42
            Caption = #27169#32068#36984#25799
            Columns = 2
            DataField = 'A1'
            DataSource = DataModule1.dsParam
            Items.Strings = (
              #22266#23450
              #28014#21205)
            ParentBackground = True
            TabOrder = 1
            Values.Strings = (
              '0'
              '1')
          end
          object dbeA11: TDBEdit
            Left = 560
            Top = 40
            Width = 62
            Height = 20
            DataField = 'A11'
            DataSource = DataModule1.dsParam
            TabOrder = 2
          end
          object dbeA7: TDBEdit
            Left = 224
            Top = 40
            Width = 62
            Height = 20
            DataField = 'A7'
            DataSource = DataModule1.dsParam
            TabOrder = 3
          end
          object dbeA8: TDBEdit
            Left = 336
            Top = 40
            Width = 62
            Height = 20
            DataField = 'A8'
            DataSource = DataModule1.dsParam
            TabOrder = 4
          end
          object dbeA9: TDBEdit
            Left = 440
            Top = 40
            Width = 62
            Height = 20
            DataField = 'A9'
            DataSource = DataModule1.dsParam
            TabOrder = 5
          end
          object dbeA13: TDBEdit
            Left = 139
            Top = 82
            Width = 62
            Height = 20
            DataField = 'A13'
            DataSource = DataModule1.dsParam
            TabOrder = 6
          end
          object dbeA14: TDBEdit
            Left = 257
            Top = 84
            Width = 62
            Height = 20
            DataField = 'A14'
            DataSource = DataModule1.dsParam
            TabOrder = 7
          end
          object dbeA15: TDBEdit
            Left = 378
            Top = 84
            Width = 62
            Height = 20
            DataField = 'A15'
            DataSource = DataModule1.dsParam
            TabOrder = 8
          end
        end
        object GroupBox5: TGroupBox
          Left = 13
          Top = 151
          Width = 717
          Height = 73
          Caption = #21069#33139#20301#27169#32068
          TabOrder = 1
          object Label15: TLabel
            Left = 89
            Top = 22
            Width = 101
            Height = 12
            Caption = 'B1.'#21069#26085#26399#39640#20302#28085#33995
          end
          object Label19: TLabel
            Left = 515
            Top = 22
            Width = 112
            Height = 12
            Caption = 'B5.K'#25910'/'#21069#39640#20302#31684#22285#22806
          end
          object dbcbB_Open: TDBCheckBox
            Left = 18
            Top = 32
            Width = 51
            Height = 17
            Caption = #38283' / '#38364
            DataField = 'B_Open'
            DataSource = DataModule1.dsParam
            TabOrder = 0
            ValueChecked = 'T'
            ValueUnchecked = 'F'
          end
          object dbeB1: TDBEdit
            Left = 87
            Top = 40
            Width = 62
            Height = 20
            DataField = 'B1'
            DataSource = DataModule1.dsParam
            TabOrder = 1
            OnChange = dbeB1Change
          end
          object dbeB2: TDBEdit
            Left = 212
            Top = 47
            Width = 62
            Height = 20
            DataField = 'B2'
            DataSource = DataModule1.dsParam
            TabOrder = 2
            OnChange = dbeB1Change
          end
          object dbeB3: TDBEdit
            Left = 358
            Top = 47
            Width = 62
            Height = 20
            DataField = 'B3'
            DataSource = DataModule1.dsParam
            TabOrder = 3
            OnChange = dbeB1Change
          end
          object dbeB5: TDBEdit
            Left = 515
            Top = 40
            Width = 62
            Height = 20
            DataField = 'B5'
            DataSource = DataModule1.dsParam
            TabOrder = 4
          end
          object dbeB2_1: TDBEdit
            Left = 276
            Top = 47
            Width = 62
            Height = 20
            DataField = 'B2_1'
            DataSource = DataModule1.dsParam
            TabOrder = 5
            OnChange = dbeB1Change
          end
          object DBRadioGroup1: TDBRadioGroup
            Left = 210
            Top = 12
            Width = 289
            Height = 33
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Columns = 2
            Ctl3D = True
            DataField = 'B2orB3'
            DataSource = DataModule1.dsParam
            Items.Strings = (
              'B2.'#20219#24847#39640#20302#40670
              'B3.K'#25910'/'#21069#39640#20302#31684#22285#20839)
            ParentBackground = True
            ParentCtl3D = False
            TabOrder = 6
            Values.Strings = (
              '0'
              '1')
            OnChange = dbeB1Change
          end
        end
        object GroupBox6: TGroupBox
          Left = 12
          Top = 218
          Width = 718
          Height = 73
          Caption = #29190#24341#32218#27169#32068
          TabOrder = 2
          object Label18: TLabel
            Left = 89
            Top = 22
            Width = 97
            Height = 12
            Caption = 'C1.'#29190'K'#32317#39640#20302#25104#31435
          end
          object Label20: TLabel
            Left = 207
            Top = 22
            Width = 73
            Height = 12
            Caption = 'C2.'#29190'K'#26834#22238#27284
          end
          object Label21: TLabel
            Left = 302
            Top = 22
            Width = 85
            Height = 12
            Caption = 'C3.'#29190'K'#27604#20363#31186#25976
          end
          object Label22: TLabel
            Left = 411
            Top = 22
            Width = 85
            Height = 12
            Caption = 'C4.'#29190'K'#26032#39640#31186#25976
          end
          object Label23: TLabel
            Left = 514
            Top = 22
            Width = 100
            Height = 12
            Caption = 'C5.'#22343#32218'/'#29190'K'#26834#22238#27284
          end
          object Label24: TLabel
            Left = 623
            Top = 22
            Width = 77
            Height = 12
            Caption = 'C7.'#29190#24341#32218#27604#37325
          end
          object dbcbC_Open: TDBCheckBox
            Left = 18
            Top = 32
            Width = 51
            Height = 17
            Caption = #38283' / '#38364
            DataField = 'C_Open'
            DataSource = DataModule1.dsParam
            TabOrder = 0
            ValueChecked = 'T'
            ValueUnchecked = 'F'
          end
          object dbeC1: TDBEdit
            Left = 87
            Top = 40
            Width = 62
            Height = 20
            DataField = 'C1'
            DataSource = DataModule1.dsParam
            TabOrder = 1
          end
          object dbeC2: TDBEdit
            Left = 207
            Top = 40
            Width = 62
            Height = 20
            DataField = 'C2'
            DataSource = DataModule1.dsParam
            TabOrder = 2
          end
          object dbeC3: TDBEdit
            Left = 302
            Top = 40
            Width = 62
            Height = 20
            DataField = 'C3'
            DataSource = DataModule1.dsParam
            TabOrder = 3
          end
          object dbeC4: TDBEdit
            Left = 411
            Top = 40
            Width = 62
            Height = 20
            DataField = 'C4'
            DataSource = DataModule1.dsParam
            TabOrder = 4
          end
          object dbeC5: TDBEdit
            Left = 514
            Top = 40
            Width = 62
            Height = 20
            DataField = 'C5'
            DataSource = DataModule1.dsParam
            TabOrder = 5
          end
          object dbeC7: TDBEdit
            Left = 623
            Top = 40
            Width = 62
            Height = 20
            DataField = 'C7'
            DataSource = DataModule1.dsParam
            TabOrder = 6
          end
        end
        object GroupBox7: TGroupBox
          Left = 13
          Top = 284
          Width = 718
          Height = 115
          Caption = #30436#25972#30436#27169#32068
          TabOrder = 3
          object Label25: TLabel
            Left = 89
            Top = 22
            Width = 95
            Height = 12
            Caption = 'D1.'#30436#22343#32218'1'#26781#39640#20302
          end
          object Label26: TLabel
            Left = 207
            Top = 22
            Width = 95
            Height = 12
            Caption = 'D2.'#30436#22343#32218'3'#26781#39640#20302
          end
          object Label27: TLabel
            Left = 308
            Top = 22
            Width = 97
            Height = 12
            Caption = 'D3.'#30436#22266#23450'K'#26834#39640#20302
          end
          object Label28: TLabel
            Left = 439
            Top = 22
            Width = 97
            Height = 12
            Caption = 'D4.'#30436#28014#21205'K'#26834#39640#20302
          end
          object Label29: TLabel
            Left = 622
            Top = 22
            Width = 77
            Height = 12
            Caption = 'D6.'#30436#25972#30436#27604#37325
          end
          object Label30: TLabel
            Left = 87
            Top = 66
            Width = 89
            Height = 12
            Caption = 'D7.'#38748#32622#35299#38500#27604#37325
          end
          object Label31: TLabel
            Left = 207
            Top = 66
            Width = 77
            Height = 12
            Caption = 'D8.'#30436#35299#38500#27604#37325
          end
          object Label12: TLabel
            Left = 552
            Top = 22
            Width = 17
            Height = 12
            Caption = 'D5.'
          end
          object dbcbD_Open: TDBCheckBox
            Left = 18
            Top = 32
            Width = 51
            Height = 17
            Caption = #38283' / '#38364
            DataField = 'D_Open'
            DataSource = DataModule1.dsParam
            TabOrder = 0
            ValueChecked = 'T'
            ValueUnchecked = 'F'
          end
          object dbeD1: TDBEdit
            Left = 87
            Top = 40
            Width = 46
            Height = 20
            DataField = 'D1'
            DataSource = DataModule1.dsParam
            TabOrder = 1
          end
          object dbeD2: TDBEdit
            Left = 207
            Top = 40
            Width = 62
            Height = 20
            DataField = 'D2'
            DataSource = DataModule1.dsParam
            TabOrder = 2
          end
          object dbeD3: TDBEdit
            Left = 308
            Top = 40
            Width = 46
            Height = 20
            DataField = 'D3'
            DataSource = DataModule1.dsParam
            TabOrder = 3
          end
          object dbeD4: TDBEdit
            Left = 439
            Top = 40
            Width = 46
            Height = 20
            DataField = 'D4'
            DataSource = DataModule1.dsParam
            TabOrder = 4
          end
          object dbeD6: TDBEdit
            Left = 622
            Top = 40
            Width = 62
            Height = 20
            DataField = 'D6'
            DataSource = DataModule1.dsParam
            TabOrder = 5
          end
          object dbeD7: TDBEdit
            Left = 87
            Top = 84
            Width = 62
            Height = 20
            DataField = 'D7'
            DataSource = DataModule1.dsParam
            TabOrder = 6
          end
          object dbeD8: TDBEdit
            Left = 205
            Top = 84
            Width = 62
            Height = 20
            DataField = 'D8'
            DataSource = DataModule1.dsParam
            TabOrder = 7
          end
          object dbeD1_1: TDBEdit
            Left = 139
            Top = 40
            Width = 46
            Height = 20
            DataField = 'D1_1'
            DataSource = DataModule1.dsParam
            TabOrder = 8
          end
          object dbeD3_1: TDBEdit
            Left = 359
            Top = 40
            Width = 46
            Height = 20
            DataField = 'D3_1'
            DataSource = DataModule1.dsParam
            TabOrder = 9
          end
          object dbeD4_1: TDBEdit
            Left = 491
            Top = 40
            Width = 46
            Height = 20
            DataField = 'D4_1'
            DataSource = DataModule1.dsParam
            TabOrder = 10
          end
        end
        object GroupBox8: TGroupBox
          Left = 12
          Top = 394
          Width = 717
          Height = 112
          Caption = #36339#31354#27169#32068
          TabOrder = 4
          object Label32: TLabel
            Left = 89
            Top = 22
            Width = 76
            Height = 12
            Caption = 'E1.'#30041#20489#28136#29554#21033
          end
          object Label33: TLabel
            Left = 189
            Top = 22
            Width = 64
            Height = 12
            Caption = 'E3.'#30041#20489#27604#37325
          end
          object Label34: TLabel
            Left = 284
            Top = 22
            Width = 76
            Height = 12
            Caption = 'E5.'#36681#21453#21521#30041#20489
          end
          object Label35: TLabel
            Left = 373
            Top = 22
            Width = 111
            Height = 12
            Caption = 'E7.'#36555'K'#25910'/'#36914#22580#40670#31684#22285
          end
          object Label36: TLabel
            Left = 490
            Top = 22
            Width = 92
            Height = 12
            Caption = 'E8.'#36555'K'#25910#30896'K'#38283#30436
          end
          object Label37: TLabel
            Left = 591
            Top = 22
            Width = 104
            Height = 12
            Caption = 'E9.'#36555'K'#25910#30896'K'#38283#39640#20302
          end
          object Label38: TLabel
            Left = 89
            Top = 66
            Width = 85
            Height = 12
            Caption = 'E11.'#36555#30041'/'#20986#27604#37325
          end
          object dbcbE_Open: TDBCheckBox
            Left = 18
            Top = 32
            Width = 51
            Height = 17
            Caption = #38283' / '#38364
            DataField = 'E_Open'
            DataSource = DataModule1.dsParam
            TabOrder = 0
            ValueChecked = 'T'
            ValueUnchecked = 'F'
          end
          object dbeE1: TDBEdit
            Left = 87
            Top = 40
            Width = 62
            Height = 20
            DataField = 'E1'
            DataSource = DataModule1.dsParam
            TabOrder = 1
          end
          object dbeE3: TDBEdit
            Left = 189
            Top = 40
            Width = 62
            Height = 20
            DataField = 'E3'
            DataSource = DataModule1.dsParam
            TabOrder = 2
          end
          object dbeE5: TDBEdit
            Left = 284
            Top = 40
            Width = 62
            Height = 20
            DataField = 'E5'
            DataSource = DataModule1.dsParam
            TabOrder = 3
          end
          object dbeE7: TDBEdit
            Left = 374
            Top = 40
            Width = 62
            Height = 20
            DataField = 'E7'
            DataSource = DataModule1.dsParam
            TabOrder = 4
          end
          object dbeE8: TDBEdit
            Left = 490
            Top = 40
            Width = 62
            Height = 20
            DataField = 'E8'
            DataSource = DataModule1.dsParam
            TabOrder = 5
          end
          object dbeE9: TDBEdit
            Left = 588
            Top = 40
            Width = 62
            Height = 20
            DataField = 'E9'
            DataSource = DataModule1.dsParam
            TabOrder = 6
          end
          object dbeE11: TDBEdit
            Left = 87
            Top = 84
            Width = 62
            Height = 20
            DataField = 'E11'
            DataSource = DataModule1.dsParam
            TabOrder = 7
          end
        end
        object dbnaviParam: TDBNavigator
          Left = 13
          Top = 10
          Width = 182
          Height = 25
          DataSource = DataModule1.dsParam
          VisibleButtons = [nbPost, nbCancel]
          TabOrder = 5
        end
        object DBGrid_Param: TDBGrid
          Left = 528
          Top = -1
          Width = 106
          Height = 36
          DataSource = DataModule1.dsParam
          TabOrder = 6
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = #26032#32048#26126#39636
          TitleFont.Style = []
          Visible = False
        end
      end
    end
  end
end
