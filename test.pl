#!/usr/bin/perl -w
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

# $Id: test.pl,v 1.32 2004/08/25 20:15:26 jrennie Exp $

my $i = 1;
BEGIN { 
    $| = 1;
    print "v1.6: 1..36\nv1.7: 1..38\nv1.7.1: 1..37\nv2.0: 1..50\n";
}
END { print "not ok 1\n" unless $loaded; }
use WordNet::QueryData;
$loaded = 1;
print "ok ", $i++, "\n";

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

print "Loading index files.  This may take a while...\n";
# Uses $WNHOME environment variable
my $wn = WordNet::QueryData->new;
#my $wn = WordNet::QueryData->new("/scratch/jrennie/WordNet-2.0");

my $ver = $wn->version();
print "Found WordNet database version $ver\n";

($wn->querySense("sunset#n#1", "hype"))[0] eq "hour#n#2"
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";

scalar $wn->forms ("other sexes#1") == 3
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
scalar $wn->forms ("fussing#2") == 3
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
scalar $wn->forms ("fastest#3") == 3
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";

scalar $wn->querySense ("rabbit") == 2
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
scalar $wn->querySense ("rabbit#n") == 3
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
scalar $wn->querySense ("rabbit#n#1", "hypo") == 6
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";

# check that underscore is added, syntactic marker is removed
($wn->querySense("infra dig"))[0] eq "infra_dig#a"
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
($wn->querySense("infra dig#a"))[0] eq "infra_dig#a#1"
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
($wn->querySense("infra dig#a#1", "syns"))[0] eq "infra_dig#a#1"
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
($wn->queryWord("descending"))[0] eq "descending#a"
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";

($wn->querySense ("lay down#v#1", "syns"))[0] eq "lay_down#v#1"
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
scalar $wn->validForms ("lay down#v") == 2
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
scalar $wn->validForms ("checked#v") == 1
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";

my ($foo) = $wn->querySense ("cat#n#1", "glos");
($foo eq "feline mammal usually having thick soft fur and being unable to roar; domestic cats; wildcats  ") ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";

scalar $wn->querySense ("child#n#1", "syns") == 12
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";

(([$wn->validForms ("lay down#2")]->[1]) eq "lie_down#2"
    and ([$wn->validForms ("ghostliest#3")]->[0]) eq "ghostly#3"
    and ([$wn->validForms ("farther#4")]->[1]) eq "far#4")
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";

($wn->querySense("authority#n#4", "attr"))[0] eq "certain#a#2"
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";

($wn->validForms("running"))[1] eq "run#v"
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
# test capitalization
($wn->querySense("armageddon#n#1", "syns"))[0] eq "Armageddon#n#1"
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
($wn->querySense("World_War_II#n#1", "mero"))[1] eq "Battle_of_Britain#n#1"
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
# test tagSenseCnt function
($wn->tagSenseCnt("academy#n") == 2)
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";

# test "ies" -> "y" rule of detachment
($wn->validForms("activities#n"))[0] eq "activity#n"
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
# test "men" -> "man" rule of detachment
($wn->validForms("women#n"))[0] eq "woman#n"
    ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";

($wn->queryWord("dog"))[0] eq "dog#n"
? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
($wn->queryWord("dog#v"))[0] eq "dog#v#1"
? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
($wn->queryWord("dog#n"))[0] eq "dog#n#1"
? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
($wn->queryWord("tall#a#1", "ants"))[0] eq "short#a#3"
? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
($wn->queryWord("congruity#n#1", "ants"))[0] eq "incongruity#n#1"
? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";

if ($ver eq "1.6") {
    scalar $wn->querySense ("cat#noun#7", "syns") == 5
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->queryWord("confuse#v", "ants"))[0] eq "clarify#v"
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    $wn->offset ("child#n#1") == 7153837
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->querySense ("car#n#1", "mero") == 29
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->listAllWords("noun") == 94474
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->querySense ("run#verb") == 42
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
} elsif ($ver eq "1.7") {
    scalar $wn->querySense ("cat#noun#7", "syns") == 5
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->queryWord("confuse#v", "ants"))[0] eq "clarify#v"
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->listAllWords("noun") == 107930
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    $wn->offset("child#n#1") == 7964378
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->querySense("car#n#1", "mero") == 28
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->querySense("run#verb") == 41
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->offset("0#n#1") == 11356314
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->forms("axes#1") == 3
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
} elsif ($ver eq "1.7.1") {
    scalar $wn->querySense ("cat#noun#7", "syns") == 6
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->listAllWords("noun") == 109195
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    $wn->offset("child#n#1") == 8144030
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->querySense("car#n#1", "mero") == 29
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->querySense("run#verb") == 41
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->offset("0#n#1") == 11596022
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->forms("axes#1") == 3
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
} elsif ($ver eq "2.0") {
    scalar $wn->querySense("cat#noun#8", "syns") == 6
        ? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->listAllWords("noun") == 114648
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    $wn->offset("child#n#1") == 9284669
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->querySense("car#n#1", "mero") == 29
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->querySense("run#verb") == 41
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->offset("0#n#1") ==  12967124
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    scalar $wn->forms("axes#1") == 3
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->queryWord('person#n#1', 'deri'))[0] eq 'personify#v#3'
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->queryWord('shower#v#3', 'deri'))[0] eq 'shower#n#1'
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->queryWord('concentrate#v#8', 'deri'))[0] eq 'concentration#n#4'
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->querySense('curling#n#1', 'domn'))[0] eq 'Scotland#n#1'
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->querySense('sumo#n#1', 'dmnr'))[0] eq "Japan#n#2"
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->querySense('acropetal#a#1', 'dmnc'))[0] eq 'botany#n#1'
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->querySense('bloody#r#1', 'dmnu'))[0] eq 'intensifier#n#1'
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->querySense('matrix_algebra#n#1', 'domt'))[0] eq "diagonalization#n#1"
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->querySense('idiom#n#2', 'dmtu'))[0] eq 'euphonious#a#2'
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->querySense('manchuria#n#1', 'dmtr'))[0] eq 'Chino-Japanese_War#n#1'
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    ($wn->validForms('involucra'))[0] eq 'involucre#n'
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    $wn->lexname('manchuria#n#1') eq 'noun.location'
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
    $wn->lexname('idiom#n#2') eq 'noun.communication'
	? print "ok ", $i++, "\n" : print "not ok ", $i++, "\n";
}
