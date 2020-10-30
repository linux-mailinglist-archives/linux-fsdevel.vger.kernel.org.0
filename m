Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE9E2A0712
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgJ3Nxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21997 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgJ3NxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065988; x=1635601988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xPo3kn4hqbPhdopEoZslI7bCsYHDqKdsh6NiaL+hT/k=;
  b=qg3UPafWlOpyXbrubQWVvXGqDxXklTZR0dYlLKv9m3jLFIwlDFaOyT/O
   pu82BK5X6OsFi2rXngE18YncaU/iAsx58ZrPE8NOEDRML1JH+cYmf51/L
   41ClH9zJxHrT5CSlO1/y5JdMB2aoOlHfGuXqixfVBClaZUQfvuqi9bSIM
   71qefGUr9RMTdT2TWTXy4+3M5AatRM/IT/FSc0YYPZDBSKpfPbM2rCh3j
   CZxs68+vyC/JC5GoS55gMCzTe+HRm4Mce7Jm5/jv2U9QyUvKs9YPb1lz0
   Ms30MbTqD/RMhLsJuuRid/Wf3J3TLAzew9W6bkeZVAET7C7i6Ax3WTQV5
   Q==;
IronPort-SDR: odw2HDIUwn3e2qIAuOicPotaNQ876PithUblVKQVQ1UDI3pCCnOhxNmtyo13dXa5RPokZZ63aj
 yeT9YER/9HzRb58fYwDEIMAlk7kx65gYEtN2kv+P8XdAVZGgWxZQ7nD7ILNnxU7zJO/2DLFQue
 +n2cCt27/pSGdkyKbqwayjN7jTNT3v0cSSDKhOsJWk/zAeHBlGJC1y5CZ5z84rpfeUmjZpbF3k
 1d5cFpAAqYq5dlSf6NOJ1Cp92jwZ6Va8r/qGp8ghWfEL5q6bKFu1JeDCvVEurvMkZxAwqESQoa
 dGQ=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806640"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:53:04 +0800
IronPort-SDR: x78Lb1LCRpY0KqumMjahb427At76E9O83X3wMf6eZiAgk2RGVk3tyL8kEq4vrdgf+HLwYLgQml
 SMqoB8LUAq7vy960GQUrDmPZv5tAn8Qw8lBi0lHzcxUCHntezdaaJnH+5TTdZwAupSapNq85gA
 N20JTRoSINOrUhGqivag7scCB9a9rF5s9TMAHv/V3bhwQ0DZTU6rbMZjZ3RkIt6rlx7SGKxHbr
 vVIQxrX4on5ilg7IzXuKibR1A6Oz7W16cFlA+ZaXSOXgDNGPCgjmgRxl9mRQhBteqTCUXA0mhz
 12K1ulwsS6Fk45PgxFq28AVU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:18 -0700
IronPort-SDR: ppR0aDkHzeebcsAie91uo4tnMYCfzGcKfNyYyKB5eZBeL61GOwUsAaq6EydVOurGhPRbKYXiaY
 A4KLbcTFk38kuDW1NEBfqYhMMC4XrmPrBjOHNEF+DkBG8f65mozplvyQlJFa+WCE2QClKlAKZp
 jzJA4sJ/WdnA1FG2fEWicP2Z5GUDj+MDcNyVCyp2+dkDyurnZVmZY4WAlk6fEcevJTIKgdaX17
 OLwmMjJyVLNftFLmkUSu9SOW/sSEQJ3xyrbWCSHyXkZELA4jLr8OrsiTLoKXylMw8j4AXHyGHk
 NQg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:53:03 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 35/41] btrfs: enable relocation in ZONED mode
Date:   Fri, 30 Oct 2020 22:51:42 +0900
Message-Id: <669d00d499b702413a51364b405280798df9c6c3.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3602806d71bd..44b697b881b6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2603,6 +2603,32 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 	if (ret)
 		return ret;
 
+	/*
+	 * In ZONED mode, we cannot preallocate the file region. Instead, we
+	 * dirty and fiemap_write the region.
+	 */
+
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
+		ret = btrfs_update_inode(trans, root, &inode->vfs_inode);
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
@@ -2799,6 +2825,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		}
 	}
 	WARN_ON(nr != cluster->nr);
+	if (btrfs_is_zoned(fs_info) && !ret)
+		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
 out:
 	kfree(ra);
 	return ret;
@@ -3434,8 +3462,12 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
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
@@ -3450,8 +3482,7 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
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

