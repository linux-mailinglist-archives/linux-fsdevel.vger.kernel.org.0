Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB08116173A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgBQQMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbgBQQMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kFvy5rqL34bI0bK+22oPoeMBpoKLvb1SoXQIRtCvZpg=; b=ehzwVISLVYJaH0kSdhXpXOUoia
        yyMnb/n0ZjkTOKEyhIwlyx4Ok6sEP6Nb4JMdMGdQ7r7/bDcGyyUm5TzOwu9eHxuRuoVQJpBCj/wUC
        AIMIGSDJ7zTAtRYo7DYgUJ8xQ2DNcWFIepdAzstjEx8lUo5ew/gWnYfLFQpFlSFMlMMXOTFgA2byr
        iyBc55+aWHhK/3ABp09Yznf/OPb8RrQieqP6/y8VJR9rGXjveAie6wQHyuJoghFbsesLqWizSXejp
        ZIR2NU9WFxnf23raDqhambNrdQqNIXsvp8/RwNz9zy2CB4EuFxjnvgWDuK7D4ZPz29WSepswbKpq9
        40RLffLA==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0e-0006uX-2H; Mon, 17 Feb 2020 16:12:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fcJ-EL; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 42/44] docs: filesystems: convert ubifs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:28 +0100
Message-Id: <9043dc2965cafc64e6a521e2317c00ecc8303bf6.1581955849.git.mchehab+huawei@kernel.org>
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
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Add lists markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../filesystems/{ubifs.txt => ubifs.rst}      | 25 +++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)
 rename Documentation/filesystems/{ubifs.txt => ubifs.rst} (91%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index bb14738df358..58d57c9bf922 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -90,6 +90,7 @@ Documentation for filesystem implementations.
    sysfs
    sysv-fs
    tmpfs
+   ubifs
    ubifs-authentication.rst
    virtiofs
    vfat
diff --git a/Documentation/filesystems/ubifs.txt b/Documentation/filesystems/ubifs.rst
similarity index 91%
rename from Documentation/filesystems/ubifs.txt
rename to Documentation/filesystems/ubifs.rst
index acc80442a3bb..e6ee99762534 100644
--- a/Documentation/filesystems/ubifs.txt
+++ b/Documentation/filesystems/ubifs.rst
@@ -1,5 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+UBI File System
+===============
+
 Introduction
-=============
+============
 
 UBIFS file-system stands for UBI File System. UBI stands for "Unsorted
 Block Images". UBIFS is a flash file system, which means it is designed
@@ -79,6 +85,7 @@ Mount options
 
 (*) == default.
 
+====================	=======================================================
 bulk_read		read more in one go to take advantage of flash
 			media that read faster sequentially
 no_bulk_read (*)	do not bulk-read
@@ -98,6 +105,7 @@ auth_key=		specify the key used for authenticating the filesystem.
 auth_hash_name=		The hash algorithm used for authentication. Used for
 			both hashing and for creating HMACs. Typical values
 			include "sha256" or "sha512"
+====================	=======================================================
 
 
 Quick usage instructions
@@ -107,12 +115,14 @@ The UBI volume to mount is specified using "ubiX_Y" or "ubiX:NAME" syntax,
 where "X" is UBI device number, "Y" is UBI volume number, and "NAME" is
 UBI volume name.
 
-Mount volume 0 on UBI device 0 to /mnt/ubifs:
-$ mount -t ubifs ubi0_0 /mnt/ubifs
+Mount volume 0 on UBI device 0 to /mnt/ubifs::
+
+    $ mount -t ubifs ubi0_0 /mnt/ubifs
 
 Mount "rootfs" volume of UBI device 0 to /mnt/ubifs ("rootfs" is volume
-name):
-$ mount -t ubifs ubi0:rootfs /mnt/ubifs
+name)::
+
+    $ mount -t ubifs ubi0:rootfs /mnt/ubifs
 
 The following is an example of the kernel boot arguments to attach mtd0
 to UBI and mount volume "rootfs":
@@ -122,5 +132,6 @@ References
 ==========
 
 UBIFS documentation and FAQ/HOWTO at the MTD web site:
-http://www.linux-mtd.infradead.org/doc/ubifs.html
-http://www.linux-mtd.infradead.org/faq/ubifs.html
+
+- http://www.linux-mtd.infradead.org/doc/ubifs.html
+- http://www.linux-mtd.infradead.org/faq/ubifs.html
-- 
2.24.1

