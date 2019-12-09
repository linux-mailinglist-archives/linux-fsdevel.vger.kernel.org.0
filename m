Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A38A2116728
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 07:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfLIGzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 01:55:22 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:36498 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfLIGzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:55:10 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191209065505epoutp0191f37015b1c7f58acbb7e5f7c9192548~eoYNl-joP2979529795epoutp01M
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2019 06:55:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191209065505epoutp0191f37015b1c7f58acbb7e5f7c9192548~eoYNl-joP2979529795epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575874505;
        bh=W/nvY8vh7b5VKEGm7/5P+NKNPdIjQbHkTzk7gijW0ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUHrI+5hfTXnjNYe0DyZAah9tt0Z1LCUZO+7jlXCV/FsIVFtf+sKEv697qllRY/Kd
         JvJDbhCnBue909s6mACjJD8/IQNzUQNLSYDsxNXZLRROrWdz27Hut0/9JBQWQttl2W
         KEM4rme7c1V1JDifRG5szh1VJAhJJv5a00X/tS6Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191209065504epcas1p36981f229db8c7954c57ebffc622473f7~eoYNHBTWi0357103571epcas1p3r;
        Mon,  9 Dec 2019 06:55:04 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47WYpv6Y7KzMqYkd; Mon,  9 Dec
        2019 06:55:03 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.97.48019.7CFEDED5; Mon,  9 Dec 2019 15:55:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191209065503epcas1p12d8b47ee6211884a217959e6f54995fb~eoYL0OJ8s3195431954epcas1p12;
        Mon,  9 Dec 2019 06:55:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191209065503epsmtrp14363bdb208e71620761e5cc8bdf7cdf5~eoYLzj4zL2418724187epsmtrp1U;
        Mon,  9 Dec 2019 06:55:03 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-c0-5dedefc751e7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.E9.06569.7CFEDED5; Mon,  9 Dec 2019 15:55:03 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191209065503epsmtip1550f127f9068726bf0abe976f9b94e7c~eoYLowMpY1817618176epsmtip1A;
        Mon,  9 Dec 2019 06:55:03 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v6 11/13] exfat: add Kconfig and Makefile
Date:   Mon,  9 Dec 2019 01:51:46 -0500
Message-Id: <20191209065149.2230-12-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209065149.2230-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmru7x929jDWY80rJoXryezWLl6qNM
        Fnv2nmSxuLxrDpvFj+n1Flv+HWG1uPT+A4sDu8f+uWvYPXbfbGDz6NuyitHj8yY5j0Pb37AF
        sEbl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaGk
        UJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7UyNDAwMgWq
        TMjJOPLGs6CDt2LCn2aWBsZLXF2MnBwSAiYSp+88YO9i5OIQEtjBKLF1w1xmCOcTo8TumVcZ
        IZxvjBLTpuxggWl5/2kDG0RiL6PE28dTWeFaLny7w9TFyMHBJqAt8WeLKEiDiIC9xObZB1hA
        apgFWhglFpz+wQySEBawlNh5soEdpJ5FQFXi5WRNEJNXwEbiT3skxC55idUbDoBVcwKF3/Qc
        ZAIZIyEwh03iwsudjBBFLhK/9nUxQ9jCEq+Ob2GHsKUkXva3gY2XEKiW+LgfqqSDUeLFd1sI
        21ji5voNrCAlzAKaEut36UOEFSV2/p4LNp1ZgE/i3dceVogpvBIdbUIQJaoSfZcOM0HY0hJd
        7R+glnpIzF7XyAIJkH5Gic6Tn9gmMMrNQtiwgJFxFaNYakFxbnpqsWGBCXJ0bWIEpzEtix2M
        e875HGIU4GBU4uFVsHobK8SaWFZcmXuIUYKDWUmEd8nEV7FCvCmJlVWpRfnxRaU5qcWHGE2B
        wTiRWUo0OR+YYvNK4g1NjYyNjS1MzMzNTI2VxHk5flyMFRJITyxJzU5NLUgtgulj4uCUamBk
        M9Ffdo/7fbdEgV7wLGlH45vsTd5nH7F7Cy99GvBjS+r/lkMq1skvOCOPhPKzv83ZYnz/8k/u
        H6kznK/Mf1LH83Lfq+97lKdv1ju2cX/j1/APZj7XftVnrtr93XK9jFxCxu5/1i57BRwv6kXI
        3DYQy7mgz3Jxz9p1T1f3T264c18sYJdu2NMGJZbijERDLeai4kQA7cwDDHkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSnO7x929jDb4tErFoXryezWLl6qNM
        Fnv2nmSxuLxrDpvFj+n1Flv+HWG1uPT+A4sDu8f+uWvYPXbfbGDz6NuyitHj8yY5j0Pb37AF
        sEZx2aSk5mSWpRbp2yVwZRx541nQwVsx4U8zSwPjJa4uRk4OCQETifefNrB1MXJxCAnsZpRY
        3b+bCSIhLXHsxBnmLkYOIFtY4vDhYoiaD4wSV/YvZAeJswloS/zZIgpSLiLgKNG76zALSA2z
        QBejxKOmb8wgCWEBS4mdJxvA6lkEVCVeTtYEMXkFbCT+tEdCbJKXWL3hAFg1J1D4Tc9BsAuE
        BKwlrr5cyjiBkW8BI8MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgYNPS2sF44kT8
        IUYBDkYlHl4Fq7exQqyJZcWVuYcYJTiYlUR4l0x8FSvEm5JYWZValB9fVJqTWnyIUZqDRUmc
        Vz7/WKSQQHpiSWp2ampBahFMlomDU6qBcWrC1JWuu8Ul3vBHR69MWB4kEeHCqrKbt9pXQ0fW
        Utj6u9PeKzsDv36qeDer5+U9AyHh4F3cLsHdk1bntKvK9fSa1S/55nT6weGVR6QX/5y/Q6Dz
        z/FTt1R3ayRVfVeISzvx56V6d94muztOFprzCgXyf80yd63suL/82B/usJoN5em3ePofK7EU
        ZyQaajEXFScCAEV0zFgyAgAA
X-CMS-MailID: 20191209065503epcas1p12d8b47ee6211884a217959e6f54995fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209065503epcas1p12d8b47ee6211884a217959e6f54995fb
References: <20191209065149.2230-1-namjae.jeon@samsung.com>
        <CGME20191209065503epcas1p12d8b47ee6211884a217959e6f54995fb@epcas1p1.samsung.com>
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

