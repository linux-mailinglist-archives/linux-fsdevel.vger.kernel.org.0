Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F42C3F6EA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 06:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhHYE7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 00:59:44 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:62743 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhHYE7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 00:59:43 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210825045856epoutp02df49e2345bf7f0929b128d209c1cef77~ec_OYqh3d0816708167epoutp02B
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Aug 2021 04:58:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210825045856epoutp02df49e2345bf7f0929b128d209c1cef77~ec_OYqh3d0816708167epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629867536;
        bh=PwE5uHqawGK9+a5e4GZ7xRkvV0L8t++bGlmByelV01k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Anc1Kc3WrLERZaXldjLWLQqFFIi4mZ0RUmbGaOdhey/WxrdOI7Zpn23pivbnoL+Rq
         N14CeVs3cWnGqoMMN9PqXcB5OAxgx25EiQKc/MIQ9Ot0lOzKl4opctVgKyfAlKodYJ
         B4aOWZdnuiBYyaflfvqZXaL7J1f8FSkr/WAdgCpQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210825045855epcas1p1ed1771f3f0883f20e011d50fbef613ae~ec_N08ato0955609556epcas1p16;
        Wed, 25 Aug 2021 04:58:55 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.241]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GvYfQ6Cndz4x9Pt; Wed, 25 Aug
        2021 04:58:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.4D.09827.E0EC5216; Wed, 25 Aug 2021 13:58:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210825045853epcas1p39e688eb91dcdd8913d274e499726af3b~ec_L_WYLR0829408294epcas1p3a;
        Wed, 25 Aug 2021 04:58:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210825045853epsmtrp1e299e65f9894a9484ff7c97fb9ae96f9~ec_L9q3lD2443424434epsmtrp1o;
        Wed, 25 Aug 2021 04:58:53 +0000 (GMT)
X-AuditID: b6c32a36-c7bff70000002663-da-6125ce0ea486
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.EA.08750.D0EC5216; Wed, 25 Aug 2021 13:58:53 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210825045853epsmtip24fe65c3623d7b3f34e278ef2090b3d30~ec_Ly6HXB2473024730epsmtip2k;
        Wed, 25 Aug 2021 04:58:53 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH] MAINTAINERS: exfat: update my email address
Date:   Wed, 25 Aug 2021 13:48:33 +0900
Message-Id: <20210825044833.16806-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7bCmgS7fOdVEg4PdBhZz1q9hs9iz9ySL
        xeVdc9gsfkyvd2DxODHjN4tH35ZVjB6fN8kFMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8eb
        mhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYALVNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2Cql
        FqTkFJgV6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfceXyRsWAKa8WHb1ENjItYuhg5OSQETCSO
        T93A2MXIxSEksINRYn3bE3YI5xOjxIZLE5kgnM+MErfm9TDDtPzu2MIGkdjFKHHlzgFWuJb7
        i/8BZTg42AS0Jf5sEQVpEBGQlZj69zzYPmaBDInHvV9YQWxhARuJma+fMYLYLAKqEhs/HmYD
        sXmB4n2bv7FBLJOXWL3hADPIfAmBdnaJL1PuQR3uIrH1yByoImGJV8e3sEPYUhIv+9ug7HKJ
        Eyd/MUHYNRIb5u1jB7lNQsBYoudFCYjJLKApsX6XPkSFosTO33MZIc7kk3j3tYcVoppXoqNN
        CKJEVaLv0mGogdISXe0foBZ5SHR9WgD2lZBArMTJNa1sExhlZyEsWMDIuIpRLLWgODc9tdiw
        wAgeRcn5uZsYwalHy2wH46S3H/QOMTJxMB5ilOBgVhLh/cuknCjEm5JYWZValB9fVJqTWnyI
        0RQYXBOZpUST84HJL68k3tDE0sDEzMjEwtjS2ExJnJfxlUyikEB6YklqdmpqQWoRTB8TB6dU
        A1Nkwp9z0bOrXj336JqSYXfn5eStNo1GM84vTnV+OWf65gd+C1hZfHcWfH2S71jfm39OoWKC
        QXfJC5WCB5/r1vey686f90jxx9lll7/MKpuUb82UJRjesVPuQ/IDkdO7N8zRn3Un3mB5Qr9c
        w4mJadwh005URZ6YHiU052yAWN3GWSapH6dWX/7P+cNLdX/m8RenIlNT2oJTMpI1PxTyxFZF
        T/mbuOlGnlTRadFJsdua2S4HHD5tedB587Ezu48oKyxq85r5jsFu7qdv722Vl7tz9V4RfHPX
        ZqLD2zMyrXuMBe9Nz7v+bdvRDTMC5QOe3RV5OcPzXk+zttmGH9Xxz0TLrv/aGaM/dYPgscIs
        +ZJ8JZbijERDLeai4kQAqPjYdcYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJMWRmVeSWpSXmKPExsWy7bCSvC7vOdVEg55vxhZz1q9hs9iz9ySL
        xeVdc9gsfkyvd2DxODHjN4tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZdx5fJGxYAprxYdv
        UQ2Mi1i6GDk5JARMJH53bGHrYuTiEBLYwShx//0EJoiEtMSxE2eYuxg5gGxhicOHiyFqPjBK
        fHo0lwUkziagLfFniyhIuYiArMTUv+fBwswCWRKzX9mBhIUFbCRmvn7GCGKzCKhKbPx4mA3E
        5gWK923+xgaxSV5i9YYDzBMYeRYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgO
        BS2tHYx7Vn3QO8TIxMF4iFGCg1lJhPcvk3KiEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfj
        hQTSE0tSs1NTC1KLYLJMHJxSDUwBNa9qnbdc3XFEWJfna5JedbEK84rbFi9KvHoObV5lH3vx
        nNmdPdvl9a45zqta1iK9teV7ccGNMFOntsBrrg1TXgq+v325IDR98d7n8qfeTHS2u14lsd/8
        wr5Kg2Uca23YdXTMmnTddW/yT9v2/yGrklw4u857WZEtj5cl+ho9y3xYlPcvPuxne8Jq4YrQ
        9Vs0Pvz8PvvLPI4jod+2VJo9dzTnMjkt9NubIctk47/AadbbWdy3ctnel5F0OuHd/ERPOq/p
        tdeXVZtlm5lftubwXIuJ3l2ac/zumRbJVgPufJ7WGQ1zHi+OvbbBe9Hr45VPFPb0az+Kvbpg
        wtvK60LC3MKCOnuKv9wr5RMV26rEUpyRaKjFXFScCABnL9t9dAIAAA==
X-CMS-MailID: 20210825045853epcas1p39e688eb91dcdd8913d274e499726af3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210825045853epcas1p39e688eb91dcdd8913d274e499726af3b
References: <CGME20210825045853epcas1p39e688eb91dcdd8913d274e499726af3b@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My email address in exfat entry will be not available in a few days.
Update it to my own kernel.org address.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d638f19bbfb..ac2367d1114e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7002,7 +7002,7 @@ F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 
 EXFAT FILE SYSTEM
-M:	Namjae Jeon <namjae.jeon@samsung.com>
+M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Sungjong Seo <sj1557.seo@samsung.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-- 
2.17.1

