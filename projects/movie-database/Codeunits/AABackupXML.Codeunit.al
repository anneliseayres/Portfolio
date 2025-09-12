codeunit 50454 "AA Backup XML" implements "AA Backup"
{
    procedure Backup(AAMovie: Record "AA Movie"): Boolean;
   var
        MessageLbl: Label 'XML backup called for movie %1', Comment = 'Retorno da procedure backup';
    begin
        Message(MessageLbl, AAMovie.Title);
        exit(true);
    end;
}