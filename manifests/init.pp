# Define: ssh_keygen
# Parameters:
# $home
# $comment
#
define ssh_keygen(
  $home=undef,
  $keyname=undef,
  $keytype=undef,
  $comment=undef) {

  Exec { path => '/bin:/usr/bin' }

  $home_real = $home ? {
    undef => "/home/${name}",
    default => $home,
  }

  $comment_real = $comment ? {
    undef => "puppet generated key for ${name}@${::fqdn}",
    default => $comment,
  }

  $keytype_real = $keytype ? {
    undef => "rsa",
    default => $keytype,
  }

  $keyname_real = $keyname ? {
    undef => "id_rsa",
    default => $keyname,
  }

  exec { "ssh_keygen-${name}":
    command => "ssh-keygen -f \"${home_real}/.ssh/${keyname_real}\" -t \"${keytype_real}\" -N '' -C '${comment_real}'",
    user    => $name,
    creates => "${home_real}/.ssh/${keyname_real}",
  }

}
