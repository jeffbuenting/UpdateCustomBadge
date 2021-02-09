FROM mcr.microsoft.com/powershell:ubuntu-18.04

LABEL "com.github.actions.name"="UpdateCustomBadge"
LABEL "com.github.actions.description"="Updates a Custom Badge"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/jeffbuenting/UpdateCustomBadge"
LABEL "homepage"="https://jeffbuenting.github.io"
LABEL "maintainer"="Jeff Buenting"

COPY PSScript.ps1 /PSScript.ps1
ENTRYPOINT ["pwsh", "/PSScript.ps1"]
