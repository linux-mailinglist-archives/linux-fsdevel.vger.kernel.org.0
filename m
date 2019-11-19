Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F7E101A24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 08:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfKSHOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 02:14:18 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:62639 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfKSHOP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:14:15 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191119071411epoutp02ad8468f899d328d6169cdc429b5ed120~YfvL4TLXy1270812708epoutp02P
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 07:14:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191119071411epoutp02ad8468f899d328d6169cdc429b5ed120~YfvL4TLXy1270812708epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574147651;
        bh=W/nvY8vh7b5VKEGm7/5P+NKNPdIjQbHkTzk7gijW0ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgE4msI5KEWw7wEpcgjpQ3zYC1E7/5zKlj7S5SGGpKzRY0Mtt0aimZuRncNdVIxLT
         TRBfkVH/ck6ie3dUhnTm9scRRcYgWsmmD1jJ72LuOyTQBcB+oHKZsGnsibKFOP/d4f
         R23LZejk4LDv7qEQR8RVHol6i6BKLuOoactWMg9o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191119071411epcas1p2416d86ee55e6b22b3aed5de25f9ca934~YfvLdyEFK1339313393epcas1p2W;
        Tue, 19 Nov 2019 07:14:11 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47HHB85C9PzMqYkk; Tue, 19 Nov
        2019 07:14:08 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.E8.04237.04693DD5; Tue, 19 Nov 2019 16:14:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191119071408epcas1p355692e5e4b48c7c08617974715ae636d~YfvIwPL0N2873728737epcas1p3J;
        Tue, 19 Nov 2019 07:14:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191119071408epsmtrp17bf358218355f6e78c3ce1e0abf1e33a~YfvIvoqvK3109231092epsmtrp1A;
        Tue, 19 Nov 2019 07:14:08 +0000 (GMT)
X-AuditID: b6c32a39-913ff7000000108d-31-5dd39640a660
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.14.03654.04693DD5; Tue, 19 Nov 2019 16:14:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191119071408epsmtip1d023d2b9d60ee038189be442732b6d36~YfvInZF7T1409814098epsmtip1D;
        Tue, 19 Nov 2019 07:14:08 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v2 11/13] exfat: add Kconfig and Makefile
Date:   Tue, 19 Nov 2019 02:11:05 -0500
Message-Id: <20191119071107.1947-12-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119071107.1947-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju85yznUmLw7L8MMp5IELL3HFNj6ZlZHVCCaGgKGQd3GGTdmNn
        muaPJMOGVMsoC7tQSWHesbE275hd1S4aiDcqqdQys6J0Ztbm0erf8z7f87zvw/u9OCL7iQXh
        6UYrZzGyelLkjzrvhSrCE4q6UxWOjjA6r6RaRN8uv+9H9wz2IXRD42OU7q67LKJ/Fw9j9NSF
        o7Rjtg2juz5PoAkSxl08KGaar1SImfreXBFz2lEGmG+1q5jWu2Mipv+9E00R79fH6ThWw1nk
        nDHNpEk3auPJpN3qrWpVlIIKp2LoaFJuZA1cPJmYnBK+PV3vTUbKM1l9hpdKYXmejNgUZzFl
        WDm5zsRb40nOrNGbKYV5Pc8a+Ayjdn2ayRBLKRSRKq/yoF7XNrbTbJNmnZnJQ3NBl38BkOCQ
        2AAd44VYAfDHZYQLwIlbPWKh+Apgfef5+eIHgJWl4+iCpcrhQoSHRgA7+6ZFfy3Oyot+BQDH
        RcRaOONY5jMEEJvhnUstqE+DEHcAfFN7c67TUiIGNhZdBD6MEqvhqOsV5sNSIg6OfWwXC9OC
        YXlNC+LDEi9vvzo5FwkSLhEcmp71E0SJsP/TVyDgpfDDQ8e8OQiO2vPFvkCQyIFfmhGBtgE4
        MhkvYCXsra7BfBKECIXVdRECHQLdP6/MdUSIJXD8+0lM6CKFtnyZIFkNT3fdmw+wAhacmJgf
        xEC387CwETuAXTYPcgasKv434BoAZWA5Z+YNWo6nzKr//6sWzB1eWIwLPHia3AoIHJCLpfI1
        3akyjM3ksw2tAOIIGSDdNfQ8VSbVsNlHOItJbcnQc3wrUHn3WIgELUszec/YaFVTqkilUklv
        iIqOUinJQCk+9SJVRmhZK3eI48ycZcHnh0uCcoF7f9aWovbmQWRllSf4/oA2qenwTAdVCm2B
        T04tL/nYnb73WGFZVHHbr5V5zREjhTs877Lb0dBFVJUtS7buGTH7oDpsyPlsX9HZ14/XuRH3
        cXsp02DPwZK3zRzH8s8hnhBJcIpi28ZX33UHHjUF7rkenJ9YoR5wx4o9LxM0N94OkyivY6kw
        xMKzfwCKw+6qjgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnK7DtMuxBme2ilk0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfgxvd5iy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD2KyyYlNSezLLVI3y6BK+PIG8+CDt6KCX+aWRoYL3F1
        MXJySAiYSKzbsoO5i5GLQ0hgN6PE5t4v7BAJaYljJ84AJTiAbGGJw4eLIWo+MEp8bd4PFmcT
        0Jb4s0UUpFxEwFGid9dhFpAaZpA5W6b/YgRJCAtYSuydNgPMZhFQlXi54z4riM0rYCPx5vVp
        qF3yEqs3HGAGsTmB4v3zvoPFhQSsJTYvWsI6gZFvASPDKkbJ1ILi3PTcYsMCw7zUcr3ixNzi
        0rx0veT83E2M4MDU0tzBeHlJ/CFGAQ5GJR7eEyqXY4VYE8uKK3MPMUpwMCuJ8Po9uhArxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnPdp3rFIIYH0xJLU7NTUgtQimCwTB6dUAyO/zHr9isPT1S3W
        6G3fKHtTfGZs5or/7zbYt85m6XjmmTY3oXfv0ned6kYPW7adt9qcq1fhsSJgx33H2W3PtyvL
        yX/pVe0IsuBqvCFya0J+xfnqBb3tF51XchhXNSZLuj4/4HRpmVfDPzv5Y+vXzZxbeUSwt8Hy
        h0nSwbfxBypVzh48zK7qyqXEUpyRaKjFXFScCACILC+bSAIAAA==
X-CMS-MailID: 20191119071408epcas1p355692e5e4b48c7c08617974715ae636d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119071408epcas1p355692e5e4b48c7c08617974715ae636d
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
        <CGME20191119071408epcas1p355692e5e4b48c7c08617974715ae636d@epcas1p3.samsung.com>
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

