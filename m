Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C270161768
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgBQQNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XL0RC242yGEdYAKvPtjJDxMTTmgPVKj+8fzli+YYpH4=; b=dOiW/9AHKHJnUcSFfGGlb+zMxk
        hDQcxfzbbLJptfRTAJNfT6pSxEvXJOECqnKhYWljDVZiOh721ZgW6C6xtua0b7PnYlY4XXrA7Ida6
        FiOWQQpVaWtRdMfsFieofJJURufmTvZ0Ao6vHrXy3rarGlXwdeqdzyggHJ0p6Lc5i1Leie+eQBP8S
        aM38b8VxkgxPRizvCUPN0lPMbwDWw7VxGPs3msKt/SpGuLng/g3RIeX+u1hvRXJHezvIy6Svsitqy
        Sn8o6Vsd6CkGMOrRu8gh34lkRNvTxZIZfWS8cpn7l3CxA6e/SrMqY9aUOujof9Qt83DwgbnUikvVZ
        gYZDU2iw==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006uQ-4n; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0Z-000fZH-Mm; Mon, 17 Feb 2020 17:12:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/44] docs: filesystems: convert autofs-mount-control.txt to ReST
Date:   Mon, 17 Feb 2020 17:11:51 +0100
Message-Id: <8cae057ae244d0f5b58d3c209bcdae5ed82bc52c.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 ...t-control.txt => autofs-mount-control.rst} | 102 +++++++++---------
 Documentation/filesystems/index.rst           |   1 +
 2 files changed, 53 insertions(+), 50 deletions(-)
 rename Documentation/filesystems/{autofs-mount-control.txt => autofs-mount-control.rst} (89%)

diff --git a/Documentation/filesystems/autofs-mount-control.txt b/Documentation/filesystems/autofs-mount-control.rst
similarity index 89%
rename from Documentation/filesystems/autofs-mount-control.txt
rename to Documentation/filesystems/autofs-mount-control.rst
index acc02fc57993..2903aed92316 100644
--- a/Documentation/filesystems/autofs-mount-control.txt
+++ b/Documentation/filesystems/autofs-mount-control.rst
@@ -1,4 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
 
+====================================================================
 Miscellaneous Device control operations for the autofs kernel module
 ====================================================================
 
@@ -36,24 +38,24 @@ For example, there are two types of automount maps, direct (in the kernel
 module source you will see a third type called an offset, which is just
 a direct mount in disguise) and indirect.
 
-Here is a master map with direct and indirect map entries:
+Here is a master map with direct and indirect map entries::
 
-/-      /etc/auto.direct
-/test   /etc/auto.indirect
+    /-      /etc/auto.direct
+    /test   /etc/auto.indirect
 
-and the corresponding map files:
+and the corresponding map files::
 
-/etc/auto.direct:
+    /etc/auto.direct:
 
-/automount/dparse/g6  budgie:/autofs/export1
-/automount/dparse/g1  shark:/autofs/export1
-and so on.
+    /automount/dparse/g6  budgie:/autofs/export1
+    /automount/dparse/g1  shark:/autofs/export1
+    and so on.
 
-/etc/auto.indirect:
+/etc/auto.indirect::
 
-g1    shark:/autofs/export1
-g6    budgie:/autofs/export1
-and so on.
+    g1    shark:/autofs/export1
+    g6    budgie:/autofs/export1
+    and so on.
 
 For the above indirect map an autofs file system is mounted on /test and
 mounts are triggered for each sub-directory key by the inode lookup
@@ -69,23 +71,23 @@ use the follow_link inode operation to trigger the mount.
 But, each entry in direct and indirect maps can have offsets (making
 them multi-mount map entries).
 
-For example, an indirect mount map entry could also be:
+For example, an indirect mount map entry could also be::
 
-g1  \
-   /        shark:/autofs/export5/testing/test \
-   /s1      shark:/autofs/export/testing/test/s1 \
-   /s2      shark:/autofs/export5/testing/test/s2 \
-   /s1/ss1  shark:/autofs/export1 \
-   /s2/ss2  shark:/autofs/export2
+    g1  \
+    /        shark:/autofs/export5/testing/test \
+    /s1      shark:/autofs/export/testing/test/s1 \
+    /s2      shark:/autofs/export5/testing/test/s2 \
+    /s1/ss1  shark:/autofs/export1 \
+    /s2/ss2  shark:/autofs/export2
 
-and a similarly a direct mount map entry could also be:
+and a similarly a direct mount map entry could also be::
 
-/automount/dparse/g1 \
-    /       shark:/autofs/export5/testing/test \
-    /s1     shark:/autofs/export/testing/test/s1 \
-    /s2     shark:/autofs/export5/testing/test/s2 \
-    /s1/ss1 shark:/autofs/export2 \
-    /s2/ss2 shark:/autofs/export2
+    /automount/dparse/g1 \
+	/       shark:/autofs/export5/testing/test \
+	/s1     shark:/autofs/export/testing/test/s1 \
+	/s2     shark:/autofs/export5/testing/test/s2 \
+	/s1/ss1 shark:/autofs/export2 \
+	/s2/ss2 shark:/autofs/export2
 
 One of the issues with version 4 of autofs was that, when mounting an
 entry with a large number of offsets, possibly with nesting, we needed
@@ -170,32 +172,32 @@ autofs Miscellaneous Device mount control interface
 The control interface is opening a device node, typically /dev/autofs.
 
 All the ioctls use a common structure to pass the needed parameter
-information and return operation results:
+information and return operation results::
 
-struct autofs_dev_ioctl {
-	__u32 ver_major;
-	__u32 ver_minor;
-	__u32 size;             /* total size of data passed in
-				 * including this struct */
-	__s32 ioctlfd;          /* automount command fd */
+    struct autofs_dev_ioctl {
+	    __u32 ver_major;
+	    __u32 ver_minor;
+	    __u32 size;             /* total size of data passed in
+				    * including this struct */
+	    __s32 ioctlfd;          /* automount command fd */
 
-	/* Command parameters */
-	union {
-		struct args_protover		protover;
-		struct args_protosubver		protosubver;
-		struct args_openmount		openmount;
-		struct args_ready		ready;
-		struct args_fail		fail;
-		struct args_setpipefd		setpipefd;
-		struct args_timeout		timeout;
-		struct args_requester		requester;
-		struct args_expire		expire;
-		struct args_askumount		askumount;
-		struct args_ismountpoint	ismountpoint;
-	};
+	    /* Command parameters */
+	    union {
+		    struct args_protover		protover;
+		    struct args_protosubver		protosubver;
+		    struct args_openmount		openmount;
+		    struct args_ready		ready;
+		    struct args_fail		fail;
+		    struct args_setpipefd		setpipefd;
+		    struct args_timeout		timeout;
+		    struct args_requester		requester;
+		    struct args_expire		expire;
+		    struct args_askumount		askumount;
+		    struct args_ismountpoint	ismountpoint;
+	    };
 
-	char path[0];
-};
+	    char path[0];
+    };
 
 The ioctlfd field is a mount point file descriptor of an autofs mount
 point. It is returned by the open call and is used by all calls except
@@ -212,7 +214,7 @@ is used account for the increased structure length when translating the
 structure sent from user space.
 
 This structure can be initialized before setting specific fields by using
-the void function call init_autofs_dev_ioctl(struct autofs_dev_ioctl *).
+the void function call init_autofs_dev_ioctl(``struct autofs_dev_ioctl *``).
 
 All of the ioctls perform a copy of this structure from user space to
 kernel space and return -EINVAL if the size parameter is smaller than
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 0598bc52abdc..c9480138d47e 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -51,6 +51,7 @@ Documentation for filesystem implementations.
    affs
    afs
    autofs
+   autofs-mount-control
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

