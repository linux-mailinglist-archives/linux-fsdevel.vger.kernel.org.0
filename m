Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F6104A38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 06:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfKUFaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 00:30:07 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:58284 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfKUF3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:29:24 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191121052922epoutp04de48d8bd498191a1ffd95c5860ebc048~ZFmPibqp42288822888epoutp04h
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 05:29:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191121052922epoutp04de48d8bd498191a1ffd95c5860ebc048~ZFmPibqp42288822888epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574314163;
        bh=W/nvY8vh7b5VKEGm7/5P+NKNPdIjQbHkTzk7gijW0ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEFZ0Otk8o8UQy5dNrFejXModNYn4TniglgN+PusistERayyB44cxvS4+XAGol9tv
         6KuSjUAFdDrzIKcoCZkDYrBH5OZq5oIAZCGhXabf/lkyXNgJlRayGk0FTPIIvEAHMG
         dIfJ2ckRdvB5nAdPsXru+3otONyNMr24ox8j34OY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191121052922epcas1p485af334a8f0c165bafb8369d13e8392c~ZFmPE7R9o2184121841epcas1p4J;
        Thu, 21 Nov 2019 05:29:22 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47JSmK46x7zMqYkV; Thu, 21 Nov
        2019 05:29:21 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.10.04406.1B026DD5; Thu, 21 Nov 2019 14:29:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191121052921epcas1p35c720135e315a34d16800057e8e67829~ZFmNy0YZv1390713907epcas1p3R;
        Thu, 21 Nov 2019 05:29:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191121052921epsmtrp11e8aac9a15108ec63c0d0beabfb68586~ZFmNyEsKT1320713207epsmtrp1_;
        Thu, 21 Nov 2019 05:29:21 +0000 (GMT)
X-AuditID: b6c32a38-95fff70000001136-eb-5dd620b10c3e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.06.03654.1B026DD5; Thu, 21 Nov 2019 14:29:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191121052920epsmtip12a6985b8fe1b27aaeee1a4b55153ef0e~ZFmNo47SW1143211432epsmtip1w;
        Thu, 21 Nov 2019 05:29:20 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v4 11/13] exfat: add Kconfig and Makefile
Date:   Thu, 21 Nov 2019 00:26:16 -0500
Message-Id: <20191121052618.31117-12-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121052618.31117-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ3pdIpWJ1XkpkStE4mCFjqUwrhUTTQ4riH4pKbBESYU7ZZO
        iyIPorggKlYTEVEiUeOuhVKRyqKBGlSCiVUg1BAVAy4hghi3qGiHcXv7z3+/s+TcgyPKg5gK
        z7E6OYeVNZNYBFrbEqvVVKs7jdp9hVPolpdHZXThWQ9GX7pyV0J39YQQuqHxPko/vnUKo3+W
        v5LSX47voH8O7EZp30hASgcHh9DFYxl/eY+MuV1xVcbUdxdgTInvMmA8vg6UqWnLZz54pzLN
        Nwcw5ml/LZomX29eYOLYLM6h5qyZtqwca7aBXLk2Y0mGPllLaai5dAqptrIWzkAuXZWmSc0x
        h4cl1bms2RW20lieJxMWLnDYXE5ObbLxTgPJ2bPMdkprj+dZC++yZsdn2izzKK02UR8mN5pN
        gYHl9iLFNvf3QrQABCOKgRyHRBL0jpTJikEEriTqABwK9SNiMAxgfd8HiRh8AvBC9zm0GOCj
        KUXtKtFvBPCqf6fkb8b1vucSAcKI2fC7L1JoMYlYBGtO3kEFBiG6AOwPlUmFh4nEXNja9wAV
        NErEQLfn3qivIAxwT5UfFeebBq9U3UGEmvKw/+xbnlAHEk8xeL5yQCYOtBSW7mJFfCJ82+qT
        iVoF3xze+xvJh+9vI6JdBODrzwZR62C3p0oqIAgRCz23EkR7OvR/qwCCRojx8N3Hg1KxigIW
        7VWKSAwsCbZIRB0Ni/cN/W7KwM7SakxciBvApo6dMjeYWv6vQyUAl8Fkzs5bsjmesif9/1te
        MHqJcXQdaHi4qhkQOCDHKUyzOoxKKZvL51maAcQRcpKioeuJUanIYvO2cw5bhsNl5vhmoA+v
        8Qiiisy0he/a6syg9Ik6nY5OSk5J1uvIKAX+5ZFRSWSzTm4Lx9k5x588CS5XFQB0zJqtc86s
        +Do/1LlO1/2CS02/vj9dih39kTIrqoFaOTihQnOvKT1u5nBCZWN9aNPhoKapNxqvrstnHwYP
        3fTELDuQu/pj392y+Wkd4+M3z5ux/VDsk5GmR4HNF9taoObEuV5Jf0F79NA1VwmZLHcQsa1e
        1Wn3hsmJN/KOUYEIdYhEeRNLxSEOnv0FQESCXJ8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSnO5GhWuxBh+vMVscfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9Rb/37SwWGz5d4TV4tL7DywO3B47Z91l
        99g/dw27x+6bDWwefVtWMXqs33KVxWPz6WqPz5vkPA5tf8PmcfvZNpYAzigum5TUnMyy1CJ9
        uwSujCNvPAs6eCsm/GlmaWC8xNXFyMEhIWAi0XFWqouRi0NIYDejxPX/i1i6GDmB4tISx06c
        YYaoEZY4fLgYouYDo0TvxAesIHE2AW2JP1tEQcpFBBwlencdZgGpYRZ4zChx4vwTRpCEsICl
        xPGnp8BmsgioSkxYf4IVxOYVsJVo3bATape8xOoNB8B2cQLF7/+uBAkLCdhIXD3xgnUCI98C
        RoZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBoauluYPx8pL4Q4wCHIxKPLwZGldj
        hVgTy4orcw8xSnAwK4nw7rl+JVaINyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZ
        qakFqUUwWSYOTqkGxvlODAJmLx9Is5ZsDLrisPRmfknamaJ92mu+z5FUmyUX0Xl7x9RTn9xe
        dChfnflw148FmkUPlF5//LTm1MaOnYnusY9FBQ5Whcau9Si9dlPl/eGfrrM+1O8+9WTCzOsx
        E9+4FBmYsc9jidKcEWe5sGnXkvOzDKe7rphUH9fEW66lVZ8l9rD2iLESS3FGoqEWc1FxIgAL
        2Qd3WQIAAA==
X-CMS-MailID: 20191121052921epcas1p35c720135e315a34d16800057e8e67829
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191121052921epcas1p35c720135e315a34d16800057e8e67829
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
        <CGME20191121052921epcas1p35c720135e315a34d16800057e8e67829@epcas1p3.samsung.com>
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

