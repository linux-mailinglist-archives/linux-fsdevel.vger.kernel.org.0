Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0E01275AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 07:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfLTG1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 01:27:44 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:32283 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfLTG1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:27:43 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191220062741epoutp019acbb967bd8eca32ec46c30d1d3de6a9~iAGbmBL2l2292322923epoutp01D
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 06:27:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191220062741epoutp019acbb967bd8eca32ec46c30d1d3de6a9~iAGbmBL2l2292322923epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576823261;
        bh=AzBION1P1SSnBVcusv/wNk1xYVspkZx+OM0dfZawxd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSFh7gZatYy9A+WLVklVthspcNKvyOZR9XY3lkm5B00giG+lIwYkjaboRhsV/+Ft3
         qCrYiyPclSUbcSO4p1nwMAzgcfXbBavPYN6YeTdkpwrE48yUsFPn9J9MEa7NiR2Zid
         N6YZ+TdFFvLGe2/0iYb1nZ3fxsuwxM31OixG4LF4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191220062741epcas1p3afd7e22dba2a5116573b0e5c5e549880~iAGbWApRL2862228622epcas1p3i;
        Fri, 20 Dec 2019 06:27:41 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.159]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47fJhC4dG2zMqYkb; Fri, 20 Dec
        2019 06:27:39 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.DB.48498.BD96CFD5; Fri, 20 Dec 2019 15:27:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191220062739epcas1p4fcda127a4b5a4e06bf53f7da4dbd045c~iAGZnRrzX0237302373epcas1p4Y;
        Fri, 20 Dec 2019 06:27:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220062739epsmtrp1c9468925cafb28c0a4db5ba8bb553b54~iAGZmgxgI2112421124epsmtrp1g;
        Fri, 20 Dec 2019 06:27:39 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-de-5dfc69db04a9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.0A.10238.BD96CFD5; Fri, 20 Dec 2019 15:27:39 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220062739epsmtip17cc32704e0721a6c71cc4beb41dac76d~iAGZZXBq42892228922epsmtip1l;
        Fri, 20 Dec 2019 06:27:39 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v8 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Date:   Fri, 20 Dec 2019 01:24:18 -0500
Message-Id: <20191220062419.23516-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220062419.23516-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+zyXHWOLw9Hqw0jXIQMVdXNunsKVkdiwgkVQVMg66HGudmNn
        SlccCjakzKgoL0FYaKWxYeZdsnmJCiWtKAsRIfJCOrOWhVJtO2b997wvv+d9H77vJRDqCxZB
        GMx2zmZmjTS+Gm3uiUmM/2BYypJVdW5him+7cOZefV8I83b0PcJ0dj1DmVft1Tjz43oh0/Sr
        F2OGvXNoGqFpqxwVaR7fbBBpOkYcuKas6T7QfG2M1HhaPuNa/IgxNY9jcziblDNnW3IMZr2a
        3nNAt0unVMnk8fKtTAotNbMmTk2n79XGZxiM/jy0tIA15vtbWpbn6cTtqTZLvp2T5ll4u5rm
        rDlGq1xmTeBZE59v1idkW0zb5DJZktJPHjPmeYsXcWstcfLtjFPkAF68FIQSkEyGpSXjSClY
        TVBkK4ALv79hQjEPYPNSw3LxHcD5l0Mrlk+TRSCgKbILwL4XG1ccF6pu+CGCwMk4uNS0NsCE
        kzvgw6puNMAgZDWArRcrg+YwUgMnrnUHh6JkNBxeqsUCWkKqYV2LFxOWRcF6dzcS0KH+/qJv
        IiQwCJJuHDoqZhEBSodFC5WooMPg9NMmkaAj4NSlElEgECTPwC+Pl3EngJMLakEr4IjLjQUQ
        hIyBrvZEob0Jti3eDMZEyDVw1ncBE6ZIoLOEEpBoWDbcEyLoDbD0/NzyUg0c9AkBKLIcwLF5
        cTmIrPy34BYA98E6zsqb9Bwvtyb9/1+NIHhusapWUDO41wNIAtBiSVruYhaFsQX8KZMHQAKh
        wyUfnD+zKEkOe+o0Z7PobPlGjvcApf8dLyMRa7Mt/uM123VyZZJCoWCSVSkqpYJeLyF+DGVR
        pJ61cyc4zsrZ/vpCiNAIB3iQGVNxdICf6d/djlYfeTJ+u9eVTm3ZfHWgesc72b4rj1qmHNq5
        gyPPoyIPSX7lfmTFg3WqjoXjBjEC6lLDzz6d9r1hTI13xwxhQ51xd857poeMSadfFxzFupzn
        THTsKsdOxKoaqMAK9/cV4K3NeKwboJOZh70ZA/1TNXG5ahrl81h5LGLj2T+oCvdXhAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnO7tzD+xBiea+S2aF69ns1i5+iiT
        xfW7t5gt9uw9yWJxedccNosf0+sttvw7wmpx6f0HFgcOj52z7rJ77J+7ht1j980GNo++LasY
        PT5vkvM4tP0NWwBbFJdNSmpOZllqkb5dAlfG++bfbAXLOCquv+1gb2B8z9bFyMkhIWAi8exF
        E2MXIxeHkMBuRolrczaxQiSkJY6dOMPcxcgBZAtLHD5cDFHzgVGif1EPO0icTUBb4s8WUZBy
        EQFHid5dh1lAapgFFjFKvPs4GWyOsICHxPOpB8CWsQioSlz6swwszitgK7F8+3uoXfISqzcc
        YAaxOYHiv78+ZwKxhQRsJBq3rWGcwMi3gJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+
        7iZGcBhqae5gvLwk/hCjAAejEg+vQ9rvWCHWxLLiytxDjBIczEoivLc7fsYK8aYkVlalFuXH
        F5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwDi7eeOvzYIbDm9x/K3XGLKO
        99KKHwILEqSeupokCOetfzFxS/6/dcs/BnReD2riFHDxmrri33VHu94lqTtnb5Qy7z/+Puxm
        cVP17vu/3ITWZf2ITE2etOfOg+f32po/VP5q3BIkZmSlZzFH4d6v2RcO7T048fMNwan3PxRF
        dJQfNOyMzbSPufNIiaU4I9FQi7moOBEAZt/Lqz8CAAA=
X-CMS-MailID: 20191220062739epcas1p4fcda127a4b5a4e06bf53f7da4dbd045c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220062739epcas1p4fcda127a4b5a4e06bf53f7da4dbd045c
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
        <CGME20191220062739epcas1p4fcda127a4b5a4e06bf53f7da4dbd045c@epcas1p4.samsung.com>
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

