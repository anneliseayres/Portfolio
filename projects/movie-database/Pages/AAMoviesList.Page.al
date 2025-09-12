page 50450 "AA Movies List"
{
    PageType = List;
    Caption = 'Movie List';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "AA Movie";
    Editable = false;
    CardPageId = "AA Movie Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Title';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    ToolTip = 'Year';
                }
                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Genre';
                }
                field(Actors; Rec.Actors)
                {
                    ApplicationArea = All;
                    ToolTip = 'Actors';
                }
                field(Production; Rec.Production)
                {
                    ApplicationArea = All;
                    ToolTip = 'Production';
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                    ToolTip = 'Score';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Search on OMDb")
            {
                ApplicationArea = All;
                Image = Import;
                Caption = 'Search on OMDb';
                ToolTip = 'Search the movie information on OMDb.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "AA Get movie details";
            }
            action("Backup Movies")
            {
                ApplicationArea = All;
                Image = ExportDatabase;
                Caption = 'Backup Movies';
                ToolTip = 'Create a backup of the movies in your database.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    BackupMovie();
                end;
            }
        }
    }
    local procedure BackupMovie()
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
}