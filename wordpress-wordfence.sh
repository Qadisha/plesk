PLESKHOME=$(cat /etc/psa/psa.conf | grep HTTPD_VHOSTS_D | sed -e 's/HTTPD_VHOSTS_D //')
ISWP='/httpdocs/wp-content/plugins'
ISWORDFENCE='/httpdocs/wp-content/plugins/wordfence'
for d in $PLESKHOME/* ; do
    [ -L "${d%/}" ] && continue

        if [ -d "$d$ISWP" ]; then
          echo "$d   is Wordpress"
          cd $d/httpdocs

          SITENAME=${d/"$PLESKHOME/"/''}
          echo $SITENAME

          if [ -d "$d$ISWORDFENCE" ]; then
                echo "There is Wordfence here."
				wp plugin deactivate wordfence --allow-root 
          else
            echo "There is NO Wordfence here."
          fi

          cd /root
        fi
done
