codeunit 50452 "AA Backup XSLX" implements "AA Backup"
{
    procedure Backup(AAMovie: Record "AA Movie"): Boolean;
    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        Movies: Record "AA Movie";
        MoviesLbl: Label 'Movies';
        ExcelFileNameLbl: Label 'MoviesBackup_%1_%2', Comment = '%1 UserId, %2 DateTime';
        RowNo: Integer;
    begin
        ExcelBuffer.Reset();
        ExcelBuffer.DeleteAll();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(Movies.FieldCaption("No."), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Movies.FieldCaption("Title"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Movies.FieldCaption("Genre"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Movies.FieldCaption("Year"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(Movies.FieldCaption("Actors"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Movies.FieldCaption("Production"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Movies.FieldCaption("Description"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Movies.FieldCaption("Score"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);

        if Movies.FindSet() then
            repeat
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(Movies."No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Movies.Title, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Movies.Genre, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Movies.Year, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
                ExcelBuffer.AddColumn(Movies.Actors, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Movies.Production, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Movies.Description, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Movies.Score, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
            until Movies.Next() = 0;
       
        ExcelBuffer.CreateNewBook(MoviesLbl);
        ExcelBuffer.WriteSheet(MoviesLbl, CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileNameLbl, CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        exit(true);
    end;
}