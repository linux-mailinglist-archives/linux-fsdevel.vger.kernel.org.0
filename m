Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE55B161777
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgBQQNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1bNPuIyuSZ2/UdgmTbtGEMggf4pmcGLb2N9GWIrE96U=; b=ndHS5HUeQphK57MSbjMRy3rdm2
        c1Tw0ueWL5RR38TNxQWMtO01xxXDPjZK1P6v+bQ/hiwVRJiFidZTFqOmLCJKQ5+E3JD5bOMha8OOI
        SIXAtWYT5g/tDu0KwQM2aEMjwNWACyr7uXxrF/yxEGsanlRzGHbkqTURVEy8RDHcZgdjKlpxNzJnr
        AI+36BVonpWX8Y4kgIXIN1lIUgpKS5FdP4gqn60NZPSKGvo0kF+fJOCqivO5aL9kN67fc6PRQFiQa
        gsyjb5crVX6JGidmJxXP/4WfPTYiDfaKUY2WfOKxLsili/75jt29TLzaGJREjUFfDpJKr5A9J0PCV
        KK4ee71Q==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006uM-5Y; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0Z-000fZ4-Jv; Mon, 17 Feb 2020 17:12:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/44] docs: filesystems: convert adfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:11:48 +0100
Message-Id: <15ee92f03ec917e5d26bd7b863565dec88c843f6.1581955849.git.mchehab+huawei@kernel.org>
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
- Add a document title;
- Adjust section titles;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{adfs.txt => adfs.rst}        | 29 ++++++++++++-------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 20 insertions(+), 10 deletions(-)
 rename Documentation/filesystems/{adfs.txt => adfs.rst} (85%)

diff --git a/Documentation/filesystems/adfs.txt b/Documentation/filesystems/adfs.rst
similarity index 85%
rename from Documentation/filesystems/adfs.txt
rename to Documentation/filesystems/adfs.rst
index 0baa8e8c1fc1..5b22cae38e5e 100644
--- a/Documentation/filesystems/adfs.txt
+++ b/Documentation/filesystems/adfs.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+Acorn Disc Filing System - ADFS
+===============================
+
 Filesystems supported by ADFS
 -----------------------------
 
@@ -25,6 +31,7 @@ directory updates, specifically updating the access mode and timestamp.
 Mount options for ADFS
 ----------------------
 
+  ============  ======================================================
   uid=nnn	All files in the partition will be owned by
 		user id nnn.  Default 0 (root).
   gid=nnn	All files in the partition will be in group
@@ -36,22 +43,23 @@ Mount options for ADFS
   ftsuffix=n	When ftsuffix=0, no file type suffix will be applied.
 		When ftsuffix=1, a hexadecimal suffix corresponding to
 		the RISC OS file type will be added.  Default 0.
+  ============  ======================================================
 
 Mapping of ADFS permissions to Linux permissions
 ------------------------------------------------
 
   ADFS permissions consist of the following:
 
-	Owner read
-	Owner write
-	Other read
-	Other write
+	- Owner read
+	- Owner write
+	- Other read
+	- Other write
 
   (In older versions, an 'execute' permission did exist, but this
-   does not hold the same meaning as the Linux 'execute' permission
-   and is now obsolete).
+  does not hold the same meaning as the Linux 'execute' permission
+  and is now obsolete).
 
-  The mapping is performed as follows:
+  The mapping is performed as follows::
 
 	Owner read				-> -r--r--r--
 	Owner write				-> --w--w---w
@@ -66,17 +74,18 @@ Mapping of ADFS permissions to Linux permissions
 	Possible other mode permissions		-> ----rwxrwx
 
   Hence, with the default masks, if a file is owner read/write, and
-  not a UnixExec filetype, then the permissions will be:
+  not a UnixExec filetype, then the permissions will be::
 
 			-rw-------
 
   However, if the masks were ownmask=0770,othmask=0007, then this would
-  be modified to:
+  be modified to::
+
 			-rw-rw----
 
   There is no restriction on what you can do with these masks.  You may
   wish that either read bits give read access to the file for all, but
-  keep the default write protection (ownmask=0755,othmask=0577):
+  keep the default write protection (ownmask=0755,othmask=0577)::
 
 			-rw-r--r--
 
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index a9330c3f8c2e..14dc89c94822 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -47,6 +47,7 @@ Documentation for filesystem implementations.
    :maxdepth: 2
 
    9p
+   adfs
    autofs
    fuse
    overlayfs
-- 
2.24.1

