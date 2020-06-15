Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D24C1F8C61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 04:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgFOC74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jun 2020 22:59:56 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:25326 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgFOC7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jun 2020 22:59:55 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200615025953epoutp01898d960236b99a9a57112c63b9dbf3f9~YmFz4UrBv2301623016epoutp01B
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 02:59:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200615025953epoutp01898d960236b99a9a57112c63b9dbf3f9~YmFz4UrBv2301623016epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592189993;
        bh=eGGelpkcY/LO3yX2Zejg2CnNM824qHYvkp0EHrxeMPg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=aEchWPuJ9kL4g8lMN0ordCsbE+rpPCNaW1/47iHuPuKLS9vCzimptTDUQRG/lJZpO
         TNUFvE8zBh8S9/HwRJDZcKdLH+rf6mr3XYei6ls40xMKVbOyZS137m7G893KImeSx8
         +TkIUu1eMq1hUQUIQ7pzr+Y8SiHvyownKLPgIRD0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200615025953epcas1p48085be4f20302114c59c606082fbb8b2~YmFzlsaWR0840308403epcas1p4w;
        Mon, 15 Jun 2020 02:59:53 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49lbfJ0ldszMqYkf; Mon, 15 Jun
        2020 02:59:52 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.C8.28581.824E6EE5; Mon, 15 Jun 2020 11:59:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200615025951epcas1p4d8ea0dddac1fe76435ef087df930d6c9~YmFyM1tuS0840308403epcas1p4q;
        Mon, 15 Jun 2020 02:59:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200615025951epsmtrp291445e1aa67729783a1a991f40e7f5a6~YmFyMKMTC1711917119epsmtrp27;
        Mon, 15 Jun 2020 02:59:51 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-49-5ee6e4278b9b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.46.08303.724E6EE5; Mon, 15 Jun 2020 11:59:51 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200615025951epsmtip23bf3d4e3c4062ec38e2c467a6d4643ed~YmFyCcNV-2436324363epsmtip2w;
        Mon, 15 Jun 2020 02:59:51 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <b29d254b-212a-bfcb-ab7c-456f481b85c8@gmail.com>
Subject: RE: [PATCH] exfat: remove EXFAT_SB_DIRTY flag
Date:   Mon, 15 Jun 2020 11:59:51 +0900
Message-ID: <237301d642c1$09b77e30$1d267a90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJnvEdqdI23glRQ63sAxRdAmHabxwH6sMC1AgRQa20BQ3jTmaeL6gYg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmnq7Gk2dxBp0HmC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi8qxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2Vo
        YGBkClSZkJPxtUW84Kx0xf29L9gbGM+KdzFyckgImEhc6DjO2sXIxSEksINR4uSBKywQzidG
        id7HS6Ccz4wSk3d0MMO0LJ77mw0isYtR4sCaa1DOS0aJ6y9PsYBUsQnoSjy58ROsQ0RAT+Lk
        yetsIDazQCOTxImX2SA2p4CtxKkpa8BqhAXMJJZ27QXrZRFQlfi8po8dxOYVsJR4O/8+M4Qt
        KHFy5hMWiDnaEssWvoa6SEFi96ejQE9wAO1ykzg6KwmiRERidmcbVMlcDoln01MgbBeJq39/
        sUPYwhKvjm+BsqUkPr/bywZh10vsXnUK7HsJgQZGiSOPFrJAJIwl5rcsZAbZxSygKbF+lz5E
        WFFi5++5jBB7+STefe0BO0dCgFeio00IokRF4vuHnSwwq678uMo0gVFpFpLHZiF5bBaSD2Yh
        LFvAyLKKUSy1oDg3PbXYsMAEOa43MYJTqZbFDsa5bz/oHWJk4mA8xCjBwawkwtud9iROiDcl
        sbIqtSg/vqg0J7X4EKMpMKgnMkuJJucDk3leSbyhqZGxsbGFiZm5mamxkjjvSasLcUIC6Ykl
        qdmpqQWpRTB9TBycUg1M0sGtzYs+Bsg8a5Ar7rG9cWJJVYNwhcjak3xWS8yTt965Vm8zt7so
        /13f1Si3CUXKtgYph4PrQ1as/OhtwS3ovnlf+b2TK85J5Mp/uMqR9m22s3XVn4+zf1lL+90x
        tS3y+6rqvYiP827uOksv6/k6brG3S91f8xyJcTur++6OtUPDoaW+odufXY7LCStxbJ9cvnKH
        XttENb5a38I+Ke0DZ/96Xmu6FialYqnT6LTn2vInDmfl/6xwubL559nNa9NePk3/wps577IP
        a9I89uvVwWK+lvn/uR7qr2BpVBILvCRiNLeAnXOB5+v5F60/XvAuDvo53f/n9mLvxlU8xw50
        HQxduDOoy+f/w/+vZP4osRRnJBpqMRcVJwIA/c+LWC4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXlf9ybM4g73XZSx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi+KySUnNySxLLdK3S+DKmPxyG1tBs0TF5uPtrA2M14S6GDk5JARMJBbP/c3WxcjF
        ISSwg1FiY9sG9i5GDqCElMTBfZoQprDE4cPFECXPGSXOHb7ACNLLJqAr8eTGT2YQW0RAT+Lk
        yetgc5gFmpkkWr80M0F0vGSUaHu6kw2kilPAVuLUlDVgHcICZhJLu/aygNgsAqoSn9f0sYPY
        vAKWEm/n32eGsAUlTs58AlbDLKAt0fuwlRHGXrbwNTPEBwoSuz8dZQW5VETATeLorCSIEhGJ
        2Z1tzBMYhWchmTQLyaRZSCbNQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZG
        cFRpae1g3LPqg94hRiYOxkOMEhzMSiK83WlP4oR4UxIrq1KL8uOLSnNSiw8xSnOwKInzfp21
        ME5IID2xJDU7NbUgtQgmy8TBKdXAlHgjwE+uLKtt4QZrztPVpQ5eWQ5JypusP0R/V75e2P2w
        4AjDv+7Jwidfp7xvWVsfdH79jgVeAUVxe3o4rn6pazuQdtrvgrF4gJ2gUW5on3R7xIbZM3ft
        snwWtYPhZKTU/YfvqjWaBbzvr5vavNSyt7LayPjwpjNXgyKnWSgev6i6VsLWd/PrG+elSwpk
        xU8LbjuRbzjffe15nndLHnzz4VaOf1GxLnXGBN/qUGvp62lWyz5ePFf7tbE/0Nd2t3PFwV0y
        3Ck/VmzXES3kOT95u+mq19FShoemdhe6Li/fJu3PwzRDwYSFo78l6cLKhKV9GgK8h2/PUTav
        iJcQvL77Y1hf7g2/9L810597azApsRRnJBpqMRcVJwIAkIo1OxkDAAA=
X-CMS-MailID: 20200615025951epcas1p4d8ea0dddac1fe76435ef087df930d6c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200612012902epcas1p4194d6fa3b3f7c46a8becb9bb6ce23d56
References: <CGME20200612012902epcas1p4194d6fa3b3f7c46a8becb9bb6ce23d56@epcas1p4.samsung.com>
        <20200612012834.13503-1-kohada.t2@gmail.com>
        <219a01d64094$5418d7a0$fc4a86e0$@samsung.com>
        <b29d254b-212a-bfcb-ab7c-456f481b85c8@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 2020/06/12 17:34, Sungjong Seo wrote:
> >> remove EXFAT_SB_DIRTY flag and related codes.
> >>
> >> This flag is set/reset in exfat_put_super()/exfat_sync_fs() to avoid
> >> sync_blockdev().
> >> However ...
> >> - exfat_put_super():
> >> Before calling this, the VFS has already called sync_filesystem(), so
> >> sync is never performed here.
> >> - exfat_sync_fs():
> >> After calling this, the VFS calls sync_blockdev(), so, it is
> >> meaningless to check EXFAT_SB_DIRTY or to bypass sync_blockdev() here.
> >> Not only that, but in some cases can't clear VOL_DIRTY.
> >> ex:
> >> VOL_DIRTY is set when rmdir starts, but when non-empty-dir is
> >> detected, return error without setting EXFAT_SB_DIRTY.
> >> If performe 'sync' in this state, VOL_DIRTY will not be cleared.
> >>
> >> Remove the EXFAT_SB_DIRTY check to ensure synchronization.
> >> And, remove the code related to the flag.
> >>
> >> Signed-off-by: Tetsuhiro Kohada <kohada.t2=40gmail.com>
> >> ---
> >>   fs/exfat/balloc.c   =7C  4 ++--
> >>   fs/exfat/dir.c      =7C 16 ++++++++--------
> >>   fs/exfat/exfat_fs.h =7C  5 +----
> >>   fs/exfat/fatent.c   =7C  7 ++-----
> >>   fs/exfat/misc.c     =7C  3 +--
> >>   fs/exfat/namei.c    =7C 12 ++++++------
> >>   fs/exfat/super.c    =7C 11 +++--------
> >>   7 files changed, 23 insertions(+), 35 deletions(-)
> >>
> > =5Bsnip=5D
> >>
> >> =40=40 -62,11 +59,9 =40=40 static int exfat_sync_fs(struct super_block=
 *sb,
> >> int
> >> wait)
> >>
> >>   	/* If there are some dirty buffers in the bdev inode */
> >>   	mutex_lock(&sbi->s_lock);
> >> -	if (test_and_clear_bit(EXFAT_SB_DIRTY, &sbi->s_state)) =7B
> >> -		sync_blockdev(sb->s_bdev);
> >> -		if (exfat_set_vol_flags(sb, VOL_CLEAN))
> >> -			err =3D -EIO;
> >> -	=7D
> >
> > I looked through most codes related to EXFAT_SB_DIRTY and VOL_DIRTY.
> > And your approach looks good because all of them seem to be protected
> > by s_lock.
> >
> > BTW, as you know, sync_filesystem() calls sync_fs() with 'nowait'
> > first, and then calls it again with 'wait' twice. No need to sync with
> lock twice.
> > If so, isn't it okay to do nothing when wait is 0?
>=20
> I also think  =E2=80=98do=20nothing=20when=20wait=20is=200=E2=80=99=20as=
=20you=20say,=20but=20I'm=20still=20not=0D=0A>=20sure.=0D=0A>=20=0D=0A>=20S=
ome=20other=20Filesystems=20do=20nothing=20with=20nowait=20and=20just=20ret=
urn.=0D=0A>=20However,=20a=20few=20Filesystems=20always=20perform=20sync.=
=0D=0A>=20=0D=0A>=20sync_blockdev()=20waits=20for=20completion,=20so=20it=
=20may=20be=20inappropriate=20to=20call=0D=0A>=20with=20=20nowait.=20(But=
=20it=20was=20called=20in=20the=20original=20code)=0D=0A>=20=0D=0A>=20I'm=
=20still=20not=20sure,=20so=20I=20excluded=20it=20in=20this=20patch.=0D=0A>=
=20Is=20it=20okay=20to=20include=20it?=0D=0A>=20=0D=0A=0D=0AYes,=20I=20thin=
k=20so.=20sync_filesystem()=20will=20call=20__sync_blockdev()=20without=20'=
wait'=20first.=0D=0ASo,=20it's=20enough=20to=20call=20sync_blockdev()=20wit=
h=20s_lock=20just=20one=20time.=0D=0A=0D=0A>=20=0D=0A>=20>>=20+=09sync_bloc=
kdev(sb->s_bdev);=0D=0A>=20>>=20+=09if=20(exfat_set_vol_flags(sb,=20VOL_CLE=
AN))=0D=0A>=20>>=20+=09=09err=20=3D=20-EIO;=0D=0A>=20>>=20=20=20=09mutex_un=
lock(&sbi->s_lock);=0D=0A>=20>>=20=20=20=09return=20err;=0D=0A>=20>>=20=20=
=20=7D=0D=0A>=20>>=20--=0D=0A>=20>>=202.25.1=0D=0A>=20>=0D=0A>=20>=0D=0A>=
=20=0D=0A>=20BR=0D=0A>=20---=0D=0A>=20Tetsuhiro=20Kohada=20<kohada.t2=40gma=
il.com>=0D=0A=0D=0A=0D=0A
