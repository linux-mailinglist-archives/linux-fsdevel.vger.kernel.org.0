Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F9397FCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 05:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFBEAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 00:00:03 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:26978 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhFBEAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:00:00 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210602035817epoutp031a76e59ecc1829b9904027989a8eb485~Ep9SSbLKd1179911799epoutp03c
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jun 2021 03:58:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210602035817epoutp031a76e59ecc1829b9904027989a8eb485~Ep9SSbLKd1179911799epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622606297;
        bh=K8qYft7uoFRN6/YBKMybGm0S7dAx4xJvR/R3vTf/vBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cHAv7ALzowhytQKP2AzD0/ennAGI1/deU7FpOHMobrlFmGbjtJO/fH8UP9BRupanT
         smdF8sCESkM4AvJkJIDLRYaCs0RVg0kFVgTziLDeH1PukecphLHmBmosg5HT5qkN0j
         EAL0ysnrHUzxwmIUxX+eHN0DB7TEVqc+ZaVHiKJc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210602035816epcas1p2f9a669635f383cc838eebffdd23d4ac8~Ep9RlDSkA3085430854epcas1p2x;
        Wed,  2 Jun 2021 03:58:16 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FvwHC1rCjz4x9Q1; Wed,  2 Jun
        2021 03:58:15 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.52.09736.7D107B06; Wed,  2 Jun 2021 12:58:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210602035814epcas1p3f244e5e018b0d7164081399262bd4bb7~Ep9P-I1Xi1757817578epcas1p3R;
        Wed,  2 Jun 2021 03:58:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210602035814epsmtrp1da38358cd22e8717685d1b1f2ea6ac12~Ep9P_HG5O1583215832epsmtrp1F;
        Wed,  2 Jun 2021 03:58:14 +0000 (GMT)
X-AuditID: b6c32a39-8d9ff70000002608-37-60b701d7093e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.25.08637.6D107B06; Wed,  2 Jun 2021 12:58:14 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210602035814epsmtip2dbc5b724c8c912e96c549cf896b65446~Ep9Pr-1lA3007730077epsmtip2p;
        Wed,  2 Jun 2021 03:58:14 +0000 (GMT)
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
Subject: [PATCH v4 01/10] cifsd: add document
Date:   Wed,  2 Jun 2021 12:48:38 +0900
Message-Id: <20210602034847.5371-2-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602034847.5371-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmru51xu0JBgf/sFo0vj3NYnH89V92
        i9f/prNYnJ6wiMli5eqjTBbX7r9nt3jxfxezxc//3xkt9uw9yWJxedccNosf0+stevs+sVq0
        XtGy2L1xEZvF2s+P2S3evDjMZnFr4nw2i/N/j7Na/P4xh81B2GN2w0UWj52z7rJ7bF6h5bF7
        wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK4InKsclITUxJ
        LVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBelFJoSwxpxQoFJBY
        XKykb2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tlaGBgZApUmZCTsf7MTbaC
        Tu+KBfNXsjQwvrDoYuTkkBAwkWht72bvYuTiEBLYwSjRdvoKK4TziVFiadsNZgjnG6PEn83z
        WWFaNh77xQaR2MsoMfPYVUa4lt93tzJ1MXJwsAloS/zZIgrSICIQK3Fjx2uwScwCu5gltt7f
        xAaSEBbQlTj86RYziM0ioCoxZ1IvC4jNK2Atsf/qZUaIbfISqzccAKvhFLCRWH1tChtE/AaH
        xKbXUhC2i8SV4/Og6oUlXh3fwg5hS0m87G+DssslTpz8xQRh10hsmLePHeROCQFjiZ4XJSAm
        s4CmxPpd+hAVihI7f88Fm8gswCfx7msPK0Q1r0RHmxBEiapE36XDUAOlJbraP0At8pA4sGYp
        NET7GSWO/L7HPoFRbhbChgWMjKsYxVILinPTU4sNC0yRI2wTIzgJa1nuYJz+9oPeIUYmDsZD
        jBIczEoivO55WxOEeFMSK6tSi/Lji0pzUosPMZoCg24is5Rocj4wD+SVxBuaGhkbG1uYmJmb
        mRorifOmO1cnCAmkJ5akZqemFqQWwfQxcXBKNTApP558sPboPA+ZijfiezReWW9Pfr7DZq+j
        nkLZPKns2Z9MvklIX8/5mrK8d3L7q1bVWO24iVO+mlax5RysKqj/LMFQ1hBi+/zX7x+iPl9k
        7CMzww1vb41rEFm7oVH9iaqAfnQ/89rvrTsTnjm2/dHhLF4ResHhvLvSnamCmiIXZk/vd5dO
        aJu/z93y2E39k53Hz84P/Rbsdk+xkI21edvKqTcKt+dsn/sh9ASfXeV2JeniVMt10pzL7wVP
        DEreIWNkOjP6R7HxyV03mn8FMXLK63lsSLy6c53IsxXz36/8+OXDc+HCaVdS07/qyfz3j/Ph
        i0z+m2Av+CCQ1eZh1Z6piTdST6a+aLto1q0t56/EUpyRaKjFXFScCADbL5ZdSwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvO41xu0JBvMXqFg0vj3NYnH89V92
        i9f/prNYnJ6wiMli5eqjTBbX7r9nt3jxfxezxc//3xkt9uw9yWJxedccNosf0+stevs+sVq0
        XtGy2L1xEZvF2s+P2S3evDjMZnFr4nw2i/N/j7Na/P4xh81B2GN2w0UWj52z7rJ7bF6h5bF7
        wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK4InisklJzcks
        Sy3St0vgylh/5iZbQad3xYL5K1kaGF9YdDFyckgImEhsPPaLrYuRi0NIYDejROPZi6wQCWmJ
        YyfOMHcxcgDZwhKHDxdD1HxglHj8s58RJM4moC3xZ4soSLmIQLzEzYbbLCA1zAJnmCWePrnK
        DpIQFtCVOPzpFjOIzSKgKjFnUi8LiM0rYC2x/+plRohd8hKrNxwAq+EUsJFYfW0KG4gtBFSz
        dP4+9gmMfAsYGVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHi5bmDsbtqz7oHWJk
        4mA8xCjBwawkwuuetzVBiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalF
        MFkmDk6pBiYfz79dW9Xun7/qkrNKiem9fPmRGsVTbzlnOfren6T6VnnV5glOpRXcydfXf30V
        kr/4hNPqks9uRlNmOEbvPZi+wPsoP9d2YfGZoXpmCcvf6Z6afs1k7qrnuh9vSh9Z0x16Rjgl
        2JxvV4r795xXryxYGUpaVz6e27bd6tFllbCypia9FWc1WSPnXrurpKr8+/F91Ye7ZrRt5Hs0
        89TV2DWim9YYLebV/nwze8IJhvdNP5vfbb/Ht3lHZNjULE7vKTN2+rjfdzo5cWGN7ckmlr7P
        H6oXiM1aZT5DbEFZ0R+2szOTlMNYj/BPWPv3wjvW444Gpj1u5fsTft+2cXp67EX5+xjTxYe3
        L7TZ4xfbdThjuhJLcUaioRZzUXEiAAx8hP0FAwAA
X-CMS-MailID: 20210602035814epcas1p3f244e5e018b0d7164081399262bd4bb7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210602035814epcas1p3f244e5e018b0d7164081399262bd4bb7
References: <20210602034847.5371-1-namjae.jeon@samsung.com>
        <CGME20210602035814epcas1p3f244e5e018b0d7164081399262bd4bb7@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a document describing ksmbd design, key features and usage.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 Documentation/filesystems/cifs/cifsd.rst | 164 +++++++++++++++++++++++
 Documentation/filesystems/cifs/index.rst |  10 ++
 Documentation/filesystems/index.rst      |   2 +-
 3 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/cifs/cifsd.rst
 create mode 100644 Documentation/filesystems/cifs/index.rst

diff --git a/Documentation/filesystems/cifs/cifsd.rst b/Documentation/filesystems/cifs/cifsd.rst
new file mode 100644
index 000000000000..01a0be272ce6
--- /dev/null
+++ b/Documentation/filesystems/cifs/cifsd.rst
@@ -0,0 +1,164 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+CIFSD - SMB3 Kernel Server
+==========================
+
+CIFSD is a linux kernel server which implements SMB3 protocol in kernel space
+for sharing files over network.
+
+CIFSD architecture
+==================
+
+The subset of performance related operations belong in kernelspace and
+the other subset which belong to operations which are not really related with
+performance in userspace. So, DCE/RPC management that has historically resulted
+into number of buffer overflow issues and dangerous security bugs and user
+account management are implemented in user space as ksmbd.mountd.
+File operations that are related with performance (open/read/write/close etc.)
+in kernel space (ksmbd). This also allows for easier integration with VFS
+interface for all file operations.
+
+ksmbd (kernel daemon)
+---------------------
+
+When the server daemon is started, It starts up a forker thread
+(ksmbd/interface name) at initialization time and open a dedicated port 445
+for listening to SMB requests. Whenever new clients make request, Forker
+thread will accept the client connection and fork a new thread for dedicated
+communication channel between the client and the server. It allows for parallel
+processing of SMB requests(commands) from clients as well as allowing for new
+clients to make new connections. Each instance is named ksmbd/1~n(port number)
+to indicate connected clients. Depending on the SMB request types, each new
+thread can decide to pass through the commands to the user space (ksmbd.mountd),
+currently DCE/RPC commands are identified to be handled through the user space.
+To further utilize the linux kernel, it has been chosen to process the commands
+as workitems and to be executed in the handlers of the ksmbd-io kworker threads.
+It allows for multiplexing of the handlers as the kernel take care of initiating
+extra worker threads if the load is increased and vice versa, if the load is
+decreased it destroys the extra worker threads. So, after connection is
+established with client. Dedicated ksmbd/1..n(port number) takes complete
+ownership of receiving/parsing of SMB commands. Each received command is worked
+in parallel i.e., There can be multiple clients commands which are worked in
+parallel. After receiving each command a separated kernel workitem is prepared
+for each command which is further queued to be handled by ksmbd-io kworkers.
+So, each SMB workitem is queued to the kworkers. This allows the benefit of load
+sharing to be managed optimally by the default kernel and optimizing client
+performance by handling client commands in parallel.
+
+ksmbd.mountd (user space daemon)
+--------------------------------
+
+ksmbd.mountd is userspace process to, transfer user account and password that
+are registered using ksmbd.adduser(part of utils for user space). Further it
+allows sharing information parameters that parsed from smb.conf to ksmbd in
+kernel. For the execution part it has a daemon which is continuously running
+and connected to the kernel interface using netlink socket, it waits for the
+requests(dcerpc and share/user info). It handles RPC calls (at a minimum few
+dozen) that are most important for file server from NetShareEnum and
+NetServerGetInfo. Complete DCE/RPC response is prepared from the user space
+and passed over to the associated kernel thread for the client.
+
+
+CIFSD Feature Status
+====================
+
+============================== =================================================
+Feature name                   Status
+============================== =================================================
+Dialects                       Supported. SMB2.1 SMB3.0, SMB3.1.1 dialects
+                               (intentionally excludes security vulnerable SMB1
+                               dialect).
+Auto Negotiation               Supported.
+Compound Request               Supported.
+Oplock Cache Mechanism         Supported.
+SMB2 leases(v1 lease)          Supported.
+Directory leases(v2 lease)     Planned for future.
+Multi-credits                  Supported.
+NTLM/NTLMv2                    Supported.
+HMAC-SHA256 Signing            Supported.
+Secure negotiate               Supported.
+Signing Update                 Supported.
+Pre-authentication integrity   Supported.
+SMB3 encryption(CCM, GCM)      Supported. (CCM and GCM128 supported, GCM256 in
+                               progress)
+SMB direct(RDMA)               Partially Supported. SMB3 Multi-channel is
+                               required to connect to Windows client.
+SMB3 Multi-channel             In Progress.
+SMB3.1.1 POSIX extension       Supported.
+ACLs                           Partially Supported. only DACLs available, SACLs
+                               (auditing) is planned for the future. For
+                               ownership (SIDs) ksmbd generates random subauth
+                               values(then store it to disk) and use uid/gid
+                               get from inode as RID for local domain SID.
+                               The current acl implementation is limited to
+                               standalone server, not a domain member.
+                               Integration with Samba tools is being worked on
+                               to allow future support for running as a domain
+                               member.
+Kerberos                       Supported.
+Durable handle v1,v2           Planned for future.
+Persistent handle              Planned for future.
+SMB2 notify                    Planned for future.
+Sparse file support            Supported.
+DCE/RPC support                Partially Supported. a few calls(NetShareEnumAll,
+                               NetServerGetInfo, SAMR, LSARPC) that are needed
+                               for file server handled via netlink interface
+                               from ksmbd.mountd. Additional integration with
+                               Samba tools and libraries via upcall is being
+                               investigated to allow support for additional
+                               DCE/RPC management calls (and future support
+                               for Witness protocol e.g.)
+ksmbd/nfsd interoperability    Planned for future. The features that ksmbd
+                               support are Leases, Notify, ACLs and Share modes.
+============================== =================================================
+
+
+How to run
+==========
+
+1. Download ksmbd-tools and compile them.
+	- https://github.com/cifsd-team/ksmbd-tools
+
+2. Create user/password for SMB share.
+
+	# mkdir /etc/ksmbd/
+	# ksmbd.adduser -a <Enter USERNAME for SMB share access>
+
+3. Create /etc/ksmbd/smb.conf file, add SMB share in smb.conf file
+	- Refer smb.conf.example and
+          https://github.com/cifsd-team/ksmbd-tools/blob/master/Documentation/configuration.txt
+
+4. Insert ksmbd.ko module
+
+	# insmod ksmbd.ko
+
+5. Start ksmbd user space daemon
+	# ksmbd.mountd
+
+6. Access share from Windows or Linux using CIFS
+
+Shutdown CIFSD
+==============
+
+1. kill user and kernel space daemon
+	# sudo ksmbd.control -s
+
+How to turn debug print on
+==========================
+
+Each layer
+/sys/class/ksmbd-control/debug
+
+1. Enable all component prints
+	# sudo ksmbd.control -d "all"
+
+2. Enable one of components(smb, auth, vfs, oplock, ipc, conn, rdma)
+	# sudo ksmbd.control -d "smb"
+
+3. Show what prints are enable.
+	# cat/sys/class/ksmbd-control/debug
+	  [smb] auth vfs oplock ipc conn [rdma]
+
+4. Disable prints:
+	If you try the selected component once more, It is disabled without brackets.
diff --git a/Documentation/filesystems/cifs/index.rst b/Documentation/filesystems/cifs/index.rst
new file mode 100644
index 000000000000..e762586b5dc7
--- /dev/null
+++ b/Documentation/filesystems/cifs/index.rst
@@ -0,0 +1,10 @@
+===============================
+CIFS
+===============================
+
+
+.. toctree::
+   :maxdepth: 1
+
+   cifsd
+   cifsroot
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index d4853cb919d2..bdba80ae2bb1 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -72,7 +72,7 @@ Documentation for filesystem implementations.
    befs
    bfs
    btrfs
-   cifs/cifsroot
+   cifs/index
    ceph
    coda
    configfs
-- 
2.17.1

