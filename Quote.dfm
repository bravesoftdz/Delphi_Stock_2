object fmQuote: TfmQuote
  Left = 595
  Top = 135
  Caption = #22577#20729#35469#35657
  ClientHeight = 528
  ClientWidth = 763
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 763
    Height = 49
    Align = alTop
    Caption = '1.'#35469#35657
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 21
      Width = 33
      Height = 13
      AutoSize = False
      Caption = #24115#34399
    end
    object Label2: TLabel
      Left = 119
      Top = 19
      Width = 34
      Height = 13
      AutoSize = False
      Caption = #23494#30908
    end
    object Label3: TLabel
      Left = 311
      Top = 19
      Width = 48
      Height = 13
      Caption = #36984#25799#26085#26399
    end
    object lbSystemTime: TLabel
      Left = 575
      Top = 19
      Width = 65
      Height = 13
      Caption = 'lbSystemTime'
    end
    object Label5: TLabel
      Left = 490
      Top = 19
      Width = 79
      Height = 13
      AutoSize = False
      Caption = #31995#32113#26178#38291':'
    end
    object edtPass: TEdit
      Left = 149
      Top = 16
      Width = 73
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object edtLogID: TEdit
      Left = 48
      Top = 16
      Width = 65
      Height = 21
      CharCase = ecUpperCase
      PasswordChar = '*'
      TabOrder = 0
    end
    object btnLogin: TButton
      Left = 228
      Top = 14
      Width = 75
      Height = 25
      Caption = #30331#20837
      TabOrder = 2
      OnClick = btnLoginClick
    end
    object dtpDate: TDateTimePicker
      Left = 370
      Top = 13
      Width = 97
      Height = 21
      Date = 40788.496454895830000000
      Time = 40788.496454895830000000
      TabOrder = 3
      OnChange = dtpDateChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 49
    Width = 763
    Height = 50
    Align = alTop
    Caption = '2.'#21830#21697#36984#25799
    TabOrder = 1
    object Label6: TLabel
      Left = 228
      Top = 19
      Width = 83
      Height = 13
      AutoSize = False
      Caption = #20132#26131#26178#38291
    end
    object Label7: TLabel
      Left = 382
      Top = 19
      Width = 7
      Height = 13
      Caption = '~'
    end
    object btnDownLoad: TButton
      Left = 133
      Top = 14
      Width = 75
      Height = 25
      Caption = #21450#26178#30435#25511
      TabOrder = 0
      OnClick = btnDownLoadClick
    end
    object cbbStockNO: TComboBox
      Left = 16
      Top = 16
      Width = 105
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'TX00'
      OnChange = cbbStockNOChange
      OnDropDown = cbbStockNODropDown
    end
    object btnDataBase: TButton
      Left = 672
      Top = 19
      Width = 75
      Height = 25
      Caption = #36681#36039#26009#24235
      TabOrder = 2
      Visible = False
      OnClick = btnDataBaseClick
    end
    object btnKLine: TButton
      Left = 596
      Top = 19
      Width = 75
      Height = 25
      Caption = #27511#21490'K'#32218
      TabOrder = 3
      Visible = False
      OnClick = btnKLineClick
    end
    object btnHistoryKLine: TButton
      Left = 515
      Top = 19
      Width = 75
      Height = 25
      Caption = #32362#35069'K'#32218
      TabOrder = 4
      Visible = False
      OnClick = btnHistoryKLineClick
    end
    object edtStart: TEdit
      Left = 301
      Top = 14
      Width = 73
      Height = 21
      TabOrder = 5
    end
    object edtEnd: TEdit
      Left = 396
      Top = 14
      Width = 73
      Height = 21
      TabOrder = 6
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 99
    Width = 763
    Height = 104
    Align = alTop
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object MainChart: TChart
    Left = 0
    Top = 243
    Width = 608
    Height = 285
    AllowPanning = pmHorizontal
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Legend.DividingLines.Visible = True
    Legend.Frame.Visible = False
    Legend.Visible = False
    Title.Color = clSilver
    Title.Font.Color = clYellow
    Title.Text.Strings = (
      #21488#25351' K '#32218#22294)
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.DateTimeFormat = 'hh:mm'
    BottomAxis.Grid.Visible = False
    BottomAxis.Increment = 0.020833333333333330
    BottomAxis.LabelsFont.Color = clWhite
    BottomAxis.LabelsSeparation = 100
    BottomAxis.LabelStyle = talValue
    BottomAxis.Maximum = 0.999305555555555600
    BottomAxis.Minimum = 0.250000000000000000
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.LabelsFont.Color = clYellow
    LeftAxis.Maximum = 449.016152343749800000
    LeftAxis.Minimum = 1.673437500000015000
    LeftAxis.Title.Caption = #25104#20132#20729
    Pages.AutoScale = True
    RightAxis.Automatic = False
    RightAxis.AutomaticMaximum = False
    RightAxis.AutomaticMinimum = False
    RightAxis.Grid.Visible = False
    RightAxis.LabelsFont.Color = clYellow
    RightAxis.Maximum = 572.500000000000000000
    RightAxis.Title.Caption = #25104#20132#37327
    TopAxis.Automatic = False
    TopAxis.AutomaticMaximum = False
    TopAxis.AutomaticMinimum = False
    View3D = False
    Zoom.Allow = False
    Zoom.Animated = True
    OnAfterDraw = MainChartAfterDraw
    Align = alClient
    Color = clBlack
    TabOrder = 3
    OnMouseMove = MainChartMouseMove
    PrintMargins = (
      15
      25
      15
      25)
    object lbShow: TLabel
      Left = 520
      Top = 6
      Width = 35
      Height = 13
      Caption = 'lbShow'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Shadow.Color = 8487297
      Marks.Visible = False
      SeriesColor = clYellow
      Title = #32929#31080#36264#21218'('#22343#32218')'
      Pointer.Brush.Color = clYellow
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Pen.Color = clBlue
      Pointer.Pen.Visible = False
      Pointer.Style = psCircle
      Pointer.VertSize = 1
      Pointer.Visible = True
      XValues.DateTime = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TBarSeries
      BarPen.Visible = False
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Title = #25104#20132#37327
      VertAxis = aRightAxis
      BarWidthPercent = 50
      Gradient.Direction = gdTopBottom
      Shadow.Color = 8947848
      XValues.DateTime = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
    object Series9: TLineSeries
      ColorEachPoint = True
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 0
      Marks.Shadow.Color = 8684676
      Marks.Visible = False
      SeriesColor = clWhite
      Title = #25910#30436#20729
      ClickableLine = False
      Pointer.HorizSize = 5
      Pointer.InflateMargins = True
      Pointer.Pen.Visible = False
      Pointer.Style = psRectangle
      Pointer.VertSize = 9
      Pointer.Visible = False
      XValues.DateTime = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TPointSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 8
      Marks.Visible = False
      Title = 'OpenP'
      ClickableLine = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series4: TPointSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 8
      Marks.Visible = False
      Title = 'CloseP'
      ClickableLine = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series5: TPointSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 8
      Marks.Visible = False
      Title = 'HighP'
      ClickableLine = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series6: TPointSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 8
      Marks.Visible = False
      Title = 'LowP'
      ClickableLine = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Panel1: TPanel
    Left = 608
    Top = 243
    Width = 155
    Height = 285
    Align = alRight
    Caption = 'Panel1'
    Color = clGradientInactiveCaption
    ParentBackground = False
    ShowCaption = False
    TabOrder = 4
    object lbOpen: TLabel
      Left = 6
      Top = 24
      Width = 32
      Height = 16
      Caption = #38283#30436
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
    object lbHigh: TLabel
      Left = 6
      Top = 61
      Width = 32
      Height = 16
      Caption = #26368#39640
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
    object lbLow: TLabel
      Left = 6
      Top = 99
      Width = 32
      Height = 16
      Caption = #26368#20302
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
    object lbClose: TLabel
      Left = 6
      Top = 137
      Width = 32
      Height = 16
      Caption = #25910#30436
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
    object lbTickTime: TLabel
      Left = 6
      Top = 179
      Width = 32
      Height = 16
      Caption = #26178#38291
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
    object lbTest: TLabel
      Left = 6
      Top = 215
      Width = 48
      Height = 16
      Caption = 'lbTest'
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 203
    Width = 763
    Height = 40
    Align = alTop
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 5
    object Label4: TLabel
      Left = 14
      Top = 13
      Width = 56
      Height = 16
      Caption = #21363#26178'K'#26834
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
    object lbNowOpen: TLabel
      Left = 89
      Top = 13
      Width = 32
      Height = 16
      Caption = #38283#30436
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
    object lbNowHigh: TLabel
      Left = 190
      Top = 13
      Width = 32
      Height = 16
      Caption = #26368#39640
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
    object lbNowLow: TLabel
      Left = 296
      Top = 13
      Width = 32
      Height = 16
      Caption = #26368#20302
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
    object lbNowClose: TLabel
      Left = 392
      Top = 13
      Width = 32
      Height = 16
      Caption = #25910#30436
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
    object lbNowMA5: TLabel
      Left = 482
      Top = 13
      Width = 24
      Height = 16
      Caption = 'MA5'
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
    object lbBalance: TLabel
      Left = 578
      Top = 13
      Width = 64
      Height = 16
      Caption = #30070#26085#25613#30410
      Font.Charset = CHINESEBIG5_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #32048#26126#39636
      Font.Style = []
      ParentFont = False
    end
  end
  object jedfMainQuote: TJvEmbeddedFormLink
    Left = 704
    Top = 65528
  end
  object SencondTimer: TTimer
    OnTimer = SencondTimerTimer
    Left = 576
    Top = 32
  end
  object LastTimer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = LastTimerTimer
    Left = 648
    Top = 32
  end
  object A4Timer: TTimer
    Enabled = False
    Left = 704
    Top = 32
  end
  object TimerSystem: TTimer
    Interval = 15000
    OnTimer = TimerSystemTimer
    Left = 496
    Top = 24
  end
  object DownLoadTimer: TTimer
    Enabled = False
    Interval = 4000
    OnTimer = DownLoadTimerTimer
    Left = 240
    Top = 112
  end
  object SKOSQuoteLib1: TSKOSQuoteLib
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    OnConnect = SKOSQuoteLib1Connect
    OnNotifyTicks = SKOSQuoteLib1NotifyTicks
    OnNotifyBest5 = SKOSQuoteLib1NotifyBest5
    OnKLineData = SKOSQuoteLib1KLineData
    OnNotifyServerTime = SKOSQuoteLib1NotifyServerTime
    Left = 336
    Top = 104
  end
  object SKQuoteLib1: TSKQuoteLib
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    OnConnection = SKQuoteLib1Connection
    OnNotifyTicks = SKQuoteLib1NotifyTicks
    OnNotifyKLineData = SKQuoteLib1NotifyKLineData
    OnNotifyServerTime = SKQuoteLib1NotifyServerTime
    Left = 432
    Top = 104
  end
  object SKOrderLib1: TSKOrderLib
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    OnAccount = SKOrderLib1Account
    OnOpenInterest = SKOrderLib1OpenInterest
    OnOverseaFutureOpenInterest = SKOrderLib1OverseaFutureOpenInterest
    OnOverseaFuture = SKOrderLib1OverseaFuture
    Left = 504
    Top = 104
  end
end
