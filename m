Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBACB45CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 05:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfIQDCJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 23:02:09 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:55551 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbfIQDCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 23:02:09 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190917030203epoutp0307896bb1f27a904d889ff79559117515~FGqDvZKO52559925599epoutp03D
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 03:02:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190917030203epoutp0307896bb1f27a904d889ff79559117515~FGqDvZKO52559925599epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568689323;
        bh=4syauy6QTpnQ79U2ecTkaTKcPSC4TnvQzdXAq6U5/Ok=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=REE802birG5zIJVNSkR8NdxtXylUVSFN7+dZTMFZfZp8wD/rz+PoHjjZr5K2Jcsh0
         hm/y4Q4JuE0xk7KGy0OHNpi7zlQi2GmfqqU8iuFK3LEXHb3CG0mvJZM6YG+IYJSoev
         8LS354iAgmtWX8PBpru6KmlEc0BcvVW4mSISxQu4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190917030203epcas1p43c375aced62c5ec9fcc59ac27a58c5b8~FGqDLgphO0810108101epcas1p47;
        Tue, 17 Sep 2019 03:02:03 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46XSZL0d28zMqYkb; Tue, 17 Sep
        2019 03:02:02 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.46.04088.AAC408D5; Tue, 17 Sep 2019 12:02:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190917030201epcas1p1cd99c1de475ca6a5c37a04dbe548587e~FGqB_D-Jo2793627936epcas1p1F;
        Tue, 17 Sep 2019 03:02:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190917030201epsmtrp18036eb30e20ee55679911221889d424f~FGqB9RDvn2191821918epsmtrp1c;
        Tue, 17 Sep 2019 03:02:01 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-27-5d804caaf514
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.8B.03638.9AC408D5; Tue, 17 Sep 2019 12:02:01 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190917030201epsmtip199b38ab9596cda056307430ec4342135~FGqBy07Vp0296102961epsmtip1O;
        Tue, 17 Sep 2019 03:02:01 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <alexander.levin@microsoft.com>, <devel@driverdev.osuosl.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Valdis Kletnieks'" <valdis.kletnieks@vt.edu>,
        <sergey.senozhatsky@gmail.com>,
        "Namjae Jeon" <linkinjeon@gmail.com>, <namjae.jeon@samsung.com>
In-Reply-To: <003601d56d03$aa04fa00$fe0eee00$@samsung.com>
Subject: RE: [PATCH] staging: exfat: add exfat filesystem code to
Date:   Tue, 17 Sep 2019 12:02:01 +0900
Message-ID: <003701d56d04$470def50$d529cdf0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQEojCBVDO0x2GFDb0pWuteI5NJ8IwIob7haqHero4A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0hTcRjG+e8cd86iyWlavSjVPFFQZm3O6dGyjCxGLRj0LbJ10INKu3HO
        lCxEoZqmYXfMZWQXQk3RTG3aZXmBNCyqlWFpCRlU2lUsyW5nOxP27fe+PA/v+/wvJKa6KY8i
        c21OjrexFlo+B2/vWaGJqzcWZ2impmTM3cp3GHN74BfBHLzcJGdejLwUyzv9OOPrrJYz05VF
        TOPkW4J5+uUrnqYwvL7bgxs63COEwXu+gTAc9vwhDBWt9cgw2bLY0H1zQm4idlrW5XBsFser
        OVumPSvXlp1Kb9th3mTWJ2q0cdpkJolW21grl0qnG01xW3It4ma0Op+15IktEysI9Jr163h7
        npNT59gFZyrNObIsDq3GsVpgrUKeLXt1pt2aotVo4vWico8lZ6x3CHOUp+1rGB6SFaO3qWVI
        QQKVAF2nqvAyNIdUUR4ET87WY1LxHUGnGFcqfojF0RFi1jL8pQ/5WUXdQVD5OboMkSJ/RFC3
        w9+WU3Hw97dX7udIahWUDvQFJmBUlQwGzzwIeBVUCjwbvR7gCGojTPvuyfyMU8ugru10mJ+V
        VDLc8pTjEs+D/qqxAGNUPFy5dkEmcSxcvTiOSbupwfNwHEmDU+D549GgJhLOHXEFNeUEnKoM
        xk+H4dsngrki4OP91iBHwYdjLsKfC6gD8M0btJYieP8zaNXBUFNzmMQx0DFzHkmjwuHz1NEw
        yaqEUpdKkiyDiqc9MomjoazkK3Ec0e6QYO6QYO6QYO6QADUIr0cLOIdgzeYErUMbetctKPBo
        V+o96PQjYzeiSETPVWraizJUYWy+UGDtRkBidKTSVCi2lFlswX6Ot5v5PAsndCO9ePAnsKj5
        mXbxC9icZq0+XqfTMQmJSYl6Hb1QeXGayVBR2ayT28txDo6f9clIRVQxOnOpxB3uNEUvj0F1
        JR/6fAk3Ji7EOvmErTPsrur+XZ/evCKbfJfoWq9rpmG0uXrJYIyvZhI/9L7lXFut1TXMqCYX
        te62FSl3F27X/T3ZUehNEd7QJv1SxaaHaYsGjeGvC/41psdvK7mycGIc2O3XnvQaa2s2dOn5
        THWXefPaRhoXcljtSowX2P8upJ2FygMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnO5Kn4ZYg66rOhb7pj9ltthz5he7
        RfPi9WwW1+/eAnL3nmSxuLxrDpvFj+n1Fms/P2a3uPT+A4sDp8e9fYdZPHbOusvusX/uGnaP
        1h1/2T36tqxi9Pi8Sc7j0PY3bAHsUVw2Kak5mWWpRfp2CVwZy05tZC/Yolsxu6GDqYFxvkoX
        IyeHhICJxJ33Jxi7GLk4hAR2M0rMfvCFCSIhLXHsxBnmLkYOIFtY4vDhYoiaF4wS2968Zgep
        YRPQlfj3Zz8biC0ioCPRceYEC0gRs8BCJonXK74zgiSEBLoZJdrnhIDYnAJWElcebASLCws4
        Svy4fABsGYuAqsTKrVNYQWxeAUuJ3Tu6WSBsQYmTM5+A2cxAlzYe7oaytSWWLXzNDHGogsSO
        s68ZIY6wkrh64QETRI2IxOzONuYJjMKzkIyahWTULCSjZiFpWcDIsopRMrWgODc9t9iwwCgv
        tVyvODG3uDQvXS85P3cTIzjqtLR2MJ44EX+IUYCDUYmH98bm+lgh1sSy4srcQ4wSHMxKIrwB
        tUAh3pTEyqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjGF9TD3L
        YtjWMdw32pm66b8+x7T8AzlJEr83Skzcfif/2tINL/dKCjb/0RTedTLTeIaKpsYlcdF3lTs+
        cE33d7r1cPLF1K17phqudJJ0Pamzk7+eceXhvAlqrxR1KnWMjz10ba5s1lm9M7bc6Pm3he+n
        Pdk/QdxBY6Icx1LJpJY/CUlbipmsPymxFGckGmoxFxUnAgA3bwXstgIAAA==
X-CMS-MailID: 20190917030201epcas1p1cd99c1de475ca6a5c37a04dbe548587e
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190917025738epcas1p1f1dd21ca50df2392b0f84f0340d82bcd
References: <CGME20190917025738epcas1p1f1dd21ca50df2392b0f84f0340d82bcd@epcas1p1.samsung.com>
        <003601d56d03$aa04fa00$fe0eee00$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We are excited to see this happening and would like to state that we apprec=
iate
time and
effort which people put into upstreaming exfat. Thank you=21

However, if possible, can we step back a little bit and re-consider it? We
would prefer to
see upstream the code which we are currently using in our products - sdfat =
- as
this can
be mutually benefitial from various points of view.

Thanks=21

> ---------- Forwarded message ---------
> =BA=B8=B3=BD=BB=E7=B6=F7:=20Ju=20Hyung=20Park=20<qkrwngud825=40gmail.com>=
=0D=0A>=20Date:=202019=B3=E2=209=BF=F9=2016=C0=CF=20(=BF=F9)=20=BF=C0=C0=FC=
=203:49=0D=0A>=20Subject:=20Re:=20=5BPATCH=5D=20staging:=20exfat:=20add=20e=
xfat=20filesystem=20code=20to=0D=0A>=20To:=20Greg=20KH=20<gregkh=40linuxfou=
ndation.org>=0D=0A>=20Cc:=20<alexander.levin=40microsoft.com>,=20<devel=40d=
riverdev.osuosl.org>,=20<linux-=0D=0A>=20fsdevel=40vger.kernel.org>,=20<lin=
ux-kernel=40vger.kernel.org>,=20Valdis=20Kletnieks=0D=0A>=20<valdis.kletnie=
ks=40vt.edu>=0D=0A>=20=0D=0A>=20=0D=0A>=20Hi=20Greg,=0D=0A>=20=0D=0A>=20On=
=20Sun,=20Sep=2015,=202019=20at=2010:54=20PM=20Greg=20KH=20<gregkh=40linuxf=
oundation.org>=20wrote:=0D=0A>=20>=20Note,=20this=20just=20showed=20up=20pu=
blically=20on=20August=2012,=20where=20were=20you=20with=0D=0A>=20>=20all=
=20of=20this=20new=20code=20before=20then?=20=20:)=0D=0A>=20=0D=0A>=20My=20=
sdFAT=20port,=20exfat-nofuse=20and=20the=20one=20on=20the=20staging=20tree,=
=20were=20all=0D=0A>=20made=20by=20Samsung.=0D=0A>=20And=20unless=20you=20g=
uys=20had=20a=20chance=20to=20talk=20to=20Samsung=20developers=0D=0A>=20dir=
ectly,=20those=20all=20share=20the=20same=20faith=20of=20lacking=20proper=
=20development=0D=0A>=20history.=0D=0A>=20=0D=0A>=20The=20source=20I=20used=
=20was=20from=20http://opensource.samsung.com,=20which=0D=0A>=20provides=20=
kernel=20sources=20as=20tar.gz=20files.=0D=0A>=20There=20is=20no=20code=20h=
istory=20available.=0D=0A>=20=0D=0A>=20>=20For=20the=20in-kernel=20code,=20=
we=20would=20have=20to=20rip=20out=20all=20of=20the=20work=20you=20did=0D=
=0A>=20>=20for=20all=20older=20kernels,=20so=20that's=20a=20non-starter=20r=
ight=20there.=0D=0A>=20=0D=0A>=20I'm=20aware.=0D=0A>=20I'm=20just=20letting=
=20mainline=20know=20that=20there=20is=20potentially=20another=20(much=0D=
=0A>=20better)=20base=20that=20could=20be=20upstreamed.=0D=0A>=20=0D=0A>=20=
If=20you=20want=20me=20to=20rip=20out=20older=20kernel=20support=20for=20up=
streaming,=20I'm=0D=0A>=20more=20than=20happy=20to=20do=20so.=0D=0A>=20=0D=
=0A>=20>=20As=20for=20what=20codebase=20to=20work=20off=20of,=20I=20don't=
=20want=20to=20say=20it=20is=20too=20late,=0D=0A>=20>=20but=20really,=20thi=
s=20shows=20up=20from=20nowhere=20and=20we=20had=20to=20pick=20something=20=
so=0D=0A>=20>=20we=20found=20the=20best=20we=20could=20at=20that=20point=20=
in=20time.=0D=0A>=20=0D=0A>=20To=20be=20honest,=20whole=20public=20exFAT=20=
sources=20are=20all=20from=20nowhere=20unless=0D=0A>=20you=20had=20internal=
=20access=20to=20Samsung's=20development=20archive.=0D=0A>=20The=20one=20in=
=20the=20current=20staging=20tree=20isn't=20any=20better.=0D=0A>=20=0D=0A>=
=20I'm=20not=20even=20sure=20where=20the=20staging=20driver=20is=20from,=20=
actually.=0D=0A>=20=0D=0A>=20Samsung=20used=20the=201.2.x=20versioning=20un=
til=20they=20switched=20to=20a=20new=20code=0D=0A>=20base=20-=20sdFAT.=0D=
=0A>=20The=20one=20in=20the=20staging=20tree=20is=20marked=20version=201.3.=
0(exfat_super.c).=0D=0A>=20I=20failed=20to=20find=20anything=201.3.x=20from=
=20Samsung's=20public=20kernel=20sources.=0D=0A>=20=0D=0A>=20The=20last=20t=
ime=20exFAT=201.2.x=20was=20used=20was=20in=20Galaxy=20S7(released=20in=202=
016).=0D=0A>=20Mine=20was=20originally=20based=20on=20sdFAT=202.1.10,=20use=
d=20in=20Galaxy=20S10(released=0D=0A>=20in=20March=202019)=20and=20it=20jus=
t=20got=20updated=20to=202.2.0,=20used=20in=20Galaxy=0D=0A>=20Note10(releas=
ed=20in=20August=202019).=0D=0A>=20=0D=0A>=20>=20Is=20there=20anything=20sp=
ecific=20in=20the=20codebase=20you=20have=20now,=20that=20is=20lacking=0D=
=0A>=20>=20in=20the=20in-kernel=20code?=20=20Old-kernel-support=20doesn't=
=20count=20here,=20as=20we=0D=0A>=20>=20don't=20care=20about=20that=20as=20=
it=20is=20not=20applicable.=20=20But=20functionality=20does=0D=0A>=20>=20ma=
tter,=20what=20has=20been=20added=20here=20that=20we=20can=20make=20use=20o=
f?=0D=0A>=20=0D=0A>=20This=20is=20more=20of=20a=20suggestion=20of=0D=0A>=20=
=22Let's=20base=20on=20a=20*much=20more=20recent*=20snapshot=20for=20the=20=
community=20to=20work=20on=22,=0D=0A>=20since=20the=20current=20one=20on=20=
the=20staging=20tree=20also=20lacks=20development=20history.=0D=0A>=20=0D=
=0A>=20The=20diff=20is=20way=20too=20big=20to=20even=20start=20understandin=
g=20the=20difference.=0D=0A>=20=0D=0A>=20=0D=0A>=20With=20that=20said=20tho=
ugh,=20I=20do=20have=20some=20vague=20but=20real=20reason=20as=20to=20why=
=0D=0A>=20sdFAT=20base=20is=20better.=0D=0A>=20=0D=0A>=20With=20some=20majo=
r=20Android=20vendors=20showing=20interests=20in=20supporting=20exFAT,=0D=
=0A>=20Motorola=20notably=20published=20their=20work=20on=20public=20Git=20=
repository=20with=0D=0A>=20full=20development=20history(the=20only=20vendor=
=20to=20do=20this=20that=20I'm=20aware=0D=0A>=20of).=0D=0A>=20Commits=20lik=
e=20this:=0D=0A>=20https://github.com/MotorolaMobilityLLC/kernel-msm/commit=
/7ab1657=20is=0D=0A>=20not=20merged=20to=20exFAT(including=20the=20current=
=20staging=20tree=20one)=20while=20it=0D=0A>=20did=20for=20sdFAT.=0D=0A>=20=
=0D=0A>=20=0D=0A>=20The=20only=20thing=20I=20regret=20is=20not=20working=20=
on=20porting=20sdFAT=20sooner.=0D=0A>=20I=20definitely=20didn't=20anticipat=
e=20Microsoft=20to=20suddenly=20lift=20legal=20issues=0D=0A>=20on=20upstrea=
ming=20exFAT=20just=20around=20when=20I=20happen=20to=20gain=20interest=20i=
n=0D=0A>=20porting=20sdFAT.=0D=0A>=20=0D=0A>=20If=20my=20port=20happened=20=
sooner,=20it=20would=20have=20been=20a=20no-brainer=20for=20it=20to=0D=0A>=
=20be=20considered=20as=20a=20top=20candidate=20for=20upstreaming.=0D=0A>=
=20=0D=0A>=20>=20And=20do=20you=20have=20any=20=22real=22=20development=20h=
istory=20to=20look=20at=20instead=20of=20the=0D=0A>=20>=20=22one=20giant=20=
commit=22=20of=20the=20initial=20code=20drop?=20=20That=20is=20where=20we=
=20could=0D=0A>=20>=20actually=20learn=20what=20has=20changed=20over=20time=
.=20=20Your=20repo=20as-is=20shows=20none=0D=0A>=20>=20of=20the=20interesti=
ng=20bits=20:(=0D=0A>=20=0D=0A>=20As=20I=20mentioned,=20development=20histo=
ry=20is=20unobtainable,=20even=20for=20the=0D=0A>=20current=20staging=20tre=
e=20or=20exfat-nofuse.=0D=0A>=20(If=20you=20guys=20took=20exfat-nofuse,=20y=
ou=20can=20also=20see=20that=20there's=20barely=0D=0A>=20any=20real=20exFAT=
-related=20development=20done=20in=20that=20tree.=20Everything=20is=0D=0A>=
=20basically=20fixes=20for=20newer=20kernel=20versions.)=0D=0A>=20=0D=0A>=
=20The=20best=20I=20could=20do,=20if=20someone's=20interested,=20is=20to=20=
diff=20all=20versions=0D=0A>=20of=20exFAT/sdFAT=20throughout=20the=20Samsun=
g's=20kernel=20versions,=20but=20that=0D=0A>=20still=20won't=20give=20us=20=
reasons=20as=20to=20why=20the=20changes=20were=20made.=0D=0A>=20=0D=0A>=20T=
L;DR=0D=0A>=20My=20suggestion=20-=20Let's=20base=20on=20a=20much=20newer=20=
driver=20that's=20matured=20more,=0D=0A>=20contains=20more=20fixes,=20gives=
=20(slightly?)=20better=20performance=20and=0D=0A>=20hopefully=20has=20bett=
er=20code=20quality.=0D=0A>=20=0D=0A>=20Both=20drivers=20are=20horrible.=0D=
=0A>=20You=20said=20it=20yourself(for=20the=20current=20staging=20one),=20a=
nd=20even=20for=20my=20new=0D=0A>=20sdFAT-base=20proposal,=20I'm=20definite=
ly=20not=20comfortable=20seeing=20this=20kind=0D=0A>=20of=20crap=20in=20mai=
nline:=0D=0A>=20https://github.com/arter97/exfat-linux/commit/0f1ddde=0D=0A=
>=20=0D=0A>=20However,=20it's=20clear=20to=20me=20that=20the=20sdFAT=20base=
=20is=20less-horrible.=0D=0A>=20=0D=0A>=20Please=20let=20me=20know=20what=
=20you=20think.=0D=0A>=20=0D=0A>=20>=20thanks,=0D=0A>=20>=0D=0A>=20>=20greg=
=20kh=0D=0A>=20=0D=0A>=20Thanks.=0D=0A>=20=0D=0A=0D=0A=0D=0A
