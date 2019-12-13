Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1DFB11DDFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 06:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfLMFx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 00:53:58 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:21453 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732156AbfLMFxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:53:52 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191213055350epoutp033017ec342ba32455d932b750501c810a~f2H4E3rFM1448214482epoutp03B
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 05:53:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191213055350epoutp033017ec342ba32455d932b750501c810a~f2H4E3rFM1448214482epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576216430;
        bh=W/nvY8vh7b5VKEGm7/5P+NKNPdIjQbHkTzk7gijW0ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGOWmE8ApaJMftowS7GKiRIiDL0CoVo7g5HYegl9RrgfIjzpbQLRj3Jv9CH+2G9Rx
         aSSqYuCLngwsGbxzlYDZoVebkv1B0MRkEmBrVtCj8/9K/Tu0P5w4cUSlOaNFjPyTbE
         fWu3om3SZTO7kRzrHKj30VzTG9m8Jx/ZnMXMkEdc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191213055348epcas1p1aaec0360e2e65b6ca53b2d64eae9264c~f2H2K1ZGO0207402074epcas1p1H;
        Fri, 13 Dec 2019 05:53:48 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47Z0GM0mHZzMqYlv; Fri, 13 Dec
        2019 05:53:47 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.BA.57028.86723FD5; Fri, 13 Dec 2019 14:53:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191213055344epcas1p4445bead283b45a45eab868907774d529~f2HyRtdJc0917809178epcas1p4C;
        Fri, 13 Dec 2019 05:53:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213055344epsmtrp1162ef4398bcabbffc0d14301ba4772bf~f2HyRHtX30538305383epsmtrp1b;
        Fri, 13 Dec 2019 05:53:44 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-17-5df327687c5a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.92.06569.76723FD5; Fri, 13 Dec 2019 14:53:44 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213055343epsmtip29af0a4f3d74e7c295f91d09fb907380d~f2HyGpSn81079710797epsmtip2L;
        Fri, 13 Dec 2019 05:53:43 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v7 11/13] exfat: add Kconfig and Makefile
Date:   Fri, 13 Dec 2019 00:50:26 -0500
Message-Id: <20191213055028.5574-12-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213055028.5574-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmgW6G+udYg4M3RSyaF69ns1i5+iiT
        xZ69J1ksLu+aw2bxY3q9xZZ/R1gtLr3/wOLA7rF/7hp2j903G9g8+rasYvT4vEnO49D2N2wB
        rFE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVygp
        lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEq
        E3IyjrzxLOjgrZjwp5mlgfESVxcjJ4eEgInE6UknGLsYuTiEBHYwSkw69pYVwvnEKHGhYxYL
        hPONUeLbyePsMC1LTt9ghkjsZZR4tOMzQsvO58eBHA4ONgFtiT9bREEaRATsJTbPPgA2iVmg
        hVFiwekfzCAJYQFLiV233oLZLAKqEl03b7KA2LwCNhJnpp1hgdgmL7F6wwGwGk6g+LzJH9hB
        BkkILGCTODWrjQ2iyEXi8rcZUOcJS7w6vgXKlpJ42d/GDnKQhEC1xMf9zBDhDkaJF99tIWxj
        iZvrN4DdzCygKbF+lz5EWFFi5++5jCA2swCfxLuvPawQU3glOtqEIEpUJfouHWaCsKUluto/
        QC31kGg/8xEaJP2MEmvOrmWewCg3C2HDAkbGVYxiqQXFuempxYYFhsgRtokRnMq0THcwTjnn
        c4hRgINRiYd3ReKnWCHWxLLiytxDjBIczEoivPY1QCHelMTKqtSi/Pii0pzU4kOMpsCAnMgs
        JZqcD0yzeSXxhqZGxsbGFiZm5mamxkrivBw/LsYKCaQnlqRmp6YWpBbB9DFxcEo1MK6e+O9q
        z/7iFzmirPc6511ZcNZ97uzJTCr+pgotnjmr1Ks0vk8X94u2ubdswgURnR8ySvtmv71nlqnK
        Nc2g9tXuOzr3rso/zuT9WHPvy+xNWhLWyQkGT+a45ssa3a+e1Zrz98cbNo5bZ6/2zOntWXgv
        +cbH9wLyrs9PhBz+XTphv+X5Bz6tqlOVWIozEg21mIuKEwFRWZP/ewMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSvG6G+udYg9svGS2aF69ns1i5+iiT
        xZ69J1ksLu+aw2bxY3q9xZZ/R1gtLr3/wOLA7rF/7hp2j903G9g8+rasYvT4vEnO49D2N2wB
        rFFcNimpOZllqUX6dglcGUfeeBZ08FZM+NPM0sB4iauLkZNDQsBEYsnpG8xdjFwcQgK7GSV2
        Xj/GCJGQljh24gxQggPIFpY4fLgYouYDo8TeRy2MIHE2AW2JP1tEQcpFBBwlencdZgGpYRbo
        YpR41PSNGSQhLGApsevWWzCbRUBVouvmTRYQm1fARuLMtDMsELvkJVZvOABWwwkUnzf5AzuI
        LSRgLXH37Su2CYx8CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBAecltYOxhMn
        4g8xCnAwKvHwrkj8FCvEmlhWXJl7iFGCg1lJhNe+BijEm5JYWZValB9fVJqTWnyIUZqDRUmc
        Vz7/WKSQQHpiSWp2ampBahFMlomDU6qBMfrxB5YTT2/fPsaZtSTimECs5JcZ26f5Jdarsa3V
        ntW5cHLR5aNrPxjNq1x55/uXa8s8xI/7u0x+0SHEMDnkkVKAudqj1+FP6lbfnnMpa+nS62oP
        /rvcbykzXq3ycVbp8uhTEuue3Xudv+tdfkzk2nff3E3KzJZeEMreGT9trlul+ZWivgnWvKVK
        LMUZiYZazEXFiQDFSRtBNAIAAA==
X-CMS-MailID: 20191213055344epcas1p4445bead283b45a45eab868907774d529
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191213055344epcas1p4445bead283b45a45eab868907774d529
References: <20191213055028.5574-1-namjae.jeon@samsung.com>
        <CGME20191213055344epcas1p4445bead283b45a45eab868907774d529@epcas1p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the Kconfig and Makefile for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/Kconfig  | 21 +++++++++++++++++++++
 fs/exfat/Makefile |  8 ++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 fs/exfat/Kconfig
 create mode 100644 fs/exfat/Makefile

diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
new file mode 100644
index 000000000000..11d841a5f7f0
--- /dev/null
+++ b/fs/exfat/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config EXFAT
+	tristate "exFAT filesystem support"
+	select NLS
+	help
+	  This allows you to mount devices formatted with the exFAT file system.
+	  exFAT is typically used on SD-Cards or USB sticks.
+
+	  To compile this as a module, choose M here: the module will be called
+	  exfat.
+
+config EXFAT_FS_DEFAULT_IOCHARSET
+	string "Default iocharset for exFAT"
+	default "utf8"
+	depends on EXFAT
+	help
+	  Set this to the default input/output character set you'd
+	  like exFAT to use. It should probably match the character set
+	  that most of your exFAT filesystems use, and can be overridden
+	  with the "iocharset" mount option for exFAT filesystems.
diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
new file mode 100644
index 000000000000..e9193346c80c
--- /dev/null
+++ b/fs/exfat/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for the linux exFAT filesystem support.
+#
+obj-$(CONFIG_EXFAT) += exfat.o
+
+exfat-y	:= inode.o namei.o dir.o super.o fatent.o cache.o nls.o misc.o \
+	   file.o balloc.o
-- 
2.17.1

