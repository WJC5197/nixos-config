# Check if the required arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <machine> <login>"
  exit 1
fi

MACHINE="$1"
LOGIN="$2"

# Decrypt the .authinfo.gpg file and store the content in a variable
AUTHINFO=$(gpg -dq ~/.authinfo.gpg 2>/dev/null)

if [ -z "$AUTHINFO" ]; then
  echo "Failed to decrypt ~/.authinfo.gpg"
  exit 1
fi

# Search for the password corresponding to the given machine and login
PASSWORD=$(echo "$AUTHINFO" | awk -v m="$MACHINE" -v l="$LOGIN" '$2 == m && $4 == l {print $6}')

if [ -n "$PASSWORD" ]; then
  echo "$PASSWORD"
else
  echo "No matching entry found"
  exit 1
fi
