Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1933730F0E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhBDKcw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:32:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54218 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbhBDKbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434664; x=1643970664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eKn5s655mQV80Mh5yVdiqf2y3e6s1hG0pl3u2SlJQcM=;
  b=W3skXC+P9z1UVyY8Q3LHKK0vdB4FL6wmY9KrCqE27tdspckaR2ZdafKK
   dOHfbDzM1LXx5YXP/KohTzu0LVkuQ+jC8P+1o3O45A4V602wrUalk1Ofi
   btc+/2fYEaF11KOMwVTyAKzMmFwJXtzvfpaiYQgKUbPhUMJqJBrt6/320
   8he1kgn+ReCBZjlj2qQQLE5yChToZ8c1rva6KhYK3glsZsO60TwwsZ0vk
   t+GQWuBqXca9WpvHTPpAz+z7rcbdSHAkJvD2+DK6/m/9bfQ1xnG2SSN6y
   nytxzKFWmXMu0NUGQo6jTHpzhC41M/Ujmk23BaPnbqu2glDIQIwnfxkOI
   A==;
IronPort-SDR: A7CaCtQs74Oh8s0gnfzNYRUZo0r0Nvzqrh6i064fOV00vWh8/KqROBCwr9jnkry+lsPudz7qcd
 sfJmX5vM9GqSn5j1jsiiYbxESslmeaDepRTunck4ET30Or2CTssDYYbqJMKxwGouAdcOSn2KuM
 J5f6UbujoNn+py9HWKzHDEK0OGfo8zXJtDduXphQg8inkbEtInkCCaDpuu2qbYYUBY3cDbl4K3
 fYxIC6C4PJg3Zu5Xvj3Cc6AEKSu41X5JgG/3rbAtjytGY6dDnkSkj2sM/d/AyJyO0J16/Qp3HX
 pFA=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108063"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:45 +0800
IronPort-SDR: Gwm9XgdPJmCN8s8sRK0HwD1JCWunMRtT4dw0hHdGk/OOd8U1NIHkLKATF16d+jeG+6+LWOkLZf
 ICYmEIAV6r6a4iBJtfbzTh9iPCUls+Fm+u1Znkc3JmtW+aJVnzaSuhw/srFGs5CsU/3vHKfOgC
 /0Mrm6M8F9Xu5X+UUKz4ZllqSwUFEmd31h31E1cNYg7gtjHEr+MuJP2FMqlKUB2wbCy6YOXMlc
 q9e++9GSAanDzYy1aMUF1sX8nsksKXVt6datKQnukS3dXlrkGNPqq6JqDUhay8S+5GGeK2BO93
 YT2I0c8oGIKuD9nq89Aim/ZX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:48 -0800
IronPort-SDR: 3WmhTBoeX0W/V4mfuIA9YVYkn3Aj8/46rSzugfONNG6JZsOWrA3IFzRl5SoOVtQId1tp3N8ZSM
 E5PHouyGitwaqtvulEJzVUiEKuYUjn4U5RZ9CBX53RBpjSjIhZ3QQ9SfG+P0Imm7Mgz6/wi+DE
 PkHSGpf9qLYvhUmasIMvNwNQCT9QJ2OL+NHXS+xtLDCA/SGn3y9pqSRVlyNF0h4ZZbQY1xsnyd
 sZNZPTrAmTPtM9ADtSPiemHTV6CQUqb59nbbGBxZvlkS0fLFfIUe2vYMVVDYjyvWPtAO0zvfvg
 /Bw=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:44 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 36/42] btrfs: zoned: enable relocation on a zoned filesystem
Date:   Thu,  4 Feb 2021 19:22:15 +0900
Message-Id: <a1648f09fca54c60fabc2cc9a76cf10d3147a809.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently fallocate() is disabled on a zoned filesystem. Since current
relocation process relies on preallocation to move file data extents, it
must be handled differently.

On a zoned filesystem, we just truncate the inode to the size that we
wanted to pre-allocate. Then, we flush dirty pages on the file before
finishing the relocation process. run_delalloc_zoned() will handle all the
allocations and submit IOs to the underlying layers.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 473b78874844..232d5da7b7be 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2553,6 +2553,31 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 	if (ret)
 		return ret;
 
+	/*
+	 * On a zoned filesystem, we cannot preallocate the file region.
+	 * Instead, we dirty and fiemap_write the region.
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
@@ -2756,6 +2781,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		}
 	}
 	WARN_ON(nr != cluster->nr);
+	if (btrfs_is_zoned(fs_info) && !ret)
+		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
 out:
 	kfree(ra);
 	return ret;
@@ -3434,8 +3461,12 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
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
@@ -3450,8 +3481,7 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
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
2.30.0

