Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75037F33C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 08:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhEMGxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 02:53:21 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:52175 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEMGxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 02:53:20 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210513065208epoutp03d9ec08e5d86ddb83d825b7e74e6dd68a~_jbYF6tWa0032200322epoutp03i
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 May 2021 06:52:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210513065208epoutp03d9ec08e5d86ddb83d825b7e74e6dd68a~_jbYF6tWa0032200322epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620888728;
        bh=EjZZMj/sXLOBPqiyLsIUwSPwZ9N4tL3FBl+3yX5/pjI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ay7kfGz45frM+TutQIDXr1AqH+FcbjVYu9F4Wg9ZDuOMVQIx2lwsTZUcLC0FzA2C+
         Vfgrc4BN+/SWs2/Rl0QSmw1wXV3OLunkdpbLH6crZHI5csxWLGH4CcAOxJ9pel3/cN
         hsNjRkHQ+lQENmrPiZL8Fg7JhP6Y7CdM6e+q+Xvg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210513065208epcas1p3f3b9af979a4725c65c1434c5651b01e4~_jbXuJcoD2555225552epcas1p3A;
        Thu, 13 May 2021 06:52:08 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Fgj532yBQz4x9QB; Thu, 13 May
        2021 06:52:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.24.09824.79CCC906; Thu, 13 May 2021 15:52:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210513065206epcas1p1d1425af8874db38993c61e50acb4cf88~_jbWPBKnT0964809648epcas1p1K;
        Thu, 13 May 2021 06:52:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210513065206epsmtrp221fca85626b767ebc899c727e6b0f594~_jbWOGAwb2595625956epsmtrp2e;
        Thu, 13 May 2021 06:52:06 +0000 (GMT)
X-AuditID: b6c32a37-621e9a8000002660-58-609ccc97b4db
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.CB.08637.69CCC906; Thu, 13 May 2021 15:52:06 +0900 (KST)
Received: from namjaejeon01 (unknown [10.89.31.77]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210513065206epsmtip2e25b13844187f975145cad55c7fec1ed~_jbWCF3oV2617226172epsmtip2K;
        Thu, 13 May 2021 06:52:06 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Eric Sandeen'" <sandeen@sandeen.net>,
        "'Hyunchul Lee'" <hyc.lee@gmail.com>
Cc:     "'Namjae Jeon'" <linkinjeon@kernel.org>,
        "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'Pavel Reichl'" <preichl@redhat.com>,
        <chritophe.vu-brugier@seagate.com>
In-Reply-To: <35b5967f-dc19-f77f-f7d1-bf1d6e2b73e8@sandeen.net>
Subject: RE: problem with exfat on 4k logical sector devices
Date:   Thu, 13 May 2021 15:52:06 +0900
Message-ID: <003801d747c4$7cfdf820$76f9e860$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEo2/DaJy0YUotfQpay9jtmd1bcWAIfpTVmAa7BVgkB2ON5bQKp9gK5AZBO5OQB5D2sQQE5UguEq9XXIiA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmru70M3MSDO4+FLBoWzqfzeLa/ffs
        FhOnLWW22LP3JIvFzINuFq1XtBzYPHbOusvusWlVJ5vH+31X2Ty2LH7I5NF++BuLx+dNcgFs
        UTk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBHKCmU
        JeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKDA0K9IoTc4tL89L1kvNzrQwNDIxMgSoT
        cjIOfvjJVnDYtOLNkROsDYz/jbsYOTkkBEwkfk4+wdrFyMUhJLCDUaL3wkomCOcTo8STCyvY
        IZxvjBJbf61jgmnZ/3sLC0RiL6PEnAkfoJwXjBINXw+BVbEJ6Er8+7OfDcQWEQiS2LLgMRtI
        EbPAWkaJXSf3sIIkOAXsJd40gSzk4BAWsJFoOVMFEmYRUJXo/nucGcTmFbCU+Hn+NwuELShx
        cuYTMJtZQFti2cLXzBAXKUj8fLqMFWJXksTls4/ZIGpEJGZ3tjGD7JUQmMoh8ad5B1SDi8Tl
        g7vYIWxhiVfHt0DZUhKf3+1lg7DLJU6c/AX1co3Ehnn72EHulBAwluh5UQJiMgtoSqzfpQ9R
        oSix8/dcRoi1fBLvvvawQlTzSnS0CUGUqEr0XToMNVBaoqv9A/sERqVZSB6bheSxWUgemIWw
        bAEjyypGsdSC4tz01GLDAmPkyN7ECE6gWuY7GKe9/aB3iJGJg/EQowQHs5IIr1jS7AQh3pTE
        yqrUovz4otKc1OJDjKbAoJ7ILCWanA9M4Xkl8YamRsbGxhYmZuZmpsZK4rzpztUJQgLpiSWp
        2ampBalFMH1MHJxSDUzLrlf55Mv3LmLvYeM6obh3/bx7XnyGiU7bgjsupjiqdEbcF9KxN5i5
        WjtGtlSiazeXy9ZfL51j4yK/fU1Z1ismYao8//Gq5W+kG0s5WzfNWfsnLf5TY5nvh9C3um8W
        GuQaz2QyE9VfIF5mpDn1/3on389nd+Yfe7Ww9weTeu2WoPCdl0/fNDhSUfXLq7SNe6nXBtk1
        tkvDvkTw3kuctOv8lI2Pl352nZBfOb/UR6++eW3gK84P9fxSD3229b9r2XndS+XE1Lj/XFpT
        /7S6KZplfOhaMp0/P+ma2+/JZ990xC7+daji3u59j95cle+8dfxyoT5vvFJH4OEPH/9L36s0
        7b7nfEas8JDq48afRR+VWIozEg21mIuKEwEFCHgqKQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvO60M3MSDLa26Fi0LZ3PZnHt/nt2
        i4nTljJb7Nl7ksVi5kE3i9YrWg5sHjtn3WX32LSqk83j/b6rbB5bFj9k8mg//I3F4/MmuQC2
        KC6blNSczLLUIn27BK6MKytnsRZMUq14+X0PcwPjAtkuRk4OCQETif2/t7CA2EICuxkl1jXw
        QsSlJY6dOMPcxcgBZAtLHD5c3MXIBVTyjFFi856JzCA1bAK6Ev/+7GcDsUUEgiQu/Z7BDFLE
        LLCeUeJgw0Y2iKEPmSW69nGB2JwC9hJvmlYygQwVFrCRaDlTBRJmEVCV6P57HGwmr4ClxM/z
        v1kgbEGJkzOfgNnMAtoSvQ9bGWHsZQtfM0PcqSDx8+kyVogbkiQun33MBlEjIjG7s415AqPw
        LCSjZiEZNQvJqFlIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOIy3NHYzb
        V33QO8TIxMF4iFGCg1lJhFcsaXaCEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tS
        s1NTC1KLYLJMHJxSDUyTD3zSUn6cHhDrubhJr+9ZYj0zpyFrbIDOfz3To8dz2u2qVfmylZwX
        xurekV909c65J6sZ107pubnk+a3wHdskF+rWvZ5eV1EkbfopX/T0P9tL5dImG5eEB55wWFOy
        t5R1iuW5p11vu/Orjzh/P5WuqFPx++QypkUmzucV2NenMGfujX5avH77SqYlgTzlu2+I7xK+
        c0XwaNksi6XvQ51Mp56KuHSyun9qa5ZU/4XX35f6HGhuvJ8kt1zjuN3S5w8iLRnf5WtMtWor
        vt187+df/5mB5zdvWubnGnUss7q8Ns8+nu3/+rXdkTtk7NvSZy37Her2pi5h8uz5X/wqDNf7
        5dno8CU7bPBsOT0jf6ISS3FGoqEWc1FxIgDFC+kCEgMAAA==
X-CMS-MailID: 20210513065206epcas1p1d1425af8874db38993c61e50acb4cf88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210511233346epcas1p3071e13aa2f1364e231f2d6ece4b64ca2
References: <372ffd94-d1a2-04d6-ac38-a9b61484693d@sandeen.net>
        <CAKYAXd_5hBRZkCfj6YAgb1D2ONkpZMeN_KjAQ_7c+KxHouLHuw@mail.gmail.com>
        <CGME20210511233346epcas1p3071e13aa2f1364e231f2d6ece4b64ca2@epcas1p3.samsung.com>
        <276da0be-a44b-841e-6984-ecf3dc5da6f0@sandeen.net>
        <001201d746c0$cc8da8e0$65a8faa0$@samsung.com>
        <b3015dc1-07a9-0c14-857a-9562a9007fb6@sandeen.net>
        <CANFS6bZs3bDQdKH-PYnQqo=3iDUaVy5dH8VQ+JE8WdeVi4o0NQ@mail.gmail.com>
        <35b5967f-dc19-f77f-f7d1-bf1d6e2b73e8@sandeen.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>=20
> On 5/12/21 9:09 AM, Hyunchul Lee wrote:
> > Hello,
> >
> > 2021=EB=85=84=205=EC=9B=94=2012=EC=9D=BC=20(=EC=88=98)=20=EC=98=A4=EC=
=A0=84=208:57,=20Eric=20Sandeen=20<sandeen=40sandeen.net>=EB=8B=98=EC=9D=B4=
=20=EC=9E=91=EC=84=B1:=0D=0A>=20>>=0D=0A>=20>>=20On=205/11/21=206:53=20PM,=
=20Namjae=20Jeon=20wrote:=0D=0A>=20>>=0D=0A>=20>>>>=20One=20other=20thing=
=20that=20I=20ran=20across=20is=20that=20fsck=20seems=20to=20validate=20an=
=0D=0A>=20>>>>=20image=20against=20the=20sector=20size=20of=20the=20device=
=20hosting=20the=20image=0D=0A>=20>>>>=20rather=20than=20the=20sector=20siz=
e=20found=20in=20the=20boot=20sector,=20which=20seems=20like=20another=20is=
sue=20that=20will=0D=0A>=20come=20up:=0D=0A>=20>>>>=0D=0A>=20>>>>=20=23=20f=
sck/fsck.exfat=20/dev/sdb=0D=0A>=20>>>>=20exfatprogs=20version=20:=201.1.1=
=0D=0A>=20>>>>=20/dev/sdb:=20clean.=20directories=201,=20files=200=0D=0A>=
=20>>>>=0D=0A>=20>>>>=20=23=20dd=20if=3D/dev/sdb=20of=3Dtest.img=0D=0A>=20>=
>>>=20524288+0=20records=20in=0D=0A>=20>>>>=20524288+0=20records=20out=0D=
=0A>=20>>>>=20268435456=20bytes=20(268=20MB)=20copied,=201.27619=20s,=20210=
=20MB/s=0D=0A>=20>>>>=0D=0A>=20>>>>=20=23=20fsck.exfat=20test.img=0D=0A>=20=
>>>>=20exfatprogs=20version=20:=201.1.1=0D=0A>=20>>>>=20checksum=20of=20boo=
t=20region=20is=20not=20correct.=200,=20but=20expected=200x3ee721=0D=0A>=20=
>>>>=20boot=20region=20is=20corrupted.=20try=20to=20restore=20the=20region=
=20from=20backup.=0D=0A>=20>>>>=20Fix=20(y/N)?=20n=0D=0A>=20>>>>=0D=0A>=20>=
>>>=20Right=20now=20the=20utilities=20seem=20to=20assume=20that=20the=20dev=
ice=20they're=0D=0A>=20>>>>=20pointed=20at=20is=20always=20a=20block=20devi=
ce,=20and=20image=20files=20are=20problematic.=0D=0A>=20>>>=20Okay,=20Will=
=20fix=20it.=0D=0A>=20>>=0D=0A>=20>>=20Right=20now=20I=20have=20a=20hack=20=
like=20this.=0D=0A>=20>>=0D=0A>=20>>=201)=20don't=20validate=20the=20in-ima=
ge=20sector=20size=20against=20the=20host=20device=0D=0A>=20>>=20size=20(ma=
ybe=20should=20only=20skip=20this=20check=20if=20it's=20not=20a=20bdev?=20O=
r=20is=20it=0D=0A>=20>>=20OK=20to=20have=20a=204k=20sector=20size=20fs=20on=
=20a=20512=20device?=20Probably?)=0D=0A>=20>>=0D=0A>=20>>=202)=20populate=
=20the=20=22bd=22=20sector=20size=20information=20from=20the=20values=20rea=
d=20from=20the=20image.=0D=0A>=20>>=0D=0A>=20>>=20It=20feels=20a=20bit=20me=
ssy,=20but=20it=20works=20so=20far.=20I=20guess=20the=20messiness=0D=0A>=20=
>>=20stems=20from=20assuming=20that=20we=20always=20have=20a=20=22bd=22=20b=
lock=20device.=0D=0A>=20>>=0D=0A>=20>=0D=0A>=20>=20I=20think=20we=20need=20=
to=20keep=20the=20=22bd=22=20sector=20size=20to=20avoid=20confusion=0D=0A>=
=20>=20between=20the=20device's=20sector=20size=20and=20the=20exfat's=20sec=
tor=20size.=0D=0A>=20=0D=0A>=20Sure,=20it's=20just=20that=20for=20a=20files=
ystem=20in=20an=20image=20file,=20there=20is=20no=20meaning=20to=20the=20=
=22device=20sector=0D=0A>=20size=22=20because=20there=20is=20no=20device.=
=0D=0A>=20=0D=0A>=20...=0D=0A>=20=0D=0A>=20>=20Is=20it=20better=20to=20add=
=20a=20sector=20size=20parameter=20to=20read_boot_region=0D=0A>=20>=20funct=
ion?=20This=20function=20is=20also=20called=20to=20read=20the=20backup=20bo=
ot=20region=0D=0A>=20>=20to=20restore=20the=20corrupted=20main=20boot=20reg=
ion.=0D=0A>=20>=20During=20this=20restoration,=20we=20need=20to=20read=20th=
e=20backup=20boot=20region=20with=0D=0A>=20>=20various=20sector=20sizes,=20=
Because=20we=20don't=20have=20a=20certain=20exfat=20sector=0D=0A>=20>=20siz=
e.=0D=0A>=20>=0D=0A>=20>>=20=20=20=20=20=20=20=20=20ret=20=3D=20boot_region=
_checksum(bd,=20bs_offset);=0D=0A>=20>>=20=20=20=20=20=20=20=20=20if=20(ret=
=20<=200)=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20got=
o=20err;=0D=0A>=20>>=0D=0A>=20>>=0D=0A>=20>=0D=0A>=20>=20I=20sent=20the=20p=
ull=20request=20to=20fix=20these=20problems.=20Could=20you=20check=20this=
=20request?=0D=0A>=20>=20https://protect2.fireeye.com/v1/url?k=3D7932f7a1-2=
6a9cef7-79337cee-0cc47=0D=0A>=20>=20a31ce52-924b76d62e7bfc04&q=3D1&e=3D433c=
5d9e-f62a-4378-9b98-3c965d70e4da&u=3D=0D=0A>=20>=20https%3A%2F%2Fgithub.com=
%2Fexfatprogs%2Fexfatprogs%2Fpull%2F167=0D=0A>=20=0D=0A>=20I=20didn't=20rev=
iew=20that=20in=20depth,=20but=20it=20looks=20like=20for=20fsck=20and=20dum=
p,=20it=20gets=20the=20sector=20size=20from=20the=0D=0A>=20boot=20sector=20=
rather=20than=20from=20the=20host=20device=20or=20filesystem,=20which=20mak=
es=20sense,=20at=20least.=0D=0A>=20=0D=0A>=20(As=20an=20aside,=20I'd=20sugg=
est=20that=20your=20new=20=22c2o=22=20function=20could=20have=20a=20more=20=
descriptive,=20self-documenting=0D=0A>=20name.)=0D=0A>=20=0D=0A>=20But=20th=
ere=20are=20other=20problems=20where=20bd->sector_*=20is=20used=20and=20ass=
umed=20to=20relate=20to=20the=20filesystem,=20for=0D=0A>=20example:=0D=0A>=
=20=0D=0A>=20=23=20fsck/fsck.exfat=20/root/test.img=0D=0A>=20exfatprogs=20v=
ersion=20:=201.1.1=0D=0A>=20/root/test.img:=20clean.=20directories=201,=20f=
iles=200=20=23=20tune/tune.exfat=20-I=200x1234=20=20/root/test.img=20exfatp=
rogs=0D=0A>=20version=20:=201.1.1=20New=20volume=20serial=20:=200x1234=20=
=23=20fsck/fsck.exfat=20/root/test.img=20exfatprogs=20version=20:=201.1.1=
=0D=0A>=20checksum=20of=20boot=20region=20is=20not=20correct.=200x3eedc5,=
=20but=20expected=200xe59577e3=20boot=20region=20is=20corrupted.=0D=0A>=20t=
ry=20to=20restore=20the=20region=20from=20backup.=20Fix=20(y/N)?=20n=0D=0A>=
=20=0D=0A>=20I=20think=20because=20exfat_write_checksum_sector()=20relies=
=20on=20bd->sector_size.=0D=0A>=20=0D=0A>=20You=20probably=20need=20to=20au=
dit=20every=20use=20of=20bd->sector_size=20and=0D=0A>=20bd->sector_size_bit=
s=20outside=20of=20mkfs,=20because=20anything=20assuming=20that=20it=0D=0A>=
=20is=20related=20to=20the=20filesystem=20itself,=20as=20opposed=20to=20the=
=20filesytem/device=20hosting=20it,=20could=20be=0D=0A>=20problematic.=20=
=20Is=20there=20any=20time=20outside=20of=20mkfs=20that=20you=20actually=20=
care=20about=20the=20device=20sector=20size?=0D=0A>=20If=20not,=20I=20might=
=20suggest=20trying=20to=20isolate=20that=20usage=20to=20mkfs.=0D=0AI=20do=
=20not=20object=20to=20updating=20bd->sector_size=20to=20sector=20size=20ob=
tained=20from=20boot=20sector.=0D=0AI=20think=20that's=20the=20best=20way=
=20to=20do=20it.=0D=0A=0D=0A>=20=0D=0A>=20I=20also=20wonder=20about:=0D=0A>=
=20=0D=0A>=20=20=20=20=20=20=20=20=20bd->num_sectors=20=3D=20blk_dev_size=
=20/=20DEFAULT_SECTOR_SIZE;=0D=0A>=20=20=20=20=20=20=20=20=20bd->num_cluste=
rs=20=3D=20blk_dev_size=20/=20ui->cluster_size;=0D=0A>=20=0D=0A>=20is=20it=
=20really=20correct=20that=20this=20should=20always=20be=20in=20terms=20of=
=20512-byte=20sectors?=0D=0AYep,=20Need=20to=20fix=20it.=0D=0A=0D=0AThanks=
=21=0D=0A>=20=0D=0A>=20-Eric=0D=0A=0D=0A
