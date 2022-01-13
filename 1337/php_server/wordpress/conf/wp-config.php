<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'DATABASE_NAME' );

/** MySQL database username */
// define( 'DB_USER', 'abdel-ke' );
define( 'DB_USER', 'DATABASE_USER' );

/** MySQL database password */
define( 'DB_PASSWORD', 'DB_USER_PASS' );

/** MySQL hostname */
define( 'DB_HOST', 'DB__HOST' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         ')`:!8~p}%FsGt70ZJ=,?R~*5~WLbP/;p/77eFDL4|:fih7[{vJP`T^A0iX%&VLaC');
define('SECURE_AUTH_KEY',  'tZ|M[jq@Ka7}SpZ.[<h,LZl)Qh4P:~V`ILrYO}jTjCoW%|vT|7]|l0|e9{<(nX*{');
define('LOGGED_IN_KEY',    'YgbGUrp>%xP#TCc0IEmBCn~9o0+aM&3iIaLSIi+j{Wz8.iEP[q+cEQdW(-w;Mu^x');
define('NONCE_KEY',        'qR*wbrX_^*/yBl+k|nr`Qa_S{c<fK=o3F`ArRamc*ks}D+@qs$@4b,m|_XN02N{=');
define('AUTH_SALT',        'ZMWLslnfYcMcW}|~LA|7!DMWl*]X{e9J=+fi*>>Z&Vt)T?20lv5>TwH42m?pkndU');
define('SECURE_AUTH_SALT', ':P5{^[srv-q~XRODl;/$bLtz+)JTqqR4<]x&76)6wRrmT0}~&S|QaC[}P$TVw5p$');
define('LOGGED_IN_SALT',   '?~gf5yJlb<)3t8@KPavrwxbV^Z>)G4WL$|(|a=H<8#eYi_sh@nr$T c(y`0=).X#');
define('NONCE_SALT',       'DBpCXfp_hy=,`Olga/@v>=-HsADc!|{w>3Mi7v,!DFOezhM<Tj{@|N+]#sW=TZ+n');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
