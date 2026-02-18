Return-Path: <linux-fsdevel+bounces-77542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOrsFf50lWnDRgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:14:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7DC153EBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE043022948
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 08:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2F2318135;
	Wed, 18 Feb 2026 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="gpZpfcJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C8487BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402425; cv=none; b=XRViJlCvTy+Ou7oMKLWaO81gmocT/51W/gBH4R/hGbLwjLvTYmV8f40cyPdTESpSEaVAzLl089G4mI2k6o3Dyj3pUNFnx3feUGluc3tVu0aAgKdElZVBAoof9bbRsYVojslAEaC+bBeMEw78q9AG4+dXfLJab4iJyx9EC4eNzLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402425; c=relaxed/simple;
	bh=+FXvO46LDkW7rgjU6SdZbIG56S9ni4ZtApHuczawTo0=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=bMcSMR5LBFKzgneiucAYPS/duXkXWG7NC7jFueds5+FOvCtx7IxmRU7gCbFAsAQFi7VSBug7sMcppfvymeQW1e10MvQAFCKWofp9jx7bCQGf6lILDKMKiX3CwqFvpiKhTVccR0Pnpg2kUeVLs6hSOvq7zeIZlv1mBMUbLuHwtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=gpZpfcJt; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 6ECE11D49A;
	Wed, 18 Feb 2026 08:13:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 6ECE11D49A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1771402422; bh=+FXvO46LDkW7rgjU6SdZbIG56S9ni4ZtApHuczawTo0=;
	h=Date:From:Subject:References:To:Cc:In-Reply-To:From;
	b=gpZpfcJtm5flAJrkwpG54Olojh0+z4L+nkN5CqNzRtcUvIJmZX8CNWVdzYF5WS+Bh
	 QPE9h/5qOlraXir9U6pOaVdnHriUxjI4HN9r6f7nS6eIRVlsoUjGwSi44KRDog/9kv
	 A6MvNulryGDeGbKnQ5fG9Ma1CDyoO5cbNKo43/yI=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id zloaCbV0lWmy3QEA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Wed, 18 Feb 2026 08:13:41 +0000
Message-ID: <d0e5da23-90ed-4529-b919-11ae551611f3@dev.snart.me>
Date: Wed, 18 Feb 2026 17:13:36 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Timber <dxdt@dev.snart.me>
Subject: [PATCH] exfat: add fallocate support
References: <>
Content-Language: en-US, ko
To: linux-fsdevel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[dev.snart.me,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dev.snart.me:s=00];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dxdt@dev.snart.me,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77542-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[dev.snart.me:+]
X-Rspamd-Queue-Id: EF7DC153EBA
X-Rspamd-Action: no action

Bug-for-bug compatible support for fallocate originally introduced in
vfat. For details on background and caveats, refer to
commit b13bb33eacb7.

Currently, the Linux (ex)FAT drivers do not employ any cluster
allocation strategy to keep fragmentation at bay. As a result, when
multiple processes are competing for new clusters to expand files in
exfat filesystem on Linux simultaneously, the files end up heavily
fragmented. HDDs are most impacted, but this could also have some
negative impact on various forms of flash memory depending on the
type of underlying technology.

For instance, modern digital cameras produce multiple media files for a
single video stream. If the application does not take the fragmentation
issue into account or the system is under memory pressure, the kernel
end up allocating clusters in said files in a interleaved manner.

Demo script:

	for (( i = 0; i < 4; i += 1 ));
	do
	    dd if=/dev/urandom iflag=fullblock bs=1M count=64 of=frag-$i &
	done
	for (( i = 0; i < 4; i += 1 ));
	do
	    wait
	done

	filefrag frag-*

Result - Linux kernel native exfat, async mount:
	780 extents found
	740 extents found
	809 extents found
	712 extents found

Result - Linux kernel native exfat, sync mount:
	1852 extents found
	1836 extents found
	1846 extents found
	1881 extents found

Result - Windows XP:
	3 extents found
	3 extents found
	3 extents found
	2 extents found

Windows kernel, on the other hand, regardless of the underlying storage
interface or the medium, seems to space out clusters for each file.
Similar strategy has to be employed by Linux fat filesystems for
efficient utilisation of storage backend.

In the meantime, to combat this, userspace applications like rsync may
use fallocate.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 Documentation/filesystems/vfat.rst |  23 ++++++
 fs/exfat/file.c                    | 116 +++++++++++++++++++++++++++++
 fs/exfat/inode.c                   |  16 +++-
 3 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/vfat.rst b/Documentation/filesystems/vfat.rst
index b289c4449cd0..7a39cbb27f53 100644
--- a/Documentation/filesystems/vfat.rst
+++ b/Documentation/filesystems/vfat.rst
@@ -232,6 +232,29 @@ the inode from the memory. As a result, for any dependency on
 the fallocated region, user should make sure to recheck fallocate
 after reopening the file.
 
+In the event of unsafe removal of the device(e.g. power loss),
+unused clusters fallocated with FALLOC_FL_KEEP_SIZE can become
+orphaned. In order to reclaim orphaned clusters, option 1: try
+truncating the file to the exact size(truncate -s ...). Option 2:
+delete the file if possible, then unmount the filesystem and run
+fsck or, in case of MS Windows, chkdsk. The contents of the
+reclaimed clusters will be placed in the files in the directory
+named *FOUND.XXX*. Delete the files to free up the space taken up
+by orphan clusters(exFAT support testetd as far back as the Windows
+XP KB955704 patch).
+
+For exFAT, use of FALLOC_FL_KEEP_SIZE shouldn't be necessary as
+long as the write is sequential thanks to ValidDataLength in the
+file entry format. However, be aware that the write operation is
+only deferred. Doing something like this
+
+        fallocate -l 1G file
+        echo -n "data" | dd of=file seek=2097151 conv=nocreat,notrunc
+
+is basically asking the kernel to zero out all the blocks before
+the offset. Currently, this IO operation cannot be canceled. This
+caveat also applies when up-truncating files in vfat.
+
 TODO
 ====
 Need to get rid of the raw scanning stuff.  Instead, always use
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 90cd540afeaa..1865f4f66028 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -13,6 +13,7 @@
 #include <linux/msdos_fs.h>
 #include <linux/writeback.h>
 #include <linux/filelock.h>
+#include <linux/falloc.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -90,6 +91,120 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	return -EIO;
 }
 
+static long __exfat_fallocate(struct inode *inode, loff_t ondisksize,
+			  loff_t newsize)
+{
+	unsigned int num_clusters; /* Number of clusters already allocated */
+	unsigned int nr_clusters; /* Number of clusters to be allocated */
+	unsigned int last_clu;
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_chain clu;
+	int ret;
+
+	/* First compute the number of clusters to be allocated */
+	num_clusters = EXFAT_B_TO_CLU(ondisksize, sbi);
+	nr_clusters = EXFAT_B_TO_CLU_ROUND_UP(newsize, sbi);
+
+	/* Set up the cluster chain */
+	if (num_clusters) {
+		exfat_chain_set(&clu, ei->start_clu, num_clusters, ei->flags);
+		ret = exfat_find_last_cluster(sb, &clu, &last_clu);
+		if (ret)
+			return ret;
+
+		clu.dir = last_clu + 1;
+	} else {
+		last_clu = EXFAT_EOF_CLUSTER;
+		clu.dir = EXFAT_EOF_CLUSTER;
+	}
+
+	clu.size = 0;
+	clu.flags = ei->flags;
+
+	/* Allocate clusters */
+	ret = exfat_alloc_cluster(inode, nr_clusters - num_clusters, &clu,
+			inode_needs_sync(inode));
+	if (ret)
+		return ret;
+
+	/* Append new clusters to chain */
+	if (num_clusters) {
+		if (clu.flags != ei->flags)
+			if (exfat_chain_cont_cluster(sb, ei->start_clu, num_clusters))
+				goto free_clu;
+
+		if (clu.flags == ALLOC_FAT_CHAIN)
+			if (exfat_ent_set(sb, last_clu, clu.dir))
+				goto free_clu;
+	} else
+		ei->start_clu = clu.dir;
+
+	ei->flags = clu.flags;
+
+	/* Wrap up: invalidate everything */
+	/* Not zeroing out the clusters, not updating mtime */
+	inode->i_blocks = round_up(newsize, sbi->cluster_size) >> 9;
+	mark_inode_dirty(inode);
+
+	if (IS_SYNC(inode))
+		return write_inode_now(inode, 1);
+
+	return 0;
+free_clu:
+	exfat_free_cluster(inode, &clu);
+	return -EIO;
+}
+
+/*
+ * Preallocate space for a file. This implements fat's fallocate file
+ * operation, which gets called from sys_fallocate system call. User
+ * space requests len bytes at offset. If FALLOC_FL_KEEP_SIZE is set
+ * we just allocate clusters without zeroing them out. Otherwise we
+ * allocate and zero out clusters via an expanding truncate.
+ */
+static long exfat_fallocate(struct file *file, int mode,
+			  loff_t offset, loff_t len)
+{
+	struct inode *inode = file->f_mapping->host;
+	loff_t ondisksize; /* block aligned on-disk size in bytes*/
+	loff_t newsize = offset + len;
+	int err = 0;
+
+	/* No support for hole punch or other fallocate flags. */
+	if (mode & ~FALLOC_FL_KEEP_SIZE)
+		return -EOPNOTSUPP;
+
+	/* No support for dir */
+	if (!S_ISREG(inode->i_mode))
+		return -EOPNOTSUPP;
+
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
+	inode_lock(inode);
+
+	if (mode & FALLOC_FL_KEEP_SIZE) {
+		ondisksize = exfat_ondisk_size(inode);
+		if (newsize <= ondisksize)
+			goto error;
+
+		err = __exfat_fallocate(inode, ondisksize, newsize);
+	} else {
+		if (newsize <= i_size_read(inode))
+			goto error;
+
+		/* This is just an expanding truncate */
+		err = exfat_cont_expand(inode, newsize);
+	}
+
+error:
+	inode_unlock(inode);
+
+	return err;
+}
+
 static bool exfat_allow_set_time(struct mnt_idmap *idmap,
 				 struct exfat_sb_info *sbi, struct inode *inode)
 {
@@ -771,6 +886,7 @@ const struct file_operations exfat_file_operations = {
 	.fsync		= exfat_file_fsync,
 	.splice_read	= exfat_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.fallocate	= exfat_fallocate,
 	.setlease	= generic_setlease,
 };
 
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 2fb2d2d5d503..0ae3ace90bd5 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -686,15 +686,27 @@ struct inode *exfat_build_inode(struct super_block *sb,
 
 void exfat_evict_inode(struct inode *inode)
 {
+	int err = 0;
 	truncate_inode_pages(&inode->i_data, 0);
 
-	if (!inode->i_nlink) {
+	if (!inode->i_nlink)
 		i_size_write(inode, 0);
+	if (!inode->i_nlink || (exfat_ondisk_size(inode) >
+			round_up(i_size_read(inode),
+				EXFAT_SB(inode->i_sb)->cluster_size))) {
+		/* Release unused blocks only when required.
+		 * The inode commit is handled in __exfat_truncate().
+		 */
 		mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
-		__exfat_truncate(inode);
+		err = __exfat_truncate(inode);
 		mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);
 	}
 
+	if (err) {
+		exfat_warn(inode->i_sb,
+			"IO error occurred whilst evicting an inode. Please run fsck");
+	}
+
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
 	exfat_cache_inval_inode(inode);
-- 
2.53.0


