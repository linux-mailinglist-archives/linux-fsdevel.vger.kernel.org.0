Return-Path: <linux-fsdevel+bounces-70111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D47C90DAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 05:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCE73ABBE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 04:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C325DB12;
	Fri, 28 Nov 2025 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AWWl75A8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357162F85B;
	Fri, 28 Nov 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764305746; cv=none; b=Q7meCYqHoUPUnKB0eUxZ914eMIMssl3J+cml5Q1CBtqtAsgGGvvbshTMtQ0sB4A17PAWr1N3dkYCjdLJuDjD1suSCOzaC8pqysdMljjjckJfi/G3m2jnsdo6feGed9AJ2MqsLlvj5KwbAhMM3DBwu+euvb7QRo22aW6HCRmJX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764305746; c=relaxed/simple;
	bh=MLEIbbJrhR3hPs9cAzd2vPmUwIKsg7jwKnfJgxM4Ry4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3dezTRMqAXS0xv5JKzR1onBfl/d9KMatNnEtxd66xyeXD4Yo1E0eGqt5GOp8F3KhqGn/iqxnFndNhro9wq4Ob44QR+mfFyUX4xXO4priLw8XBDGyE5sOq+urUQ5tcKIsD3hWwMZl0PtjT35j3hUSwG9gNaH+fLfwulhiIPAwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AWWl75A8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WZ4/UTOU9vCmfDkJwHNbwL8YqYu7205FP8K9nxSsJYM=; b=AWWl75A8gOmlBd6I0buM0Ro1H1
	tHVs7/NgX1+jBtKSqy4sDuAxVKuuHrB17P/93qmFiv7vrkYTY4xXKLeaw7vOvKEDb2yHgmGhAc/na
	a+0j/Q7oJxub6Lu++s22zfE2y0TsTo97SVjuMwJYmzOXdf+88So6kR/EB8Q5X/QbKPvC/O6ugl7oe
	b5q9QS97gmNTwnQVb8ALVjIBzH3e4vqSZ0cyNhyj0mt9X27EEHBGIwHI62JNNCg3Lm7jCsvF83MYZ
	/FX6Levj00TdBVok+ylqJeBQBiBV1v58+JGRJlenNdSCy+jjA1OZtXNFEk8TKwDehoizT0sslz7tS
	O3Uu6y3w==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOqWD-0000000Ha1D-2gib;
	Fri, 28 Nov 2025 04:55:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	linux-nilfs@vger.kernel.org
Subject: [PATCH] nilfs2: convert nilfs_super_block to kernel-doc
Date: Thu, 27 Nov 2025 20:55:41 -0800
Message-ID: <20251128045541.672456-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminate 40+ kernel-doc warnings in nilfs2_ondisk.h by converting
all of the struct member comments to kernel-doc comments.

Fix one misnamed struct member in nilfs_direct_node.

Object files before and after are the same size and content.

Examples of warnings:
Warning: include/uapi/linux/nilfs2_ondisk.h:202 struct member 's_rev_level'
 not described in 'nilfs_super_block'
Warning: include/uapi/linux/nilfs2_ondisk.h:202 struct member
 's_minor_rev_level' not described in 'nilfs_super_block'
Warning: include/uapi/linux/nilfs2_ondisk.h:202 struct member 's_magic'
 not described in 'nilfs_super_block'
Warning: include/uapi/linux/nilfs2_ondisk.h:202 struct member 's_bytes'
 not described in 'nilfs_super_block'
Warning: include/uapi/linux/nilfs2_ondisk.h:202 struct member 's_flags'
 not described in 'nilfs_super_block'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-nilfs@vger.kernel.org
---
 include/uapi/linux/nilfs2_ondisk.h |  163 ++++++++++++++++-----------
 1 file changed, 97 insertions(+), 66 deletions(-)

--- linux-next-20251127.orig/include/uapi/linux/nilfs2_ondisk.h
+++ linux-next-20251127/include/uapi/linux/nilfs2_ondisk.h
@@ -133,73 +133,104 @@ struct nilfs_super_root {
 
 /**
  * struct nilfs_super_block - structure of super block on disk
+ * @s_rev_level:		Revision level
+ * @s_minor_rev_level:		minor revision level
+ * @s_magic:			Magic signature
+ * @s_bytes:			Bytes count of CRC calculation for
+ *				  this structure.  s_reserved is excluded.
+ * @s_flags:			flags
+ * @s_crc_seed:			Seed value of CRC calculation
+ * @s_sum:			Check sum of super block
+ * @s_log_block_size:		Block size represented as follows:
+ *				  blocksize = 1 << (s_log_block_size + 10)
+ * @s_nsegments:		Number of segments in filesystem
+ * @s_dev_size:			block device size in bytes
+ * @s_first_data_block:		1st seg disk block number
+ * @s_blocks_per_segment:	number of blocks per full segment
+ * @s_r_segments_percentage:	Reserved segments percentage
+ * @s_last_cno:			Last checkpoint number
+ * @s_last_pseg:		disk block addr pseg written last
+ * @s_last_seq:			seq. number of seg written last
+ * @s_free_blocks_count:	Free blocks count
+ * @s_ctime:			Creation time (execution time of newfs)
+ * @s_mtime:			Mount time
+ * @s_wtime:			Write time
+ * @s_mnt_count:		Mount count
+ * @s_max_mnt_count:		Maximal mount count
+ * @s_state:			File system state
+ * @s_errors:			Behaviour when detecting errors
+ * @s_lastcheck:		time of last check
+ * @s_checkinterval:		max. time between checks
+ * @s_creator_os:		OS
+ * @s_def_resuid:		Default uid for reserved blocks
+ * @s_def_resgid:		Default gid for reserved blocks
+ * @s_first_ino:		First non-reserved inode
+ * @s_inode_size:		Size of an inode
+ * @s_dat_entry_size:		Size of a dat entry
+ * @s_checkpoint_size:		Size of a checkpoint
+ * @s_segment_usage_size:	Size of a segment usage
+ * @s_uuid:			128-bit uuid for volume
+ * @s_volume_name:		volume name
+ * @s_c_interval:		Commit interval of segment
+ * @s_c_block_max:		Threshold of data amount for the
+ *				  segment construction
+ * @s_feature_compat:		Compatible feature set
+ * @s_feature_compat_ro:	Read-only compatible feature set
+ * @s_feature_incompat:		Incompatible feature set
+ * @s_reserved:			padding to the end of the block
  */
 struct nilfs_super_block {
-/*00*/	__le32	s_rev_level;		/* Revision level */
-	__le16	s_minor_rev_level;	/* minor revision level */
-	__le16	s_magic;		/* Magic signature */
-
-	__le16  s_bytes;		/*
-					 * Bytes count of CRC calculation
-					 * for this structure. s_reserved
-					 * is excluded.
-					 */
-	__le16  s_flags;		/* flags */
-	__le32  s_crc_seed;		/* Seed value of CRC calculation */
-/*10*/	__le32	s_sum;			/* Check sum of super block */
-
-	__le32	s_log_block_size;	/*
-					 * Block size represented as follows
-					 * blocksize =
-					 *     1 << (s_log_block_size + 10)
-					 */
-	__le64  s_nsegments;		/* Number of segments in filesystem */
-/*20*/	__le64  s_dev_size;		/* block device size in bytes */
-	__le64	s_first_data_block;	/* 1st seg disk block number */
-/*30*/	__le32  s_blocks_per_segment;   /* number of blocks per full segment */
-	__le32	s_r_segments_percentage; /* Reserved segments percentage */
-
-	__le64  s_last_cno;		/* Last checkpoint number */
-/*40*/	__le64  s_last_pseg;		/* disk block addr pseg written last */
-	__le64  s_last_seq;             /* seq. number of seg written last */
-/*50*/	__le64	s_free_blocks_count;	/* Free blocks count */
-
-	__le64	s_ctime;		/*
-					 * Creation time (execution time of
-					 * newfs)
-					 */
-/*60*/	__le64	s_mtime;		/* Mount time */
-	__le64	s_wtime;		/* Write time */
-/*70*/	__le16	s_mnt_count;		/* Mount count */
-	__le16	s_max_mnt_count;	/* Maximal mount count */
-	__le16	s_state;		/* File system state */
-	__le16	s_errors;		/* Behaviour when detecting errors */
-	__le64	s_lastcheck;		/* time of last check */
-
-/*80*/	__le32	s_checkinterval;	/* max. time between checks */
-	__le32	s_creator_os;		/* OS */
-	__le16	s_def_resuid;		/* Default uid for reserved blocks */
-	__le16	s_def_resgid;		/* Default gid for reserved blocks */
-	__le32	s_first_ino;		/* First non-reserved inode */
-
-/*90*/	__le16  s_inode_size;		/* Size of an inode */
-	__le16  s_dat_entry_size;       /* Size of a dat entry */
-	__le16  s_checkpoint_size;      /* Size of a checkpoint */
-	__le16	s_segment_usage_size;	/* Size of a segment usage */
-
-/*98*/	__u8	s_uuid[16];		/* 128-bit uuid for volume */
-/*A8*/	char	s_volume_name[80]	/* volume name */
-			__kernel_nonstring;
-
-/*F8*/	__le32  s_c_interval;           /* Commit interval of segment */
-	__le32  s_c_block_max;          /*
-					 * Threshold of data amount for
-					 * the segment construction
-					 */
-/*100*/	__le64  s_feature_compat;	/* Compatible feature set */
-	__le64  s_feature_compat_ro;	/* Read-only compatible feature set */
-	__le64  s_feature_incompat;	/* Incompatible feature set */
-	__u32	s_reserved[186];	/* padding to the end of the block */
+/*00*/	__le32	s_rev_level;
+	__le16	s_minor_rev_level;
+	__le16	s_magic;
+
+	__le16  s_bytes;
+	__le16  s_flags;
+	__le32  s_crc_seed;
+/*10*/	__le32	s_sum;
+
+	__le32	s_log_block_size;
+	__le64  s_nsegments;
+/*20*/	__le64  s_dev_size;
+	__le64	s_first_data_block;
+/*30*/	__le32  s_blocks_per_segment;
+	__le32	s_r_segments_percentage;
+
+	__le64  s_last_cno;
+/*40*/	__le64  s_last_pseg;
+	__le64  s_last_seq;
+/*50*/	__le64	s_free_blocks_count;
+
+	__le64	s_ctime;
+/*60*/	__le64	s_mtime;
+	__le64	s_wtime;
+/*70*/	__le16	s_mnt_count;
+	__le16	s_max_mnt_count;
+	__le16	s_state;
+	__le16	s_errors;
+	__le64	s_lastcheck;
+
+/*80*/	__le32	s_checkinterval;
+	__le32	s_creator_os;
+	__le16	s_def_resuid;
+	__le16	s_def_resgid;
+	__le32	s_first_ino;
+
+/*90*/	__le16  s_inode_size;
+	__le16  s_dat_entry_size;
+	__le16  s_checkpoint_size;
+	__le16	s_segment_usage_size;
+
+/*98*/	__u8	s_uuid[16];
+/*A8*/	char	s_volume_name[80]	__kernel_nonstring;
+
+/*F8*/	__le32  s_c_interval;
+	__le32  s_c_block_max;
+
+/*100*/	__le64  s_feature_compat;
+	__le64  s_feature_compat_ro;
+	__le64  s_feature_incompat;
+	__u32	s_reserved[186];
 };
 
 /*
@@ -449,7 +480,7 @@ struct nilfs_btree_node {
 /**
  * struct nilfs_direct_node - header of built-in bmap array
  * @dn_flags: flags
- * @dn_pad: padding
+ * @pad: padding
  */
 struct nilfs_direct_node {
 	__u8 dn_flags;

