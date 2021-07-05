Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECC63BB584
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 05:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhGEDUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 23:20:11 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21477 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGEDUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:20:05 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210705031727epoutp035175f65909cbd88f33f213097ef3d8a7~OxsD03lCb3232732327epoutp030
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jul 2021 03:17:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210705031727epoutp035175f65909cbd88f33f213097ef3d8a7~OxsD03lCb3232732327epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625455047;
        bh=bqPvbEo5egD1jgRPz3GkcqbEWe3lRSNoRyW4ePFRMyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcmYu/FWgQIxFAXToPk2TAqbmLLAFQpfmu7VFwOgK1dM6Olh5OVEWUnTc8Bx2zIO3
         N/lN6Zh2H6KMUSiQqDeBt+zrz+3ikgGFb6VklZ0NoNPWa7dSXVA9Ztmm9aM4RYNqlX
         jCcFbIu2HTUGsCSmXxbyj4Mn3SsFM5BE4Nt4I7yg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210705031726epcas1p1fb7645b357f62ec89b32a2351d7a9a96~OxsC3tXIE1195311953epcas1p13;
        Mon,  5 Jul 2021 03:17:26 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.163]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GJ9pr1Z0rz4x9Pw; Mon,  5 Jul
        2021 03:17:24 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.3C.09468.3C972E06; Mon,  5 Jul 2021 12:17:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210705031723epcas1p4ac9261186053af0c348b1c7f07b5d557~OxsAHPuCz0813108131epcas1p4Z;
        Mon,  5 Jul 2021 03:17:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210705031723epsmtrp28cf14b01382b27821ed107bed5ec1ffa~OxsAGkH-B1726817268epsmtrp2x;
        Mon,  5 Jul 2021 03:17:23 +0000 (GMT)
X-AuditID: b6c32a37-0c7ff700000024fc-f8-60e279c3eab2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.EC.08289.3C972E06; Mon,  5 Jul 2021 12:17:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210705031723epsmtip221a29b92548150de2eb33dec0eb63d95~Oxr-ysEfH2530725307epsmtip2_;
        Mon,  5 Jul 2021 03:17:23 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        willy@infradead.org, hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, dan.carpenter@oracle.com, hch@lst.de,
        christian@brauner.io, smfrench@gmail.com, hyc.lee@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v5 01/13] ksmbd: add document
Date:   Mon,  5 Jul 2021 12:07:17 +0900
Message-Id: <20210705030729.10292-2-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705030729.10292-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmvu6RykcJBosXMVo0vj3NYnH89V92
        i8Z3yhav/01nsTg9YRGTxcrVR5ksrt1/z27x4v8uZouf/78zWuzZe5LF4vKuOWwWP6bXW/T2
        fWK1aL2iZbF74yI2izcvDrNZ3Jo4n83i/N/jrBa/f8xhcxD2+Dv3I7PH7IaLLB47Z91l99i8
        Qstj94LPTB67bzawebTu+Mvu8fHpLRaPvi2rGD22LH7I5LF+y1UWj8+b5Dw2PXnLFMAblWOT
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA/SmkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ+PE
        LJWCVu+KDVvPMzYwPrHoYuTkkBAwkVj/dztLFyMXh5DADkaJzo9TGCGcT4wSP79fYIJwPjNK
        HJu4mAmmZc6Fd1CJXYwS1+7vZwNJgLUsX5bQxcjBwSagLfFniyhIWEQgVuLGjtfMIPXMArOZ
        JW7t3MIKkhAW0JV40H8DbCiLgKrEss59zCA2r4CNxMkjy6GWyUus3nAALM4pYCuxt+sqK8gg
        CYEbHBKr3yxihihykbjatJYNwhaWeHV8CzuELSXx+d1eqHi5xImTv6CG1khsmLePHeRQCQFj
        iZ4XJSAms4CmxPpd+hAVihI7f89lBLGZBfgk3n3tYYWo5pXoaBOCKFGV6Lt0GGqgtERX+weo
        pR4SOw6fhgbPBEaJFW9+ME9glJuFsGEBI+MqRrHUguLc9NRiwwJj5PjaxAhOxVrmOxinvf2g
        d4iRiYPxEKMEB7OSCG/ovHsJQrwpiZVVqUX58UWlOanFhxhNgWE3kVlKNDkfmA3ySuINTY2M
        jY0tTMzMzUyNlcR5d7IdShASSE8sSc1OTS1ILYLpY+LglGpgmpnPGx29JGp/9C1j+5WL0qWZ
        BVmKWJQY7KUEbLQOT1fhOl/w4v2MyX9W6ptEVl7Yo/NH2TnGey2n0uWZLC0/JqrPVXrLyzyt
        Q91BY/aymNiSr0vTjy15s1Xzn7ZnpRfPk8wd3eXbDq1bs1dEr7UycL+GXFY355LU0peMyQKi
        yY1H72Wb7xKYX6TS//evrIMr/8+QYpG71pVt/5ad5T7X+FeVNf7rxX+ZumX/Spv7L3YVxNge
        NNxq4ng9eyZne8qU+vOcedP9XiSHPHiz7tqkjKNmGqFztXdvncBh3tjzPLBCJHi6v6Zj4tcQ
        hk2f5Mzn/r32oHDWN7FD/xWeS9tun3/n77oUGYbLguYbS08qsRRnJBpqMRcVJwIAVDA2Wk4E
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvO7hykcJBtueSVg0vj3NYnH89V92
        i8Z3yhav/01nsTg9YRGTxcrVR5ksrt1/z27x4v8uZouf/78zWuzZe5LF4vKuOWwWP6bXW/T2
        fWK1aL2iZbF74yI2izcvDrNZ3Jo4n83i/N/jrBa/f8xhcxD2+Dv3I7PH7IaLLB47Z91l99i8
        Qstj94LPTB67bzawebTu+Mvu8fHpLRaPvi2rGD22LH7I5LF+y1UWj8+b5Dw2PXnLFMAbxWWT
        kpqTWZZapG+XwJVxYpZKQat3xYat5xkbGJ9YdDFyckgImEjMufCOqYuRi0NIYAejxOWZl9gg
        EtISx06cYe5i5ACyhSUOHy6GqPnAKLH2wFU2kDibgLbEny2iIOUiAvESNxtus4DUMAusZ5Z4
        M/UXC0hCWEBX4kH/DSYQm0VAVWJZ5z5mEJtXwEbi5JHlTBC75CVWbzgAFucUsJXY23WVFcQW
        Aqrp/vmDdQIj3wJGhlWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMExo6W1g3HPqg96
        hxiZOBgPMUpwMCuJ8IbOu5cgxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTU
        gtQimCwTB6dUA5OeY7tq0TaFl2kb7RVX3F7MFFNhkFjwJ2u74basN3dt15pXJz/0FnQPFUpM
        dzVmrJ59u/tvVuiP1beMFY3zDj6qeC+0tPhojYJAlbjmgRJVJj7puFchX65MESlk2Zxysqds
        q2qP4M6tjzT0Zrk7b2GLVNL41SNsu6h5n+M7lw0hrseUZmj2O1fG+AkrT0qw2bp7z5y6hq/x
        Yhr3w8q45hW3HL2q6bmt17Zqt6WOuJ7ZalZrPcPYty+PHjkbYcvS6svN/nyvpeiWa5N4tgly
        mxScYN543iUwwOz9vk0hT9Lcw2ptdmTrBM0tq2zOO/K6Z13p7DUzvjpP3VXv6h+j2e1q8tD7
        +TozhQu58l+UWIozEg21mIuKEwEv7OZdCAMAAA==
X-CMS-MailID: 20210705031723epcas1p4ac9261186053af0c348b1c7f07b5d557
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210705031723epcas1p4ac9261186053af0c348b1c7f07b5d557
References: <20210705030729.10292-1-namjae.jeon@samsung.com>
        <CGME20210705031723epcas1p4ac9261186053af0c348b1c7f07b5d557@epcas1p4.samsung.com>
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

