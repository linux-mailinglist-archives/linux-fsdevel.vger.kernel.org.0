Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44436154229
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgBFKok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:40 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgBFKoj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985878; x=1612521878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7kSGCvaay2SG1nIxMcRDLO5KnT8tOtaO/l1P1KJNuCY=;
  b=i+i1OkLoSu3hnxz8BNrvz0cP+UYVQmSUZMr6X0GyY7jzZC6om9NSLst1
   Nvu6N9zev5PxHrJ67wjDBsuvPaWqaVyvxkLja+h+cp7NjjQ7bJfZmNDrV
   ZJPhLT77kZ+JXCaRRF70pNLzE0TZfrdOU0HpxEtG5tZ5ZKMWnyivK+TOf
   NwU2uyo+Doo435xasKDXzcnB21H4s1i4dxGWEiBBtpxRpJ8wigHY2+sbc
   Zd2yblol25/WpO5HC0JEXEb6HsjPArEUbpy9f7504wOZD7hwHGGqAS5mz
   f7e5YUzLOnaBXPqeG/3zsXeT703hIkxAw8odRKE99cEruRdbPwPHICu+1
   Q==;
IronPort-SDR: jEP/QREmE7FKnpJRcmDO7efOYXKw/C6Ee+TGew5sTwqlAWCqXIZj1/AhQRHaQ0EAGKezP6GkVU
 vCKUtN73OWgc10WHjmdmkuB+pKtIoTAshD9AovaYYRTkJkR1DqljEnMlBJOtrxfuiJDZ5RNkRt
 XSBqQbwLNJRDXb73MwFAO9iknOsx8ksttAb29HjgHOik+ihCWw7ZaxD0hp/hHMLfIVEJKU1zk1
 n50GJ9E519mZJNllzW+vX9KYDn357TDeqN/gYQF8xDLk7JrvxvTWef7ZuJCCH3adtkvXEUO3rt
 +pw=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209534"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:38 +0800
IronPort-SDR: h0xFgMrQKK9H0OiE8Wq6X3DT6H79UFU+FPl1oxHTw4ttOiEcWjCpxZ/7oFvtw+hQUdscHICsmF
 9l7c7G4bTuv2lx4hPtRt+K0r4+SBT7mqcxuvpRhdfY4vwwVGY39/Z/GfzPlBo7a/vhEp8kzpt1
 Ju4TaOIFZTvPvHjIvFcoByMfOoG4n+IoKOP5ab7xYqwXyoueqYefIVJeMOsT1U/OJ73Dx0KaX0
 xEurDtn2ygXs85Bjx2jH3LbRGV0qMAUio+K8ZykJS8CQwtfuZ0dT/ojG0huWLCHxCb44+fU8mk
 cdhTUE9dVXBMh4VUvDb0vCP3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:38 -0800
IronPort-SDR: BGd5LnyGzcrNSr0OXSZBsTxbiLrqb7agv3fnqOkJCCunZ8K7aPGlKPGbQjy0xeWY0hR8DNwBZl
 8+zhkFTXyIKRTk7Lma/uJ/rQesA5gnsr4EKsHacX3smCMPYJxnRjOd3Fk/yozUpdkjyPD6xHNw
 YVNzrrLE3NTnTcQ9S8+/kffpmtw5456yHfOMlm+fNdUPEj+snfdTYhdt1gP/yoXtDOsFPuU/vK
 9+t/Iv8Gjh/LoRlLA4sxQIKNFTPMHOIXAZefYLGT1G+IEMIPW13prhglCFCMl3ZYaB0y+Txk6I
 cfk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:36 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 11/20] btrfs: move hint_byte into find_free_extent_ctl
Date:   Thu,  6 Feb 2020 19:42:05 +0900
Message-Id: <20200206104214.400857-12-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit moves hint_byte into find_free_extent_ctl, so that we can
modify the hint_byte in the other functions. This will help us split
find_free_extent further. This commit also renames the function argument
"hint_byte" to "hint_byte_orig" to avoid misuse.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 247d68eb4735..b1f52eee24fe 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3494,6 +3494,9 @@ struct find_free_extent_ctl {
 	/* Found result */
 	u64 found_offset;
 
+	/* Hint byte to start looking for an empty space */
+	u64 hint_byte;
+
 	/* Allocation policy */
 	enum btrfs_extent_allocation_policy policy;
 };
@@ -3808,7 +3811,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
  */
 static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 				u64 ram_bytes, u64 num_bytes, u64 empty_size,
-				u64 hint_byte, struct btrfs_key *ins,
+				u64 hint_byte_orig, struct btrfs_key *ins,
 				u64 flags, int delalloc)
 {
 	int ret = 0;
@@ -3833,6 +3836,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ffe_ctl.have_caching_bg = false;
 	ffe_ctl.orig_have_caching_bg = false;
 	ffe_ctl.found_offset = 0;
+	ffe_ctl.hint_byte = hint_byte_orig;
 	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
@@ -3875,14 +3879,14 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	if (last_ptr) {
 		spin_lock(&last_ptr->lock);
 		if (last_ptr->block_group)
-			hint_byte = last_ptr->window_start;
+			ffe_ctl.hint_byte = last_ptr->window_start;
 		if (last_ptr->fragmented) {
 			/*
 			 * We still set window_start so we can keep track of the
 			 * last place we found an allocation to try and save
 			 * some time.
 			 */
-			hint_byte = last_ptr->window_start;
+			ffe_ctl.hint_byte = last_ptr->window_start;
 			use_cluster = false;
 		}
 		spin_unlock(&last_ptr->lock);
@@ -3890,8 +3894,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 
 	ffe_ctl.search_start = max(ffe_ctl.search_start,
 				   first_logical_byte(fs_info, 0));
-	ffe_ctl.search_start = max(ffe_ctl.search_start, hint_byte);
-	if (ffe_ctl.search_start == hint_byte) {
+	ffe_ctl.search_start = max(ffe_ctl.search_start, ffe_ctl.hint_byte);
+	if (ffe_ctl.search_start == ffe_ctl.hint_byte) {
 		block_group = btrfs_lookup_block_group(fs_info,
 						       ffe_ctl.search_start);
 		/*
-- 
2.25.0

