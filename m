Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82282FFCCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbhAVGaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:30:14 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51034 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbhAVG3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296951; x=1642832951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C0suuqAEVuTZh016N5UsV5kbXaTibBUMf8NpAAdpB+4=;
  b=rz9wJBAsCRf37AbqVk2x7PsqRJRjzJVJzwHxDmwoZGauRQoKPQLmo9Aj
   XG1h6Xni1b/nPz8t7bcmksVn9NrG5OEYQs+55YYT8A8MjdcYXAmbpEz9y
   uwYkrtCbHbmHPskwekJvCg6Bq+CcUqNW31Kf5uQ2s4gON5lXSFHuASi0f
   NKqEGiQYC8T4Y0x8dUfyA1lTHh0mDw2tbixEQEzxsJxIkLhd1rC9vXXRx
   IIlifBYC0wpeVtAfVGOisg+itzXXeLbjN1dtbu1lUHJJrYe+9iBY5Y1sc
   xg7cHVU5K0cJs3KD/IuNwdEs19hpeT9dlsn4Q2JGyuxlTMFFRBhEzda5i
   w==;
IronPort-SDR: lp4XoL4fAto9lKPuoXAsValU0lTtSHav13JYv7j04PzF1BsVuKr/13B1BWfnn9kgIxPzbiSrHf
 M7KncdJwJ0vq6XkYNc3qXC9R/72M3aEROTS0d8FIBhszoeD7K2AD/mpRua5APlFgpTlkke82kT
 HokEITRuY8Uj3NxrrBkiVwMvBz4SJCX/Pl+n8ouXVZYo+PNI4FRZePYOSwUaMZBNIuMhKGVilK
 IWCOwrqmjUhdRBstbQ+hp47pTKEFkGquiYdhGbU/te/aA0yDdvEfqC8wnIJMcKTFoGbwpXgALj
 DDE=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392081"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:22 +0800
IronPort-SDR: uQvdYoTVCZDkz5nOsbidNS28bznti3h6AfGRNuZ/f/vsy6faa2gGvaP1KcxHyzNgrFeDiHQtZ6
 8WxIQPVJ9iYY3CbOrkI5BCJluP5JWIadf136FFfjG+OljwPoV1//3shOUmSrokchk4IvcwL0zZ
 a5zaNnQWErsi9BZNwhZBQIYlKvLmuQmWYUadfE4GYev7GS5mrC992/C9O6iCykgw905CBq2nMi
 VoUcSiqmrxtAPOAJR3Mo9x95zjqq5HVYxf4HYR0cg0cGAGQhB0Ixi8hYQCH8bpI6qdqmrCv4WM
 AGNCNylFI6MxSIxXIQTe9/Mj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:54 -0800
IronPort-SDR: eVwryliSKZSxWvTim7ym3y745wvJpHaft1dsrR4Q/z665mbMivbs3rumJDtx25DctojBV8u9w4
 7hGLZkByuJ3+IX2ZLH72IJDHPli/62GwLcd9OJkysFH/Ot8dKhvkrvH8PXQkwq2T/wONmlIyWi
 jMx39EdqhVX+FAP1n+TA9aT+W+oRwM83qN34yIdi4SUst0V/D+tErxf6Ht4YyhKHZWIK+JRa3f
 zYvsikkeL1Lc3AX60lQFezzSbrF/OXraRCz5hWrZo1BIAKyrtyUcj4pNH6YhqiJk2Oqf0t5CDy
 9jU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:21 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 37/42] btrfs: enable relocation in ZONED mode
Date:   Fri, 22 Jan 2021 15:21:37 +0900
Message-Id: <7186d9b29e59a1658a55e7bc6a1998c89097754e.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To serialize allocation and submit_bio, we introduced mutex around them. As
a result, preallocation must be completely disabled to avoid a deadlock.

Since current relocation process relies on preallocation to move file data
extents, it must be handled in another way. In ZONED mode, we just truncate
the inode to the size that we wanted to pre-allocate. Then, we flush dirty
pages on the file before finishing relocation process.
run_delalloc_zoned() will handle all the allocation and submit IOs to the
underlying layers.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9f2289bcdde6..702986b83f6c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2555,6 +2555,31 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 	if (ret)
 		return ret;
 
+	/*
+	 * In ZONED mode, we cannot preallocate the file region. Instead, we
+	 * dirty and fiemap_write the region.
+	 */
+	if (btrfs_is_zoned(inode->root->fs_info)) {
+		struct btrfs_root *root = inode->root;
+		struct btrfs_trans_handle *trans;
+
+		end = cluster->end - offset + 1;
+		trans = btrfs_start_transaction(root, 1);
+		if (IS_ERR(trans))
+			return PTR_ERR(trans);
+
+		inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
+		i_size_write(&inode->vfs_inode, end);
+		ret = btrfs_update_inode(trans, root, inode);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			btrfs_end_transaction(trans);
+			return ret;
+		}
+
+		return btrfs_end_transaction(trans);
+	}
+
 	inode_lock(&inode->vfs_inode);
 	for (nr = 0; nr < cluster->nr; nr++) {
 		start = cluster->boundary[nr] - offset;
@@ -2751,6 +2776,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		}
 	}
 	WARN_ON(nr != cluster->nr);
+	if (btrfs_is_zoned(fs_info) && !ret)
+		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
 out:
 	kfree(ra);
 	return ret;
@@ -3429,8 +3456,12 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct btrfs_inode_item *item;
 	struct extent_buffer *leaf;
+	u64 flags = BTRFS_INODE_NOCOMPRESS | BTRFS_INODE_PREALLOC;
 	int ret;
 
+	if (btrfs_is_zoned(trans->fs_info))
+		flags &= ~BTRFS_INODE_PREALLOC;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -3445,8 +3476,7 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	btrfs_set_inode_generation(leaf, item, 1);
 	btrfs_set_inode_size(leaf, item, 0);
 	btrfs_set_inode_mode(leaf, item, S_IFREG | 0600);
-	btrfs_set_inode_flags(leaf, item, BTRFS_INODE_NOCOMPRESS |
-					  BTRFS_INODE_PREALLOC);
+	btrfs_set_inode_flags(leaf, item, flags);
 	btrfs_mark_buffer_dirty(leaf);
 out:
 	btrfs_free_path(path);
-- 
2.27.0

