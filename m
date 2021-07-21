Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D85A3D0E83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 14:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhGULXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 07:23:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52264 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbhGULMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:12:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 81FB020325;
        Wed, 21 Jul 2021 11:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626868321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dFD7virWkj+bIVXu9a1QPj6qakD/vsP6mRzRDs9A1AY=;
        b=a5HZ8/QLeWyM64jEfdtNKJ9EnAbeg3A/5zk1MkdzsBY5Iezqwj3LwOjM2prto1Hg2xcZOp
        h0HGz2xKcMPGOmjErD7CgBfSscDb4rskTSrdssGOAb3sLb6JGngQusKBfF+Ydnh0lt6Q8z
        q0W5TtBXayyk4rCbgb2QecDnS//OUz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626868321;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dFD7virWkj+bIVXu9a1QPj6qakD/vsP6mRzRDs9A1AY=;
        b=SVmw4pl8sC1sIjlRrnaWmV2Qt7sH70WpF00eprsF65WvK/dVvBJG7DfEu9ONjqIbR63K3T
        oHzSGtL4OBsYnhDw==
Received: from echidna.suse.de (unknown [10.163.26.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 528C1A3B90;
        Wed, 21 Jul 2021 11:52:01 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 3/3] docs: remove mention of "crc" cpio format support
Date:   Wed, 21 Jul 2021 13:51:53 +0200
Message-Id: <20210721115153.28620-3-ddiss@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210721115153.28620-1-ddiss@suse.de>
References: <20210721115153.28620-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

init/initramfs.c only supports extraction of cpio archives carrying the
"newc" header magic ("070701"). Remove statements indicating support for
the "crc" cpio format.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 .../early-userspace/buffer-format.rst         | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

Version 2:
- reword initramfs padding description, as suggested by Matthew Wilcox

diff --git a/Documentation/driver-api/early-userspace/buffer-format.rst b/Documentation/driver-api/early-userspace/buffer-format.rst
index 7f74e301fdf3..0df76bca444c 100644
--- a/Documentation/driver-api/early-userspace/buffer-format.rst
+++ b/Documentation/driver-api/early-userspace/buffer-format.rst
@@ -14,10 +14,10 @@ is different.  The initramfs buffer contains an archive which is
 expanded into a ramfs filesystem; this document details the format of
 the initramfs buffer format.
 
-The initramfs buffer format is based around the "newc" or "crc" CPIO
-formats, and can be created with the cpio(1) utility.  The cpio
-archive can be compressed using gzip(1).  One valid version of an
-initramfs buffer is thus a single .cpio.gz file.
+The initramfs buffer format is based around the "newc" CPIO format, and
+can be created with the cpio(1) utility.  The cpio archive can be
+compressed using gzip(1).  One valid version of an initramfs buffer is
+thus a single .cpio.gz file.
 
 The full format of the initramfs buffer is defined by the following
 grammar, where::
@@ -40,9 +40,8 @@ grammar, where::
 
 
 In human terms, the initramfs buffer contains a collection of
-compressed and/or uncompressed cpio archives (in the "newc" or "crc"
-formats); arbitrary amounts zero bytes (for padding) can be added
-between members.
+compressed and/or uncompressed cpio archives (in the "newc" format),
+with arbitrary amount of zero-byte padding between members.
 
 The cpio "TRAILER!!!" entry (cpio end-of-archive) is optional, but is
 not ignored; see "handling of hard links" below.
@@ -55,7 +54,7 @@ by the ASCII string "000012ac"):
 ============= ================== ==============================================
 Field name    Field size	 Meaning
 ============= ================== ==============================================
-c_magic	      6 bytes		 The string "070701" or "070702"
+c_magic	      6 bytes		 The string "070701"
 c_ino	      8 bytes		 File inode number
 c_mode	      8 bytes		 File mode and permissions
 c_uid	      8 bytes		 File uid
@@ -68,8 +67,7 @@ c_min	      8 bytes		 Minor part of file device number
 c_rmaj	      8 bytes		 Major part of device node reference
 c_rmin	      8 bytes		 Minor part of device node reference
 c_namesize    8 bytes		 Length of filename, including final \0
-c_chksum      8 bytes		 Checksum of data field if c_magic is 070702;
-				 otherwise zero
+c_chksum      8 bytes		 Ignored; reserved for unsupported "crc" format
 ============= ================== ==============================================
 
 The c_mode field matches the contents of st_mode returned by stat(2)
@@ -78,12 +76,6 @@ on Linux, and encodes the file type and file permissions.
 The c_filesize should be zero for any file which is not a regular file
 or symlink.
 
-The c_chksum field contains a simple 32-bit unsigned sum of all the
-bytes in the data field.  cpio(1) refers to this as "crc", which is
-clearly incorrect (a cyclic redundancy check is a different and
-significantly stronger integrity check), however, this is the
-algorithm used.
-
 If the filename is "TRAILER!!!" this is actually an end-of-archive
 marker; the c_filesize for an end-of-archive marker must be zero.
 
-- 
2.26.2

