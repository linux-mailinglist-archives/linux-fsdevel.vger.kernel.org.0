Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E0115A1C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgBLHVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:19 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBLHVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492082; x=1613028082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0mLMyvXISJkKtaveQS6Ke3dOGw0YjpT7RmJIVuVCL8Q=;
  b=qJlov1eUjDNYaqRwR/ESkdiE3R89XKXih3QVUmG36mkWt6RlZlIAJhIy
   7ts6iKRHGPUm7YL5bysLrtt6dWAZOP51bdokHxcUMSj33AXpjWd6hIGVO
   3HCJ3ldtmKyT7nMp5iooI/gNlKflkcqlTCmZi5Ljp/vgAP5k4UEMaAx1h
   syKDqQKjqhZTA6GT6A6Mc0sMnfHxOALCINP6sh+ZxsxpcCzkbhPWCtMt7
   rZJiTHiUEQzXxmHmbrfeM0VELskWTW8zRPVvjEQuDcqEFBXYKcI0YA7Rl
   60Z3uWkJUxEzkksVLLSNHcTPJ+9rYUkGvV11ZpLnE4k47ZS3zTSG9muJj
   Q==;
IronPort-SDR: 5N4nBErIxjKP513dzC25IWttHJwreNmnqsTfaSCfyxk/U3OG5lqZElD5BD2oGTWgo7FzDDS+lL
 wGO6s1b4pDdioCsvH0fG6NHrjYyRl7WWc/Rvmp6ubMd9nMehgWnAw6rbYSa0Jy9iDIXNzY4hAb
 92Xz5qEtnj/FceajHSjpz4FqB100wv5ecY8TQwuJhABlTxljGaj2LUI7wOM3dDeQolppqNepXV
 DS+NQJg07Ak7NW8wTDtew4cV4OTAyY0eZx0WoUrF9AU/EoowG4x0sLoFJ04GJKU2XQN/vAXEcF
 CmE=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448920"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:22 +0800
IronPort-SDR: ZA6nTc1myv+bYiqvXrWL1GRrODGCcV9FOqCxvQXJW2VipNu9bS7wkL9VTfDdJndM0E4FUtXDUT
 hKc1hRAM9d7L2EGt4rIAvFsireK8WaApTFQQzoxH3Y6Zjqrcru1O7FesXJNOwEQKGcfvRfuEUF
 /CvRoVy6ac/UggL0Ks8VF0+onzfyuddKht0qJeZkhgiJl92f2850n5j+msGcsve6yY9dKs2wdD
 cirUuN0poPeDG3yX3nGyYW2BwMy4udfMbV053DdwgE3PcFsa5EbOg5RKdBhujbIt3IvbdQgdI6
 skFesOuolTyifP+Xw0Og1nhj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:07 -0800
IronPort-SDR: gd/4ZfqYymUZq9A1Uo6rAcC+kYzzupwx6DbM3+0ZE2Iy0gSJ1WY+/z81rlXQaFd4bknmQyBTIb
 LzqpPp1rNVxNvW3h5qKW3nnceMcA/qStOr01yuLxiVYeP5i9Jt15FChZwS1/zXQAwgWVGDJkos
 0XmLpuumc70s+sK5ac6ei1DLLEPUp8WX5juiD/xONGJfMhgBL7cet6bPIr4k8WK3aBg167nP29
 KCk8g8X5jTQHjzrdAoWvOL58yuTOnnwtPk6En9z3pM089Cz+vmeYqNkxA8YHNE44l1oqiLPkil
 Eak=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:16 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 11/21] btrfs: introduce extent allocation policy
Date:   Wed, 12 Feb 2020 16:20:38 +0900
Message-Id: <20200212072048.629856-12-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit introduces extent allocation policy for btrfs. This policy
controls how btrfs allocate an extents from block groups.

There is no functional change introduced with this commit.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 227d4d628b90..247d68eb4735 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3438,6 +3438,10 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
 	btrfs_put_block_group(cache);
 }
 
+enum btrfs_extent_allocation_policy {
+	BTRFS_EXTENT_ALLOC_CLUSTERED,
+};
+
 /*
  * Structure used internally for find_free_extent() function.  Wraps needed
  * parameters.
@@ -3489,6 +3493,9 @@ struct find_free_extent_ctl {
 
 	/* Found result */
 	u64 found_offset;
+
+	/* Allocation policy */
+	enum btrfs_extent_allocation_policy policy;
 };
 
 
@@ -3826,6 +3833,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ffe_ctl.have_caching_bg = false;
 	ffe_ctl.orig_have_caching_bg = false;
 	ffe_ctl.found_offset = 0;
+	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
 	ins->objectid = 0;
-- 
2.25.0

