package Text::CSV::Easy_XS;
use 5.010;
use strict;
use warnings FATAL => 'all';

our $VERSION = '0.01';

require Exporter;

our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(csv_build csv_parse);

require XSLoader;
XSLoader::load( 'Text::CSV::Easy_XS', $VERSION );

# Preloaded methods go here.

1;

__END__

=head1 NAME

Text::CSV::Easy_XS - Easy CSV parsing and building

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

  use Text::CSV::Easy_XS qw(csv_build csv_parse);

  my @fields = csv_parse($string);
  my $string = csv_build(@fields);

=head1 DESCRIPTION

Text::CSV::Easy_XS is a simple module for parsing and building simple CSV fields.

Integers do not need to be quoted, but strings must be quoted:

    1,"two","three"     OK
    "1","two","three"   OK
    1,two,three         NOT OK

If you need to use a literal quote ("), escape it with another quote:

    "one","some ""quoted"" string"

=head1 SUBROUTINES

=head2 csv_build( List @fields ) : Str

Takes a list of fields and will generate a csv string. This subroutine will raise an exception if any errors occur.

=head2 csv_parse( Str $string ) : List[Str]

Parses a CSV string. Returns a list of fields it found. This subroutine will raise an exception if a string could not be properly parsed.

=head1 DISCLAIMER

Note: this module is still in an *alpha* state. This has not been tested with threads. Use at your own risk.

=head1 SEE ALSO

=over 4

=item L<Text::CSV>

=back

=head1 AUTHOR

Thomas Peters, E<lt>weters@me.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Thomas Peters

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.4 or,
at your option, any later version of Perl 5 you may have available.

=cut
