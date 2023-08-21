unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TMainForm = class(TForm)
    FileOpenDialog: TFileOpenDialog;
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    SettingsLabel: TLabel;
    TrackBarMin: TTrackBar;
    TrackBarMax: TTrackBar;
    Label2: TLabel;
    Console: TMemo;
    Label6: TLabel;
    TrackBarStep: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure TrackBarMinChange(Sender: TObject);
    procedure TrackBarMaxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBarStepChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ProcessGCode;
    procedure UpdateLabel;
    procedure ProcessTemperatureStep(Gcode: TStringList;
                                     Temperature: Integer;
                                     Verbose: Boolean = False);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.Button1Click(Sender: TObject);
begin
  if FileOpenDialog.Execute then
  begin
    Console.Lines.Add('Обрабатываю файл: ' + FileOpenDialog.FileName);
    ProcessGCode;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TrackBarMaxChange(Self);
  TrackBarMinChange(Self);
  Top := (Screen.DesktopHeight- Height) div 2;
  Left := (Screen.DesktopWidth - Width) div 2;
end;

procedure TMainForm.ProcessGCode;
begin
  var Gcode := TStringList.Create;
  Gcode.LoadFromFile(FileOpenDialog.FileName);

  var temp := TrackBarMin.Position;
  var Verbose := True;
  repeat
    ProcessTemperatureStep(Gcode, temp, Verbose);
    if Verbose then Verbose := False;
    temp := temp + TrackBarStep.Position;
  until temp > TrackBarMax.Position;

  Console.Lines.Add('');
end;

procedure TMainForm.ProcessTemperatureStep(Gcode: TStringList;
  Temperature: Integer; Verbose: Boolean);
begin
  for var i := 0 to Gcode.Count-1 do
  begin
    if (Pos('M104 S', Gcode[i])=1) and
       (Pos('set final nozzle temp', Gcode[i])>0) then
      begin
        if Verbose then Console.Lines.Add('Строку #' + IntToStr(i) + ': ' + Gcode[i]);
        Gcode[i] := 'M104 S' + IntToStr(Temperature) + ' ; set final nozzle temp';
        if Verbose then Console.Lines.Add('Заменил на : ' + Gcode[i]);
      end;
    if (Pos('M109 S', Gcode[i])=1) and
       (Pos('wait for nozzle temp to stabilize', Gcode[i])>0) then
      begin
        if Verbose then Console.Lines.Add('Строку #' + IntToStr(i) + ': ' + Gcode[i]);
        Gcode[i] := 'M109 S' + IntToStr(Temperature) + ' ; wait for nozzle temp to stabilize';
        if Verbose then Console.Lines.Add('Заменил на : ' + Gcode[i]);
      end;
  end;

  var fileName := ExtractFilePath(FileOpenDialog.FileName) +
                  IntToStr(Temperature) + 'C___' +
                  ExtractFileName(FileOpenDialog.FileName);
  Gcode.SaveToFile(fileName);
  Console.Lines.Add('Сохранил в файл: ' + fileName);
end;

procedure TMainForm.TrackBarMaxChange(Sender: TObject);
begin
  if TrackBarMax.Position < TrackBarMin.Position then
    TrackBarMax.Position := TrackBarMin.Position;

  UpdateLabel;
end;

procedure TMainForm.TrackBarMinChange(Sender: TObject);
begin
  if TrackBarMin.Position > TrackBarMax.Position then
    TrackBarMin.Position := TrackBarMax.Position;

  UpdateLabel;
end;

procedure TMainForm.TrackBarStepChange(Sender: TObject);
begin
  TrackBarStep.Position := 5 * (TrackBarStep.Position div 5);
  UpdateLabel;
end;

procedure TMainForm.UpdateLabel;
begin
  SettingsLabel.Caption := 'Изменять температуру от  ' +
                              IntToStr(TrackBarMin.Position) +
                           '  до  ' +
                              IntToStr(TrackBarMax.Position) +
                           '  с шагом  ' +
                              IntToStr(TrackBarStep.Position) +
                           '  градусов';
end;

end.
