#!/bin/bash

# Regenerate language files for gettext
if [ -f app/vendor/lang/POTFILES.in ]; then
rm -f app/vendor/lang/POTFILES.in
fi
touch app/vendor/lang/POTFILES.in
find app/vendor/ -name '*.dbpx' -exec grep -l "http://www.w3.org/2005/11/its" '{}' ';' >>app/vendor/lang/POTFILES.in
#itstool -o app/vendor/lang/blog-example.pot `cat app/vendor/lang/POTFILES.in`
itstool -i  /usr/share/itstool/its/xhtml.its -i app/dbpager.its -o app/vendor/lang/blog-example.pot `cat app/vendor/lang/POTFILES.in`
cd app/vendor/lang/
rm -rf LINGUAS
touch LINGUAS
if [ -f *.po ]; then
for f in *.po; do
  lang=`echo $f | sed -e 's,\.po$,,'`
  msgmerge -U $lang.po blog-example.pot
  msgfmt -c -o $lang.mo $lang.po
  mkdir -p $lang/LC_MESSAGES/
  mv $lang.mo $lang/LC_MESSAGES/blog-example.mo
  echo $lang >>LINGUAS
done
fi
cd ..

