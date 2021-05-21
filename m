Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71D338BF9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 08:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhEUGjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 02:39:06 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55405 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhEUGhn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 02:37:43 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210521063553epoutp0249e6588ea4a8aad30b711bbf4de1276c~BAXeVFGeg1166411664epoutp02K
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 06:35:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210521063553epoutp0249e6588ea4a8aad30b711bbf4de1276c~BAXeVFGeg1166411664epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621578953;
        bh=K8qYft7uoFRN6/YBKMybGm0S7dAx4xJvR/R3vTf/vBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a297G2KCT/K5mTGVeWBd4Hqp5kOnr7YAu3XHRxEFx6qLRXeCmB/7s9Ld7/EZ1aXje
         Hyd6fD9penaAztHMGjLOYgOWZuC1z7FJZ1GHRvmf6fFO1sXi4vFumpWPDnw9tIWKoQ
         UmuhFlXQ+Vf4/v5upwyX5AHMB2oMvCYUVOE8oo6E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210521063553epcas1p4fcda25200a8b9fdc3221e787427eb08a~BAXdylOUl2176821768epcas1p4X;
        Fri, 21 May 2021 06:35:53 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FmcLb5SlFz4x9Q3; Fri, 21 May
        2021 06:35:51 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.04.09736.7C457A06; Fri, 21 May 2021 15:35:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210521063551epcas1p4f9c25b83b0088b3631c0860f5f715c52~BAXbwO0yU1898218982epcas1p4m;
        Fri, 21 May 2021 06:35:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210521063551epsmtrp261d1e43c35fce6c6423b62dc86fd4049~BAXbvNvKR1342813428epsmtrp2Z;
        Fri, 21 May 2021 06:35:51 +0000 (GMT)
X-AuditID: b6c32a39-8d9ff70000002608-05-60a754c75958
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.4E.08163.6C457A06; Fri, 21 May 2021 15:35:50 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210521063550epsmtip1d6b31e8979662ab8e6c6d0b0e592599a~BAXbdiMFO1699216992epsmtip1a;
        Fri, 21 May 2021 06:35:50 +0000 (GMT)
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
Subject: [PATCH v3 01/10] cifsd: add document
Date:   Fri, 21 May 2021 15:26:28 +0900
Message-Id: <20210521062637.31347-2-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210521062637.31347-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmnu7xkOUJBi+vq1s0vj3NYnH89V92
        i9f/prNYnJ6wiMli5eqjTBbX7r9nt3jxfxezxc//3xkt9uw9yWJxedccNosf0+stevs+sVq0
        XtGy2L1xEZvF2s+P2S3evDjMZnFr4nw2i/N/j7Na/P4xh81B2GN2w0UWj52z7rJ7bF6h5bF7
        wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK4InKsclITUxJ
        LVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBelFJoSwxpxQoFJBY
        XKykb2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tlaGBgZApUmZCTsf7MTbaC
        Tu+KBfNXsjQwvrDoYuTgkBAwkWiewdvFyMUhJLCDUeLinEvsEM4nRomla7dBOZ8ZJTa972br
        YuQE65j+9CJUYhejRO+P6Qgtt17sZwaZyyagLfFniyhIg4hArMSNHa+ZQWqYBXYxS5xd9IIR
        JCEsoCux8/tfVpB6FgFVic+340DCvAI2El0PDjNDLJOXWL3hAJjNKWAr8fT7AlaQORICFzgk
        Ns//BFXkIvFz7woWCFtY4tXxLewQtpTE53d7oa4ulzhx8hcThF0jsWHePnaI/40lel6UgJjM
        ApoS63fpQ1QoSuz8PRfsSmYBPol3X3tYIap5JTrahCBKVCX6Lh2GGigt0dX+AWqgh8TGx76Q
        AJnAKDFvyw7GCYxysxAWLGBkXMUollpQnJueWmxYYIocXZsYwQlYy3IH4/S3H/QOMTJxMB5i
        lOBgVhLh5XZcniDEm5JYWZValB9fVJqTWnyI0RQYchOZpUST84E5IK8k3tDUyNjY2MLEzNzM
        1FhJnDfduTpBSCA9sSQ1OzW1ILUIpo+Jg1OqgWnO0qUn3vCtn/k7JEi+ZOWqQBeXmt17GYuf
        uBYJf1ZJY86ZJ77lesisKUKcv/r/nPpbu5PPT//+af5FqULzC69wTo01OHb2c/gk8bRAvmNx
        RidlFOyX+i67zdt0/16hBvOuLUJiWVe+lGx+cL9raWuA74q8u1P2T656W6+2V/Hk2TNSwskh
        9Q+r3l5NeHYyu5fr3lbWreejG+RP6Fp9cKqXOPZ2x/Ntu5r4xfU+9d872HBh5SyeGzG/nWTb
        yusWB4f+u8Y3QYA5WtKv7fHZqycOSRzM7AhSqq346FK1xUbZaP3C2yb1ssYZiVNyKxV2KG8p
        9GE7YezQn+B1u3vrlCYj6bUOMtcvFvy/qJEpZ6DEUpyRaKjFXFScCAB0fC/RSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnO7xkOUJBu2pFo1vT7NYHH/9l93i
        9b/pLBanJyxisli5+iiTxbX779ktXvzfxWzx8/93Ros9e0+yWFzeNYfN4sf0eovevk+sFq1X
        tCx2b1zEZrH282N2izcvDrNZ3Jo4n83i/N/jrBa/f8xhcxD2mN1wkcVj56y77B6bV2h57F7w
        mclj980GNo/WHX/ZPT4+vcXi0bdlFaPHlsUPmTzWb7nK4vF5k5zHpidvmQJ4orhsUlJzMstS
        i/TtErgy1p+5yVbQ6V2xYP5KlgbGFxZdjJwcEgImEtOfXmTvYuTiEBLYwSjR+XM3K0RCWuLY
        iTPMXYwcQLawxOHDxRA1HxglJr6bxg4SZxPQlvizRRSkXEQgXuJmw20WkBpmgTPMEg0te1hA
        EsICuhI7v/9lBalnEVCV+Hw7DiTMK2Aj0fXgMDPEKnmJ1RsOgNmcArYST78vADtBCKim5+ZK
        9gmMfAsYGVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHipbWDsY9qz7oHWJk4mA8
        xCjBwawkwsvtuDxBiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkm
        Dk6pBia+xp3fzb6rZKl9fOW2ui3XzKFOIW9mn03ulG9f+MUYg6eW3Psxe41gZNya8o4v1kuE
        ZO+XL3k4+XXFErXWaz//fbaUTzu9UyiDo6vGLD55TTmLpET+HF73aaeKXW+xfDtW/3Xt24/W
        PO1Tt07gj468sN7y2DwFs+hp6neNaxeVT3R0+jvt7cqffh+4mLeJHnZwMeGwejDBIOdAs9dD
        //L94n0MO2/KvxRtWWbtGxPpqhhyZC+T98Z1b/21u9mzAluX58Ws+b7KOvTnAs4Wme/FDpbG
        Z3dPEQiyEdnSI/I1er/TSh5Htv/b34hudsps3bmZZ5Hn2j9ud+bt1f89g0Vav9yg9GqxQbex
        g3L3fyWW4oxEQy3mouJEAIHI+NQDAwAA
X-CMS-MailID: 20210521063551epcas1p4f9c25b83b0088b3631c0860f5f715c52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210521063551epcas1p4f9c25b83b0088b3631c0860f5f715c52
References: <20210521062637.31347-1-namjae.jeon@samsung.com>
        <CGME20210521063551epcas1p4f9c25b83b0088b3631c0860f5f715c52@epcas1p4.samsung.com>
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

