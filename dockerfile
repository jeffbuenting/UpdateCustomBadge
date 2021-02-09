FROM mcr.microsoft.com/powershell:ubuntu-latest

LABEL "com.github.actions.name"="UpdateCustomBadge"
LABEL "com.github.actions.description"="Updates a Custom Badge"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/jeffbuenting/UpdateCustomBadge"
LABEL "homepage"="https://jeffbuenting.github.io"
LABEL "maintainer"="Jeff Buenting"

COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

#COPY PSScript.ps1 /PSScript.ps1
#ENTRYPOINT ["pwsh", "/PSScript.ps1"]
#