use strict;
use warnings;
package Data::Rx::ComposedType;
# ABSTRACT: class for composed Rx types, i.e. types composed of other types

sub new {
  my ($class, $arg) = @_;

  Carp::croak("no uri given")
    unless $arg->{uri};
  Carp::croak("no schema given")
    unless $arg->{schema} and (ref $arg->{schema} || 'HASH' eq 'HASH');

  Carp::croak("unknown arguments to new")
    unless Data::Rx::Util->_x_subset_keys_y($arg, {uri=>1, schema=>1});

  bless {uri => $arg->{uri}, schema => $arg->{schema}}, $class;
}

sub new_checker {
  my ($self, $arg, $rx) = @_;
  Carp::croak "ComposedType does not take check arguments" if %$arg;
  return $rx->make_schema($self->{schema});
}

1;
