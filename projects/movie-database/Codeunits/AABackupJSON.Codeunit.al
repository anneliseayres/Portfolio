codeunit 50453 "AA Backup JSON" implements "AA Backup"
{
    procedure Backup(AAMovie: Record "AA Movie"): Boolean;
    var
        MessageLbl: Label 'JSON backup called for movie %1', Comment = 'Retorno da procedure backup';
    begin
        Message(MessageLbl, AAMovie.Title);
        exit(true);
    end;
   

}