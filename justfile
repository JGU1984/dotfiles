#Using [doc("<comment>")] overrides the default comments, as a way to control what is showed in the terminal and still be able to add you own comments
[doc("List all recipes without a command")]
default:
  @just --list

### --- DAILY OPERATIONS ---

# Sync everything: pulls the latest changes from your remote repo and runs chezmoi apply (git pull with rebase/autostash)
[group('daily')]
[confirm('Sure you want to pull the latest changes and apply them to the destination state?')]
sync:
  chezmoi update

# See remote changes without applying it (usable if dotfiles is managed on more than one machine)
[group('daily')]
check:
  chezmoi git fetch
  chezmoi diff

# See what changes chezmoi would make to destination state (--reverse for vice versa)
[group('daily')]
diff *flags:
  @chezmoi diff {{flags}}

# Quick summary of what files would change if you ran chezmoi apply
[group('daily')]
stat:
  chezmoi status

# Apply updates from the source state to destionation state (accepts flags, e.g. -n -v for dry-run verbose)
[group('daily')]
[confirm('Are you sure you want to overwrite the destination state?')]
apply *flags:
  chezmoi apply {{flags}}

# Launch chezmoi source directory in a shell (exit to return)
[group('daily')]
cd:
  chezmoi cd



### --- FILE MANAGEMENT ---

# Add file from PWD (Example: cj track .zshrc)
[group('files')]
add file:
  chezmoi add {{invocation_directory()}}/{{file}}
  @echo "{{file}} added from {{invocation_directory()}}"

# Remove file from the source state, i.e. stop managing them.
[group('files')]
rm file:
  chezmoi forget {{invocation_directory()}}/{{file}}
  @echo "{{file}} removed from chezmoi tracking"

# List managed files
[group('files')]
lm:
  chezmoi managed

# List unmanged files
[group('files')]
lu:
  chezmoi unmanaged



### --- EDITING ---

# Edit source state file and apply changes to the destination state
[group('edit')]
ea file:
  chezmoi edit --apply {{invocation_directory()}}/{{file}}

# Edit source state file
[group('edit')]
e file:
  chezmoi edit {{invocation_directory()}}/{{file}}

#Reminder - you migth have to change the path for intellij on a new computer for it to be opened as the merge tool (.config/chezmoi/chezmoi.toml)
# Launch merge tool to peform a three-way merge between the destination state, the target state and the source state
[group('edit')]
merge file:
  chezmoi merge {{invocation_directory()}}/{{file}}



### --- GIT / BACKUP ---
# No need for chezmoi git <command> since "cj" zsh alias points to the chezmoi source directory

# Chezmoi git status
[group('git')]
gs:
  git status

# Chezmoi git diff
[group('git')]
gd:
  git diff

# Commit and push chezmoi changes (Example: cj save "Commit message")
[group('git')]
[confirm('Sure you want to add all files and push to remote repository?')]
save message:
  git add .
  git commit -m {{quote(message)}}
  git push



### --- DEBUG ---

# Checks for common problems. If you encounter something unexpected, run this first
[group('misc')]
doc:
  chezmoi doctor



### --- Templates ---

# Print all available template data variables
[group('template')]
data:
    chezmoi data

# Add a new file and automatically make it a template
[group('template')]
[confirm('Sure you want to add the file as a template?')]
add-template file:
    chezmoi add --template {{file}}

# Convert an existing managed file into a template
[group('template')]
[confirm('Sure you want to convert the file into a template?')]
make-template file:
    chezmoi chattr +template {{file}}

# Preview the computed target contents of a file without changing it
[group('template')]
cat-template file:
    chezmoi cat {{file}}

# Test and debug custom template syntax strings via standard input
[group('template')]
test-template string:
    echo {{quote(string)}} | chezmoi execute-template
