codeunit 50453 "AA Backup JSON" implements "AA Backup"
{
    procedure Backup(AAMovie: Record "AA Movie"): Boolean;
    var
        Movies: Record "AA Movie";
        TempBlob: Codeunit "Temp Blob";
        JsonOutStream: OutStream;
        JsonInStream: InStream;
        FileName: Text;
        FileNameLbl: Label 'MoviesBackup_%1_%2.json', Comment= '%1 UserId, %2 DateTime';
        MoviesArray: JsonArray;
        MovieObj: JsonObject;
    begin
        FileName := StrSubstNo(FileNameLbl, UserId(), Format(CurrentDateTime()));

        // Loop through all movies and build JSON array
        Movies.Reset();
        if Movies.FindSet() then
            repeat
                Clear(MovieObj);
                MovieObj.Add('No.', Movies."No.");
                MovieObj.Add('Title', Movies.Title);
                MovieObj.Add('Genre', Movies.Genre);
                MovieObj.Add('Year', Movies.Year);
                MovieObj.Add('Actors', Movies.Actors);
                MovieObj.Add('Production', Movies.Production);
                MovieObj.Add('Description', Movies.Description);
                MovieObj.Add('Score', Movies.Score);

                MoviesArray.Add(MovieObj);
            until Movies.Next() = 0;

        // Write JSON array to stream
        TempBlob.CreateOutStream(JsonOutStream);
        MoviesArray.WriteTo(JsonOutStream);
        TempBlob.CreateInStream(JsonInStream);

        // Download the JSON file
        DownloadFromStream(JsonInStream, '', '', '', FileName);

        exit(true);
    end;
}
