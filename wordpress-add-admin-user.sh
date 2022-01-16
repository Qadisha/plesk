PLESKHOME=$(cat /etc/psa/psa.conf | grep HTTPD_VHOSTS_D | sed -e 's/HTTPD_VHOSTS_D //')
ISWP='/httpdocs/wp-content/plugins'
for d in $PLESKHOME/* ; do
    [ -L "${d%/}" ] && continue

        if [ -d "$d$ISWP" ]; then
          echo "$d   is Wordpress"
          cd $d/httpdocs

          SITENAME=${d/"$PLESKHOME/"/''}
          echo $SITENAME

          ISTECHSUP=$(wp user get username --field=ID --allow-root)
          if [ -z "$ISTECHSUP" ]; then
			echo "Creating the user";
			wp user create username email@email.com --user_pass=XXXXXXXXXXXXXXX --role=administrator --allow-root
		  else
			echo $ISTECHSUP;
		  fi

          cd /root
        fi
done
