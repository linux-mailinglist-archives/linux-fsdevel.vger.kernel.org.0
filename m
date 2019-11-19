Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F42391020EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 10:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfKSJkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 04:40:33 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:28273 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKSJkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:40:33 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191119094030epoutp03511ed30ba0f4a68a1c3cf721441984d4~Yhu74cXJo1838918389epoutp033
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 09:40:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191119094030epoutp03511ed30ba0f4a68a1c3cf721441984d4~Yhu74cXJo1838918389epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574156430;
        bh=W/nvY8vh7b5VKEGm7/5P+NKNPdIjQbHkTzk7gijW0ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gOxU8gkSqCmuaDTzHij2kzAvzVbLJTCAdlynvCC8Ez2/t2NjkVurNSiLEWJGC5ghz
         bBHjfFFViaoZ8xrTZzFNreJZs/PXMl4zQ3laQ3wN6r3Aos2b94QHgEUDh75ibifPCA
         T2QWwd1MxTJqgqTE4ekbmWO4w9OMR1Y5hPC3lTBQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191119094030epcas1p2612217083e19225efdd6fd8be210d1f1~Yhu7cYV4l0375303753epcas1p22;
        Tue, 19 Nov 2019 09:40:30 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.163]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47HLR01HwdzMqYll; Tue, 19 Nov
        2019 09:40:28 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.07.04080.B88B3DD5; Tue, 19 Nov 2019 18:40:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191119094026epcas1p4bee051f56352505eab919011ec740c5d~Yhu4RAffa0056700567epcas1p4m;
        Tue, 19 Nov 2019 09:40:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191119094026epsmtrp244743dfa374fe7756d0f42f594ff68de~Yhu4QQuI50322403224epsmtrp2f;
        Tue, 19 Nov 2019 09:40:26 +0000 (GMT)
X-AuditID: b6c32a37-7cdff70000000ff0-c6-5dd3b88b1c39
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.12.03654.A88B3DD5; Tue, 19 Nov 2019 18:40:26 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191119094026epsmtip26cc73e231a4e2faa3b695b1a0be389c7~Yhu4HBDA10817608176epsmtip2E;
        Tue, 19 Nov 2019 09:40:26 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v3 11/13] exfat: add Kconfig and Makefile
Date:   Tue, 19 Nov 2019 04:37:16 -0500
Message-Id: <20191119093718.3501-12-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119093718.3501-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTQLd7x+VYg3V3WS0OP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzV4sf0eost/46wWlx6/4HFgctj56y77B77565h
        99h9s4HNo2/LKkaPzaerPT5vkvM4tP0Nm8ftZ9tYAjiicmwyUhNTUosUUvOS81My89JtlbyD
        453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgE5UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
        l9gqpRak5BQYGhToFSfmFpfmpesl5+daGRoYGJkCVSbkZBx541nQwVsx4U8zSwPjJa4uRk4O
        CQETieOLJzB1MXJxCAnsYJTY/+MzlPOJUeLg7DnMEM43Ron5y18wwrS0vu5kgUjsZZT4cGYR
        Qsv6ybOAMhwcbALaEn+2iII0iAjYS2yefQCsgVngCKPEiy8T2EFqhAUsJTZMcgGpYRFQlbj9
        6y/YAl4BG4nOvStZIJbJS6zecIAZxOYEij+cvYwRZI6EwBE2icZr69kgilwkJmw5zgphC0u8
        Or6FHcKWkvj8bi8byC4JgWqJj/uZIcIdQDd8t4WwjSVurt/AClLCLKApsX6XPkRYUWLn77lg
        5zAL8Em8+9rDCjGFV6KjTQiiRFWi79JhJghbWqKr/QM7RImHxN05XpAA6WeU+LznAdMERrlZ
        CAsWMDKuYhRLLSjOTU8tNiwwRo6uTYzgBKhlvoNxwzmfQ4wCHIxKPLwK6pdjhVgTy4orcw8x
        SnAwK4nw+j26ECvEm5JYWZValB9fVJqTWnyI0RQYjhOZpUST84HJOa8k3tDUyNjY2MLEzNzM
        1FhJnJfjx8VYIYH0xJLU7NTUgtQimD4mDk6pBkY1/az6I2mucy58PWDQfDxrU8y2qKo1Ezt/
        B5g52lqUGCWr7BZolAi4tO9s5r5u+1eH966+/3yH8oz5LdsXysatW7Rm921dReePm9f01Pyq
        beuKa3JPPbjQTXmpbKbInfdOky42//ohqNGWbNQecfDgDq7MS2HH94qrnmJ9m2ZsOX+FGl/w
        u8NKLMUZiYZazEXFiQDv4GRslgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSvG7XjsuxBl836VocfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9RZb/h1htbj0/gOLA5fHzll32T32z13D
        7rH7ZgObR9+WVYwem09Xe3zeJOdxaPsbNo/bz7axBHBEcdmkpOZklqUW6dslcGUceeNZ0MFb
        MeFPM0sD4yWuLkZODgkBE4nW150sXYxcHEICuxkldk99xwKRkJY4duIMcxcjB5AtLHH4cDFE
        zQdGiTVbJoPF2QS0Jf5sEQUpFxFwlOjddRhsDrPAOUaJnc+WMYLUCAtYSmyY5AJSwyKgKnH7
        119GEJtXwEaic+9KqFXyEqs3HGAGsTmB4g9nLwOrERKwlmh81Mw+gZFvASPDKkbJ1ILi3PTc
        YsMCw7zUcr3ixNzi0rx0veT83E2M4EDV0tzBeHlJ/CFGAQ5GJR7eEyqXY4VYE8uKK3MPMUpw
        MCuJ8Po9uhArxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdp3rFIIYH0xJLU7NTUgtQimCwTB6dU
        A2NsWH5hc9k7wcXTGf12u9psTPx7+dF254N5ySl1Z6IWiZU/E6/g2iUfct/hDpumqFqMa56y
        27HaScdrhZRtDLOFJCprnXflnpO8PLdYuuTEH6vy5I0nnL6uLeP9J8y4UuO+t4udk9iHn1vl
        4mqDHt7sFna1rpEXs1/05dqMrHsem899/awnqcRSnJFoqMVcVJwIAHdZpuZQAgAA
X-CMS-MailID: 20191119094026epcas1p4bee051f56352505eab919011ec740c5d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119094026epcas1p4bee051f56352505eab919011ec740c5d
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
        <CGME20191119094026epcas1p4bee051f56352505eab919011ec740c5d@epcas1p4.samsung.com>
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

