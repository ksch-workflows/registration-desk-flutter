### Git hooks

It is recommended to add the following [Git hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks) to your local repository:

`.git/hooks/pre-commit`:

```bash
#!/bin/bash

set -e

dart format . --set-exit-if-changed
flutter test
```

`.git/hooks/pre-push`:

```bash
#!/bin/bash

set -e

flutter analyze --fatal-infos
```
