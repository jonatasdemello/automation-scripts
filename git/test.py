from github import Github

# First create a Github instance:

# using username and password
g = Github("username", "password")

# or using an access token
# g = Github("access_token")

# Github Enterprise with custom hostname
#g = Github(base_url="https://{hostname}/api/v3", login_or_token="access_token")

# Then play with your Github objects:
for repo in g.get_user().get_repos():
    print(repo.name)

for repo in g.get_user().get_emails():
    print(repo)

g.get_user().get_emails()
g.get_user().add_to_emails(*emails)
g.get_user().remove_from_emails(*emails)

g.get_user().remove_from_emails("user@users.noreply.github.com")