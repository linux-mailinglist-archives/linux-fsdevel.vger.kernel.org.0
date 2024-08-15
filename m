Return-Path: <linux-fsdevel+bounces-26040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B78E6952BF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1E71C2331A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E3F1E4EF0;
	Thu, 15 Aug 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="0TB37fgt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F71E4858;
	Thu, 15 Aug 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712997; cv=none; b=rd7STNtHaXrUxs326+0WTeQ5mpM/kfdADsu2jzSRa3esdjlXkyv2tJHyX65sitoegvLyJZMEDfiPDUYGcMshvNR+Jlb7y2wtTdUk7QMa71it1sn5JgdgrVFUO9VpQyLKbcFl3PDeiuJWOLB61fu1/0cJGJx5cni8LokiE1+PUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712997; c=relaxed/simple;
	bh=12cx8z3Hh5xBamqzZNJ7CHYJWZma06iegocET7vDoSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdhQKhAVLlbkCLMpyjUE3OKsil4z+ICqBv9qmhen81xAV3IpaaLS/WJRZucAkyWYCNiT+ha0nwppN2W089+Dbcp+NHTG5Pd0V2n/NVx7P5JhtX5OeSgBjhJmwJKGLWMJjiOInI+zDf44KtJdxEEz6aDdETepXrcR7j1f/Trqwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=0TB37fgt; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wkzph4P1Lz9t1S;
	Thu, 15 Aug 2024 11:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1723712988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXkoBosXMLIYgJIKlAekj9Nug/tJBjbP9UExZYT9KcY=;
	b=0TB37fgtNhiVqU/8NCdQbFcB3fK7yAm735qgwS0jp0y3MyV6bZyZtOtOOXR83wYXC63RAC
	M6c7Ycpkxz1Yt/SOM7wWXHEhBKPQbzbKo3aJTvHG1TTORTkLayMmUXPi93ZpWMlHgh7cZG
	FAXhAWGN6Ow/T+mUNQfHospGnJETKbNfcxRN4vvCr8x/7HD9dWOFzqEGhHqLFVLgXJ7zWc
	3LPqXX6gNzI8O/99IAOV1DQYdfmjkrvAInhmUhS7QxyQKaSIMi7RG3VvIA8Unn3pOabwVP
	i1sB1ogTdacmzF7rGGHuYZ1rndTt3AZ7VEzcpqQl9iWcyoi4OVm3+YHs49kupw==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: brauner@kernel.org,
	akpm@linux-foundation.org
Cc: chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org,
	djwong@kernel.org,
	hare@suse.de,
	gost.dev@samsung.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	david@fromorbit.com,
	Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	john.g.garry@oracle.com,
	cl@os.amperecomputing.com,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	ryan.roberts@arm.com,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v12 10/10] xfs: enable block size larger than page size support
Date: Thu, 15 Aug 2024 11:08:49 +0200
Message-ID: <20240815090849.972355-11-kernel@pankajraghav.com>
In-Reply-To: <20240815090849.972355-1-kernel@pankajraghav.com>
References: <20240815090849.972355-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Page cache now has the ability to have a minimum order when allocating
a folio which is a prerequisite to add support for block size > page
size.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/libxfs/xfs_ialloc.c |  5 +++++
 fs/xfs/libxfs/xfs_shared.h |  3 +++
 fs/xfs/xfs_icache.c        |  6 ++++--
 fs/xfs/xfs_mount.c         |  1 -
 fs/xfs/xfs_super.c         | 28 ++++++++++++++++++++--------
 include/linux/pagemap.h    | 13 +++++++++++++
 6 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 0af5b7a33d055..1921b689888b8 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -3033,6 +3033,11 @@ xfs_ialloc_setup_geometry(
 		igeo->ialloc_align = mp->m_dalign;
 	else
 		igeo->ialloc_align = 0;
+
+	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
+		igeo->min_folio_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
+	else
+		igeo->min_folio_order = 0;
 }
 
 /* Compute the location of the root directory inode that is laid out by mkfs. */
diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
index 2f7413afbf46c..33b84a3a83ff6 100644
--- a/fs/xfs/libxfs/xfs_shared.h
+++ b/fs/xfs/libxfs/xfs_shared.h
@@ -224,6 +224,9 @@ struct xfs_ino_geometry {
 	/* precomputed value for di_flags2 */
 	uint64_t	new_diflags2;
 
+	/* minimum folio order of a page cache allocation */
+	unsigned int	min_folio_order;
+
 };
 
 #endif /* __XFS_SHARED_H__ */
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index cf629302d48e7..0fcf235e50235 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -88,7 +88,8 @@ xfs_inode_alloc(
 
 	/* VFS doesn't initialise i_mode! */
 	VFS_I(ip)->i_mode = 0;
-	mapping_set_large_folios(VFS_I(ip)->i_mapping);
+	mapping_set_folio_min_order(VFS_I(ip)->i_mapping,
+				    M_IGEO(mp)->min_folio_order);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -325,7 +326,8 @@ xfs_reinit_inode(
 	inode->i_uid = uid;
 	inode->i_gid = gid;
 	inode->i_state = state;
-	mapping_set_large_folios(inode->i_mapping);
+	mapping_set_folio_min_order(inode->i_mapping,
+				    M_IGEO(mp)->min_folio_order);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 3949f720b5354..c6933440f8066 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -134,7 +134,6 @@ xfs_sb_validate_fsb_count(
 {
 	uint64_t		max_bytes;
 
-	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
 
 	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 210481b03fdb4..8cd76a01b543f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1638,16 +1638,28 @@ xfs_fs_fill_super(
 		goto out_free_sb;
 	}
 
-	/*
-	 * Until this is fixed only page-sized or smaller data blocks work.
-	 */
 	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
-		xfs_warn(mp,
-		"File system with blocksize %d bytes. "
-		"Only pagesize (%ld) or less will currently work.",
+		size_t max_folio_size = mapping_max_folio_size_supported();
+
+		if (!xfs_has_crc(mp)) {
+			xfs_warn(mp,
+"V4 Filesystem with blocksize %d bytes. Only pagesize (%ld) or less is supported.",
 				mp->m_sb.sb_blocksize, PAGE_SIZE);
-		error = -ENOSYS;
-		goto out_free_sb;
+			error = -ENOSYS;
+			goto out_free_sb;
+		}
+
+		if (mp->m_sb.sb_blocksize > max_folio_size) {
+			xfs_warn(mp,
+"block size (%u bytes) not supported; Only block size (%ld) or less is supported",
+				mp->m_sb.sb_blocksize, max_folio_size);
+			error = -ENOSYS;
+			goto out_free_sb;
+		}
+
+		xfs_warn(mp,
+"EXPERIMENTAL: V5 Filesystem with Large Block Size (%d bytes) enabled.",
+			mp->m_sb.sb_blocksize);
 	}
 
 	/* Ensure this filesystem fits in the page cache limits */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3a876d6801a90..61a7649d86e57 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -373,6 +373,19 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 #define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
 #define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
 
+/*
+ * mapping_max_folio_size_supported() - Check the max folio size supported
+ *
+ * The filesystem should call this function at mount time if there is a
+ * requirement on the folio mapping size in the page cache.
+ */
+static inline size_t mapping_max_folio_size_supported(void)
+{
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
+	return PAGE_SIZE;
+}
+
 /*
  * mapping_set_folio_order_range() - Set the orders supported by a file.
  * @mapping: The address space of the file.
-- 
2.44.1


