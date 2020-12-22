Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D1C2E0526
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgLVDzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:55:37 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46466 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgLVDzg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609336; x=1640145336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ck+h504WIFiv+j2i047DwHY8LAOv/31ulyKIT557WPs=;
  b=K+GkGq6+IptDpr1ZKAUJahXXG/JqnuSDxEzqtwmbtEzOzC6iuCGvwcNl
   EKWjwugkYW1VZx7j2d9e7tCq5K7LWu3H8oX2QFQP/psPeXL6cOlJwAwz5
   TvACFU8ODcGr+apZki4TmPa8J+8HbwkJXjYLwxpVy4/8cjqnZb6yVljNJ
   T+Gx5Z6bkSoVVKHzVaT80U1y+T53SwwV9zOwPQfpL2tg2g+lYo9DzWMFx
   jZodosHO/B/UPD6M3GCBvr3vRHmgAhoTGvm1zPrTwknSizLZqA5jSShLo
   AkvIN0XmyGU3FCga8K1oY63NggPWN2fe2PeeQfYN/SK4sUaz5CT8gVP9g
   Q==;
IronPort-SDR: IeQYJZUJ8WUFSCQSgl92CViCRw0k4nlQnECtqsuTRPJBitcnKsdwKpMeURbBksufjUpo+nHjz3
 co/Bi/wxbzvB0yeuXmRUDjF02+5beaoU9YqypnFu+vccyEZyJJ4bw0iXEsztvItSCum+4yY5cN
 zYOCTkAphRNpe6sqyGiUPMhSfXERV9c4luacs/l3OHPEkt4EbLaBTUhT0rLc81+TqF6f/jW9N8
 lKqCKzdLAo20uyixrZmtegd+wZ8q1Bo7xJxjti+s5QVTofMCqNLEFJba/Bx9OMsZlFFMz5XdzP
 lOE=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193864"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:20 +0800
IronPort-SDR: 7sQzYoVMtWqh5JXDxWAkIiV5TOT/1FePNTWZ7irwa4SU9o002iXWoZ8p2O+ZR5ElzRwrg+YiSB
 YLa6kG0oGtaEBwlwwgJFrF5RTD6+QzHSFuYBk7dNUPJt4Ogn/7w0W6dCHP5JmeujUWZd/xAZ5m
 LR+/Br4DU84VidL5ymFEAccsNYIs2cpb9sDITdn+85A2+Hrk28km0dIiFlOD0jnW53uQLXepBJ
 bDi2mYYL5ocKYxh6V3ToGObBQlDKcHZKNsbCWw8tLe8UMxX1BXv+SwHJDOlyVZ4KDLg34zdzJq
 EsPm+S1hkZeTTCx2KNiNNmcf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:31 -0800
IronPort-SDR: YyoqLIbBzQ6y7NR0soKUB9wyG7SBK0q/nlMb2mmpbyAJ2EDPF3wL2rw60WLUqVs4wUytA5lAum
 PUlrlLcuqPhjeqLulElQ/CTKc7iR8XR+9F/wJV7aa48lNDK8ZrBphySlAHuT37xjDJgcmXIDkH
 KxGPRnZTInayYoe19TWIR8uOQuC+PdVHl+gKkvhlqTUFgt4hIkLMHP7ENTXspyFhSWAUilpKWy
 Cf9gvUxHLQOEgCVcbOWNTQXJUdhN2Rkvztp/385pSPZDMN7EWlLqus3Fb5VbdUpL66q17WM985
 Nq8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:19 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 35/40] btrfs: enable relocation in ZONED mode
Date:   Tue, 22 Dec 2020 12:49:28 +0900
Message-Id: <b0c32d2a62cd3e61c605a2eee0ad706929a1e3a8.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
index 30a80669647f..94c72bea6a43 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2553,6 +2553,32 @@ static noinline_for_stack int prealloc_file_extent_cluster(
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
@@ -2749,6 +2775,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		}
 	}
 	WARN_ON(nr != cluster->nr);
+	if (btrfs_is_zoned(fs_info) && !ret)
+		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
 out:
 	kfree(ra);
 	return ret;
@@ -3384,8 +3412,12 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
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
@@ -3400,8 +3432,7 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
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

