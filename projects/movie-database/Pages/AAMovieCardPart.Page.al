page 50452 "AA Movie Card Part"
{
    PageType = CardPart;
    SourceTable = "AA Movie";
    Caption = 'Movie Poster';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                ShowCaption = false;
                field(Image; Rec.Image)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the image that has been inserted for the movie.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(FileUpload)
            {
                ApplicationArea = All;
                Image = Import;
                Caption = 'File Upload';
                ToolTip = 'Upload a picture file.';
            //   Promoted = true;
              //  PromotedCategory = Process;
               // PromotedIsBig = true;
               // PromotedOnly = true;

                trigger OnAction()
                begin
                    UploadImage();
                end;
            }
        }
    }
    procedure UploadImage(): text
    var
        TempBlob: Codeunit "Temp Blob";
        NVInStream: InStream;
        NVOutStream: OutStream;
        UploadResult: Boolean;
        Name: Text;
        DialogCaption: Text;
        ConfirmModify: Boolean;
        ConfirmMsg: Label 'An image already exists. Do you want to modify the existing image?';
    begin
        if Rec.Image.Count > 0 then begin
            ConfirmModify := Confirm(ConfirmMsg, false);
            if not ConfirmModify then
                exit;
        end;
        Clear(Rec.Image);
        UploadResult := UploadIntoStream(DialogCaption, NVInStream);
        if UploadResult then begin
            TempBlob.CreateOutStream(NVOutStream);
            CopyStream(NVOutStream, NVInStream);
            TempBlob.CreateInStream(NVInStream);
            Rec.Image.ImportStream(NVInStream, Name);
            Rec.Modify();
            exit(Name);
        end;
    end;
    /*
    Procedure correçao curso
    local procedure UploadImage()
    var
         PictureInStream: InStream;
         FileName: Text;
    begin
        if File.UploadIntoStream('Import Movie Poster', '', 'JPG Files (*.jpg)|*.jpg', FilemName, PictureInStream) then
        begin
            Clear(Rec.Image);
            Rec.Image.ImportStream(PictureInStream, Rec.Title);
            Rec.Modify();
        end;
    end;
    */
}
