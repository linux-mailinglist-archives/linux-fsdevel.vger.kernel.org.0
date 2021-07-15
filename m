Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C2D3CAFD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 02:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhGPAGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 20:06:50 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28730 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhGPAGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 20:06:50 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210716000354epoutp0398e82d7e0d6a9b30d3f54dcb6545a261~SHJNtJzL70474504745epoutp03L
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 00:03:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210716000354epoutp0398e82d7e0d6a9b30d3f54dcb6545a261~SHJNtJzL70474504745epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626393834;
        bh=0ecHHt7lCuZJh3o10h6QCYCxalCSpfibUbGLmS4sLFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPlFMCtGNhpbsZLLkaFElc+mrPaCOC4/aeGEF9pdavoT9TLRxuQ0+H1x0+y18bBSp
         ZoZDVSWJNRvxxHWHmmAQCwMmyIfRjM8i+DhrPQQxJbBjvZLNktd4vuwsRS93Myv/uF
         XXtGLmxssjp6qFavP+RGlusGnAjLWg02ekKFIHIs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210716000351epcas1p18b93ddc1dc6434f2086fe8816c7a046c~SHJK7S8wn1421114211epcas1p1I;
        Fri, 16 Jul 2021 00:03:51 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GQs0Q65Mrz4x9Q6; Fri, 16 Jul
        2021 00:03:50 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.C9.09952.6ECC0F06; Fri, 16 Jul 2021 09:03:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210716000347epcas1p49645cb64b0400b21eaf9e73e5267e211~SHJHCWJ6r0593605936epcas1p4D;
        Fri, 16 Jul 2021 00:03:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210716000347epsmtrp13203e366b91221c99f2adaef0d1269fa~SHJG-ohi12064220642epsmtrp1j;
        Fri, 16 Jul 2021 00:03:47 +0000 (GMT)
X-AuditID: b6c32a35-447ff700000026e0-61-60f0cce6772a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.8E.08289.3ECC0F06; Fri, 16 Jul 2021 09:03:47 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210716000347epsmtip23ebdfe5d3b84fd5d6fe4c45b40d90f8b~SHJGwHJHR1664016640epsmtip2Q;
        Fri, 16 Jul 2021 00:03:47 +0000 (GMT)
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
Subject: [PATCH v6 01/13] ksmbd: add document
Date:   Fri, 16 Jul 2021 08:53:44 +0900
Message-Id: <20210715235356.3191-2-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715235356.3191-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmnu6zMx8SDF6s1Lc4/vovu0XjO2WL
        1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y16+z6xWrRe
        0bLYvXERm8WbF4fZLG5NnM9mcf7vcVaL3z/msDkIefyd+5HZY3bDRRaPnbPusntsXqHlsXvB
        ZyaP3Tcb2Dxad/xl9/j49BaLR9+WVYweWxY/ZPL4vEnOY9OTt0wBPFE5NhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAzykplCXmlAKFAhKLi5X07WyK
        8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEqE3IyJsxpYito9a54v+YS
        awPjE4suRk4OCQETiZ72/exdjFwcQgI7GCX23/4H5XxilPhwbA0LhPOZUeLWol2MMC13/z9k
        BrGFBHYxSrSvEYHrODFnGVA7BwebgLbEny2iIDUiArESN3a8ZgapYRboYpZ4ev8ME0hCWEBX
        ouXBIbChLAKqEruvTGEFsXkFrCUm9raxQSyTl1i94QDYMk4BG4nHJ79BHXGCQ+LSggoI20Vi
        VtcNqLiwxKvjW9ghbCmJl/1tUHa5xImTv5gg7BqJDfP2gd0pIWAs0fOiBMRkFtCUWL9LH6JC
        UWLn77lgE5kF+CTefe1hhajmlehoE4IoUZXou3QYaqC0RFf7B6hFHhIPH/+BhmE/o8Tub0sY
        JzDKzULYsICRcRWjWGpBcW56arFhgSFyfG1iBKddLdMdjBPfftA7xMjEwXiIUYKDWUmEd6nR
        2wQh3pTEyqrUovz4otKc1OJDjKbAoJvILCWanA9M/Hkl8YamRsbGxhYmZuZmpsZK4rw72Q4l
        CAmkJ5akZqemFqQWwfQxcXBKNTA9vXPuld/mrVs3/ZK4+MDjd7ZFzu7YmFkMUQ/FJjpp/jkX
        XB6rLHnwi5teuvCtefKcym33OGQ/bPbjkDgmdlV204qpXcLXlFlfpzWU8G6pmK2XI2KTu+xw
        79zzVtJZ++5nG/8IjrjwXZ1pExOf0iHWSw2Xzx98VFD+3+v56iChgA7h+jvv53D7Vp9gni3w
        4smflncp554YFbyq3MizNNNGTFS1v831nkGynRrnyujLbwMT8i5xd/RcPy+vu2j/VG8Xrdwl
        HFdNH2jeLzgaZTRd40nAnPBHwUXbU7nUfK3eXOASjbN/a1lltXHC90tXF56a8fI1e9iiA9td
        XzukLVj/2ip9T7Ypx+3dD3bNLy1QYinOSDTUYi4qTgQAyMFbhkQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvO7jMx8SDL5sUbM4/vovu0XjO2WL
        1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y16+z6xWrRe
        0bLYvXERm8WbF4fZLG5NnM9mcf7vcVaL3z/msDkIefyd+5HZY3bDRRaPnbPusntsXqHlsXvB
        ZyaP3Tcb2Dxad/xl9/j49BaLR9+WVYweWxY/ZPL4vEnOY9OTt0wBPFFcNimpOZllqUX6dglc
        GRPmNLEVtHpXvF9zibWB8YlFFyMnh4SAicTd/w+Zuxi5OIQEdjBKfD3ZxAaRkJY4duIMUIID
        yBaWOHy4GKLmA6PE5Ia9TCBxNgFtiT9bREHKRQTiJW423GYBqWEWmMMssXPjEUaQhLCArkTL
        g0NgNouAqsTuK1NYQWxeAWuJib1tULvkJVZvOMAMYnMK2Eg8PvkNrF4IqGb9mg0sExj5FjAy
        rGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4QLa0djHtWfdA7xMjEwXiIUYKDWUmE
        d6nR2wQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamFR0
        bpW4OK2cmn5T8N3XqDNLpjNf4zx2X96G815xdV6dj8WLP1ejZaYxm6TdWvlUWvChjVXxb9ek
        Zdfk9pRlGGbF700uy9p6L2Qa26e+cO+yI9szeW1e+KudstR1m1CRcWjn3X8lKhYybH1P3xZ8
        uCauKrJ4atUcn3+Wfcnyh8SMVrsEn3lkkyfyruPdd72Tn9tCip9x5i16fadS9IHLHv0lMn8K
        NjU5eS++eUhcq2Xf/60ZJfw/2zWjUqtZ3vjtED0pvu23WHqiJ9d8JdkE/9VxuodvuhxdIMac
        /uV7kN+xg0E71H0tQ5g39DNLf4k/wJTLFs2WY2t59kWq5DNLJ/szR5dxPj//6ADftTnVSizF
        GYmGWsxFxYkA7/z2Sf8CAAA=
X-CMS-MailID: 20210716000347epcas1p49645cb64b0400b21eaf9e73e5267e211
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210716000347epcas1p49645cb64b0400b21eaf9e73e5267e211
References: <20210715235356.3191-1-namjae.jeon@samsung.com>
        <CGME20210716000347epcas1p49645cb64b0400b21eaf9e73e5267e211@epcas1p4.samsung.com>
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

