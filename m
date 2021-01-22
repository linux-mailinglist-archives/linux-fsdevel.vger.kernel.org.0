Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0562FFC99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbhAVGZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:25:55 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51039 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbhAVGZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296741; x=1642832741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xRZH9KEu1Wn2ThIAvcmBq2KQH7GSQKzuEhsQiBxI9rw=;
  b=EG83WM93lVwe9ExEmddUskWxewAOXTLkQCHWglSEZ2vhkIHfmde2xsV/
   gyj4JK7NSeU4Mfhm0/aSizBK1rYL+cnLr1LCCJbZyBw/eyKn5LJYN5iUl
   HnesRhloiCkgTgWNgKHREQcy/4qKiaa5htFMo9BfnBNHaWOIKIw0lk6Oo
   u0Id0jrWgOzPk8LORIGUMO9yMN9VEyJM8GXN9Pk+eLFDtesgTn/i5RaIq
   1BuA9JDIp4MiZevJxd5rWoXIQtDMWRXRuCx2YV0fdsQo28MtlTBThS9zm
   mCagfiCZ1YbJ24QBVx0tH23uJgJxrnw46u4QOcav0Mt9/7YCJpHyUTXaa
   g==;
IronPort-SDR: 2ecxe+HhYp8GBfG+3BlD1TCxfgJ4lZXt0IzIxuksWUKtC/RlfDwsdMlhpSWyDgefnP17ycYBYD
 MkzmFaa1PdR3KueUpUu6PC5mVZnaZSqf/SdYLiI9u+pV4iK7L7yAekVsfyvvhrFPWI26PvaPqc
 qlkWH00rWxQeHUMNADW81uAVxZY38PTkHMLT7lSnxwj7xBUV1CWH71veHM7dqzNeEKdkdCD4w5
 ZR/iNFDY5rInyUETVLmWqg5RTCL2k5Ju/bTdoSclnbFRN+xytp6rooQ9EIkJJoxW8mm6AJoZWe
 A3A=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391988"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:47 +0800
IronPort-SDR: oCRXuvnYntCq4oL8C2W63vdZSj7kyzojN61KgLzd4nwgguSJH9dSb59g3IKB+3mqQR1BeU0lfQ
 zGVRQt1dsUG3cLTrtCj8RAFa8tvtKzpEB3xd7PO/yegz19aLqQ4S6mVX+nucHHO4VnkX2Wkzsx
 7MQtot1qocYiUhb4TtzDV8ye3tvPHSbpbgUrpGmBTNKjLVRoyC/6vzp8l5JgLFLAyrULGIfCmd
 RlA5008J9WV+yDBLD9af0xVuO86pxVOTMzbvOYox/o2YEoM3y0nmuEKjax0MdfdjuO2Ol4prsn
 qnzdGwmhw9fuAxqJhZ/Nauvu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:19 -0800
IronPort-SDR: ANtHpyoYxVgsSF4Img3Yx4xsgdIVDe5iC5DC+3cb5QndoVeo48lfGHZ6g1HNRQIfLDYFVbgM0T
 ETRO3kYQBMSKxvViID3geG7dBXgdyy5CoQ1IYHFtKOh1q1r1iXowRE4dxbbTCA+tXnHSY5oMsO
 OkT2KzPS1Wwy7c+3DsBRYLwjaKIE4eUuabdmS4ibLfAWp2HQjK+60db6eFj0SIcr8r8AT7TQmn
 ot/ovxwbE/Uif2qslTz37lZtszlaby+eaonqiFiu4bzjHdqvyjKiLZlNtlMRdv8DQZDIOyXB+i
 sjQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:46 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 16/42] btrfs: advance allocation pointer after tree log node
Date:   Fri, 22 Jan 2021 15:21:16 +0900
Message-Id: <b8a6081fed384de0e6fc47e2b2257fdb2d77d1a7.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the allocation info of tree log node is not recorded to the extent
tree, calculate_alloc_pointer() cannot detect the node, so the pointer can
be over a tree node.

Replaying the log call btrfs_remove_free_space() for each node in the log
tree. So, advance the pointer after the node.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 990b0887ea45..1af6eec79f66 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2616,8 +2616,22 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 	int ret;
 	bool re_search = false;
 
-	if (btrfs_is_zoned(block_group->fs_info))
+	if (btrfs_is_zoned(block_group->fs_info)) {
+		/*
+		 * This can happen with conventional zones when replaying
+		 * log. Since the allocation info of tree-log nodes are
+		 * not recorded to the extent-tree, calculate_alloc_pointer()
+		 * failed to advance the allocation pointer after last
+		 * allocated tree log node blocks.
+		 *
+		 * This function is called from
+		 * btrfs_pin_extent_for_log_replay() when replaying the
+		 * log. Advance the pointer not to overwrite the tree-log nodes.
+		 */
+		if (block_group->alloc_offset < offset + bytes)
+			block_group->alloc_offset = offset + bytes;
 		return 0;
+	}
 
 	spin_lock(&ctl->tree_lock);
 
-- 
2.27.0

