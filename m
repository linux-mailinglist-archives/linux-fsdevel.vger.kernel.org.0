Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D58105ED6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 04:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKVDA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 22:00:29 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:64249 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfKVDA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 22:00:29 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191122030026epoutp02fb0aadcb51ddac4a400e0e7bcc23dfb1~ZXNfAJBKB2604926049epoutp02c
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2019 03:00:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191122030026epoutp02fb0aadcb51ddac4a400e0e7bcc23dfb1~ZXNfAJBKB2604926049epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574391626;
        bh=jR9JDOrzxDxFjd+KH+FnSxCDcPOdDJG/HnjXXkic4t8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=D4hMWuJQ631TjJVRG9xzpgbMUNFWuGkp9SHkikiX9l37rPlYvg0ydCmp5L6KpZwiJ
         3UkYnPwVolY+sLLe6yTm3Rkt6MeuTHBYnJr8lL4d5vvJCt1VjKJ8tHQ08hsfQRXOl2
         pOL3LvbfVjz+nBQxw2LbsJVKiUMWeOmL5UBP4juc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191122030020epcas1p4375d4ec1b17cbe32a4ce3d5fe00f6b11~ZXNY-2wO-2233022330epcas1p4_;
        Fri, 22 Nov 2019 03:00:20 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47K1Pv2krWzMqYkb; Fri, 22 Nov
        2019 03:00:19 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.5C.04406.34F47DD5; Fri, 22 Nov 2019 12:00:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191122030016epcas1p13fc5d28cd56527a4d760758bae1b9e3e~ZXNWHlHxL2551125511epcas1p1D;
        Fri, 22 Nov 2019 03:00:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191122030016epsmtrp13607f69341bf4b7660a0b7716ca92a3d~ZXNWG6hnj2174221742epsmtrp1I;
        Fri, 22 Nov 2019 03:00:16 +0000 (GMT)
X-AuditID: b6c32a38-947ff70000001136-b2-5dd74f4389fd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.CB.03814.04F47DD5; Fri, 22 Nov 2019 12:00:16 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191122030016epsmtip15f756ff689bf918de48b6844e2131c92~ZXNV41NIx2923129231epsmtip1j;
        Fri, 22 Nov 2019 03:00:16 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Markus Elfring'" <Markus.Elfring@web.de>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Daniel Wagner'" <dwagner@suse.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Nikolay Borisov'" <nborisov@suse.com>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        =?UTF-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@vt.edu>,
        <linkinjeon@gmail.com>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <498a958f-9066-09c6-7240-114234965c1a@web.de>
Subject: RE: [PATCH v4 04/13] exfat: add directory operations
Date:   Fri, 22 Nov 2019 12:00:16 +0900
Message-ID: <004901d5a0e0$f7bf1030$e73d3090$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGvn6iTTExTp6OkCy7f8aJjab+B9AHpvZ4UAavVuMIBPbFUKae75+zw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmga6z//VYgxMtIhaHH09it2hevJ7N
        YuXqo0wWW29JW1y/e4vZYs/ekywWl3fNYbP4P+s5q8X/Ny0sFlv+HWG1uPT+A4sDt8fOWXfZ
        PfbPXcPusftmA5tH35ZVjB7rt1xl8dh8utrj8yY5j0Pb37B53H62jSWAMyrHJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoWCWFssScUqBQQGJxsZK+
        nU1RfmlJqkJGfnGJrVJqQUpOgaFBgV5xYm5xaV66XnJ+rpWhgYGRKVBlQk7G6tM/2Au+sVfs
        P3iQsYHxJnsXIyeHhICJxMTTU4BsLg4hgR2MEmfOXmCFcD4xSkx8fYIRwvnGKLHv7VxWmJZv
        ezYxQST2MkpsuHwGqv8Vo8Spj6uZQKrYBHQl/v3ZzwZiiwjoSUx6cxhsLrPATGaJIy/PsoAk
        OAWsJI68PwvUwMEhLGArsacjDCTMIqAq8frebmYQm1fAUuJx910oW1Di5MwnYK3MAtoSyxa+
        Zoa4SEFix9nXjBC73CRO9F5gg6gRkZjd2QZVs4xdYuYjfwjbRWLfpf9Q3whLvDq+BRoYUhIv
        +9vYQc6REKiW+LgfqrWDUeLFd1sI21ji5voNrCAlzAKaEut36UOEFSV2/p7LCLGVT+Ld1x5W
        iCm8Eh1tQhAlqhJ9lw4zQdjSEl3tH9gnMCrNQvLXLCR/zUJy/yyEZQsYWVYxiqUWFOempxYb
        Fpggx/UmRnA61rLYwbjnnM8hRgEORiUe3gnl12KFWBPLiitzDzFKcDArifDuuX4lVog3JbGy
        KrUoP76oNCe1+BCjKTDYJzJLiSbnA3NFXkm8oamRsbGxhYmZuZmpsZI4L8ePi7FCAumJJanZ
        qakFqUUwfUwcnFINjLsPhx3VZHnX4hJ/ZfXjqWcWdBsvuiVxmks3f7LKmhXnDaXsDpVlKyxU
        rH399ubKx48SK/asPh89f+Kd0iKGDTfPtrV7v7De32ixeMlD095JGjk2T95M1nxSU8Ewr+Tw
        gye3/7VvqpZ1tpCZFf3nb8iCcvcl/7YHll6pV3zvKz+vqSPdXmcZ83YlluKMREMt5qLiRAAe
        1t2x3QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSnK6D//VYg/+HjC0OP57EbtG8eD2b
        xcrVR5kstt6Strh+9xazxZ69J1ksLu+aw2bxf9ZzVov/b1pYLLb8O8Jqcen9BxYHbo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD3Wb7nK4rH5dLXH501yHoe2v2HzuP1sG0sAZxSXTUpqTmZZapG+
        XQJXRtPj50wF31gq5h04zNzAeJS5i5GTQ0LAROLbnk1MXYxcHEICuxklLrfugEpISxw7cQbI
        5gCyhSUOHy6GqHnBKNF7/D0jSA2bgK7Evz/72UBsEQE9iUlvDrOCFDELLGSWODdnAiNEx1tG
        iaNtu1hAqjgFrCSOvD/LBDJVWMBWYk9HGEiYRUBV4vW93WCLeQUsJR5334WyBSVOznwC1sos
        oC3R+7CVEcZetvA11KEKEjvOvmaEOMJN4kTvBTaIGhGJ2Z1tzBMYhWchGTULyahZSEbNQtKy
        gJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcGxqae1gPHEi/hCjAAejEg/vhPJr
        sUKsiWXFlbmHGCU4mJVEePdcvxIrxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6Yklq
        dmpqQWoRTJaJg1OqgbH+koXwe9HsVUc+rlxW7iX/uzv85/qHPGqJshMbK1uqlrZoNM3yruNt
        7TTYuVYtsH5NUYJl5od7TueFNu2sDpaYd/tdmOwdyRXHvv73M+CouLE3dUZw45aV9Zs5Zsyq
        3fPu5bQbcXN7Mh6uyP65MeLfz0Id30cbueae1PA5dMbZXDd7d8DSlw5KLMUZiYZazEXFiQBG
        0Cl6yQIAAA==
X-CMS-MailID: 20191122030016epcas1p13fc5d28cd56527a4d760758bae1b9e3e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191121052917epcas1p259b8cb61ab86975cabc0cf4815a8dc38
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
        <CGME20191121052917epcas1p259b8cb61ab86975cabc0cf4815a8dc38@epcas1p2.samsung.com>
        <20191121052618.31117-5-namjae.jeon@samsung.com>
        <498a958f-9066-09c6-7240-114234965c1a@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>=20
> =E2=80=A6=0D=0A>=20>=20+++=20b/fs/exfat/dir.c=0D=0A>=20=E2=80=A6=0D=0A>=
=20>=20+static=20int=20exfat_readdir(struct=20inode=20*inode,=20struct=20ex=
fat_dir_entry=0D=0A>=20*dir_entry)=0D=0A>=20>=20+=7B=0D=0A>=20=E2=80=A6=0D=
=0A>=20>=20+=09=09=09if=20(=21ep)=20=7B=0D=0A>=20>=20+=09=09=09=09ret=20=3D=
=20-EIO;=0D=0A>=20>=20+=09=09=09=09goto=20free_clu;=0D=0A>=20>=20+=09=09=09=
=7D=0D=0A>=20=0D=0A>=20How=20do=20you=20think=20about=20to=20move=20a=20bit=
=20of=20common=20exception=20handling=20code=0D=0A>=20(at=20similar=20place=
s)?=0D=0ANot=20sure=20it=20is=20good.=20Other=20review=20comments=20are=20o=
kay.=20Will=20fix=20them=20on=20v5.=0D=0A>=20=0D=0A>=20+=09=09=09if=20(=21e=
p)=0D=0A>=20+=09=09=09=09goto=20e_io;=0D=0A>=20=0D=0A>=20=0D=0A>=20=E2=80=
=A6=0D=0A>=20>=20+free_clu:=0D=0A>=20>=20+=09kfree(clu);=0D=0A>=20>=20+=09r=
eturn=20ret;=0D=0A>=20=0D=0A>=20+=0D=0A>=20+e_io:=0D=0A>=20+=09ret=20=3D=20=
-EIO;=0D=0A>=20+=09goto=20free_clu;=0D=0A>=20=0D=0A>=20>=20+=7D=0D=0A=0D=0A
