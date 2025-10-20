Return-Path: <linux-fsdevel+bounces-64640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A502BEF10B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 04:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1CB3E2A1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 02:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB61C223DC0;
	Mon, 20 Oct 2025 02:12:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92E221FBF
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 02:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926370; cv=none; b=tcT5UDonI9G2A7OVpsiM8E7dqCwxWq/ykIh0jK6+MQ6imd6Fpbe0X7ZcGWEBZOo4W4KRHP+/PxOPBKrovsa/G8qByufTJ+XY8O/iS/nDyjjUdxf5A9oXjjV+IkERgXk54nFfyreNmi9Fm+THXrIqooVxP9UryvgrBEHJwFtx/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926370; c=relaxed/simple;
	bh=kRURUKdeCZb7JH7Pu7jhvsjNuYhQ0Tc4Uf6ynjkL34E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XwESEGf20vXfsSUbzJW6gLDTEV6NCAqX0ZtDKIQbK7rkIcwqDRohoq7UKcWfixY0M0udpd9aW27AFNtsuarlvYiECOJnUPVfMTDkgT+AF7ClO9TW0J1eSan0ueyHh5gB2hUzXlMTfZsJ5DJBo9LBxjY4fdXrjXG0TxOiTE59REI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso3382943a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 19:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760926367; x=1761531167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dnmAWou/FNp9oJYJZA0a5QBO0439Yxt0gKeUqw9miI=;
        b=sjAgGBOcDalpwi7W3GuyavzihF0KpP0SAMFXFZRzQE7njYQqWDpkbDpQwC2LO0n56u
         WyRUKaa0cf25jpWXQtMvuAcpCeR63JPNZfhRc7wC1YqLY9rjq6dVSodQr+nBEX6MiQxM
         5Ufmt5DBuWFVEwKeu8qdGVU0dAOR1LpxNPNZmZn3arsWdlhoYCpAAVbDS8uMUiFxbmJD
         hNT2cSNDnUOJ04/cQqjEplSSGkyNCZa62Q8kVdORO5HIlf8NaCndUs2Iqg7g4+xzKOUm
         qvDe94/Ly4FqMevHSSUupd6fCNxWhZkCSLRF/EHua4sNJwqObD8dj2Vktc7mMRwYQdEK
         i7wA==
X-Gm-Message-State: AOJu0Yy9odf4RzvEuurh7FV1JNbr7UOCe78A/VjZx8/aOpGuNA++4fD9
	HDT3izaWLjhW6wQ3UFlT3XDHOGbGxrCP1i0qerllOCrN2G6uBHpR72PC
X-Gm-Gg: ASbGncuachKvLNXbOBJX93KExaDe7fTFU6Uumk7yZP/Ci9LtHWSDOzFpNJgVWfdDxck
	g9TeBl/2P4fAQLaoNQSH1ymjwxrHNb0+p4to9y33LTM7RlhtwUMO/R+ZCwkL+WsZmPUwwAlTEfS
	/+2dGFH+bUEyUcfwZG8MvN0bT3o3pD9bwi2Bl7qKUXcCGuEuY3WdNA0HNL5Ivbtw2YgWgKsuP4o
	YUKay4BOAUAfCnUyZxjX8hKxfSXa/NUALOC3VhoGdPTneTAqo5XK/bX5EI/LJz2v3dGkx74CYDE
	O3QHb7PY+otYOLyJS8T3ZtdInxnR6LvURAybeK9qCPL1BTtipWKR+Kqb7VkkL4J5jEek6PFkGzM
	qmjTcoR5ZcpzvSuFvj7f+0fD8OH5LtlN6LBxLJ6Z4IEzyBGIwnQJsV4FA96moMVTrLCfyrEW7QU
	EJokXgqRBgWLu+13s=
X-Google-Smtp-Source: AGHT+IGmY5GUhidpS2a9H27p/cHkz7wxEFmaNUss4g/mzoVKMn9O2HaAVvTPR9VulQxaBws9GHD1Fw==
X-Received: by 2002:a17:90b:3891:b0:32e:9da9:3e60 with SMTP id 98e67ed59e1d1-33bcf9375e8mr12547095a91.36.1760926367026;
        Sun, 19 Oct 2025 19:12:47 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a764508b0sm6406849a12.0.2025.10.19.19.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:12:46 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 06/11] ntfsplus: add iomap and address space operations
Date: Mon, 20 Oct 2025 11:12:22 +0900
Message-Id: <20251020021227.5965-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the implementation of iomap and address space operations
for ntfsplus.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfsplus/aops.c       | 631 +++++++++++++++++++++++++++++++++++
 fs/ntfsplus/ntfs_iomap.c | 704 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 1335 insertions(+)
 create mode 100644 fs/ntfsplus/aops.c
 create mode 100644 fs/ntfsplus/ntfs_iomap.c

diff --git a/fs/ntfsplus/aops.c b/fs/ntfsplus/aops.c
new file mode 100644
index 000000000000..50c804be3bd4
--- /dev/null
+++ b/fs/ntfsplus/aops.c
@@ -0,0 +1,631 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ * NTFS kernel address space operations and page cache handling.
+ *
+ * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
+ * Copyright (c) 2002 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#include <linux/writeback.h>
+#include <linux/mpage.h>
+#include <linux/uio.h>
+
+#include "aops.h"
+#include "attrib.h"
+#include "mft.h"
+#include "ntfs.h"
+#include "misc.h"
+#include "ntfs_iomap.h"
+
+static s64 ntfs_convert_page_index_into_lcn(struct ntfs_volume *vol, struct ntfs_inode *ni,
+		unsigned long page_index)
+{
+	sector_t iblock;
+	s64 vcn;
+	s64 lcn;
+	unsigned char blocksize_bits = vol->sb->s_blocksize_bits;
+
+	iblock = (s64)page_index << (PAGE_SHIFT - blocksize_bits);
+	vcn = (s64)iblock << blocksize_bits >> vol->cluster_size_bits;
+
+	down_read(&ni->runlist.lock);
+	lcn = ntfs_attr_vcn_to_lcn_nolock(ni, vcn, false);
+	up_read(&ni->runlist.lock);
+
+	return lcn;
+}
+
+struct bio *ntfs_setup_bio(struct ntfs_volume *vol, unsigned int opf, s64 lcn,
+		unsigned int pg_ofs)
+{
+	struct bio *bio;
+
+	bio = bio_alloc(vol->sb->s_bdev, 1, opf, GFP_NOIO);
+	if (!bio)
+		return NULL;
+	bio->bi_iter.bi_sector = ((lcn << vol->cluster_size_bits) + pg_ofs) >>
+		vol->sb->s_blocksize_bits;
+
+	return bio;
+}
+
+/**
+ * ntfs_read_folio - fill a @folio of a @file with data from the device
+ * @file:	open file to which the folio @folio belongs or NULL
+ * @folio:	page cache folio to fill with data
+ *
+ * For non-resident attributes, ntfs_read_folio() fills the @folio of the open
+ * file @file by calling the ntfs version of the generic block_read_full_folio()
+ * function, which in turn creates and reads in the buffers associated with
+ * the folio asynchronously.
+ *
+ * For resident attributes, OTOH, ntfs_read_folio() fills @folio by copying the
+ * data from the mft record (which at this stage is most likely in memory) and
+ * fills the remainder with zeroes. Thus, in this case, I/O is synchronous, as
+ * even if the mft record is not cached at this point in time, we need to wait
+ * for it to be read in before we can do the copy.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static int ntfs_read_folio(struct file *file, struct folio *folio)
+{
+	loff_t i_size;
+	struct inode *vi;
+	struct ntfs_inode *ni;
+
+	vi = folio->mapping->host;
+	i_size = i_size_read(vi);
+	/* Is the page fully outside i_size? (truncate in progress) */
+	if (unlikely(folio->index >= (i_size + PAGE_SIZE - 1) >>
+			PAGE_SHIFT)) {
+		folio_zero_segment(folio, 0, PAGE_SIZE);
+		ntfs_debug("Read outside i_size - truncated?");
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+		return 0;
+	}
+	/*
+	 * This can potentially happen because we clear PageUptodate() during
+	 * ntfs_writepage() of MstProtected() attributes.
+	 */
+	if (folio_test_uptodate(folio)) {
+		folio_unlock(folio);
+		return 0;
+	}
+	ni = NTFS_I(vi);
+
+	/*
+	 * Only $DATA attributes can be encrypted and only unnamed $DATA
+	 * attributes can be compressed.  Index root can have the flags set but
+	 * this means to create compressed/encrypted files, not that the
+	 * attribute is compressed/encrypted.  Note we need to check for
+	 * AT_INDEX_ALLOCATION since this is the type of both directory and
+	 * index inodes.
+	 */
+	if (ni->type != AT_INDEX_ALLOCATION) {
+		/* If attribute is encrypted, deny access, just like NT4. */
+		if (NInoEncrypted(ni)) {
+			BUG_ON(ni->type != AT_DATA);
+			folio_unlock(folio);
+			return -EACCES;
+		}
+		/* Compressed data streams are handled in compress.c. */
+		if (NInoNonResident(ni) && NInoCompressed(ni)) {
+			BUG_ON(ni->type != AT_DATA);
+			BUG_ON(ni->name_len);
+			return ntfs_read_compressed_block(folio);
+		}
+	}
+
+	return iomap_read_folio(folio, &ntfs_read_iomap_ops);
+}
+
+static int ntfs_write_mft_block(struct ntfs_inode *ni, struct folio *folio,
+		struct writeback_control *wbc)
+{
+	struct inode *vi = VFS_I(ni);
+	struct ntfs_volume *vol = ni->vol;
+	u8 *kaddr;
+	struct ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];
+	int nr_locked_nis = 0, err = 0, mft_ofs, prev_mft_ofs;
+	struct bio *bio = NULL;
+	unsigned long mft_no;
+	struct ntfs_inode *tni;
+	s64 lcn;
+	unsigned int lcn_folio_off = 0;
+	s64 vcn = (s64)folio->index << PAGE_SHIFT >> vol->cluster_size_bits;
+	s64 end_vcn = ni->allocated_size >> vol->cluster_size_bits;
+	unsigned int folio_sz;
+	struct runlist_element *rl;
+
+	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, folio index 0x%lx.",
+			vi->i_ino, ni->type, folio->index);
+	BUG_ON(!NInoNonResident(ni));
+	BUG_ON(!NInoMstProtected(ni));
+
+	/*
+	 * NOTE: ntfs_write_mft_block() would be called for $MFTMirr if a page
+	 * in its page cache were to be marked dirty.  However this should
+	 * never happen with the current driver and considering we do not
+	 * handle this case here we do want to BUG(), at least for now.
+	 */
+
+	BUG_ON(!((S_ISREG(vi->i_mode) && !vi->i_ino) || S_ISDIR(vi->i_mode) ||
+		(NInoAttr(ni) && ni->type == AT_INDEX_ALLOCATION)));
+
+	lcn = ntfs_convert_page_index_into_lcn(vol, ni, folio->index);
+	if (lcn <= LCN_HOLE) {
+		folio_start_writeback(folio);
+		folio_unlock(folio);
+		folio_end_writeback(folio);
+		return -EIO;
+	}
+
+	if (vol->cluster_size_bits > PAGE_SHIFT) {
+		lcn_folio_off = folio->index << PAGE_SHIFT;
+		lcn_folio_off &= vol->cluster_size_mask;
+	}
+
+	/* Map folio so we can access its contents. */
+	kaddr = kmap_local_folio(folio, 0);
+	/* Clear the page uptodate flag whilst the mst fixups are applied. */
+	folio_clear_uptodate(folio);
+
+	for (mft_ofs = 0; mft_ofs < PAGE_SIZE && vcn < end_vcn;
+	     mft_ofs += vol->mft_record_size) {
+		/* Get the mft record number. */
+		mft_no = (((s64)folio->index << PAGE_SHIFT) + mft_ofs) >>
+			vol->mft_record_size_bits;
+		/* Check whether to write this mft record. */
+		tni = NULL;
+		if (ntfs_may_write_mft_record(vol, mft_no,
+					(struct mft_record *)(kaddr + mft_ofs), &tni)) {
+			unsigned int mft_record_off = 0;
+			s64 vcn_off = vcn;
+
+			/*
+			 * The record should be written.  If a locked ntfs
+			 * inode was returned, add it to the array of locked
+			 * ntfs inodes.
+			 */
+			if (tni)
+				locked_nis[nr_locked_nis++] = tni;
+
+			if (bio && (mft_ofs != prev_mft_ofs + vol->mft_record_size)) {
+flush_bio:
+				flush_dcache_folio(folio);
+				submit_bio_wait(bio);
+				bio_put(bio);
+				bio = NULL;
+			}
+
+			if (vol->cluster_size == NTFS_BLOCK_SIZE) {
+				down_write(&ni->runlist.lock);
+				rl = ntfs_attr_vcn_to_rl(ni, vcn_off, &lcn);
+				up_write(&ni->runlist.lock);
+				if (IS_ERR(rl) || lcn < 0) {
+					err = -EIO;
+					goto unm_done;
+				}
+			}
+
+			if (!bio) {
+				unsigned int off = lcn_folio_off;
+
+				if (vol->cluster_size != NTFS_BLOCK_SIZE)
+					off += mft_ofs;
+
+				bio = ntfs_setup_bio(vol, REQ_OP_WRITE, lcn, off);
+				if (!bio) {
+					err = -ENOMEM;
+					goto unm_done;
+				}
+			}
+
+			if (vol->cluster_size == NTFS_BLOCK_SIZE && rl->length == 1)
+				folio_sz = NTFS_BLOCK_SIZE;
+			else
+				folio_sz = vol->mft_record_size;
+			if (!bio_add_folio(bio, folio, folio_sz,
+					   mft_ofs + mft_record_off)) {
+				err = -EIO;
+				bio_put(bio);
+				goto unm_done;
+			}
+			prev_mft_ofs = mft_ofs;
+			mft_record_off += folio_sz;
+
+			if (mft_record_off != vol->mft_record_size) {
+				vcn_off++;
+				goto flush_bio;
+			}
+
+			if (mft_no < vol->mftmirr_size)
+				ntfs_sync_mft_mirror(vol, mft_no,
+						(struct mft_record *)(kaddr + mft_ofs));
+		}
+
+		vcn += vol->mft_record_size >> vol->cluster_size_bits;
+	}
+
+	if (bio) {
+		flush_dcache_folio(folio);
+		submit_bio_wait(bio);
+		bio_put(bio);
+	}
+	flush_dcache_folio(folio);
+unm_done:
+	folio_mark_uptodate(folio);
+	kunmap_local(kaddr);
+
+	folio_start_writeback(folio);
+	folio_unlock(folio);
+	folio_end_writeback(folio);
+
+	/* Unlock any locked inodes. */
+	while (nr_locked_nis-- > 0) {
+		struct ntfs_inode *base_tni;
+
+		tni = locked_nis[nr_locked_nis];
+		mutex_unlock(&tni->mrec_lock);
+
+		/* Get the base inode. */
+		mutex_lock(&tni->extent_lock);
+		if (tni->nr_extents >= 0)
+			base_tni = tni;
+		else {
+			base_tni = tni->ext.base_ntfs_ino;
+			BUG_ON(!base_tni);
+		}
+		mutex_unlock(&tni->extent_lock);
+		ntfs_debug("Unlocking %s inode 0x%lx.",
+				tni == base_tni ? "base" : "extent",
+				tni->mft_no);
+		atomic_dec(&tni->count);
+		iput(VFS_I(base_tni));
+	}
+
+	if (unlikely(err && err != -ENOMEM))
+		NVolSetErrors(vol);
+	if (likely(!err))
+		ntfs_debug("Done.");
+	return err;
+}
+
+/**
+ * ntfs_bmap - map logical file block to physical device block
+ * @mapping:	address space mapping to which the block to be mapped belongs
+ * @block:	logical block to map to its physical device block
+ *
+ * For regular, non-resident files (i.e. not compressed and not encrypted), map
+ * the logical @block belonging to the file described by the address space
+ * mapping @mapping to its physical device block.
+ *
+ * The size of the block is equal to the @s_blocksize field of the super block
+ * of the mounted file system which is guaranteed to be smaller than or equal
+ * to the cluster size thus the block is guaranteed to fit entirely inside the
+ * cluster which means we do not need to care how many contiguous bytes are
+ * available after the beginning of the block.
+ *
+ * Return the physical device block if the mapping succeeded or 0 if the block
+ * is sparse or there was an error.
+ *
+ * Note: This is a problem if someone tries to run bmap() on $Boot system file
+ * as that really is in block zero but there is nothing we can do.  bmap() is
+ * just broken in that respect (just like it cannot distinguish sparse from
+ * not available or error).
+ */
+static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
+{
+	s64 ofs, size;
+	loff_t i_size;
+	s64 lcn;
+	unsigned long blocksize, flags;
+	struct ntfs_inode *ni = NTFS_I(mapping->host);
+	struct ntfs_volume *vol = ni->vol;
+	unsigned int delta;
+	unsigned char blocksize_bits, cluster_size_shift;
+
+	ntfs_debug("Entering for mft_no 0x%lx, logical block 0x%llx.",
+			ni->mft_no, (unsigned long long)block);
+	if (ni->type != AT_DATA || !NInoNonResident(ni) || NInoEncrypted(ni)) {
+		ntfs_error(vol->sb, "BMAP does not make sense for %s attributes, returning 0.",
+				(ni->type != AT_DATA) ? "non-data" :
+				(!NInoNonResident(ni) ? "resident" :
+				"encrypted"));
+		return 0;
+	}
+	/* None of these can happen. */
+	BUG_ON(NInoCompressed(ni));
+	BUG_ON(NInoMstProtected(ni));
+	blocksize = vol->sb->s_blocksize;
+	blocksize_bits = vol->sb->s_blocksize_bits;
+	ofs = (s64)block << blocksize_bits;
+	read_lock_irqsave(&ni->size_lock, flags);
+	size = ni->initialized_size;
+	i_size = i_size_read(VFS_I(ni));
+	read_unlock_irqrestore(&ni->size_lock, flags);
+	/*
+	 * If the offset is outside the initialized size or the block straddles
+	 * the initialized size then pretend it is a hole unless the
+	 * initialized size equals the file size.
+	 */
+	if (unlikely(ofs >= size || (ofs + blocksize > size && size < i_size)))
+		goto hole;
+	cluster_size_shift = vol->cluster_size_bits;
+	down_read(&ni->runlist.lock);
+	lcn = ntfs_attr_vcn_to_lcn_nolock(ni, ofs >> cluster_size_shift, false);
+	up_read(&ni->runlist.lock);
+	if (unlikely(lcn < LCN_HOLE)) {
+		/*
+		 * Step down to an integer to avoid gcc doing a long long
+		 * comparision in the switch when we know @lcn is between
+		 * LCN_HOLE and LCN_EIO (i.e. -1 to -5).
+		 *
+		 * Otherwise older gcc (at least on some architectures) will
+		 * try to use __cmpdi2() which is of course not available in
+		 * the kernel.
+		 */
+		switch ((int)lcn) {
+		case LCN_ENOENT:
+			/*
+			 * If the offset is out of bounds then pretend it is a
+			 * hole.
+			 */
+			goto hole;
+		case LCN_ENOMEM:
+			ntfs_error(vol->sb,
+				"Not enough memory to complete mapping for inode 0x%lx. Returning 0.",
+				ni->mft_no);
+			break;
+		default:
+			ntfs_error(vol->sb,
+				"Failed to complete mapping for inode 0x%lx.  Run chkdsk. Returning 0.",
+				ni->mft_no);
+			break;
+		}
+		return 0;
+	}
+	if (lcn < 0) {
+		/* It is a hole. */
+hole:
+		ntfs_debug("Done (returning hole).");
+		return 0;
+	}
+	/*
+	 * The block is really allocated and fullfils all our criteria.
+	 * Convert the cluster to units of block size and return the result.
+	 */
+	delta = ofs & vol->cluster_size_mask;
+	if (unlikely(sizeof(block) < sizeof(lcn))) {
+		block = lcn = ((lcn << cluster_size_shift) + delta) >>
+				blocksize_bits;
+		/* If the block number was truncated return 0. */
+		if (unlikely(block != lcn)) {
+			ntfs_error(vol->sb,
+				"Physical block 0x%llx is too large to be returned, returning 0.",
+				(long long)lcn);
+			return 0;
+		}
+	} else
+		block = ((lcn << cluster_size_shift) + delta) >>
+				blocksize_bits;
+	ntfs_debug("Done (returning block 0x%llx).", (unsigned long long)lcn);
+	return block;
+}
+
+static void ntfs_readahead(struct readahead_control *rac)
+{
+	struct address_space *mapping = rac->mapping;
+	struct inode *inode = mapping->host;
+	struct ntfs_inode *ni = NTFS_I(inode);
+
+	if (!NInoNonResident(ni) || NInoCompressed(ni)) {
+		/* No readahead for resident and compressed. */
+		return;
+	}
+
+	if (NInoMstProtected(ni) &&
+	    (ni->mft_no == FILE_MFT || ni->mft_no == FILE_MFTMirr))
+		return;
+
+	iomap_readahead(rac, &ntfs_read_iomap_ops);
+}
+
+static int ntfs_mft_writepage(struct folio *folio, struct writeback_control *wbc)
+{
+	struct address_space *mapping = folio->mapping;
+	struct inode *vi = mapping->host;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	loff_t i_size;
+	int ret;
+
+	i_size = i_size_read(vi);
+
+	/* We have to zero every time due to mmap-at-end-of-file. */
+	if (folio->index >= (i_size >> PAGE_SHIFT)) {
+		/* The page straddles i_size. */
+		unsigned int ofs = i_size & ~PAGE_MASK;
+
+		folio_zero_segment(folio, ofs, PAGE_SIZE);
+	}
+
+	ret = ntfs_write_mft_block(ni, folio, wbc);
+	mapping_set_error(mapping, ret);
+	return ret;
+}
+
+static int ntfs_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	struct inode *inode = mapping->host;
+	struct ntfs_inode *ni = NTFS_I(inode);
+	struct iomap_writepage_ctx wpc = {
+		.inode		= mapping->host,
+		.wbc		= wbc,
+		.ops		= &ntfs_writeback_ops,
+	};
+
+	if (NVolShutdown(ni->vol))
+		return -EIO;
+
+	if (!NInoNonResident(ni))
+		return 0;
+
+	if (NInoMstProtected(ni) && ni->mft_no == FILE_MFT) {
+		struct folio *folio = NULL;
+		int error;
+
+		while ((folio = writeback_iter(mapping, wbc, folio, &error)))
+			error = ntfs_mft_writepage(folio, wbc);
+		return error;
+	}
+
+	/* If file is encrypted, deny access, just like NT4. */
+	if (NInoEncrypted(ni)) {
+		ntfs_debug("Denying write access to encrypted file.");
+		return -EACCES;
+	}
+
+	return iomap_writepages(&wpc);
+}
+
+static int ntfs_swap_activate(struct swap_info_struct *sis,
+		struct file *swap_file, sector_t *span)
+{
+	return iomap_swapfile_activate(sis, swap_file, span,
+			&ntfs_read_iomap_ops);
+}
+
+/**
+ * ntfs_normal_aops - address space operations for normal inodes and attributes
+ *
+ * Note these are not used for compressed or mst protected inodes and
+ * attributes.
+ */
+const struct address_space_operations ntfs_normal_aops = {
+	.read_folio		= ntfs_read_folio,
+	.readahead		= ntfs_readahead,
+	.writepages		= ntfs_writepages,
+	.direct_IO		= noop_direct_IO,
+	.dirty_folio		= iomap_dirty_folio,
+	.bmap			= ntfs_bmap,
+	.migrate_folio		= filemap_migrate_folio,
+	.is_partially_uptodate	= iomap_is_partially_uptodate,
+	.error_remove_folio	= generic_error_remove_folio,
+	.release_folio		= iomap_release_folio,
+	.invalidate_folio	= iomap_invalidate_folio,
+	.swap_activate          = ntfs_swap_activate,
+};
+
+/**
+ * ntfs_compressed_aops - address space operations for compressed inodes
+ */
+const struct address_space_operations ntfs_compressed_aops = {
+	.read_folio		= ntfs_read_folio,
+	.direct_IO		= noop_direct_IO,
+	.writepages		= ntfs_writepages,
+	.dirty_folio		= iomap_dirty_folio,
+	.migrate_folio		= filemap_migrate_folio,
+	.is_partially_uptodate	= iomap_is_partially_uptodate,
+	.error_remove_folio	= generic_error_remove_folio,
+	.release_folio		= iomap_release_folio,
+	.invalidate_folio	= iomap_invalidate_folio,
+};
+
+/**
+ * ntfs_mst_aops - general address space operations for mst protecteed inodes
+ *		   and attributes
+ */
+const struct address_space_operations ntfs_mst_aops = {
+	.read_folio		= ntfs_read_folio,	/* Fill page with data. */
+	.readahead		= ntfs_readahead,
+	.writepages		= ntfs_writepages,	/* Write dirty page to disk. */
+	.dirty_folio		= iomap_dirty_folio,
+	.migrate_folio		= filemap_migrate_folio,
+	.is_partially_uptodate	= iomap_is_partially_uptodate,
+	.error_remove_folio	= generic_error_remove_folio,
+	.release_folio		= iomap_release_folio,
+	.invalidate_folio	= iomap_invalidate_folio,
+};
+
+void mark_ntfs_record_dirty(struct folio *folio)
+{
+	iomap_dirty_folio(folio->mapping, folio);
+}
+
+int ntfs_dev_read(struct super_block *sb, void *buf, loff_t start, loff_t size)
+{
+	pgoff_t idx, idx_end;
+	loff_t offset, end = start + size;
+	u32 from, to, buf_off = 0;
+	struct folio *folio;
+	char *kaddr;
+
+	idx = start >> PAGE_SHIFT;
+	idx_end = end >> PAGE_SHIFT;
+	from = start & ~PAGE_MASK;
+
+	if (idx == idx_end)
+		idx_end++;
+
+	for (; idx < idx_end; idx++, from = 0) {
+		folio = ntfs_read_mapping_folio(sb->s_bdev->bd_mapping, idx);
+		if (IS_ERR(folio)) {
+			ntfs_error(sb, "Unable to read %ld page", idx);
+			return PTR_ERR(folio);
+		}
+
+		kaddr = kmap_local_folio(folio, 0);
+		offset = (loff_t)idx << PAGE_SHIFT;
+		to = min_t(u32, end - offset, PAGE_SIZE);
+
+		memcpy(buf + buf_off, kaddr + from, to);
+		buf_off += to;
+		kunmap_local(kaddr);
+		folio_put(folio);
+	}
+
+	return 0;
+}
+
+int ntfs_dev_write(struct super_block *sb, void *buf, loff_t start,
+			loff_t size, bool wait)
+{
+	pgoff_t idx, idx_end;
+	loff_t offset, end = start + size;
+	u32 from, to, buf_off = 0;
+	struct folio *folio;
+	char *kaddr;
+
+	idx = start >> PAGE_SHIFT;
+	idx_end = end >> PAGE_SHIFT;
+	from = start & ~PAGE_MASK;
+
+	if (idx == idx_end)
+		idx_end++;
+
+	for (; idx < idx_end; idx++, from = 0) {
+		folio = ntfs_read_mapping_folio(sb->s_bdev->bd_mapping, idx);
+		if (IS_ERR(folio)) {
+			ntfs_error(sb, "Unable to read %ld page", idx);
+			return PTR_ERR(folio);
+		}
+
+		kaddr = kmap_local_folio(folio, 0);
+		offset = (loff_t)idx << PAGE_SHIFT;
+		to = min_t(u32, end - offset, PAGE_SIZE);
+
+		memcpy(kaddr + from, buf + buf_off, to);
+		buf_off += to;
+		kunmap_local(kaddr);
+		folio_mark_uptodate(folio);
+		folio_mark_dirty(folio);
+		if (wait)
+			folio_wait_stable(folio);
+		folio_put(folio);
+	}
+
+	return 0;
+}
diff --git a/fs/ntfsplus/ntfs_iomap.c b/fs/ntfsplus/ntfs_iomap.c
new file mode 100644
index 000000000000..a6d2c9e01ca6
--- /dev/null
+++ b/fs/ntfsplus/ntfs_iomap.c
@@ -0,0 +1,704 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ * iomap callack functions
+ *
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#include <linux/writeback.h>
+#include <linux/mpage.h>
+#include <linux/uio.h>
+
+#include "aops.h"
+#include "attrib.h"
+#include "mft.h"
+#include "ntfs.h"
+#include "misc.h"
+#include "ntfs_iomap.h"
+
+static void ntfs_iomap_put_folio(struct inode *inode, loff_t pos,
+		unsigned int len, struct folio *folio)
+{
+	struct ntfs_inode *ni = NTFS_I(inode);
+	unsigned long sector_size = 1UL << inode->i_blkbits;
+	loff_t start_down, end_up, init;
+
+	if (!NInoNonResident(ni))
+		goto out;
+
+	start_down = round_down(pos, sector_size);
+	end_up = (pos + len - 1) | (sector_size - 1);
+	init = ni->initialized_size;
+
+	if (init >= start_down && init <= end_up) {
+		if (init < pos) {
+			loff_t offset = offset_in_folio(folio, pos + len);
+
+			if (offset == 0)
+				offset = folio_size(folio);
+			folio_zero_segments(folio,
+					    offset_in_folio(folio, init),
+					    offset_in_folio(folio, pos),
+					    offset,
+					    folio_size(folio));
+
+		} else  {
+			loff_t offset = max_t(loff_t, pos + len, init);
+
+			offset = offset_in_folio(folio, offset);
+			if (offset == 0)
+				offset = folio_size(folio);
+			folio_zero_segment(folio,
+					   offset,
+					   folio_size(folio));
+		}
+	} else if (init <= pos) {
+		loff_t offset = 0, offset2 = offset_in_folio(folio, pos + len);
+
+		if ((init >> folio_shift(folio)) == (pos >> folio_shift(folio)))
+			offset = offset_in_folio(folio, init);
+		if (offset2 == 0)
+			offset2 = folio_size(folio);
+		folio_zero_segments(folio,
+				    offset,
+				    offset_in_folio(folio, pos),
+				    offset2,
+				    folio_size(folio));
+	}
+
+out:
+	folio_unlock(folio);
+	folio_put(folio);
+}
+
+const struct iomap_write_ops ntfs_iomap_folio_ops = {
+	.put_folio = ntfs_iomap_put_folio,
+};
+
+static int ntfs_read_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct ntfs_inode *base_ni, *ni = NTFS_I(inode);
+	struct ntfs_attr_search_ctx *ctx;
+	loff_t i_size;
+	u32 attr_len;
+	int err = 0;
+	char *kattr;
+	struct page *ipage;
+
+	if (NInoNonResident(ni)) {
+		s64 vcn;
+		s64 lcn;
+		struct runlist_element *rl;
+		struct ntfs_volume *vol = ni->vol;
+		loff_t vcn_ofs;
+		loff_t rl_length;
+
+		vcn = offset >> vol->cluster_size_bits;
+		vcn_ofs = offset & vol->cluster_size_mask;
+
+		down_write(&ni->runlist.lock);
+		rl = ntfs_attr_vcn_to_rl(ni, vcn, &lcn);
+		if (IS_ERR(rl)) {
+			up_write(&ni->runlist.lock);
+			return PTR_ERR(rl);
+		}
+
+		if (flags & IOMAP_REPORT) {
+			if (lcn < LCN_HOLE) {
+				up_write(&ni->runlist.lock);
+				return -ENOENT;
+			}
+		} else if (lcn < LCN_ENOENT) {
+			up_write(&ni->runlist.lock);
+			return -EINVAL;
+		}
+
+		iomap->bdev = inode->i_sb->s_bdev;
+		iomap->offset = offset;
+
+		if (lcn <= LCN_DELALLOC) {
+			if (lcn == LCN_DELALLOC)
+				iomap->type = IOMAP_DELALLOC;
+			else
+				iomap->type = IOMAP_HOLE;
+			iomap->addr = IOMAP_NULL_ADDR;
+		} else {
+			if (!(flags & IOMAP_ZERO) && offset >= ni->initialized_size)
+				iomap->type = IOMAP_UNWRITTEN;
+			else
+				iomap->type = IOMAP_MAPPED;
+			iomap->addr = (lcn << vol->cluster_size_bits) + vcn_ofs;
+		}
+
+		rl_length = (rl->length - (vcn - rl->vcn)) << ni->vol->cluster_size_bits;
+
+		if (rl_length == 0 && rl->lcn > LCN_DELALLOC) {
+			ntfs_error(inode->i_sb,
+				   "runlist(vcn : %lld, length : %lld, lcn : %lld) is corrupted\n",
+				   rl->vcn, rl->length, rl->lcn);
+			up_write(&ni->runlist.lock);
+			return -EIO;
+		}
+
+		if (rl_length && length > rl_length - vcn_ofs)
+			iomap->length = rl_length - vcn_ofs;
+		else
+			iomap->length = length;
+		up_write(&ni->runlist.lock);
+
+		if (!(flags & IOMAP_ZERO) &&
+		    iomap->type == IOMAP_MAPPED &&
+		    iomap->offset < ni->initialized_size &&
+		    iomap->offset + iomap->length > ni->initialized_size) {
+			iomap->length = round_up(ni->initialized_size, 1 << inode->i_blkbits) -
+				iomap->offset;
+		}
+		iomap->flags |= IOMAP_F_MERGED;
+		return 0;
+	}
+
+	if (NInoAttr(ni))
+		base_ni = ni->ext.base_ntfs_ino;
+	else
+		base_ni = ni;
+	BUG_ON(NInoNonResident(ni));
+
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err))
+		goto out;
+
+	attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
+	if (unlikely(attr_len > ni->initialized_size))
+		attr_len = ni->initialized_size;
+	i_size = i_size_read(inode);
+
+	if (unlikely(attr_len > i_size)) {
+		/* Race with shrinking truncate. */
+		attr_len = i_size;
+	}
+
+	if (offset >= attr_len) {
+		if (flags & IOMAP_REPORT)
+			err = -ENOENT;
+		else
+			err = -EFAULT;
+		goto out;
+	}
+
+	kattr = (u8 *)ctx->attr + le16_to_cpu(ctx->attr->data.resident.value_offset);
+
+	ipage = alloc_page(__GFP_NOWARN | __GFP_IO | __GFP_ZERO);
+	if (!ipage) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(page_address(ipage), kattr, attr_len);
+	iomap->type = IOMAP_INLINE;
+	iomap->inline_data = page_address(ipage);
+	iomap->offset = 0;
+	iomap->length = min_t(loff_t, attr_len, PAGE_SIZE);
+	iomap->private = ipage;
+
+out:
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	return err;
+}
+
+static int ntfs_read_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+		ssize_t written, unsigned int flags, struct iomap *iomap)
+{
+	if (iomap->type == IOMAP_INLINE) {
+		struct page *ipage = iomap->private;
+
+		put_page(ipage);
+	}
+	return written;
+}
+
+const struct iomap_ops ntfs_read_iomap_ops = {
+	.iomap_begin = ntfs_read_iomap_begin,
+	.iomap_end = ntfs_read_iomap_end,
+};
+
+static int ntfs_buffered_zeroed_clusters(struct inode *vi, s64 vcn)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_volume *vol = ni->vol;
+	struct address_space *mapping = vi->i_mapping;
+	struct folio *folio;
+	pgoff_t idx, idx_end;
+	u32 from, to;
+
+	idx = (vcn << vol->cluster_size_bits) >> PAGE_SHIFT;
+	idx_end = ((vcn + 1) << vol->cluster_size_bits) >> PAGE_SHIFT;
+	from = (vcn << vol->cluster_size_bits) & ~PAGE_MASK;
+	if (idx == idx_end)
+		idx_end++;
+
+	to = min_t(u32, vol->cluster_size, PAGE_SIZE);
+	for (; idx < idx_end; idx++, from = 0) {
+		if (to != PAGE_SIZE) {
+			folio = ntfs_read_mapping_folio(mapping, idx);
+			if (IS_ERR(folio))
+				return PTR_ERR(folio);
+			folio_lock(folio);
+		} else {
+			folio = __filemap_get_folio(mapping, idx,
+					FGP_WRITEBEGIN | FGP_NOFS, mapping_gfp_mask(mapping));
+			if (IS_ERR(folio))
+				return PTR_ERR(folio);
+		}
+
+		if (folio_test_uptodate(folio) ||
+		    iomap_is_partially_uptodate(folio, from, to))
+			goto next_folio;
+
+		folio_zero_segment(folio, from, from + to);
+		folio_mark_uptodate(folio);
+
+next_folio:
+		iomap_dirty_folio(mapping, folio);
+		folio_unlock(folio);
+		folio_put(folio);
+		balance_dirty_pages_ratelimited(mapping);
+		cond_resched();
+	}
+
+	return 0;
+}
+
+int ntfs_zeroed_clusters(struct inode *vi, s64 lcn, s64 num)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_volume *vol = ni->vol;
+	u32 to;
+	struct bio *bio = NULL;
+	s64 err = 0, zero_len = num << vol->cluster_size_bits;
+	s64 loc = lcn << vol->cluster_size_bits, curr = 0;
+
+	while (zero_len > 0) {
+setup_bio:
+		if (!bio) {
+			bio = bio_alloc(vol->sb->s_bdev,
+					bio_max_segs(DIV_ROUND_UP(zero_len, PAGE_SIZE)),
+					REQ_OP_WRITE | REQ_SYNC | REQ_IDLE, GFP_NOIO);
+			if (!bio)
+				return -ENOMEM;
+			bio->bi_iter.bi_sector = (loc + curr) >> vol->sb->s_blocksize_bits;
+		}
+
+		to = min_t(u32, zero_len, PAGE_SIZE);
+		if (!bio_add_page(bio, ZERO_PAGE(0), to, 0)) {
+			err = submit_bio_wait(bio);
+			bio_put(bio);
+			bio = NULL;
+			if (err)
+				break;
+			goto setup_bio;
+		}
+		zero_len -= to;
+		curr += to;
+	}
+
+	if (bio) {
+		err = submit_bio_wait(bio);
+		bio_put(bio);
+	}
+
+	return err;
+}
+
+static int __ntfs_write_iomap_begin(struct inode *inode, loff_t offset,
+				    loff_t length, unsigned int flags,
+				    struct iomap *iomap, bool da, bool mapped)
+{
+	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_volume *vol = ni->vol;
+	struct attr_record *a;
+	struct ntfs_attr_search_ctx *ctx;
+	u32 attr_len;
+	int err = 0;
+	char *kattr;
+	struct page *ipage;
+
+	if (NVolShutdown(vol))
+		return -EIO;
+
+	mutex_lock(&ni->mrec_lock);
+	if (NInoNonResident(ni)) {
+		s64 vcn;
+		loff_t vcn_ofs;
+		loff_t rl_length;
+		s64 max_clu_count =
+			round_up(length, vol->cluster_size) >> vol->cluster_size_bits;
+
+		vcn = offset >> vol->cluster_size_bits;
+		vcn_ofs = offset & vol->cluster_size_mask;
+
+		if (da) {
+			bool balloc = false;
+			s64 start_lcn, lcn_count;
+			bool update_mp;
+
+			update_mp = (flags & IOMAP_DIRECT) || mapped ||
+				NInoAttr(ni) || ni->mft_no < FILE_first_user;
+			down_write(&ni->runlist.lock);
+			err = ntfs_attr_map_cluster(ni, vcn, &start_lcn, &lcn_count,
+					max_clu_count, &balloc, update_mp,
+					!(flags & IOMAP_DIRECT) && !mapped);
+			up_write(&ni->runlist.lock);
+			mutex_unlock(&ni->mrec_lock);
+			if (err) {
+				ni->i_dealloc_clusters = 0;
+				return err;
+			}
+
+			iomap->bdev = inode->i_sb->s_bdev;
+			iomap->offset = offset;
+
+			rl_length = lcn_count << ni->vol->cluster_size_bits;
+			if (length > rl_length - vcn_ofs)
+				iomap->length = rl_length - vcn_ofs;
+			else
+				iomap->length = length;
+
+			if (start_lcn == LCN_HOLE)
+				iomap->type = IOMAP_HOLE;
+			else
+				iomap->type = IOMAP_MAPPED;
+			if (balloc == true)
+				iomap->flags = IOMAP_F_NEW;
+
+			iomap->addr = (start_lcn << vol->cluster_size_bits) + vcn_ofs;
+
+			if (balloc == true) {
+				if (flags & IOMAP_DIRECT || mapped == true) {
+					loff_t end = offset + length;
+
+					if (vcn_ofs || ((vol->cluster_size > iomap->length) &&
+							end < ni->initialized_size))
+						err = ntfs_zeroed_clusters(inode,
+								start_lcn, 1);
+					if (!err && lcn_count > 1 &&
+					    (iomap->length & vol->cluster_size_mask &&
+					     end < ni->initialized_size))
+						err = ntfs_zeroed_clusters(inode,
+								start_lcn + (lcn_count - 1), 1);
+				} else {
+					if (lcn_count > ni->i_dealloc_clusters)
+						ni->i_dealloc_clusters = 0;
+					else
+						ni->i_dealloc_clusters -= lcn_count;
+				}
+				if (err < 0)
+					return err;
+			}
+
+			if (mapped && iomap->offset + iomap->length >
+			    ni->initialized_size) {
+				err = ntfs_attr_set_initialized_size(ni, iomap->offset +
+								     iomap->length);
+				if (err)
+					return err;
+			}
+		} else {
+			struct runlist_element *rl, *rlc;
+			s64 lcn;
+			bool is_retry = false;
+
+			down_read(&ni->runlist.lock);
+			rl = ni->runlist.rl;
+			if (!rl) {
+				up_read(&ni->runlist.lock);
+				err = ntfs_map_runlist(ni, vcn);
+				if (err) {
+					mutex_unlock(&ni->mrec_lock);
+					return -ENOENT;
+				}
+				down_read(&ni->runlist.lock);
+				rl = ni->runlist.rl;
+			}
+			up_read(&ni->runlist.lock);
+
+			down_write(&ni->runlist.lock);
+remap_rl:
+			/* Seek to element containing target vcn. */
+			while (rl->length && rl[1].vcn <= vcn)
+				rl++;
+			lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
+
+			if (lcn <= LCN_RL_NOT_MAPPED && is_retry == false) {
+				is_retry = true;
+				if (!ntfs_map_runlist_nolock(ni, vcn, NULL)) {
+					rl = ni->runlist.rl;
+					goto remap_rl;
+				}
+			}
+
+			max_clu_count = min(max_clu_count, rl->length - (vcn - rl->vcn));
+			if (max_clu_count == 0) {
+				ntfs_error(inode->i_sb,
+					   "runlist(vcn : %lld, length : %lld) is corrupted\n",
+					   rl->vcn, rl->length);
+				up_write(&ni->runlist.lock);
+				mutex_unlock(&ni->mrec_lock);
+				return -EIO;
+			}
+
+			iomap->bdev = inode->i_sb->s_bdev;
+			iomap->offset = offset;
+
+			if (lcn <= LCN_DELALLOC) {
+				if (lcn < LCN_DELALLOC) {
+					max_clu_count =
+						ntfs_available_clusters_count(vol, max_clu_count);
+					if (max_clu_count < 0) {
+						err = max_clu_count;
+						up_write(&ni->runlist.lock);
+						mutex_unlock(&ni->mrec_lock);
+						return err;
+					}
+				}
+
+				iomap->type = IOMAP_DELALLOC;
+				iomap->addr = IOMAP_NULL_ADDR;
+
+				if (lcn <= LCN_HOLE) {
+					size_t new_rl_count;
+
+					rlc = ntfs_malloc_nofs(sizeof(struct runlist_element) * 2);
+					if (!rlc) {
+						up_write(&ni->runlist.lock);
+						mutex_unlock(&ni->mrec_lock);
+						return -ENOMEM;
+					}
+
+					rlc->vcn = vcn;
+					rlc->lcn = LCN_DELALLOC;
+					rlc->length = max_clu_count;
+
+					rlc[1].vcn = vcn + max_clu_count;
+					rlc[1].lcn = LCN_RL_NOT_MAPPED;
+					rlc[1].length = 0;
+
+					rl = ntfs_runlists_merge(&ni->runlist, rlc, 0,
+							&new_rl_count);
+					if (IS_ERR(rl)) {
+						ntfs_error(vol->sb, "Failed to merge runlists");
+						up_write(&ni->runlist.lock);
+						mutex_unlock(&ni->mrec_lock);
+						ntfs_free(rlc);
+						return PTR_ERR(rl);
+					}
+
+					ni->runlist.rl = rl;
+					ni->runlist.count = new_rl_count;
+					ni->i_dealloc_clusters += max_clu_count;
+				}
+				up_write(&ni->runlist.lock);
+				mutex_unlock(&ni->mrec_lock);
+
+				if (lcn < LCN_DELALLOC)
+					ntfs_hold_dirty_clusters(vol, max_clu_count);
+
+				rl_length = max_clu_count << ni->vol->cluster_size_bits;
+				if (length > rl_length - vcn_ofs)
+					iomap->length = rl_length - vcn_ofs;
+				else
+					iomap->length = length;
+
+				iomap->flags = IOMAP_F_NEW;
+				if (lcn <= LCN_HOLE) {
+					loff_t end = offset + length;
+
+					if (vcn_ofs || ((vol->cluster_size > iomap->length) &&
+							end < ni->initialized_size))
+						err = ntfs_buffered_zeroed_clusters(inode, vcn);
+					if (!err && max_clu_count > 1 &&
+					    (iomap->length & vol->cluster_size_mask &&
+					     end < ni->initialized_size))
+						err = ntfs_buffered_zeroed_clusters(inode,
+								vcn + (max_clu_count - 1));
+					if (err) {
+						ntfs_release_dirty_clusters(vol, max_clu_count);
+						return err;
+					}
+				}
+			} else {
+				up_write(&ni->runlist.lock);
+				mutex_unlock(&ni->mrec_lock);
+
+				iomap->type = IOMAP_MAPPED;
+				iomap->addr = (lcn << vol->cluster_size_bits) + vcn_ofs;
+
+				rl_length = max_clu_count << ni->vol->cluster_size_bits;
+				if (length > rl_length - vcn_ofs)
+					iomap->length = rl_length - vcn_ofs;
+				else
+					iomap->length = length;
+			}
+		}
+
+		return 0;
+	}
+
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (err) {
+		if (err == -ENOENT)
+			err = -EIO;
+		goto out;
+	}
+
+	a = ctx->attr;
+	BUG_ON(a->non_resident);
+	/* The total length of the attribute value. */
+	attr_len = le32_to_cpu(a->data.resident.value_length);
+
+	BUG_ON(offset > attr_len);
+	kattr = (u8 *)a + le16_to_cpu(a->data.resident.value_offset);
+
+	ipage = alloc_page(__GFP_NOWARN | __GFP_IO | __GFP_ZERO);
+	if (!ipage) {
+		err = -ENOMEM;
+		goto out;
+	}
+	memcpy(page_address(ipage), kattr, attr_len);
+
+	iomap->type = IOMAP_INLINE;
+	iomap->inline_data = page_address(ipage);
+	iomap->offset = 0;
+	/* iomap requires there is only one INLINE_DATA extent */
+	iomap->length = attr_len;
+	iomap->private = ipage;
+
+out:
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	mutex_unlock(&ni->mrec_lock);
+
+	return err;
+}
+
+static int ntfs_write_iomap_begin(struct inode *inode, loff_t offset,
+				  loff_t length, unsigned int flags,
+				  struct iomap *iomap, struct iomap *srcmap)
+{
+	return __ntfs_write_iomap_begin(inode, offset, length, flags, iomap,
+			false, false);
+}
+
+static int ntfs_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+		ssize_t written, unsigned int flags, struct iomap *iomap)
+{
+	if (iomap->type == IOMAP_INLINE) {
+		struct page *ipage = iomap->private;
+		struct ntfs_inode *ni = NTFS_I(inode);
+		struct ntfs_attr_search_ctx *ctx;
+		u32 attr_len;
+		int err;
+		char *kattr;
+
+		mutex_lock(&ni->mrec_lock);
+		ctx = ntfs_attr_get_search_ctx(ni, NULL);
+		if (!ctx) {
+			written = -ENOMEM;
+			mutex_unlock(&ni->mrec_lock);
+			goto out;
+		}
+
+		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+				CASE_SENSITIVE, 0, NULL, 0, ctx);
+		if (err) {
+			if (err == -ENOENT)
+				err = -EIO;
+			written = err;
+			goto err_out;
+		}
+
+		/* The total length of the attribute value. */
+		attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
+		if (pos >= attr_len || pos + written > attr_len)
+			goto err_out;
+
+		kattr = (u8 *)ctx->attr + le16_to_cpu(ctx->attr->data.resident.value_offset);
+		memcpy(kattr + pos, iomap_inline_data(iomap, pos), written);
+		mark_mft_record_dirty(ctx->ntfs_ino);
+err_out:
+		ntfs_attr_put_search_ctx(ctx);
+		put_page(ipage);
+		mutex_unlock(&ni->mrec_lock);
+	}
+
+out:
+	return written;
+}
+
+const struct iomap_ops ntfs_write_iomap_ops = {
+	.iomap_begin		= ntfs_write_iomap_begin,
+	.iomap_end		= ntfs_write_iomap_end,
+};
+
+static int ntfs_page_mkwrite_iomap_begin(struct inode *inode, loff_t offset,
+				  loff_t length, unsigned int flags,
+				  struct iomap *iomap, struct iomap *srcmap)
+{
+	return __ntfs_write_iomap_begin(inode, offset, length, flags, iomap,
+			true, true);
+}
+
+const struct iomap_ops ntfs_page_mkwrite_iomap_ops = {
+	.iomap_begin		= ntfs_page_mkwrite_iomap_begin,
+	.iomap_end		= ntfs_write_iomap_end,
+};
+
+static int ntfs_dio_iomap_begin(struct inode *inode, loff_t offset,
+				  loff_t length, unsigned int flags,
+				  struct iomap *iomap, struct iomap *srcmap)
+{
+	return __ntfs_write_iomap_begin(inode, offset, length, flags, iomap,
+			true, false);
+}
+
+const struct iomap_ops ntfs_dio_iomap_ops = {
+	.iomap_begin		= ntfs_dio_iomap_begin,
+	.iomap_end		= ntfs_write_iomap_end,
+};
+
+static ssize_t ntfs_writeback_range(struct iomap_writepage_ctx *wpc,
+		struct folio *folio, u64 offset, unsigned int len, u64 end_pos)
+{
+	if (offset < wpc->iomap.offset ||
+	    offset >= wpc->iomap.offset + wpc->iomap.length) {
+		int error;
+
+		error = __ntfs_write_iomap_begin(wpc->inode, offset,
+				NTFS_I(wpc->inode)->allocated_size - offset,
+				IOMAP_WRITE, &wpc->iomap, true, false);
+		if (error)
+			return error;
+	}
+
+	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
+}
+
+const struct iomap_writeback_ops ntfs_writeback_ops = {
+	.writeback_range	= ntfs_writeback_range,
+	.writeback_submit	= iomap_ioend_writeback_submit,
+};
-- 
2.34.1


