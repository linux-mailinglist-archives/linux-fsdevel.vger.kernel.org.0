Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945D3343847
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 06:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCVFWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 01:22:49 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34377 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCVFWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 01:22:12 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210322052210epoutp018132f0b945c6464cbf65c202c4ea0ca3~ukp_3F9jY2636526365epoutp01e
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 05:22:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210322052210epoutp018132f0b945c6464cbf65c202c4ea0ca3~ukp_3F9jY2636526365epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616390530;
        bh=M28OwHLyWcp/EY7MC/OJQBYN1Av5VMcoyOZI6xRD/M8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+UIKHXbgsDO8mYgvRIfl0UXBh6BYD+rx8+xz8K7Y7IsCb4MxLYG33cR1VgZu/zwV
         P3G8zicbvwPy/IngWGDK8ZoP7heEDsM6W8jgRAWuv41KAlt8rfwLSQgSXfDQUUb4xg
         JKIdgtHQuStu5mOoc/VUe9qurkr2PTxDw7GTXUo0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210322052210epcas1p30aeb01c9e37671356eee3104d6c2468b~ukp_Idy8T1871018710epcas1p3b;
        Mon, 22 Mar 2021 05:22:10 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F3jYF1SJjz4x9Q9; Mon, 22 Mar
        2021 05:22:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.FF.10347.18928506; Mon, 22 Mar 2021 14:22:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210322052208epcas1p430b2e93761d5194844c533c61d43242d~ukp8sVzcc0640406404epcas1p4S;
        Mon, 22 Mar 2021 05:22:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210322052208epsmtrp27425330e616ef6d09f668b7ecdd27f87~ukp8rNLFc0546105461epsmtrp2p;
        Mon, 22 Mar 2021 05:22:08 +0000 (GMT)
X-AuditID: b6c32a39-15dff7000002286b-2a-60582981a5ac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.06.13470.08928506; Mon, 22 Mar 2021 14:22:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210322052208epsmtip1e716fc91d5b3321fc1c970ff1e5a5006~ukp8ann_71797317973epsmtip1S;
        Mon, 22 Mar 2021 05:22:08 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4/5] cifsd: add Kconfig and Makefile
Date:   Mon, 22 Mar 2021 14:13:43 +0900
Message-Id: <20210322051344.1706-5-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210322051344.1706-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmvm6jZkSCwZb5bBaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y3e
        3gGq7e37xGrRekXLYvfGRWwWaz8/Zrd48+Iwm8WtiUDDz/89zuog4jGroZfNY3bDRRaPnbPu
        sntsXqHlsXvBZyaP3Tcb2Dxad/xl9/j49BaLR9+WVYweWxY/ZPJYv+Uqi8fnTXIem568ZQrg
        jcqxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAF6Vkmh
        LDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2VoYGBkClSZ
        kJMx9UMzS8FrxYqT526wNzD+le5i5OSQEDCR2PtvF1sXIxeHkMAORoklGx8xQTifGCVe/uuD
        ynxjlOib/IAFpuX4m5lgtpDAXkaJUytE4Do2bX3L3sXIwcEmoC3xZ4soSI2IQKzEjR2vmUFq
        mAWuMUscXzCTESQhDDToxpeFrCA2i4CqxPaNW8HivALWEhfWn2OEWCYvsXrDAWYQm1PARmLa
        8k4WkEESAg84JC50tjBBFLlI/DvxmBnCFpZ4dXwLO4QtJfH53V42kIMkBKolPu6HKulglHjx
        3RbCNpa4uX4DK0gJs4CmxPpd+hBhRYmdv+eCncAswCfx7msPK8QUXomONiGIElWJvkuHoQ6Q
        luhq/wC11EPi14Ib0HDrZ5T48vUJ+wRGuVkIGxYwMq5iFEstKM5NTy02LDBFjrBNjODErGW5
        g3H62w96hxiZOBgPMUpwMCuJ8J5IDkkQ4k1JrKxKLcqPLyrNSS0+xGgKDLuJzFKiyfnA3JBX
        Em9oamRsbGxhYmZuZmqsJM6bZPAgXkggPbEkNTs1tSC1CKaPiYNTqoHpyEXJ/d89pjQ4PH+9
        4cDubKeoOK+ws5rmBf1FGkydLt++d22eYpjqu2C13WF+WWterjKPmMfKV03PRp1bafzo0qsM
        txePdO68i9xc/MhU9/ak1y+mbOgpqa0X+nFW2yR42uef336Ftx+b8GnDpiymFTriJs4fbpVf
        NPzF2PNwiiKT8KsDhZrHqq6cqRJJ4jvo594y4Vb37rlXjEtmLFu+y9D2LOPcTo6vTiEr0nfI
        Ht1xTOzoBYYF/z74a10yLvyislh5Rc/0/G/3K5dwWXIEaG0I4xQQnC5S5S70uTGwo1/tuLWD
        dcg8gYUXHjxMSp5RU/BL44yde4K3lXdsgofNrxb9j29Fyk8ZWFUu7F+nxFKckWioxVxUnAgA
        MOdboVUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnG6DZkSCwbR5shaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y3e
        3gGq7e37xGrRekXLYvfGRWwWaz8/Zrd48+Iwm8WtifPZLM7/Pc7qIOIxq6GXzWN2w0UWj52z
        7rJ7bF6h5bF7wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK
        4I3isklJzcksSy3St0vgypj6oZml4LVixclzN9gbGP9KdzFyckgImEgcfzOTpYuRi0NIYDej
        xNyDv9khEtISx06cYe5i5ACyhSUOHy6GqPnAKPFl7hp2kDibgLbEny2iIOUiAvESNxtug81h
        FnjFLLFq7WkmkIQw0IIbXxaygtgsAqoS2zduZQSxeQWsJS6sP8cIsUteYvWGA8wgNqeAjcS0
        5Z0sILYQUM3M1vtMExj5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4gLc0d
        jNtXfdA7xMjEwXiIUYKDWUmE90RySIIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNIT
        S1KzU1MLUotgskwcnFINTDaC3IpeG2M3hDO8mR98c5GNlmlB/r0pU159kTtv99opi+Ext/4y
        56DnUnNEI9rZti+tP/M+Odsysz2EW27P98gFx5MP66va+nVqTmyRVdaQLlKqyQlwv79dcfqn
        /El8lccbQr6Iv12YMlX4NqNospuWKOvdvvI4iYRnqacmL2fZzvw/VMXtpcSLf8tu3pvqJmgb
        /+gLt1/sr/8nzitEXShNvZj1Yvlprc+PRbikJRQuGQn/erXjjebbsH9f1pRui08+1jA/dpOg
        dfqZyv4VO8/d6WBXPbSjITn1QIpNycHaORJ7Z56/+VTryI+9hi7Oa/Znse5ndt7xgbEp7aVD
        ymv2b7dMP/nMv6Lv8OLhYiWW4oxEQy3mouJEAL5KQNsPAwAA
X-CMS-MailID: 20210322052208epcas1p430b2e93761d5194844c533c61d43242d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322052208epcas1p430b2e93761d5194844c533c61d43242d
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
        <CGME20210322052208epcas1p430b2e93761d5194844c533c61d43242d@epcas1p4.samsung.com>
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
 fs/cifsd/Kconfig  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/cifsd/Makefile | 13 ++++++++++
 4 files changed, 79 insertions(+)
 create mode 100644 fs/cifsd/Kconfig
 create mode 100644 fs/cifsd/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index a55bda4233bb..92deb66021d1 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -340,6 +340,7 @@ config NFS_V4_2_SSC_HELPER
 source "net/sunrpc/Kconfig"
 source "fs/ceph/Kconfig"
 source "fs/cifs/Kconfig"
+source "fs/cifsd/Kconfig"
 source "fs/coda/Kconfig"
 source "fs/afs/Kconfig"
 source "fs/9p/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 3215fe205256..62dc87f3ff94 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_NLS)		+= nls/
 obj-$(CONFIG_UNICODE)		+= unicode/
 obj-$(CONFIG_SYSV_FS)		+= sysv/
 obj-$(CONFIG_CIFS)		+= cifs/
+obj-$(CONFIG_SMB_SERVER)	+= cifsd/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS_FS)		+= ntfs/
 obj-$(CONFIG_UFS_FS)		+= ufs/
diff --git a/fs/cifsd/Kconfig b/fs/cifsd/Kconfig
new file mode 100644
index 000000000000..6e78960be5b1
--- /dev/null
+++ b/fs/cifsd/Kconfig
@@ -0,0 +1,64 @@
+config SMB_SERVER
+	tristate "SMB server support (EXPERIMENTAL)"
+	depends on INET
+	select NLS
+	select NLS_UTF8
+	select CRYPTO
+	select CRYPTO_MD4
+	select CRYPTO_MD5
+	select CRYPTO_HMAC
+	select CRYPTO_ARC4
+	select CRYPTO_ECB
+	select CRYPTO_LIB_DES
+	select CRYPTO_SHA256
+	select CRYPTO_CMAC
+	select CRYPTO_SHA512
+	select CRYPTO_AEAD2
+	select CRYPTO_CCM
+	select CRYPTO_GCM
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
index 000000000000..a6c03c4ba51e
--- /dev/null
+++ b/fs/cifsd/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for Linux SMB3 kernel server
+#
+obj-$(CONFIG_SMB_SERVER) += ksmbd.o
+
+ksmbd-y :=	unicode.o auth.o vfs.o vfs_cache.o server.o buffer_pool.o \
+		misc.o oplock.o connection.o ksmbd_work.o crypto_ctx.o \
+		mgmt/ksmbd_ida.o mgmt/user_config.o mgmt/share_config.o \
+		mgmt/tree_connect.o mgmt/user_session.o smb_common.o \
+		transport_tcp.o transport_ipc.o smbacl.o smb2pdu.o \
+		smb2ops.o smb2misc.o asn1.o netmisc.o ndr.o
+ksmbd-$(CONFIG_SMB_SERVER_SMBDIRECT) += transport_rdma.o
-- 
2.17.1

