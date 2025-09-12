codeunit 50452 "AA Backup XSLX" implements "AA Backup"
{
    procedure Backup(AAMovie: Record "AA Movie"): Boolean;
    var
        MessageLbl: Label 'XLSX backup called for movie %1', Comment = 'Retorno da procedure backup';
    begin
        Message(MessageLbl, AAMovie.Title);
        exit(true);
    end;
}