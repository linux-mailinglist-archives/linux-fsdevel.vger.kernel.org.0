Return-Path: <linux-fsdevel+bounces-14020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09730876A61
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 19:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCB41C213EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A1459B68;
	Fri,  8 Mar 2024 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="SrmB9uOQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D01A58120;
	Fri,  8 Mar 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921017; cv=none; b=dgNc3W8kbsdXgbjPSfEYMt2b7J44tNs3KXbu1NcR2DOs78z+pi5gudIsFozrMvDqVrTeEEpjbDqNqqJ972Ln0j4xUG3N82DIZD+9aDI434iIh6AVQ6F9+dKK5ju4hY1eBmT57f25F2k5W1JyljoGgMdFo+ZlZzt9J093kdRT20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921017; c=relaxed/simple;
	bh=kKASgejRq9MCDxzTnAFMqn5RVm5WA1Jh0hcRwVy+8EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eidL/WSfaxc/zDKv6AJ+K1RoH1FsFdpF4GkX3w2ii7cUs5G7S4PbD02ZDhdK3ekomof+Tfp3Co0fBI8o+ccHW6W4E3DLvzGKOLLjSTZI5Wv1giBH2EB7xjrAzKHh/ZzjQ9BbKCQ0AL9RkAgQDGobVVZXmxxdMPn3FgfZm4PZzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=SrmB9uOQ; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 8E1EA82579;
	Fri,  8 Mar 2024 13:03:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1709921008; bh=kKASgejRq9MCDxzTnAFMqn5RVm5WA1Jh0hcRwVy+8EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SrmB9uOQJ8xsF2KSNMWg0FBw0xk3y2HmgiC2DfHT+C1xZfUMDOWz1lEKnJR3CV/V7
	 M70ZgEgPWkDTkL0bHeitKPlr0hzEpnmEji7s4sXAAlj2Yn4Uk65vEXf3kmlpGxyDxz
	 lV+I56Qnt2gmSjTFj733GeloqvrFxXbannKdeYnh0oYMMNAielBcOSBrCeDl6SEg9e
	 naH6w73PN97iLHXNF1oXgsSainncl/dFelrTkEezVuDySzM6p5bZVWUHX2zTE8x3rv
	 o7fED5anQw8CL4ha4Q+gznHAYDogH/10ZZOHc2sXoAWwjKB1f59hLg916nFcHPTZtL
	 f7qrPtzW+kAtw==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: corbet@lwn.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	clm@meta.com,
	dsterba@suse.com,
	josef@toxicpanda.com
Cc: jbacik@toxicpanda.com,
	kernel-team@meta.com,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 2/3] fs: update fiemap_fill_next_extent() signature
Date: Fri,  8 Mar 2024 13:03:19 -0500
Message-ID: <4253d6784dfde3ce0d1318229809b74375c975f4.1709918025.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1709918025.git.sweettea-kernel@dorminy.me>
References: <cover.1709918025.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the signature of fiemap_fill_next_extent() to allow passing a
physical length, and update all callers to pass the same logical and
physical lengths.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 Documentation/filesystems/fiemap.rst | 3 ++-
 fs/bcachefs/fs.c                     | 6 +++++-
 fs/btrfs/extent_io.c                 | 2 +-
 fs/ext4/extents.c                    | 1 +
 fs/f2fs/data.c                       | 8 +++++---
 fs/f2fs/inline.c                     | 3 ++-
 fs/ioctl.c                           | 9 +++++----
 fs/iomap/fiemap.c                    | 2 +-
 fs/nilfs2/inode.c                    | 8 +++++---
 fs/ntfs3/frecord.c                   | 6 ++++--
 fs/ocfs2/extent_map.c                | 4 ++--
 fs/smb/client/smb2ops.c              | 1 +
 include/linux/fiemap.h               | 2 +-
 13 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/fiemap.rst b/Documentation/filesystems/fiemap.rst
index e3e84573b087..fd0911e65b43 100644
--- a/Documentation/filesystems/fiemap.rst
+++ b/Documentation/filesystems/fiemap.rst
@@ -234,7 +234,8 @@ For each extent in the request range, the file system should call
 the helper function, fiemap_fill_next_extent()::
 
   int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
-			      u64 phys, u64 len, u32 flags, u32 dev);
+			      u64 phys, u64 log_len, u64 phys_len, u32 flags,
+                              u32 dev);
 
 fiemap_fill_next_extent() will use the passed values to populate the
 next free extent in the fm_extents array. 'General' extent flags will
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 3f073845bbd7..0a030f048fc6 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -927,7 +927,9 @@ static int bch2_fill_extent(struct bch_fs *c,
 			ret = fiemap_fill_next_extent(info,
 						bkey_start_offset(k.k) << 9,
 						offset << 9,
-						k.k->size << 9, flags|flags2);
+						k.k->size << 9,
+						k.k->size << 9,
+						flags|flags2);
 			if (ret)
 				return ret;
 		}
@@ -937,12 +939,14 @@ static int bch2_fill_extent(struct bch_fs *c,
 		return fiemap_fill_next_extent(info,
 					       bkey_start_offset(k.k) << 9,
 					       0, k.k->size << 9,
+					       k.k->size << 9,
 					       flags|
 					       FIEMAP_EXTENT_DATA_INLINE);
 	} else if (k.k->type == KEY_TYPE_reservation) {
 		return fiemap_fill_next_extent(info,
 					       bkey_start_offset(k.k) << 9,
 					       0, k.k->size << 9,
+					       k.k->size << 9,
 					       flags|
 					       FIEMAP_EXTENT_DELALLOC|
 					       FIEMAP_EXTENT_UNWRITTEN);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7441245b1ceb..cdf662b9fb5b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2743,7 +2743,7 @@ static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
 		return 0;
 
 	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
-				      cache->len, cache->flags);
+				      cache->len, cache->len, cache->flags);
 	cache->cached = false;
 	if (ret > 0)
 		ret = 0;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e57054bdc5fd..2b886e7189a5 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2215,6 +2215,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
 				(__u64)es.es_lblk << blksize_bits,
 				(__u64)es.es_pblk << blksize_bits,
 				(__u64)es.es_len << blksize_bits,
+				(__u64)es.es_len << blksize_bits,
 				flags);
 		if (next == 0)
 			break;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bd8674bf1d84..d68094753b84 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1843,7 +1843,8 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 		if (!xnid)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent(fieinfo, 0, phys, len, flags);
+		err = fiemap_fill_next_extent(
+				fieinfo, 0, phys, len, len, flags);
 		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
 		if (err)
 			return err;
@@ -1869,7 +1870,8 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 	}
 
 	if (phys) {
-		err = fiemap_fill_next_extent(fieinfo, 0, phys, len, flags);
+		err = fiemap_fill_next_extent(
+				fieinfo, 0, phys, len, len, flags);
 		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
 	}
 
@@ -1988,7 +1990,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			flags |= FIEMAP_EXTENT_DATA_ENCRYPTED;
 
 		ret = fiemap_fill_next_extent(fieinfo, logical,
-				phys, size, flags);
+				phys, size, size, flags);
 		trace_f2fs_fiemap(inode, logical, phys, size, flags, ret);
 		if (ret)
 			goto out;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index ac00423f117b..825b51978c56 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -806,7 +806,8 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
 	byteaddr += (char *)inline_data_addr(inode, ipage) -
 					(char *)F2FS_INODE(ipage);
-	err = fiemap_fill_next_extent(fieinfo, start, byteaddr, ilen, flags);
+	err = fiemap_fill_next_extent(
+			fieinfo, start, byteaddr, ilen, ilen, flags);
 	trace_f2fs_fiemap(inode, start, byteaddr, ilen, flags, err);
 out:
 	f2fs_put_page(ipage, 1);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index f8e5d6dfc62d..a5d0e7882f19 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -99,7 +99,8 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
  * @fieinfo:	Fiemap context passed into ->fiemap
  * @logical:	Extent logical start offset, in bytes
  * @phys:	Extent physical start offset, in bytes
- * @len:	Extent length, in bytes
+ * @log_len:	Extent logical length, in bytes
+ * @phys_len:	Extent physical length, in bytes
  * @flags:	FIEMAP_EXTENT flags that describe this extent
  *
  * Called from file system ->fiemap callback. Will populate extent
@@ -110,7 +111,7 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
  * extent that will fit in user array.
  */
 int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
-			    u64 phys, u64 len, u32 flags)
+			    u64 phys, u64 log_len, u64 phys_len, u32 flags)
 {
 	struct fiemap_extent extent;
 	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
@@ -138,8 +139,8 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 	memset(&extent, 0, sizeof(extent));
 	extent.fe_logical = logical;
 	extent.fe_physical = phys;
-	extent.fe_length = len;
-	extent.fe_physical_length = len;
+	extent.fe_length = log_len;
+	extent.fe_physical_length = phys_len;
 	extent.fe_flags = flags;
 
 	dest += fieinfo->fi_extents_mapped;
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 610ca6f1ec9b..30c5f14f908f 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -36,7 +36,7 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
 
 	return fiemap_fill_next_extent(fi, iomap->offset,
 			iomap->addr != IOMAP_NULL_ADDR ? iomap->addr : 0,
-			iomap->length, flags);
+			iomap->length, iomap->length, flags);
 }
 
 static loff_t iomap_fiemap_iter(const struct iomap_iter *iter,
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index a475095a5e80..e53a1b9ab393 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1190,7 +1190,8 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			if (size) {
 				/* End of the current extent */
 				ret = fiemap_fill_next_extent(
-					fieinfo, logical, phys, size, flags);
+					fieinfo, logical, phys, size, size,
+					flags);
 				if (ret)
 					break;
 			}
@@ -1240,7 +1241,8 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 					flags |= FIEMAP_EXTENT_LAST;
 
 				ret = fiemap_fill_next_extent(
-					fieinfo, logical, phys, size, flags);
+					fieinfo, logical, phys, size, size,
+					flags);
 				if (ret)
 					break;
 				size = 0;
@@ -1256,7 +1258,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 					/* Terminate the current extent */
 					ret = fiemap_fill_next_extent(
 						fieinfo, logical, phys, size,
-						flags);
+						size, flags);
 					if (ret || blkoff > end_blkoff)
 						break;
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 7f27382e0ce2..ba443e0b8d2b 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1948,6 +1948,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		err = fiemap_fill_next_extent(
 			fieinfo, 0, 0,
 			attr ? le32_to_cpu(attr->res.data_size) : 0,
+			attr ? le32_to_cpu(attr->res.data_size) : 0,
 			FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_LAST |
 				FIEMAP_EXTENT_MERGED);
 		goto out;
@@ -2042,7 +2043,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 				flags |= FIEMAP_EXTENT_LAST;
 
 			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
-						      flags);
+						      dlen, flags);
 			if (err < 0)
 				break;
 			if (err == 1) {
@@ -2062,7 +2063,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		if (vbo + bytes >= end)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
+		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, bytes,
+					      flags);
 		if (err < 0)
 			break;
 		if (err == 1) {
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 70a768b623cf..553b1695671d 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -723,7 +723,7 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 					 id2.i_data.id_data);
 
 		ret = fiemap_fill_next_extent(fieinfo, 0, phys, id_count,
-					      flags);
+					      id_count, flags);
 		if (ret < 0)
 			return ret;
 	}
@@ -794,7 +794,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		virt_bytes = (u64)le32_to_cpu(rec.e_cpos) << osb->s_clustersize_bits;
 
 		ret = fiemap_fill_next_extent(fieinfo, virt_bytes, phys_bytes,
-					      len_bytes, fe_flags);
+					      len_bytes, len_bytes, fe_flags);
 		if (ret)
 			break;
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 6ee22d0dbc00..79c839964c41 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3778,6 +3778,7 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
 				le64_to_cpu(out_data[i].file_offset),
 				le64_to_cpu(out_data[i].file_offset),
 				le64_to_cpu(out_data[i].length),
+				le64_to_cpu(out_data[i].length),
 				flags);
 		if (rc < 0)
 			goto out;
diff --git a/include/linux/fiemap.h b/include/linux/fiemap.h
index c50882f19235..17a6c32cdf3f 100644
--- a/include/linux/fiemap.h
+++ b/include/linux/fiemap.h
@@ -16,6 +16,6 @@ struct fiemap_extent_info {
 int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 *len, u32 supported_flags);
 int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
-			    u64 phys, u64 len, u32 flags);
+			    u64 phys, u64 log_len, u64 phys_len, u32 flags);
 
 #endif /* _LINUX_FIEMAP_H 1 */
-- 
2.44.0


