Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A911402FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 05:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgAQEWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 23:22:32 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:35957 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgAQEWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:22:32 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200117042230epoutp04e8f939aaecbedebf2aebbabee519ad07~qkdH4c7-Z2095820958epoutp04T
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 04:22:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200117042230epoutp04e8f939aaecbedebf2aebbabee519ad07~qkdH4c7-Z2095820958epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579234950;
        bh=yXs4dN9dWbgqK0plr9GWSMlt+yloNWhcLnkDRbj19+E=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=BmGThpJWjkfH9gEStarGQ4E/NKdI4kpTWkMg15/C7u62qMP0gWvnDhd5QChoEusCv
         5T4Tham3RTgk1FuxACLsw9yJ7030KH4QpL1EhsPPeBV7VlbSuSadE4TTzCi708LZRu
         xWH26O4yu/UmWP9IJJbaVpsNkure0odJAkB7BuoU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200117042229epcas1p11c1eec0d0b812e38f8e240dc1bd75c43~qkdHMP4VA2840228402epcas1p1Y;
        Fri, 17 Jan 2020 04:22:29 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47zSZr3G17zMqYkV; Fri, 17 Jan
        2020 04:22:28 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.AB.52419.486312E5; Fri, 17 Jan 2020 13:22:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200117042227epcas1p2b6ffef02aa47191accfec4bf00bac4a1~qkdFlXMrV2377523775epcas1p2-;
        Fri, 17 Jan 2020 04:22:27 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200117042227epsmtrp27cdd49e69b55f65e1b91a1041cb3de02~qkdFkZWAH2547425474epsmtrp2A;
        Fri, 17 Jan 2020 04:22:27 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-1e-5e213684a50b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.24.06569.386312E5; Fri, 17 Jan 2020 13:22:27 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200117042227epsmtip2ca212f321a68f125e5c1f744f20c3159~qkdFaJafF2635726357epsmtip2n;
        Fri, 17 Jan 2020 04:22:27 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     =?UTF-8?Q?'Pali_Roh=C3=A1r'?= <pali.rohar@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <hch@lst.de>, <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>,
        <arnd@arndb.de>
In-Reply-To: <20200115093915.cjef2jadiwe2eul4@pali>
Subject: RE: [PATCH v10 11/14] exfat: add Kconfig and Makefile
Date:   Fri, 17 Jan 2020 13:22:27 +0900
Message-ID: <002f01d5cced$ba0828b0$2e187a10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHvmPGd9hXZW1JGF9XPkytILTKCmQHO27G6AkKblqwC0Bzdx6eDnHCw
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmrm6LmWKcweNeQYu/k46xWzQvXs9m
        sXL1USaL63dvMVvs2XuSxeLyrjlsFhNP/2ay2PLvCKvFpfcfWBw4PX7/msTosXPWXXaP/XPX
        sHvsvtnA5tG3ZRWjx+dNch6Htr9hC2CPyrHJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1
        tLQwV1LIS8xNtVVy8QnQdcvMATpNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNg
        aFCgV5yYW1yal66XnJ9rZWhgYGQKVJmQk7FnczdLwQWein1PZ7M1MF7h7GLk5JAQMJHYcWAy
        UxcjF4eQwA5Giaf3vzNDOJ8YJV5vPswK4XxjlPj6fSMTTMv6sxegqvYyStzt2QuWEBJ4ySgx
        d3ckiM0moCvx789+ti5GDg4RAQuJ+a3GIPXMAhcZJTZ872cBqeEUMJZ4enAJG4gtLGAnce/0
        QXYQm0VAVeLK5E6wOK+ApcTHs/+YIGxBiZMzn4D1MgtoSyxb+JoZ4iAFiZ9Pl7FCxEUkZne2
        MUPsdZPom1MAsldCoJld4tbTJjaIeheJS1+es0PYwhKvjm+BsqUkPr/bC3azhEC1xMf9UOM7
        GCVefLeFsI0lbq7fwApSwiygKbF+lz5EWFFi5++5jBAX8Em8+9rDCjGFV6KjTQiiRFWi79Jh
        aAhKS3S1f2CfwKg0C8lfs5D8NQvJL7MQli1gZFnFKJZaUJybnlpsWGCMHNWbGMGJVst8B+OG
        cz6HGAU4GJV4eGcEKcQJsSaWFVfmHmKU4GBWEuE9OUM2Tog3JbGyKrUoP76oNCe1+BCjKTDY
        JzJLiSbnA7NAXkm8oamRsbGxhYmZuZmpsZI47wwXoDkC6YklqdmpqQWpRTB9TBycUg2Myp2c
        NXuO/9vitKvg6abtjwUXTVAO2HGWhTVmVUx90F+tFc/31J3WvL25+/Gxgut7879v/xweNG/X
        5gjRb8nWp+MP5vyM5dxadezR+WNS3/Y/ONpTfexsV5N/w79d2tdfXpn1hfms75T0Fmd/25Bq
        1p8mNz4HXkhmbPy+pfn1qgcn5Ppqf/19mK/EUpyRaKjFXFScCAA2TZ8rygMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSvG6zmWKcweW5BhZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLCae/s1kseXfEVaLS+8/sDhwevz+NYnRY+esu+we++eu
        YffYfbOBzaNvyypGj8+b5DwObX/DFsAexWWTkpqTWZZapG+XwJWx7s1LtoJ1PBUXOvYxNTBu
        4uxi5OSQEDCRWH/2AnMXIxeHkMBuRonTnS8ZIRLSEsdOnAFKcADZwhKHDxdD1DxnlFi55QYb
        SA2bgK7Evz/72UBqRAQsJOa3GoPUMAvcZpTY0X+IHa7h0oSNYA2cAsYSTw8uAbOFBewk7p0+
        yA5iswioSlyZ3AkW5xWwlPh49h8ThC0ocXLmExYQm1lAW6L3YSsjjL1s4WtmiEMVJH4+XcYK
        EReRmN3ZxgxxkJtE35yCCYzCs5BMmoVk0iwkk2Yh6V7AyLKKUTK1oDg3PbfYsMAoL7Vcrzgx
        t7g0L10vOT93EyM46rS0djCeOBF/iFGAg1GJh3dGkEKcEGtiWXFl7iFGCQ5mJRHekzNk44R4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUwBndPPecnofX5
        Hf/+5vcM0X9iDmz5wLnshHhKRVIf+3rW7bdZizXTrK6oe8bWhktOvH4v9YPLbYt1e0TCipsa
        VHojmj7N+Wiy+uL/xTeO5hywCovyU632n3X+uFj557YzVc/vZeuUCU+cGbJVao9jzY/G4lnn
        ldMfWW5KaJvO8rL7bO2pk8HFSizFGYmGWsxFxYkAR96Im7YCAAA=
X-CMS-MailID: 20200117042227epcas1p2b6ffef02aa47191accfec4bf00bac4a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200115082825epcas1p1f22ddca6dbf5d70e65d3b0e3c25c3a59
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
        <CGME20200115082825epcas1p1f22ddca6dbf5d70e65d3b0e3c25c3a59@epcas1p1.samsung.com>
        <20200115082447.19520-12-namjae.jeon@samsung.com>
        <20200115093915.cjef2jadiwe2eul4@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +config EXFAT_DEFAULT_IOCHARSET
> > +	string =22Default iocharset for exFAT=22
> > +	default =22utf8=22
> > +	depends on EXFAT_FS
> > +	help
> > +	  Set this to the default input/output character set you'd
> > +	  like exFAT to use. It should probably match the character set
> > +	  that most of your exFAT filesystems use, and can be overridden
> > +	  with the =22iocharset=22 mount option for exFAT filesystems.
>=20
> Hello=21 This description is incorrect. iocharset option specify what
> character set is expected by VFS layer and not character set used by exFA=
T
> filesystem. exFAT filesystem always uses UTF-16 as this is the only
> allowed by exFAT specification.
Hi Pali,

Could you please review updated description ?

diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
index 9eeaa6d06..f2b0cf2c1 100644
--- a/fs/exfat/Kconfig
+++ b/fs/exfat/Kconfig
=40=40 -15,7 +15,7 =40=40 config EXFAT_DEFAULT_IOCHARSET
        default =22utf8=22
        depends on EXFAT_FS
        help
-         Set this to the default input/output character set you'd
-         like exFAT to use. It should probably match the character set
-         that most of your exFAT filesystems use, and can be overridden
-         with the =22iocharset=22 mount option for exFAT filesystems.
+         Set this to the default input/output character set to use for
+         converting between the encoding is used for user visible filename=
 and
+         UTF-16 character that exfat filesystem use. and can be overridden=
 with
+         the =22iocharset=22 mount option for exFAT filesystems.

