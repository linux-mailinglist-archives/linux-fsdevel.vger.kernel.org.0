Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4678FFDB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 06:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfKRFFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 00:05:24 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:38048 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfKRFFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 00:05:24 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191118050522epoutp011cf37a8c1e45dc406fcbae2821b50d41~YKVblxAbd1960019600epoutp01J
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2019 05:05:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191118050522epoutp011cf37a8c1e45dc406fcbae2821b50d41~YKVblxAbd1960019600epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574053523;
        bh=90XN/fh+rCaU/MawbzJrKX/j/w6gxQPViZ5zdqgY9T4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pt31RvPbxUzbkMetr3SiV7NPqH5ItjCS0gLVy3Hda+I/URKA7jHmg0sNw7su5JSB/
         Xr2MMH5cRzDWTTTXdtKOKD1zdoEEyrHMLezF9oS1cAbK8ShN0JoDGRNHOtdIjXrUO6
         xH5Q5rILIq4lxt0rQv7Lz7K764Tvp0wwGdcgiFRU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191118050522epcas1p3db7c50730bff7dcc3771810df782d641~YKVbV6YJj0306203062epcas1p3R;
        Mon, 18 Nov 2019 05:05:22 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47GcN20NQBzMqYkl; Mon, 18 Nov
        2019 05:05:22 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.F5.04237.19622DD5; Mon, 18 Nov 2019 14:05:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191118050521epcas1p15b04db4758f806cda3c826ca9b3f90f9~YKVaJvoM21371013710epcas1p1o;
        Mon, 18 Nov 2019 05:05:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191118050521epsmtrp2cef67b72a8716dffa50f6d5ba85cafed~YKVaG8uqV1065710657epsmtrp2C;
        Mon, 18 Nov 2019 05:05:21 +0000 (GMT)
X-AuditID: b6c32a39-913ff7000000108d-9f-5dd22691e409
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.C7.03654.19622DD5; Mon, 18 Nov 2019 14:05:21 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191118050521epsmtip23499ae1eee00efde746da7f619aab5a5~YKVZ7HFg-2708027080epsmtip2h;
        Mon, 18 Nov 2019 05:05:21 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Markus Elfring'" <Markus.Elfring@web.de>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        =?UTF-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@vt.edu>,
        <linkinjeon@gmail.com>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <bb89f610-3eac-6b28-1aff-265b358d22af@web.de>
Subject: RE: [PATCH 07/13] exfat: add bitmap operations
Date:   Mon, 18 Nov 2019 14:05:21 +0900
Message-ID: <00bd01d59dcd$c72058a0$556109e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJT34xI6Pyft9P4cwvm8O1PsyfppwNHvFQQAswP5mmmYz3KkA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0hTcRTmt7v7WLi4LauDhaxLBRabm2t6LY1exMKISUIRmN3cTa292J2v
        jFDMHiNKg14zyzKLHmjZcvYwaVa6oDC1LMWI6MUUy+xdWpvXyP++c873nXO+34PCFF4igsqy
        OnmHlTMzxARpfXOUSlU2pz1V8/S2hi2uqiXY8xfvSdhr3dPZrt5ujL3V6JeyHTeOE+wf9zuc
        9Yzcxdn2Dx+li2WG6+5e0tBUcYk03HxeSBj2ey4gw1BdpMHn7ScMPW/rpUZyvTkhk+dMvEPJ
        W9NtpixrRiKTtCZtWZo+VqNVaePZOEZp5Sx8IrN8lVG1Issc3IxR5nDm7GDKyAkCE70owWHL
        dvLKTJvgTGR4u8ls12rsaoGzCNnWDHW6zbJAq9HE6IPMjebM8l+3SftpPG9vdRteiA7gLiSj
        gJ4PbyoPIBeaQCnoBgRlrfUSMfiE4GhPESYGXxGUeq8EK9So5ErRZjHfiMD1eIAUgwCCWydO
        kqG+BK2Ckd9NRAiH02o42N+Mh0gY7ZfA16oWLFSQ0Qug5ulnFMKT6Th40/ZiVCylZ8PuzhZJ
        CMvpeBj8UUKIeBL4j72WhjBGz4Ozp/ow0YQSGh72IXHYUgh4r45xwqF8765RC0AXkzDseT1m
        YTl4WzWidjIEWjykiCNgaKCRECkFMNg01n4PgvffEkWsg+e1l/EQBaOjoPZGtJieCdd/VSBx
        6kQY+LIPF7vIYc8uhUiZDfvbmyUing6u3R/JUsS4x/lyj/PlHre/+/+wSiS9gKbydsGSwQta
        u378Xdeh0Uc7N74B3X+0yodoCjFh8pe5j1MVOJcj5Ft8CCiMCZevftWWqpCbuPxtvMOW5sg2
        84IP6YPHXoZFTEm3Bb+A1Zmm1cfodDp2fmxcrF7HTJNT34N96AzOyW/leTvv+KeTULKIQrTW
        c/PJtYBfIxk6EvUwkH+46n5nf8HxhbPWJRS7vnd1hl3a0KGNsp3Z2hHWl+wvvfNTrj4UaZIY
        jb0fkg/lLpHdO/fCM0O5uaKyPD/JmRed1NVa8XLkwXn/ueTt23M3Xd1Z2LclxVTiS1lXVzNT
        qMkpqh4OUzhXxuU9KylSN8Z0bdjBSIVMTjsXcwjcX0CvAFLKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSvO5EtUuxBqtaBC2aF69ns1i5+iiT
        xdZb0hbX795ittiz9ySLxeVdc9gs/s96zmqx5d8RVotL7z+wOHB67Jx1l91j/9w17B67bzaw
        efRtWcXo8XmTnMeh7W/YPG4/28YSwB7FZZOSmpNZllqkb5fAlTH76gb2giPMFde2vGRrYHzM
        1MXIwSEhYCKxsTGti5GTQ0hgN6NEz8Z0EFtCQFri2IkzzBAlwhKHDxd3MXIBlbxglPh/ZQ8L
        SA2bgK7Evz/72UBsEQE9iUlvDrOCFDELnGeSODzhIiPc0FcnFUBsTgEriXXXvoDFhQXMJZ5e
        uMcOYrMIqEq0XznOBGLzClhKfPzZygZhC0qcnPkEbBmzgLZE78NWRhh72cLXzBCHKkjsOPua
        EeIIJ4lX2zdD1YtIzO5sY57AKDwLyahZSEbNQjJqFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WK
        E3OLS/PS9ZLzczcxgiNOS3MH4+Ul8YcYBTgYlXh4LaouxgqxJpYVV+YeYpTgYFYS4fV7dCFW
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBsbqws/swYkt
        eQ0O1lazstw1FC2DAz98akpvCTbkZjOYuXJDw6yuywr7dUv3LODln/cqYfuvv1tkf0lOCTLr
        KSxX6pn/b/blxSWpOvkzY+vun78VdFnrtNXphnVrzqSu0s1bcih014vTjBoPyqflciiVpXHu
        2dvmUXZ3c62ciWCYts7xBSe5q5VYijMSDbWYi4oTAZpKF8m0AgAA
X-CMS-MailID: 20191118050521epcas1p15b04db4758f806cda3c826ca9b3f90f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191117150120epcas4p4c9229bc184f0a299f0c7215dd473ae0a
References: <20191113081800.7672-8-namjae.jeon@samsung.com>
        <CGME20191117150120epcas4p4c9229bc184f0a299f0c7215dd473ae0a@epcas4p4.samsung.com>
        <bb89f610-3eac-6b28-1aff-265b358d22af@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> =E2=80=A6=0D=0A>=20>=20+++=20b/fs/exfat/balloc.c=0D=0A>=20=E2=80=A6=0D=0A=
>=20+int=20exfat_count_used_clusters(struct=20super_block=20*sb,=20unsigned=
=20int=0D=0A>=20*ret_count)=0D=0A>=20+=7B=0D=0A>=20=E2=80=A6=0D=0A>=20+=09/=
*=20FIXME=20:=20abnormal=20bitmap=20count=20should=20be=20handled=20as=20mo=
re=20smart=20*/=0D=0A>=20+=09if=20(total_clus=20<=20count)=0D=0A>=20+=09=09=
count=20=3D=20total_clus;=0D=0A>=20=0D=0A>=20Would=20you=20like=20to=20impr=
ove=20any=20implementation=20details=20according=20to=20this=0D=0A>=20comme=
nt?=0D=0AYes,=20Will=20improve=20it=20on=20V2.=0D=0A=0D=0AThanks=21=0D=0A>=
=20=0D=0A>=20Regards,=0D=0A>=20Markus=0D=0A=0D=0A
