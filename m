Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9668D12E3CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 09:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgABIYN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 03:24:13 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:34790 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgABIYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:24:13 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200102082410epoutp04f5abf633bbb0c4978846418a396b94a2~mBE2j4Ywa0423904239epoutp04D
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2020 08:24:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200102082410epoutp04f5abf633bbb0c4978846418a396b94a2~mBE2j4Ywa0423904239epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577953450;
        bh=AzBION1P1SSnBVcusv/wNk1xYVspkZx+OM0dfZawxd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQZCZQMLCsXxoWcBC5XOOOqD+B9hJQ2xsjsuaf5wfvJR/gnsV+CGzsN783STMTHa2
         6v/t6G0r/D8VX+46L4WD6e4WNw2xOOM9uBRS1rKEeR8ZW3dtPVV9eJpmQQWClw5+L+
         kRUwfxYBbJA5aApVfaEQuj6+BJTH19tcazlXcOfo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200102082410epcas1p3ee8b96c0264eb9f9cfdac8342c46d527~mBE2IdrLR3061930619epcas1p3i;
        Thu,  2 Jan 2020 08:24:10 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47pLfd0nNgzMqYkk; Thu,  2 Jan
        2020 08:24:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.12.57028.9A8AD0E5; Thu,  2 Jan 2020 17:24:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200102082408epcas1p194621a6aa6729011703f0c5a076a7396~mBE0op36r3218732187epcas1p1w;
        Thu,  2 Jan 2020 08:24:08 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200102082408epsmtrp128bbb0a33f8d9b600cea7e795b610f4b~mBE0n5wL_2259122591epsmtrp1A;
        Thu,  2 Jan 2020 08:24:08 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-7f-5e0da8a9cf49
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.88.06569.8A8AD0E5; Thu,  2 Jan 2020 17:24:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200102082408epsmtip23d0d018dc3c9f748066f5cb41b1af119~mBE0aXQZS2457824578epsmtip2k;
        Thu,  2 Jan 2020 08:24:08 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v9 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Date:   Thu,  2 Jan 2020 16:20:35 +0800
Message-Id: <20200102082036.29643-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102082036.29643-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmge7KFbxxBisOs1o0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbTDz9m8liy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wBbBF5dhkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynk
        Jeam2iq5+AToumXmAB2lpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwNCjQK07M
        LS7NS9dLzs+1MjQwMDIFqkzIyXjf/JutYBlHxfW3HewNjO/Zuhg5OSQETCSeN8xi72Lk4hAS
        2MEosXDaW0YI5xOjxLtN+5kgnG+MEvMeX4FreXPsJlTLXkaJLZumI7T0H/4G1MLBwSagLfFn
        iyhIg4iAvcTm2QdYQGqYBTYxSuyZ/5UVJCEs4CGx8dVVJhCbRUBVouHuDzCbV8BWYtf1Tqht
        8hKrNxxgBrE5geIz37eygQySENjCJnH3fD8TRJGLxKHbx1kgbGGJV8e3sEPYUhIv+9vYQQ6S
        EKiW+LifGSLcwSjx4rsthG0scXP9BlaQEmYBTYn1u/QhwooSO3/PZQSxmQX4JN597WGFmMIr
        0dEmBFGiKtF36TDUAdISXe0foBZ5SCyZmQ0JkQmMEqcPXGScwCg3C2HBAkbGVYxiqQXFuemp
        xYYFhsgRtokRnOi0THcwTjnnc4hRgINRiYf3xjyeOCHWxLLiytxDjBIczEoivOWBvHFCvCmJ
        lVWpRfnxRaU5qcWHGE2B4TiRWUo0OR+YhPNK4g1NjYyNjS1MzMzNTI2VxHk5flyMFRJITyxJ
        zU5NLUgtgulj4uCUamBc0NK2UIXLJtJkR3PXCt0VqrtWOYhGP1zp+I/Z7efUAoOV1pMSv9z9
        xc3aJL1yc++suPJNBeK8DUdZevZlcjxepHnfXu5Q+DKj9ZZPww1/298JKn/OcW91+5NX50Rf
        7zkmfXexQP+6Y+LbV4idqN+5RHZu9ZR3V7I4H1y74Z+5asOpicwKS5y1lFiKMxINtZiLihMB
        Oe93jYoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvO6KFbxxBnva9C2aF69ns1i5+iiT
        xfW7t5gt9uw9yWJxedccNosf0+stJp7+zWSx5d8RVotL7z+wOHB67Jx1l91j/9w17B67bzaw
        efRtWcXo8XmTnMeh7W/YAtiiuGxSUnMyy1KL9O0SuDLeN/9mK1jGUXH9bQd7A+N7ti5GTg4J
        AROJN8dusncxcnEICexmlPh4vp0ZIiEtcezEGSCbA8gWljh8uBii5gOjRPP+Z0wgcTYBbYk/
        W0RBykUEHCV6dx1mAalhFtjFKHHi9GlGkISwgIfExldXmUBsFgFViYa7P8BsXgFbiV3XO6GO
        kJdYveEA2F5OoPjM961gcSEBG4lX/x6zTWDkW8DIsIpRMrWgODc9t9iwwCgvtVyvODG3uDQv
        XS85P3cTIzggtbR2MJ44EX+IUYCDUYmH98Y8njgh1sSy4srcQ4wSHMxKIrzlgbxxQrwpiZVV
        qUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhh9De7f4LP567/F8uDp
        n0suvplcZPbtyhq+vvaiwrLV2kvu3pxZdfjsYjujKcdS8zZWLT1RNK/J/Guuz6anOsem8K2L
        K690yQl3yzzwZ0Gt/em2GQlK/y/P9J68bUnUsyUL/9i3Mmx/5fNK+U6FoNrkTYKVay+eOsdg
        dPBrxW3XYyZPrnz4/ihHRomlOCPRUIu5qDgRAPIbDuNEAgAA
X-CMS-MailID: 20200102082408epcas1p194621a6aa6729011703f0c5a076a7396
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082408epcas1p194621a6aa6729011703f0c5a076a7396
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082408epcas1p194621a6aa6729011703f0c5a076a7396@epcas1p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add exfat in fs/Kconfig and fs/Makefile.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/Kconfig  | 3 ++-
 fs/Makefile | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 7b623e9fc1b0..5edd87eb5c13 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -139,9 +139,10 @@ endmenu
 endif # BLOCK
 
 if BLOCK
-menu "DOS/FAT/NT Filesystems"
+menu "DOS/FAT/EXFAT/NT Filesystems"
 
 source "fs/fat/Kconfig"
+source "fs/exfat/Kconfig"
 source "fs/ntfs/Kconfig"
 
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 98be354fdb61..2c7ea7e0a95b 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
 obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
+obj-$(CONFIG_EXFAT)		+= exfat/
 obj-$(CONFIG_BFS_FS)		+= bfs/
 obj-$(CONFIG_ISO9660_FS)	+= isofs/
 obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+
-- 
2.17.1

