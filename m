Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424A038BF8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 08:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhEUGi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 02:38:57 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:54217 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhEUGhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 02:37:45 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210521063601epoutp01b5587dfccfc6bf6f200112d36d86d9a8~BAXlshMyI2334323343epoutp01s
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 06:36:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210521063601epoutp01b5587dfccfc6bf6f200112d36d86d9a8~BAXlshMyI2334323343epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621578961;
        bh=BeIIII2iKK1GrbhWKCXgEFhq3Jpub63YFNsLHhAqs/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9cUnGlViwVRUTRECjWXcTcjqzTknZHSSsVA2ICIkG7+0h6qPVguDOOyDWZItJQo4
         RAPgOv8NFup91+SdyObcDnzB+5iYVcZiah22If+DllCY+X7Pkmblym08IiGBhotbbc
         yz/ucvpJTIYWmWpJCBm+2w9BszhEx0uYRugDs0QI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210521063601epcas1p2f606809a24345f74723cbe108d3b56f2~BAXk8aspz0634806348epcas1p2G;
        Fri, 21 May 2021 06:36:01 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FmcLm08qdz4x9Pt; Fri, 21 May
        2021 06:36:00 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.49.10258.FC457A06; Fri, 21 May 2021 15:35:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210521063559epcas1p2d2b26d889e3cd4945e4a6fea4345c0eb~BAXjkDbZ20634706347epcas1p2H;
        Fri, 21 May 2021 06:35:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210521063559epsmtrp1fa2d78d99d08935ff443ef8613d0a92f~BAXjh8OM53156631566epsmtrp1d;
        Fri, 21 May 2021 06:35:59 +0000 (GMT)
X-AuditID: b6c32a38-419ff70000002812-19-60a754cfe417
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.10.08637.FC457A06; Fri, 21 May 2021 15:35:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210521063559epsmtip16c641101b2f893eaa981e8c144027b9c~BAXjTmL8z1754917549epsmtip1k;
        Fri, 21 May 2021 06:35:59 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        willy@infradead.org, Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v3 09/10] cifsd: add Kconfig and Makefile
Date:   Fri, 21 May 2021 15:26:36 +0900
Message-Id: <20210521062637.31347-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210521062637.31347-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGd+5t773F1d0U0EPHAOtXZIKUUjgsoBKMuZn+QZybUWKgo1e+
        Slt72805lI8EnKzD4gwkCIyA2glsQC2CIEQgGzK2EBAQcc4YBwOR8dE5nAhd74rb/nvOm9/z
        vHnfcw6FS64TUipVa2QNWpVGRngIrndvCw7qP2hNDBm+EIlyZvoEqGd6mUTTKyUC1GepwtDV
        2u8wNPJwlkSTzlYc/eVcBOhme68A3WktI9Dzkiz0ReGCEOUNBaK2xioCfeN4TKKnk90EGiv6
        ikD9yz1CtPS8jNjtyVzMHhAwN0ofkMy1rwOZtkoHxrTdyyaYvJZlkpkfHxMwhfYawNirH2FM
        vX1YwDhsfozt1xks7vUjmqgUVqVmDQGsNkmnTtUmR8v2vZcQm6AMD5EHySNRhCxAq8pgo2V7
        9scF7U3VuEaUBXyk0phcpTgVx8l27Iwy6ExGNiBFxxmjZaxerdHLQ/TBnCqDM2mTg5N0Ge/I
        Q0JClS4yUZNy/3EFqe/ddGLZ7BRkg1a/AiCiIB0GLRXtoAB4UBK6BUCLpZ9wHxYAnBpeJHhK
        Qv8J4OBd3SvHw7lRzA21A+iwNQv+dTS0jJMFgKII+m340u7NG7zoo3C0ZRrnGZxuxeFPVZOA
        ZzzpSPjbxEaeEdCb4QN7sZDXYjoanr/YhLmb+cPahls4r0Wu+vhipZDPgfQQBe8tDRB8DqT3
        QGvNITfvCZ/02Em3lsKpc/mr+mN4u/fFamYmbKjoIN1WBTRPGnmJ09tgfesON7EB3lgqB7zG
        6bXw92dmoZsWw8/yJW5kMywc7F4NfBMWnJlbbcTAa+NTpHshFgAbB3IJC/Ar/a9DJQA1YB2r
        5zKSWU6uD/v/ddnAPw84ELWA8pm54C6AUaALQAqXeYnXxFgTJWK16pOTrEGXYDBpWK4LKF2r
        K8Kl3kk61w/QGhPkylCFQoHCwiPClQrZenFy7KeJEjpZZWTTWVbPGl75MEokzcaEN+dHjU35
        k/EDh/23ZIVayxupTPXi2eLODmfHBktG8cLp2gOxJq229MWtoPnmpS8rKn/Imd86pBSd8j53
        4azT1tnOhL/VPngndxfrsC71Xu7pi6lTr1875k/F28pyvo11Bot8D/Zc3v/U67j2vu5KcXz/
        u284j6Udrav2Tf95ZDZmN5cWYLYu+4ukr3VOGOXv19ufXZUqQnedwH3F6Y8mqn2OaDy24sdy
        mz7HckaL48nvxbMlWWtMIxM+NfuurPhtv02nmySzZYcORPzRcSoP/vgyauYDn/G7mYF69MuZ
        sLTmnR9GDpg3nS5KsZRdWrfo2V93Uliy1xzT98Sx5TC1sv24TMClqOSBuIFT/Q1ODDzqSQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnO75kOUJBp+2SVk0vj3NYnH89V92
        i9f/prNYnJ6wiMli5eqjTBbX7r9nt3jxfxezxc//3xkt9uw9yWJxedccNosf0+stevs+sVq0
        XtGy2L1xEZvF2s+P2S3evDjMZnFr4nw2i/N/j7Na/P4xh81B2GN2w0UWj52z7rJ7bF6h5bF7
        wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK4InisklJzcks
        Sy3St0vgyrj9eB57wUmVir89/1kaGHfJdTFyckgImEjc/3CDqYuRi0NIYDejxMP9ncwQCWmJ
        YyfOANkcQLawxOHDxRA1HxglPnzvZwKJswloS/zZIgpSLiIQL3Gz4TYLSA2zwBlmiYaWPSwg
        NcIClhLPnymD1LAIqErc3TKNFcTmFbCVmDR7KxPEKnmJ1RsOgK3lBIo//b4ArEZIwEai5+ZK
        9gmMfAsYGVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTHipbmDsbtqz7oHWJk4mA8
        xCjBwawkwsvtuDxBiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkm
        Dk6pBibx90EnGVTOsHWbz2ETue/Y8kdE9PiubynBh9pSGW0eLHX7zsO18HXCjRPPWg2z/T6c
        mKitELfszxy/tzVHuvh0VCttHucxPdkWXLIo6uuNPVwKJYFb+xatu/T8mcPyR5vr7n8zz1mf
        OOvevfmdjzqOO97bVaYl6LR75kPOV17TTy+Pim133Jdgx7XQQz1QY93Lbk4DBZcQmcmTZXby
        Pvo8J0XnfCBTyb8DN18sf2oezKEVsHqbP1NdRkrfvw+7ukz2BPTkXdeb+W+30z/5YsYg6fMP
        DW5tT0vJZl59/IaqtnXJyZjDUqdyOhL3LfoobRWtKvBi96N5MndWrEp6n3BWfUH/7WtPXL/L
        nmIxEmhSYinOSDTUYi4qTgQAwGyaYQQDAAA=
X-CMS-MailID: 20210521063559epcas1p2d2b26d889e3cd4945e4a6fea4345c0eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210521063559epcas1p2d2b26d889e3cd4945e4a6fea4345c0eb
References: <20210521062637.31347-1-namjae.jeon@samsung.com>
        <CGME20210521063559epcas1p2d2b26d889e3cd4945e4a6fea4345c0eb@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the Kconfig and Makefile for cifsd.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/Kconfig        |  1 +
 fs/Makefile       |  1 +
 fs/cifsd/Kconfig  | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/cifsd/Makefile | 17 ++++++++++++
 4 files changed, 87 insertions(+)
 create mode 100644 fs/cifsd/Kconfig
 create mode 100644 fs/cifsd/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 141a856c50e7..7462761ebd2f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -344,6 +344,7 @@ config NFS_V4_2_SSC_HELPER
 source "net/sunrpc/Kconfig"
 source "fs/ceph/Kconfig"
 source "fs/cifs/Kconfig"
+source "fs/cifsd/Kconfig"
 source "fs/coda/Kconfig"
 source "fs/afs/Kconfig"
 source "fs/9p/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 9c708e1fbe8f..542a77374d12 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_NLS)		+= nls/
 obj-$(CONFIG_UNICODE)		+= unicode/
 obj-$(CONFIG_SYSV_FS)		+= sysv/
 obj-$(CONFIG_CIFS)		+= cifs/
+obj-$(CONFIG_SMB_SERVER)	+= cifsd/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS_FS)		+= ntfs/
 obj-$(CONFIG_UFS_FS)		+= ufs/
diff --git a/fs/cifsd/Kconfig b/fs/cifsd/Kconfig
new file mode 100644
index 000000000000..e6448b04f46e
--- /dev/null
+++ b/fs/cifsd/Kconfig
@@ -0,0 +1,68 @@
+config SMB_SERVER
+	tristate "SMB server support (EXPERIMENTAL)"
+	depends on INET
+	depends on MULTIUSER
+	depends on FILE_LOCKING
+	select NLS
+	select NLS_UTF8
+	select CRYPTO
+	select CRYPTO_MD4
+	select CRYPTO_MD5
+	select CRYPTO_HMAC
+	select CRYPTO_ECB
+	select CRYPTO_LIB_DES
+	select CRYPTO_SHA256
+	select CRYPTO_CMAC
+	select CRYPTO_SHA512
+	select CRYPTO_AEAD2
+	select CRYPTO_CCM
+	select CRYPTO_GCM
+	select ASN1
+	select OID_REGISTRY
+	default n
+	help
+	  Choose Y here if you want to allow SMB3 compliant clients
+	  to access files residing on this system using SMB3 protocol.
+	  To compile the SMB3 server support as a module,
+	  choose M here: the module will be called ksmbd.
+
+	  You may choose to use a samba server instead, in which
+	  case you can choose N here.
+
+	  You also need to install user space programs which can be found
+	  in cifsd-tools, available from
+	  https://github.com/cifsd-team/cifsd-tools.
+	  More detail about how to run the cifsd kernel server is
+	  available via README file
+	  (https://github.com/cifsd-team/cifsd-tools/blob/master/README).
+
+	  cifsd kernel server includes support for auto-negotiation,
+	  Secure negotiate, Pre-authentication integrity, oplock/lease,
+	  compound requests, multi-credit, packet signing, RDMA(smbdirect),
+	  smb3 encryption, copy-offload, secure per-user session
+	  establishment via NTLM or NTLMv2.
+
+config SMB_SERVER_SMBDIRECT
+	bool "Support for SMB Direct protocol"
+	depends on SMB_SERVER=m && INFINIBAND && INFINIBAND_ADDR_TRANS || SMB_SERVER=y && INFINIBAND=y && INFINIBAND_ADDR_TRANS=y
+	select SG_POOL
+	default n
+
+	help
+	  Enables SMB Direct support for SMB 3.0, 3.02 and 3.1.1.
+
+	  SMB Direct allows transferring SMB packets over RDMA. If unsure,
+	  say N.
+
+config SMB_SERVER_CHECK_CAP_NET_ADMIN
+	bool "Enable check network administration capability"
+	depends on SMB_SERVER
+	default y
+
+	help
+	  Prevent unprivileged processes to start the cifsd kernel server.
+
+config SMB_SERVER_KERBEROS5
+	bool "Support for Kerberos 5"
+	depends on SMB_SERVER
+	default n
diff --git a/fs/cifsd/Makefile b/fs/cifsd/Makefile
new file mode 100644
index 000000000000..ccacb798a932
--- /dev/null
+++ b/fs/cifsd/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for Linux SMB3 kernel server
+#
+obj-$(CONFIG_SMB_SERVER) += ksmbd.o
+
+$(obj)/spnego_negtokeninit.asn1.o: $(obj)/spnego_negtokeninit.asn1.c $(obj)/spnego_negtokeninit.asn1.h
+$(obj)/spnego_negtokentarg.asn1.o: $(obj)/spnego_negtokentarg.asn1.c $(obj)/spnego_negtokentarg.asn1.h
+
+ksmbd-y :=	unicode.o auth.o vfs.o vfs_cache.o server.o buffer_pool.o \
+		misc.o oplock.o connection.o ksmbd_work.o crypto_ctx.o \
+		mgmt/ksmbd_ida.o mgmt/user_config.o mgmt/share_config.o \
+		mgmt/tree_connect.o mgmt/user_session.o smb_common.o \
+		transport_tcp.o transport_ipc.o smbacl.o smb2pdu.o \
+		smb2ops.o smb2misc.o spnego_negtokeninit.asn1.o \
+		spnego_negtokentarg.asn1.o asn1.o ndr.o
+ksmbd-$(CONFIG_SMB_SERVER_SMBDIRECT) += transport_rdma.o
-- 
2.17.1

