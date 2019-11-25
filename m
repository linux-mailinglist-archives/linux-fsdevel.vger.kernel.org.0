Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E88A1085C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 01:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfKYAGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 19:06:48 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:26195 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfKYAGj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:06:39 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191125000636epoutp017883b2e43ae73da78b6b4f273d8b1ee5~aPxjyBbKw0821308213epoutp01r
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 00:06:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191125000636epoutp017883b2e43ae73da78b6b4f273d8b1ee5~aPxjyBbKw0821308213epoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574640396;
        bh=LzsUvoRQ+/EvYb4sCIgQeQ8VbnU5fmhs4hyN/5tdGrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjFvSmbGTuMwXiOFyNeWRbXLlMFaPGnE0E2UCC6uEFqW6N6Y97fZVaERTromENiKF
         1Aym3vHlzIaj92GkW3w8sgkqesmK4iTryMhhxdy4RB6UaDwvMI34qNzbVCp+eEkLg7
         mtcPL2Jn+D+mXj3ySrhAAGL5yzz2BGXjJ7xpGF+w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191125000635epcas1p4371a6ba6a147e28e6f4768fbcdaec7fa~aPxjJi5DE0995009950epcas1p43;
        Mon, 25 Nov 2019 00:06:35 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47LnQ23jSszMqYkt; Mon, 25 Nov
        2019 00:06:34 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.32.48019.A0B1BDD5; Mon, 25 Nov 2019 09:06:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191125000634epcas1p4a2d87cec8621b42a85bd94ecc5803e5c~aPxiCzujm0995009950epcas1p4s;
        Mon, 25 Nov 2019 00:06:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191125000634epsmtrp1620710a362cad11c3c3291143670d565~aPxiCCCna2803828038epsmtrp1Y;
        Mon, 25 Nov 2019 00:06:34 +0000 (GMT)
X-AuditID: b6c32a38-6b4789c00001bb93-b1-5ddb1b0a3e96
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.70.10238.A0B1BDD5; Mon, 25 Nov 2019 09:06:34 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191125000634epsmtip2763529189d9616ee8fb80b97f3082760~aPxh23iu21614516145epsmtip2j;
        Mon, 25 Nov 2019 00:06:34 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v5 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Date:   Sun, 24 Nov 2019 19:03:25 -0500
Message-Id: <20191125000326.24561-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125000326.24561-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURTGu87s7Ky2NY1ZFyWzAYkMdcd1dQzXhB4MFCFFBcGyTjqptC92
        1iiFUrISE7MHWGuBGL00Wx+brxRFM02pUKu1lV5U2kPSMh9UVjuOVv/97uH7znc49+AIWYD5
        42kmG281cQYK80Zr29eEhXoHDOpUJ1+vYNrfnJEzRy87MOZGeYcX43ruRpim5vso0994EWN+
        24dlzHTREeb3SA7KOH/dlTF9o2NovA/bYH8uZ1su3ZSzd55lYWyBswywDucTlK3pyWTHqwPZ
        troRjB0cqkUTFHsMsak8l8xbg3hTkjk5zZSipbbs0G/Qa6JUdCgdw0RTQSbOyGupjVsTQjen
        GTzDUkEHOEO6p5TACQIVHhdrNafb+KBUs2DTUrwl2WChVZYwgTMK6aaUsCSzcR2tUkVoPMpE
        Q+qZ8SvAchU/2FFRh2SBUSwPKHBIRMKinHwPe+MkUQ9gy9iATHp8BbDpaLFcekwCmN3Qhcxb
        XM0dMpFJohnAc/a4v47HTVVoHsBxjFgLfzr9RM1SYj2sKW5FRQ1CuAAccp+fNfsSLBy+VS8X
        GSWC4cz1F4joVRJa2D3BSlkrYXll62yuwlPu6q5FxD6QGMTg+alvqCTaCEtLuueG84UfO51y
        if3hh1PH5WJPSGTCLy1zklwA309pJVbDZ45KmShBiDXQ0RgulVfBhh+XgMgIsQh+nsiXSV2U
        MPc4KUmCYUFfu5fEATDvxNhcKAvrxosQaSOFANb3Z6GFIND+L6EEgDKwjLcIxhReoC2R//9X
        NZi9xRCmHjQ93NoGCBxQC5WVFW4dKeMOCIeMbQDiCLVUufnBgI5UJnOHMnirWW9NN/BCG9B4
        9nga8fdLMnsu22TT05oItVrNREZFR2nU1HIlPt2rI4kUzsbv53kLb533eeEK/yxAt8RndNd0
        4nvNuScOl2a3ftou9N2r2Ddc4T7bvGRBYsmAt2Iotm8k/pFxQ3mI+cLTd7venvTZMzHR4Etq
        es5OymY6Y26/bO8JSJq6qlt2cJgp3Xkvze9ascP1elyfnR28baasC3EH5qyme3dzHcQx0pH5
        qrNqk9KuuLt42hXxPZxChVSODkGsAvcH6I0pN6EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvC6X9O1Yg6vruSwOP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzV4sf0eov/b1pYLLb8O8Jqcen9BxYHbo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD3Wb7nK4rH5dLXH501yHoe2v2HzuP1sG0sAZxSXTUpqTmZZapG+
        XQJXxqTPSxkLlnFUHF27nbmB8T1bFyMnh4SAicT1vUdZuxi5OIQEdjNKTD3XzgiRkJY4duIM
        cxcjB5AtLHH4cDFEzQdGiWkvu1hA4mwC2hJ/toiClIsIOEr07jrMAlLDLPCYUeLE+Sdgc4QF
        PCSer9vBDmKzCKhK/F1xD2wmr4CtxKmvHhCr5CVWbzjADGJzAoVPnNoGZgsJ2Ei0HzrKNoGR
        bwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjODw1dLcwXh5SfwhRgEORiUe3g1r
        b8UKsSaWFVfmHmKU4GBWEuF1O3sjVog3JbGyKrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6Ykl
        qdmpqQWpRTBZJg5OqQbGWdZL/mw/mvzzi+jSP4pXFkXu5ArYI8J3aFL5ff64qw6BfZpnfa1Z
        r/PpuQnHP9zZcuZTf/4hZvOgT92bLJSAITK5fWdD55wXs14wL50jPcvRLmIDh4TX/ydXP1i1
        n2LV/LwpeNdqtw37r3Pd3/vJiX3+L6turgPPGLfduej3rPHpfku/tf1aSizFGYmGWsxFxYkA
        xGygR1sCAAA=
X-CMS-MailID: 20191125000634epcas1p4a2d87cec8621b42a85bd94ecc5803e5c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191125000634epcas1p4a2d87cec8621b42a85bd94ecc5803e5c
References: <20191125000326.24561-1-namjae.jeon@samsung.com>
        <CGME20191125000634epcas1p4a2d87cec8621b42a85bd94ecc5803e5c@epcas1p4.samsung.com>
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
index 1148c555c4d3..4358dda56b1e 100644
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

