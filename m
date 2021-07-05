Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C53BB574
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 05:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhGEDUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 23:20:25 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48116 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhGEDUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:20:13 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210705031735epoutp013fa905a18224a796dee8a1819c40175d~OxsLk08Wa0684306843epoutp01G
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jul 2021 03:17:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210705031735epoutp013fa905a18224a796dee8a1819c40175d~OxsLk08Wa0684306843epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625455055;
        bh=E8zXyfZrE3G57CVmFE+4hkPLffjZiEjineGKYUfCids=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tC8ilJprccfTrYy07Zv4A19hYL4Cx4uSiYIrDhgu1eeafd/1muYuRGepFFp1brj3w
         2L59IBuo0ZUAHfstBPUeMCufoI+9J+J8BSXA9yiR7JYksSbBUZedK3KRBbQqk9/ZWz
         YfDxv6C96lhph6lqoGWDY+c6fFoIhJQEwrrPQo4g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210705031735epcas1p24205522cf2e4cdaa0e2ed4b379312f41~OxsLE2wyB1374013740epcas1p2l;
        Mon,  5 Jul 2021 03:17:35 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GJ9q22sW3z4x9Q0; Mon,  5 Jul
        2021 03:17:34 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.5E.10119.EC972E06; Mon,  5 Jul 2021 12:17:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210705031733epcas1p48c95e5d2f8edcaa0860b1eb83fc4f8f8~OxsJzJsgl0813108131epcas1p4G;
        Mon,  5 Jul 2021 03:17:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210705031733epsmtrp1388509b678e1a08ebb6f28ee94e24039~OxsJyZo_U0836508365epsmtrp1I;
        Mon,  5 Jul 2021 03:17:33 +0000 (GMT)
X-AuditID: b6c32a38-965ff70000002787-14-60e279ce55b4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.BB.08394.DC972E06; Mon,  5 Jul 2021 12:17:33 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210705031733epsmtip226aa900f3fe3258758b00a1e2bde3ebd~OxsJhtaE42370723707epsmtip2R;
        Mon,  5 Jul 2021 03:17:33 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        willy@infradead.org, hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, dan.carpenter@oracle.com, hch@lst.de,
        christian@brauner.io, smfrench@gmail.com, hyc.lee@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v5 12/13] ksmbd: add Kconfig and Makefile
Date:   Mon,  5 Jul 2021 12:07:28 +0900
Message-Id: <20210705030729.10292-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705030729.10292-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmru65ykcJBgdfc1k0vj3NYnH89V92
        i8Z3yhav/01nsTg9YRGTxcrVR5ksrt1/z27x4v8uZouf/78zWuzZe5LF4vKuOWwWP6bXW/T2
        fWK1aL2iZbF74yI2izcvDrNZ3Jo4n83i/N/jrBa/f8xhcxD2+Dv3I7PH7IaLLB47Z91l99i8
        Qstj94LPTB67bzawebTu+Mvu8fHpLRaPvi2rGD22LH7I5LF+y1UWj8+b5Dw2PXnLFMAblWOT
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA/SmkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ+Pv
        mUOsBS9UK96928XWwHhOvouRg0NCwETixj6NLkYuDiGBHYwSN5+/ZINwPjFKTDnYwArhfGOU
        +LF1C1CGE6zjfetUqMReRonVsyYzw7WsXb2fBWQum4C2xJ8toiANIgKxEjd2vAarYRaYzSxx
        a+cWVpCEsIClxITbPxhB6lkEVCVe9muDmLwCthKzLwtA7JKXWL3hADOIzQkU3tt1lRUifoND
        4u06TgjbReLQqnnMELawxKvjW9ghbCmgiW1QdrnEiZO/mCDsGokN8/axQ3xvLNHzogTEZBbQ
        lFi/Sx+iQlFi5++5jCA2swCfxLuvPawQ1bwSHW1CECWqEn2XDkMNlJboav8AtchDYs/CjyyQ
        8JjAKHH33X3GCYxysxA2LGBkXMUollpQnJueWmxYYIIcW5sYwWlYy2IH49y3H/QOMTJxMB5i
        lOBgVhLhDZ13L0GINyWxsiq1KD++qDQntfgQoykw4CYyS4km5wMzQV5JvKGpkbGxsYWJmbmZ
        qbGSOO9OtkMJQgLpiSWp2ampBalFMH1MHJxSDUx6MjbRE37Z/mcofevaxnlk4WofiRkdHH9P
        yysfvSF/T6b7zBdGn9rfpxoPJdsI33r6zGnawSWX19bmcu/Z414g41a+6qJb6rr0nkdx57iP
        3P02f9G5lfdfFZ2b+lm8+4BYJsu03riFVy7tyo3bqq/5eiNrV2cSr4+2yNtfPmbrHh796+Jk
        xW0sVmsq/rz7kNCzo+Ku6vXL4/cs7LondIyXacMRa7bcUwY9G5faXF+x4Iigfqrei8YV6x8q
        bLYKL6x0DOLoUJ1asv+SS53t9gfvrKM0677nx63+ExB/+dnLXewhyyblPWHazf3hyMI7qYUP
        Gnxuqu8w2TU5v/L3yrNblz5dJCD0Pd0twr449baNEktxRqKhFnNRcSIACO1la0wEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvO7ZykcJBnunGVo0vj3NYnH89V92
        i8Z3yhav/01nsTg9YRGTxcrVR5ksrt1/z27x4v8uZouf/78zWuzZe5LF4vKuOWwWP6bXW/T2
        fWK1aL2iZbF74yI2izcvDrNZ3Jo4n83i/N/jrBa/f8xhcxD2+Dv3I7PH7IaLLB47Z91l99i8
        Qstj94LPTB67bzawebTu+Mvu8fHpLRaPvi2rGD22LH7I5LF+y1UWj8+b5Dw2PXnLFMAbxWWT
        kpqTWZZapG+XwJXx98wh1oIXqhXv3u1ia2A8J9/FyMkhIWAi8b51KmsXIxeHkMBuRomP60+z
        QSSkJY6dOMPcxcgBZAtLHD5cDFHzgVFifssuVpA4m4C2xJ8toiDlIgLxEjcbbrOA1DALrGeW
        eDP1FwtIQljAUmLC7R+MIPUsAqoSL/u1QUxeAVuJ2ZcFIDbJS6zecIAZxOYECu/tusoKYgsJ
        2Eh0//zBOoGRbwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOCI0dLcwbh91Qe9
        Q4xMHIyHGCU4mJVEeEPn3UsQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6Yklqdmpq
        QWoRTJaJg1OqgSnpyvfDTOxPChkrpJ0dObM/2P7+lGuw7JtSnGxp4wzl2ydXFBvOL+JnmqZz
        cWvq3otVW1aEP1EIbZi2ozlWcsGUU+uUuIJz3DTSl3i4tt6wW9DIeP6t1067i3HnRK0u5G/z
        4DERCmbO9t5hmntj1+4LTDklKz4e4V8zdf7JOpeQR0f31O/06HgWFFE/1+kW03vvp2uX3bfj
        2XLtUsu9pBlzbm183JHSN0kyPUQreMIaxTecbPUtr95Hb2h3FNUS+CDoX3drhlDE9TeZSjmd
        MdbZH/IYnv5xt7+9t+k60/8JhjLrzdstF7BPlCiRnnUmgf/Yl21Czo+6Xyrb1SeVz1xdMe2T
        cEnaW/e6br6pukosxRmJhlrMRcWJAMW19BEHAwAA
X-CMS-MailID: 20210705031733epcas1p48c95e5d2f8edcaa0860b1eb83fc4f8f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210705031733epcas1p48c95e5d2f8edcaa0860b1eb83fc4f8f8
References: <20210705030729.10292-1-namjae.jeon@samsung.com>
        <CGME20210705031733epcas1p48c95e5d2f8edcaa0860b1eb83fc4f8f8@epcas1p4.samsung.com>
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
index 141a856c50e7..720c38f484c6 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -344,6 +344,7 @@ config NFS_V4_2_SSC_HELPER
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

