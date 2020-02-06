Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCAD154216
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgBFKoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:23 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgBFKoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985862; x=1612521862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N+QkKiBW9DKyUmLy1nAZGPeXhULyD0Q+ER4MjgDcrOo=;
  b=WvHdONng4MF0ZMu6XoCgqOflrT9d8NFj014i3ZqvBooRZccabK8lXshr
   V+mVVNItb/THhjI/nVl2stZ5k/xKZOBq5E5dxjXLpsoXw9or28bzWtG2j
   m9L21qRGmG16WEHMuJ/h91xJINgeHDxd92vWbOGKZ6X80h10SNPRkPhRQ
   4qu3MvXvTvyU9lEEbiqgNznC+Q7ZCUt8zO0Vc5N4b6UqBwk3BL8Ej0gU+
   L3LvLuOW3g8P9K9OHTP9JKfJ7rSS1sNQHXo3yW2ZIDex1iRqCWXajzz6w
   V+IX7Aijezs3ruiZS+1tW5b2de4Cv6SU96ji6z0wVJJTZA7qjhbDYTB0/
   A==;
IronPort-SDR: Gchi/waDNIFeZGI5/Ge/WZyE41cjhW0K7/4i4nUHNh2X/oCnSBh0Pznij77XOfVKpakFm4wtjg
 nkGrR8xLGnff99BfTDgvc/bHPZnQV2YF2+Xjz6l7Ja5NdbB1UJ6eSD7C07i68yIRZ1QVkM45EF
 MAUIKEohlj6QwgyaPkUV+mpKP9BXfYc0vPz3rREdoCZU+vuJ68NN1xZH5zveWAnoAJCWlqaTOu
 UOIEUlMFEwfDBIKINj8vGc2sDcb5Uvf3J/eyiz48GrL+Rh0ngPhlB4fLIhyzAg8Z4woFd2sQa5
 vGU=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209488"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:22 +0800
IronPort-SDR: WFJdf2T6ZGMuOmjw71v+ie6LjSwpPw+1XY4fSRR6W04dRrYRQ2zmTeTI1rJvwrlx3Sc0ISNH8y
 oBLle8SQIm8PbCUlVovfGYyRlDZ7WppEjGN38j8sWO2tYu9x0JAtoVKoaMLFPy+t15cxVni+Kj
 SjHwtmUlpewoeNS3b1kvpFgVVde9/uGtztco3oIh5WHZJ42E5z6jdZ4JvrZmGcVWu1iwhrvVpX
 Q+R9VikUqnhQPbsHnMGkH7mV1D9M+839jGdwQtrTyJAVKfJYTq5xb0K5ifPVdsus9hZlQrkogY
 cQqk0jw1bnhd85Dnkm+qeJlQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:21 -0800
IronPort-SDR: lChjNzj7odtW5lgt9e9xIa2kRwsx6MGmNqpjIkDdQGXmL7RwVpgonUbzusvJmxDs9nZP9Muu7N
 fKO6CipxKN7i8MdYW6u4rfzjAYeIlNRaAPsKgNMLMuPyZ+LKNPF5IXI41DDTQpWPbcG5VoLKYe
 7zhd7CqL78urcPU+PgkfXmCNekgwMWHxuhSk8pi37xwPYyDYOb1IDaYoUnjujaMaiimiT1Ck8v
 RGnBxpcDLFFbauhIb/KSEeBthcySNDBBz+5ci4YulSaoHYZITAvg2zqgPWD33ddvKIQmutEDT3
 mAI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:20 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 03/20] btrfs: refactor find_free_dev_extent_start()
Date:   Thu,  6 Feb 2020 19:41:57 +0900
Message-Id: <20200206104214.400857-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out two functions from find_free_dev_extent_start().
dev_extent_search_start() decides the starting position of the search.
dev_extent_hole_check() checks if a hole found is suitable for device
extent allocation.

These functions also have the switch-cases to change the allocation
behavior depending on the policy.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 80 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 60 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index beee9a94142f..9bb673df777a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1384,6 +1384,61 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 	return false;
 }
 
+static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
+{
+	switch (device->fs_devices->chunk_alloc_policy) {
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		/*
+		 * We don't want to overwrite the superblock on the
+		 * drive nor any area used by the boot loader (grub
+		 * for example), so we make sure to start at an offset
+		 * of at least 1MB.
+		 */
+		return max_t(u64, start, SZ_1M);
+	default:
+		BUG();
+	}
+}
+
+/*
+ * dev_extent_hole_check - check if specified hole is suitable for allocation
+ * @device:	the device which we have the hole
+ * @hole_start: starting position of the hole
+ * @hole_size:	the size of the hole
+ * @num_bytes:	the size of the free space that we need
+ *
+ * This function may modify @hole_start and @hole_end to reflect the
+ * suitable position for allocation. Returns 1 if hole position is
+ * updated, 0 otherwise.
+ */
+static int dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
+				 u64 *hole_size, u64 num_bytes)
+{
+	int ret = 0;
+	u64 hole_end = *hole_start + *hole_size;
+
+	/*
+	 * Have to check before we set max_hole_start, otherwise we
+	 * could end up sending back this offset anyway.
+	 */
+	if (contains_pending_extent(device, hole_start, *hole_size)) {
+		if (hole_end >= *hole_start)
+			*hole_size = hole_end - *hole_start;
+		else
+			*hole_size = 0;
+		ret = 1;
+	}
+
+	switch (device->fs_devices->chunk_alloc_policy) {
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		/* No extra check */
+		break;
+	default:
+		BUG();
+	}
+
+	return ret;
+}
 
 /*
  * find_free_dev_extent_start - find free space in the specified device
@@ -1430,12 +1485,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	int slot;
 	struct extent_buffer *l;
 
-	/*
-	 * We don't want to overwrite the superblock on the drive nor any area
-	 * used by the boot loader (grub for example), so we make sure to start
-	 * at an offset of at least 1MB.
-	 */
-	search_start = max_t(u64, search_start, SZ_1M);
+	search_start = dev_extent_search_start(device, search_start);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -1493,18 +1543,8 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 
 		if (key.offset > search_start) {
 			hole_size = key.offset - search_start;
-
-			/*
-			 * Have to check before we set max_hole_start, otherwise
-			 * we could end up sending back this offset anyway.
-			 */
-			if (contains_pending_extent(device, &search_start,
-						    hole_size)) {
-				if (key.offset >= search_start)
-					hole_size = key.offset - search_start;
-				else
-					hole_size = 0;
-			}
+			dev_extent_hole_check(device, &search_start, &hole_size,
+					      num_bytes);
 
 			if (hole_size > max_hole_size) {
 				max_hole_start = search_start;
@@ -1543,8 +1583,8 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	 */
 	if (search_end > search_start) {
 		hole_size = search_end - search_start;
-
-		if (contains_pending_extent(device, &search_start, hole_size)) {
+		if (dev_extent_hole_check(device, &search_start, &hole_size,
+					  num_bytes)) {
 			btrfs_release_path(path);
 			goto again;
 		}
-- 
2.25.0

