Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570BB3CAFEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 02:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhGPAHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 20:07:10 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:34054 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhGPAHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 20:07:00 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210716000405epoutp04d7fb2a5dd1931a0f3f7781e182fd8e57~SHJXKDApP1787517875epoutp04D
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 00:04:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210716000405epoutp04d7fb2a5dd1931a0f3f7781e182fd8e57~SHJXKDApP1787517875epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626393845;
        bh=6wppFRxEt88l6Qh4NV13BjeI/aY1HZpyZQ+uZNslI6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCkGepwwxe7HApoKJ/L7WXqnldScmkE8RVSQ5eGoJW0C+pjJTRi077gFZ6eEE/Nnm
         QSJGoRaWuzPiCQ+MF4fKHb3zUmfsTlgHRu/Q5JvWZzcJ/geweTlZjjaz8XxiX1WUmF
         dL8hPXsC6egue6Jiwhs89jsnY0ygsUphhOlCMGns=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210716000359epcas1p1976912002fd5566f866d2ad3935b3a1f~SHJSLSUmg2869628696epcas1p1D;
        Fri, 16 Jul 2021 00:03:59 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GQs0Z5qG1z4x9QP; Fri, 16 Jul
        2021 00:03:58 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.AE.10119.EECC0F06; Fri, 16 Jul 2021 09:03:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210716000356epcas1p2ed40bdd5d7ed27393df9fa5fef97d47a~SHJPdfGqG0471604716epcas1p2T;
        Fri, 16 Jul 2021 00:03:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210716000356epsmtrp1d14a75aa07338011b63aba306fa1bfe5~SHJPcbPaQ2134121341epsmtrp1H;
        Fri, 16 Jul 2021 00:03:56 +0000 (GMT)
X-AuditID: b6c32a38-97bff70000002787-a6-60f0cceecf2c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.0B.08394.CECC0F06; Fri, 16 Jul 2021 09:03:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210716000356epsmtip2a73cdb9ffe2f9be8daecb7f7278cb527~SHJPL8DYi1664916649epsmtip2t;
        Fri, 16 Jul 2021 00:03:56 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        senozhatsky@chromium.org, sandeen@sandeen.net, willy@infradead.org,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, dan.carpenter@oracle.com, hch@lst.de,
        christian@brauner.io, smfrench@gmail.com, hyc.lee@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v6 12/13] ksmbd: add Kconfig and Makefile
Date:   Fri, 16 Jul 2021 08:53:55 +0900
Message-Id: <20210715235356.3191-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715235356.3191-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmnu67Mx8SDM5/1bE4/vovu0XjO2WL
        1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y16+z6xWrRe
        0bLYvXERm8WbF4fZLG5NnM9mcf7vcVaL3z/msDkIefyd+5HZY3bDRRaPnbPusntsXqHlsXvB
        ZyaP3Tcb2Dxad/xl9/j49BaLR9+WVYweWxY/ZPL4vEnOY9OTt0wBPFE5NhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAzykplCXmlAKFAhKLi5X07WyK
        8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEqE3IyHsx9zFLwQrVi+rfl
        rA2M5+S7GDk5JARMJP73HWHrYuTiEBLYwSixom0uK0hCSOATo0RzgxtE4hujxO9DNxhhOp4f
        3coEkdjLKHF2xjV2CAeo42zbYiCHg4NNQFvizxZRkAYRgViJGzteM4PUMAt0MUs8vX+GCSQh
        LGApsX7ZbDYQm0VAVWLD7vdgG3gFbCTuPLzJDrFNXmL1hgPMIDYnUPzxyW+MIIMkBM5wSOy7
        s58JoshFYs/MpVC2sMSr41ugmqUkXva3QdnlEidO/oKqqZHYMG8f2KESAsYSPS9KQExmAU2J
        9bv0ISoUJXb+ngt2DrMAn8S7rz2sENW8Eh1tQhAlqhJ9lw5DDZSW6Gr/ALXIQ2L56RvMkEDs
        Z5S4dqpgAqPcLIQFCxgZVzGKpRYU56anFhsWmCDH1yZGcNrVstjBOPftB71DjEwcjIcYJTiY
        lUR4lxq9TRDiTUmsrEotyo8vKs1JLT7EaAoMuonMUqLJ+cDEn1cSb2hqZGxsbGFiZm5maqwk
        zruT7VCCkEB6YklqdmpqQWoRTB8TB6dUA1PiCdnPBar3jddmGnhcnvpJQtxxR/6kjTtae3g3
        vrHPWGvIt9y/+eidU91Lyr7fVz0Ucnbu9EPq62S3GyovCdGq2aPyZ17dui1cLpVsn33K1Z99
        vzNzSeL9q/c5EtbNjHoio2+4VGS10RMbsxn7TmxumTajNJn3vVvgj1iLrtz0iz/6nZUvv013
        dN5ntfnHpK1VO6dpxeUGdvNLlSXVe9yOVI2WT/3h/P1ryuNzMdtX3Y9nXFg3zWM6x59Sxzkx
        ecEVx2P33G9LbOw8wzttyuqYfXX5W3lbTqtfdWusLWd+X97yoJtrFcMhRev6FJZbkVNMNswX
        OaD5XLP4obPgbffggAbBphMJnk8OGPuuMFBiKc5INNRiLipOBADHclBWRAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvO6bMx8SDOYf0bQ4/vovu0XjO2WL
        1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y16+z6xWrRe
        0bLYvXERm8WbF4fZLG5NnM9mcf7vcVaL3z/msDkIefyd+5HZY3bDRRaPnbPusntsXqHlsXvB
        ZyaP3Tcb2Dxad/xl9/j49BaLR9+WVYweWxY/ZPL4vEnOY9OTt0wBPFFcNimpOZllqUX6dglc
        GQ/mPmYpeKFaMf3bctYGxnPyXYycHBICJhLPj25lArGFBHYzSlzYogARl5Y4duIMcxcjB5At
        LHH4cHEXIxdQyQdGiZlzNzOBxNkEtCX+bBEFKRcRiJe42XCbBaSGWWAOs8TOjUcYQRLCApYS
        65fNZgOxWQRUJTbsfg8W5xWwkbjz8CY7xC55idUbDjCD2JxA8ccnvzFC3GMtsX7NBpYJjHwL
        GBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEx4eW5g7G7as+6B1iZOJgPMQowcGs
        JMK71OhtghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1M
        irEd6zzXrOu9NkGQRWJ11rWq7jNn69xfWnw+fWdWyGl+qQnFBn4rD+1pC3Gt0Fz44tP+0ps2
        /kUNgYxZPS5rIlgN6/6U5fQcZ9Wd4P9IedL3dWdmrDdawJy7S+Pp9w1dQpd2MnCWm2jI/FRo
        eCJ1/6Hki116W6VmX936bcUL/n/vxK/affj6hiOn3v+tSGKPGk/Ml4stl1b/eF/SP6nyqx3r
        HXmvL13rjuYcnnbQhLvR6WSGXFLtZM7NMlxcog4FQS3fNNuZftcpXlt0LDn64LJtrIUNrv19
        7S5fXZVNmqqYj5SXlT5muTd/epXoAa31ruvnvnx6YN/7ou3/ROc5yvD489jMfG97ZeaBlsAH
        SizFGYmGWsxFxYkAb75Apv4CAAA=
X-CMS-MailID: 20210716000356epcas1p2ed40bdd5d7ed27393df9fa5fef97d47a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210716000356epcas1p2ed40bdd5d7ed27393df9fa5fef97d47a
References: <20210715235356.3191-1-namjae.jeon@samsung.com>
        <CGME20210716000356epcas1p2ed40bdd5d7ed27393df9fa5fef97d47a@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the Kconfig and Makefile for ksmbd.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/Kconfig        |  1 +
 fs/Makefile       |  1 +
 fs/ksmbd/Kconfig  | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ksmbd/Makefile | 20 ++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 fs/ksmbd/Kconfig
 create mode 100644 fs/ksmbd/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index a7749c126b8e..9237728678cd 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -359,6 +359,7 @@ config NFS_V4_2_SSC_HELPER
 source "net/sunrpc/Kconfig"
 source "fs/ceph/Kconfig"
 source "fs/cifs/Kconfig"
+source "fs/ksmbd/Kconfig"
 source "fs/coda/Kconfig"
 source "fs/afs/Kconfig"
 source "fs/9p/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 9c708e1fbe8f..e03a048b2cd8 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_NLS)		+= nls/
 obj-$(CONFIG_UNICODE)		+= unicode/
 obj-$(CONFIG_SYSV_FS)		+= sysv/
 obj-$(CONFIG_CIFS)		+= cifs/
+obj-$(CONFIG_SMB_SERVER)	+= ksmbd/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS_FS)		+= ntfs/
 obj-$(CONFIG_UFS_FS)		+= ufs/
diff --git a/fs/ksmbd/Kconfig b/fs/ksmbd/Kconfig
new file mode 100644
index 000000000000..e9a5ac01b6e0
--- /dev/null
+++ b/fs/ksmbd/Kconfig
@@ -0,0 +1,69 @@
+config SMB_SERVER
+	tristate "SMB3 server support (EXPERIMENTAL)"
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
+	select FS_POSIX_ACL
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
+	  in ksmbd-tools, available from
+	  https://github.com/cifsd-team/ksmbd-tools.
+	  More detail about how to run the ksmbd kernel server is
+	  available via README file
+	  (https://github.com/cifsd-team/ksmbd-tools/blob/master/README).
+
+	  ksmbd kernel server includes support for auto-negotiation,
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
+	  Prevent unprivileged processes to start the ksmbd kernel server.
+
+config SMB_SERVER_KERBEROS5
+	bool "Support for Kerberos 5"
+	depends on SMB_SERVER
+	default n
diff --git a/fs/ksmbd/Makefile b/fs/ksmbd/Makefile
new file mode 100644
index 000000000000..7d6337a7dee4
--- /dev/null
+++ b/fs/ksmbd/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for Linux SMB3 kernel server
+#
+obj-$(CONFIG_SMB_SERVER) += ksmbd.o
+
+ksmbd-y :=	unicode.o auth.o vfs.o vfs_cache.o server.o ndr.o \
+		misc.o oplock.o connection.o ksmbd_work.o crypto_ctx.o \
+		mgmt/ksmbd_ida.o mgmt/user_config.o mgmt/share_config.o \
+		mgmt/tree_connect.o mgmt/user_session.o smb_common.o \
+		transport_tcp.o transport_ipc.o smbacl.o smb2pdu.o \
+		smb2ops.o smb2misc.o ksmbd_spnego_negtokeninit.asn1.o \
+		ksmbd_spnego_negtokentarg.asn1.o asn1.o
+
+$(obj)/asn1.o: $(obj)/ksmbd_spnego_negtokeninit.asn1.h $(obj)/ksmbd_spnego_negtokentarg.asn1.h
+
+$(obj)/ksmbd_spnego_negtokeninit.asn1.o: $(obj)/ksmbd_spnego_negtokeninit.asn1.c $(obj)/ksmbd_spnego_negtokeninit.asn1.h
+$(obj)/ksmbd_spnego_negtokentarg.asn1.o: $(obj)/ksmbd_spnego_negtokentarg.asn1.c $(obj)/ksmbd_spnego_negtokentarg.asn1.h
+
+ksmbd-$(CONFIG_SMB_SERVER_SMBDIRECT) += transport_rdma.o
-- 
2.17.1

