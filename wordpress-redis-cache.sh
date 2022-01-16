PLESKHOME=$(cat /etc/psa/psa.conf | grep HTTPD_VHOSTS_D | sed -e 's/HTTPD_VHOSTS_D //')
ISWP='/httpdocs/wp-content/plugins'
ISREDIS='/httpdocs/wp-content/plugins/redis-cache'
for d in $PLESKHOME/* ; do
    [ -L "${d%/}" ] && continue

        if [ -d "$d$ISWP" ]; then
          echo "$d   is Wordpress"
          cd $d/httpdocs

          SITENAME=${d/"$PLESKHOME/"/''}
          echo $SITENAME

          if [ -d "$d$ISREDIS" ]; then
                echo "There is REDIS here."
          else
            echo "There is NO REDIS here."
			sed -i "2 i define( 'WP_REDIS_DATABASE', 0 );" wp-config.php
			sed -i "2 i define( 'WP_REDIS_PREFIX', '$SITENAME' );" wp-config.php
			sed -i "2 i define( 'WP_REDIS_SELECTIVE_FLUSH', true );" wp-config.php

			wp plugin install redis-cache --allow-root
			wp plugin activate redis-cache --allow-root
			wp redis enable --allow-root
			wp redis update-dropin --allow-root
			wp redis status --allow-root
          fi

          cd /root
        fi
done
