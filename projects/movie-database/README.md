# 🎬 Movie Database – Business Central Extension

This is a custom extension built for Microsoft Dynamics 365 Business Central to manage and import a catalog of movies using the [OMDb API](http://www.omdbapi.com/).

## 🔍 Features

- Search for movies directly from Business Central using the OMDb API.
- Store selected movie data in a custom table (`Movie`).
- View movie details on a custom card and list page.
- Export the movie data in multiple formats:
  - CSV
  - XLSX
  - JSON 
  - XML 

## 📂 Project Structure

| Folder / File | Description |
|---------------|-------------|
| `Tables` | Custom movie-related data tables |
| `Pages` | User interface elements (list, card pages) |
| `Codeunits` | Business logic components (API integration and backup logic) |
| `Interfaces` | Interfaces used for backup implementation |
| `Enums` | Export format options |
| `MoviesPermissions.permissionset.al` | Permission set definition |
| `Cronus_Movie Database_1.0.0.0.app` | Published `.app` package for deployment |

## 🔧 Use Case

This project was created as part of my technical development in AL language, focusing on API integration, modular design with interfaces, and user interaction in Business Central.

It demonstrates how to integrate third-party APIs (like OMDb) and design extensible backup/export features using best practices in AL.

## 🧪 Key Concepts Practiced

- API integration with `HttpClient` in AL
- JSON parsing and data handling
- Separation of concerns via Interfaces and Codeunits
- Enum-based export options
- Creating Pages, Tables, and Permissions in AL
- Packaging and deployment of `.app` files

---

📁 Go back to my [Portfolio](https://github.com/anneliseayres/portfolio)

