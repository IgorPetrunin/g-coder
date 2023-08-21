object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'G-coder'
  ClientHeight = 575
  ClientWidth = 525
  Color = clBtnFace
  Constraints.MaxHeight = 614
  Constraints.MaxWidth = 541
  Constraints.MinHeight = 614
  Constraints.MinWidth = 541
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 21
  object Button1: TButton
    Left = 24
    Top = 231
    Width = 473
    Height = 57
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1080#1089#1093#1086#1076#1085#1099#1081' g-code '#1080' '#1079#1072#1087#1091#1089#1090#1080#1090#1100' '#1086#1073#1088#1072#1073#1086#1090#1082#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 509
    Height = 209
    Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 32
      Height = 21
      Caption = #1052#1080#1085
    end
    object SettingsLabel: TLabel
      Left = 16
      Top = 168
      Width = 186
      Height = 21
      Caption = #1048#1079#1084#1077#1085#1103#1090#1100' '#1090#1077#1084#1087#1077#1088#1072#1090#1091#1088#1091' '#1086#1090
    end
    object Label2: TLabel
      Left = 16
      Top = 74
      Width = 37
      Height = 21
      Caption = #1052#1072#1082#1089
    end
    object Label6: TLabel
      Left = 16
      Top = 117
      Width = 29
      Height = 21
      Caption = #1064#1072#1075
    end
    object TrackBarMin: TTrackBar
      Left = 72
      Top = 32
      Width = 425
      Height = 45
      Max = 330
      Min = 190
      Position = 190
      TabOrder = 0
      OnChange = TrackBarMinChange
    end
    object TrackBarMax: TTrackBar
      Left = 72
      Top = 74
      Width = 425
      Height = 45
      Max = 330
      Min = 190
      Position = 330
      TabOrder = 1
      OnChange = TrackBarMaxChange
    end
    object TrackBarStep: TTrackBar
      Left = 72
      Top = 117
      Width = 425
      Height = 45
      Max = 330
      Min = 1
      Position = 5
      TabOrder = 2
      OnChange = TrackBarStepChange
    end
  end
  object Console: TMemo
    Left = 8
    Top = 303
    Width = 509
    Height = 271
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object FileOpenDialog: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = #1060#1072#1081#1083' g-code'
        FileMask = '*.gcode'
      end
      item
        DisplayName = #1042#1089#1077' '#1092#1072#1081#1083#1099
        FileMask = '*.*'
      end>
    Options = [fdoStrictFileTypes, fdoFileMustExist]
    Left = 392
    Top = 311
  end
end
