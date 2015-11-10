<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
        <head>
                <title>Lazy session example page</title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        </head>
        <body>
                <h1>Welcome to the lazy session example page!</h1>

                <?php
                $username = $_SERVER["AJP_cn"];
                if (!isset($username) || empty($username)) {
                        ?>
                        <p>You have not accessed with a Shibboleth credential.<br/>
                        This is a public content available to everybody!</p>
                        <p>To login click <a href="/Shibboleth.sso/Login?target=/lazy.php">here</a>.</p>
                        <?php
                }
                else {
                        ?>
                        <p>You have accessed with a Shibboleth credential!<br/>
                        This is a private content available only to logged users!</p>
                        <p>You authenticated as: <b><?php echo $username ?></b>.</p>
                        <?php
                }
                ?>
        </body>
</html>

