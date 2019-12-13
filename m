Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 255A311DCE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfLMELP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:15 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11918 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731971AbfLMELN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210274; x=1607746274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=48fi9iWuTJ5hUDEI3q4s9C6bEGLUNolZCKfPx156Xxk=;
  b=oo3qwKTKsxRO56wCBQncvBIqjla9jBXXwKAwSvAyq1yuUSuktBcQm6KG
   cUa0kLify7YlqBkgymSbNsf5Wh8ZT5vXA5Ay1rP4oDZ2evKnB4QCLA8Qc
   VWLQZ7LiNr2LsRrQhjUc194uOmm52A9rG6pwZjTYGthxHVLXbl6vLu8fX
   9SsmXBjLRCqWpn54yaWbL9ce18C/DtjOZ6vZ7IDOLyAOC9gklyoAECDay
   4z5ZUCaZ1U4D82bPw0WMoA327AQyK4xLCiY7yTBfUX7vI2qCsvsKph6jP
   qSmJr48eb4ApWhMq0k1SunLsNaS7P023hss8ueU/OXAUGYVHzjU/y5FH5
   g==;
IronPort-SDR: J4tKul2ZXnGsmHzlOPwAMKL2mTQIN/GtrTfEq23R5akeo9+95K3BEbsdZWtCOmIZo9w5QH8rZz
 25c9tb01QFaXFFyFIRIAWUM4CpRKpRiYLy6m5OMo/eEycncjNZtvbuPx7Uowp+O5vtYQHZrhkb
 tjohd9PkrNxd6i4KTwhiU7JUGTS+/tvLvGhL+1Aoo+2dHhIFyqvnuxXizxdk+lBUozVJ5mH7+P
 8mwusG0QauIQBetKswa/OgR5P9etZ4AgpDCeKFUVMHuS+0FlKfUbjOv5XTcdcMRxVWtqqFeAkB
 j4w=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860144"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:14 +0800
IronPort-SDR: fvf3cQgb5GxZfQpNx59pYz0bM7PqDZFhuKiXzxo8fdfCIehy33ykL56Fhz/k2YCYs8mzAjDdjV
 BPfvGmFxKaiOcRH5Jxu5/sySOuvraaCVVDtsEdRCkMphgR9XELo+KTwF6hqZzSdPNWf+HOyOSJ
 Jr5DMEPLFX+uxRgC//u/09s/Pj7ZAIrCGmcXX+Sb8kjRJT6ZgjYT2YDhFuT6QDG5ngqkZMzA0V
 M7hNsZXTQ573TwnFwW7cBIvQk7LAGzEgJN7BmtY7pR/3LYZ9l3hCxd9Ug4NrAaVniY0OhdUu+B
 FD4KtYUr/paIiswP4tjhecA2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:45 -0800
IronPort-SDR: 5LnL+4hVnOklwCOqCGNFa4OmPj9F26Xg2LYSNDBLR+CLgugDiYzpy1PJfvaQCMHYhooiY78QxN
 fJrQvESLNFcHJaIVu9FFNZuK2Q/5eckzCApn4YO6yLo9WRLwbyp98rxAFMOGMv8w7KEMn/uw9p
 dOpe3QoR70u6VPugaZ7CkRTxNKO5aUVxS8FFEKHBlWMIaE+MP8PElqmpeqTDPL5stvPnOQnIrN
 nJt8EhY/FYSbzTYzxOuePMZWorwCtBzGYdsKrYF7RQrEcOMKa25bJC6YHqEPgbBQPrWLN1GFRb
 7/4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:11 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 16/28] btrfs: implement atomic compressed IO submission
Date:   Fri, 13 Dec 2019 13:09:03 +0900
Message-Id: <20191213040915.3502922-17-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As same as with non-compressed IO submission, we must unlock a block group
for the next allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3677c36999d8..e09089e24a8f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -793,13 +793,25 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			 * and IO for us.  Otherwise, we need to submit
 			 * all those pages down to the drive.
 			 */
-			if (!page_started && !ret)
+			if (!page_started && !ret) {
+				struct extent_map *em;
+				u64 logical;
+
+				em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
+						      async_extent->start,
+						      async_extent->ram_size,
+						      0);
+				logical = em->block_start;
+				free_extent_map(em);
+
 				extent_write_locked_range(inode,
 						  async_extent->start,
 						  async_extent->start +
 						  async_extent->ram_size - 1,
 						  WB_SYNC_ALL);
-			else if (ret && async_chunk->locked_page)
+				btrfs_hmzoned_data_io_unlock_logical(fs_info,
+								     logical);
+			} else if (ret && async_chunk->locked_page)
 				unlock_page(async_chunk->locked_page);
 			kfree(async_extent);
 			cond_resched();
@@ -899,6 +911,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			free_async_extent_pages(async_extent);
 		}
 		alloc_hint = ins.objectid + ins.offset;
+		btrfs_hmzoned_data_io_unlock_logical(fs_info, ins.objectid);
 		kfree(async_extent);
 		cond_resched();
 	}
@@ -906,6 +919,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 out_free_reserve:
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
+	btrfs_hmzoned_data_io_unlock_logical(fs_info, ins.objectid);
 out_free:
 	extent_clear_unlock_delalloc(inode, async_extent->start,
 				     async_extent->start +
-- 
2.24.0

