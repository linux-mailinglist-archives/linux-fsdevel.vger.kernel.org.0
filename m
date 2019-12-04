Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9FB112473
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLDIUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:20:00 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfLDIUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447600; x=1606983600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=48fi9iWuTJ5hUDEI3q4s9C6bEGLUNolZCKfPx156Xxk=;
  b=fAiRl2HmEkPvPSsfjTg6UkzdTX4YfGWRHfPuQIZfbr2d/ZqYFZxk6155
   P6uttvGkQPOg5o01ns2k4qPFeVOlYudD+Wct34bCh5cIQqMCzwXLfuX0B
   E0/t1tucRtr8Vjoka+QOoUSQSUVnr6wn5kBPCkK32d6/YHhSJpV04TshP
   7m/EQeXiNrwA0bdSCpLBpZ9SPvAmJgtkMk0Xu/63Mxe/NXzRbeeJLUQ7t
   cU/zi863vVsmuBpj3zMXPMgDHZEZK0sZGOghm5aH/TALoz6WKAA5eFcpR
   Zqr/gajSEZRDG6VHFYcPUddqhVVctStkJY/706tsGdhjLr+HKDaWTSm6L
   w==;
IronPort-SDR: jH1M2EBLhom67WXalvqt4IirPIdLdX+Oc8/I5vewPdR9keRoNFvzcZnrt8oTtl97im3/medZvi
 VWiwYRyVfh9sjbHSsA28OrjktEf1Ij+wpKehtUUf68xbxqf7kYN0ag+lFBl86inWj0vp9JPGQ9
 53Rd2YpVvEPhhB0NtaYu5DcVYJjHHzRs/SImQprc+Inka5zmM+/Dm4WODu/DlrrHgYnanBnM+U
 K4+rfVN74b7csxuyecXmOQHKQ6BxPa2yj0ThCr3AQ4GOw+REVlwNx2FrU75h/JRKD3zTan9GLY
 83g=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355094"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:20:00 +0800
IronPort-SDR: 8gxPzSkdqNGV2P+V4szZ6DSeexTt/ncjBitIXeYa/soz/XEVdfzCte+uQpXD/JtliUXpToVRPI
 ixqVyAoJba0JzPZ8BPx4gTqdVWEtjubJQXgIFJedvJ3R1g6oQaG5SpGDdQjBvQm7valM2i08yP
 49LCgslPlAliNLfJRRMPdKuvKuyzlwvOgepP84NztcGOdv6gtLhw7oWcBqOMg+FF0rXWrcTj5B
 aK/49gZgm8IDalLud47JFG4RWzDZSJ+uIYqTlSO+Nb3oIzaHuTXd2AXgftkXKYS0C8c/3bu5sK
 pGPNgPjtfAx9bRIEQo/RaS/F
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:25 -0800
IronPort-SDR: lymiCoHnw4iO4+Qe6jL7PiSRV1yyjZ4WMz6XlHiJfl3jX2TdDxc8+/LT0i8Jxv8k5nzc+pzJG0
 c/HDGojBG5VrhHbXYz+MGrdoWL6aoyRPtFO5TUNDesnJAHRbea49Ao777RNrpYGqFv1lmJiMTB
 CEnAQ2SXV6iYQmxAJYDaJQZCVXD35euzi7GtMyQrv9hJk4ND8IvrK2y+Azp0sDm8QFDusHESGg
 CX+9U5usuwfBTXm55pDAbVliI1KfpItITy6PmQLSNCwCmFOKlIs1jhbaD/3DO+JssAlFV1hJt5
 MEw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:57 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 16/28] btrfs: implement atomic compressed IO submission
Date:   Wed,  4 Dec 2019 17:17:23 +0900
Message-Id: <20191204081735.852438-17-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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

