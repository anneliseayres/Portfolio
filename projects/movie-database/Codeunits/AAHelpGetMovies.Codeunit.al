codeunit 50451 "AA Help Get Movies"
{
    //Search JSON results of all movies how have the word from MovieToSearch
    procedure GetListOfMovies(MovieToSearch: text): Text
    var
        Url, MovieName, MovieId, Titles, MovieList : text;
        UrlTok: Label 'http://www.omdbapi.com/?apikey=db88628&s=%1', Comment = '%1 = Movie name', Locked = true;
        OmdbHttpClient: HttpClient;
        OmdbHttpResponseMessage: HttpResponseMessage;
        MovieJsonToken: JsonToken;
        MovieJsonObject: JsonObject;
        MovieJsonArray: JsonArray;
        Index, SelectedMovieIndex : Integer;

    begin
        Url := StrSubstNo(UrlTok, MovieToSearch);
        if not OmdbHttpClient.Get(Url, OmdbHttpResponseMessage) then
            Error('No connection to %1', Url);

        if not OmdbHttpResponseMessage.IsSuccessStatusCode() then
            Error('Error: %1 - Reason: %2', OmdbHttpResponseMessage.HttpStatusCode(), OmdbHttpResponseMessage.ReasonPhrase());

        OmdbHttpResponseMessage.Content.ReadAs(Titles);

        MovieJsonToken.ReadFrom(Titles);

        if MovieJsonToken.IsObject() then begin
            MovieJsonObject := MovieJsonToken.AsObject();
            if MovieJsonObject.Get('Search', MovieJsonToken) then begin
                if MovieJsonToken.IsArray() then
                    MovieJsonArray := MovieJsonToken.AsArray()
                else
                    Error('Search is not a JSON array');
            end else
                Error('Search not found in JSON');
        end else
            Error('Invalid JSON object');

        for Index := 0 to MovieJsonArray.Count() - 1 do begin
            MovieJsonArray.Get(Index, MovieJsonToken);
            if (MovieJsonToken.IsObject()) then begin
                MovieJsonObject := MovieJsonToken.AsObject();
                if MovieJsonObject.Get('Title', MovieJsonToken) then begin
                    MovieName := MovieJsonToken.AsValue().AsText();
                    //Isso é necessario porque alguns filmes podem conter virgula no nome
                    //O que prejudica depoisa selacao do filme
                    if MovieName.Contains(',') then
                       MovieName := MovieName.Replace(',', '');
                    if MovieList <> '' then
                        MovieList += ',';
                    MovieList += MovieName;
                end;
            end;
        end;
        SelectedMovieIndex := StrMenu(MovieList, 1, 'Select a movie');

        MovieJsonArray.Get(SelectedMovieIndex - 1, MovieJsonToken);

        if (MovieJsonToken.IsObject()) then begin
            MovieJsonObject := MovieJsonToken.AsObject();
            MovieJsonObject.Get('imdbID', MovieJsonToken);
            MovieId := MovieJsonToken.AsValue().AsText();
        end;
        exit(MovieId);
    end;
    //Get the movie details and save in Movie Table
    procedure GetDetailsMovie(imdbID: text): text
    var
        MovieRec: Record "AA Movie";
        Url, MovieDetails, Poster : text;
        UrlTok: Label 'http://www.omdbapi.com/?apikey=db88628&i=%1', Comment = '%1 = imdb ID', Locked = true;

        OmdbHttpClient: HttpClient;
        OmdbHttpResponseMessage: HttpResponseMessage;
        MovieJsonToken: JsonToken;
        MovieJsonObject: JsonObject;

    begin
        Url := StrSubstNo(UrlTok, imdbID);
        if not OmdbHttpClient.Get(Url, OmdbHttpResponseMessage) then
            Error('No connection to %1', Url);

        if not OmdbHttpResponseMessage.IsSuccessStatusCode() then
            Error('Error: %1 - Reason: %2', OmdbHttpResponseMessage.HttpStatusCode(), OmdbHttpResponseMessage.ReasonPhrase());

        OmdbHttpResponseMessage.Content.ReadAs(MovieDetails);

        MovieJsonToken.ReadFrom(MovieDetails);

        if MovieJsonToken.IsObject() then begin
            MovieJsonObject := MovieJsonToken.AsObject();
            MovieRec.Init();

            MovieJsonObject.Get('imdbID', MovieJsonToken);
            MovieRec."No." := MovieJsonToken.AsValue().AsCode();

            MovieJsonObject.Get('Title', MovieJsonToken);
            MovieRec.Title := MovieJsonToken.AsValue().AsText();

            MovieJsonObject.Get('Year', MovieJsonToken);
            MovieRec.Year := MovieJsonToken.AsValue().AsInteger();

            MovieJsonObject.Get('Genre', MovieJsonToken);
            MovieRec.Genre := MovieJsonToken.AsValue().AsText();

            MovieJsonObject.Get('Actors', MovieJsonToken);
            MovieRec.Actors := MovieJsonToken.AsValue().AsText();

            MovieJsonObject.Get('Director', MovieJsonToken);
            MovieRec.Production := MovieJsonToken.AsValue().AsText();

            MovieJsonObject.Get('Plot', MovieJsonToken);
            MovieRec.Description := MovieJsonToken.AsValue().AsText();

            MovieJsonObject.Get('imdbRating', MovieJsonToken);
            MovieRec.Score := MovieJsonToken.AsValue().AsDecimal();

            MovieRec.Insert();

            MovieJsonObject.Get('Poster', MovieJsonToken);
            Poster := MovieJsonToken.AsValue().AsText();
            exit(Poster);
        end;
    end;

    procedure DownloadPosterImage(UrlPoster: Text; imdbID: text)
    var
        MovieRec: Record "AA Movie";
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        ImageInStream: InStream;
        ImageContent: Text;

    begin
        // Tente enviar uma solicitação GET para a URL da imagem
        if HttpClient.Get(UrlPoster, HttpResponseMessage) then begin
            // Se a solicitação for bem-sucedida, leia o conteúdo da resposta como um fluxo de entrada
            HttpResponseMessage.Content.ReadAs(ImageInStream);

            // Encontre o registro do filme
            if MovieRec.Get(imdbID) then begin
                // Movie.Init();
                MovieRec.Image.ImportStream(ImageInStream, ImageContent);
                MovieRec.Modify();
            end;
        end else
            // Se a solicitação GET falhar, manipule o erro aqui
            Error('Falha ao baixar a imagem da URL %1', UrlPoster);
    end;
}