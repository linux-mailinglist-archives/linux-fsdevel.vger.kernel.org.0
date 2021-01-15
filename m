Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF0E2F731B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 07:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbhAOG5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:57:17 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41680 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693835; x=1642229835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W7XFF0P7OQNDxD89tYtJUXC4wa061hO3/UHNt84IISc=;
  b=oLI3gkCyiDGoywwDUii9O5/ujhFaC1xLD2NmKrWnQp4zJbA6/6jxoK/o
   BZZcG1kKOyueTlT9Udof8OPbjHopjehTc0zVkmmR1b6PmAnFV3Au5rrKE
   T8WD6AQPq+an5+ehEnflblh6+pnaGSbZPBO11us7RZbb/czKHriYzxolv
   RGz9FwdQZatYmchLSgjqfFzWgRBlzCcJ2iqAve10WdU9g+iomLhFHiLCr
   c3cRkNMlRm+yWlzpSQ8vUHi21sEOcVkq5SHvNum3Tmo9BbyJmKr6HFHG0
   g64zQG8L5zl4Biejz5KTZ9gKW8GhE9lFlXhqZhN2RjLxyEE9/CFVd7hjr
   A==;
IronPort-SDR: tHmRGuTR32+F8pXUYRrQ+QSfEpCbmWFwaXLA62YZuy2j56m1/rZQE3IYeV4MBjb1WuXaytzHn8
 uCbwWa6nkwJuK0S9oLgbdi9OUN/jRQrBCaZppbgLd3+ccwcT5t+jFFIk3gm5e+rYbkGS/0QX6f
 GRAU6lRq8kmJc+mFNQTMrPe/u0neLppuo7cU7S0LhMlXWJ2B94LG+I6w5oyVyvnBwVjRFn7csq
 FPeWpQJdAiL0Uysj77BN6EjcJtSYIub2i8z6CAaZwWX6sradNdAkThvT0Onh0L78/echPTOmaU
 Vlc=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928201"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:15 +0800
IronPort-SDR: ZMg2bHIBUMpLK/k9eDEjw+BSEkl+G8oxYJl1/n2n/qQCd13tj0Lmv67Ex2ly6R7eNBjdhA7dTi
 oC7uSr6AK2fBOXpnj+nzupuF+vtsxheIMOM5w5QjEZTdckG5kGdLJ2xYW+m6Ti5sFpwF7gCJS1
 76ya1gMgkYTPmHO2sQImubLON6M0dpYNxwijbv1KW5FwvUDCGhIcsBlltEcMkSO7lQKo1DtvPO
 WtoDBoPlAVhf8/UZizb+9Hcwfg46QLcgRps20WPXiG4s+ERPYmcGqEn8GFdUGQt+NksFuha1Mj
 HhmZvXbgKX6P/FuZwmbX0RVJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:39:57 -0800
IronPort-SDR: dRBYkP/Egkn/bt1qPEWlf+4yQ5TPCJ5hE0OEa6K5SX96T72uHK3C+FhTDBYkc3+MhmSP5Fs51Q
 i5fhSW+mKEDOJGCoXjHfjFDbiZfnWEucy9OvKJHiu/QphtKUMmtp0TH6Z1V+5gfGw0nL+Dqc4L
 BTFRDmM1tJnWDOAN7I9Y31kBhQoLEakrlo2MGiAcVjAC6hi1ryxBuSy4+Ksz0sz3Ij78y2RT4N
 p7vD21IEfzGX68+m+hG0iOrEDjHWskbMmJjy05m+MvacmWJdShBflOZyZizTeNmDEfvBwW4E5I
 Cho=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:14 -0800
Received: (nullmailer pid 1916430 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v12 06/41] btrfs: do not load fs_info->zoned from incompat flag
Date:   Fri, 15 Jan 2021 15:53:09 +0900
Message-Id: <e9726ecb20d2bc5213e57a7d9456bb77def68333.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't set the zoned flag in fs_info when encountering the
BTRFS_FEATURE_INCOMPAT_ZONED on mount. The zoned flag in fs_info is in a
union together with the zone_size, so setting it too early will result in
setting an incorrect zone_size as well.

Once the correct zone_size is read from the device, we can rely on the
zoned flag in fs_info as well to determine if the filesystem is running in
zoned mode.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c | 2 --
 fs/btrfs/zoned.c   | 8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e7b451d30ae2..192e366f8afc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3136,8 +3136,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
 		btrfs_info(fs_info, "has skinny extents");
 
-	fs_info->zoned = (features & BTRFS_FEATURE_INCOMPAT_ZONED);
-
 	/*
 	 * flag our filesystem as having big metadata blocks if
 	 * they are bigger than the page size
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 49148e7a44b4..684dad749a8c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -431,6 +431,14 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size = max_zone_append_size;
 
+	/*
+	 * Check mount options here, because we might change fs_info->zoned
+	 * from fs_info->zone_size.
+	 */
+	ret = btrfs_check_mountopts_zoned(fs_info);
+	if (ret)
+		goto out;
+
 	btrfs_info(fs_info, "zoned mode enabled with zone size %llu", zone_size);
 out:
 	return ret;
-- 
2.27.0

