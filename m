Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B6636764D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 02:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343948AbhDVAjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 20:39:15 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:40629 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbhDVAjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:39:14 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210422003839epoutp0164d6b60376dc2aa354868f63229a11e4~4ByRzhmIY1755917559epoutp01v
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 00:38:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210422003839epoutp0164d6b60376dc2aa354868f63229a11e4~4ByRzhmIY1755917559epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619051919;
        bh=8oyUU47YhVZBDr3YrD13x6gtMMa62XXjBdzT/ksA+Pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPpMdIf7Ue2t6rpkDrwtjUwu7mXnTi4WOK9yBVQ7iJLXHJTLMQRTwTwlJPUKzmo6h
         MptzNntmsITXbXYZtnHQq76Mb4Q23TC1O96zOoJ8nQB5Tn+pW+lHmoZhczAplu1KDq
         PqS3DKvf7/QWhtFfNfzebOdtXbBIoDktPU1wEPlM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210422003838epcas1p36f7c05de18b970b3e47359d7ea16d872~4ByRF-0KE0971509715epcas1p3g;
        Thu, 22 Apr 2021 00:38:38 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.159]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FQdnn1Xq9z4x9Px; Thu, 22 Apr
        2021 00:38:37 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.91.09701.C85C0806; Thu, 22 Apr 2021 09:38:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210422003836epcas1p391ed30aed1cf7b010b93c32fc1aebe89~4ByPZOKMw1133711337epcas1p3J;
        Thu, 22 Apr 2021 00:38:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210422003836epsmtrp16c00324903b89339a6e158ddf7403905~4ByPYL1hn2297822978epsmtrp1e;
        Thu, 22 Apr 2021 00:38:36 +0000 (GMT)
X-AuditID: b6c32a36-647ff700000025e5-18-6080c58c76f4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.E9.08163.C85C0806; Thu, 22 Apr 2021 09:38:36 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210422003836epsmtip1f9f7c1b5ef7e2723859246e20961b984~4ByPFnduQ1901119011epsmtip1T;
        Thu, 22 Apr 2021 00:38:36 +0000 (GMT)
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
Subject: [PATCH v2 01/10] cifsd: add document
Date:   Thu, 22 Apr 2021 09:28:15 +0900
Message-Id: <20210422002824.12677-2-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210422002824.12677-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmgW7v0YYEg4unmCwa355msTj++i+7
        xe/VvWwWr/9NZ7E4PWERk8XK1UeZLK7df89usWfvSRaLy7vmsFn8mF5v8fYOUEVv3ydWi9Yr
        Wha7Ny5is1j7+TG7xZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7zGroZfOY3XCRxWPnrLvsHptX
        aHnsvtnA5tG64y+7x8ent1g8+rasYvTYsvghk8f6LVdZPD5vkvPY9OQtUwBPVI5NRmpiSmqR
        Qmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCLSgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwCQ4MCveLE3OLSvHS95PxcK0MDAyNToMqEnIzOKQ0sBb+c
        K9o3P2FpYOw27WLk5JAQMJHY/H0LUxcjF4eQwA5GiTfnd7BAOJ8YJb49n8gM4XxmlPjS8p0R
        pmVtxzlGiMQuRoldK24gtOxaMpWti5GDg01AW+LPFlEQU0TAXuL2Yh+QEmaBQ8wSX6/0gQ0S
        FtCVOLscZDcnB4uAqsSp/0fZQWxeARuJ9te/oJbJS6zecIAZxOYUsJX4tWEl2GIJgQscEq+u
        9bJAFLlI3F26kgnCFpZ4dXwLO4QtJfGyv40d5AgJgWqJj/uZIcIdjBIvvttC2MYSN9dvYAUp
        YRbQlFi/Sx8irCix8/dcsBOYBfgk3n3tYYWYwivR0SYEUaIq0XfpMNRSaYmu9g9QSz0kjj5v
        ZoeEyARGiQ0T/7FOYJSbhbBhASPjKkax1ILi3PTUYsMCI+QI28QITsJaZjsYJ739oHeIkYmD
        8RCjBAezkgjv2uKGBCHelMTKqtSi/Pii0pzU4kOMpsCwm8gsJZqcD8wDeSXxhqZGxsbGFiZm
        5mamxkrivOnO1QlCAumJJanZqakFqUUwfUwcnFINTIusAuMuXjQ9+GpB2fzDbY0zXNmXvvni
        2Zc/J0Wy5VCB4iuzW6+mntcp4WkyyHVleCPObH0+Xz/Z7njIe9mb0rGqrILcmronk0JCzv/b
        UD15O59KeULdrB3CIdkTWgNYbI4GB8l8XiX/fkr7lQwerXX977yWVSdIuv+UC7oeznMr9sEd
        94gq9eOKp+13hp21YJxbsPvPtpLVjtNz66rKd2v+Tfxz049l5R/RvSWW6QEL+r84z+901vzr
        vfux1rfkaxts/JW0F8tJNU1jD5A/kX9ZxdrIRUn6XPbaL7r+z442J/qtmXH38vHdkwqkzrTd
        1opU+xP82Va/zMcgftX3Loc/W9sjnd5u6k+z4tdQYinOSDTUYi4qTgQAyXJBQEsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSnG7P0YYEg1WzJS0a355msTj++i+7
        xe/VvWwWr/9NZ7E4PWERk8XK1UeZLK7df89usWfvSRaLy7vmsFn8mF5v8fYOUEVv3ydWi9Yr
        Wha7Ny5is1j7+TG7xZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7zGroZfOY3XCRxWPnrLvsHptX
        aHnsvtnA5tG64y+7x8ent1g8+rasYvTYsvghk8f6LVdZPD5vkvPY9OQtUwBPFJdNSmpOZllq
        kb5dAldG55QGloJfzhXtm5+wNDB2m3YxcnJICJhIrO04x9jFyMUhJLCDUWLjsxNsEAlpiWMn
        zjB3MXIA2cIShw8XQ9R8YJS4dWM6K0icTUBb4s8WUZByEQFHiRNTF4HNYRa4xizxbfsERpCE
        sICuxNnlW5hAbBYBVYlT/4+yg9i8AjYS7a9/MULskpdYveEAM4jNKWAr8WvDSrC4EFBN0/Sr
        LBMY+RYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOFi2tHYx7Vn3QO8TIxMF4
        iFGCg1lJhHdtcUOCEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJM
        HJxSDUy2PZsWlP5Y/9bMjynb4MbEpKdyBs7Mm2eZzv3y40TL+R4t1epQnTvyMk/fccfoO8md
        U/jop5Nf51/dy/TwtUJdxrkCxotbjuvYWJRp13fJvArPy7QzPVxtfrHatIz9QpRfyL6FvYpv
        L7wtvCnk/Ggb91Vrabu0ZNueyAtzpdTrZ26X2/GxeeJ+yT5t0ztBk97I/UwTkfZ6yNUSFbHu
        zaI/y9hrNbW2M5cp2z9S7Xbo4Cj/GHhNl/2L4K6Yc9Wfyqb5BmSL8eqc12RRLTqwlb1nfv49
        6ZVds44s/1Jx++7MgKv/JRacK5Bd8NuaLZV7iqWpa9Q2tRQnS7vGo5s4OmJ4amX8D6a1ph74
        +n2hEktxRqKhFnNRcSIANpBzTQUDAAA=
X-CMS-MailID: 20210422003836epcas1p391ed30aed1cf7b010b93c32fc1aebe89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210422003836epcas1p391ed30aed1cf7b010b93c32fc1aebe89
References: <20210422002824.12677-1-namjae.jeon@samsung.com>
        <CGME20210422003836epcas1p391ed30aed1cf7b010b93c32fc1aebe89@epcas1p3.samsung.com>
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
 Documentation/filesystems/cifs/cifsd.rst | 152 +++++++++++++++++++++++
 Documentation/filesystems/cifs/index.rst |  10 ++
 Documentation/filesystems/index.rst      |   2 +-
 3 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/cifs/cifsd.rst
 create mode 100644 Documentation/filesystems/cifs/index.rst

diff --git a/Documentation/filesystems/cifs/cifsd.rst b/Documentation/filesystems/cifs/cifsd.rst
new file mode 100644
index 000000000000..cb9f87b8529f
--- /dev/null
+++ b/Documentation/filesystems/cifs/cifsd.rst
@@ -0,0 +1,152 @@
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
+                               excluding security vulnerable SMB1.
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
+SMB3 encryption(CCM, GCM)      Supported.
+SMB direct(RDMA)               Partial Supported. SMB3 Multi-channel is required
+                               to connect to Windows client.
+SMB3 Multi-channel             In Progress.
+SMB3.1.1 POSIX extension       Supported.
+ACLs                           Partial Supported. only DACLs available, SACLs is
+                               planned for future. ksmbd generate random subauth
+                               values(then store it to disk) and use uid/gid
+                               get from inode as RID for local domain SID.
+                               The current acl implementation is limited to
+                               standalone server, not a domain member.
+Kerberos                       Supported.
+Durable handle v1,v2           Planned for future.
+Persistent handle              Planned for future.
+SMB2 notify                    Planned for future.
+Sparse file support            Supported.
+DCE/RPC support                Partial Supported. a few calls(NetShareEnumAll,
+                               NetServerGetInfo, SAMR, LSARPC) that needed as
+                               file server via netlink interface from
+                               ksmbd.mountd.
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
index 1f76b1cb3348..085702b5dbba 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -71,7 +71,7 @@ Documentation for filesystem implementations.
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

