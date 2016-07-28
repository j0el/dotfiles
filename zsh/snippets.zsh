# Find snippets
function find:days()         { find . -type f -mtime -$1 | grep -v "/.git/" }
function find:minutes()      { find . -type f -mmin -$1 | grep -v "/.git/" }
function find:biggest()      { find . -type f -print0 | xargs -0 du | sort -n | tail -10 | cut -f2 | xargs -I{} du -sh {} }
function find:content()      { grep --include=\*.php -rnw '.' -e "$1" }
function find:duplicated()   { fdupes -r . }

# MySQL snippets
function mysql:list()        { mysql -e "show databases;" }
function mysql:create()      { mysql -e "create database \`$1\`;" }
function mysql:drop()        { mysql -e "drop database \`$1\`;" }
function mysql:drop-tables() { mysqldump --add-drop-table --no-data $1 | grep -e "^DROP \| FOREIGN_KEY_CHECKS" | mysql $1 }

# SSH snippets
function ssh:list()          { cat ~/.ssh/config | grep "Host " | grep -v "Host \*" | sed 's/Host //g' | sort }
function ssh:combine()       { cp ~/.ssh/config ~/.ssh/config.bak && cat ~/.ssh/config.d/* > ~/.ssh/config } # allow for multiple ssh config files
function ssh:keygen()        { ssh-keygen -t rsa -b 4096 -C "$1"}

# Terminal snippets
function term:test256()      { for code in $(seq -w 0 255); do for attr in 0 1; do printf "%s-%03s %bTest%b\n" "${attr}" "${code}" "\e[${attr};38;05;${code}m" "\e[m"; done; done | column -c $((COLUMNS*2)) }