#!/bin/bash

# Exports
DEVICE=$(echo $TARGET_PRODUCT | sed 's/sigma_//g')
out=$OUT_DIR/target/product/$DEVICE
if [ -f $out ]; # The path does not exist
then
	echo "The path to create changelog does not exist, exiting..."
	exit
fi

export Changelog=Changelog.txt

if [ -f $Changelog ];
then
	rm -f $Changelog
fi

touch $Changelog

# Print something to build output
echo "Generating changelog..."

# define changelog_days using 'export changelog_days=10'
# this can be done before intiate build environment (. build/envsetup.sh)
if [ -z $changelog_days ];then
	changelog_days=14
else
	if (($changelog_days > 30 )); then
        echo "Changelog can not generated for more than 30 days. For how many days do you want to generate changelog again? (🕑 timeout 15 seconds - default to 10 days)"
        read -r -t 15 changelog_days || changelog_days=10
	fi
fi

REPO_LIST="$(repo list --path | sed 's|^vendor/OTA$||')"
for i in $(seq $changelog_days); do
    After_Date=`date --date="$i days ago" +%m-%d-%Y`
    k=$(expr $i - 1)
    Until_Date=`date --date="$k days ago" +%m-%d-%Y`

    # Line with after --- until was too long for a small ListView
    echo '====================' >> $Changelog
    echo  "     "$Until_Date    >> $Changelog
    echo '====================' >> $Changelog

    # Cycle through all available repos
    for repo_path in $REPO_LIST; do
        # Find commits between 2 dates
        GIT_LOG="$(git -C "$repo_path" log --oneline --after="$After_Date" --until="$Until_Date" --pretty=format:"%h - %s (by %an)" --date=format:"%Y-%m-%d")"
        [ -n "$GIT_LOG" ] && {
            printf '\n   * '; echo "$repo_path"
            echo "$GIT_LOG"
        } >> $Changelog
    done
    echo >> $Changelog
done

sed -i 's/project/   */g' $Changelog

cp $Changelog $OUT_DIR/target/product/$DEVICE/system/etc/$Changelog
cp $Changelog $OUT_DIR/target/product/$DEVICE/system/etc/Changelog.txt
cp $Changelog $OUT_DIR/target/product/$DEVICE/
