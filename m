Return-Path: <linux-fsdevel+bounces-17142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8E8A83DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52FE1F2497C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E39913D60D;
	Wed, 17 Apr 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="HfYkZrL7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF4EDC;
	Wed, 17 Apr 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359466; cv=none; b=dhspo5p1Z5OS/hJ41Za4Ayg2z6sqCLxYFkTw7t0IIfXoqRg7JeELpPuAYpfq5ZvW01iVgtL/90EcAJGLkEv+xmBKMFFnm9Uy4li+t7Zj+S4Opr6FkZE1DpP24cdEQP0kHpQQldzq1z8CKHacgms+6WaYzQq6SiSQKKfUBmfkEKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359466; c=relaxed/simple;
	bh=0YKqo7UEfJKQTsq4A++ORS6N4xFhJAVWzE9smktPIoo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=HZ8+2PIidh606QyaDkQMKCnZuagSV/wEhbNtPw8wI1dMgJR8uYnKk9113UYK7RLF2ny/tQu8rBSG0fEqLAMmZwIo6RQrd6V1RRkMsd73f26P5vk+YtKv2Yw/dRZdHyb5Ki8TY2EHhjgg1mNxFf8/iIVYvSVNIGcRwI2QJ5u3pq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=HfYkZrL7; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 734F02126;
	Wed, 17 Apr 2024 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713359011;
	bh=G9XKR3MvwzmqgbDgmesN/ZrFgai4sTl/pKO/5Nm44xg=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=HfYkZrL74s4E2urBXmM9SZ7LkdD5mMF2+KT0+6GvTuamYWDEv10u/q+iiicEbpmPi
	 XDdhhg/N1ulH+PzEczm03Tz6uzwhJ/kUWhUAby+uFzWap1CJXVwwbAMrzxuj2Z39Tu
	 zSDt/loGGudbXmgZHZWiBA8z3VTj2/M+9AqUgYHQ=
Received: from [192.168.211.39] (192.168.211.39) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Apr 2024 16:10:59 +0300
Message-ID: <0cb0b314-e4f6-40a2-9628-0fe7d905a676@paragon-software.com>
Date: Wed, 17 Apr 2024 16:10:59 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 11/11] fs/ntfs3: Taking DOS names into account during link
 counting
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>, Johan Hovold
	<johan@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Anton
 Altaparmakov <anton@tuxera.com>
References: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Language: en-US
In-Reply-To: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

When counting and checking hard links in an ntfs file record,

   struct MFT_REC {
     struct NTFS_RECORD_HEADER rhdr; // 'FILE'
     __le16 seq;        // 0x10: Sequence number for this record.
 >>  __le16 hard_links;    // 0x12: The number of hard links to record.
     __le16 attr_off;    // 0x14: Offset to attributes.
   ...

the ntfs3 driver ignored short names (DOS names), causing the link count
to be reduced by 1 and messages to be output to dmesg.

For Windows, such a situation is a minor error, meaning chkdsk does not 
report
errors on such a volume, and in the case of using the /f switch, it silently
corrects them, reporting that no errors were found. This does not affect
the consistency of the file system.

Nevertheless, the behavior in the ntfs3 driver is incorrect and
changes the content of the file system. This patch should fix that.

PS: most likely, there has been a confusion of concepts
MFT_REC::hard_links and inode::__i_nlink.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/inode.c  |  7 ++++---
  fs/ntfs3/record.c | 11 ++---------
  2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index ae4465bf099f..f98200b1a4d2 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -37,7 +37,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
      bool is_dir;
      unsigned long ino = inode->i_ino;
      u32 rp_fa = 0, asize, t32;
-    u16 roff, rsize, names = 0;
+    u16 roff, rsize, names = 0, links = 0;
      const struct ATTR_FILE_NAME *fname = NULL;
      const struct INDEX_ROOT *root;
      struct REPARSE_DATA_BUFFER rp; // 0x18 bytes
@@ -200,11 +200,12 @@ static struct inode *ntfs_read_mft(struct inode 
*inode,
              rsize < SIZEOF_ATTRIBUTE_FILENAME)
              goto out;

+        names += 1;
          fname = Add2Ptr(attr, roff);
          if (fname->type == FILE_NAME_DOS)
              goto next_attr;

-        names += 1;
+        links += 1;
          if (name && name->len == fname->name_len &&
              !ntfs_cmp_names_cpu(name, (struct le_str *)&fname->name_len,
                      NULL, false))
@@ -429,7 +430,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
          ni->mi.dirty = true;
      }

-    set_nlink(inode, names);
+    set_nlink(inode, links);

      if (S_ISDIR(mode)) {
          ni->std_fa |= FILE_ATTRIBUTE_DIRECTORY;
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 6aa3a9d44df1..6c76503edc20 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -534,16 +534,9 @@ bool mi_remove_attr(struct ntfs_inode *ni, struct 
mft_inode *mi,
      if (aoff + asize > used)
          return false;

-    if (ni && is_attr_indexed(attr)) {
+    if (ni && is_attr_indexed(attr) && attr->type == ATTR_NAME) {
          u16 links = le16_to_cpu(ni->mi.mrec->hard_links);
-        struct ATTR_FILE_NAME *fname =
-            attr->type != ATTR_NAME ?
-                NULL :
-                resident_data_ex(attr,
-                         SIZEOF_ATTRIBUTE_FILENAME);
-        if (fname && fname->type == FILE_NAME_DOS) {
-            /* Do not decrease links count deleting DOS name. */
-        } else if (!links) {
+        if (!links) {
              /* minor error. Not critical. */
          } else {
              ni->mi.mrec->hard_links = cpu_to_le16(links - 1);
-- 
2.34.1


