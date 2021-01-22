Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576802FFC89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhAVGYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:24:17 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51031 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbhAVGYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296649; x=1642832649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lXJV3aeX/g+21wp5YVCT9XcbjBESAfZEy0QiID+uj0o=;
  b=iK9nX2/bqKkl6QX7BzHQnRqwqUwhaacRtRCm1oi9EhAXsMtdeUcyZ4aA
   Slc3b7t/cBSKvOcEBVFMZ+yMnfA824aWUonTZJy7COR5P5Nvc5nOMzrka
   u3IqzzAdOFkeuKjtL3KqjhOrN0HpjWeqrJ3WeccYsq++yqfQo15bcancY
   gBWK3wOjZUv4r+1GoMvXIsyA5eWTl1frkDromQF5oIjE0ZbsBqSM9X5V5
   rDua3a/zz4pN3CVSmkwVT6qM6UB7LEwDioepPtUv3I96TQCvTKx4MTNtq
   U+J3seWX+nnZG00G9XGtQy3UBC8wQ2u7Oi2e0wdvmn8CwyqwXjK9DbiDe
   Q==;
IronPort-SDR: TtlxzJilQ07F5edblsJI4sQobKwTAqv1YeTox6SnB7lrh1yZ1x6qX9xT0juvG7xIX+1+V8PujS
 0eYs7Q2KB+ARE3e8eFBeTPp49ENd90Ze7BIM5X1nENMNkj8sgkDeOfxfX+beJVLPBN2uVKJwIA
 fsRnsOtFkCeeemLro5WdN3nmfSZgLRAF74FKugvE+X8HFkCIQKYMp38JedKrr9q8MeGuAWBOE6
 7sWkvUVwEwGN1N6vrHmrMF9h4DJeXLip39np/G70hib42pESzQUl+iDYKRrRsDs8oC16bZGMay
 dKQ=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391933"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:27 +0800
IronPort-SDR: z4xBmwQQB9X+3o1Qy7/YkZ6UyRt8alFTClgpSFtmUBG3npSdgKLSOWJqnoSJNKxZ+RERDcXHdW
 KXctz016yF2s2S5huJjlWnXzzo2uCs9bOaDRrVNZjV4Jxw05Eo9Aucqe+6MaH3LEf8ZW5llqbD
 3q8dxrWnz4B92F4cIvcWtuXvw//2fqCpp0RyaMEPBuFJcOaH2Zui+BLJFoqjjeY5zutcky4cmu
 zTi1EPPNTh8misdjGmE/8Wi+rWSg78YnFvhYqk9PBNwKQw3qy9LGw7zvzCNYSMsJV95EMbCgUg
 QDezfz1uFJ3ZeRIBr5AYLLYG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:04:59 -0800
IronPort-SDR: suyh4awmDeZmtu7UUnjbGCvNGn7pR8Bf/1miA/cKFsedHHB5AYPUwI3aIqs4WdvqSe2Xrb+h6F
 3+ZGOQkj2enP03vOdD9+z7iH8vKwAuDMeA6ssSN7DZeFAIB4617V27cb0aYoB1ZUSwSaa2ZvL6
 FUPs8SnFELa2FoAENkXK6fLBl9r0NvWjAuFCDcyqRKjyxjyE1vS5zzRgqfeWD7Pws1jmIQ1KDK
 3miVB93WpL6rn9aN76htwJb0DVmp8GPfQpyTZgWDR/gjXScEHNJ70EKffncKASCtrBi7MEb5Wx
 LXA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:26 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 04/42] btrfs: use regular SB location on emulated zoned mode
Date:   Fri, 22 Jan 2021 15:21:04 +0900
Message-Id: <a0cbbb0c6c4ff0294f575aee047648132205a494.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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

