### Code structure

- `/doc`: Miscellaneous files for the project documentation.
- `/lib`: Main home of the application's source code.
  - `/api`: Provides services and data structures for the access of the REST API of the app's backend.
  - `/l10n`: Files required for the localization of the app.
  - `/pages`: Every page of the web app gets a directory here.
  - `/util`: Non-UI related tools which may be accessed from all other parts of the app.
  - `/widgets`: UI components which may be access from all pages of the app.
- `/test`: The code in the `/test` directory reflect the structure of the `/lib` directory.
- `/web`: HTML scaffold for the generated web page.

### Design principles

> Clean code always looks like it was written by someone who cares. There is nothing obvious you can do to make it better. - [Michael Feathers](https://cvuorinen.net/2014/04/what-is-clean-code-and-why-should-you-care/)

- TDD: Enable a stable code base which supports regular refactoring by test-driven development.
- SOLID: Keep the code base clear to understand by the application of the SOLID design principles.
