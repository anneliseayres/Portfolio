codeunit 50450 "AA Backup CSV" implements "AA Backup"
{
    procedure Backup(AAMovie: Record "AA Movie"): Boolean;
    var
        MessageLbl: Label 'CSV backup called for movie %1', Comment = 'Retorno da procedure backup';
    begin
        Message(MessageLbl, AAMovie.Title);
        exit(true);
    end;
}