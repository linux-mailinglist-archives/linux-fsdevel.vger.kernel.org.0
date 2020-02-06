Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC0F154226
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgBFKoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:38 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgBFKoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985876; x=1612521876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0mLMyvXISJkKtaveQS6Ke3dOGw0YjpT7RmJIVuVCL8Q=;
  b=TXOdlQAIIXqlQ4UQfnNWlXqi8uBdZzz5+NObCwC1+tq36JSHg3k5R21T
   ffIo5iYQTeRjWM+DBtmWw9R3RMWbxlecJUiUJYdWLAl/bdFGjsXFbIlEy
   kDfPE9hawLlsPDGSFajwETbgMPF120Dvmh7DS5hR6I1GX2a3CKz92GRoG
   GDYxf8NaNNs7c1SOr6Qfr3TZGi33NUQQnWNsOnOR2lApvj2fkLdhEUkyP
   mVw6GUWUPy8Zc60tivHWElgEtO6ddAT10rITlJ2cCbsi7Gkq/kjfY4uBD
   2c1jVMxlVtovjSb+qoEs/HBcwJ1H0qS6+SC2X9HqlOk4gzHvBZq1QjPxW
   A==;
IronPort-SDR: 3AI19ja2s/0SFD+/mNrf/5bWOpaqB3Tx2W6tAxMzMdP3Xn3e+CEulUm2Kz7XMqWJzLVpb7qrws
 p+qCSOsj8nnfwXdYTT8uljHiVsUTyRMRPL8KBBNJCT/f5IOJMZeUVWB8UJTRAYqdrywDfawLT5
 mkSxIhRZJSzAEmfJUiq15Y4WwNQvz5MV/wxvwhV8VaKBd4SNbguTXy3mBNaXwaOBxN7SsKnezD
 8yAFPUznn7GJtj0kNHqUejb+2Pn8bC4W7FZxPBgydXZ6XLTo4cchhOHuruwehPPaQQBbgYEfVM
 Iro=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209529"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:36 +0800
IronPort-SDR: IWc0jNE4+vfzfvManjmOq1weBy6gD4QgrlAhmXFl92p3M7I7pgdi9d6OPFTGd/5vysj7U9Jqca
 EmJBBS/z2rMVNZscSR1yQaYkiJ1TAiMZ1Z9y4fVqBVgDFcAhdsWXO0FT0KABsXW7zW/fphF2WA
 maoeBchn6lTOz8X+ezh9WQKBux6kbYz7sdyoURS0uYvUs/KecivpiK2m6UBtb3fvhdv/t3aY7c
 yiNMVv+p25QgdM0RiRV40vnM/i1gSsSGi6e7xX2xoawmhQvrzT4b2SqJXDwGeNcBD7I3atNnaa
 czXY6yRBTVCI/3pV8AF2v9HQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:36 -0800
IronPort-SDR: RHVjB6SlHuAdz3hXbCGVQE54NnX5y7ZUxynWUtSHJByo9NKEkgnIXuSTbJ8Fp7V1kUxodADsMl
 aL6qJ3L2C8SPl3Usbgwh+xm/9TdBWKYlyySNeet5DEugG/IMrE6qCVIa0Qy2dvnFlmklvI+cCv
 4brFPcuniS9m/staK+lAQayq9jHkUMJ6TLe2MZGwQctytU3/AYSidJcNiRvA46z9/htkbEWpFc
 m6rRCpIc92BY5wtzhU50GvQnHAZRGFLq2erxJDMxG2xniiSrFWdmCWrSAVVF+m1CsUgpvSk1Fz
 /6s=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:34 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 10/20] btrfs: introduce extent allocation policy
Date:   Thu,  6 Feb 2020 19:42:04 +0900
Message-Id: <20200206104214.400857-11-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
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

