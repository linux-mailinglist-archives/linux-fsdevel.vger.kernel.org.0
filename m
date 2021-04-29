Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A6C36E286
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 02:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhD2ATV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 20:19:21 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49667 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhD2ATS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 20:19:18 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210429001831epoutp019330ea4d9d44b1653de3496b9b058485~6LBstLlAK0996709967epoutp01i
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 00:18:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210429001831epoutp019330ea4d9d44b1653de3496b9b058485~6LBstLlAK0996709967epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619655511;
        bh=vFipv7Sdk2iyuIrgh9n//k6qI1AWbbwaLo0xqzarbws=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Nc93/svU1z0I8h0TzB4Q/T+bJ0TKBpnyiHk+j4+5NTRH9oeUOJAznyvtpPPJ78RKU
         cPWPTcOPBM0OjzHRSbrSS7y78ArUw9tH2tFmZ8rBu4RJ116PpXG9ePlbzhS3PiRlPX
         hOT20DjoGlnQRmVHujm4rokNB8XoEEoqBIn43CvA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210429001830epcas1p1c8d1587f02017b515e12e13d384bab45~6LBr9qvyK2826728267epcas1p1b;
        Thu, 29 Apr 2021 00:18:30 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FVx1K3pNTz4x9QB; Thu, 29 Apr
        2021 00:18:29 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.49.09824.55BF9806; Thu, 29 Apr 2021 09:18:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210429001828epcas1p3ad7708995dd6d48af980db61bffdfb1c~6LBqelq0k0885308853epcas1p3I;
        Thu, 29 Apr 2021 00:18:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210429001828epsmtrp15858c3f9e94044247bf783744ea071f5~6LBqddi5T2867528675epsmtrp1V;
        Thu, 29 Apr 2021 00:18:28 +0000 (GMT)
X-AuditID: b6c32a37-04bff70000002660-7e-6089fb557364
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.C8.08163.45BF9806; Thu, 29 Apr 2021 09:18:28 +0900 (KST)
Received: from namjaejeon01 (unknown [10.89.31.77]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210429001828epsmtip21ff33bd6b9d38f1159fab8c8a7c6a1e9~6LBqPuaLb1209312093epsmtip2O;
        Thu, 29 Apr 2021 00:18:28 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        =?UTF-8?Q?'Aur=C3=A9lien_Aptel'?= <aaptel@suse.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <smfrench@gmail.com>, <senozhatsky@chromium.org>,
        <hyc.lee@gmail.com>, <viro@zeniv.linux.org.uk>, <hch@lst.de>,
        <hch@infradead.org>, <ronniesahlberg@gmail.com>,
        <aurelien.aptel@gmail.com>, <sandeen@sandeen.net>,
        <dan.carpenter@oracle.com>, <colin.king@canonical.com>,
        <rdunlap@infradead.org>, <willy@infradead.org>
In-Reply-To: <20210428235702.GE7400@fieldses.org>
Subject: RE: [PATCH v2 00/10] cifsd: introduce new SMB3 kernel server
Date:   Thu, 29 Apr 2021 09:18:28 +0900
Message-ID: <005d01d73c8d$2dd5ca80$89815f80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEyw8UcQFiOkygfL6nbawEwj6LAkgNL6ZwbARcXS5ACyQCCswIY1UerAQPpMTkCx5elNKurDbhA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJsWRmVeSWpSXmKPExsWy7bCmnm7o784Eg7dtEhaNb0+zWBx//Zfd
        4sWUKIvfq3vZLF7/m85icXrCIiaLlauPMllcu/+e3WLP3pMsFpd3zWGzeHsHKNvb94nVovWK
        lsXujYvYLN68OMxmcf7vcVaL3z/msDkIesxq6GXzmN1wkcVjw9QmNo+ds+6ye2xeoeWx+2YD
        m8fHp7dYPLYsfsjksX7LVRaPz5vkPDY9ecsUwB2VY5ORmpiSWqSQmpecn5KZl26r5B0c7xxv
        amZgqGtoaWGupJCXmJtqq+TiE6DrlpkD9JOSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp
        tSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEnY+vT+IIu3or996cyNTBe5eli5OSQEDCR
        2LLiHDOILSSwg1GidWpJFyMXkP2JUaJx7zpGCOczo8T0mfMZYTqafk5mhUjsYpS4/f4fG4Tz
        glGis7OVBaSKTUBX4t+f/WwgtohAqsStD5uZQYqYBTqZJS5+mcUEkuAUMJR4vfQcWJGwgKvE
        wXX/wA5hEVCVWN6xEczmFbCUaF/XyAhhC0qcnPkEbAGzgLbEsoWvmSFOUpD4+XQZK8SyKInL
        u1ayQtSISMzubANbLCHQzikxe/UZdogGF4mu5ZOgbGGJV8e3QNlSEi/724BsDiC7WuLjfqj5
        HYwSL77bQtjGEjfXb2AFKWEW0JRYv0sfIqwosfP3XEaItXwS7772sEJM4ZXoaBOCKFGV6Lt0
        mAnClpboav/APoFRaRaSx2YheWwWkgdmISxbwMiyilEstaA4Nz212LDAGDmuNzGCk7uW+Q7G
        aW8/6B1iZOJgPMQowcGsJML7e11nghBvSmJlVWpRfnxRaU5q8SFGU2BQT2SWEk3OB+aXvJJ4
        Q1MjY2NjCxMzczNTYyVx3nTn6gQhgfTEktTs1NSC1CKYPiYOTqkGpqKEP18Lf3Id5fBSUN6V
        aiV01LbwpMEdrYlVWU7LmkOPJtY2GtT/vZHGs+sOZ9+/9RVnO47Pk+peFRJVJ7joXsuaBm1t
        7kvbuo/LfWE4uj2ga2KJk7O6ldOB/z3zIw8wptldP7TRVkWbc8pH78NePsriH147nFDaEvdd
        JH/N0uqY5kVtTBMNDk3UX8UZ81666d+rjVqfO25zNF195bnfyuuTnlKjqbJ5UOvJPK6Dt5uE
        HDzC9j6yXe5fKL1mxS8pD9cf35Z4bX641vn3i2Yr/bl9N5bM4zPeaPG8MI/9f7nf19/v3SVZ
        JwWIfxOw9f1d0FWgW9+6duLL+hfTmZJuSk419TC4l/Y7amsUW8xnJZbijERDLeai4kQAhJZ5
        oHcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCSvG7I784Eg09HdSwa355msTj++i+7
        xYspURa/V/eyWbz+N53F4vSERUwWK1cfZbK4dv89u8WevSdZLC7vmsNm8fYOULa37xOrResV
        LYvdGxexWbx5cZjN4vzf46wWv3/MYXMQ9JjV0MvmMbvhIovHhqlNbB47Z91l99i8Qstj980G
        No+PT2+xeGxZ/JDJY/2WqywenzfJeWx68pYpgDuKyyYlNSezLLVI3y6BK+PU6ffsBZ85Kjad
        qmhg/MrWxcjJISFgItH0czIriC0ksINR4lifEERcWuLYiTPMXYwcQLawxOHDxV2MXEAlzxgl
        ejpvMYHUsAnoSvz7sx9sjohAqsStD5uZQYqYBWYzSzRe+MQO0bGRSWLG1ZvMIFWcAoYSr5ee
        A+sQFnCVOLjuH1icRUBVYnnHRjCbV8BSon1dIyOELShxcuYTFhCbWUBbovdhKyOMvWzha2aI
        SxUkfj5dxgpxRZTE5V0rWSFqRCRmd7YxT2AUnoVk1Cwko2YhGTULScsCRpZVjJKpBcW56bnF
        hgVGeanlesWJucWleel6yfm5mxjBca6ltYNxz6oPeocYmTgYDzFKcDArifD+XteZIMSbklhZ
        lVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAMTg8qfT/Pc333epbtp
        htf7M+9Lsh7NzGs/Wfx2gZnUeb3yYKuipaItgkmrdGS9EqZFmzMvytm9WqVszTx/TreAr3Mn
        Hz22J9quZ1/Q16l2MvlrrTK1+43ffCl25jY7JhlfMePXsbi1x66JNQY5frqUoMCbwvJI+dKO
        f3rzbI9yxpmLfw8sXPPv+rtDu+fLiJ1NXDKnp9Th8xsl/4svL5Sn3N5QWsJtaLv7lzP/7Y2+
        u9qnh125qnCc9e9OyZjT7ebX3RwydzHHWhh13m35+WHGu7zFEte0LH0OF+Vwpi14q6K1I/Br
        uuWHp2UJUTIHTCKyFra85Z3O/Wt+h6sM88z35Tfrt4T+lbq04kwXo3GVEktxRqKhFnNRcSIA
        HHzUgWIDAAA=
X-CMS-MailID: 20210429001828epcas1p3ad7708995dd6d48af980db61bffdfb1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7
References: <CGME20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7@epcas1p2.samsung.com>
        <20210422002824.12677-1-namjae.jeon@samsung.com>
        <20210428191829.GB7400@fieldses.org> <878s52w49d.fsf@suse.com>
        <20210428204035.GD7400@fieldses.org> <875z06vyi6.fsf@suse.com>
        <20210428235702.GE7400@fieldses.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, Apr 29, 2021 at 12:24:17AM +0200, Aur=C3=A9lien=20Aptel=20wrote:=
=0D=0A>=20>=20=22J.=20Bruce=20Fields=22=20<bfields=40fieldses.org>=20writes=
:=0D=0A>=20>=20>=20I'd=20rather=20see=20multiple=20patches=20that=20were=20=
actually=20functional=20at=0D=0A>=20>=20>=20each=0D=0A>=20>=20>=20stage:=20=
e.g.,=20start=20with=20a=20server=20that=20responds=20to=20some=20sort=20of=
=0D=0A>=20>=20>=20rpc-level=20ping=20but=20does=20nothing=20else,=20then=20=
add=20basic=20file=20IO,=20etc.=0D=0A>=20>=20>=0D=0A>=20>=20>=20I=20don't=
=20know=20if=20that's=20practical.=0D=0A>=20>=0D=0A>=20>=20Although=20it=20=
would=20certainly=20be=20nice=20I=20don't=20think=20it's=20realistic=20to=
=0D=0A>=20>=20expect=20this=20kind=20of=20retro-logical-rewriting.=20AFAIK=
=20the=20other=20new=0D=0A>=20>=20fs-related=20addition=20(ntfs=20patchset)=
=20is=20using=20the=20same=20trick=20of=20adding=0D=0A>=20>=20the=20Makefil=
e=20at=20the=20end=20after=20it=20was=20suggested=20on=20the=20mailing=20li=
st.=20So=0D=0A>=20>=20there's=20a=20precedent.=0D=0A>=20=0D=0A>=20OK,=20I=
=20wondered=20if=20that=20might=20be=20the=20case.=0D=0A>=20=0D=0A>=20I=20d=
on't=20love=20it,=20but,=20fair=20enough,=20maybe=20that's=20the=20best=20c=
ompromise.=0D=0AThank=20you=20for=20your=20understanding.=20One=20big=20pat=
ch=20seems=20to=20be=20unable=20to=20review=0D=0Abecause=20the=20code=20see=
m=20to=20be=20cut=20off=20in=20the=20mail.=20So=20it=20does=20not=20exceed=
=20300KB=0D=0Aper=20patch.=20So=20we=20split=20patches=20out=20by=20layer=
=20and=20added=20Makefile,=20Kconfig=0D=0Aat=20the=20end.=0D=0A=0D=0AThanks=
=21=0D=0A=0D=0A>=20=0D=0A>=20--b.=0D=0A=0D=0A
