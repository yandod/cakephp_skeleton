if !Dir.exist?(config.shared_path + "/app/Config") then
  run "mkdir -p #{config.shared_path}/app/Config/"
  run "cp #{config.release_path}/app/Config/core.php #{config.shared_path}/app/Config/core.php"
  run "echo \"<?php
  class DATABASE_CONFIG {
  	var \\\$default = array(
  		'datasource' => 'Database/Mysql',
  		'persistent' => false,
  		'host' => '',
  		'login' => '',
  		'password' => '',
  		'database' => '',
  		'prefix' => '',
  		'port' => '',
  		'encoding' => 'utf8',
  	);
  	public function __construct()
  	{
  	  \\\$this->default = array(
    		'datasource' => 'Database/Mysql',
    		'persistent' => false,
    		'host' => isset(\\\$_SERVER['DB_HOST']) ? \\\$_SERVER['DB_HOST'] : EY_DB_HOST,
    		'login' => isset(\\\$_SERVER['DB_USER']) ? \\\$_SERVER['DB_USER'] : EY_DB_USER,
    		'password' => isset(\\\$_SERVER['DB_PASS']) ? \\\$_SERVER['DB_PASS'] : EY_DB_PASS,
    		'database' => isset(\\\$_SERVER['DB_NAME']) ? \\\$_SERVER['DB_NAME'] : EY_DB_NAME,
    		'prefix' => '',
    		'port' => '',
    		'encoding' => 'utf8',
    	);
  	}
  }\" > #{config.shared_path}/app/Config/database.php"
end

# set timezone in php.ini
sudo "echo 'date.timezone = Asia/Tokyo' > /etc/php/cgi-php5.4/ext-active/timezone.ini"
sudo "echo 'date.timezone = Asia/Tokyo' > /etc/php/cli-php5.4/ext-active/timezone.ini"
sudo "echo 'date.timezone = Asia/Tokyo' > /etc/php/fpm-php5.4/ext-active/timezone.ini"

# prepare shared files and directories
run "rm #{config.release_path}/app/Config/core.php && ln -s #{config.shared_path}/app/Config/core.php #{config.release_path}/app/Config/core.php"
run "rm #{config.release_path}/app/Config/database.php && ln -s #{config.shared_path}/app/Config/database.php #{config.release_path}/app/Config/database.php"

