
USE `geo_maps`;

CREATE TABLE `geo_tracks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` char(255) NOT NULL,
  `track_file_body` MEDIUMTEXT NOT NULL,
  `track_file_name` char(255) NOT NULL,
  `track_file_mime` char(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;
