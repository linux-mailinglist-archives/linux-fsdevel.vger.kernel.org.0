Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0AC3E0E03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 08:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhHEGQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 02:16:13 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:21188 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbhHEGQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:16:12 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210805061557epoutp04e87aa477b50e78d8d598514b9ece6fb4~YVHwYh8pU0292002920epoutp04U
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Aug 2021 06:15:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210805061557epoutp04e87aa477b50e78d8d598514b9ece6fb4~YVHwYh8pU0292002920epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628144157;
        bh=0ecHHt7lCuZJh3o10h6QCYCxalCSpfibUbGLmS4sLFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jldjoVp+N7LCzmaro6xZwvm9wMG2c22cMNeMwwYpKjfVAHBhU9DRNKeCIF43yXXL8
         5/7UMFgN9gyRd3ByPejY4vGOdL7cq5yz30wd9jncNhpkdpw04fh0EsLnRXo67QAFjh
         BpBGyEiSMWuVsQ8VmAY2xWTKE2VKYVOowKB2KfsY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210805061556epcas1p44d5d53c32187db95e840d4c95f4133ca~YVHvl7Wk40902809028epcas1p4B;
        Thu,  5 Aug 2021 06:15:56 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GgJJW2gnYz4x9Pv; Thu,  5 Aug
        2021 06:15:55 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.A5.09468.B128B016; Thu,  5 Aug 2021 15:15:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210805061554epcas1p26484b6aa7d1a44930350f8ffed4bbe3f~YVHuD_Kqd2902829028epcas1p2C;
        Thu,  5 Aug 2021 06:15:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210805061554epsmtrp24ba02ac3659fba9988fe00d791e70e9a~YVHuC3_3c0723807238epsmtrp2f;
        Thu,  5 Aug 2021 06:15:54 +0000 (GMT)
X-AuditID: b6c32a37-0b1ff700000024fc-9d-610b821bc658
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.43.08394.A128B016; Thu,  5 Aug 2021 15:15:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210805061554epsmtip1ba79a2e41374ea3faa8fe0ef86d39da3~YVHtuJzYx3217432174epsmtip10;
        Thu,  5 Aug 2021 06:15:54 +0000 (GMT)
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
Subject: [PATCH v7 01/13] ksmbd: add document
Date:   Thu,  5 Aug 2021 15:05:34 +0900
Message-Id: <20210805060546.3268-2-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805060546.3268-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmrq50E3eiwcZJghbHX/9lt2h8p2zx
        +t90FovTExYxWaxcfZTJ4tr99+wWL/7vYrb4+f87o8WevSdZLC7vmsNmcXHZTxaLH9PrLXr7
        PrFatF7Rsti9cRGbxZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7/J37kdljdsNFFo+ds+6ye2xe
        oeWxe8FnJo/dNxvYPFp3/GX3+Pj0FovH3F19jB59W1YxemxZ/JDJ4/MmOY9NT94yBfBG5dhk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAL2ppFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwNCjQK07MLS7NS9dLzs+1MjQwMDIFqkzIyZgw
        p4mtoNW74v2aS6wNjE8suhg5OSQETCQe7nnB3sXIxSEksINRYt28N4wQzidGiV2dT5khnG+M
        Eht7nrHDtBya1g2V2AuUWL+aBa6ls+kfaxcjBwebgLbEny2iIA0iArESN3a8BmtgFpjNLPF8
        7ykWkBphAV2JtmnKIDUsAqoSJ37fYQGxeQWsJVqb25kglslLrN5wgBnE5hSwkXi1ejMryBwJ
        gRscEmdO3WCBKHKRmP7mHFSDsMSr41ugLpWS+PxuLxuEXS5x4uQvqJoaiQ3z9rGD3CAhYCzR
        86IExGQW0JRYv0sfokJRYufvuYwgNrMAn8S7rz2sENW8Eh1tQhAlqhJ9lw5DDZSW6Gr/ALXU
        Q+LT4q+skBDpZ5T4eWoa2wRGuVkIGxYwMq5iFEstKM5NTy02LDBGjrBNjOBkrGW+g3Ha2w96
        hxiZOBgPMUpwMCuJ8CYv5koU4k1JrKxKLcqPLyrNSS0+xGgKDLuJzFKiyfnAfJBXEm9oamRs
        bGxhYmZuZmqsJM77LfZrgpBAemJJanZqakFqEUwfEwenVAPT3l7WdqWmDT/7Aw/vaF6rYn9F
        2nO90zW2l28vn5jCvUZmX6l1+fdjV1c+Oa4R+fumg97cN2Lz3r/uPqN3Mqt0KusHl+XSS6fk
        p8e7OjcKOset4msOrtV5wRussvvC7LmXfzQ/3nauaBVniZrjk93TbKSWbfWdV7Olo/2M2W8V
        1ocMOsdEF0nJWcza1v8nfXLgg/6bghUe56sv/GyT/8b28rXscoOO6EtZ/nIC67b9ur8g0aNk
        0cLgpZP7q9yE2SsPiTZI81zv7FZzbbsky2iffVb4aLqg5je5dOlfHlw11n9u+/0sEubi2L9Y
        dUrY6mOGuy+EVoj1f6+s/B2fXZ5htqxwQRmfcr1ETPhaDj4lluKMREMt5qLiRADWkhkmTwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnK5UE3eiQds5ZYvjr/+yWzS+U7Z4
        /W86i8XpCYuYLFauPspkce3+e3aLF/93MVv8/P+d0WLP3pMsFpd3zWGzuLjsJ4vFj+n1Fr19
        n1gtWq9oWezeuIjN4s2Lw2wWtybOZ7M4//c4q8XvH3PYHIQ9/s79yOwxu+Eii8fOWXfZPTav
        0PLYveAzk8fumw1sHq07/rJ7fHx6i8Vj7q4+Ro++LasYPbYsfsjk8XmTnMemJ2+ZAnijuGxS
        UnMyy1KL9O0SuDImzGliK2j1rni/5hJrA+MTiy5GTg4JAROJQ9O6mbsYuTiEBHYzSixqO84K
        kZCWOHbiDFCCA8gWljh8uBgkLCTwgVHi3QojkDCbgLbEny2iIGERgXiJmw23WUDGMAusZ5Y4
        +7qJBaRGWEBXom2aMkgNi4CqxInfd1hAbF4Ba4nW5nYmiE3yEqs3HGAGsTkFbCRerd7MCrHK
        WuL922vMExj5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4YLc0djNtXfdA7
        xMjEwXiIUYKDWUmEN3kxV6IQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1ML
        UotgskwcnFINTBO33jI6LFr696+T2YKi7A/crDW+WdK/qj4K2E+psp/9KOa0EGO23+SnGVv/
        Tf5spXg4J//Ita72Q8n6UY82/mDL+abm9e1Fx46f/EHP1I5wXCiM2Jca4vW95jW/vDWX6Lzq
        HUopfOcii4tivHuvb7kScI93mkfUkzDR/+rrt4Zw7ud+/UDbvN97cWSGt3xNBtPir41cW4r0
        yhbed29bulQ0Z0HAzYX8igszPnQKh3i5WpY/zLpxOtIoYq30D7GDKm+3bTUTDLy4dhVHlLGN
        lfVu524lI20T9YPX06YwFrObr1vfH9W6+7aazcca35sVCezh3cEyO8qvSGxoZJzatqPkpevd
        qnNcu9WTdlxWYinOSDTUYi4qTgQACJf3hwcDAAA=
X-CMS-MailID: 20210805061554epcas1p26484b6aa7d1a44930350f8ffed4bbe3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210805061554epcas1p26484b6aa7d1a44930350f8ffed4bbe3f
References: <20210805060546.3268-1-namjae.jeon@samsung.com>
        <CGME20210805061554epcas1p26484b6aa7d1a44930350f8ffed4bbe3f@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a document describing ksmbd design, key features and usage.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 Documentation/filesystems/cifs/index.rst |  10 ++
 Documentation/filesystems/cifs/ksmbd.rst | 164 +++++++++++++++++++++++
 Documentation/filesystems/index.rst      |   2 +-
 3 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/cifs/index.rst
 create mode 100644 Documentation/filesystems/cifs/ksmbd.rst

diff --git a/Documentation/filesystems/cifs/index.rst b/Documentation/filesystems/cifs/index.rst
new file mode 100644
index 000000000000..1c8597a679ab
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
+   ksmbd
+   cifsroot
diff --git a/Documentation/filesystems/cifs/ksmbd.rst b/Documentation/filesystems/cifs/ksmbd.rst
new file mode 100644
index 000000000000..1e111efecd45
--- /dev/null
+++ b/Documentation/filesystems/cifs/ksmbd.rst
@@ -0,0 +1,164 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+KSMBD - SMB3 Kernel Server
+==========================
+
+KSMBD is a linux kernel server which implements SMB3 protocol in kernel space
+for sharing files over network.
+
+KSMBD architecture
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
+KSMBD Feature Status
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
+Shutdown KSMBD
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
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 246af51b277a..7e1f44c14e6f 100644
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

