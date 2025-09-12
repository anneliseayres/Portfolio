codeunit 50455 "AA Backup"
{
    procedure BackupMovie()
    var
        BackupInterface: Interface "AA Backup";
        Movie: Record "AA Movie";
        MovieSetup: Record "AA Movie Setup";
    begin
        if not MovieSetup.Get() then
            Error('Please setup the backup type in the Movie Setup page.');

        if Movie.IsEmpty() then
            exit;

        BackupInterface := MovieSetup.BackupType;
        BackupInterface.Backup(Movie);
    end;

    procedure ManualBackupMovie()
    var
        Movie: Record "AA Movie";
        BackupInterface: Interface "AA Backup";
        BackupCSV: Codeunit "AA Backup CSV";
        BackupJSON: Codeunit "AA Backup JSON";
        BackupXML: Codeunit "AA Backup XML";
        BackupXSLX: Codeunit "AA Backup XSLX";
        FormatChoice: Integer;
        FormatOptionsLbl: Label 'CSV, JSON, XML, XSLX';
        FormatOptions: Text[30];
    begin
        if Movie.IsEmpty() then
            exit;
        FormatOptions := FormatOptionsLbl;
        FormatChoice := Dialog.StrMenu(FormatOptions, 0, 'Select backup format');

        case FormatChoice of
            1:
                BackupInterface := BackupCSV;
            2:
                BackupInterface := BackupJSON;
            3:
                BackupInterface := BackupXML;
            4:
                BackupInterface := BackupXSLX;
            else
                exit;
        end;

        BackupInterface.Backup(Movie);
    end;
}