Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1185E6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfHHJbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59666 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732176AbfHHJbq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256706; x=1596792706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t2T8/0CuftCCAs+exhYi5obxY8CW2cdT0Xrk9qPFPWw=;
  b=IxxIO8H/bbQU06IqJXQ/HcmNk2EvFXITy11vK1dO6k19D3e5Kr6AOEtk
   Vokc+Rt43pFBzDhNrh/E/azIMAjWo5AAMWvfyQwltS8irUmGYOmN2Y65Y
   uNObnjHkdgWzGR9qNm9AaOw7eZVTS2qWOWYKXlazqowBqPPA4hLbzhjV8
   3GFMVfEljFhww3wTGWLcHZGp4kjNm37epCDNVkCJjvaPrcab9Yry5mxU9
   3wrrwclDBswzmybT0H6vGQXWHvfRJt+aRrJAnZQHTWbLZ9gSPw31g5pZU
   6oNscmvUF9IlMSxbIZbh2hQ5rFc9Fb5mmJegZRWi2FCUU1AXByy76o1Xj
   w==;
IronPort-SDR: UI/19HZxXjzmY8Xzckj8pLgCyPnMwfRhY+HiBPfhAbHbkO62MtWjbn1/iaO9AryTCB9dev/6sd
 pe5Jq/4xAmargexocGXpc6zMCLZ590n3O0wkyb21VdUza6TMk94yRa40qBNNEbLRpJADJAOFpZ
 f9GjZ8Cg9+CGYpbj7Au581TOyRDCj6ARd4tfVRMhKB3ZVZTvyw7GFe79zEKgVK4iXVV6eqoew8
 A4KZx8RYQFHjlw9IwPie63+668nPpCvG7kwDxew4wNusOOZnwPnBgb02SV/tsityRUB3yLbMMO
 Agk=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363389"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:45 +0800
IronPort-SDR: +bcSx1C6tyNdrdY/Y2bsrpNx16PSEnUfwf7c3KlkSikNPtQCGtozqGCENb2j2ji4E3YXmNUYx1
 01CVU8m3h28qrYB2Q3DhJfAghFM5eDQFSkzHr2AlSQ8AoizY3soaxuYxRefUESxecDRMpJ5NBb
 M6wjbiCJS2QBVMQFrsazJQrGUc52r03fmW+Y8pBNCrq/+582WIfVIxPtT3JtHkp//rlDDAFCGJ
 DVsAgid9sRnaZlw4cF9SfU95xjVGm8s+QDrsG76U5LIDRm5RaTKe3ZNSgOjUjdLfoHFbtM4ymJ
 i79vrj3WiDeDho1AhBnpXW/3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:29 -0700
IronPort-SDR: 9nQlb89y/RkHJBgrERurdEjEmG6uRxyJh86/YxIyDRWdKpKLzVKojfFmkWEc+3Kms9VRlrhewW
 jWWNpfzb4TGeM1qleCZQu53rttQ4rJZvnI+Fm9N477jiRNl2JaZJLx7W0R5IirGseIsClR7mj2
 SNXgu2phljw5NlWowsJnEhYUHxPwRxnKyhmsrB30lX4XO9Hlc7C1rV4oFbilsYw4pe5carP4ud
 +a89sYvFOl9JbEhrCAnfaFJwwENzHD0HqZSgzjnuKMlTfvz8viQ2on1Vuh8X3GztFmXeb2y5Mw
 17Q=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:44 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 17/27] btrfs: implement atomic compressed IO submission
Date:   Thu,  8 Aug 2019 18:30:28 +0900
Message-Id: <20190808093038.4163421-18-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
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
2.22.0

