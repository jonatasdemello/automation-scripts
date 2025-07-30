# change <repo>

repo=jonatasdemello

curl -s https://api.github.com/users/$repo/repos | grep \"clone_url\" | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g' | xargs -n1 git clone


curl -s https://api.github.com/users/jonatasdemello/repos | grep \"clone_url\" | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g' | xargs -n1 git clone
