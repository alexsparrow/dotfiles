# Performance patch - AS 19/11/2010
if [ "$PS1" ] ; then 
mkdir -m 0700 /dev/cgroup/cpu/user/$$
echo $$ > /dev/cgroup/cpu/user/$$/tasks
fi

source ~/.alexdot/my.zsh
