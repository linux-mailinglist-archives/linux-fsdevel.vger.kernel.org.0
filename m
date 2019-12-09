Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42D811672A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 07:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfLIGz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 01:55:27 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:35997 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfLIGzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:55:09 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191209065505epoutp038171b2015eaa33e6f212ba16fd17a206~eoYN4Wybh2175021750epoutp03V
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2019 06:55:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191209065505epoutp038171b2015eaa33e6f212ba16fd17a206~eoYN4Wybh2175021750epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575874505;
        bh=LzsUvoRQ+/EvYb4sCIgQeQ8VbnU5fmhs4hyN/5tdGrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sn6tYRLxM0aKm3ZEuYw2OGEmOyg/htghJ1ggX1hm/PXogMlx1ZMK+4iSFWhGiFFiH
         yYZddqek8BY5/s4mZbEe8UJG7UPglZQVGIOE2t0WkGZmPBl3EzdJtC4CbZdkOeQQC7
         liFG7JbwPPHGdh655+D7aQs62dbpQjawk5eGwurM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191209065505epcas1p27d477ba56f8d869c50e617129c0bd0cb~eoYNfZBC12291722917epcas1p2c;
        Mon,  9 Dec 2019 06:55:05 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47WYpw1zYTzMqYkX; Mon,  9 Dec
        2019 06:55:04 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.18.51241.8CFEDED5; Mon,  9 Dec 2019 15:55:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191209065503epcas1p3e9efaa9e22ebe270d8827ce34935a58b~eoYMSK5jp0815208152epcas1p3L;
        Mon,  9 Dec 2019 06:55:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191209065503epsmtrp149fbb4e5e1c961748ca522c6d69fb8f1~eoYMRZTV42418724187epsmtrp1W;
        Mon,  9 Dec 2019 06:55:03 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-04-5dedefc8ab3d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.E9.06569.7CFEDED5; Mon,  9 Dec 2019 15:55:03 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191209065503epsmtip165a1c677930f74c9ee8df7f15447390b~eoYMIi-ZZ1944319443epsmtip1Y;
        Mon,  9 Dec 2019 06:55:03 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v6 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Date:   Mon,  9 Dec 2019 01:51:47 -0500
Message-Id: <20191209065149.2230-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209065149.2230-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmnu6J929jDTac5LdoXryezWLl6qNM
        Fnv2nmSxuLxrDpvFj+n1Flv+HWG1uPT+A4sDu8f+uWvYPXbfbGDz6NuyitHj8yY5j0Pb37AF
        sEbl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaGk
        UJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7UyNDAwMgWq
        TMjJmPR5KWPBMo6Ko2u3MzcwvmfrYuTkkBAwkdjQdgbI5uIQEtjBKHFk1xFWCOcTo8TBpr/s
        EM43RonV96YwwrTc/bQbzBYS2Mso8WRSFFzHoVW/gDo4ONgEtCX+bBEFqRERsJfYPPsAC0gN
        s0ALo8SC0z+YQWqEBTwkeu/qgNSwCKhKrPjRDzaTV8BGorf7MRPELnmJ1RsOMIPYnEDxNz0H
        mUDmSAgsYJNY9eAuI8gcCQEXib/rsiDqhSVeHd/CDmFLSbzsb2OHKKmW+LifGSLcwSjx4rst
        hG0scXP9BlaQEmYBTYn1u/QhwooSO3/PBbuGWYBP4t3XHlaIKbwSHW1CECWqEn2XDkMdKS3R
        1f4BainQTz/nM0ECpJ9R4lLbFtYJjHKzEDYsYGRcxSiWWlCcm55abFhgihxdmxjBaUzLcgfj
        sXM+hxgFOBiVeHgVrN7GCrEmlhVX5h5ilOBgVhLhXTLxVawQb0piZVVqUX58UWlOavEhRlNg
        OE5klhJNzgem2LySeENTI2NjYwsTM3MzU2MlcV6OHxdjhQTSE0tSs1NTC1KLYPqYODilGhgl
        Q28v+hb8IzqyaXl989tV+vNC3jvd3Njw2DFIcv+/jz2smWrbE72u3H/ArclZdGAb4xn7Lx0d
        p6cvvaoW9lDG0fmBpBL/jY1bDjmYLe9mkvKJklrvf/JDUVurKMNb3uX7yvZWfujLLVjFzXnD
        PXay/acYj4+y0Qfq4874WIVkRVqeLW7JuaPEUpyRaKjFXFScCAB/AeCzeQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSnO7x929jDf5tMbdoXryezWLl6qNM
        Fnv2nmSxuLxrDpvFj+n1Flv+HWG1uPT+A4sDu8f+uWvYPXbfbGDz6NuyitHj8yY5j0Pb37AF
        sEZx2aSk5mSWpRbp2yVwZUz6vJSxYBlHxdG125kbGN+zdTFyckgImEjc/bSbsYuRi0NIYDej
        xL6vS9ghEtISx06cYe5i5ACyhSUOHy6GqPnAKDH34wImkDibgLbEny2iIOUiAo4SvbsOs4DU
        MAt0MUo8avoG1iss4CHRe1cHpIZFQFVixY9+RhCbV8BGorf7MRPEKnmJ1RsOMIPYnEDxNz0H
        weJCAtYSV18uZZzAyLeAkWEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwwGlp7WA8
        cSL+EKMAB6MSD6+C1dtYIdbEsuLK3EOMEhzMSiK8Sya+ihXiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOK59/LFJIID2xJDU7NbUgtQgmy8TBKdXAWKj1+cnRIwc0XPcv1HSa8OZD7ZUwqds8mUmX
        19Uc/eGgvPXsZJHQVctP+j0oOtP2WUP8mJrrtJnTzbV/swl08jx5mRryt4pfrXWl36sHykLq
        2eUFt9TLN1qW+C7T1dvooVvw8HXAY799u4J02L41cjDxBc18mebKujtT7ZfEY7FLGbt+T97+
        RomlOCPRUIu5qDgRAFl8NyE0AgAA
X-CMS-MailID: 20191209065503epcas1p3e9efaa9e22ebe270d8827ce34935a58b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209065503epcas1p3e9efaa9e22ebe270d8827ce34935a58b
References: <20191209065149.2230-1-namjae.jeon@samsung.com>
        <CGME20191209065503epcas1p3e9efaa9e22ebe270d8827ce34935a58b@epcas1p3.samsung.com>
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

