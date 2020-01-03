Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9411912F4D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 08:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgACHGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 02:06:32 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:63630 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACHGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:06:30 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200103070627epoutp03ba8a815767f0c8d2c2ebb5b913783d0f~mTqR0auXa0669206692epoutp03I
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jan 2020 07:06:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200103070627epoutp03ba8a815767f0c8d2c2ebb5b913783d0f~mTqR0auXa0669206692epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578035187;
        bh=rfGGNQT8evgRVw+JTBLO+XI7I4bJD+fGwGykG+9qYHQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=jQ5Ts5r+9T/OdQO2FHk0G0dwD2j28nSGul2Rfocuf+W6hC4+HE2Surw6R9Mc5ndHr
         EX2Aj8D2K+qrA47jWaU5JErm4B9YgPc7Bsn5myRVfNoiJsgkarPZprfvC7wy7/D1gY
         Rs46eJpH8s3+6BwhmP870bC0PEQH9a9ymmVoUfzI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200103070627epcas1p44761069aa188b7822dd095ce151f4cab~mTqRce6RQ1519215192epcas1p4Z;
        Fri,  3 Jan 2020 07:06:27 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47pwtV3jRVzMqYkg; Fri,  3 Jan
        2020 07:06:26 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.A2.57028.2F7EE0E5; Fri,  3 Jan 2020 16:06:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200103070626epcas1p3a2dc24ac9d4ae26ad190f0d26edbd225~mTqQSI5wP2168721687epcas1p3t;
        Fri,  3 Jan 2020 07:06:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200103070626epsmtrp14c57a6da2e8900fc1f20d683631eb339~mTqQRa1qo0737607376epsmtrp1o;
        Fri,  3 Jan 2020 07:06:26 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-68-5e0ee7f2861f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.78.06569.1F7EE0E5; Fri,  3 Jan 2020 16:06:25 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200103070625epsmtip2ad2d3260bc48f6bd73e3613cf2be0e80~mTqQKMf2x2126821268epsmtip2P;
        Fri,  3 Jan 2020 07:06:25 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     =?UTF-8?Q?'Pali_Roh=C3=A1r'?= <pali.rohar@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <hch@lst.de>, <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>
In-Reply-To: <20200102135502.hkey7z45gnprinpp@pali>
Subject: RE: [PATCH v9 10/13] exfat: add nls operations
Date:   Fri, 3 Jan 2020 16:06:25 +0900
Message-ID: <003101d5c204$5046e9a0$f0d4bce0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJSGi/S1M7UFBjz5N3SW71o+eawLwHz+Lr1AtmMBwQCoo41BaakU3fg
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTQRiGM912uxBXh1r1s0ZTNx4BA7TUwmKo8U5FfmD45QVsYFOIvdIt
        qKgJSkTBE2Oi1gISFSNyqRUFNQjVGDRBxAhC0qiJxqOiFbxFY9vFyL9n3nm/+b53ZihC0Uiq
        qHyrk3dYOTNDRkpbvNGa2OHXEzM1+/0z2ZIzTSR74eJdCdvvGyTYm7e6pOzjNjfJVjz4JWE9
        f+7I2N6PAekSytjq8smN7ZX1cuONgWLSeMhTh4wjl2cZO6+9J9PJ9eaUPJ7L5R1q3ppjy823
        mgzMmoys5Vn6RI02VpvMJjFqK2fhDcyKtPTYVfnm4ECMupAzFwSldE4QmPjFKQ5bgZNX59kE
        p4Hh7blmu1ZjjxM4i1BgNcXl2CyLtBpNgj7ozDbntXiOI/s3vPW2e5QsRh/pchRBAV4Inopa
        IsQKfB1BR/2ychQZ5GEEu074CHHxFUHNvVH5v4rDJX6JuHELQXfDkFxcvEXwor9GFnKROBb+
        jLaT5YiilJiF6j26kIfAt4OexkthTwTWwf3fx8M8GSfB+3O+cAcpngPeYn+YaZwMVX1nkchR
        0HXypTTEBF4AtTV+QpxIDT9e1cpEXQmnykrDuhKvgj1PP4QjAB4hwXv1BRILVkD//foxngzv
        7nnGoqng7eFSeWhowNvhU/vY+fsQvPlmEFkHA03NspCFwNHQ1BYvyrOh9VclEkeYCB++HJCJ
        p9Cwr1QhWubCoV6vROQZUL43ID+CGNe4YK5xwVzjwrj+NzuNpHVoKm8XLCZe0Nq149/6Mgr/
        1Rj9dXSsO60TYQoxE+gjfXSmQsYVCtssnQgoglHSW9YGJTqX21bEO2xZjgIzL3QiffDeKwjV
        lBxb8OdbnVlafYJOp2MXJiYl6nXMNJr6/miTAps4J7+Z5+2841+dhIpQFSM6s6dh3cWV3o3z
        bg5E779a7fI2NC5/SM2XlFy4ljOy4WhqYW9h4NjnlGd1B5607s62G/uLKstMwx3n9Z9tV1Ij
        1W5XclTa94PzbrT5Er8OuicZenZlKKtWL9WcbZxyJeEMFXj+07+jcmiIO1c6YfrryGZ3TbZq
        54AsdXFAXlY04wHFSIU8ThtDOATuL4XJFYPBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvO7H53xxBs3zbSyaF69ns1i5+iiT
        xfW7t5gt9uw9yWJxedccNouJp38zWWz5d4TV4tL7DywOHB47Z91l99g/dw27x+6bDWwefVtW
        MXp83iTncWj7G7YAtigum5TUnMyy1CJ9uwSujDNT2pgKbghU9K+dxdjAeJK3i5GTQ0LARKK/
        +TVTFyMXh5DAbkaJJQf6mCES0hLHTpwBsjmAbGGJw4eLIWqeA9UsncUKUsMmoCvx789+NpAa
        EQELifmtxiA1zAInGCXO9N9ihWu4tvQ8I0gDp4CxxKm/08GahQXMJd4svcsOYrMIqEgcbngN
        ZvMKWErMu7aEEcIWlDg58wkLiM0soC3R+7CVEcZetvA11KEKEj+fLmOFiItIzO5sA4uLCLhJ
        tN54xzyBUXgWklGzkIyahWTULCTtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525i
        BMeYltYOxhMn4g8xCnAwKvHwTrjGGyfEmlhWXJl7iFGCg1lJhLc8ECjEm5JYWZValB9fVJqT
        WnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBMdtWyWFSVm1Q5K8ct0bvxNUP92RI
        uAVeVuSzcuc3eXlURyXWsEhGZN3Cx1tv+8k+O6zitGFFsjXjE85DCtXqyoJBh2rZMmbN2ZYe
        6a9V9Pj4qfrVe25K//xlMu/kysnmIXNmOm2pyza1nsj8jvV+6qyf++Uq12U8fd4yb+rWZr+e
        69sYVbTfKrEUZyQaajEXFScCAO9vDi6tAgAA
X-CMS-MailID: 20200103070626epcas1p3a2dc24ac9d4ae26ad190f0d26edbd225
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
        <20200102135502.hkey7z45gnprinpp@pali>
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
>=20
> ...
>=20
> > +int exfat_nls_uni16s_to_vfsname(struct super_block *sb,
> > +		struct exfat_uni_name *uniname, unsigned char *p_cstring,
> > +		int buflen)
> > +=7B
> > +	if (EXFAT_SB(sb)->options.utf8)
> > +		return __exfat_nls_utf16s_to_vfsname(sb, uniname, p_cstring,
> > +				buflen);
> > +	return __exfat_nls_uni16s_to_vfsname(sb, uniname, p_cstring,
> buflen);
> > +=7D
>=20
> Hello, I'm looking at this function and basically it do nothing.
> Or was it supposed that this function should do something more for UTF-8
> encoding?
>=20
> There is one if- statement, but in both branches is executed exactly
> same code.
>=20
> And executed function just pass same arguments as current callee
> function.
>=20
> So calls to exfat_nls_uni16s_to_vfsname() can be replaced by direct
> calls to __exfat_nls_uni16s_to_vfsname().
Ah, The function names are similar, but not same. see utf16s/uni16s.

Thanks=21

>=20
> Or maybe better, rename __exfat_nls_uni16s_to_vfsname() function to
> exfat_nls_uni16s_to_vfsname().
>=20
> > +int exfat_nls_vfsname_to_uni16s(struct super_block *sb,
> > +		const unsigned char *p_cstring, const int len,
> > +		struct exfat_uni_name *uniname, int *p_lossy)
> > +=7B
> > +	if (EXFAT_SB(sb)->options.utf8)
> > +		return __exfat_nls_vfsname_to_utf16s(sb, p_cstring, len,
> > +				uniname, p_lossy);
> > +	return __exfat_nls_vfsname_to_uni16s(sb, p_cstring, len, uniname,
> > +			p_lossy);
> > +=7D
>=20
> And same for this function.
>=20
> --
> Pali Roh=C3=A1r=0D=0A>=20pali.rohar=40gmail.com=0D=0A=0D=0A
