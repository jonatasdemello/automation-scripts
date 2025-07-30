replace YOURUSERNAME by your username and use:

CNTX={users|orgs}; NAME={username|orgname}; PAGE=1
curl "https://api.github.com/$CNTX/$NAME/repos?page=$PAGE&per_page=100" |
  grep -e 'git_url*' |
  cut -d \" -f 4 |
  xargs -L1 git clone

Set CNTX=users and NAME=yourusername, to download all your repositories.
Set CNTX=orgs and NAME=yourorgname, to download all repositories of your organization.

The maximum page-size is 100, so you have to call this several times with the right page number to get all your repositories
(set PAGE to the desired page number you want to download).


Organisation repositories
To clone all repos from your organisation, try the following shell one-liner:

GHORG=company; curl "https://api.github.com/orgs/$GHORG/repos?per_page=1000" | grep -o 'git@[^"]*' | xargs -L1 git clone
User repositories
Cloning all using Git repository URLs:

GHUSER=CHANGEME; curl "https://api.github.com/users/$GHUSER/repos?per_page=1000" | grep -o 'git@[^"]*' | xargs -L1 git clone
Cloning all using Clone URL:

GHUSER=CHANGEME; curl "https://api.github.com/users/$GHUSER/repos?per_page=1000" | grep -w clone_url | grep -o '[^"]\+://.\+.git' | xargs -L1 git clone
Here is the useful shell function which can be added to user's startup files (using curl + jq):

# Usage: gh-clone-user (user)
gh-clone-user() {
  curl -sL "https://api.github.com/users/$1/repos?per_page=1000" | jq -r '.[]|.clone_url' | xargs -L1 git clone
}
Private repositories
If you need to clone the private repos, you can add Authorization token either in your header like:

-H 'Authorization: token <token>'
or pass it in the param (?access_token=TOKEN), for example:

curl -s "https://api.github.com/users/$GHUSER/repos?access_token=$GITHUB_API_TOKEN&per_page=1000" | grep -w clone_url | grep -o '[^"]\+://.\+.git' | xargs -L1 git clone

Notes:

To fetch only private repositories, add type=private into your query string.
Another way is to use hub after configuring your API key.

