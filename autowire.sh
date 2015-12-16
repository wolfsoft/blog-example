#!/bin/sh

cd app

cat > autowire.dbpx<<EOL
<?xml version="1.0"?>
<!--

	Please do not modify this file. It's generated automatically by autowire.sh when compiling.

-->
<dbp:module
	xmlns:dbp="http://dbpager.org.ru/schemas/dbp/3.0"
>

<dbp:include href="config.dbpx" />
EOL

find `find . ! -path . -type d` -name '*.dbpx' -exec echo '<dbp:include href="{}" />' ';' | sort | uniq >> autowire.dbpx

cat >> autowire.dbpx<<EOL

</dbp:module>
EOL

cd ..
