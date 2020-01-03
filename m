Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70EC612F3DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 05:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgACEos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 23:44:48 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:38541 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgACEos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 23:44:48 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200103044445epoutp017ddd77d3f6162a58ac1e16f5f878767e~mRujMizt-0533805338epoutp015
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jan 2020 04:44:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200103044445epoutp017ddd77d3f6162a58ac1e16f5f878767e~mRujMizt-0533805338epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578026685;
        bh=75O1crx9PoInAEcmq7qeyy4qEeoh27i5ezfCPmh3QS0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=CGpLkRlZC637fHfIxA1qO+hDY3IB80htmkPvWRTzz4D6JoY05wNh1jRDCp7F4EybK
         perfoksCSiAweg73MyUORrO9sOuTEBvTJdM2IUdZ+dRZkCRRulGL4/ParRgYDyJCND
         9eYLtU2N9Y8iviqeZ/LwN56uPpkK3OY6tctryN6E=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200103044444epcas1p302c57170b718d59bdb6d93e3ecd4a39c~mRuia8xU50196101961epcas1p3w;
        Fri,  3 Jan 2020 04:44:44 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47pskz2TFhzMqYkh; Fri,  3 Jan
        2020 04:44:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.CD.48019.BB6CE0E5; Fri,  3 Jan 2020 13:44:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200103044442epcas1p219334c376ffea9a151f3f5390f7d205c~mRuhDoG-e2124721247epcas1p2Z;
        Fri,  3 Jan 2020 04:44:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200103044442epsmtrp2fff97365cdd2ebfe349971e5bd392087~mRuhC95pm2213822138epsmtrp2R;
        Fri,  3 Jan 2020 04:44:42 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-44-5e0ec6bbc664
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.7A.06569.AB6CE0E5; Fri,  3 Jan 2020 13:44:42 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200103044442epsmtip18d906b74a0a6f924d702497289459fcc~mRug4b_oU2067520675epsmtip1B;
        Fri,  3 Jan 2020 04:44:42 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     =?UTF-8?Q?'Pali_Roh=C3=A1r'?= <pali.rohar@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <hch@lst.de>, <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>
In-Reply-To: <20200102142026.wb5glvnf5c7uweed@pali>
Subject: RE: [PATCH v9 10/13] exfat: add nls operations
Date:   Fri, 3 Jan 2020 13:44:42 +0900
Message-ID: <002801d5c1f0$83ef7d80$8bce7880$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJSGi/S1M7UFBjz5N3SW71o+eawLwHz+Lr1AtmMBwQCdCwXw6alnvnA
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN60yng1J8FpBrjaZONMYFaS2FgYga16okYoy4RKljmUBjl0mn
        4PZTYxSoBqmJGqpERSGxElGCCyKiuIsxURTjUsHEDSW4VECCMbYdjfyde94579z73qUJVQ2l
        pi12F++0c1aGGkZeuDFZm9h4OyZH27Mnht15opZiT52+JWOfBV4Q7JWmeyTbdvkIxXpbB2Vs
        /e+bcvbxl6/kHNrY4AsojM0VNQpj43M3ZSyt9yNjsG6cseViN5VFrbXOzOe5XN6p4e1mR67F
        npfBLF1hmmcypGh1ibo0NpXR2Dkbn8HMz8xKXGixhhpiNIWctSBEZXGiyCTNmul0FLh4Tb5D
        dGUwvJBrFXRaYbrI2cQCe950s8OWrtNqZxhCyg3W/MrWY0joGLHl7tWTpBv1RXtQFA04GXZ8
        ekl60DBahS8h2NvlQ1LxHcHV29/lUtGHoMzfrvhn+XywRB7GKtyE4O7+dEnUFbKfq5GFDyic
        CL9/NVMeRNNxmIWju/RhDYGvIXhz5lzEHIX1EDjQFtHH4lTorgpEAkg8Ae6//xHBSpwGg41u
        UsIj4V752wgm8FSoPv6ZkBrSwMC7arnEx8Hhkt2ElLsQdj6VhXMBByk4v79fEeYBz4fyjm2S
        NRY+3an/O5cagj1NlCTZDt+a/95ejOBjf4aE9fC89qw8LCHwZKi9nCTR46FhsAJJDcRAT+9e
        uXSLEop3qyTJRCh9fEMm4THgKfqqKEOMb8hYviFj+YaM4vsfdgyRfjSKF0RbHi/qhOShP12H
        Ips6hb2ErjzMbEGYRky0sqxdmaOSc4XiVlsLAppg4pSbl4coZS63dRvvdJicBVZebEGG0Kt7
        CXW82RHae7vLpDPM0Ov1bHJKaopBzyQo6Z+P1qtwHufiN/G8wDv/+WR0lNqNFrmrd6V4YxNK
        Ozuzr38Y3ds5sLohdlqrQKztyV78I6d7zcaSw5nO2cssXSM0ya3tdIfag194X7WJhQFddP++
        J6/8xNxxj4oG0rK9CnOdNcm8clJweIchQfO6Nz5YTBxYtyBd/2vJKcuDdxVVO+Itk/xFi88L
        3vIJfaayQ2MrV/kZUszndFMIp8j9AbVONYe/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnO6uY3xxBgtn6Fg0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBYTT/9mstjy7wirxaX3H1gcODx2zrrL7rF/7hp2j903G9g8+ras
        YvT4vEnO49D2N2wBbFFcNimpOZllqUX6dglcGTMPPmYuWMxfsfDcRdYGxo08XYycHBICJhKv
        p3WydjFycQgJ7GaUmPJsETNEQlri2IkzQDYHkC0scfhwMUTNc0aJS+tmMoLUsAnoSvz7s58N
        pEZEwEJifqsxSA2zwAlGiTP9t1hBasAaJt52BrE5BYwl7k69zARiCwuYS7xZepcdxGYRUJE4
        9ewLmM0rYCnxe3cDC4QtKHFy5hMwm1lAW6L3YSsjjL1s4WuoOxUkfj5dxgoRF5GY3dnGDHGP
        m0TzVaYJjMKzkEyahWTSLCSTZiHpXsDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cT
        Izi+tLR2MJ44EX+IUYCDUYmHd8I13jgh1sSy4srcQ4wSHMxKIrzlgUAh3pTEyqrUovz4otKc
        1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjN5swkfCW9mPL+dRknaInCLO0Vwy
        /1fU/Cde89Yw7IrefoDLpr3k029bBb63z1ZWL5xoHN/qPb/B+vmZhVHmaxRZtJdlFiXNOtz8
        b7nq6mluybqyXDxKyj1NTAd2fhaU2BzLuGSVcuonTbNNOQ/2Lt7hpZZwwOX4ldIOdn3rAO7/
        x6p9qm5XKbEUZyQaajEXFScCAKtxTRerAgAA
X-CMS-MailID: 20200103044442epcas1p219334c376ffea9a151f3f5390f7d205c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com>
        <20200102082036.29643-11-namjae.jeon@samsung.com>
        <20200102142026.wb5glvnf5c7uweed@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thursday 02 January 2020 16:20:33 Namjae Jeon wrote:
> > This adds the implementation of nls operations for exfat.
> >
> > Signed-off-by: Namjae Jeon <namjae.jeon=40samsung.com>
> > Signed-off-by: Sungjong Seo <sj1557.seo=40samsung.com>
> > ---
> >  fs/exfat/nls.c =7C 809
> > +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 809 insertions(+)
> >  create mode 100644 fs/exfat/nls.c
> >
> > diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c new file mode 100644
> > index 000000000000..af52328e28ff
> > --- /dev/null
> > +++ b/fs/exfat/nls.c
> > =40=40 -0,0 +1,809 =40=40
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
> > + */
> > +
> > +=23include <linux/string.h>
> > +=23include <linux/nls.h>
> > +=23include <linux/slab.h>
> > +=23include <linux/buffer_head.h>
> > +=23include <asm/unaligned.h>
> > +
> > +=23include =22exfat_raw.h=22
> > +=23include =22exfat_fs.h=22
> > +
> > +/* Upcase tabel macro */
> > +=23define EXFAT_NUM_UPCASE	(2918)
> > +=23define UTBL_COUNT		(0x10000)
> > +
> > +/*
> > + * Upcase table in compressed format (7.2.5.1 Recommended Up-case
> > +Table
> > + * in exfat specification, See:
> > +https://protect2.fireeye.com/url?k=3D25cbd240-78ac9666-25ca590f-0cc47a=
3
> > +1384a-776465f5f2917059&u=3Dhttps://docs.microsoft.com/en-us/windows/
> > + * win32/fileio/exfat-specification).
>=20
> Just a small suggestion: Do not wrap URLs as they are hard to copy-paste
> into web browser. Also my email client is not able to detect URL continue
> on next line...
Okay, Will fix it on next version.
Thanks for review=21
>=20
> > + */
> > +static const unsigned short uni_def_upcase=5BEXFAT_NUM_UPCASE=5D =3D =
=7B
> > +	0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007,
> > +	0x0008, 0x0009, 0x000a, 0x000b, 0x000c, 0x000d, 0x000e, 0x000f,
>=20
> ...
>=20
> --
> Pali Roh=C3=A1r=0D=0A>=20pali.rohar=40gmail.com=0D=0A=0D=0A
