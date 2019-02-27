for repo in $*
do
    if [ ! -L $repo ]; then
        if [ -d $repo ]; then
            echo "removing existing directory: "$repo
            rm -rf $repo
        fi
        echo "sym linking:$repo to /git/$repo/recipe"
        ln -s /git/$repo/recipe $repo
    else
        echo $repo" is already linked"
    fi
done
