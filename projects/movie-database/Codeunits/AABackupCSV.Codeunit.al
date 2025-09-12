codeunit 50450 "AA Backup CSV" implements "AA Backup"
{
    procedure Backup(AAMovie: Record "AA Movie"): Boolean;
    var
        Movies: Record "AA Movie";
        TempBlob: Codeunit "Temp Blob";
        CsvOutStream: OutStream;
        CsvInStream: InStream;
        CsvLine: Text;
        Separator: Text[1];
        FileName: Text;
        FileNameLbl: Label 'MoviesBackup_%1_%2.csv', Comment= '%1 UserId, %2 DateTime';
        TxtBuilder: TextBuilder;
    begin
        FileName := StrSubstNo(FileNameLbl, UserId(), Format(CurrentDateTime()));
        Separator := ',';

        // Write CSV header
        TxtBuilder.AppendLine('No.' + ',' + 'Title' + ',' + 'Genre' + ',' + 'Year' + ',' + 'Actors' + ',' + 'Production' + ',' + 'Description' + ',' + 'Score');

        // Write each movie as a CSV line
        Movies.Reset();
        if Movies.FindSet() then
            repeat
                TxtBuilder.AppendLine(
                    Quote(Movies."No.") + Separator +
                    Quote(Movies.Title) + Separator +
                    Quote(Movies.Genre) + Separator +
                    Quote(Format(Movies.Year)) + Separator +
                    Quote(Movies.Actors) + Separator +
                    Quote(Movies.Production) + Separator +
                    Quote(Movies.Description) + Separator +
                    Quote(Format(Movies.Score)));
            until Movies.Next() = 0;

        TempBlob.CreateOutStream(CsvOutStream);
        CsvOutStream.WriteText(TxtBuilder.ToText());
        TempBlob.CreateInStream(CsvInStream);

        // Download the CSV file
        DownloadFromStream(CsvInStream, '', '', '', FileName);
        exit(true);
    end;

    // Helper function to wrap values in double quotes and escape internal quotes
    local procedure Quote(Value: Text): Text
    begin
        exit('"' + Value.Replace('"', '""') + '"');
    end;
}