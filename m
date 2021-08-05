Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5C53E0E1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 08:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbhHEGQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 02:16:46 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:38671 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbhHEGQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:16:20 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210805061605epoutp01bcfcfa046f7b53ebb1f43eb9daed8cec~YVH4fHdvW1569415694epoutp01l
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Aug 2021 06:16:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210805061605epoutp01bcfcfa046f7b53ebb1f43eb9daed8cec~YVH4fHdvW1569415694epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628144165;
        bh=yzm6aIume2vnZQj866cjUOb150v8iYfxoTLECmVPiJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8h7wOJzZJfVzOKiv7lUHPtnMHR928YFLyaOiqVsCkMMTc1Z72KH2JsRo5CG4VR3K
         XIFSckGIOtIkWjeTigVo60sxHkuBCQTEnwif8PeqU8HqyKiRcEHfD752EYHfb+xBhW
         pDaylCF8y13ClCtu+29NfgJZUrUde6bFWgn+o/DI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210805061605epcas1p4e34139b14755798d64bf57d1a30c78ac~YVH3-ENCU0961409614epcas1p4_;
        Thu,  5 Aug 2021 06:16:05 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4GgJJh3168z4x9Pq; Thu,  5 Aug
        2021 06:16:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.96.45479.4228B016; Thu,  5 Aug 2021 15:16:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210805061603epcas1p16cdc8cfbd37590e18df36d92a713e333~YVH2pstaN2014620146epcas1p1F;
        Thu,  5 Aug 2021 06:16:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210805061603epsmtrp18dbc4dacf64f7a9b43a940db41775756~YVH2ofbd81607716077epsmtrp1E;
        Thu,  5 Aug 2021 06:16:03 +0000 (GMT)
X-AuditID: b6c32a35-cbfff7000001b1a7-9d-610b8224db47
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.43.08394.3228B016; Thu,  5 Aug 2021 15:16:03 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210805061603epsmtip186f8887a8cff4d42ecb9fa0fe445504e~YVH2aIe630035500355epsmtip1G;
        Thu,  5 Aug 2021 06:16:03 +0000 (GMT)
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
Subject: [PATCH v7 12/13] ksmbd: add Kconfig and Makefile
Date:   Thu,  5 Aug 2021 15:05:45 +0900
Message-Id: <20210805060546.3268-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805060546.3268-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmga5KE3eiwZNrIhbHX/9lt2h8p2zx
        +t90FovTExYxWaxcfZTJ4tr99+wWL/7vYrb4+f87o8WevSdZLC7vmsNmcXHZTxaLH9PrLXr7
        PrFatF7Rsti9cRGbxZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7/J37kdljdsNFFo+ds+6ye2xe
        oeWxe8FnJo/dNxvYPFp3/GX3+Pj0FovH3F19jB59W1YxemxZ/JDJ4/MmOY9NT94yBfBG5dhk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAL2ppFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwNCjQK07MLS7NS9dLzs+1MjQwMDIFqkzIyVg6
        P7DghWrF750r2BoYz8l3MXJwSAiYSHy9ad7FyMUhJLCDUeLF+TmsEM4nRonjJ98ydTFyAjnf
        GCX+/k8BsUEaOrf9ZIIo2sso8ev3bja4jjvP5jCDjGUT0Jb4s0UUpEFEIFbixo7XzCA1zAKz
        mSWe7z3FApIQFrCU2HZiNdgGFgFViaWffrKB2LwCNhI/zm5lg9gmL7F6wwFmEJsTKP5q9Waw
        8yQE7nBINO+cwQxR5CJxYPpiRghbWOLV8S3sELaUxMv+Nii7XOLEyV9MEHaNxIZ5+9gh/jeW
        6HlRAmIyC2hKrN+lD1GhKLHz91ywicwCfBLvvvawQlTzSnS0CUGUqEr0XToMNVBaoqv9A9Qi
        D4mXy1ZDw62fUeLT8qQJjHKzEBYsYGRcxSiWWlCcm55abFhgiBxbmxjBaVjLdAfjxLcf9A4x
        MnEwHmKU4GBWEuFNXsyVKMSbklhZlVqUH19UmpNafIjRFBh0E5mlRJPzgZkgryTe0NTI2NjY
        wsTM3MzUWEmc91vs1wQhgfTEktTs1NSC1CKYPiYOTqkGppTnb6/Ll8peVPy8zu68W/TH9XuX
        /lz953DYQW/dnh3CS7be9Tml/fdnttO5XMs6ZY9G/c9NE2WlMiUZSwvvq5m0iJvyduyM/cnw
        hnd5TNMld5HczxMe3dfbndC+PmSf3cu/scL8+VE9W9TuuH+4u5D7FAvDFqfNglXfmkJvp6YH
        +82LLPBqqN2bfMu4OTKkVlm740vBofONiRdLZONNxV2WSbrHabhyLQ379jHc6vhLjg7R7Zzc
        nL8krsyJfq1hcK846+3c7y/e7spTldsrlZsbKS5+pNSUP6C78eaUt4oaUeLXSovkJi56d+BZ
        kG+y4/3Ql1eXbf7I3enYr7J1xlG1zpiTF7Y6i+TYlFoqsRRnJBpqMRcVJwIAvVGKSkwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnK5yE3eiwd5GU4vjr/+yWzS+U7Z4
        /W86i8XpCYuYLFauPspkce3+e3aLF/93MVv8/P+d0WLP3pMsFpd3zWGzuLjsJ4vFj+n1Fr19
        n1gtWq9oWezeuIjN4s2Lw2wWtybOZ7M4//c4q8XvH3PYHIQ9/s79yOwxu+Eii8fOWXfZPTav
        0PLYveAzk8fumw1sHq07/rJ7fHx6i8Vj7q4+Ro++LasYPbYsfsjk8XmTnMemJ2+ZAnijuGxS
        UnMyy1KL9O0SuDKWzg8seKFa8XvnCrYGxnPyXYycHBICJhKd234ydTFycQgJ7GaU2L24gQki
        IS1x7MQZ5i5GDiBbWOLw4WKQsJDAB0aJvdcDQcJsAtoSf7aIgoRFBOIlbjbcZgEZwyywnlni
        7OsmFpCEsIClxLYTq8FGsgioSiz99JMNxOYVsJH4cXYrG8QqeYnVGw4wg9icQPFXqzezQuyy
        lnj/9hrzBEa+BYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgiNGS3MH4/ZVH/QO
        MTJxMB5ilOBgVhLhTV7MlSjEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC
        1CKYLBMHp1QD0wbx6QoMOlXivm1/nllVf9f5+szu6v1Lf4sf6gf2S0w1DeeXLX70RS+jKXf2
        v9d3p/CpanpfPiH5u2fnfpkHLMcXFH4vPCbavDkjJuvbjeApa32LLx/7tZZ5d6b+T69Lv6VM
        2Dfb8yf8lrNad/FJ7rR9Cx1E9OpfT2nu3hXjub6h43bExt1NhjqX7L7ZmGTOf8wjtaEpbM/M
        2TX1ga8q3Jfe3zhzY8WK2bELv1/8JPrDc6lFfdrzms2qjhvm7P6aofNzvfznitwY8SdCcubn
        b35Myl4rxf1zh+JCC41XS7kSji90OX1eN/u4x4ymWdeyo2LPbu/u02yasfnTEb/DfKumn7To
        KuO4qRRq/65w2gQlluKMREMt5qLiRABu9+D2BwMAAA==
X-CMS-MailID: 20210805061603epcas1p16cdc8cfbd37590e18df36d92a713e333
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210805061603epcas1p16cdc8cfbd37590e18df36d92a713e333
References: <20210805060546.3268-1-namjae.jeon@samsung.com>
        <CGME20210805061603epcas1p16cdc8cfbd37590e18df36d92a713e333@epcas1p1.samsung.com>
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

