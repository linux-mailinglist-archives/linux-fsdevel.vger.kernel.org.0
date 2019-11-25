Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1072D1085D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 01:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKYAHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 19:07:11 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:36358 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfKYAGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:06:37 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191125000635epoutp0395ce336f4f04ab0ca1c1484a63fed1d6~aPxjDzVbf1811818118epoutp03F
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 00:06:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191125000635epoutp0395ce336f4f04ab0ca1c1484a63fed1d6~aPxjDzVbf1811818118epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574640395;
        bh=W/nvY8vh7b5VKEGm7/5P+NKNPdIjQbHkTzk7gijW0ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryPWH02qLt/QI3LbgJZ2P6047A7QOp7pLMUoaOGWfYwp5OXYnJzd2cbRn1cTHLX4U
         F4vA485+rcqJSmzc5unvML+60Bo1mDyf5eqzwjKmgMu2emy6nZ80pd9tijUD51Lqgh
         Jcn73cE1imraiw3GNTHXJ9xUu2a8o8ezXwaKM9sQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191125000635epcas1p232b074485592ac72b3755b740dbae624~aPxi25_XP0613906139epcas1p25;
        Mon, 25 Nov 2019 00:06:35 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47LnQ21TBBzMqYkk; Mon, 25 Nov
        2019 00:06:34 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.64.52419.A0B1BDD5; Mon, 25 Nov 2019 09:06:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191125000633epcas1p3366266bfed68fd63566c086d98988259~aPxhjfJyz0344003440epcas1p3_;
        Mon, 25 Nov 2019 00:06:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191125000633epsmtrp20aa14b368100351b66316a0cfe1e8441~aPxhi0iBn2416924169epsmtrp2i;
        Mon, 25 Nov 2019 00:06:33 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-2b-5ddb1b0a4c33
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.70.10238.90B1BDD5; Mon, 25 Nov 2019 09:06:33 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191125000633epsmtip2643d393189b3747a32e69681c35ed243~aPxhWyod42000720007epsmtip2Z;
        Mon, 25 Nov 2019 00:06:33 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v5 11/13] exfat: add Kconfig and Makefile
Date:   Sun, 24 Nov 2019 19:03:24 -0500
Message-Id: <20191125000326.24561-12-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125000326.24561-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3e3V1Xi8vS+mVgdulloW7N6TVa9pRbWgj1Rw9lXvTixD0u
        u1OyoIaayailBWWaFElQPtqosdKSampWmpRij9nAMjTLSnspJNm2a4//vr9zPud8D+d3cER+
        HAvHc40W1mxk9CQmRd2tUYpo6cL+DMXgfSnVOnhSQhXXOjDqSn27iHru8yLU7ZaHKNXbfA6j
        pquGxdTkmcPU9GgJSrl+tYmpns9j6PpZdFOVT0LfqWmQ0LdeWjHa7qoDtMPVh9LXOw/SX69F
        0J4boxjdP+RG00L26tfqWCabNUeyxixTdq4xR0Om7NRu0qrjFcpoZSKVQEYaGQOrITenpkUn
        5+r9w5KRBYw+3x9KY3iejF231mzKt7CROhNv0ZAsl63nlAouhmcMfL4xJybLZFijVChWq/1k
        pl7XNrqVK5PtL58qRq2gR2oDITgk4uCgoxuxASkuJ24CeLmtAxMeXwBsGP42k/kBoK9kGvlT
        8uy1VRLQcqIFwDd9ur8VJd5hkQ3gOEasglOusAATSiTB69V30QCDEM8BHPJWigOJuUQibPQ+
        CDZCiaWwv9qFBbSM0EDn2zpMMFsE6513g8Yh/viDR+7gRJDox+DFka6gGSQ2w8qBFIGfC993
        uCSCDodfP7VgAnIQjt+Zmb8MwHcTGkGr4EuHUxxAECIKOppjhfBi2PSzBgQ0QsyBn74fEwtd
        ZLCsVC4gS6G9p1Uk6IXQdnRsxpSG7y+MzKytHMBLt3ygHERU/XO4AEAdmMdyvCGH5ZWc6v/v
        ugaCp7gy4SZwdqd6AIEDcrbM2ejNkIuZAr7Q4AEQR8hQWfLjFxlyWTZTeIA1m7TmfD3Le4Da
        v8cKJDwsy+Q/bKNFq1SvVqlUVFx8QrxaRc6X4ZNPM+REDmNh81iWY81/6kR4SLgV4HzL6ROZ
        A5x74Gqlxfpx1459h1KSXSfdE+n2j9vqkKn4hyMRtXqdInUi1ZZXJIqyTzrA+Ctp/QpZ5oai
        dO956yvdlvZTnqLdpcymz+e5SbQ6LWn72aSNvmXypA+9zRXLQzvTh2qb4hKLI3q7xp7sUS2J
        0mrvFeZ1XTlEHFlQaydRXscoVyJmnvkNxS5zcqADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvC6n9O1Yg319KhaHH09it2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLP7Pes5q8WN6vcX/Ny0sFlv+HWG1uPT+A4sDt8fOWXfZ
        PfbPXcPusftmA5tH35ZVjB7rt1xl8dh8utrj8yY5j0Pb37B53H62jSWAM4rLJiU1J7MstUjf
        LoEr48gbz4IO3ooJf5pZGhgvcXUxcnJICJhIXHvYwN7FyMUhJLCbUWLSllPsEAlpiWMnzjB3
        MXIA2cIShw8XQ9R8YJR4cfEVC0icTUBb4s8WUZByEQFHid5dh1lAapgFHjNKnDj/hBEkISxg
        KbH21gmwmSwCqhK3Z29hA7F5BWwlNjxZxQaxS15i9YYDzCA2J1D8xKltYLaQgI1E+6GjbBMY
        +RYwMqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAgOXy3NHYyXl8QfYhTgYFTi4d2w
        9lasEGtiWXFl7iFGCQ5mJRFet7M3YoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5Y
        kpqdmlqQWgSTZeLglGpg1Dp1N1Rqk+OJZsOIrjWJzz64eM8zPrVvk9s74ZbUjh3VErdEV+3m
        zzVTeHXAv8f/48JeYf+ysn+v3jYzHEnRSo7WUMwsyK94UG13yXP9yRufQh5kHt0q+pX7/a49
        i18J+G58vJ/1q/Dimz8fPlwxqyImrWXKSdNHdjmZ91zPTnGqfGZe7xHBpcRSnJFoqMVcVJwI
        ABzRO+hbAgAA
X-CMS-MailID: 20191125000633epcas1p3366266bfed68fd63566c086d98988259
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191125000633epcas1p3366266bfed68fd63566c086d98988259
References: <20191125000326.24561-1-namjae.jeon@samsung.com>
        <CGME20191125000633epcas1p3366266bfed68fd63566c086d98988259@epcas1p3.samsung.com>
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

