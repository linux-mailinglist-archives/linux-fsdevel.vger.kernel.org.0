Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F74B23F864
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Aug 2020 19:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHHRsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Aug 2020 13:48:00 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:26182 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgHHRr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Aug 2020 13:47:56 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200808174751epoutp04e3511dbab36004102d42035b2498a3db~pXCh_DURv0573505735epoutp04L
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2020 17:47:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200808174751epoutp04e3511dbab36004102d42035b2498a3db~pXCh_DURv0573505735epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596908871;
        bh=z6YHluQ4GNDsHPkqQwY6Xcb1ell9rkc8pLldCIBH4Vk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=arts7RstdR68osA72ioOAFndXzj1VJ+Lw9Dy7XQ2ONgCqUIsTf1viBuWkYNPfzKDg
         Nzcwpxkn7QjLhyynbaYSRs4vXK3luVtCD07ub2Fm6ljwuiL/aT8ov4NSY5J0YxJsS2
         rZMktJ7TND249FWnk39wHdjvZ65LQ1BdqkoxxTHo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200808174750epcas1p2809ba10462b4f80ddd4ac895319cc406~pXCg6ut5v3191631916epcas1p24;
        Sat,  8 Aug 2020 17:47:50 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BP8nx5zntzMqYlh; Sat,  8 Aug
        2020 17:47:49 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.44.19033.545EE2F5; Sun,  9 Aug 2020 02:47:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200808174748epcas1p39109727ea50b9daeca1fe2b4734f62a3~pXCfK3IlR0332503325epcas1p3i;
        Sat,  8 Aug 2020 17:47:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200808174748epsmtrp16dd84074adde5359b0cd0e665dee8a3a~pXCfKcH-m2787527875epsmtrp1I;
        Sat,  8 Aug 2020 17:47:48 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-b5-5f2ee54519d4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.0A.08382.445EE2F5; Sun,  9 Aug 2020 02:47:48 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200808174748epsmtip2539caf750d654e6d5dff32166975e04e~pXCe9J8TI2772827728epsmtip2N;
        Sat,  8 Aug 2020 17:47:48 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <c635e965-6b78-436a-3959-e4777e1732c1@gmail.com>
Subject: RE: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
Date:   Sun, 9 Aug 2020 02:47:48 +0900
Message-ID: <000301d66dac$07b9fc00$172df400$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQF0BoMPlscPSpT3Th8lCwQKqdMbhQJGtMGMAcFEUC0CM27r7AJXiyRiAvP59PyplxD30A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmrq7rU714g0fX1Sx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi8qxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2Vo
        YGBkClSZkJMxc+1WtoLT0hVfpt9mbWDcJtrFyMkhIWAi0XH8PEsXIxeHkMAORokj+58yQzif
        GCWer53ICOF8Y5Q48HERM0zLzcONbBCJvYwSHy+vYYJwXjJKbF32mB2kik1AV+LJjZ9gHSIC
        ehInT15nA7GZBRqZJE68zAaxOQVsJRof3AZawcEhLGApsfC6MkiYRUBF4viB20wgNi9QeOf9
        X6wQtqDEyZlPWCDGaEssW/ga6iAFid2fjrJCrAqTONJ7iRGiRkRidmcb2DsSAjM5JJbvvc4C
        0eAi0fv5MiOELSzx6vgWdghbSuJlfxuUXS/xf/5adojmFkaJh5+2MYEcKiFgL/H+kgWIySyg
        KbF+lz5EuaLEzt9zofbySbz72sMKUc0r0dEmBFGiIvH9w04WmE1XflxlmsCoNAvJZ7OQfDYL
        yQezEJYtYGRZxSiWWlCcm55abFhghBzZmxjByVTLbAfjpLcf9A4xMnEwHmKU4GBWEuHNeqEd
        L8SbklhZlVqUH19UmpNafIjRFBjWE5mlRJPzgek8ryTe0NTI2NjYwsTM3MzUWEmc9+EthXgh
        gfTEktTs1NSC1CKYPiYOTqkGpsjkre+bjkrd0Hs6Kebx2c+P0/MNOGSWFW3d+vT5yQP7LRQ6
        Te6df6l8hd/i+LwbxSFtt3TshZPDlNxs5/uZ/Js0lf9EjYvUVGubGQXRU0VFpobLbijt35cs
        NXWKxwJL5lJRpu4p7mqmV/W3phXd2rxsQuPW+Xk+8psbPKP5bznXKU823exzm+Fy6EnJL5JL
        zt79/svJSy/JNsH8G9tCD43co9x/WbkMQp7opKToLEnLOlX63fbxdq2th/YtyeredFzgo3z9
        7/v2pXF3Pi28xhwqvTbIofGY2/wb/fuXmWwour32zQ/tdVGLhUyT71czLhfTS8rZekR02QEJ
        /fpLOxfdOSceFPxn5u4lGQEewkosxRmJhlrMRcWJAFfR5uEvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXtflqV68wftHmhY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwRXHZpKTmZJalFunbJXBlfN71gK3gtnTFhEXfmRsYd4l2MXJySAiYSNw83MjWxcjF
        ISSwm1Hi0OIu5i5GDqCElMTBfZoQprDE4cPFECXPGSUmXGxgAellE9CVeHLjJzOILSKgJ3Hy
        5HWwOcwCzUwSrV+amSA6jjNJPFh8gwmkilPAVqLxwW1GkKnCApYSC68rg4RZBFQkjh+4DVbC
        CxTeef8XK4QtKHFy5hOwZcwC2hJPbz6Fs5ctfM0M8YCCxO5PR1khjgiTONJ7iRGiRkRidmcb
        8wRG4VlIRs1CMmoWklGzkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHFVa
        mjsYt6/6oHeIkYmD8RCjBAezkghv1gvteCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8NwoXxgkJ
        pCeWpGanphakFsFkmTg4pRqYwnKe/zugNFfad73s3cMmTm9WnGpJf+YsaPbpPOsT1X1H758L
        0us6IdUZnsww6WKgTevHSucjd55cO91YbOTptu7xiZaf3GwyfXY6/ia7Zy1lXmnH3LD0TmKy
        zLntlqahtW7Tn3vu+XL4+qr9TMZSq4skZn06c27qNsngzh6Nv58S26KPBSslmqezpuivjWvt
        23u/QsLq2g2puz9c736zS+BJjL1c6bLIU2nO0p83pm79+GBW9jM7wXyO368+H3jUeNTyfY2d
        fX+uoHzO1jNVmRP3T/3HLMzTu/CZxv/oiSenP/Bff37Kp11ej0Q0uAR7uXz2L/l81k3ss7dq
        7/TWD/v/tRe1LORY7nf8hBNfvxJLcUaioRZzUXEiAE6CBbIZAwAA
X-CMS-MailID: 20200808174748epcas1p39109727ea50b9daeca1fe2b4734f62a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3
References: <CGME20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3@epcas1p2.samsung.com>
        <20200616021808.5222-1-kohada.t2@gmail.com>
        <414101d64477$ccb661f0$662325d0$@samsung.com>
        <aac9d6c7-1d62-a85d-9bcb-d3c0ddc8fcd6@gmail.com>
        <500801d64572$0bdd2940$23977bc0$@samsung.com>
        <c635e965-6b78-436a-3959-e4777e1732c1@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 2020/06/18 22:11, Sungjong Seo wrote:
> >> BTW
> >> Even with this patch applied,  VOL_DIRTY remains until synced in the
> >> above case.
> >> It's not  easy to reproduce as rmdir, but I'll try to fix it in the
> future.
> >
> > I think it's not a problem not to clear VOL_DIRTY under real errors,
> > because VOL_DIRTY is just like a hint to note that write was not
> finished clearly.
> >
> > If you mean there are more situation like ENOTEMPTY you mentioned,
> > please make new patch to fix them.
>=20
>=20
> When should VOL_DIRTY be cleared?
>=20
> The current behavior is ...
>=20
> Case of  mkdir, rmdir, rename:
>    - set VOL_DIRTY before operation
>    - set VOL_CLEAN after operating.
> In async mode, it is actually written to the media after 30 seconds.
>=20
> Case of  cp, touch:
>    - set VOL_DIRTY before operation
>    - however, VOL_CLEAN is not called in this context.
> VOL_CLEAN will call by sync_fs or unmount.
>=20
> I added VOL_CLEAN in last of __exfat_write_inode() and exfat_map_cluster(=
).
> As a result, VOL_DIRTY is cleared with cp and touch.
> However, when copying a many files ...
>   - Async mode: VOL_DIRTY is written to the media twice every 30 seconds.
>   - Sync mode: Of course,  VOL_DIRTY and VOL_CLEAN to the media for each
> file.
>=20
> Frequent writing VOL_DIRTY and VOL_CLEAN  increases the risk of boot-
> sector curruption.
> If the boot-sector corrupted, it causes the following serious problems  o=
n
> some OSs.
>   - misjudge as unformatted
>   - can't judge as exfat
>   - can't repair
>=20
> I want to minimize boot sector writes, to reduce these risk.
>=20
> I looked vfat/udf implementation, which manages similar dirty information
> on linux, and found that they ware mark-dirty at mount and cleared at
> unmount.
>=20
> Here are some ways to clear VOL_DIRTY.
>=20
> (A) VOL_CLEAN after every write operation.
>    :-) Ejectable at any time after a write operation.
>    :-( Many times write to Boot-sector.
>=20
> (B) dirty at mount, clear at unmount (same as vfat/udf)
>    :-) Write to boot-sector twice.
>    :-( It remains dirty unless unmounted.
>    :-( Write to boot-sector even if there is no write operation.
>=20
> (C) dirty on first write operation, clear on unmount
>    :-) Writing to boot-sector is minimal.
>    :-) Will not write to the boot-sector if there is no write operation.
>    :-( It remains dirty unless unmounted.
>=20
> (D) dirty on first write operation,  clear on sync-fs/unmount
>   :-) Writing to boot-sector can be reduced.
>   :-) Will not write to the boot-sector if there is no write operation.
>   :-) sync-fs makes it clean and ejectable immidiately.
>   :-( It remains dirty unless sync-fs or unmount.
>   :-( Frequent sync-fs will  increases writes to boot-sector.
>=20
> I think it should be (C) or(D).
> What do you think?
>=20

First of all, I'm sorry for the late reply.
And thank you for the suggestion.

Most of the NAND flash devices and HDDs have wear leveling and bad sector r=
eplacement algorithms applied.
So I think that the life of the boot sector will not be exhausted first.

Currently the volume dirty/clean policy of exfat-fs is not perfect,
but I think it behaves similarly to the policy of MS Windows.

Therefore,
I think code improvements should be made to reduce volume flag records whil=
e maintaining the current policy.

BR
Sungjong Seo
>=20
>=20
> BR
> ---
> Tetsuhiro Kohada <kohada.t2=40gmail.com>

