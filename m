Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D88711DCFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbfLMELd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:33 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11924 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbfLMELc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210293; x=1607746293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xc6PNKHNLMT6cFXODCW5lJKtVCDGPT+JT7Ud3tXcFaQ=;
  b=PMTPzfOqgxHSbMyNBOx6eQgM+MQmsjutgsNBCHDXb5pNdvJmStdWoOa9
   fT9m5J+vGZ4aKDUUBKozNI1QR51BgpSjMlo8Gr+o7GmYp/m4Q8ypoUmVR
   Fx5kgrssQbweJI9wHlCEFtN96oqCfRtZqnZ7fJMl/8jEhIxMrdHNyL074
   DrY/WMaAD0UUccCehoLEN6HUbKRxeSQ7fE8aUwPO2KHoSZNo/6xi3T3If
   H6QhzGchcK6PEuDCHjKb+IlFut82bQW3U8vU/r/LzHJgsiZ484uFNkMXn
   CgO2F1jryjGu1KI1jWqDqGZZjFeFuD5SaF4fjfxqbUrodJoOriu1VfnKw
   Q==;
IronPort-SDR: TFG+6NVR8kjFcdCKh8CuICgK/Ksi4UjKKuW9gedn2dTvP4wV7HathYmwRfM7L2RmyjUwj/xBVT
 AYpdyVsTQ18IGtNhxbOto58LwS6jXl91kVNnNVYIyxkHtqodWhzfqTEAlq5/Fu8fMtb3esHkTA
 mLcS1BM8EBoY5MAYxx/2G1YBvYoheA7ddOou8Ot7pj982WW2i0UV1DF3tFnM4xcmEsMIUBzdzR
 +YR72OyC7MRXwEhRTnVnxWQ/acKT1NT/c4bFKxFoDYooDjVidKDPp5pXclR74JvdmvNi2jDiWn
 XPg=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860167"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:32 +0800
IronPort-SDR: Vt706ZYGV/0Em+pav4zJiCxDKTD9PIdwYt3vUu3LoFpE6INc2H6nxSysfxNePglC5viNeGsPpa
 li1mKbifePoJvIad9sbIeX+Oqgx8xbJnV+c2U7BMjK4ICthL/qmu22orkEeQ9hrz+UUZ75gyOn
 t+OfGAMN+UV/05FQoF1XNtA5oyMSdbDaIzYjpEtn/51TLN+8Co4e5ppkXMNNsM1jl2GLptTVE4
 hpqfcO80yLGu4AXO5U97bbiW7rflJD8UgJJ6rvYBYeBlUcM2GItMFMQD5ylqo7yF21k78T2JHd
 jIaDfarjQEVcUyduI1dCx6lC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:06:04 -0800
IronPort-SDR: xKp/Jg/HyGLx4nXCfMW4tEnQm8VnOtX/l/SQZeml8ASwLX9qqKknqWEIYsTsxTSWwYCRzIX/zt
 xHSz1FeGwLrMrSa3p0/xgDdJbbvFukPAgPYme6fJUAJ0iEvillGoa1oHRPh3QAysqaN+W8EwrK
 lHY32oZhLme4hDsKPVkrJhGftANUbVkjMfCc5X/c2JPh3CkJYXVVfAYRBHwuzas4JldEeNnAVU
 DAJsIXFnl4Tb7DGJv+em3EX/6904Ogrp1kupUkSIR8ZhVMX3d6th/j5PgeoJqyseB2pzCuz6IH
 sQ0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:30 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 24/28] btrfs: enable relocation in HMZONED mode
Date:   Fri, 13 Dec 2019 13:09:11 +0900
Message-Id: <20191213040915.3502922-25-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To serialize allocation and submit_bio, we introduced mutex around them. As
a result, preallocation must be completely disabled to avoid a deadlock.

Since current relocation process relies on preallocation to move file data
extents, it must be handled in another way. In HMZONED mode, we just
truncate the inode to the size that we wanted to pre-allocate. Then, we
flush dirty pages on the file before finishing relocation process.
run_delalloc_hmzoned() will handle all the allocation and submit IOs to
the underlying layers.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d897a8e5e430..2d17b7566df4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3159,6 +3159,34 @@ int prealloc_file_extent_cluster(struct inode *inode,
 	if (ret)
 		goto out;
 
+	/*
+	 * In HMZONED, we cannot preallocate the file region. Instead,
+	 * we dirty and fiemap_write the region.
+	 */
+
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED)) {
+		struct btrfs_root *root = BTRFS_I(inode)->root;
+		struct btrfs_trans_handle *trans;
+
+		end = cluster->end - offset + 1;
+		trans = btrfs_start_transaction(root, 1);
+		if (IS_ERR(trans))
+			return PTR_ERR(trans);
+
+		inode->i_ctime = current_time(inode);
+		i_size_write(inode, end);
+		btrfs_ordered_update_i_size(inode, end, NULL);
+		ret = btrfs_update_inode(trans, root, inode);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			btrfs_end_transaction(trans);
+			return ret;
+		}
+		ret = btrfs_end_transaction(trans);
+
+		goto out;
+	}
+
 	cur_offset = prealloc_start;
 	while (nr < cluster->nr) {
 		start = cluster->boundary[nr] - offset;
@@ -3346,6 +3374,10 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		btrfs_throttle(fs_info);
 	}
 	WARN_ON(nr != cluster->nr);
+	if (btrfs_fs_incompat(fs_info, HMZONED) && !ret) {
+		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
+		WARN_ON(ret);
+	}
 out:
 	kfree(ra);
 	return ret;
@@ -4186,8 +4218,12 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct btrfs_inode_item *item;
 	struct extent_buffer *leaf;
+	u64 flags = BTRFS_INODE_NOCOMPRESS | BTRFS_INODE_PREALLOC;
 	int ret;
 
+	if (btrfs_fs_incompat(trans->fs_info, HMZONED))
+		flags &= ~BTRFS_INODE_PREALLOC;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -4202,8 +4238,7 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
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
2.24.0

