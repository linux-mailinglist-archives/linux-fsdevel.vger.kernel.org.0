Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359083F4397
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 05:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhHWDJc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Aug 2021 23:09:32 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:13804 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbhHWDJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Aug 2021 23:09:28 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210823030845epoutp019844e568f969befb357a7da0a98fa74d~d0Lczqwoi2661126611epoutp01i
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 03:08:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210823030845epoutp019844e568f969befb357a7da0a98fa74d~d0Lczqwoi2661126611epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629688125;
        bh=OWtDQYI+VWe1u/jagSjeu79khErfVoz5E0X2naGI/WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfhfVmYJ7ThpYLwgxYgFLvgGrXT/jPqDiqvsl9PB2i1F77hAsDW83XrGolB3uMoDu
         dEMtlUi7C7PQ9BjT5tk0I1pUVK4V0K3xdmD/nlpir+7oCVSOFhAK9kA4+E/LrIPoFS
         J1rEC195X2nT/hHxpzBuKPtqnKvjc3nexKidaJNI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210823030844epcas1p1b590825d3e43bbe63f91b722622ca53c~d0LcOYx6J0179001790epcas1p1z;
        Mon, 23 Aug 2021 03:08:44 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.243]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GtHJB3Nr8z4x9Q3; Mon, 23 Aug
        2021 03:08:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.03.10095.A3113216; Mon, 23 Aug 2021 12:08:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210823030841epcas1p1a811d4a6aec75c09581a9b0fb575d23e~d0LZZrCly0179001790epcas1p1m;
        Mon, 23 Aug 2021 03:08:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210823030841epsmtrp113ceeb2393419f8117f0e9b2511aa982~d0LZYk6eS2889928899epsmtrp1q;
        Mon, 23 Aug 2021 03:08:41 +0000 (GMT)
X-AuditID: b6c32a38-6a7ff7000000276f-41-6123113ad405
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.35.08750.93113216; Mon, 23 Aug 2021 12:08:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210823030841epsmtip288ad5f3f50681a832f49a084b29f7e3c~d0LZEvgz_0645806458epsmtip2G;
        Mon, 23 Aug 2021 03:08:41 +0000 (GMT)
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
Subject: [PATCH v8 01/13] ksmbd: add document
Date:   Mon, 23 Aug 2021 11:58:04 +0900
Message-Id: <20210823025816.7496-2-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210823025816.7496-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmnq6VoHKiwZYdEhbHX/9lt2h8p2zx
        +t90FovTExYxWaxcfZTJ4tr99+wWL/7vYrb4+f87o8WevSdZLC7vmsNmcXHZTxaLH9PrLXr7
        PrFatF7Rsti9cRGbxZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7/J37kdljdsNFFo+ds+6ye2xe
        oeWxe8FnJo/dNxvYPFp3/GX3+Pj0FovH3F19jB59W1YxemxZ/JDJ4/MmOY9NT94yBfBGZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAL2ppFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwK9ArTswtLs1L18tLLbEyNDAwMgUqTMjO2PLq
        AnPBc++Ke+sesTUwzrfsYuTkkBAwkZj7ZSZbFyMXh5DADkaJf7NnMEM4nxglnp6Zww7hfGaU
        uNCxhB2mZcb0dlaIxC5GiRfP77HAtXw/MB3I4eBgE9CW+LNFFKRBRCBW4saO12BjmQVmM0s8
        33uKBSQhLKAr8WDJElYQm0VAVWLms5NsIDavgLXE5Te3WCG2yUus3nCAGcTmFLCR+DjpFSNE
        /A6HxN2uYAjbReLJ3HtsELawxKvjW6AulZJ42d8GZZdLnDj5iwnCrpHYMG8fO8idEgLGEj0v
        SkBMZgFNifW79CEqFCV2/p4LtolZgE/i3dceVohqXomONiGIElWJvkuHoQZKS3S1f4Ba5CFx
        /ctuaIj2M0p0vO1gncAoNwthwwJGxlWMYqkFxbnpqcWGBSbwCEvOz93ECE7FWhY7GOe+/aB3
        iJGJg/EQowQHs5II718m5UQh3pTEyqrUovz4otKc1OJDjKbAoJvILCWanA/MBnkl8YYmlgYm
        ZkYmFsaWxmZK4ryMr2QShQTSE0tSs1NTC1KLYPqYODilGpiSIraXH93zQJDTRa49ZaNajFDy
        a4eFB322M7VtOVZ01/nSTP8i2wVpV9RD+TQyStVCKhiOfj5cZ3j69DUBXlOuVmnZ1KjXPjcf
        11Vw6hjsa9ee8jF0adLSrIzpPZqvmU5e8QxzTpWuZ+6dMP/o2dTcDXqbK1/0fK98M7GNb76m
        7MPSXKvd31dZ3Oe0+OeWxfPo0gFzhpJ9R/w5hf0qPcS1zzFzOn5ymKPuV+e09P2NF2fNTred
        nHcqe/ciBeXX8o+PnLbhPn3sWtQLHf+F8ZNWrcmOu8FSOmnFy4b0YxPl4heq1j1aEOqk/duW
        Y7GV644pul9YVhkVmn9YyyNicHV5Sux2zW09dmsuTdvRcFGJpTgj0VCLuag4EQC9w4GMTgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvK6loHKiweflahbHX/9lt2h8p2zx
        +t90FovTExYxWaxcfZTJ4tr99+wWL/7vYrb4+f87o8WevSdZLC7vmsNmcXHZTxaLH9PrLXr7
        PrFatF7Rsti9cRGbxZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7/J37kdljdsNFFo+ds+6ye2xe
        oeWxe8FnJo/dNxvYPFp3/GX3+Pj0FovH3F19jB59W1YxemxZ/JDJ4/MmOY9NT94yBfBGcdmk
        pOZklqUW6dslcGVseXWBueC5d8W9dY/YGhjnW3YxcnJICJhIzJjeztrFyMUhJLCDUWLToS+M
        EAlpiWMnzjB3MXIA2cIShw8XQ9R8YJS48ugEWJxNQFvizxZRkHIRgXiJmw23WUBqmAXWM0uc
        fd3EApIQFtCVeLBkCSuIzSKgKjHz2Uk2EJtXwFri8ptbrBC75CVWbzjADGJzCthIfJz0CuwG
        IaCaP3vWMk1g5FvAyLCKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4arS0djDuWfVB
        7xAjEwfjIUYJDmYlEd6/TMqJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5N
        LUgtgskycXBKNTCdnvR7RcX9mXcXbF6dtvyD7JcAxQXSrMo9nzb5N6//fL3r8pLDl8/e+d+2
        7J1j/NmpRgv0Nl+54beR/eaCSR+so5f8Ki6ZoKfWxiTc8kHgbcWRLUGnYtVb+KMYIpO+Ktz5
        Inmuje+n49//tbFqXkxH9xu8LzyRul8ioF3sfdtvl9vOax6VBJxXeDH/3Id4zxVvz7zVFoyX
        nWJyZSmHp1yRmu5888nzg5Y/tbcTfMyk+bS54ParmSbs6Rs9vR+ucPkkapXc7vEx0PnyeyFz
        x/+e8e8E6yrmp0vtznqr5bVH+QFL9bf1B7yP3O2ekrJYdLv8/M2Nv/nVImOUn63cPHXt3pU8
        7Ot2lB7/7WaS9GpltBJLcUaioRZzUXEiAOHO91wJAwAA
X-CMS-MailID: 20210823030841epcas1p1a811d4a6aec75c09581a9b0fb575d23e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210823030841epcas1p1a811d4a6aec75c09581a9b0fb575d23e
References: <20210823025816.7496-1-namjae.jeon@samsung.com>
        <CGME20210823030841epcas1p1a811d4a6aec75c09581a9b0fb575d23e@epcas1p1.samsung.com>
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
 Documentation/filesystems/cifs/ksmbd.rst | 165 +++++++++++++++++++++++
 Documentation/filesystems/index.rst      |   2 +-
 3 files changed, 176 insertions(+), 1 deletion(-)
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
index 000000000000..a1326157d53f
--- /dev/null
+++ b/Documentation/filesystems/cifs/ksmbd.rst
@@ -0,0 +1,165 @@
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
+SMB3 Multi-channel             Partially Supported. Planned to implement
+                               replay/retry mechanisms for future.
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

