Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52DF397FE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 05:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFBEAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 00:00:35 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:63489 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhFBEAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:00:07 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210602035823epoutp0460f69aaa40b9f5e6dfe8116b4757b8bd~Ep9YcVc-u1379113791epoutp04s
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jun 2021 03:58:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210602035823epoutp0460f69aaa40b9f5e6dfe8116b4757b8bd~Ep9YcVc-u1379113791epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622606303;
        bh=BeIIII2iKK1GrbhWKCXgEFhq3Jpub63YFNsLHhAqs/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYtb/DMKyOxQBpn3PNsXQBPvOOgPHVF6e3VON9GVaJo6kNZ12nwOieHIostQr75rQ
         dNwX7w3Z/ui+AZyJuFI2HGF0kCRScqcadG9Jf8M11EbppvxFxmEHEcBohivB1M+1kB
         Gv5zRgSEmykO9donrOn3ZnsnRWbUTu0A5SNSQI1g=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210602035823epcas1p36f1c7c3073ebee8cc8e7924d2ed6b0be~Ep9X5XakG1757817578epcas1p3x;
        Wed,  2 Jun 2021 03:58:23 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FvwHK5jfpz4x9Pv; Wed,  2 Jun
        2021 03:58:21 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.77.09824.DD107B06; Wed,  2 Jun 2021 12:58:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210602035821epcas1p2bb9cbdcdbd61fe9c66697e944c53f297~Ep9WL2N8U3085430854epcas1p2C;
        Wed,  2 Jun 2021 03:58:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210602035821epsmtrp1867596842b64c689554e47beca0c72e2~Ep9WK8mYF1583215832epsmtrp1N;
        Wed,  2 Jun 2021 03:58:21 +0000 (GMT)
X-AuditID: b6c32a37-061ff70000002660-c5-60b701dd69ee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.25.08637.DD107B06; Wed,  2 Jun 2021 12:58:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210602035821epsmtip258a906049efa7e1fa48aa12878d06168~Ep9V_FgFt3049530495epsmtip2d;
        Wed,  2 Jun 2021 03:58:21 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, stfrench@microsoft.com, willy@infradead.org,
        aurelien.aptel@gmail.com, linux-cifsd-devel@lists.sourceforge.net,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, hch@lst.de, dan.carpenter@oracle.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH v4 09/10] cifsd: add Kconfig and Makefile
Date:   Wed,  2 Jun 2021 12:48:46 +0900
Message-Id: <20210602034847.5371-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602034847.5371-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmge5dxu0JBp2ndSwa355msTj++i+7
        xet/01ksTk9YxGSxcvVRJotr99+zW7z4v4vZ4uf/74wWe/aeZLG4vGsOm8WP6fUWvX2fWC1a
        r2hZ7N64iM1i7efH7BZvXhxms7g1cT6bxfm/x1ktfv+Yw+Yg7DG74SKLx85Zd9k9Nq/Q8ti9
        4DOTx+6bDWwerTv+snt8fHqLxaNvyypGjy2LHzJ5rN9ylcXj8yY5j01P3jIF8ETl2GSkJqak
        Fimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAvaikUJaYUwoUCkgs
        LlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7UyNDAwMgWqTMjJuP14HnvB
        SZWKvz3/WRoYd8l1MXJySAiYSEx61MfSxcjFISSwg1Hi3uqZ7BDOJ0aJrV3PoTLfGCUaFhxm
        hmnZOGUlM0RiL6PE73U/mOBatux/ANTCwcEmoC3xZ4soSIOIQKzEjR2vwRqYBXYxS2y9v4kN
        JCEsYCmx79R5MJtFQFVi8uYDYBt4BWwkPnx7ywSxTV5i9QaIOCdQfPW1KWwQ8QscEr0XPUF2
        SQi4SMz7ZgYRFpZ4dXwLO4QtJfGyvw3KLpc4cfIX1MgaiQ3z9rFDtBpL9LwoATGZBTQl1u/S
        h6hQlNj5ey4jiM0swCfx7msPK0Q1r0RHmxBEiapE36XDUAOlJbraP0AN9JCYMiMZEh79jBJL
        dp5gncAoNwthwQJGxlWMYqkFxbnpqcWGBcbI0bWJEZyAtcx3ME57+0HvECMTB+MhRgkOZiUR
        Xve8rQlCvCmJlVWpRfnxRaU5qcWHGE2BATeRWUo0OR+YA/JK4g1NjYyNjS1MzMzNTI2VxHnT
        nasThATSE0tSs1NTC1KLYPqYODilGpiMv+uKx8wME9Le884q9+2qqu6MkmNntsX/jruk+S0q
        pn32XlvWa5uaszOr8k/Wezeytecx/HlczHtrAnvwxHkl2YvNoifW7uOS0Gg6zXvXe+vE7NMc
        Lx9pa+U+77BVlPXaft3cYsefKXnHVwnNaPzyflexr4BkfSe3xecN1xpSOp10v/zwa/91OjVg
        gVar/KJJTvdME9g0jauuWoerfFg7+ZyKyw71I+te3rH7lDg5Z7X0twJVUUP9d7MKcgRexLAU
        qpYpeR2wvMWmlNDhEeh1KddQb9mKfWcajYOst04u3KafcENk9rpHtof5azzjFz9O9yxXKQir
        dfGw3ufP8KQhKmbC9r0C4jt0Pn72UmIpzkg01GIuKk4EAGoAtS1JBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvO5dxu0JBp8WC1o0vj3NYnH89V92
        i9f/prNYnJ6wiMli5eqjTBbX7r9nt3jxfxezxc//3xkt9uw9yWJxedccNosf0+stevs+sVq0
        XtGy2L1xEZvF2s+P2S3evDjMZnFr4nw2i/N/j7Na/P4xh81B2GN2w0UWj52z7rJ7bF6h5bF7
        wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK4InisklJzcks
        Sy3St0vgyrj9eB57wUmVir89/1kaGHfJdTFyckgImEhsnLKSuYuRi0NIYDejxLqFM9ghEtIS
        x06cAUpwANnCEocPF4OEhQQ+MEp8OeIIEmYT0Jb4s0UUJCwiEC9xs+E2C8gYZoEzzBJPn1wF
        GyMsYCmx79R5NhCbRUBVYvLmA8wgNq+AjcSHb2+ZIFbJS6zeABHnBIqvvjaFDWKXtcTS+fvY
        JzDyLWBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERwrWpo7GLev+qB3iJGJg/EQ
        owQHs5IIr3ve1gQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4
        OKUamGSdBHfp3GhTmaXH8Ftmt5h+bQvXCXH/RNsIlq9PeGTEtwoIvZjVHLWnsadkarTqz3Xm
        u798LVXryf42/WLxTO1d8+WjUhe/ldf9dLbruJ1Jd+KkeZ4K9gm5Niu9BBLWrAy6KT8pv22F
        +TLhfXc4t2Q/UFCv8eLPb2z7XPzRS39txI5tu5QPHdutMMtgU/D/z1d3vZSIldgZOSN50UvO
        DSl/m7bOT1lVMus+X1aq4n6fLe+DZjJGWnWwSRzzW3yF3WZFgvubtsqriXWhwgfWB7h/vPl/
        yqX4KhENq+UCKbkiKQEB7yZrnXU5deM4syr7t5NruRlfrHhw43fuSdU0TT0fFsdZp5Qjc8Xf
        W8oeUmIpzkg01GIuKk4EAFjJTFAEAwAA
X-CMS-MailID: 20210602035821epcas1p2bb9cbdcdbd61fe9c66697e944c53f297
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210602035821epcas1p2bb9cbdcdbd61fe9c66697e944c53f297
References: <20210602034847.5371-1-namjae.jeon@samsung.com>
        <CGME20210602035821epcas1p2bb9cbdcdbd61fe9c66697e944c53f297@epcas1p2.samsung.com>
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

