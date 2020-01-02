Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D113512E3D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 09:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgABIYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 03:24:37 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:52923 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgABIYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:24:13 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200102082411epoutp0378ab91cd636fc0d1aad87e1b7b72e43e~mBE214wmn3233932339epoutp03B
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2020 08:24:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200102082411epoutp0378ab91cd636fc0d1aad87e1b7b72e43e~mBE214wmn3233932339epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577953451;
        bh=W/nvY8vh7b5VKEGm7/5P+NKNPdIjQbHkTzk7gijW0ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y14UMEyPC8N7vHYb5Pa9C0mNd8AvF888al6G1qQBRALVEfQEkBpGvbiS/Kx3p13LY
         cbxM2SBtxMNn1X14TiLkLFAGrvtmRisA3PTXktho5lqhwcGXWG1yZ9ovFnG2FSMvI1
         QNlzMlcn6C8+ri8940XJS69rYAZkz0VEgRpkrlC4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200102082410epcas1p20401d707ee4bad518820feed6f1f3680~mBE2ce8B81480914809epcas1p2q;
        Thu,  2 Jan 2020 08:24:10 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47pLfc3m8CzMqYkj; Thu,  2 Jan
        2020 08:24:08 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.C1.51241.8A8AD0E5; Thu,  2 Jan 2020 17:24:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200102082408epcas1p28d46af675103d2cd92232a4f7b712c46~mBEz6nkDe1480914809epcas1p2i;
        Thu,  2 Jan 2020 08:24:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200102082408epsmtrp2c10d5b46b46004d915366c2f186147fd~mBEz52yoW2039720397epsmtrp2a;
        Thu,  2 Jan 2020 08:24:08 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-83-5e0da8a8914b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.68.10238.7A8AD0E5; Thu,  2 Jan 2020 17:24:07 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200102082407epsmtip2e61e00a38690d85e4542edfb809756c0~mBEzuQiIA2215622156epsmtip2Z;
        Thu,  2 Jan 2020 08:24:07 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v9 11/13] exfat: add Kconfig and Makefile
Date:   Thu,  2 Jan 2020 16:20:34 +0800
Message-Id: <20200102082036.29643-12-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102082036.29643-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmvu6KFbxxBi8nS1s0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbTDz9m8liy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wBbBF5dhkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynk
        Jeam2iq5+AToumXmAB2lpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwNCjQK07M
        LS7NS9dLzs+1MjQwMDIFqkzIyTjyxrOgg7diwp9mlgbGS1xdjJwcEgImEtsaN7CA2EICOxgl
        przW7mLkArI/MUq8mrmZDcL5xijRcHkPI1zHt/0sEIm9jBLdT98xw7VsevAPKMPBwSagLfFn
        iyhIg4iAvcTm2QfAGpgFNjFK7Jn/lRUkISxgKTGxZQnYVBYBVYmDn3vAbF4BW4nDZ36xQ2yT
        l1i94QAziM0JFJ/5vhXsJAmBLWwSW6ZdgjrJRWLa3scsELawxKvjW6CapSQ+v9vLBnKQhEC1
        xMf9zBDhDkaJF99tIWxjiZvrN7CClDALaEqs36UPEVaU2Pl7Lth0ZgE+iXdfe1ghpvBKdLQJ
        QZSoSvRdOswEYUtLdLV/YIco8ZB4NMcEEiITGCU2rNjDOIFRbhbCggWMjKsYxVILinPTU4sN
        C0yRo2sTIzjJaVnuYDx2zucQowAHoxIP7415PHFCrIllxZW5hxglOJiVRHjLA3njhHhTEiur
        Uovy44tKc1KLDzGaAsNxIrOUaHI+MAHnlcQbmhoZGxtbmJiZm5kaK4nzcvy4GCskkJ5Ykpqd
        mlqQWgTTx8TBKdXA2BdqquiVndO8tmP5vD1vssPCX6+OXCD29p3xQ53k5frnrR/WnHhYbhew
        oLXtkMh2g237Hy1prYlnFVTnmWn7fP9dhX2zso5rW8odeSSj3yh2hjlT8+TXRg6FB4+K3u7j
        qj289rxl8vVYQ0Fb7lvL1vz5ZRtX+/B9a2m/X1f8cZkTbhWpfWd9lFiKMxINtZiLihMBuf5l
        dYgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvO7yFbxxBife21g0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbTDz9m8liy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wBbBFcdmkpOZklqUW6dslcGUceeNZ0MFbMeFPM0sD4yWuLkZODgkB
        E4lt3/azdDFycQgJ7GaUaJjUxAaRkJY4duIMcxcjB5AtLHH4cDFEzQdGiTXfbrOAxNkEtCX+
        bBEFKRcRcJTo3XUYbA6zwC5GiROnTzOCJIQFLCUmtiwBs1kEVCUOfu4Bs3kFbCUOn/nFDrFL
        XmL1hgPMIDYnUHzm+1awG4QEbCRe/XvMNoGRbwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8
        dL3k/NxNjOBw1NLcwXh5SfwhRgEORiUe3hvzeOKEWBPLiitzDzFKcDArifCWB/LGCfGmJFZW
        pRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cBo6r6lPc3H9oWcgevK
        51MOMrrMakm8vXCrYknrokNpv2cYrbmopsD2ZFn93d2W0Rt+iH9P+cKk6r78yImDh79suSy5
        94sVf4UIlzXrsqdZyVY7DZby3RB7afBxzmE5ET2Znucp0T1+b/f5zMpY9jI5e/m8qRXn2uTn
        /G7TuRT4r3767fzzm1lVlViKMxINtZiLihMBWezbcUMCAAA=
X-CMS-MailID: 20200102082408epcas1p28d46af675103d2cd92232a4f7b712c46
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082408epcas1p28d46af675103d2cd92232a4f7b712c46
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082408epcas1p28d46af675103d2cd92232a4f7b712c46@epcas1p2.samsung.com>
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

