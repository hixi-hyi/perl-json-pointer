#!perl -w
use strict;
use Test::More;
use JSON::Pointer::Syntax;

sub test_tokenize {
    my ($pointer, $expect, $desc) = @_;
    my $actual = JSON::Pointer::Syntax->tokenize($pointer);
    is_deeply($actual, $expect, $desc);
}

subtest "JSON Pointer Section examples" => sub {
    test_tokenize('', [], q{""});
    test_tokenize('/foo', ['foo'], q{"/foo"});
    test_tokenize('/foo/0', ['foo', 0], q{"/foo/0"});
    test_tokenize('/', [''], q{"/"});
    test_tokenize('/a~1b', ['a/b'], q{"/a~1b"});
    test_tokenize('/c%d', ['c%d'], q{"/c%d"});
    test_tokenize('/e^f', ['e^f'], q{"/e^f"});
    test_tokenize('/g|h', ['g|h'], q{"/g|h"});
    test_tokenize('/i\\j', ['i\\j'], q{"/i\\j"});
    test_tokenize('/k"l', ['k"l'], q{"/k\"l"});
    test_tokenize('/ ', [' '], q{"/ "});
    test_tokenize('/m~0n', ['m~n'], q{"/m~0n"});
};

done_testing;
