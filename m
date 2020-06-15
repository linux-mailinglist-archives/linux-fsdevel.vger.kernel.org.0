Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7A1F8C5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 04:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgFOC4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jun 2020 22:56:13 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:59895 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgFOC4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jun 2020 22:56:12 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200615025607epoutp040dc62d117622956520217e9ee7e26c2a~YmChzwo_l1321913219epoutp04j
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 02:56:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200615025607epoutp040dc62d117622956520217e9ee7e26c2a~YmChzwo_l1321913219epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592189767;
        bh=OSgaMGStcVna1NvLyYlJ7PYN2FF5jFA2B5CSbZ5HrKA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=qerLNAr0Y98+CNjQKrc5OaDjCg15h6n8muEy+vadi7u69KvnL2yq5IKcD0Yu5+K21
         ufoyM64aDtidVCMpHw7+cMwJEo2cXn9Xnj/06yix8hH9D/bjE7xW7XvgiD5X9V9CO9
         SbW0+Sl5/fYzIZxoFILkPZT91dRMMnXXBalfhO0A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200615025607epcas1p151a08d5f661dde35b3faccbd18aabe1b~YmChNZEvi2619126191epcas1p1n;
        Mon, 15 Jun 2020 02:56:07 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49lbYy0d7HzMqYkj; Mon, 15 Jun
        2020 02:56:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.87.19033.543E6EE5; Mon, 15 Jun 2020 11:56:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200615025605epcas1p323a08f6874ea5569c2f79e8fb36d84d2~YmCf3kvCq0303003030epcas1p3N;
        Mon, 15 Jun 2020 02:56:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200615025605epsmtrp106ea82bacb8b166ec9bbee2e5d20fa9d~YmCf2-SXj2427424274epsmtrp1G;
        Mon, 15 Jun 2020 02:56:05 +0000 (GMT)
X-AuditID: b6c32a36-159ff70000004a59-19-5ee6e345230f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.F2.08382.543E6EE5; Mon, 15 Jun 2020 11:56:05 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200615025605epsmtip279cb7fba4a992d4683d9f0962099e628~YmCftxeGQ2038420384epsmtip2Z;
        Mon, 15 Jun 2020 02:56:05 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Hyunchul Lee'" <hyc.lee@gmail.com>
Cc:     <linux-fsdevel@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <CANFS6bYm_yCLG2kKfn8wYBJ4bO+Z+2+R-gHQ6dTwiP9Ut3yy5g@mail.gmail.com>
Subject: RE: [PATCH 1/2] exfat: call sync_filesystem for read-only remount
Date:   Mon, 15 Jun 2020 11:56:05 +0900
Message-ID: <003901d642c0$832b10c0$89813240$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIBJJ4yXVc624qtmpPir+DFyChZQwLoIJeKAkCj0FcB5qa6iKhKu2dg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmvq7b42dxBrtmMlpcu/+e3WLP3pMs
        Fpd3zWGz2PLvCKsDi8fOWXfZPfq2rGL0+LxJLoA5KscmIzUxJbVIITUvOT8lMy/dVsk7ON45
        3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2ibkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRW
        KbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ+PH0maWgj+qFXNWv2RrYPyu0sXIySEh
        YCKxt28LcxcjF4eQwA5GiY9bNjJCOJ8YJdq2TWSBcL4xSlzfu4MZpqX15Cs2iMReRomHvYvZ
        IZyXjBKrV05iA6liE9CV+PdnP5gtIqAh8e/kIyYQm1mgUmLn9HlgkzgFAiW+vl8HViMs4CVx
        rWMfmM0ioCpxd+k/FhCbV8BS4sSSh+wQtqDEyZlPWCDmaEssW/ga6iIFiZ9Pl7FC7HKT+Nva
        CVUjIjG7sw3sOQmBl+wSZ67MAHI4gBwXiXu3yyB6hSVeHd/CDmFLSbzsb2OHKKmW+LgfanwH
        o8SL77YQtrHEzfUbWEFKmAU0Jdbv0ocIK0rs/D2XEWIrn8S7rz2sEFN4JTrahCBKVCX6Lh1m
        grClJbraP7BPYFSaheSvWUj+moXk/lkIyxYwsqxiFEstKM5NTy02LDBCjutNjOCEqGW2g3HS
        2w96hxiZOBgPMUpwMCuJ8HanPYkT4k1JrKxKLcqPLyrNSS0+xGgKDOmJzFKiyfnAlJxXEm9o
        amRsbGxhYmZuZmqsJM6rJnMhTkggPbEkNTs1tSC1CKaPiYNTqoFpClvqtQzO+0dWnDsl90qX
        5fpUjmVLHraFHVl79Xgek+bWCUFc8xOiZc9duJ3f8cBWh2XH1e/yF+yKN+cvD1bYxG17knkP
        v+SJm1NT4g9uejYx8u3r2MZ0xq3FwvohxxwuLw1b/WnW22OaNpaL+34q3pjE2tCvtZFDY31n
        codv2KWnUoGM03+d+i60yKvwxNmc+/eVQsOWxEv+PL0w6t2nKZl5M1XE5mv6t9S/+jGt07bW
        sjZflXvXJ5Ozp24sq379if/cjZ8u0wSsNXP96s7LvvHetitO0JbXM+zAnEDeHe/vulhtecmW
        o3lH87He+SfNNudipeP3HJ+iwX3nTqvnnmbtlntNz7Kzf207rffqhhJLcUaioRZzUXEiAOXe
        o5sRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvK7r42dxBvuXqllcu/+e3WLP3pMs
        Fpd3zWGz2PLvCKsDi8fOWXfZPfq2rGL0+LxJLoA5issmJTUnsyy1SN8ugSujZ9E2xoKr4hUb
        b7xgaWCcLNjFyMkhIWAi0XryFVsXIxeHkMBuRommy1OZIRLSEsdOnAGyOYBsYYnDh4shap4z
        Siy8d4MNpIZNQFfi35/9YLaIgIbEv5OPmEBsZoFqiRkf3oDZQgK/GCWuf5AEsTkFAiW+vl8H
        Vi8s4CVxrWMfmM0ioCpxd+k/FhCbV8BS4sSSh+wQtqDEyZlPWCBmakv0PmxlhLGXLXwNdaeC
        xM+ny1ghbnCT+NvaCVUvIjG7s415AqPwLCSjZiEZNQvJqFlIWhYwsqxilEwtKM5Nzy02LDDM
        Sy3XK07MLS7NS9dLzs/dxAiODS3NHYzbV33QO8TIxMF4iFGCg1lJhLc77UmcEG9KYmVValF+
        fFFpTmrxIUZpDhYlcd4bhQvjhATSE0tSs1NTC1KLYLJMHJxSDUwT7uVMedEfsepD9lejaSf/
        SC2tm7C1x5k3cIYJh1ajSkP63CWKIXc/pWuJlpQ1iEzrv3tzccL1S0fyspOnF5oFtLX/388Z
        p8pYwf1YJKTXaZa1l2B42dGDfRY7nVoYNWcu8bzuEhYjNs1jqtry5WqsMRcXie6ZuY2pJaOr
        662soxZDvx1v51J2Fa/VZkfe8O9JD7IoOrNA0KDpcMal3VnfX9eGp64sPhefr73J8pLLgZLF
        VmzTJhU/e96Xf+4+d00W37ey7Lwn82c+0vyv8Giu7Z6pExfbWx1eMYtxbuuU5f33jsexzvZJ
        DHs1wadGxmSZ2C+XdrtzFtyyr5sSejICZU52zLn3y96StcxlmRJLcUaioRZzUXEiACAPI0/8
        AgAA
X-CMS-MailID: 20200615025605epcas1p323a08f6874ea5569c2f79e8fb36d84d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200612094312epcas1p1d8be51e8ab6e26b622e3c8437a20cfcf
References: <CGME20200612094312epcas1p1d8be51e8ab6e26b622e3c8437a20cfcf@epcas1p1.samsung.com>
        <20200612094250.9347-1-hyc.lee@gmail.com>
        <001401d642a9$f74c3040$e5e490c0$@samsung.com>
        <CANFS6bYm_yCLG2kKfn8wYBJ4bO+Z+2+R-gHQ6dTwiP9Ut3yy5g@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Hi Namjae,
>=20
> 2020=EB=85=84=206=EC=9B=94=2015=EC=9D=BC=20(=EC=9B=94)=20=EC=98=A4=EC=A0=
=84=209:14,=20Namjae=20Jeon=20<namjae.jeon=40samsung.com>=EB=8B=98=EC=9D=B4=
=20=EC=9E=91=EC=84=B1:=0D=0A>=20>=0D=0A>=20>=20Hi=20Hyunchul,=0D=0A>=20>=20=
>=20We=20need=20to=20commit=20dirty=20metadata=20and=20pages=20to=20disk=20=
before=20remounting=20exfat=20as=20read-only.=0D=0A>=20>=20>=0D=0A>=20>=20>=
=20This=20fixes=20a=20failure=20in=20xfstests=20generic/452=0D=0A>=20>=20Co=
uld=20you=20please=20elaborate=20more=20the=20reason=20why=20generic/452=20=
in=20xfstests=20failed=20?=0D=0A>=20=0D=0A>=20xfstests=20generic/452=20does=
=20the=20following.=0D=0A>=20cp=20/bin/ls=20<exfat>/=0D=0A>=20mount=20-o=20=
remount,ro=20<exfat>=0D=0A>=20=0D=0A>=20the=20<exfat>/ls=20file=20is=20corr=
upted,=20because=20while=20exfat=20is=20remounted=20as=20read-only,=20exfat=
=20doesn't=20have=20a=0D=0A>=20chance=20to=20commit=20metadata=20and=20vfs=
=20invalidates=20page=20caches=20in=20a=20block=20device.=0D=0AGot=20it.=0D=
=0A>=20=0D=0A>=20I=20will=20put=20this=20explanation=20in=20a=20commit=20me=
ssage.=0D=0AGood.=0D=0A>=20=0D=0A>=20>=20>=0D=0A>=20>=20>=20Signed-off-by:=
=20Hyunchul=20Lee=20<hyc.lee=40gmail.com>=0D=0A>=20>=20>=20---=0D=0A>=20>=
=20>=20=20fs/exfat/super.c=20=7C=2019=20+++++++++++++++++++=0D=0A>=20>=20>=
=20=201=20file=20changed,=2019=20insertions(+)=0D=0A>=20>=20>=0D=0A>=20>=20=
>=20diff=20--git=20a/fs/exfat/super.c=20b/fs/exfat/super.c=20index=0D=0A>=
=20>=20>=20e650e65536f8..61c6cf240c19=20100644=0D=0A>=20>=20>=20---=20a/fs/=
exfat/super.c=0D=0A>=20>=20>=20+++=20b/fs/exfat/super.c=0D=0A>=20>=20>=20=
=40=40=20-693,10=20+693,29=20=40=40=20static=20void=20exfat_free(struct=20f=
s_context=20*fc)=0D=0A>=20>=20>=20=20=20=20=20=20=20=7D=0D=0A>=20>=20>=20=
=20=7D=0D=0A>=20>=20>=0D=0A>=20>=20>=20+static=20int=20exfat_reconfigure(st=
ruct=20fs_context=20*fc)=20=7B=0D=0A>=20>=20>=20+=20=20=20=20=20struct=20su=
per_block=20*sb=20=3D=20fc->root->d_sb;=0D=0A>=20>=20>=20+=20=20=20=20=20in=
t=20ret;=0D=0A>=20>=20int=20ret=20=3D=200;=0D=0A>=20>=20>=20+=20=20=20=20=
=20bool=20new_rdonly;=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20+=20=20=20=20=20n=
ew_rdonly=20=3D=20fc->sb_flags=20&=20SB_RDONLY;=0D=0A>=20>=20>=20+=20=20=20=
=20=20if=20(new_rdonly=20=21=3D=20sb_rdonly(sb))=20=7B=0D=0A>=20>=20If=20yo=
u=20modify=20it=20like=20this,=20would=20not=20we=20need=20new_rdonly?=0D=
=0A>=20>=20=20=20=20=20=20=20=20=20if=20(fc->sb_flags=20&=20SB_RDONLY=20&&=
=20=21sb_rdonly(sb))=0D=0A>=20>=0D=0A>=20This=20condition=20means=20that=20=
mount=20options=20are=20changed=20from=20=22rw=22=20to=20=22ro=22,=20or=20=
=22ro=22=20to=20=22rw=22.=0D=0A>=20=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=
=20=20=20=20=20=20if=20(new_rdonly)=20=7B=0D=0A>=20=0D=0A>=20And=20this=20c=
ondition=20means=20these=20options=20are=20changed=20from=20=22rw=22=20to=
=20=22ro=22.=0D=0A>=20It=20seems=20better=20to=20change=20two=20conditions=
=20to=20the=20one=20you=20suggested,=20or=20remove=20those.=20because=0D=0A=
>=20sync_filesystem=20returns=200=20when=20the=20filesystem=20is=20mounted=
=20as=20read-only.=0D=0AThe=20latter=20would=20be=20fine.=0D=0A>=20=0D=0A>=
=20>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
/*=20volume=20flag=20will=20be=20updated=20in=20exfat_sync_fs=20*/=0D=0A>=
=20>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
ret=20=3D=20sync_filesystem(sb);=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(ret=20<=200)=0D=0A>=20>=20>=20=
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20return=20ret;=0D=0A>=20>=20I=20think=20that=20this=20ret=20c=
heck=20can=20be=20removed=20by=20using=20return=20ret;=20below=20?=0D=0A>=
=20=0D=0A>=20Okay,=20I=20will=20apply=20this.=0D=0A>=20Thank=20you=20for=20=
your=20comments=21=0D=0AThanks=20for=20your=20patch=21=0D=0A>=20=0D=0A>=20=
=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=7D=0D=0A>=20>=20=
>=20+=20=20=20=20=20=7D=0D=0A>=20>=20>=20+=20=20=20=20=20return=200;=0D=0A>=
=20>=20return=20ret;=0D=0A>=20>=20>=20+=7D=0D=0A>=20>=20>=20+=0D=0A>=20>=20=
>=20=20static=20const=20struct=20fs_context_operations=20exfat_context_ops=
=20=3D=20=7B=0D=0A>=20>=20>=20=20=20=20=20=20=20.parse_param=20=20=20=20=3D=
=20exfat_parse_param,=0D=0A>=20>=20>=20=20=20=20=20=20=20.get_tree=20=20=20=
=20=20=20=20=3D=20exfat_get_tree,=0D=0A>=20>=20>=20=20=20=20=20=20=20.free=
=20=20=20=20=20=20=20=20=20=20=20=3D=20exfat_free,=0D=0A>=20>=20>=20+=20=20=
=20=20=20.reconfigure=20=20=20=20=3D=20exfat_reconfigure,=0D=0A>=20>=20>=20=
=20=7D;=0D=0A>=20>=20>=0D=0A>=20>=20>=20=20static=20int=20exfat_init_fs_con=
text(struct=20fs_context=20*fc)=0D=0A>=20>=20>=20--=0D=0A>=20>=20>=202.17.1=
=0D=0A>=20>=0D=0A>=20>=0D=0A=0D=0A
