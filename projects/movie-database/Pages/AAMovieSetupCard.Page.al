page 50455 "AA Movie Setup Card"
{
    ApplicationArea = all;
    Caption = 'Movie Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "AA Movie Setup";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = ' General';
                field(BackupType; Rec.BackupType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifie the backup type.';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}