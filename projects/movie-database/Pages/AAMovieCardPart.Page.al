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

                trigger OnAction()
                begin
                    UploadImage();
                end;
            }
        }
    }

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

}
