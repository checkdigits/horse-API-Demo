program horse1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  System.SysUtils,
  index in 'app\routes\index.pas',
  employee in 'app\routes\employee.pas';

begin
  try
    with THorse.Group.Prefix('/apis') do begin
      Route('/')
        .Get(index.API_Index);
      Route('/employees')
        .Get(employee.Get_Employees);
      Route('/employees/:id')
    end;

    THorse.Listen(8080, procedure(Horse: THorse) begin
        Writeln(Format('Server is runing on %s:%d', [Horse.Host, Horse.Port]));
      end
    );

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
