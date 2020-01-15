Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A44F913BAF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgAOI2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:28:33 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:56754 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgAOI2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:28:30 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200115082827epoutp04937b90e0e6408620b1f17272efde2564~qAhS1KMAl0574505745epoutp04J
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 08:28:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200115082827epoutp04937b90e0e6408620b1f17272efde2564~qAhS1KMAl0574505745epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579076907;
        bh=VuLy76nAW1zpWZfRklTvRkY12/GY4Q49CsvlPMo2oYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1ZZ2zv4gSQeZqj/1a3C7lcC/Rd5kke+pjL3XucS0L1ySa9bLyzlSy286LPFlATgR
         M2x+i9gIuIoRibA0oNBUsfFLpDMI7efjVMojl3Cr/bqcVU94wHmtoZhFGN/RiP5x36
         Oqt1XM4Dt472ichXWNuqGErUC76EZWisqU7V/1ms=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200115082826epcas1p272e195c703d88ad72b6651781848d659~qAhSWxclX1293712937epcas1p2a;
        Wed, 15 Jan 2020 08:28:26 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47yL7Y3hBSzMqYkt; Wed, 15 Jan
        2020 08:28:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.AE.57028.92DCE1E5; Wed, 15 Jan 2020 17:28:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200115082825epcas1p1f22ddca6dbf5d70e65d3b0e3c25c3a59~qAhQ1adgy1355713557epcas1p1D;
        Wed, 15 Jan 2020 08:28:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200115082825epsmtrp20291efc5240484179245ebac1df5e36b~qAhQ0pIYW1143311433epsmtrp2V;
        Wed, 15 Jan 2020 08:28:25 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-81-5e1ecd297da0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.3C.06569.92DCE1E5; Wed, 15 Jan 2020 17:28:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115082824epsmtip1e2f4ad21954d04a5af2a6f841f4ed71c~qAhQpZtMm0110201102epsmtip1i;
        Wed, 15 Jan 2020 08:28:24 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        arnd@arndb.de, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v10 11/14] exfat: add Kconfig and Makefile
Date:   Wed, 15 Jan 2020 17:24:44 +0900
Message-Id: <20200115082447.19520-12-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115082447.19520-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29nOzlarw0z7MFzzUD+01K05PcnWTYlBBkJQEKEd9DCt3diZ
        lRpLkqmMXJlGYVlSI5gJC1tmpkynaXYxUckWW1gUhUgXpatlbTuz+ve8D8/zvc/7fi+GiE+g
        8ViJwUKbDZSOQIXcjv6ktJSkx5J8WcupBPLXmUE+WXXVjZKu6/c45GTwOUJ29wxzyfGuiyj5
        7dxxsv7hPIf0LAzwyLEPH7lbhZr5H2eA5k5TkK/xNrfxNXf9lajG4WkFmrl2icZ3ewbN4+/T
        qYppqog2S2lDobGoxKBVEzt3F2QXKDNk8hT5JjKTkBooPa0mcnLzUnaU6ELxCOlhSlcaovIo
        hiHSNqvMxlILLS02MhY1QZuKdCa5zJTKUHqm1KBNLTTqs+Qy2UZlSHlAVzw5PMU1OURHR2q9
        aCV4JrQDAQbxdPgk8AC1AyEmxjsBbJt4wWeLWQCdLc+ixRcAf1fN8hctXud41NID4OtAE+ev
        xdV8kmcHGIbi6+FPT2zYsBLfAm9e6OWGNQjeB+DMaHPkpRg8Cy7YGnlhzMXXwZm+ehDGIlwN
        Z6ccPLbbGnj9Ri8SxoIQP+AZj0SC+AAKg5VVUVEOdFf3oCyOgdNDnmjUeDj3PsxjIVwBP3kR
        lq4F8N1XNYsV0O++EcmM4EnQ3ZXG0onwznxzJA6CL4fvP7NjQVwEa6vFrGQddIz1c1i8Gtpr
        PkabauC5Bm90P6cBtL2t454GkqZ/HVoAaAVxtInRa2lGbpL//2PtIHJ/ycpO0DiS6wM4Bohl
        ImkgIV/Mow4zZXofgBhCrBQNnw9RoiKqrJw2GwvMpTqa8QFlaJH1SHxsoTF0zQZLgVy5UaFQ
        kOkZmRlKBbFKlNMiyRfjWspCH6JpE21e9HEwQXwlaN2Q/ivx0l7VrWPicldfcNf3VU+nBf6a
        3CPt1mtX4pxPVvS2eRJSZTk3HRXd5qn7nXWJC943yQMvXvVctcrWDl1EXzbmbysjcRrbn33l
        cs3B0Syrc3usS/VpRfX3R/6lNsowYQwseQ72dGTFFUrO+qzTt1M61jQEupIH620Ny7MJLlNM
        yZMRM0P9AXDeDoOVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnK7mWbk4g93rmC3+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HFgcvj969JjB47Z91l
        99g/dw27x+6bDWwefVtWMXp83iTncWj7G7YA9igum5TUnMyy1CJ9uwSujOsnH7AU9PFWnOvY
        z9bAeIOri5GTQ0LARGL/kstsXYxcHEICuxkljt1exw6RkJY4duIMcxcjB5AtLHH4cDFEzQdG
        iTMtm8HibALaEn+2iIKUiwg4SvTuOswCUsMscJpRonvjQyaQhLCAlcS/1imsIDaLgKrEm4MT
        GUFsXgFbiU8P+lghdslLrN5wgBnE5gSKH9lyGewGIQEbiWlPTjJNYORbwMiwilEytaA4Nz23
        2LDAKC+1XK84Mbe4NC9dLzk/dxMjOEi1tHYwnjgRf4hRgINRiYdX4Y5snBBrYllxZe4hRgkO
        ZiUR3pMzgEK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphakFsFkmTg4pRoY
        Z8/0vJF4W3TnN/+cV32d02ewxZy4m/ObL7y65fGZjvWTrTsEWVxlrjEHRx1Z8jfxomuhySyt
        J4Zno9wVVmlePF/Jdedy9dL/Akk3D/ir9my6GGkS+GZd1gvZmtmydZOuSCyUj606otoiK8Lf
        vZwvxTZBiGl+l2CN9rGVe23uL+Ce/2zZToM3SizFGYmGWsxFxYkAd7CPuk4CAAA=
X-CMS-MailID: 20200115082825epcas1p1f22ddca6dbf5d70e65d3b0e3c25c3a59
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200115082825epcas1p1f22ddca6dbf5d70e65d3b0e3c25c3a59
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
        <CGME20200115082825epcas1p1f22ddca6dbf5d70e65d3b0e3c25c3a59@epcas1p1.samsung.com>
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
index 000000000000..9eeaa6d06adf
--- /dev/null
+++ b/fs/exfat/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config EXFAT_FS
+	tristate "exFAT filesystem support"
+	select NLS
+	help
+	  This allows you to mount devices formatted with the exFAT file system.
+	  exFAT is typically used on SD-Cards or USB sticks.
+
+	  To compile this as a module, choose M here: the module will be called
+	  exfat.
+
+config EXFAT_DEFAULT_IOCHARSET
+	string "Default iocharset for exFAT"
+	default "utf8"
+	depends on EXFAT_FS
+	help
+	  Set this to the default input/output character set you'd
+	  like exFAT to use. It should probably match the character set
+	  that most of your exFAT filesystems use, and can be overridden
+	  with the "iocharset" mount option for exFAT filesystems.
diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
new file mode 100644
index 000000000000..ed51926a4971
--- /dev/null
+++ b/fs/exfat/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for the linux exFAT filesystem support.
+#
+obj-$(CONFIG_EXFAT_FS) += exfat.o
+
+exfat-y	:= inode.o namei.o dir.o super.o fatent.o cache.o nls.o misc.o \
+	   file.o balloc.o
-- 
2.17.1

