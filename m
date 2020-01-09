Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1EF21363E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 00:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgAIXgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 18:36:47 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:54108 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbgAIXgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:36:47 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200109233644epoutp04a3534f16793c06713c0ad5f3800f4fa2~oXCnUurJX3236932369epoutp04T
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2020 23:36:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200109233644epoutp04a3534f16793c06713c0ad5f3800f4fa2~oXCnUurJX3236932369epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578613004;
        bh=WiKz/Fx6wAw2jEhCCjWyRhWqfPx9MgmbZWS9fsOk5dc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Fla/iTcEEQvnl4PzH055NEk8F5qacNDsHOwP2Qj9YFtFz5qxLyWLk9mfK7YS0OUJi
         evf5HLLOAWMWjZ340+fgo8+74i69QXo16jenpJAd6JCICOf7iw4y/5NybnS3LxeRyY
         oq+3n7d1NpY7KdpddQXvStc0UJniVIaD5WbFdLJg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200109233643epcas1p30d2b0803d2d56b112432a4ba9cccb409~oXCm7bWxw0751607516epcas1p3k;
        Thu,  9 Jan 2020 23:36:43 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47v2ZL4j3XzMqYm0; Thu,  9 Jan
        2020 23:36:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.1D.52419.A09B71E5; Fri, 10 Jan 2020 08:36:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200109233642epcas1p4561e344300482cc472a3d4d0171b548a~oXCllQuVR2080120801epcas1p4N;
        Thu,  9 Jan 2020 23:36:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109233642epsmtrp1047e920b3fde36def05112c30169adc7~oXClkeygN2101021010epsmtrp1d;
        Thu,  9 Jan 2020 23:36:42 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-55-5e17b90adba2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.D6.10238.A09B71E5; Fri, 10 Jan 2020 08:36:42 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200109233641epsmtip27e654c8c40a9b395ad6cb6e032cdeab7~oXClVahlk1016610166epsmtip2f;
        Thu,  9 Jan 2020 23:36:41 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Arnd Bergmann'" <arnd@arndb.de>
Cc:     <linux-kernel@vger.kernel.org>,
        "'Linux FS-devel Mailing List'" <linux-fsdevel@vger.kernel.org>,
        "'gregkh'" <gregkh@linuxfoundation.org>,
        "'Valdis Kletnieks'" <valdis.kletnieks@vt.edu>,
        "'Christoph Hellwig'" <hch@lst.de>, <sj1557.seo@samsung.com>,
        <linkinjeon@gmail.com>
In-Reply-To: <CAK8P3a1wcrKzhhODwoQTu=WHorkd+dQThk+G9w77QSgJ=LnR4A@mail.gmail.com>
Subject: RE: [PATCH v8 02/13] exfat: add super block operations
Date:   Fri, 10 Jan 2020 08:36:41 +0900
Message-ID: <002001d5c745$a57b4dd0$f071e970$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEpoQLVeCzgpkP5O8EfgqcyF1wLQwHsN8nXAH0AW2oCoNSnnqkS+JFw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01TWUwTYRDO393uLkjJUhAmKFpX0aBWW2phMdaLaqrwgNEnE8ENbCixl92W
        iLwQTCrihb5QqxCkRgVMiooIHkFaj5goCjwoJBov4gFq8bYoWroYeftm5vvmm/kPCpNfIpKp
        EouDt1s4E0NE4+2BNKUyujMpX+Vrmsf+PnqbZPd4fQTb1HJLwj56Moix167fxdn+KycItm38
        ppTt+xjEV1OGsdBRZOj0PCENXXXnSMPVgQrCcKitGRk+X5hl8F8eIfLIraYVRp4r4u0K3lJo
        LSqxFOuYnM0F2QXaDJVaqc5iMxmFhTPzOkafm6dcX2IKT8UoSjmTM5zK4wSBWbpyhd3qdPAK
        o1Vw6BjeVmSyqVW2JQJnFpyW4iWFVvNytUqVrg0zt5uMtcEqwlYZs+vL+XGyAh2kqlEUBfQy
        GAndwKpRNCWnOxCcdPdLxeATgobX7RIx+Iagzu0m/knaa/aSYuE6gqrmU0gM3iIYcgXwCRZB
        K2H8V1dEkUCnwrtXVyMKjHZLoG6kMVKIojfBse4OcgLH06ug9eFFyQTGw4IXTf2RvIzOgh+h
        50jEcXD32KuIAUYvgtMnhzFxJAX8HDotFc3WQ+8ZLyZyEuD4PldkO6D/EDAUGJSIAj00jjaS
        Io6Hd3faJnEyvD3sCmMqjMthtGuyfxWCN991ItbAgK9VOkHB6DTwXVkqpudA51gdEm1j4cPX
        A1KxiwyqXHKRkgqH+gKTA8yA6r1BsgYxnimLeaYs5pmygOe/WQPCm1EibxPMxbygtmmm3vYF
        FHmyCzM7UGtPrh/RFGJiZMb4pHy5lCsVysx+BBTGJMhuPU7Ml8uKuLLdvN1aYHeaeMGPtOFz
        P4IlTy+0hj+AxVGg1qZrNBp2WUZmhlbDJMmoH73b5HQx5+B38LyNt//TSaio5AqUcur7/viz
        H7xpoffndjXqhL4tZfO5dYm9NzMWeFY/SJc/+Joq5LzMhIHD2Sk7E5wBv7He9dFlGH4a2uBu
        W1Ne02OZ+2mxwzujB/c9q10czKG7p92nK5+RM9/fG+69w/pb9Ce64wZrY7yV23NLg5dnF9YL
        m16O8rGz8ZKNsWv36xlcMHLqhZhd4P4CSsQUMMgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSvC7XTvE4g+lH2C3+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWWz5d4TV4tL7DywOHB6/f01i9Ng56y67x/65a9g9dt9s
        YPPo27KK0ePzJjmPQ9vfsAWwR3HZpKTmZJalFunbJXBl3Ho+ibHgPnfFhdvzmBoYn7B3MXJy
        SAiYSGyb0A5kc3EICexmlNj2Yh0zREJa4tiJM0A2B5AtLHH4cDFEzXNGiSvNL8Bq2AR0Jf79
        2c8GYosIqEq8erIbbBCzwDwmiakrF7NAdLQwSay4uJoRpIpTIFBi5sEdYKuFBewlNlzYzARi
        swB1P1p5GSzOK2Ap8ePXQ0YIW1Di5MwnLCA2s4C2xNObT+HsZQtfQ12qIPHz6TJWiCvcJC4u
        X8wMUSMiMbuzjXkCo/AsJKNmIRk1C8moWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L
        10vOz93ECI43Lc0djJeXxB9iFOBgVOLhzRAWjxNiTSwrrsw9xCjBwawkwnv0hlicEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYyJVz4WTE/P+21UMumS
        Yh4L+9kLHCvvL+udf6tIyib6x+LisMy3DPen68dyr1HZICJVZl/8or5znvMdRQn+g67/9xhy
        /d71x/OTAMeTrfOvibYXuVW8MlKf2Pg84rWr0qm+mdYmix6JqdSs/16Xdfv+m7Mm+t3rXmtd
        uPMkIKMuJFGzNNV7v6QSS3FGoqEWc1FxIgA0uLVmswIAAA==
X-CMS-MailID: 20200109233642epcas1p4561e344300482cc472a3d4d0171b548a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73
References: <CGME20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73@epcas1p3.samsung.com>
        <20191220062419.23516-1-namjae.jeon@samsung.com>
        <20191220062419.23516-3-namjae.jeon@samsung.com>
        <CAK8P3a1wcrKzhhODwoQTu=WHorkd+dQThk+G9w77QSgJ=LnR4A@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +static int exfat_fill_super(struct super_block *sb, struct fs_context
> > +*fc) =7B
> > +       struct exfat_sb_info *sbi =3D sb->s_fs_info;
> > +       struct exfat_mount_options *opts =3D &sbi->options;
> > +       struct inode *root_inode;
> > +       int err;
> > +
> > +       if (opts->allow_utime =3D=3D (unsigned short)-1)
> > +               opts->allow_utime =3D =7Eopts->fs_dmask & 0022;
> > +
> > +       if (opts->utf8 && strcmp(opts->iocharset,
> exfat_iocharset_with_utf8)) =7B
> > +               exfat_msg(sb, KERN_WARNING,
> > +                       =22utf8 enabled, =5C=22iocharset=3D%s=5C=22 is =
recommended=22,
> > +                       exfat_iocharset_with_utf8);
> > +       =7D
> > +
> > +       if (opts->discard) =7B
> > +               struct request_queue *q =3D bdev_get_queue(sb->s_bdev);
> > +
> > +               if (=21blk_queue_discard(q))
> > +                       exfat_msg(sb, KERN_WARNING,
> > +                               =22mounting with =5C=22discard=5C=22 op=
tion, but the
> device does not support discard=22);
> > +               opts->discard =3D 0;
> > +       =7D
> > +
> > +       sb->s_flags =7C=3D SB_NODIRATIME;
> > +       sb->s_magic =3D EXFAT_SUPER_MAGIC;
> > +       sb->s_op =3D &exfat_sops;
>=20
> I don't see you set up s_time_gran, s_time_min and s_time_max anywhere.
> Please fill those to get the correct behavior. That also lets you drop th=
e
> manual truncation of the values.
Okay=21

Thanks=21
>=20
>        Arnd

