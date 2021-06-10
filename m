Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D5B3A3681
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 23:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhFJVr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 17:47:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36764 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhFJVrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:47:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B40811FD6E;
        Thu, 10 Jun 2021 21:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623361548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dJf9A44fOsNQRcptr99YUCdZcfG8RkwmiFR8dPcaQI=;
        b=utl1VB5z3h8t+2yxfaPPuNg8Pkh058mu8BF0N+N0g+2/WUM1lB9ZGiy4q0j05e4qDx3uwc
        8q65w+JShEChM7q4KiOE/Bn7YTLkE5SJ6O13CcB0Dsvmdw5DsBqWQhdb6GB1yhkT3w3s1a
        mng4BvZnhgtcBUU2dmYKHbDydA5thcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623361548;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dJf9A44fOsNQRcptr99YUCdZcfG8RkwmiFR8dPcaQI=;
        b=gIZobz0WTM7vUWgExrrwsmh6u9r8lJsFb47Kc6aIAlTO+LpZyWPNmag+/9I5Il4LiuaTV9
        SqIXIMKeGDw81uAw==
Received: from echidna.suse.de (unknown [10.163.26.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 95E8DA3B8A;
        Thu, 10 Jun 2021 21:45:48 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH 3/3] docs: remove mention of "crc" cpio format support
Date:   Thu, 10 Jun 2021 23:45:25 +0200
Message-Id: <20210610214525.13891-3-ddiss@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210610214525.13891-1-ddiss@suse.de>
References: <20210610214525.13891-1-ddiss@suse.de>
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
 .../early-userspace/buffer-format.rst         | 25 +++++++------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/early-userspace/buffer-format.rst b/Documentation/driver-api/early-userspace/buffer-format.rst
index 7f74e301fdf3..95e66606b605 100644
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
@@ -40,9 +40,9 @@ grammar, where::
 
 
 In human terms, the initramfs buffer contains a collection of
-compressed and/or uncompressed cpio archives (in the "newc" or "crc"
-formats); arbitrary amounts zero bytes (for padding) can be added
-between members.
+compressed and/or uncompressed cpio archives (in the "newc" format);
+arbitrary amounts zero bytes (for padding) can be added between
+members.
 
 The cpio "TRAILER!!!" entry (cpio end-of-archive) is optional, but is
 not ignored; see "handling of hard links" below.
@@ -55,7 +55,7 @@ by the ASCII string "000012ac"):
 ============= ================== ==============================================
 Field name    Field size	 Meaning
 ============= ================== ==============================================
-c_magic	      6 bytes		 The string "070701" or "070702"
+c_magic	      6 bytes		 The string "070701"
 c_ino	      8 bytes		 File inode number
 c_mode	      8 bytes		 File mode and permissions
 c_uid	      8 bytes		 File uid
@@ -68,8 +68,7 @@ c_min	      8 bytes		 Minor part of file device number
 c_rmaj	      8 bytes		 Major part of device node reference
 c_rmin	      8 bytes		 Minor part of device node reference
 c_namesize    8 bytes		 Length of filename, including final \0
-c_chksum      8 bytes		 Checksum of data field if c_magic is 070702;
-				 otherwise zero
+c_chksum      8 bytes		 Ignored; reserved for unsupported "crc" format
 ============= ================== ==============================================
 
 The c_mode field matches the contents of st_mode returned by stat(2)
@@ -78,12 +77,6 @@ on Linux, and encodes the file type and file permissions.
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

