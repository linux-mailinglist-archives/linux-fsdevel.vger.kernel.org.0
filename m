Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2736765A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 02:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbhDVAj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 20:39:26 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:40859 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343972AbhDVAjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:39:22 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210422003847epoutp01a7af94063f2c5644719d5fd1f8dec84d~4ByZjFBIs1733517335epoutp011
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 00:38:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210422003847epoutp01a7af94063f2c5644719d5fd1f8dec84d~4ByZjFBIs1733517335epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619051927;
        bh=uSOZgWYI+3ebBffVGXhhEdjEVvM/6LZNc5uoaKnz604=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTf/LTasDeMpgH9/iegoYIM1x37LcKUMRionSYZZOWdY7gqYWNVsjD6uqOI/WQWbo
         02fP2eQDTQs+XUOE14jYL1ibK19SiEKshoiKCVX7zlyRh4eWks0cOLh+ycT3dbDL/1
         e6aMcyNihssVgskqDlG7dPsw0byydfRpqv4Xf7uk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210422003846epcas1p4496d9994fb976a8996234d19af366f14~4ByYktITY1436514365epcas1p4W;
        Thu, 22 Apr 2021 00:38:46 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FQdnx3tvBz4x9QB; Thu, 22 Apr
        2021 00:38:45 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.5E.09736.595C0806; Thu, 22 Apr 2021 09:38:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210422003845epcas1p26e9145c0651b8ac8e3ad855df39163c7~4ByXV_wgB1940919409epcas1p27;
        Thu, 22 Apr 2021 00:38:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210422003845epsmtrp2d92f1997ed4f11e7a76206dce5e9c38a~4ByXVByDb1919419194epsmtrp2Q;
        Thu, 22 Apr 2021 00:38:45 +0000 (GMT)
X-AuditID: b6c32a39-8d9ff70000002608-41-6080c5957b88
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.CA.08637.495C0806; Thu, 22 Apr 2021 09:38:44 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210422003844epsmtip16b62963951a3460b01fda745bb196684~4ByXDSQz51939219392epsmtip1P;
        Thu, 22 Apr 2021 00:38:44 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     smfrench@gmail.com, senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 09/10] cifsd: add Kconfig and Makefile
Date:   Thu, 22 Apr 2021 09:28:23 +0900
Message-Id: <20210422002824.12677-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210422002824.12677-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmge7Uow0JBo/vylg0vj3NYnH89V92
        i9+re9ksXv+bzmJxesIiJouVq48yWVy7/57dYs/ekywWl3fNYbP4Mb3e4u0doIrevk+sFq1X
        tCx2b1zEZrH282N2izcvDrNZ3Jo4n83i/N/jrBa/f8xhcxD2mNXQy+Yxu+Eii8fOWXfZPTav
        0PLYfbOBzaN1x192j49Pb7F49G1ZxeixZfFDJo/1W66yeHzeJOex6clbpgCeqBybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAXlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORlznhxlLNik
        UrFrVRdjA+NyuS5GTg4JAROJK7MWMHcxcnEICexglJh46xGU84lRYub0f+wQzjdGiRkv5zHC
        tHy62sYEkdjLKLFz61aEljWX9wE5HBxsAtoSf7aIgpgiAvYStxf7gJQwCxxilvh6pQ9skLCA
        pcTBO9+ZQGwWAVWJJy+XgMV5BWwl3s+/zgaxTF5i9YYDzCA2J1D814aVjCCDJAQucEgc6v0A
        VeQicXHBDajrhCVeHd/CDmFLSXx+t5cN5AgJgWqJj/uZIcIdjBIvvttC2MYSN9dvYAUpYRbQ
        lFi/Sx8irCix8/dcsInMAnwS7772sEJM4ZXoaBOCKFGV6Lt0mAnClpboav8AtdRDYtvyQ4yQ
        EJnAKPHv8CmmCYxysxA2LGBkXMUollpQnJueWmxYYIocYZsYwUlYy3IH4/S3H/QOMTJxMB5i
        lOBgVhLhXVvckCDEm5JYWZValB9fVJqTWnyI0RQYdhOZpUST84F5IK8k3tDUyNjY2MLEzNzM
        1FhJnDfduTpBSCA9sSQ1OzW1ILUIpo+Jg1OqgYn75wZlX6NTTY9nJm34OUlhJ9Nui2fn1k0R
        inDJ4J4zMzaORdiur/Sc9pSTdyzVIlmP/5F5KXd3m2SQnnfwyZ6jB26IyJQa8VS9a/rRqftW
        j19jxaFWF96FM76oTJxyeFqf1P2am8cVX13s6jbWVtyWtVzsUf7sunz9OcdZN664nnVJqW07
        v866Daa2V0rPX73ZcpqH8cikvc9frC5kanl6R+Og9uQ5lQWTrnrs6Xa5LvTu00HfU4cv1O/Z
        7HW5/1M431fPH3fma63QvLVGeenKpQ7LHetWPWduZeDZut4m+8FWl/B64RutpUfdJUynBx1p
        1O5L/yEcF+0gtSDou+jZFcWTmaunXLoV+MdR9tUnJZbijERDLeai4kQAbi3CRUsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSnO6Uow0JBpcOWVk0vj3NYnH89V92
        i9+re9ksXv+bzmJxesIiJouVq48yWVy7/57dYs/ekywWl3fNYbP4Mb3e4u0doIrevk+sFq1X
        tCx2b1zEZrH282N2izcvDrNZ3Jo4n83i/N/jrBa/f8xhcxD2mNXQy+Yxu+Eii8fOWXfZPTav
        0PLYfbOBzaN1x192j49Pb7F49G1ZxeixZfFDJo/1W66yeHzeJOex6clbpgCeKC6blNSczLLU
        In27BK6MOU+OMhZsUqnYtaqLsYFxuVwXIyeHhICJxKerbUxdjFwcQgK7GSWaZ/5hh0hISxw7
        cYa5i5EDyBaWOHy4GKLmA6PEsj3PGEHibALaEn+2iIKUiwg4SpyYuogRpIZZ4BqzxLftExhB
        EsIClhIH73xnArFZBFQlnrxcAhbnFbCVeD//OhvELnmJ1RsOMIPYnEDxXxtWgtUICdhINE2/
        yjKBkW8BI8MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgaNHS3MG4fdUHvUOMTByM
        hxglOJiVRHjXFjckCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbL
        xMEp1cC0psdvgcb8KqG60FVOht/+NDtyvFb/OLMtuNUh+0DK7C2Ksy/8innFkJt96vVLUe60
        355BDwvdVUu6Nv1IP/e900P/+Pz3l9uln3+f3dS3+vkhX9eoItbjmzpb7up7W72rLH/azfAx
        dZNzh0L/v+afrmb2wj+2Ppb1YtljHlBfr13Y4ndcSmOCW8zL2tk371Rv5qqYvMD4jHGpVNXJ
        ctOGJYEqgXIp7vP6BD7Pl996ME/B3azheuGXboN6n+kqtQXu2zLX+PRqh4esmiy6bbZCzy9m
        1+5XgY1yHlbnTdTeeng0Nyybf75mO4fTa9Hoy2fPqCWc/3KzbPZ1gTlnvWWOHDDgzDlWf4jv
        j97pOUosxRmJhlrMRcWJANRaRGIFAwAA
X-CMS-MailID: 20210422003845epcas1p26e9145c0651b8ac8e3ad855df39163c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210422003845epcas1p26e9145c0651b8ac8e3ad855df39163c7
References: <20210422002824.12677-1-namjae.jeon@samsung.com>
        <CGME20210422003845epcas1p26e9145c0651b8ac8e3ad855df39163c7@epcas1p2.samsung.com>
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
 fs/cifsd/Kconfig  | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/cifsd/Makefile | 17 ++++++++++++
 4 files changed, 86 insertions(+)
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
index 000000000000..5316b1035fbe
--- /dev/null
+++ b/fs/cifsd/Kconfig
@@ -0,0 +1,67 @@
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

