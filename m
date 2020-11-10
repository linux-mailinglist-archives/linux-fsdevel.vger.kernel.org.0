Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706952AD52B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbgKJL37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:59 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12030 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731949AbgKJL3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007773; x=1636543773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xPo3kn4hqbPhdopEoZslI7bCsYHDqKdsh6NiaL+hT/k=;
  b=Fbvy5F44p2j8djaNWVpA14Fnqrv8IIVUXNLWV0rGSaFrKnEwMjUu1NUE
   Upxz1TV1YV6bq93SWiSz1lcWAaZrKAT5Sme4JlsPltQ5vC962sr6uvKlu
   rbhXHiGm/1UnYuEQzmsxG4r17IZAvOv6muoarSxUYCu4jEe1Nf9PXAkpN
   d4ZEufMoFaRQbybvTYg/sNg3vF74baTgohkIT6E3pDbs8j8cpMk0vFDrX
   bV2RjYuTij0lT0/kULo/GS0xUBZ0cOoL64hW2wbKPzvm4eHkkO5HMpZhe
   vla77ebu6pZIuNdB7W42K6z3XakATsonWVkTlBxhp8In4hBynfGhoZ2gO
   w==;
IronPort-SDR: prtFNrOroBWfQgnbyhyvK44LhKZ0+azoSFG0j+SpEyq1Qj8Qz5I7Svfx7hceAdOviAsgVgo2RD
 DF6KAKmAUbpptY1Pmw1rKqza4DKztiGpIhmzYmYUuuEylp2C6Naw4uyXbkAcQdHtOLMDvQVEtA
 xn9sAnn9qAr//JSPmBD5TkEdfOGEAT94/zBOhrB3NbLM2PX4J22JAqnkmIbJLoHQrbRoCs4ld1
 yyGXKLvySqG2O4hmQT4eP5suiC9pU2RspNGYUc6m6hIiTJNRwgOWBgjXXiW9CX2nUSsuG10oE9
 w5w=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376702"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:29:02 +0800
IronPort-SDR: QVRIzgynM0JKBZ+IISXadLUg4YGfp6NLY0R72NQ7t9Ktd2seZqrgMqXDq4Pew4An478QjbNPeQ
 e30a8fypMSpQ6N5+YwdA5MCLWH8Ps9sQ+L7GIaWHhnAheF8yVtfy1ootQTVnHbIZYpj7jOOny+
 JmVZq5Ahb+V0+FxyCs5pbmeaCXdlymZj8hwgbhgzmMIdCwgehAGLD24z6FIzkV+9yHAqxohjqP
 VDPVlpjfZTDE+s+Tcbhnon8yFbkx6wUt4/I4CXs6d0zJdUUfQX/1h8+c/MkLyDuHeSa8ffmRi4
 ptO0DZYOoc7cVGabKrKVi2PT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:15:03 -0800
IronPort-SDR: xCUn3TgKaZpbTWVpqHx1y9KD3atEPSQKEdzCsa4GAHeYTu9hXnTGhMryX4ayGpDDWaOPd4tJWB
 ECxT0E4T6cePPsMY8j0oYep/dsWs8/uUdzgJw+aNSsgV1L85b9eQoVu5GDbC3Ld1LV9n+SSjro
 hGt+ZhxCksk25cDb0/08Zn9pvY3Vy31ZA2PDGtgVMytyZTzonbx4HRtjF8BSCo0t0UShD745UB
 bw826yEAC7+D9i9JeKaKpxCg5xWlrlJQAjANSlXmvWfwViXPuR/0hTsgbP6s5aX1OHvqehCNr0
 MFE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:29:01 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 35/41] btrfs: enable relocation in ZONED mode
Date:   Tue, 10 Nov 2020 20:26:38 +0900
Message-Id: <34c21befbcb421bc93d3350a027ced670f568c90.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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

