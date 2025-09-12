page 50454 "AA Get movie details"
{
    PageType = StandardDialog;
    UsageCategory = None;
    Caption = 'Get movie details from OMDb';

    layout
    {
        area(Content)
        {
            group(Input)
            {
                field(MovieToSearch; MovieToSearch)
                {
                    ApplicationArea = All;
                    Caption = 'Movie title';
                    ToolTip = 'Specifie the movie title to get details from OMDb.';
                    trigger OnValidate()
                    begin
                        CallGetMovie()
                    end;
                }
            }
        }
    }
    var
        MovieToSearch: Text;

    local procedure CallGetMovie()
    var
       AAHelpGetMovie: Codeunit "AA Help Get Movies";
       MovieTitle, SelectedMovieId, UrlPoster : text;
    begin
        MovieTitle := MovieToSearch;
        SelectedMovieId := AAHelpGetMovie.GetListOfMovies(MovieTitle);

        UrlPoster := AAHelpGetMovie.GetDetailsMovie(SelectedMovieId);
        AAHelpGetMovie.DownloadPosterImage(UrlPoster, SelectedMovieId);
        CurrPage.Close();
    end;

}