Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FCA3034CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbhAZF2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:28:02 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33033 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731787AbhAZC3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628189; x=1643164189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U2Q3c4GwozAQUdaajpyHuDs/frhojOzH17vuDUHkLHw=;
  b=O5bfiUEzREFo7FLlZ4vYF2x0tXjXtK5jkrC4JFrID+R7wH4vo1iPvAXX
   FvUwzKuNfRT6MRqMIx+c5oYUQPg+m+tBrY+VwbQC8tYpcxwsBH93Pq8ai
   R0iFcjZctTBXnPbFnV3HdNR5GXLC+O7rOJkC7ZEpj5ouThB7RaIJUUxZu
   ISjMQZlxTQ1CyKP04I0740pqlC5iFfy/PFriIiZmsHzaHHBxKyeqH9Hs1
   obyI8Mf1sQjaQWlYydcgzmrQbUF7MYMH3xYfcS5SjrY3avMrKC0ieOxiO
   zbwnM4CJ6uVWX3nUI+W12y1Ei/0ie2b+z8CdDhqui9x8DPhpzWvxhjLzO
   g==;
IronPort-SDR: Sh8oZs8cWX+7yKw/8NQhkR45/BwUijsWy5HsulOLq7m0Kd7hXgjUq5kndNoqJugYKkmkwjxs2J
 p/KDnkJtD3KINLHN3GbsigkG5Q9CuXF9ohKk9v3d1LOJlyAXfCTCH7FQQFQRykIgje8V/t+sXz
 tos4uWelaAAkQa5iSD1CWhwwpEUJYrSAGBzKEaQTtFAm4IXHkO70HrFF0LT519Ew3kjd1IEv0r
 Wk/k3r7Cefs66YH37H4+EhFObO39rah+uNEc40D8ZhibXurpftneJd7Z+ZCRMDJ3BWAtkMogpz
 Nxk=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483512"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:09 +0800
IronPort-SDR: 4Nn25OZWP+y0kIhosZ0sL94t/Pp620nnif3uKm8MqYd9kA5oZvH4hqSdMUEqHFj9RPo0rudS3L
 maS3huZ17sDA6vRkPrWzlpT0+81h6/CU0cNmc1hsZ3SHWpBG0+K+PHVy87ybzop6rgpEM8jxlY
 KZL+sOGFtkPZNCxhV/gjsTARb9WMlXvdNnOxdzMFJl+S+AqxtY3Qz0jDbecWefrKf0eBFKA2OE
 puJyu7Nf1QJYmSp0hEdyqj++3fb0/nVpZqmIf2x9UfOaydFFtg2yqRDmI69GUYYtr1Rq2WvMpU
 bz0g1t5/mrta3a0r1tmw/Ukg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:36 -0800
IronPort-SDR: YA5IfCmLzewVhqRdpi2e9LPRFK6pOkhuEgSzFvIZw9Bmq6Hce0EtBd7RF65ilZ9S+AEGdIF0pH
 rwvaYHK3NKJrMROgWdqzpB11AAE38hD/ACkicEKEutU85bxLbOBR0+zIqCgqhV6fiG5kXmomRN
 kuXXsNTn1kNn3XsYZR2F0bUrsVvIjYUjqZTem/ddUCIZQZqQ6KSp3u6BN5+ylpb7x5wOnrHmrt
 N3HIAL2fRyjNhPXeJSoeJ+wDMOuox9Ka5+e6Mr9NCuyB3XKabSP3byY46SXTAfDdNPfY0eeCPf
 2Bs=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:08 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 06/42] btrfs: do not load fs_info->zoned from incompat flag
Date:   Tue, 26 Jan 2021 11:24:44 +0900
Message-Id: <a5df66e698c59ab058cece26456520d882d2f4be.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 2 --
 fs/btrfs/zoned.c   | 8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 39cbe10a81b6..76ab86dacc8d 100644
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
index 87172ce7173b..315cd5189781 100644
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

