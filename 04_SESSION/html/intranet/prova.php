<?php
function getName() {
    $attribute_prefix = "";

    if (array_key_exists($attribute_prefix."displayName", $_SERVER)) {
        return implode(" ", explode(";", $_SERVER[$attribute_prefix."displayName"]));
    } else if (array_key_exists($attribute_prefix."cn", $_SERVER)) {
        return implode(" ", explode(";", $_SERVER[$attribute_prefix."cn"]));
    } else if (array_key_exists($attribute_prefix."givenName", $_SERVER) && array_key_exists($attribute_prefix."sn", $_SERVER)) {
        return implode(" ", explode(";", $_SERVER[$attribute_prefix."givenName"])) . " " .
               implode(" ", explode(";", $_SERVER[$attribute_prefix."sn"]));
    }
    return "Unknown";
}

$username = $_SERVER["REMOTE_USER"];
$name = getName();
print "<h1>Ciao " . $username . "!!!</h1>";
print "<p>Il tuo nome &egrave; " . $name . ".</p>";
?>

