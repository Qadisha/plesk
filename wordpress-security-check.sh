#!/bin/bash
set -e




for d in $HOMEDIR/* ; do
  if [ -d "$d" ] && [[ "$d" != *"system" ]] && [[ "$d" != *"fs" ]] && [[ "$d" != *"fs-passwd" ]] && [[ "$d" != *"default" ]] && [[ "$d" != *"chroot" ]]; then

    echo "$d"
    cd "$d"/httpdocs


    SYMLINKNO=$(ls -lR . | grep ^l |wc -l)
    if [[ $SYMLINKNO -gt 0 ]]; then
      echo "Symlinks in the directory"
    fi

    if [ -f "wp-config.php" ]; then

      echo "This is Wordpress"
      #ls -lah index.php

      echo "Adjust Permissions"
      find . -type d -exec chmod 0755 {} \;
      find . -type f -exec chmod 0644 {} \;

      echo "List users"
      #wp user list --allow-root


      echo "Remove Protect Uploads fake plugin"
      find . -type f -name "protect-uploads.php" | sort -u | while read -r dir; do
	echo "Deleting directory: $dir"
	rm -rf "$dir"
      done

	pwd

      echo "Check critical files"
      if grep -rnw .htaccess -e 'wp-config-sample'; then
         echo "wp-config-sample"
      fi
      if grep -rnw wp-config.php -e '@include'; then
         echo "Bad inclusion"
      fi
      if grep -rnw index.php -e '@include'; then
         echo "Bad inclusion"
      fi


      echo "Remove insecure dot-files"
      find . -type f -name '.*.inc' -delete
      find . -type f -name '.*.ico' -delete
      find . -type f -name '.*.mo' -delete
      find . -type f -name '.listing' -delete
      find . -type f -name 'php.ini' -delete

      echo "Search for fake themes"
      find . -type d -name "consultstreet"
      if grep -rnw index.php -e 'FitnessBase'; then
         echo "FitnessBase theme"
      fi


      # Check core directories and place custom .htaccess
      cat <<EOF > wp-content/uploads/.htaccess
      DirectoryIndex index.php index.html index.htm
      <FilesMatch "\.(php|php\.)$">
       Order Allow,Deny
       Deny from all
      </FilesMatch>
EOF

      cat <<EOF > wp-content/plugins/.htaccess
      DirectoryIndex index.php index.html index.htm
      <FilesMatch "\.(php|php\.)$">
       Order Allow,Deny
       Deny from all
      </FilesMatch>
EOF

      cat <<EOF > wp-content/themes/.htaccess
      DirectoryIndex index.php index.html index.htm
      <FilesMatch "\.(php|php\.)$">
       Order Allow,Deny
       Deny from all
      </FilesMatch>
EOF


    fi

  fi
done

