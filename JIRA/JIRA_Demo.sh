# JIRA Demo

export DOMAIN=pag-demo.com
docker pull cptactionhank/atlassian-jira:latest

vim /etc/hosts
    127.0.0.1 jira.pag-demo.com www.jira.pag-demo.com
    127.0.0.1 wiki.pag-demo.com www.wiki.pag-demo.com
    127.0.0.1 bitbucket.pag-demo.com www.bitbucket.pag-demo.com

docker exec -it atlassian_database_1  psql -U postgres
   CREATE DATABASE jira;
   CREATE DATABASE wiki;
   CREATE DATABASE bitbucket;
   \l
   \q



        "Containers": {
            "46c1309b49f871423df22a5228330246c0d64288db243330cac137ee42a2edc3": {
                "Name": "atlassian_database_1",
                "EndpointID": "22f79f00ba1acb893db0ece8d9be675822dda59be92580d76cef4b18fb04dae9",
                "MacAddress": "02:42:ac:17:00:02",
                "IPv4Address": "172.23.0.2/16",
                "IPv6Address": ""
            },
            "4f09557bf92b1cd41442d8247511b809aedbfd7703a6398e5501341eaae0f7d4": {
                "Name": "atlassian_jira_1",
                "EndpointID": "2ccf098182e53f856dea40fb8637798332b34d53c7c4e60012cf988745f01de5",
                "MacAddress": "02:42:ac:17:00:05",
                "IPv4Address": "172.23.0.5/16",
                "IPv6Address": ""
            },
            "7c54d3758636ba0ff23223b6f47d4de547d9e87d9374c1a0fa9cfece33be4596": {
                "Name": "atlassian_bitbucket_1",
                "EndpointID": "3d2232f93fb01246eb73fd6aa0df6358fef70f162cd47b0f17bcad04b8e48976",
                "MacAddress": "02:42:ac:17:00:03",
                "IPv4Address": "172.23.0.3/16",
                "IPv6Address": ""
            },
            "c23b2daecd6099f3947b0a56d7744639eb90c57cce0dd9a07c1d295c16b81473": {
                "Name": "atlassian_confluence_1",
                "EndpointID": "28ff3eb2f68425da5083aa8b79708e2ef2f575ae9df211cf61369f553776f219",
                "MacAddress": "02:42:ac:17:00:04",
                "IPv4Address": "172.23.0.4/16",
                "IPv6Address": ""
            },
            "c668f1a897b73f6bf319e3fe465b492f6cb462e123a93ada5332a41603ae1136": {
                "Name": "atlassian_nginx_1",
                "EndpointID": "35596a8fe74611b24e297a7039c8bf0d6ff881fbd26c5f243f223e1a28a57c2a",
                "MacAddress": "02:42:ac:17:00:06",
                "IPv4Address": "172.23.0.6/16",
                "IPv6Address": ""



Jira 			http://172.23.0.5:8080
Bitbucket 		http://172.23.0.3:7990
Confluence 		http://172.23.0.4:8090



BEL5-G1UY-ED0F-UJ11


AAABUQ0ODAoPeNqtklFLwzAUhd/zKwK+6ENGUxzSQcHZ1jHpumk3QfAlltst0Kb1Jinu35uuGw7xa
fgQCDfJOd89N1frnaVZ01GfU+5NvGDiezTK19T3eEBi0AXK1shGhc8WdL/RtGyQRo0qKwuqAHqdA
3aAN+8TmnSisqK/RTJbfwAuy40G1CHjJEI4nMTCQNirM86Z7xOnZERhMlFDqIvdHgHL+20tZDUqm
pq4NRKmElpLoVzlZDtqK7uVSp+V2OcJceQEZQehQQsXKuRGoAEMS1FpOEEmC4f1F+VP44NnJQtQG
l5d733NJ+6hMqCEM0m+Won7sxj8PobLKNPBZ71v4RBgtFwskpdoPk3JErdCST1AraYzGkPdkGFW8
zh8SNIxm/HNG0ti75FtnjgneZKFbrGU344DHvh35Kj/n8jgcsAWpT6OZ2Wx2AkNv//FN0aP6fgwL
AIUREDraiZ5SsofQDsbQctGDhNZUc4CFBOLJTYBjU4eHcm//wnjZmGsl/Y9X02gk



AAABPw0ODAoPeNptkE9rwjAYxu/5FIFdtkOlKQoqBObaThy1yloHg8HIsrcaaNPyJi3z2y+1yoZ4y
CXJ83v+3OWHlqZ1RwNGmT/3p/PxmIZZTgOfzUgERqJqrKo1z0FUNBQl6G+BhhY10rDWRdmClkDvM
8AO8OFjTuNOlK3oNSRtqy/ATbEzgIZ7jFgH+ZQXyAi0BWxQGeAWWyAhwkkYCQu8T+Ax5gUBcUZWS
JuKCriRhyMCFo/7SqhyJOvqmup+qu5MvHrKrEBnyQtRGrhg47UD3eL+NRlgpZKgDby5Mv1dQJzQN
dDCLRD/NAqP/4IHffAr+2QA5McGTl3CzXodv4arRUI2uBdamcFtu1jSCKqaDKuuIv4UJxNvyXbvX
hz5z97uhTGSxSl3x0vYeDJjMzYlZ/7tLNsW5UEYuB73F085rd4wLAIUcm+D0wl92M9vmWi+675M1
GvzNLUCFGSY1r5qItdvcmicgTyQWQPHLxtEX02fr




git config --global user.name "Fabi"
git config --global user.email "schyrerf@gmail.com"


git clone http://fabi@172.23.0.3:7990/scm/pd/pag-demo-repo-1.git




cd existing-project
git init
git add --all
git commit -m "Initial Commit"
git remote add origin http://fabi@172.23.0.3:7990/scm/pd/pag-demo-repo-1.git
git push -u origin master



cd existing-project
git remote set-url origin http://fabi@172.23.0.3:7990/scm/pd/pag-demo-repo-1.git
git push -u origin --all
git push origin --tags



Confluence Hook Key
([A-Z][A-Z\d_]*)-(\d+)




atlassian_nginx_1
atlassian_jira_1
atlassian_bitbucket_1
atlassian_confluence_1
atlassian_database_1


https://www.tacticalprojectmanagement.com/atlassian-summit-2019/


https://www.slideshare.net/GoAtlassian/your-journey-to-cloudnative-begins-with-devops-microservices-and-containers?qid=4a4f5e52-9c3f-4fae-a2f5-8a02142410c3&v=&b=&from_search=24
https://www.slideshare.net/GoAtlassian/building-a-culture-of-trust-and-transparency-through-confluence?qid=4a4f5e52-9c3f-4fae-a2f5-8a02142410c3&v=&b=&from_search=25
https://www.slideshare.net/GoAtlassian/seven-sequential-steps-for-devops-success?qid=4a4f5e52-9c3f-4fae-a2f5-8a02142410c3&v=&b=&from_search=30
https://www.slideshare.net/GoAtlassian/devops-starts-by-knowing-your-numbers?qid=4a4f5e52-9c3f-4fae-a2f5-8a02142410c3&v=&b=&from_search=29
https://www.slideshare.net/GoAtlassian/an-admins-guide-for-running-confluence-at-scale-for-10000-yahoo-japan-users?qid=4a4f5e52-9c3f-4fae-a2f5-8a02142410c3&v=&b=&from_search=69
https://www.slideshare.net/GoAtlassian/the-top-5-skills-enterprise-admins-need-to-know?qid=4a4f5e52-9c3f-4fae-a2f5-8a02142410c3&v=&b=&from_search=70




