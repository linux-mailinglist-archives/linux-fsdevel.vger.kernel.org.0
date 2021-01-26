Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66266304928
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbhAZFaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:14 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33029 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbhAZCnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611629026; x=1643165026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C0suuqAEVuTZh016N5UsV5kbXaTibBUMf8NpAAdpB+4=;
  b=GfL5R5VZbQgVLUfel0coI776Agkmh83RuAsD3LyD5pFwOaXRhS5M5Atj
   8bMrva5zCpnyf8CK03V7yigOW1DnJR2gNSjG56VGuk5/9PysTkl562+M5
   7Nuyy6j8zykHzW2vqShflDP1d/cro/X3RYGd3066iuw3JIVVhaU/ThVTx
   wNrjL0Et8SsPYlEKCamNto/P8c8RNrdbPvPdGOJMRiLXceATFVUO4njUf
   Luq5Ha52ZcHoTaqhu3xq6JNHxczI5RA7umam3QSPsrqDDe+09jV8wzzjA
   QL9UKqjXjEzx2WMJSf9tHmvKo1ZmaOgEjVdYDHeSa+Fdnte3hMFlFlZoM
   A==;
IronPort-SDR: CJg4h21QotRwrGk0Gmyled2KlSoZ6k/JfzY09+IgVyuGFrl323PTRP8diymKc2ysAFs8rMYlQs
 kbtpXRTALJ9FeUYKlqmoHRIJwSs69pKyAKtBHu07mqwIGK67ny3LgSPpSOArIArwqc8o4rZN2R
 WqapL1Go4ijZcr4dDN/9tV+hBLMh0gaSoW9YhH+7idldcgEb9HvBE1YnvyyXDsFQJ57KhSNo8m
 EMD7NQqhtR2jzw9WLa+WpOurOUJxmxxhSpN0f3+uf+aMRrSmfDlPv+DysBUmyQdaOLZr4S1tyL
 A1U=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483579"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:27:03 +0800
IronPort-SDR: 4IB4sbkDwzxvDEnAF3RX/nBs7YGb7uw3G3OmHCQhCudLjB3+ODncysprJunrECg2xoAZnL/lY0
 a0mrdCAhYwSuvp6MrmHmacEFAkNs391iZMDoMJuwSTB/tp/GJKqdxoCgaCSdo0KtDEz17Urpek
 OV7jtvy16ZQDJ5b7cVsLE8AMLPA0ZbrlSq9vGfun57JJjn4ig6o9UbJb1nOPqd/yXI9x3xxuoY
 cCGu5+Q1BsKKo3LpfIlzhTaNQJkMulDmYJmIi1gM4sxBK/5HJVgjdjlXVb/K+eSAxoQhODrfO+
 l9O8nF9hd1QBjJVFilV2pCYr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:29 -0800
IronPort-SDR: H6Yh3Y8QZ+9NSoYYX9swPOhQztTg7fFwKzsLatvHv5V0qqcCk1d7zR4mIdyQ6X7xTo0UQXKXYM
 L2nBqp9BkeoSoxiSmsYPo9jmCZUbAwh/BEHlEkAex2AiAL0+2YoPFAYIXrN+xeMfoWgEhilnI5
 Mg4hTEgKBEpBFq676VFZ9/cwyznzNiqAxk1TcngM9yiUxgAcAAygpQfcJmlBtXUyk7dDH0XL1V
 jLwuvpT8JbEP3y4Vv2hpAk4y9CVabOLJiFKj4l5Jcq4Deyf8Kvvp+aX85vfyl39dl9KcZFi7U5
 xTg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:27:00 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 37/42] btrfs: enable relocation in ZONED mode
Date:   Tue, 26 Jan 2021 11:25:15 +0900
Message-Id: <54d1e6732ba8f867e6dbbc8c26b38eb1006e405f.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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

