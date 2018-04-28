from github import Github

token =  '4cf058e03ed6eecb22deeacf7da370e532d0736c'
#USERS = ("openstack-infra", "stackforge", "openstack-dev", "openstack")
USERS = ("openstack-infra", None)

g = Github(token)
me = g.get_user()


for username in USERS:
    print username
    user = g.get_user(username)
    print user.name
    for repo in user.get_repos():
        contributors = repo.get_contributors()
        print repo.name
        for human in contributors:
            if me.name == human.name:
                me.add_to_starred(repo)
                print("Starred %s" % repo.full_name)

        if 'system-config' in repo.name:
            from pdb import set_trace; set_trace()
