##set name and email
usethis::use_git_config(user.name = "Akash Guntamadugu",
                        user.email = "sky.akashg@gmail.com")

## create a personal access token 4 auth
usethis::create_github_token()

##set personal access token
credentials::set_github_pat("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")
