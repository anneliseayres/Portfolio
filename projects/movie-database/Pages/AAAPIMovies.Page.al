page 50453 "AA API Movies"
{
    PageType = API;

    APIPublisher = 'cronus'; // CRONUS USA, Inc.
    APIGroup = 'movies';
    APIVersion = 'v1.0';

    EntityCaption = 'API Movies';
    EntitySetCaption = 'API Movies';
    EntityName = 'movie';
    EntitySetName = 'movies';

    SourceTable = "AA Movie";
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("no"; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(title; Rec.Title)
                {
                    ApplicationArea = all;
                }
                field(year; Rec.Year)
                {
                    ApplicationArea = all;
                }
                field(genre; Rec.Genre)
                {
                    ApplicationArea = all;
                }
                field(actors; Rec.Actors)
                {
                    ApplicationArea = all;
                }
                field(production; Rec.Production)
                {
                    ApplicationArea = all;
                }
                field(description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(score; Rec.Score)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}