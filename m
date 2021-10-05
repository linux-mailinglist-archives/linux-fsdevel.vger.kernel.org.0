Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2097F421D1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 06:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhJEEHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 00:07:22 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:37887 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhJEEHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 00:07:20 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211005040528epoutp0479df7e605cd993f33be6ffd415bb084e~rBsP894CY2308223082epoutp04Z
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 04:05:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211005040528epoutp0479df7e605cd993f33be6ffd415bb084e~rBsP894CY2308223082epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1633406728;
        bh=UKquJcqa+mCuTb6CfZPv0jbD8pNeW3BfHlcIX4+b5R8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=fCUWCBmZuyqwvp74Ks70lKYioEbj6I2p2VNj+GTQCZGTpJ1FJ98rMwrZWtou0Cvek
         8KHCaG2xFzb3FvRz8BAzj/Mdhb6+ywGPCzWT4s2NPXC2sJw/DG25nZhjlb5bjVNdrD
         pDDFtLwkdQeW651h5w+ogJx74JRmaIF/miPiAbV4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211005040528epcas1p43a21e4ca2394a24774311872f641fe7c~rBsPlD_ZJ2730827308epcas1p4C;
        Tue,  5 Oct 2021 04:05:28 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.248]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HNkWn4gmQz4x9QC; Tue,  5 Oct
        2021 04:05:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.14.62447.30FCB516; Tue,  5 Oct 2021 13:05:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211005040522epcas1p41dc8a9d440fad667fa1ae6ca8fb302ad~rBsKdmOta2331723317epcas1p4P;
        Tue,  5 Oct 2021 04:05:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211005040522epsmtrp1d73cff7fe06be8fbef57743d0877d232~rBsKctQu21682416824epsmtrp1J;
        Tue,  5 Oct 2021 04:05:22 +0000 (GMT)
X-AuditID: b6c32a36-3b5ff7000001f3ef-4c-615bcf039263
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.3E.08750.20FCB516; Tue,  5 Oct 2021 13:05:22 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211005040522epsmtip1ae732bafd13964ba9c0175454ea7ad3c~rBsKUf3ea2029020290epsmtip1K;
        Tue,  5 Oct 2021 04:05:22 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     "'Chung-Chiang Cheng'" <cccheng@synology.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shepjeng@gmail.com>, <sj1557.seo@samsung.com>
In-Reply-To: <CAKYAXd9COEWU_QF3p0mnEnH4nHMrHQ5ujwBZ6rt4ZBjEFBnB=w@mail.gmail.com>
Subject: RE: [PATCH] exfat: use local UTC offset when EXFAT_TZ_VALID isn't
 set
Date:   Tue, 5 Oct 2021 13:05:22 +0900
Message-ID: <c28301d7b99e$37fb5af0$a7f210d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGbLD2CCutv2trCrUWvFxdYN9vjigGoD6NLAWfhRkYBJWz3gQLEsXbMrAT4U+A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTX5f5fHSiwZpVAhZbnx1ntZg4bSmz
        xZ69J1ksLu+aw2bROlvSYsu/I6wObB47Z91l99i0qpPNo2/LKkaPGR/2s3p83iQXwBqVbZOR
        mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdICSQlliTilQ
        KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj2uom
        1oLlohX37s5mb2A8JdjFyMEhIWAicWZ+ShcjJ4eQwA5GiZU3E7sYuYDsT4wSHy/dYoNwPjNK
        PN89gx2mYVEvN0R8F6NE7/ujTBDOS0aJU68WMoGMYhPQlXhy4yczSIOIgLbE/RfpIDXMAssY
        JXY1T2cEqeEUCJT4P/sCK4gtLBAg0TsTwmYRUJFoO9fPDGLzClhKfF8ymw3CFpQ4OfMJC4jN
        DDRz2cLXYDUSAgoSuz8dBesVEfCTuPnrOjtEjYjE7M42qJpODonma6IQtovEjqUTWCFsYYlX
        x7ewQ9hSEi/726Dseon/89eygxwtIdDCKPHw0zYmiO/tJd5fsgAxmQU0Jdbv0ocoV5TY+Xsu
        I8RaPol3X3tYIap5JTrahCBKVCS+f9jJArPpyo+rTBMYlWYheWwWksdmIXlgFsKyBYwsqxjF
        UguKc9NTiw0LjOAxnZyfu4kRnDC1zHYwTnr7Qe8QIxMH4yFGCQ5mJRHeq16RiUK8KYmVValF
        +fFFpTmpxYcYTYFBPZFZSjQ5H5iy80riDU0sDUzMjEwsjC2NzZTEeY+9tkwUEkhPLEnNTk0t
        SC2C6WPi4JRqYOqYwBi0XpDHgtH2xNk99U/2Vexm5ohSOGKZ6c/5+JMew3Le/53XnVTaHP/m
        dGyeE1vMuHBV2e5wg8fa6/d7HahxVtd2uJwUXypmJeV8aHWCkM9y7jmPv8yN4zrjzsWZ0nR6
        Tmzfn4shqZnbsw9KX/rnvOENi6nDvJ/286M/tpSu3bO68kD+75nK5QFmJmsOLtiX8u7xwr9r
        el/87Kq/+kDNICfZ+XLkPI6Gfarx21inNoo7LLy0aMPbkF7VazZqawqbGrdMMA2UZp9pcy88
        +uwO1/C83QrHc458VLP++EE21UE33Kap52S3aZro4xef/5hq1F5ce3x1pX1v85knr1znKT/9
        27j3tSj7zMXrLJRYijMSDbWYi4oTAc1FU9ghBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnC7T+ehEg6OzNS22PjvOajFx2lJm
        iz17T7JYXN41h82idbakxZZ/R1gd2Dx2zrrL7rFpVSebR9+WVYweMz7sZ/X4vEkugDWKyyYl
        NSezLLVI3y6BK+Pn5u/MBQ2iFa8OfWBvYJwr2MXIwSEhYCKxqJe7i5GLQ0hgB6PEvq4FbBBx
        KYmD+zQhTGGJw4eLIUqeA5VsW8nexcjJwSagK/Hkxk9mkBoRAW2J+y/SQcLMAqsYJZY+rwax
        hQSOMEm07PACsTkFAiX+z77AClIuLOAnMX+nPUiYRUBFou1cPzOIzStgKfF9yWw2CFtQ4uTM
        JywQI7Uleh+2MsLYyxa+BquXEFCQ2P3pKCuILQI08uav6+wQNSISszvbmCcwCs9CMmoWklGz
        kIyahaRlASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4MjR0trBuGfVB71DjEwc
        jIcYJTiYlUR4r3pFJgrxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgm
        y8TBKdXAlOxZWdpRo8ebyDjjh4Sc15HAp29XfblSrn1olXrr/aKYlBbOuy0tzSd448VtUwIF
        Eo7vm+9VoMk46fz3jXc3R+qfDZnO+22do79YXPusOx4r5ubOaZ3yvPCAvGfXXacKvov2LFx3
        r9hv/BBdkSUbtXTCdo19h6a3+VVf8zvL0zhxfsnyzxHH71nZzbdki4+XN4z7MaVM2uNPjq6q
        0pLz2w/FOyxdVXZJmVVW/lTw9etbNla8VZLaWlP+7UjGloB7RQ0FvuVbbjuesomVmn/PUn9n
        WGSJ/xozo2089+5G1gbN/ied+DmIc/rblhNc161erWY9KXUkXPEpy5JlswOURdgsukqX8h9n
        +nvrZ5m3EktxRqKhFnNRcSIA5Kan/wsDAAA=
X-CMS-MailID: 20211005040522epcas1p41dc8a9d440fad667fa1ae6ca8fb302ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210910010035epcas1p496dd515369b9f2481ccd1c0de5904bbd
References: <20210909065543.164329-1-cccheng@synology.com>
        <CGME20210910010035epcas1p496dd515369b9f2481ccd1c0de5904bbd@epcas1p4.samsung.com>
        <CAKYAXd_1ys-xQ9HusgqSr5GHaP6R2pK4JswfZzoqZ=wTnwSiOw@mail.gmail.com>
        <997a01d7b6c6$ea0c3f50$be24bdf0$@samsung.com>
        <CAKYAXd9COEWU_QF3p0mnEnH4nHMrHQ5ujwBZ6rt4ZBjEFBnB=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 2021-10-01 22:19 GMT+09:00, Sungjong Seo <sj1557.seo=40samsung.com>:
> > Hello, Namjae,
> Hi Sungjong,
> >
> > I found an important difference between the code we first wrote and
> > the code that has changed since our initial patch review. This
> > difference seems to cause compatibility issues when reading saved
> timestamps without timezone.
> > (In our initial patch review, there were concerns about possible
> > compatibility issues.) I think the code that reads timestamps without
> > timezone should go back to the concept we wrote in the first place
> > like reported patch.
> Are you talking about using sys_tz?
Yes, exactly, a part like below.

+static inline int exfat_tz_offset(struct exfat_sb_info *sbi) =7B
+	return (sbi->options.tz_set ? -sbi->options.time_offset :
+			sys_tz.tz_minuteswest) * SECS_PER_MIN; =7D
+

>=20
> > It could be an answer of another timestamp issue.
> What is another timestamp issue ?

What I'm saying is =22timestamp incompatibilities in exfat-fs=22 from Reine=
r <reinerstallknecht=40gmail.com>
I think it might be the same issue with this.

>=20
> >
> > Could you please let me know what you think?
> >
> > Thanks.
> >> -----Original Message-----
> >> From: Namjae Jeon =5Bmailto:linkinjeon=40kernel.org=5D
> >> Sent: Friday, September 10, 2021 10:01 AM
> >> To: Chung-Chiang Cheng <cccheng=40synology.com>
> >> Cc: sj1557.seo=40samsung.com; linux-fsdevel=40vger.kernel.org; linux-
> >> kernel=40vger.kernel.org; shepjeng=40gmail.com
> >> Subject: Re: =5BPATCH=5D exfat: use local UTC offset when EXFAT_TZ_VAL=
ID
> >> isn't set
> >>
> >> 2021-09-09 15:55 GMT+09:00, Chung-Chiang Cheng <cccheng=40synology.com=
>:
> >> > EXFAT_TZ_VALID is corresponding to OffsetValid field in exfat
> >> > specification =5B1=5D. If this bit isn't set, timestamps should be
> >> > treated as having the same UTC offset as the current local time.
> >> >
> >> > This patch uses the existing mount option 'time_offset' as fat does.
> >> > If time_offset isn't set, local UTC offset in sys_tz will be used
> >> > as the default value.
> >> >
> >> > Link: =5B1=5D
> >> > https://protect2.fireeye.com/v1/url?k=3Dcba4edf5-943fd4c8-cba566ba-0=
c
> >> > c47
> >> > a31309a-e70aa065be678729&q=3D1&e=3D225feff2-841f-404c-9a2e-c12064b23=
2d0
> >> > &u=3D
> >> > https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows%2Fwin32%2Ffileio
> >> > %2F exfat-specification%2374102-offsetvalid-field
> >> > Signed-off-by: Chung-Chiang Cheng <cccheng=40synology.com>
> >> Please read this discussion:
> >>  https://patchwork.kernel.org/project/linux-
> >> fsdevel/patch/20200115082447.19520-10-namjae.jeon=40samsung.com/
> >>
> >> Thanks=21
> >
> >

