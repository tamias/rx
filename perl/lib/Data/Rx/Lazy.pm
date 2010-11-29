use strict;
use warnings;
package Data::Rx::Lazy;
# ABSTRACT: class for handling lazily-evaluated schemas

sub new_checker {
  my ($class, $arg, $rx) = @_;

  Carp::croak("no schema given")
    unless $arg->{schema} and (ref $arg->{schema} || 'HASH' eq 'HASH');

  Carp::croak("unknown arguments to new")
    unless Data::Rx::Util->_x_subset_keys_y($arg, {schema => 1});

  bless {rx => $rx, schema => $arg->{schema}}, $class;
}

sub check {
  my ($self, $value) = @_;

  $self->{check} ||= $self->{rx}->make_schema($self->{schema});

  return $self->{check}->check($value);
}

1;

