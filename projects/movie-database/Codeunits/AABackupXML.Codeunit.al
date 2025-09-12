codeunit 50454 "AA Backup XML" implements "AA Backup"
{
    procedure Backup(AAMovie: Record "AA Movie"): Boolean;
    var
        Movies: Record "AA Movie";
        TempBlob: Codeunit "Temp Blob";
        XmlOutStream: OutStream;
        XmlInStream: InStream;
        FileName: Text;
        FileNameLbl: Label 'MoviesBackup_%1_%2.xml', Comment= '%1 UserId, %2 DateTime';
        TxtBuilder: TextBuilder;
    begin
        FileName := StrSubstNo(FileNameLbl, UserId(), Format(CurrentDateTime()));

        TxtBuilder.AppendLine('<?xml version="1.0" encoding="UTF-8"?>');
        TxtBuilder.AppendLine('<Movies>');

        Movies.Reset();
        if Movies.FindSet() then
            repeat
                TxtBuilder.AppendLine('  <Movie>');
                TxtBuilder.AppendLine('    <No>' + XmlEncode(Movies."No.") + '</No>');
                TxtBuilder.AppendLine('    <Title>' + XmlEncode(Movies.Title) + '</Title>');
                TxtBuilder.AppendLine('    <Genre>' + XmlEncode(Movies.Genre) + '</Genre>');
                TxtBuilder.AppendLine('    <Year>' + Format(Movies.Year) + '</Year>');
                TxtBuilder.AppendLine('    <Actors>' + XmlEncode(Movies.Actors) + '</Actors>');
                TxtBuilder.AppendLine('    <Production>' + XmlEncode(Movies.Production) + '</Production>');
                TxtBuilder.AppendLine('    <Description>' + XmlEncode(Movies.Description) + '</Description>');
                TxtBuilder.AppendLine('    <Score>' + Format(Movies.Score) + '</Score>');
                TxtBuilder.AppendLine('  </Movie>');
            until Movies.Next() = 0;

        TxtBuilder.AppendLine('</Movies>');

        TempBlob.CreateOutStream(XmlOutStream);
        XmlOutStream.WriteText(TxtBuilder.ToText());
        TempBlob.CreateInStream(XmlInStream);

        DownloadFromStream(XmlInStream, '', '', '', FileName);

        exit(true);
    end;

    local procedure XmlEncode(Value: Text): Text
    begin
        Value := Value.Replace('&', '&amp;');
        Value := Value.Replace('<', '&lt;');
        Value := Value.Replace('>', '&gt;');
        Value := Value.Replace('"', '&quot;');
        Value := Value.Replace('''', '&apos;');
        exit(Value);
    end;
}