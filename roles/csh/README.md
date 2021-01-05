# C-Shell Configuration Files

The basic `cshrc` resource script, add `$HOME/.cshrc.d/local` to use private
local configuration.

## Sample Custom Configuration

In `$HOME/.cshrc.d/local` create Android SDK and Go environment:

```csh
# set Android SDK environment
setenv ANDROID_HOME "$HOME/Library/Android/sdk"
set path = ( $path $ANDROID_HOME/{emulator,tools,platform-tools} $ANDROID_HOME/tools/bin )

# set Go environment
setenv GOPATH "$HOME/Library/go"
set path = ( $GOPATH/bin $path )
```

<!--
[//]: <> vim: set filetype=markdown :
-->
