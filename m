Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0843A304979
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbhAZF1x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:27:53 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38256 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731704AbhAZC2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628082; x=1643164082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lXJV3aeX/g+21wp5YVCT9XcbjBESAfZEy0QiID+uj0o=;
  b=VsSS9SoJry91KFc41KW0wz26+PYa3T0cbd89eL/jj0doFfBCzb+dwGV4
   MUpo4Cg5NwWgYFHL2N0v2xD4FqhwT5kI1MkYNiUCnr0Y0gtdVoukPm+DR
   7JJUKf5qrgPBLuwdfhCtu1E0wxcuQO4k3yTZVSRVjZ0SHT2OjgQQpqexM
   L8s4YGRR/lm4iG5f0Mck2cRXju0CeXGC+gYJGRRDcz2Z3R3ELmHmjDy3N
   4/S2cnS/WEdEK7W/xunDS9Qrz0zN3Fov/1rbwgIll3i28r8CuqL5QqcZY
   VhbxYRSYFKVmiWP8wHHnOkVJkO/+ywo2BZfk/Z8g44XkxIqTwdKw6lZW6
   A==;
IronPort-SDR: zA2i7CKZNRloVS8r9DSsxL+RDyhh/lGxAhUGR4WVPaDAuqZjgt8ptpxDqqI9EJCHnFvKDxsQgp
 WzCP7QtYBF1D9tfIvEyVSi6CsYc4lZMNW3zkMM4ph/S1gdKXlpzYlczrUUgqKBOHXmvb74rcca
 JESiIyfkSX8SB3YYW91p/paM4Hm797Hw5smlHQtshAwTD50uXT8u38pWH8RzKWGziIDl0wGC8M
 26AWfBbV2YWfWfBq6PzMc1RkXP++leRMsUUTsIv5Fr3hYonuzTeVO7H+4KMv1RyIWUrd7wKmE3
 A6c=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483503"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:06 +0800
IronPort-SDR: 1qn8nUEXjtgzZciZACRwIA8iiyD54TL9l1MWQfl7PMIT1o2OE9g3VAmFy2nDGQngSvMckwhMTF
 d9P/J55rOM8hhLzvTGJNgv5/LJ8wByrti2ySID4b0MZODqxgvWqZoksYes2NK5CFM8FwFkqhsH
 AHfVp3dnWOq0mz6xWD5H0/vmBi+wHury9DEkkCk/B+Aj3cLI0Opy61W/kZspVNs4hzxLKzhKO+
 qp9GZKtRgMsVaLZZIknuKpcfCUTpBUYJDygRwTcjcY3XhlKhb4h3a/+GxXuoMn3ZLyHhmbcSqg
 M0L8VpfNqGYn1CMwKMTXoi/f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:32 -0800
IronPort-SDR: qpKvojXeTIVxTVJHr94+WsGViCL1t5e4WWjrEXIdARjN6C6ms7shPbGxWgQkCzpJ1tW10hmlfP
 gsvctj/yp+adt7xFQKSzQwep8QfpXa89RYMSmZrIExRgFnbm4K9XwlZbzAOLIEN0Dle7PIyCI0
 zXSpbR7TC5+nlHMI/ADvHc7FheEWFf1WPJfrLhhPCUrkKBjKFzQ9wl4dtBRshXMdD1RDKbiMkg
 cdi3o9ulkfSKjErjwiYEAK67Wf3lsMvLJrkC+SA+SOrSsWuwYN+LGr+BMZo8j3Y7mzeHRfxTzc
 ACA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:04 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 04/42] btrfs: use regular SB location on emulated zoned mode
Date:   Tue, 26 Jan 2021 11:24:42 +0900
Message-Id: <e819daceaa2d00bc95df81a020432a746cf1c6e0.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The zoned btrfs puts a superblock at the beginning of SB logging zones
if the zone is conventional. This difference causes a chicken-and-egg
problem for emulated zoned mode. Since the device is a regular
(non-zoned) device, we cannot know if the btrfs is regular or emulated
zoned while we read the superblock. But, to load proper superblock, we
need to see if it is emulated zoned or not.

We place the SBs at the same location as the regular btrfs on emulated
zoned mode to solve the problem. It is possible because it's ensured
that all the SB locations are at a conventional zone on emulated zoned
mode.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index bcabdb2c97f1..87172ce7173b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -553,7 +553,13 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 	struct btrfs_zoned_device_info *zinfo = device->zone_info;
 	u32 zone_num;
 
-	if (!zinfo) {
+	/*
+	 * With btrfs zoned mode on a non-zoned block device, use the same
+	 * super block locations as regular btrfs. Doing so, the super
+	 * block can always be retrieved and the zoned-mode of the volume
+	 * detected from the super block information.
+	 */
+	if (!bdev_is_zoned(device->bdev)) {
 		*bytenr_ret = btrfs_sb_offset(mirror);
 		return 0;
 	}
-- 
2.27.0

