Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1413F43B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 05:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhHWDKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Aug 2021 23:10:16 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:11840 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhHWDJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Aug 2021 23:09:37 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210823030854epoutp03519d90215f2bad40e7db0d8e3c76bbe6~d0LlUyXV-2616326163epoutp03B
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 03:08:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210823030854epoutp03519d90215f2bad40e7db0d8e3c76bbe6~d0LlUyXV-2616326163epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629688134;
        bh=MC2Fl02a3BEVITF2sB18pyIm/t9CQ5bEb/5ZK3zaAb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+v4sZdF0h+ZQcX7CcII2X2EROa//Dgg2ll0aHenOAgpOhVhOuuWCTFUIboPZcz+M
         4Png024aBQSFSmY3e97J9xh3QoN3pNxLYTGe8kFGyB11FBEoaDjJEC6wEkTlVZB6DF
         dufoVTonYx5Ca201yooJQnN9Q4VHUR8Wvzv/YK1w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210823030853epcas1p4b1e139fa85fe73f850f1b571f9beaaa3~d0LkbiSSe3021430214epcas1p4J;
        Mon, 23 Aug 2021 03:08:53 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GtHJM41m5z4x9QF; Mon, 23 Aug
        2021 03:08:51 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.03.10095.34113216; Mon, 23 Aug 2021 12:08:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210823030851epcas1p2d141386b64cd9039121a9f6a5074a362~d0LiGH2EL2227422274epcas1p2z;
        Mon, 23 Aug 2021 03:08:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210823030851epsmtrp19a5c76bcacc5f0b8e0867f3e6281cb9f~d0LiFLWLI2901829018epsmtrp1G;
        Mon, 23 Aug 2021 03:08:51 +0000 (GMT)
X-AuditID: b6c32a38-691ff7000000276f-64-612311432d64
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.35.09091.24113216; Mon, 23 Aug 2021 12:08:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210823030850epsmtip2d2b41ba624db77d5319d8ed50a78e240~d0Lh400Nh0638306383epsmtip2s;
        Mon, 23 Aug 2021 03:08:50 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        sandeen@sandeen.net, willy@infradead.org, hch@infradead.org,
        senozhatsky@chromium.org, christian@brauner.io,
        viro@zeniv.linux.org.uk, ronniesahlberg@gmail.com, hch@lst.de,
        dan.carpenter@oracle.com, metze@samba.org, smfrench@gmail.com,
        hyc.lee@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v8 12/13] ksmbd: add Kconfig and Makefile
Date:   Mon, 23 Aug 2021 11:58:15 +0900
Message-Id: <20210823025816.7496-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210823025816.7496-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1BUVRTHue+9fbsQm08Qva0kuMQwSwG7sOBdBxwmrd5U01AyI8NU+GLf
        ALK/Zt9ukdMQMCPyqxXQ0eKHClYom4PCFgsbxg+RkCBIxpDUhpLAJQh0BExX2t1H9d/3fO/n
        3HPO/SHCAzpIiShHZ2KNOkYjJf2Ib/pk8qjdG8MYeWVBMBqYcwlR4UIYmntygkBDlY0YOmft
        x9D1X/8Sotm1Thw9XFsB6NuuQQJd66wj0diXDwm0euJj9InlngAdGo9EjouNJPpzto9Ek1Wn
        SPSja0CAHq3WkcmBtKt+CadrC8YIuqPmlpBuOxtJO07fx2jHjQKSPmR3Ceml6UmCru+0ANpi
        awa07cwURt9v3Ua33pnHUsTpuYnZLKNmjaGsLlOvztFlJUlf25uxOyM+Qa6IUqjQDmmojtGy
        SdI9r6dEvZyjcY8pDX2f0ZjdVgrDcdKYXYlGvdnEhmbrOVOSlDWoNYYEQzTHaDmzLitax5p2
        KuTy2Hg3uD83+26hv2EsPG9qfkBQABwhZcBXBCklPDzUCsqAnyiAsgNYdGxZwAf3AJz8o07I
        B8sANthKsTIg8qbcfiDn/S4Af5n0+L58hqNJ5mFI6nn42BbksTdR78AJ+xzu4XGqFoczXVcJ
        z0IgpYJHp+24RxNUOLw0+p1Xi6lEaOlqAXx7IdB6odvr+7r9pWqnt1VITYjgkbZqkof2wM/O
        FhG8DoTOAZuQ1xJ490jxuv4Afj/4N8brj+CFk5eE/DBxsGLW5JE4JYMtnTE8sR12PKr3toBT
        T8OFBxUCnhbDkuIAHgmHlp/61jfcCssOL64XomFH/+c4fzxHALTZfiYqwbaa/yucBqAZbGYN
        nDaL5RQG5X/XlanXtgLvG45EdlA/vxjdCzAR6AVQhEs3iV1YGBMgVjMfHmSN+gyjWcNyvSDe
        fXZVuCQoU+/+BDpThkKpkisTYpUoThWXIN0iBs5gJoDKYkxsLssaWOO/eZjIV1KAFWsTI6q2
        qq/4CDZuWHxz+kyYUP1iOugJGk2nJ84PZwqJWyFDp/bLRnZVlm3OH35mMs3q/Pqm9aSlnRzJ
        6cZfEsUHTbeTyY63uJ32JcOOtvn84/FXbpSWR6V1J5suIvPas42u0dTbKj/88sp7eef3Ba6+
        2vDDXKxdmJu699jBEqfz7S9aaFPESm15UT8VwfVURP8+NN7dszwiWfa/ee3dN8AdazXBOObW
        qmWKV5x5KQtPaKtPft5TjE+7f9O4z4ZPm4J/u266XOIrs+xLk+TFCLWxlsdTM5opcjgz2dTA
        LjxHouaVUqV2EL9aaPbbMnPgwHb5ubbyGtXx5NQXsr+ySQkum1FE4kaO+Qfsj3G+TAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvK6zoHKiwedWJovjr/+yWzS+U7Z4
        /W86i8XpCYuYLFauPspkce3+e3aLF/93MVv8/P+d0WLP3pMsFpd3zWGzuLjsJ4vFj+n1Fr19
        n1gtWq9oWezeuIjN4s2Lw2wWtybOZ7M4//c4q8XvH3PYHIQ9/s79yOwxu+Eii8fOWXfZPTav
        0PLYveAzk8fumw1sHq07/rJ7fHx6i8Vj7q4+Ro++LasYPbYsfsjk8XmTnMemJ2+ZAnijuGxS
        UnMyy1KL9O0SuDJeNvIUXFStePj2OGsD4275LkYODgkBE4l7Xw26GDk5hAR2M0qc2uMIYksI
        SEscO3GGGaJEWOLw4eIuRi6gkg+MEisPtLGBxNkEtCX+bBEFKRcRiJe42XCbBaSGWWA9s8TZ
        100sIAlhAUuJyU93MIPYLAKqEvsu7AezeQVsJPr2rmeE2CUvsXrDAbA4J1D846RXjBD3WEv8
        2bOWaQIj3wJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMHxoqW5g3H7qg96hxiZ
        OBgPMUpwMCuJ8P5lUk4U4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoR
        TJaJg1OqgWnTqb6f2TV+J+bkzt7/J0vMNvRC/LKnFjYq5QsOnWeudj53Tdmi6Mm758+tKvhN
        L8QE/uibvKLnFNPR2MJAxus/BA++v3iiqePW3ti1Nwsbp3Af6tkkVbt88f2Tfx87pDwNX3vO
        SknGj7Ojt05gnoaL2x6vz+85a/4v7s7f+KHHZ1qY2YmmKSrMf023L3w2m92oRk5b2yX0h8WS
        mXE2dybpzTgq8kZ6c8YMxh0LIp9zKXw9KsL7XVd/1cclO46cTJ+mwCAeIVv8VVRmy7ZPEokf
        MiYY3rsy3Uh0XojlLmuWosdOKQaXVBls7s47M+v2mVcuDDcVo1uWPWfI0XkrxbGXL/DpYfPq
        uFXbL9dd+3xZiaU4I9FQi7moOBEAxhEdPQYDAAA=
X-CMS-MailID: 20210823030851epcas1p2d141386b64cd9039121a9f6a5074a362
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210823030851epcas1p2d141386b64cd9039121a9f6a5074a362
References: <20210823025816.7496-1-namjae.jeon@samsung.com>
        <CGME20210823030851epcas1p2d141386b64cd9039121a9f6a5074a362@epcas1p2.samsung.com>
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
 fs/ksmbd/Kconfig  | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ksmbd/Makefile | 20 ++++++++++++++
 4 files changed, 90 insertions(+)
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
index f98f3e691c37..b7e65c39f98d 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_NLS)		+= nls/
 obj-$(CONFIG_UNICODE)		+= unicode/
 obj-$(CONFIG_SYSV_FS)		+= sysv/
 obj-$(CONFIG_CIFS)		+= cifs/
+obj-$(CONFIG_SMB_SERVER)	+= ksmbd/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS_FS)		+= ntfs/
 obj-$(CONFIG_UFS_FS)		+= ufs/
diff --git a/fs/ksmbd/Kconfig b/fs/ksmbd/Kconfig
new file mode 100644
index 000000000000..b83cbd756ae5
--- /dev/null
+++ b/fs/ksmbd/Kconfig
@@ -0,0 +1,68 @@
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

