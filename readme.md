# **What's included in the repo?** #

This repo contains the necessary cookbooks for the following applications:-

**Nagios-Remote (nagios-remote.json)**

NRPE version 2.13
Nagios plugins version 1.4.16

Tested on a Ubuntu 11.04 system


**Postgres and Postgis (postgres_postgis.json)**

Installs Postgres 9.1.2 and Postgis 2 from source.

**RasterStats (starspan.json)**

Installs GDAL 1.9.0, GEOS 3.2.2, Ruby 1.9.3, Starspan and Raster-stats

*Note* Only works on a Ubuntu 10.04 system

**TileMill (tilemill.json)**

Installs mapnik, node, nodejs, sqlite, projectmill and tilemill

Only tested on a Ubuntu 10.04 system

# **How do I use the repo?** #

Firstly do

git clone https://github.com/strtwtsn/WCMC_Cookbooks.git

Then to install the application do:-

chef-solo -c /var/chef/config/chef-solo.rb -j /var/chef/roles/role.json file


*Note*  Replace role.json with the relevant json file from the list above.


