
CREATE TABLE `chan_groups` ( 
	`id`                 	int(10) UNSIGNED AUTO_INCREMENT NOT NULL,
	`chan_group_name`    	varchar(50) NULL,
	`max_channels_cnt`   	int(11) NULL,
	`max_channels_online`	int(11) NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `chan_prefix_groups` ( 
	`id`                 	int(10) UNSIGNED AUTO_INCREMENT NOT NULL,
	`channel_id`         	int(11) NULL,
	`prefix_group_id`    	int(11) NULL,
	`max_minutes_per_day`	int(11) NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `channels` ( 
	`id`                	int(10) UNSIGNED AUTO_INCREMENT NOT NULL,
	`sip_id`            	int(11) NULL,
	`interval_mins`     	int(11) NULL,
	`calls_per_interval`	int(11) NULL,
	`call_min_interval` 	int(11) NULL,
	`status`            	int(11) NULL,
	`chan_group_id`     	int(11) NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `codecs` ( 
	`id`         	int(10) UNSIGNED AUTO_INCREMENT NOT NULL,
	`codec_name` 	varchar(40) NULL,
	`description`	varchar(100) NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `prefix_groups` ( 
	`id`             	int(10) UNSIGNED AUTO_INCREMENT NOT NULL,
	`group_name`     	varchar(255) NULL,
	`rate`           	decimal(10,4) NULL,
	`init_charge`    	decimal(10,4) NULL,
	`minutes_per_day`	int(11) NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `prefixes` ( 
	`id`             	int(10) UNSIGNED AUTO_INCREMENT NOT NULL,
	`prefix_group_id`	int(11) NULL,
	`prefix`         	varchar(200) NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `sip` ( 
	`id`              	int(11) AUTO_INCREMENT NOT NULL,
	`user_id`         	int(11) NOT NULL,
	`name`            	varchar(80) NOT NULL,
	`host`            	varchar(31) NOT NULL DEFAULT 'dynamic',
	`nat`             	varchar(5) NOT NULL DEFAULT 'yes',
	`type`            	enum('user','peer','friend') NOT NULL DEFAULT 'friend',
	`accountcode`     	varchar(20) NULL,
	`amaflags`        	varchar(13) NULL,
	`call-limit`      	smallint(5) UNSIGNED NULL,
	`callgroup`       	varchar(10) NULL,
	`callerid`        	varchar(80) NULL,
	`cancallforward`  	char(3) NULL DEFAULT 'yes',
	`canreinvite`     	char(3) NULL DEFAULT 'yes',
	`context`         	varchar(80) NULL,
	`defaultip`       	varchar(15) NULL,
	`dtmfmode`        	varchar(7) NULL,
	`fromuser`        	varchar(80) NULL,
	`fromdomain`      	varchar(80) NULL,
	`insecure`        	varchar(15) NULL,
	`language`        	char(2) NULL,
	`mailbox`         	varchar(50) NULL,
	`md5secret`       	varchar(80) NULL,
	`deny`            	varchar(95) NULL,
	`permit`          	varchar(95) NULL,
	`mask`            	varchar(95) NULL,
	`musiconhold`     	varchar(100) NULL,
	`pickupgroup`     	varchar(10) NULL,
	`qualify`         	char(3) NULL,
	`regexten`        	varchar(80) NULL,
	`restrictcid`     	varchar(25) NULL,
	`rtptimeout`      	char(3) NULL,
	`rtpholdtimeout`  	char(3) NULL,
	`secret`          	varchar(80) NULL,
	`setvar`          	varchar(100) NULL,
	`disallow`        	varchar(100) NULL DEFAULT 'all',
	`allow`           	varchar(100) NULL DEFAULT 'ulaw;alaw;gsm;',
	`fullcontact`     	varchar(80) NOT NULL,
	`ipaddr`          	varchar(45) NOT NULL,
	`port`            	smallint(5) UNSIGNED NOT NULL DEFAULT '0',
	`regserver`       	varchar(100) NULL,
	`regseconds`      	int(11) NOT NULL DEFAULT '0',
	`lastms`          	int(11) NOT NULL DEFAULT '0',
	`username`        	varchar(80) NOT NULL,
	`defaultuser`     	varchar(80) NOT NULL,
	`subscribecontext`	varchar(80) NULL,
	`useragent`       	varchar(33) NULL,
	`authuser`        	varchar(25) NULL,
	`commented`       	int(11) NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `sip_conf` ( 
	`id`         	bigint(20) UNSIGNED AUTO_INCREMENT NOT NULL,
	`cat_metric` 	int(11) NOT NULL DEFAULT '0',
	`var_metric` 	int(11) NOT NULL DEFAULT '0',
	`filename`   	varchar(128) NULL DEFAULT 'sip.conf',
	`category`   	varchar(128) NULL DEFAULT 'general',
	`var_name`   	varchar(128) NOT NULL,
	`var_val`    	varchar(128) NOT NULL,
	`commented`  	smallint(6) NOT NULL DEFAULT '0',
	`description`	varchar(255) NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `user_prefix_groups` ( 
	`id`                 	int(10) UNSIGNED AUTO_INCREMENT NOT NULL,
	`user_id`            	int(11) NULL,
	`prefix_group_id`    	int(11) NULL,
	`max_minutes_per_day`	int(11) NULL,
	`rate`               	decimal(10,4) NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `users` ( 
	`id`              	int(11) AUTO_INCREMENT NOT NULL,
	`login`           	varchar(15) NULL,
	`password`        	varchar(15) NULL,
	`company`         	varchar(100) NULL DEFAULT 'Private',
	`company_logo`    	varchar(100) NULL DEFAULT '/img/bird.gif',
	`application_name`	varchar(100) NULL DEFAULT 'Telefony',
	`last_login`      	datetime NULL,
	`email`           	varchar(60) NULL,
	`role_id`         	int(11) NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `vatson_regmonitor` ( 
	`host`          	varchar(200) NULL,
	`username`      	varchar(50) NULL,
	`status`        	varchar(20) NULL,
	`regtime`       	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`mail_sent_time`	timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' 
	);

CREATE TABLE `vatson_regmonitor_tmp` ( 
	`host`          	varchar(200) NULL,
	`username`      	varchar(50) NULL,
	`status`        	varchar(20) NULL,
	`regtime`       	timestamp NULL,
	`mail_sent_time`	timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' 
	);

CREATE TABLE `vatson_settings` ( 
	`id`                      	int(10) UNSIGNED AUTO_INCREMENT NOT NULL,
	`amanager_login`          	varchar(50) NULL,
	`amanager_password`       	varchar(50) NULL,
	`amanager_host`           	varchar(60) NULL,
	`show_sip_reg_in_settings`	int(11) NULL DEFAULT '1',
	`show_sip_line_status`    	int(11) NULL DEFAULT '0',
	PRIMARY KEY(`id`)
);

ALTER TABLE `sip_conf`
	ADD CONSTRAINT `id`
	UNIQUE (`id`);

ALTER TABLE `channels`
	ADD CONSTRAINT `chan_groups`
	FOREIGN KEY(`chan_group_id`)
	REFERENCES `chan_groups`(`id`);

ALTER TABLE `chan_prefix_groups`
	ADD CONSTRAINT `channel_groups`
	FOREIGN KEY(`channel_id`)
	REFERENCES `channels`(`id`);

ALTER TABLE `prefixes`
	ADD CONSTRAINT `prefix_group_prefixes`
	FOREIGN KEY(`prefix_group_id`)
	REFERENCES `prefix_groups`(`id`);

ALTER TABLE `chan_prefix_groups`
	ADD CONSTRAINT `channel_prefix_group`
	FOREIGN KEY(`prefix_group_id`)
	REFERENCES `prefix_groups`(`id`);

ALTER TABLE `user_prefix_groups`
	ADD CONSTRAINT `user_prefix_group`
	FOREIGN KEY(`prefix_group_id`)
	REFERENCES `prefix_groups`(`id`);

ALTER TABLE `sip`
	ADD CONSTRAINT `user_gateways`
	FOREIGN KEY(`user_id`)
	REFERENCES `users`(`id`);

ALTER TABLE `user_prefix_groups`
	ADD CONSTRAINT `user_prefixes`
	FOREIGN KEY(`user_id`)
	REFERENCES `users`(`id`);

