# Building Block View

## Code structure

- `/doc`: Miscellaneous files for the project documentation.
- `/lib`: Main home of the application's source code.
  - `/api`: Provides services and data structures for the access of the REST API of the app's backend.
  - `/l10n`: Files required for the localization of the app. 
  - `/pages`: Every page of the web app gets a directory here.
  - `/util`: Non-UI related tools which may be accessed from all other parts of the app.
  - `/widgets`: UI components which may be access from all pages of the app.
- `/test`: The code in the `/test` directory reflect the structure of the `/lib` directory.
- `/web`: HTML scaffold for the generated web page.

## References

- [https://docs.arc42.org/section-5/](https://docs.arc42.org/section-5/)