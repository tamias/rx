use strict;
use warnings;
package Data::Rx::CoreType::lazy;
use base 'Data::Rx::CoreType';
# ABSTRACT: the Rx //lazy type

sub subname { 'lazy' }

sub new_checker {
  my ($class, $arg, $rx) = @_;

  Carp::croak("unknown arguments to new")
    unless Data::Rx::Util->_x_subset_keys_y($arg, { schema => 1});

  my $self = $class->SUPER::new_checker({}, $rx);

  Carp::croak("no 'schema' parameter given to //lazy")
      unless exists $arg->{schema};

  $self->{schema} = $arg->{schema};

  return $self;
}

sub check {
  my ($self, $value) = @_;

  $self->{check} ||= $self->{rx}->make_schema($self->{schema});

  return $self->{check}->check($value);
}

1;
