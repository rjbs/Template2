#============================================================= -*-perl-*-
#
# t/gd.t
#
# Test the GD plugin.  Tests are based on the GD module tests.
#
# Written by Craig Barratt <craig@arraycomm.com>
#
# This is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.
#
# $Id$
# 
#========================================================================

use strict;
use lib qw( ../lib );
use Template;
use Template::Test;
$^W = 1;

eval "use GD;";

if ( $@ ) {
    exit(0);
}

test_expect(\*DATA, { FILTERS => {
                            hex => [\&hex_filter_factory, 1],
                        }
                    });

#
# write text out in hex format.
#
sub hex_filter_factory
{
    my($context) = @_;

    return sub {
        my $text = shift;
        $text =~ s/(.)/sprintf("%02x", ord($1))/esg;
        $text =~ s/(.{70})/$1\n/g;
        return $text;
    }
}

__END__

-- test --
[% FILTER replace('.');
    #
    # This is test2 from GD-1.xx/t/GD.t
    #
    USE gd_c = GD.Constants;
    USE im = GD.Image(300,300);
    white = im.colorAllocate(255, 255, 255);
    black = im.colorAllocate(0, 0, 0);
    red = im.colorAllocate(255, 0, 0);
    blue = im.colorAllocate(0,0,255);
    yellow = im.colorAllocate(255,250,205);
    USE brush = GD.Image(10,10);
    brush.colorAllocate(255,255,255); # white
    brush.colorAllocate(0,0,0);       # black
    brush.transparent(white);        # white is transparent
    brush.filledRectangle(0,0,5,2,black); # a black rectangle
    im.setBrush(brush);
    im.arc(100,100,100,150,0,360,gd_c.gdBrushed);
    USE poly = GD::Polygon;
    poly.addPt(30,30);
    poly.addPt(100,10);
    poly.addPt(190,290);
    poly.addPt(30,290);
    im.polygon(poly,gd_c.gdBrushed);
    im.fill(132,62,blue);
    im.fill(100,70,red);
    im.fill(40,40,yellow);
    im.interlaced(1);
    im.copy(im,150,150,20,20,50,50);
    im.copyResized(im,10,200,20,20,100,100,50,50);
END; -%][% im.png | hex -%]
-- expect --
89504e470d0a1a0a0000000d494844520000012c0000012c0403000001fc54a3d00000
000f504c5445ffffff000000ff00000000fffffacd736fe39d00000be249444154789c
ed5d5196dc280c8c6fd0b8fb0031c905e6f505c679beff99d60683851020b04c3bbbcb
5756d1940b950c3268b23f7ea4c6f0882caf654626b52c6a428ecb32ebe90bdb46addf
0f64d35a3f43c7f54769dbaff08737383d316d9ab23d99b65f842d9cb1e147dbe2f962
3f03f87a0caf6f605b7f785a1eaf05dad638af0664dbc66a7bc4b6f967d6f66350afcd
f8882ca16dff59a87bd236133615026eb679e4d99436ac09db0c6df348da7e0483b2a5
86a2f2fe115916a5e267e0bc1f367d514a0e465e6cfb13e5fd605283b4bd635b0838d8
5463dac2bc1f8877c1d9e2e786396ee7816de65d50a1cde6fdba7e7c039bc97bb504b6
35ef4d1a3da0cda6dbfc9367fbe36dabba262317c885c87be5721cdbe62025ad4d8579
6f6c636c9b099bcde747c9b6e738659b039b4639be2dcfd85639d680e1451f8f3d82f1
8b1338593156d99f39c7c17969f5fe4afb0dce4b4fcf8c9f5d336c8ebfdf2ae366c1b6
a7a6e16c86ead25307ffccec53f777c03d95e3b63e95e3a6996e2ae7e6a7b03e35e336
eb032e17b791e5069e9a13eb809bb268ce6fdd39d5a0d07b0fdcf6845bb3781e5e1937
b7a1ed6e3145efb68fcd6d1e596e2a7e4d09377a17534a29e047866e506e9d73837cad
07b5a0315311066eee4fd4530f374f907aaa779bd59879aa775376eddb46c66d5e9329
1312e7b6827937e2a9bbdb06e6dd88a7ee6e1bd8e146240870230271ed18f22bb4737a
d109140c2367c96dd73cefe6368f31fd2a1b2c17b7f46ae4dde631bb063a37a54bbb8c
7260db02cd719b329bccbeb917f7accd6d64b9b95530b7b5a96389ce6c327ba1e07740
86db94d928a15b660eead88cf86e491d14d864986e19551bdc32e2076e4f1e1acf4de7
dc82bd9ee7c6d17425c7744bbed2c82de105b357674a021516181937504b65dd14cfcd
3f5591bb64e4f65addcc8247bab9a7aee5ca2351871cebdbfacc751fb22502ed667799
ed8fd62dde798f1dd02cc2df03bd5cfb4ddc1610dfb6024bbb2dd56e44f1d3ee46d548
27dce88d7a2da78e7a2a257ee0947443d51b59d318ac905caacc5bdadc84aac117cb6d
7651c9bbf9e0656bcb99e7a6d4efcc5429b76c6d39f2dcb473cb55aa0ab8e52b5586db
0cdd88a98282f6704b17b44cb711b8e5cbe3c32d551e6f33d03f63e6919b1671bb7aac
6f2ea3ee660cb350e063c786e197a5f92456b0729d9864b04e2a3b9a913ca1757acaec
e05f6d6870f1537be1aed6cf8a9689c2ef655f68af55ea570318fca83eca9477131858
f64039b6127bd7c70cac8da066dbb0ded5c4c0caa87530c975966d5801ad7d92d5c4c0
aaa8f1246b89c1b3003cc95a6260a93b3d491aab6d92160b4db151c92c56e5240dd61c
6135a5eb8e85a1b45272589320969da4149692c39a04b1cc246572c24eb2012bced57d
925258eb249bde213a604a0e6baadd24e9b5d0116bc3a227590545ef1de7b02862adf1
2297b05723564c6cbbfbdb27b9977a6c2c0c36ad05deac1eb0d4e363e132e065cb4df0
6d5d8105c15c1ddc8cb5d79846c1dd00b18a19823eb0f7dad7ff37c02a675bfcb11e8c
6f8fb5268d18962ab75570b166c65535176b7b2d84b0cc022784a524b1d87748034e2b
30aa3e01779c1705642871179e0c218fc5259623543bc902a7aa49b2b098c448ac399c
36779214d68c43c89c248135477230274960c5d2322719636de9f61bdb58938cb0d619
82f3ba53581bd41861f12689b10c1481c52186b0cc0c632cde241196a51563b1261963
691a8b412cc49a5358ac49a27e0b3b45028b3349858eac6c3d4161958905588e1681c5
9924c6f2956a3caab0fc141b0f658333473745192c7d06eb3f390681e3688f247b4e2e
81b517290258febbe774c0c01794e4f9fd392c85def09bdc0580f2c1bcdecd60683134
17ebadf91a5c09db4567526dd70a10ebf8126d39bc0fb18ed5fed9744501b08e130a73
22d7400ca68306582dc43c163838b14798f5c40016389b68bb87019ff921560331f099
0fb0daee740e2c782cf46c9aa43f3288b0eaef87c0f14384553b497ffc1060b5dd3581
a38c63b8db8eca49baa30c02ab3a60e05804623505cc1d8b84278f6d7760e088e52aac
a6e0d3586dc107473f525823c66a798b68acb6b7288b5529a4c18a0fb69bdec81d0b41
b5dd3f76c16a585a13584d4b6b17ac86bbcc1456cbbd681facfa3b567bad21735f9be2
258b557f5f9bc46ab8fbfd0bb1aaefa49358babe322f60d540e5b094d07a6f83df8295
ba7717c47acaec8f36f822f5c419ac84907258d5f7db79ac2aa844bd7a062bd5a7d086
4506bfadbea7579d365e54c05ab1a880551fc590df8f1eab25bfe812acb67f82fade76
b46a8f0ea9738003cb06cc9d6bb1b1e2cf98d77edce78fed2ab0464ccb608103403656
f469fb32b71cf03755f958f8f3dde03fe05d3a1f2b2036b9df6e6fc49a837e9325c22a
fd763d755ea87deb4a88557ca382fb547779729c2703acf2797078376bce57a7230b20
56f94d47f7bca83f20c02af6ae44ed00737089786031fa600aad050fd83b258755eea9
29607dc3fe3039ac72bf09174b4962317a7d9858b3289616c362f50d71b1387d437f37
d65cf3fbf50a2d36c7a86ff014eab3f248f46c257bb678fd211029d3d524daff558595
4f8bbbf692dd174bb2c7ed14d64b0e6bc635c6092c942692bd7767b070fa728524b088
3ebe66acf8b512c56aed09dc3a917e6353239692c3324d8111d6c77b15cd142fed7be4
094961517d8f2d582ad1432989f5e17ecc1ebd9d2c219958b27da2d558c93ed1dbf69c
7e142bd3bfca490a2e56755fad4af7c2ca62b5f6d5c658b23dba7558923dbac25892fd
be77c5d267b0fe1fd70cd64bd477b863824ff380c39d37dc88163c97b98b8a2e4c6091
fc3425eaf8ead3b4509800ad8fa99839e5fb988a8930f98b940ff04a87099726dd3951
477ce62fc6b07cea498ba064f3c95f6b6eb4de5fbc5a4e8a1679186a6203af5a6d637f
af802568c150ede1b2bd949d78d1b4c25039156d836d175e24ad889553b11b2f8a16c1
caa9d88b17416b26581d2a1a5e97bf8fc4bfdd8db21dab68f2fe6a5e312d9a1550d1f0
ea4d8b4a2ca46287f4c2b4c8c4422a76482f4c2b2161a8e2f532225ae960052a5e1eae
9856225846c53708574f5a690dc3e4ba5ac5905646c3be2a86b472c18a54bc325c01ad
6cb042152f0e17a6950956a8e2b5491fd0ca6bd8534548aba0614f1511ad6cb03aaa08
699534eca822a2956715a9d8835631b53aaea821ad8286fdf6c57a5acfceb4ca19dfaf
e80a69955845c975135ab874be0bade9b6b4d40d694115ef446bea4c8bb1c823152f5c
e6ab690115bbd0628a181e295dc4aa8d96ba21ade060f046b4a6dbd25237a4a5bbd32a
16368ed6b35f61c32903a18a37aa4ea18afd68f193ebd9ed13839ff356c58edf89152a
76fb7cad4aae67b78f7d7e72edb7b17d68d5a9d8ed20a94ec5aea781352af6a255a9e2
75ac6a0ec031ad7e07e0ec704d7d6971937eea2a62cde74fc794e7aa38f5a6c50b97ea
ba9ceee12af2da7caeed35635fa123099773ffc86a3dad44c341c8ea855be07659d9ff
9c4335ad627ab9a77b15879d130491a755482f4fc0aa38a0305d472bcbeb088b557150
645fda15b432bca0588e16d5007609ada8ad0c647bf06b099d69e126bc2354e12fd024
c37d11adb065f10815daa992c97915ada0c1d3918a7ebf31f92a5f472b6e878d239a5c
f8aea4153023ff36b94d5c4c2b3f485a46fa8fd29a9325c847692dc982ed6eb4f6b7f7
66b45cf9713f5ae30d69a95bd2f225e4bd68f9edea56b48e7afb6eb4c61bd252b7a405
be996e466b94a1158e5281450d81eaaa86133b62171e46b4840984eb125a27285da5e2
9930b921aee2794a7bb82ea3d5ca69b940c5f394cc9056518695b88a72b4445514a225
fd1bce82b42455aca195731356b18256e9ff16fb195a05375915d9b44a6eb22a726995
dd3e418be126aa228f16678b1255518e96a88a2c5a3b2b5df412539119060e2d491579
b96c59156849aac8a7a539b4a4542cd3526c5a824557911660c5a025a522979666d012
54b1440bb22ad29253519a96908a055a01ab222d3915656989a998a715b262d1925151
9696988a1c5a9a4f4b4ac52c2dd5424b4445615a522ae66861561c5a422a5e404b42c5
0cad8815879650d175052d0115d3b462562c5a322a8ad39251b1440bb272ed93c5715e
c5bf8d16a1a1ecedd2bf9096be192d2a58ffd3cad3d25d69fd03c2c0450139dbe88200
00000049454e44ae426082
-- test --
[% FILTER replace('.');
    #
    # This is test3 from GD-1.xx/t/GD.t
    #
    USE im = GD.Image(100,50);
    black = im.colorAllocate(0, 0, 0);
    white = im.colorAllocate(255, 255, 255);
    red   = im.colorAllocate(255, 0, 0);
    blue  = im.colorAllocate(0,0,255);
    im.arc(50, 25, 98, 48, 0, 360, white);
    im.fill(50, 21, red);
END; -%][% im.png | hex -%]
-- expect --
89504e470d0a1a0a0000000d4948445200000064000000320203000000d75b962d0000
000c504c5445000000ffffffff00000000ff011d334a000000bc49444154789cad94c1
0d83300c451309ba01cc93117a203d3002d3f4403680037fca8a448526f1b710ea3fe6
c9f9b163db984b6ae4e3ce4755e7d64f88f2cf82787c151c0105eaf0ab708276ca0886
83bc7280d5919033a80c39826c1502a4a4fa1a608d6414c8e6c865e9ba560298894d32
926c9291680338636580b742e4a7ed8f7b10b2dc2272a27baafff5e1f9dca90eafb5f2
3ffc4f791ff0dee1fda6f428ef6b3e0bcafcf09953e694cfb6b20f941da2ec1dbeaba2
b2fdf60111b64d2854ccf25e0000000049454e44ae426082
-- test --
[% FILTER replace('.');
    #
    # This is test4 from GD-1.xx/t/GD.t
    #
    USE im = GD.Image(225,180);
    black   = im.colorAllocate(0, 0, 0);
    white   = im.colorAllocate(255, 255, 255);
    red     = im.colorAllocate(255, 0, 0);
    blue    = im.colorAllocate(0,0,255);
    yellow  = im.colorAllocate(255,250,205);
    USE poly = GD.Polygon;
    poly.addPt(0,50);
    poly.addPt(25,25);
    poly.addPt(50,50);
    im.filledPolygon(poly,blue);
    poly.offset(100,100);
    im.filledPolygon(poly,red);
    poly.map(50,50,100,100,10,10,110,60);
    im.filledPolygon(poly,yellow);
    b = poly.bounds; b0 = b.0; b1 = b.1; b2 = b.2; b3 = b.3;
    poly.map(b0,b1,b2,b3,50,20,80,160);
    im.filledPolygon(poly,white);
END; -%][% im.png | hex -%]
-- expect --
89504e470d0a1a0a0000000d49484452000000e1000000b4040300000090de560d0000
000f504c5445000000ffffffff00000000fffffacda03f5b3b0000022349444154789c
eddad96d84500c85e1591a081d4454108906f2e0fe6bca2c2c77b70df615d19cd3c0a7
ff010b242e170cc3300cc3b00fdd15224476f7eee2f4d359bc4f5367719a0a919ee223
b110e9293ec13c72f872035f8979a4a3f806b3483f714ecc22fdc4054c23ddc435318d
7413373089f41283c424d24b0cc138d2498c12a3c8eb30b8883118463a89496218e924
a66010e923668941a48f98835ba48b5848dc225dc412b8467a88c5c435d2432c834be4
30981f9d4ae212e920d6c039d24164061122c4ca1e47cee9b503224488e7179f60dfa3
031122c4d388af93d3f5e8408408f15f8bbfc7c437a8397344c748b5487490d48a4447
49a5487498d48944c749954864406a44220b52211299907231057792f3c9111c9d1cdc
478ac512b88b948a65700f29146be00e5226d6413d29125ba09a94886d504b0a440e54
92bcc8833a7201ab474702aa484e94811a9211a5a0826c8b72504e36450d28265ba20e
94920d510b0a49f6e930df0788eb91ebf675051122c4f3881bd8ebe89c52bc7517c7ef
cee26d1c3b8be3681bc98a8f44db48567c82a6919cf84ab48c0c4e4ef9e8bc41c3484e
9c130d23397101ed2219714db48b64c40d348b6c8b41a259645b0c41abc8a618255a45
36c518348a6c8949a2516408a6672e056d221b62966813d91073d024b22e16124d22eb
6209b488ac8ac5448bc8aa58060d226b6225d120b226d6c0c391d1c9e9f2ad031122c4
f38831d8fbaf720cc3300cc3b0a3fb03d69b699bd4e71fcb0000000049454e44ae4260
82
-- test --
[% FILTER replace('.');
    #
    # This is test5 from GD-1.xx/t/GD.t
    #
    USE gd_c = GD.Constants;
    USE im = GD.Image(300,300);
    white   = im.colorAllocate(255, 255, 255);
    black   = im.colorAllocate(0, 0, 0);
    red     = im.colorAllocate(255, 0, 0);
    blue    = im.colorAllocate(0,0,255);
    yellow  = im.colorAllocate(255,250,205);
    im.transparent(white);
    im.interlaced(1);
    USE brush = GD.Image(10,10);
    brush.colorAllocate(255,255,255);
    brush.colorAllocate(0,0,0);
    brush.transparent(white);
    brush.filledRectangle(0,0,5,2,black);
    im.string(gd_c.gdLargeFont,150,10,"Hello world!",red);
    im.string(gd_c.gdSmallFont,150,28,"Goodbye cruel world!",blue);
    im.stringUp(gd_c.gdTinyFont,280,250,"I'm climbing the wall!",black);
    im.charUp(gd_c.gdMediumBoldFont,280,280,"Q",black);
    im.setBrush(brush);
    im.arc(100,100,100,150,0,360,gd_c.gdBrushed);
    USE poly = GD.Polygon;
    poly.addPt(30,30);
    poly.addPt(100,10);
    poly.addPt(190,290);
    poly.addPt(30,290);
    im.polygon(poly,gd_c.gdBrushed);
    im.fill(132,62,blue);
    im.fill(100,70,red);
    im.fill(40,40,yellow);
END; -%][% im.png | hex -%]
-- expect --
89504e470d0a1a0a0000000d494844520000012c0000012c0403000001fc54a3d00000
000f504c5445ffffff000000ff00000000fffffacd736fe39d0000000174524e530040
e6d86600000c2a49444154789ced5d0b76eb261035f60682ed0558ea0694a30d3cf578
ff6b2a0221f119600646c46d4393d79837beba3377f813bfcb2555c45754f37c2fea7f
afebfa658a7cbfe51018bedfcb387c9b9fa7bdee3e8ef35760378ee3e3dbaf5b12757f
f96f5ee1c601593742750f64dd5f409defb1e607d7c5fe86761af019d4a9370fefa04e
c5d984dfad5b0bb6ce03a4d62d0d752e20b9ee0f50b7a4eba29ca51709e5bdaabbae5f
d7bde62d656065f3fee6d5dd4d4a4e4edd12a5a978ff1de5bdd0a901d6cd719d0f284c
aa21ebfcbc17405bb075f173fd1c377e8475ba2d48bfcee47d50e7e5bd30752aeffd94
147166ec754bf0de54dd1baafb8af1c0ba3f40dd92ae13a53ae721f4ba65c73ba948e9
f7264011f2b952d91ace557f5faf17db5836234357c9fe885b5860b65a8d72fe5676b7
69be4daa494dd36d0ecc16937f0f6d974693a3c9f17996193303b63e350d6732742c3d
55eccfcc3e756b03f6a91833f5548cd988349339b3dd05f5d48cd9321e70b9b8dd5166
ce5373621d7003d05b1f66d64e8d9c1917f6847bbe93a9be373869ecc3a78ac0cc5ae3
cc124f8dcce0c88566095f2333f8a9b119f8d4c80c7e6a6ce63f351190c45363b337d2
0c220798414f05ccfcf1e82b6996cce19f2922d7f11e46e9c67214291df75e664df05a
7f888cfc285c2f61b183c71d68ca2e9681ba677aa3dd6cb9db3e500f1db6dc6e936726
473bcae84166ba5dd40833df6eb36766ba10d5411b76b74b5c0eb32133c86833591c3d
b4d91d65667bc1dcd0268f2e3a33c8e875dc61f68d301b3203a56b96f1411e8311de6c
4e9b1d830cd24cb29a65c4f7cc1e38349cd99833f3c67a9c194653450e69966cd28159
c2cacdde31332590fe042363e6cca5b2661267b63f55c6238704cc9eb19938ccec5387
2738aced661b9c4c0f307b6fa9ad6233f7a1da4e77c2a9c98fb4e3d9131e244560961e
4b01b3c855099b853e7ce1cc120f4d4ccc42b3444422b3c087141ace2c8c48ca0c76b5
d60c763536f3c9a5b821cde03c8fcd7c1f92684833d055c0cc239748cb449ec766a0ab
80192457bd19e42a6406902b996df35ec0cc9f1e27d13e6d7a7c56111233ef4614a94a
b4ed5851142133e95e7cac17600bd5f98476353d27ed62e0a5a6fcc7cf25421ac71417
6bbc98ffd632eaef3181251c42ca3da947f0efba9809074a6e1377a99615356a3a5872
9f68ab59eab701bb5dd61588fe5a9729eb6a64323fac2589259d69cabc83a985ccb42e
6214c4faad20d7058d82b9ad3f27b0a43b1d53c4667acc2cd6228fb998765281514366
b11c5a9b93cacb3a2c8fd6e62499d886e5d1b24e528959acbb87659ca41233588b4fab
d24918abce498315b858a964168be8a4c65a22acaa74ddb042a8514a3eac8111cb38c9
8525f9b006462ced244f4e18272bb0e25cdd9ce4c2524e56b5213860920f6ba00e9270
5f6889d561c14e92a0e0b1a30d0b22561b2fb00b7b5662c5c4d6b3bf9a9c00c00635c1
5b10c49c934c68ce64a1c2e9269e970706cf83f1bcec1c532b682b28c43cac7dee7bbc
6ec00a4bd9c9948f10168158018be464098b92ae3db1284e96b1f0c48a582527f13941
721281952526a4fb73090baf6419abe0248957c9491216da490456de49f7520c060b49
0c83957592c80b9baeddb1904a22b150c45058482771583827b1581862382c9c93482c
949368acf45930150be5a490d88270f2b7fc278b60135f671be73e3907d6361967c0da
b7b8bd80e9eb30febd99d7a5b0e9ee6c962f01d6a8b1b67df2ab7995c372d71a01d655
f332fcccab6b8e97b76a593c21135808f7e2b380abf6ebaacf02ae57f5f365f3b288b4
42adebbdca7c75dd5350fa60bd365f1d5276f938c8ba630517eb5889d66cdefb587689
bc6e207fd7103bb08e1d0abd23e710db0f368ebbf137ef558475acdc9db313f7bd785e
cec689d9c2d4c4ccd18ba270335f177df978d2f7c27258cedec41c128bfcc9f2920156
859447ef7077b0eace740e2c775be8113949c1921116fd7c68c7bac7585427372c7f2b
4dd69d35ed58feded75c13b00d4b0258e48059acbb8f551530bb67e6ef3cd69d8159ac
f13cacaae0c35875c1b7e33e23d63dc4aa694530565d2bca6211853477d162ac9a16b9
61055075e78f5db02abad6045655d7da05abe22c338555732eda078b7ec66a8e3578ce
6b53bc78b1e8e7b549ac8ab3df7f2116f94c3a8935d267e6052c0a540e4b32f5f726f8
3558a9737746ac07cff86882cf329f68c14a08c987453edfce6391a012f3d516acd43d
853a2c30f875f37bb8d7a9e30505ac160b0a18792b065c3fee5835f9054fc1a8f727a0
f5b6a585d93a744da07d8003aba6cf0197314feabd0e68dfc4d2c260b95180f6732c2d
e2f509709fc9d2c2ecdb0a28f63eb1c1fbed76a493c0bedc418bb89f0cec178efbd515
6252b858db3ee601454c0a0fcbecaf0ec73e690b56780f86961401d6fa760fbb09cb2f
45ac447e8158948015b08ac1773f30a2150becbf5258a580e1b18ac127f0222545118b
2064098bd28a5ab108b95a14d2bd9f53c2a204bf158b90f7452129f1a208d98a45f291
d0b516b10ac127f12a5db3a2c41e7fcd0a81950f3e2796e76f23162d5ef8a42863e15b
772b163cc74c6361838fc0ca069f96130521493ae2854460a1856cc6a2f99817928895
0b3ea9bf2f60b90587950e98246261856cc5a2f5396f748b44612183ff0358a8e0a3b0
9042fe00162a60382c5cf07f020b13301c162ef8ff76ac54f0dd3b8448aca490c4b136
8be57660682c44c09058a8e0a3afe8f2dcacfc2dbfe5ff5a3eb011d91bfa3fcdc32d1b
a5e707d1b261d29dea87a868c3b40f1cc970edf7aec7ed1b2aa6fe057cbe22beb861da
c7a032adeb05fa58c7dda88d561026875642c5eb389a9bea1b2d4b73fbd0fad7f565fe
ee7ab956d282c25454513f5a514bd2ba38f5745a8930ed0729295eeea33d5aaaf8b4c8
d14a87299c9a90bdad2e2215a68dd4f6b19bbd8909389b4c3eedc79a2badf9bbe35c4e
c09132a1f2cedef5c5fe5e014bd07243b585cbdca50c78391f233ea5aee6dfa6f8e554
b8c80fd3f243655534176c3d5e9366b67e4dd334af4f3344d59fc7cbc9584ea652ff9a
4215ad88955531e235e927b85ff36ca261bef44b436b3206265235b4005656c590d741
68fde58c497f5cd65e6f485f005ab73c2990d602b03a54d4bc92ed11f52b298812d35a
826c0f55d4797f763f11d38259392a6a5ebd69418915a81836c70eb4c0c40a54cca7d7
29b41212fa2a9e2f63402b1d2c4fc5d3c315d34a044bab383be1ea492bada19f5c67ab
e8d3ca68d857459f562e58918a6786cba3950d96afe2c9e10a696582e5ab786ed28be0
977b73b43aaae8d22a68d853c5805636581d5514feef7ae769f55331a0956715a9d883
5631b53af6a83ead8286fdc6453aad47675ae58cef37e9f269955845c9f521b4c2a9f3
a7d01a3e9696fc405aae8a9f446be84c0bd1c9072a9ed8cd9369392a76a18514d1df52
3a89551d2df981b4bc8dc10fa2357c2c2df981b4c6eeb48a131b4bebd16f62839906ba
2a7ed0ecd455b11f2d7c723dba2d31f0396f54ecb84e24a8d86df94a4aae47b7c53e3e
b9b6d3d83eb4682a76db48a2a9d8753790a2622f5a4415cf6345d9000f69f5db004787
6be84b0b9bf443571129cb9f8e298f5571e0a325bf2018fc316714ac6edde916ae22af
d586efc620265a18195709c30f59ad2d024b2b71e1c067f5cc5e6464608bbc9ee14bf8
dcc2da1e2e0183602fb30489b5d1ef326946f1da5931a908ff7be3c88b52002b2e1591
29bff3823f3828f981c7b5b4c08827688597f08e50f9fffe21838a0411dfc195c52354
e148d5cc8a162d1bb0bb474a461627b5c50cadf83a2c14d11fa0e5314bfcedcfd0ca17
0615056a62432b1c2a52531e19ae665afcd1625051c0b56db4ce6a8b8db4da55248d89
145a6d2a9e22e2592ab6d23aa947e5a075c2b8d84cab75d22504945d1cb4da54049d6a
a6d5ace219bdfcbb5dc593a2754a17d14eab4d4541599051c3c5de45f0d06a51f18cf9
962e6d2a9e32546fe16a50f1acdc6a54f134119b543cad25b6aa7826ad6a15cf4bf913
265d6cb42a55246c52d20bfbb8c843ab41c53373ab45c5336971abc8448bbb2d32d2e2
9cdd70d1aa56f19c55f55e3e9716a38a6cb42a5514b02f6cb478db222bad0a15d1c79c
b5a56ed2d583169f8a7cb458db22232dce652c2f2d3615196971aac8498b5145665a5c
2a72d262549195169f8adcb4985464a5c5a7222f2d3615d9699155546f8967a8bcb42a
265d029c0af2d322aa28c0b730d3e26a8bccb4b8a6ce22bc19d25e38dae287d2fa2dbf
e5b7fc50f9073f07e3945648a9fe0000000049454e44ae426082