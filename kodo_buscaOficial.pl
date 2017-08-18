#!/usr/bin/perl
#coder: kodo no kami (fb/hacker.fts315)
#forum: https://eofclub.in/forum
#face: https://www.facebook.com/forum.eof
#discord: https://discordapp.com/invite/cmzeMPv (kodo#0010)
#consulta: http://www.buscaoficial.com
#data: 17/08/17

use WWW::Mechanize;

my ($kodo,$busca,$pagina,$arg_qnt,$url);
$kodo = new WWW::Mechanize;

$arg_qnt = @ARGV;
$url = "http://www.buscaoficial.com";

print 	"==========================\n" .
		"     kodo buscaOficial\n" .
		"==========================\n\n";

if(($ARGV[0] eq "-h") || ($ARGV[0] eq "--help")){
	ajuda();
	exit(0);
}
elsif($arg_qnt == 1){
	$busca = $ARGV[0];
	$pagina = 1;
}
elsif($arg_qnt == 3){
	if($ARGV[0] eq "-p"){
		$pagina = $ARGV[1];
		$busca = $ARGV[2];
	}
	else{
		$pagina = $ARGV[2];
		$busca = $ARGV[1];		
	}
}
else{
	ajuda();
	exit(0);
}

$kodo->get($url . "/buscar/?keyword=$busca&page=$pagina");
my @kami = $kodo->content =~ /div class="info"(.*?)<\/div>/gsm;

my $pri = 0;
foreach my $k(@kami){
	if($pri == 0){
		$pri =1;
		next;
		
	}
	my @ktitulo = $k =~ /title="(.*?)"/sm;
	my @kurl = $k =~ /href="(.*?)"/sm;
	my @kinfo = $k =~ /class="number">(.*?)<\/span>/sm;
	my @kdesc = $k =~ /description">(.*?)<\/p>/sm;
	
	print "[+] " . $ktitulo[0] . " [+]\n\n" . 
		$url . $kurl[0] . "\n\n" .
		$kinfo[0] . "\n\n" . 
		$kdesc[0] . "\n\n" .
		"--------------------\n\n";
}

sub ajuda{
	print "coder: kodo no kami (fb/hacker.fts315)\n" .
	"forum: https://eofclub.in/forum\n" .
	"face: face: https://www.facebook.com/forum.eof \n" .
	"discord: discord: https://discordapp.com/invite/cmzeMPv (kodo#0010)\n" .
	"data: data: 17/08/17\n\n" .
	"sintaxe:\n   perl script.pl [CPF/CNPJ/DOCUMENTO]\n   perl script.pl [CPF/CNPJ/DOCUMENTO] -p [PAGINA]\n\n";
}
