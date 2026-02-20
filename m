Return-Path: <linux-fsdevel+bounces-77828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG5vKxPamGkSNgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 23:02:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0594516B19C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 23:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF6123033D0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 22:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE10309F09;
	Fri, 20 Feb 2026 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="cO3UP0uK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1532FE066
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771624943; cv=none; b=S5N98tAWgeDJv/edF7wtWdT7KjXWL2FOzAQK77BAOnGN5mkoAOxbnBmvAzlwrhEyeTb6q+BarqMknIWD76MenTmJJKH0JJSgNSnn5/PgFaRm5muN9T2jSDwe862vOWC+6uaByOECZzse+3ThD/GSmL2Yi9UzxtNRj0jyYjDMU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771624943; c=relaxed/simple;
	bh=QTbdG+9No9SvhL80WgmQu4Oe0XJvjAspcq0PziZA7zM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fqFbx8F2i7WZMuTE7ZDc0u4bEJOYoFjmYtW21Kyn+WISTOPxy7XsmqugFcBBBveoOTxvVAyRGjBIxuDz5owJ1CqYT60Hk8etajXGRFCqi0Ed881GMv0sTQokhS6wJPF+QZV1XFYVNoC3+podzO7D1/Am0d0+O1WiIMr1Yl740qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=cO3UP0uK; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40438e0cba6so1660878fac.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 14:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1771624940; x=1772229740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6BMIV+ycb95ZXcwpSzbRTeTgcmQS/cT3RyP8tmpSyIo=;
        b=cO3UP0uKUAvbO0JM/XNZ1ycTJ/L5AkuKSMltqKF+C/dkcbqrNPAor405qoQdz7O38T
         cMgi6uGBPCfzdRrzwG0MabwGA2lbHKcFMrOujI8L5SIPUbZJVOZeyR4yKckkEXifqkwk
         UukZ4wa40jEmTD6nVsOCKVKcIUUTKqeIxHUmLX8e2Omqt2oi8kB4n6rb2YVl24U+1WDR
         tODLl567VG9pi/4N7h9s+2c1SwldolznMSGi1pyNAnUTSwH+00GfWNJsu1GnmTunqAm6
         dg8qQQYPxhApfnqHspQNROet8Y9v3Ud1fQTXxr70CZQ8Q9DMotj5ahK42uqYSgR4NJml
         TyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771624940; x=1772229740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BMIV+ycb95ZXcwpSzbRTeTgcmQS/cT3RyP8tmpSyIo=;
        b=V5YEYhcJpjMx2+S8S6/70A7g5iDyLnJrjxjqajp6nsQV9wKWNe+gpHCDd1mM7XMvw7
         GnEU6ncAB9h9gE2zCmU96vVHfk7JCSYL/sNtEmovLmlO0FoonFW83ORQFLVALFOHaECh
         1niqHj0UnIjVhYwBZCLJVR6M+4gj1zSOB0SuH0Ea68QM6E0Ksvbd+EzEYXOXNZTtxPmc
         slRlUP73eKMl9lCTP3Wjb77/BXfrozhgr+PNZnigXU6XLLI4WkXmotlp6TRk9MLloqtQ
         9vzQYJzYhrBQ6i7+X/RU0mBgq9vi2bjwRKglRH1azjvDqtxoL09bO8tWLfpr4ut2ZxLj
         N/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3c9acp+HDWIURswggBWem1mval1Aemn9SV2JotgN7Gil0i6CDWMnRt3YOCIW+k7B7xUUTgdGLt6tS118P@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4cG2OXk2T2X3EYMVE6DvjjrPL443tW6+wvvbarOJT5xWmSqa
	uoKpWgKwSDKvU8LTL5WCS0emO0MjyKRv3Pi6nck4m6XcR6bj0BSy8fsBT0VbFZrDRMU=
X-Gm-Gg: AZuq6aIcNqstgWhVZ5JMRa14kqxa/gTbQ+8SJT7HeNj+oTeTJiSD1Hy/XVRyZRe2O5V
	R8AsH5FNNVd8B9PsfzwbQVs1cWA//bPATGqrYeYlOGvVON2sxVa2+xufzxkQf3KFyZ/1PB9nRLs
	feui+PWhcRIgF+J/l2Fz4pd7RNcpl/+0k2A/JSk5mnRP00Hk+XD2RJZ/hlnQ5cWGoKb71pgU3Tv
	rVTDL303wuWkUV3BBX3FILPOhTtoTW4VElTZYq9ZmyIcEBhcmX02s00Rvdf4X4tnOlOs8ZhKZlv
	Cw2LsiVCP7pNy+VJZv53DgOmMz+Qugclr8ThQG7eWTKIgnZCjR4kGn/wI3t8ZSZtwl4arE19dQ/
	AyR9gIP8MYkoNTegnhFRI1AiKa4slA/GX5lwNBHXnkgL3juauswpG/1hpwKMgn+U/odQKjW3uou
	vFA2vxEoSFtYaH0fgYWrqwsL5J9a6RqbHjkG80+KVVOjnpwwhEgNAq819u+wT1Zx5W6Mn7WN/nw
	BC4Z6TlR1jNGH5yB9owuCOh
X-Received: by 2002:a05:6870:f146:b0:409:79d2:43a6 with SMTP id 586e51a60fabf-4157b15e88dmr809710fac.36.1771624940214;
        Fri, 20 Feb 2026 14:02:20 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:ca04:7bff:75dc:8fb1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cf9a231sm695419fac.5.2026.02.20.14.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 14:02:19 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix potential Allocation File corruption after fsync
Date: Fri, 20 Feb 2026 14:01:53 -0800
Message-Id: <20260220220152.152721-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[dubeyko.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77828-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fu-berlin.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivo.com:email]
X-Rspamd-Queue-Id: 0594516B19C
X-Rspamd-Action: no action

The generic/348 test-case has revealed the issue of
HFS+ volume corruption after simulated power failure:

FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc4+ #8 SMP PREEMPT_DYNAMIC Thu May 1 16:43:22 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/348 _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
(see xfstests-dev/results//generic/348.full for details)

The fsck tool complains about Allocation File (block bitmap)
corruption as a result of such event. The generic/348 creates
a symlink, fsync its parent directory, power fail and mount
again the filesystem. Currently, HFS+ logic has several flags
HFSPLUS_I_CAT_DIRTY, HFSPLUS_I_EXT_DIRTY, HFSPLUS_I_ATTR_DIRTY,
HFSPLUS_I_ALLOC_DIRTY. If inode operation modified the Catalog
File, Extents Overflow File, Attributes File, or Allocation
File, then inode is marked as dirty and one of the mentioned
flags has been set. When hfsplus_file_fsync() has been called,
then this set of flags is checked and dirty b-tree or/and
block bitmap is flushed. However, block bitmap can be modified
during file's content allocation. It means that if we call
hfsplus_file_fsync() for directory, then we never flush
the modified Allocation File in such case because such inode
cannot receive HFSPLUS_I_ALLOC_DIRTY flag. Moreover, this
inode-centric model is not good at all because Catalog File,
Extents Overflow File, Attributes File, and Allocation File
represent the whole state of file system metadata. This
inode-centric policy is the main reason of the issue.

This patch saves the whole approach of using HFSPLUS_I_CAT_DIRTY,
HFSPLUS_I_EXT_DIRTY, HFSPLUS_I_ATTR_DIRTY, and
HFSPLUS_I_ALLOC_DIRTY flags. But Catalog File, Extents Overflow
File, Attributes File, and Allocation File have associated
inodes. And namely these inodes become the mechanism of
checking the dirty state of metadata. The hfsplus_file_fsync()
method checks the dirtiness of file system metadata by
testing HFSPLUS_I_CAT_DIRTY, HFSPLUS_I_EXT_DIRTY,
HFSPLUS_I_ATTR_DIRTY, and HFSPLUS_I_ALLOC_DIRTY flags of
Catalog File's, Extents Overflow File's, Attributes File's, or
Allocation File's inodes. As a result, even if we call
hfsplus_file_fsync() for parent folder, then dirty Allocation File
will be flushed anyway.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/attributes.c |  3 +++
 fs/hfsplus/catalog.c    |  3 +++
 fs/hfsplus/dir.c        |  6 ++++++
 fs/hfsplus/extents.c    |  7 +++++++
 fs/hfsplus/hfsplus_fs.h |  7 +++++++
 fs/hfsplus/inode.c      | 27 ++++++++++++++++++++-------
 fs/hfsplus/super.c      |  2 ++
 fs/hfsplus/xattr.c      | 19 +++++++++++++++++--
 8 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index 4b79cd606276..6585bcea731c 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -241,6 +241,7 @@ int hfsplus_create_attr_nolock(struct inode *inode, const char *name,
 		return err;
 	}
 
+	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY);
 	hfsplus_mark_inode_dirty(inode, HFSPLUS_I_ATTR_DIRTY);
 
 	return 0;
@@ -326,6 +327,8 @@ static int __hfsplus_delete_attr(struct inode *inode, u32 cnid,
 	if (err)
 		return err;
 
+	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(inode->i_sb),
+				 HFSPLUS_I_ATTR_DIRTY);
 	hfsplus_mark_inode_dirty(inode, HFSPLUS_I_ATTR_DIRTY);
 	return err;
 }
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 02c1eee4a4b8..eef7412a4d58 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -313,6 +313,7 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	if (S_ISDIR(inode->i_mode))
 		hfsplus_subfolders_inc(dir);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
+	hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb), HFSPLUS_I_CAT_DIRTY);
 	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
 
 	hfs_find_exit(&fd);
@@ -418,6 +419,7 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	if (type == HFSPLUS_FOLDER)
 		hfsplus_subfolders_dec(dir);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
+	hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb), HFSPLUS_I_CAT_DIRTY);
 	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
 
 	if (type == HFSPLUS_FILE || type == HFSPLUS_FOLDER) {
@@ -540,6 +542,7 @@ int hfsplus_rename_cat(u32 cnid,
 	}
 	err = hfs_brec_insert(&dst_fd, &entry, entry_size);
 
+	hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb), HFSPLUS_I_CAT_DIRTY);
 	hfsplus_mark_inode_dirty(dst_dir, HFSPLUS_I_CAT_DIRTY);
 	hfsplus_mark_inode_dirty(src_dir, HFSPLUS_I_CAT_DIRTY);
 out:
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index ca5f74a140ec..0f5eaad738e0 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -478,6 +478,9 @@ static int hfsplus_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (!inode)
 		goto out;
 
+	hfs_dbg("dir->i_ino %lu, inode->i_ino %lu\n",
+		dir->i_ino, inode->i_ino);
+
 	res = page_symlink(inode, symname, strlen(symname) + 1);
 	if (res)
 		goto out_err;
@@ -526,6 +529,9 @@ static int hfsplus_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (!inode)
 		goto out;
 
+	hfs_dbg("dir->i_ino %lu, inode->i_ino %lu\n",
+		dir->i_ino, inode->i_ino);
+
 	if (S_ISBLK(mode) || S_ISCHR(mode) || S_ISFIFO(mode) || S_ISSOCK(mode))
 		init_special_inode(inode, mode, rdev);
 
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 8e886514d27f..a5f772de9985 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -121,6 +121,8 @@ static int __hfsplus_ext_write_extent(struct inode *inode,
 	 * redirty the inode.  Instead the callers have to be careful
 	 * to explicily mark the inode dirty, too.
 	 */
+	set_bit(HFSPLUS_I_EXT_DIRTY,
+		&HFSPLUS_I(HFSPLUS_EXT_TREE_I(inode->i_sb))->flags);
 	set_bit(HFSPLUS_I_EXT_DIRTY, &hip->flags);
 
 	return 0;
@@ -513,6 +515,8 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	if (!res) {
 		hip->alloc_blocks += len;
 		mutex_unlock(&hip->extents_lock);
+		hfsplus_mark_inode_dirty(HFSPLUS_SB(sb)->alloc_file,
+					 HFSPLUS_I_ALLOC_DIRTY);
 		hfsplus_mark_inode_dirty(inode, HFSPLUS_I_ALLOC_DIRTY);
 		return 0;
 	}
@@ -582,6 +586,7 @@ void hfsplus_file_truncate(struct inode *inode)
 		/* XXX: We lack error handling of hfsplus_file_truncate() */
 		return;
 	}
+
 	while (1) {
 		if (alloc_cnt == hip->first_blocks) {
 			mutex_unlock(&fd.tree->tree_lock);
@@ -623,5 +628,7 @@ void hfsplus_file_truncate(struct inode *inode)
 	hip->fs_blocks = (inode->i_size + sb->s_blocksize - 1) >>
 		sb->s_blocksize_bits;
 	inode_set_bytes(inode, hip->fs_blocks << sb->s_blocksize_bits);
+	hfsplus_mark_inode_dirty(HFSPLUS_SB(sb)->alloc_file,
+				 HFSPLUS_I_ALLOC_DIRTY);
 	hfsplus_mark_inode_dirty(inode, HFSPLUS_I_ALLOC_DIRTY);
 }
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 5f891b73a646..122ab57193bb 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -238,6 +238,13 @@ static inline struct hfsplus_inode_info *HFSPLUS_I(struct inode *inode)
 	return container_of(inode, struct hfsplus_inode_info, vfs_inode);
 }
 
+#define HFSPLUS_CAT_TREE_I(sb) \
+	HFSPLUS_SB(sb)->cat_tree->inode
+#define HFSPLUS_EXT_TREE_I(sb) \
+	HFSPLUS_SB(sb)->ext_tree->inode
+#define HFSPLUS_ATTR_TREE_I(sb) \
+	HFSPLUS_SB(sb)->attr_tree->inode
+
 /*
  * Mark an inode dirty, and also mark the btree in which the
  * specific type of metadata is stored.
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 922ff41df042..cdf08393de44 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -324,6 +324,7 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 {
 	struct inode *inode = file->f_mapping->host;
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct super_block *sb = inode->i_sb;
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 	struct hfsplus_vh *vhdr = sbi->s_vhdr;
 	int error = 0, error2;
@@ -344,29 +345,39 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 	/*
 	 * And explicitly write out the btrees.
 	 */
-	if (test_and_clear_bit(HFSPLUS_I_CAT_DIRTY, &hip->flags))
+	if (test_and_clear_bit(HFSPLUS_I_CAT_DIRTY,
+				&HFSPLUS_I(HFSPLUS_CAT_TREE_I(sb))->flags)) {
+		clear_bit(HFSPLUS_I_CAT_DIRTY, &hip->flags);
 		error = filemap_write_and_wait(sbi->cat_tree->inode->i_mapping);
+	}
 
-	if (test_and_clear_bit(HFSPLUS_I_EXT_DIRTY, &hip->flags)) {
+	if (test_and_clear_bit(HFSPLUS_I_EXT_DIRTY,
+				&HFSPLUS_I(HFSPLUS_EXT_TREE_I(sb))->flags)) {
+		clear_bit(HFSPLUS_I_EXT_DIRTY, &hip->flags);
 		error2 =
 			filemap_write_and_wait(sbi->ext_tree->inode->i_mapping);
 		if (!error)
 			error = error2;
 	}
 
-	if (test_and_clear_bit(HFSPLUS_I_ATTR_DIRTY, &hip->flags)) {
-		if (sbi->attr_tree) {
+	if (sbi->attr_tree) {
+		if (test_and_clear_bit(HFSPLUS_I_ATTR_DIRTY,
+				&HFSPLUS_I(HFSPLUS_ATTR_TREE_I(sb))->flags)) {
+			clear_bit(HFSPLUS_I_ATTR_DIRTY, &hip->flags);
 			error2 =
 				filemap_write_and_wait(
 					    sbi->attr_tree->inode->i_mapping);
 			if (!error)
 				error = error2;
-		} else {
-			pr_err("sync non-existent attributes tree\n");
 		}
+	} else {
+		if (test_and_clear_bit(HFSPLUS_I_ATTR_DIRTY, &hip->flags))
+			pr_err("sync non-existent attributes tree\n");
 	}
 
-	if (test_and_clear_bit(HFSPLUS_I_ALLOC_DIRTY, &hip->flags)) {
+	if (test_and_clear_bit(HFSPLUS_I_ALLOC_DIRTY,
+				&HFSPLUS_I(sbi->alloc_file)->flags)) {
+		clear_bit(HFSPLUS_I_ALLOC_DIRTY, &hip->flags);
 		error2 = filemap_write_and_wait(sbi->alloc_file->i_mapping);
 		if (!error)
 			error = error2;
@@ -709,6 +720,8 @@ int hfsplus_cat_write_inode(struct inode *inode)
 					 sizeof(struct hfsplus_cat_file));
 	}
 
+	set_bit(HFSPLUS_I_CAT_DIRTY,
+		&HFSPLUS_I(HFSPLUS_CAT_TREE_I(inode->i_sb))->flags);
 	set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
 out:
 	hfs_find_exit(&fd);
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 592d8fbb748c..c963809e0106 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -625,6 +625,8 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 			}
 
 			mutex_unlock(&sbi->vh_mutex);
+			hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb),
+						 HFSPLUS_I_CAT_DIRTY);
 			hfsplus_mark_inode_dirty(sbi->hidden_dir,
 						 HFSPLUS_I_CAT_DIRTY);
 		}
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9904944cbd54..31b6cb9db770 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -236,6 +236,7 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		put_page(page);
 	}
 
+	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY);
 	hfsplus_mark_inode_dirty(attr_file, HFSPLUS_I_ATTR_DIRTY);
 
 	sbi->attr_tree = hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
@@ -314,8 +315,11 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 				hfs_bnode_write(cat_fd.bnode, &entry,
 					cat_fd.entryoffset,
 					sizeof(struct hfsplus_cat_folder));
-				hfsplus_mark_inode_dirty(inode,
+				hfsplus_mark_inode_dirty(
+						HFSPLUS_CAT_TREE_I(inode->i_sb),
 						HFSPLUS_I_CAT_DIRTY);
+				hfsplus_mark_inode_dirty(inode,
+							 HFSPLUS_I_CAT_DIRTY);
 			} else {
 				err = -ERANGE;
 				goto end_setxattr;
@@ -327,8 +331,11 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 				hfs_bnode_write(cat_fd.bnode, &entry,
 					cat_fd.entryoffset,
 					sizeof(struct hfsplus_cat_file));
-				hfsplus_mark_inode_dirty(inode,
+				hfsplus_mark_inode_dirty(
+						HFSPLUS_CAT_TREE_I(inode->i_sb),
 						HFSPLUS_I_CAT_DIRTY);
+				hfsplus_mark_inode_dirty(inode,
+							 HFSPLUS_I_CAT_DIRTY);
 			} else {
 				err = -ERANGE;
 				goto end_setxattr;
@@ -381,6 +388,8 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 		hfs_bnode_write_u16(cat_fd.bnode, cat_fd.entryoffset +
 				offsetof(struct hfsplus_cat_folder, flags),
 				cat_entry_flags);
+		hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(inode->i_sb),
+					 HFSPLUS_I_CAT_DIRTY);
 		hfsplus_mark_inode_dirty(inode, HFSPLUS_I_CAT_DIRTY);
 	} else if (cat_entry_type == HFSPLUS_FILE) {
 		cat_entry_flags = hfs_bnode_read_u16(cat_fd.bnode,
@@ -392,6 +401,8 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 		hfs_bnode_write_u16(cat_fd.bnode, cat_fd.entryoffset +
 				    offsetof(struct hfsplus_cat_file, flags),
 				    cat_entry_flags);
+		hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(inode->i_sb),
+					 HFSPLUS_I_CAT_DIRTY);
 		hfsplus_mark_inode_dirty(inode, HFSPLUS_I_CAT_DIRTY);
 	} else {
 		pr_err("invalid catalog entry type\n");
@@ -862,6 +873,8 @@ static int hfsplus_removexattr(struct inode *inode, const char *name)
 		hfs_bnode_write_u16(cat_fd.bnode, cat_fd.entryoffset +
 				offsetof(struct hfsplus_cat_folder, flags),
 				flags);
+		hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(inode->i_sb),
+					 HFSPLUS_I_CAT_DIRTY);
 		hfsplus_mark_inode_dirty(inode, HFSPLUS_I_CAT_DIRTY);
 	} else if (cat_entry_type == HFSPLUS_FILE) {
 		flags = hfs_bnode_read_u16(cat_fd.bnode, cat_fd.entryoffset +
@@ -873,6 +886,8 @@ static int hfsplus_removexattr(struct inode *inode, const char *name)
 		hfs_bnode_write_u16(cat_fd.bnode, cat_fd.entryoffset +
 				offsetof(struct hfsplus_cat_file, flags),
 				flags);
+		hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(inode->i_sb),
+					 HFSPLUS_I_CAT_DIRTY);
 		hfsplus_mark_inode_dirty(inode, HFSPLUS_I_CAT_DIRTY);
 	} else {
 		pr_err("invalid catalog entry type\n");
-- 
2.43.0


