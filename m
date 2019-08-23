Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C7B9ACC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404530AbfHWKLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404383AbfHWKLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555105; x=1598091105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nIhIe5TVptpfqOEOHCwo5F/TfH05pQH7Mpvwi20f3vk=;
  b=GMD3t2mslycXABg5hAEoCK/apNW1rlQC8x/fL9iOsF+QItdX7yVCN6Zv
   i0zFPgsjZX6ZE3sqOk5FjpMM0Sf5x8E6J2Lvii9JHyPa8kNR9K3dBGZxe
   RfzQ/ReT1PdId0cFQumejqM+HIpgn6LYDieedPGP6OYM8UE565TWls5iv
   DrdU4LRRtDXYF4pEq/6AAvXmfQb0BV0ZIcaLfr1TPa7Fy1Tyfq5fpAjFQ
   p3O8HPZFALpbVlAvpr7lEn67/RyXRcggi8Ljang0GgazZQa+a3JBRbsr5
   tYr+hDpVcqjtuuVw9GO6OH/jH0BbOYOFJYP9gDwwO0eyjqXKhabXLZ4LT
   A==;
IronPort-SDR: E5BBdfLHpWnFn/hALdXLcZyXxDqxg4ib7/cAoBqeOMTCgXMJC2NCJNsk90i8cf1ew4lkIRQdQJ
 rq8hcP9IiXRXuB0GHwGGzXkQQdkR2YKdVZ5rdBZ77vHd3B89bhU4SMyQyONJohCMuVpEtSEdtP
 WzV7dKJRIMxiUfIE8F8jJU+L/IwE9b4KA7ZUWpUyCd3C/1ecIuOXAA8ZFfTtSvTLaTPBtrmBd8
 7okWylMGBYxrlvjFyUaOkb9xvnzn26aPLzKGDYq+6IOBbC9UIHqOlAbESy4wJePdngnLAt84jd
 qoo=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096260"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:44 +0800
IronPort-SDR: Z29JGMJqwY9rjYOqlYqSlCOYDNI0x2TmZ+6RP4Vl8xrzDi5CSG/7kp0+FIkZLJjWRmG9D7Vjpx
 7VRPmxFrLd0Ak/y9ZUPgQTcrTttKdv7ClxekB7iLpc28uVlWjTUkts3jhK5KSDdMHq/tSu33pl
 QJQeDmtdz5LUjJT4SNKurCoiPuqHSCeijAXAyfeuoFR3JwX/rJyxLFeZLOttLi+UahQCLrJZiK
 m03372X+hMDhIFvRqxpOlPIkU4Ln/lgOuLtqBT9HWNLWj6m8EQxbKGi1gAbAzb5esn9LKen+Ft
 9YlL5dOOHK/FlHy7cZ0AE1mh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:09:03 -0700
IronPort-SDR: lrAqJUgdHy4bFMwv2PId0PHQcBa203MYa30hbvXm7am1qfYNPzCZSppbPpFh+wEwkEAd3apgsX
 CwWXiniuWIRxRBItFVRLfuKk78ULGB+vYh0mtR6egvInrCfSmchEX1ZM9zXMWwIQ1wZVU7lW77
 paC6aq0CmrxUEgZNyT9faXp+77fviZS9g94BWfVTnxTF2pDhXvnMxtw4lmYLMXK+neFxcnF4Tg
 QJ8b8yVZ8a0MKF/YbDWQyyLJS/6dvKhx8J7zDvw/XCQYLcvpD4PDJl+QTH8fuHz9EdaN6UQJDm
 JLo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:43 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 17/27] btrfs: implement atomic compressed IO submission
Date:   Fri, 23 Aug 2019 19:10:26 +0900
Message-Id: <20190823101036.796932-18-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
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
 fs/btrfs/inode.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d504200c9767..283ac11849b1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -776,13 +776,26 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
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
-			else if (ret)
+
+				btrfs_hmzoned_data_io_unlock_logical(fs_info,
+								     logical);
+			} else if (ret)
 				unlock_page(async_chunk->locked_page);
 			kfree(async_extent);
 			cond_resched();
@@ -883,6 +896,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			free_async_extent_pages(async_extent);
 		}
 		alloc_hint = ins.objectid + ins.offset;
+		btrfs_hmzoned_data_io_unlock_logical(fs_info, ins.objectid);
 		kfree(async_extent);
 		cond_resched();
 	}
@@ -890,6 +904,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 out_free_reserve:
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
+	btrfs_hmzoned_data_io_unlock_logical(fs_info, ins.objectid);
 out_free:
 	extent_clear_unlock_delalloc(inode, async_extent->start,
 				     async_extent->start +
-- 
2.23.0

