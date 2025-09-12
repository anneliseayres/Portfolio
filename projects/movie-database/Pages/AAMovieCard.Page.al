page 50451 "AA Movie Card"
{
    PageType = Card;
    UsageCategory = none;
    SourceTable = "AA Movie";
    Caption = 'Movie';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                    MultiLine = true;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                    ToolTip = 'Score';
                }
            }
        }
        area(FactBoxes)
        {
            part("AA Movie Card Part"; "AA Movie Card Part")
            {
                ApplicationArea = All;
                Caption = 'Movie Poster';
                SubPageLink = "No." = field("No.");
            }
        }
    }
}