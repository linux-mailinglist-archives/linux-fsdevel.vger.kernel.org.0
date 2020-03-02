Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26C81753AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 07:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCBG0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 01:26:30 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22838 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgCBG02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:26:28 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200302062627epoutp0288e5f75eeb39ef9782afdc0738351ba6~4aLMNy20f0078300783epoutp02D
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2020 06:26:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200302062627epoutp0288e5f75eeb39ef9782afdc0738351ba6~4aLMNy20f0078300783epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583130387;
        bh=aYq+qH7aY+nrOnoGX2aQ0vNElB0jP9gBHloF2nfwRtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jrhjz61ERZO904AAXScmwjWhkLtRF9vjsyK81oyoa0xJKPjbsiTThqWzqt8LoYImy
         sK8MrAoPT1xTsi3xZ0/E5FVHDw/vdUrqGDwxkj5hRPHmNiVJdlLWSlRE4IGu45OVJP
         0KAsJ0xlzMQHDzjWp2I+gcnI/rdWHjCJKtauDmgw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200302062626epcas1p47c838d9fe5fc8e1c4d399d624bbb313b~4aLLuC23n2049420494epcas1p4z;
        Mon,  2 Mar 2020 06:26:26 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48W9C54bRkzMqYkq; Mon,  2 Mar
        2020 06:26:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.3D.57028.117AC5E5; Mon,  2 Mar 2020 15:26:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302062625epcas1p200c53fabe17996e92257a409b7a9c857~4aLKdD2BT0851208512epcas1p2C;
        Mon,  2 Mar 2020 06:26:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302062625epsmtrp27cc9f3426a4ae8769a75359e343b402e~4aLKbWVWy1854618546epsmtrp2R;
        Mon,  2 Mar 2020 06:26:25 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-32-5e5ca7115624
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.FA.06569.117AC5E5; Mon,  2 Mar 2020 15:26:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302062625epsmtip281d8cae0b28fe92415580f16cfa6199c~4aLKQg57j2450224502epsmtip2b;
        Mon,  2 Mar 2020 06:26:25 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        linkinjeon@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v14 11/14] exfat: add Kconfig and Makefile
Date:   Mon,  2 Mar 2020 15:21:42 +0900
Message-Id: <20200302062145.1719-12-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302062145.1719-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TWUwTURSGvZ12OkWrQ0G8gkuZBA0YaIdSGLUY45aJgiH64A6OdKRgNztt
        45bYiBFCVNS4oiQuJG4kEGwFKiiLFasGtWoIBh4wRtx3UQHRGQcjb3/++/3n3HMXDFH50Ggs
        3+pkHVbGTKBh0qut8ZrE8PNrs7VPjkyjfh26JacKz1Wh1MXLAQnV0f0UoRoag1Lqkf8USv04
        tpM6eHdAQnmHbsqo0IePUur+rzbZ3NH0QP8hQNeXdcvpG+WVcvpapwel93svAfpLzRS6pfYt
        Stc8fyfJwlabDSaWMbIONWvNtRnzrXnpxJLlOfNz9KlaMpGcSaURaitjYdOJBRlZiYvyzfxG
        CbWbMbt4K4vhOEIzx+CwuZys2mTjnOkEazea7aTWnsQxFs5lzUvKtVlmkVptsp4n15tNgdo+
        1N4TucVXQXqAJ7wEKDCIp8CeM31A0Cq8DsDvgYUlIIzXnwF8/OqCXFzoA/DCWdO/QIOvVCZC
        jQAe69g9nOYTgdaJJQDDUHwGHPSOF+xIPAbeKw1JBB7BPRJY2LTrb9EIfBbsHvChAi/F4+D1
        +s2CrcQN8HhXUC72mgovVzchglbwfpf/ARCZcBg88VwqaIRnCn0nEZEvlMPBhnlCSYgvgMUf
        1ol2BHzd5h0uGQ2/vG9ERWQ7/HRjOFkM4Mvv6aLWwc6qapmAIHg8rPJrRDsW1g+UA7HpWPj+
        216ZWEUJi/eoRCQO7g+1SkQdA0uKPg43peHgz2aJeGalAFYH/PIDQF02YpayEbOU/e98GiCX
        QBRr5yx5LEfayZFXWwP+PtkEfR043J7RAnAMEGOUdb1rslUyxs1ttbQAiCFEpDJTwVtKI7N1
        G+uw5ThcZpZrAXr+1A8i0eNzbfwHsDpzSH2yTqejUlLTUvU6YoKyZ1V8tgrPY5zsJpa1s45/
        OQmmiPYA9+ffK4Cm6+iVZ28TvU1xG8e9MIxuvhMz27tsT1Flb3BKVNzSygKL/WpraGjlgaK1
        EYGOcZW1WmN/xs/mvdcvnuzLTNnxYKr1dpTb/7qXfWhOe6V6Uto/9HXlvoqXIUPClvYCbPKc
        UfFhFX5X7PSHmh9jkg9PerbjjaLcvdgZ3JB03EBIORNDJiAOjvkD6mlx8sgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXldweUycwadVQhZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLH5Mr7eYePo3k8WWf0dYLS69/8Bicf7vcVYHbo/fvyYx
        euycdZfdY//cNeweu282sHn0bVnF6PF5k5zHoe1v2Dw2PXnLFMARxWWTkpqTWZZapG+XwJVx
        dPs3toKHIhVblxg2MDYIdjFyckgImEjs2drPCmILCexmlFjVJgcRl5Y4duIMcxcjB5AtLHH4
        cHEXIxdQyQdGiRVt99hA4mwC2hJ/toiClIsAlZ/pv8QEUsMs0MMk8XnKYiaQhLCAlcTd31vB
        6lkEVCX27SwECfMK2EjMuHOSHWKVvMTqDQeYQWxOoPidXRcYIc6xlnj64i4zRL2gxMmZT1hA
        xjALqEusnycEEmYGam3eOpt5AqPgLCRVsxCqZiGpWsDIvIpRMrWgODc9t9iwwCgvtVyvODG3
        uDQvXS85P3cTIzh+tLR2MJ44EX+IUYCDUYmHd8fz6Dgh1sSy4srcQ4wSHMxKIry+nEAh3pTE
        yqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjFNqHp9au6z3ScaW
        64Gqp05VB/LNfCFyd9lh1reX4sRU5RT3nflXdEXcuCe0+OvPBYomDNc4jpz7XJwmsDLxVlZ6
        7Y5Lppq3ZDkKyh8IqQtPSOQWLHvJmLF1H2/Duq69V3dH39HZvGq9GfMxLma9f6U3b51pL3Wf
        uVhlCu/fs7nt0qGH37p8PqfEUpyRaKjFXFScCAD7mjqwmwIAAA==
X-CMS-MailID: 20200302062625epcas1p200c53fabe17996e92257a409b7a9c857
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200302062625epcas1p200c53fabe17996e92257a409b7a9c857
References: <20200302062145.1719-1-namjae.jeon@samsung.com>
        <CGME20200302062625epcas1p200c53fabe17996e92257a409b7a9c857@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the Kconfig and Makefile for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/Kconfig        |  3 ++-
 fs/Makefile       |  1 +
 fs/exfat/Kconfig  | 21 +++++++++++++++++++++
 fs/exfat/Makefile |  8 ++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 fs/exfat/Kconfig
 create mode 100644 fs/exfat/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 708ba336e689..f08fbbfafd9a 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -140,9 +140,10 @@ endmenu
 endif # BLOCK
 
 if BLOCK
-menu "DOS/FAT/NT Filesystems"
+menu "DOS/FAT/EXFAT/NT Filesystems"
 
 source "fs/fat/Kconfig"
+source "fs/exfat/Kconfig"
 source "fs/ntfs/Kconfig"
 
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 505e51166973..2ce5112b02c8 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
 obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
+obj-$(CONFIG_EXFAT_FS)		+= exfat/
 obj-$(CONFIG_BFS_FS)		+= bfs/
 obj-$(CONFIG_ISO9660_FS)	+= isofs/
 obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+
diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
new file mode 100644
index 000000000000..2d3636dc5b8c
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
+	  Set this to the default input/output character set to use for
+	  converting between the encoding is used for user visible filename and
+	  UTF-16 character that exfat filesystem use, and can be overridden with
+	  the "iocharset" mount option for exFAT filesystems.
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

