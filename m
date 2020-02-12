Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A9615A1B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgBLHVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:05 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBLHVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492066; x=1613028066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R54Qn5BYD/ge6T31YZRw+ymws8jMNomjMOABX4oxaIQ=;
  b=eEPgNgP+2w9bdUgxsWh332xJq38MEcEnc/ABpzyvc3FfQaayEX1zEmkF
   6dk6BHT50pXMV7XzT3J/871PQNR0nyIEsT7e5wzS9Sl1J9NPYP6fYLc4c
   Pd1eS0t0rQkbxs2RMnRfSOWDN6lXTZ5R58wyLTxZDlWzzanCSnPp6pPGw
   qvGi2feJDYmj2/nAJx4zwEbRjd5hOMGLneA95mkdScjHPpskUTv7CGozb
   IpxNHRtGBNWW6GjJ4FKNOxmqL/OQAv26rpwwhVersHGI6JgUzmLgrndCb
   3dvsoOv35PzG7S2BzdER+y1YIu3dGL8wej2XHawNIXEQ6OmuSzBdaZ3TB
   A==;
IronPort-SDR: 9GTPV8F56e21ICsYPiEgHGrgnh8qgbRsHOSwcgNPAiWF2ERR7IVH9ss8dU7HCUCKlkiPAhhMZO
 SkeyG1lmXoUUBuORAY7VKCQsRktySvlaLuKYjcZcl4L3PI4oCz60jnDYrPjRH5PIPerWjgbvb4
 0Kh2mGxRtxtWtDBq9bxBkc93CgHz2Vl+RQIch1wIkzJ68rEFCBqp+YnRe9sEK1ZoKeJMlEkOZS
 nODMOkI1mBkeSwLArpK+nfdUe6joPbCkW2S2LXChMjnp3SIp1xabGVhIyONImYd0prsH5yZnNU
 YD8=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448900"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:06 +0800
IronPort-SDR: 1xGISZkL5R/dtpog7/CWjCvzQrgylaYmlTLeoAAl+fdFaKSqyPttFqLYWUoBMDA+s15NB4eGrx
 GNLJRuKrbQJeOL1n0poytaMxkoyLnn30WJA2dW2unMYgyLoDp+cZz3iy69epJ16qsDZRFV6+61
 cSw5lXv6NWUw6UCzhbj5ak7l/blvslfvb5rd4pjLCITnLrtyNndtsiP+niBh3SfSGGoq93xC/z
 D636RIPhd7ZlELMakMBHtwi+AxWBTWFB7aP3qZeUmLMGwmESZFbKOXjoRCHh8XmFIkDdsgfDrW
 B0IlpOMAqTVv3FaYBiEoMDEl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:13:53 -0800
IronPort-SDR: dZcfl2fTn7jL6aMVpYXq2nAiDLfBKfBhZVN7Hilg3q36HwJkz660aH/oQ2H4xaslWvQjLS/bS+
 LFT8aQcR7zaFWY6XAb3x8lYpOGF/OsCKeAGjWDLe8uVyzt0lNcxbD5no7iX3Um/4MJSif8SYN3
 +xvL0z6YCxDWnIHPgoh0kKCngLcNuC5eu3KN2ZrDJYpIJwOBiG2VhPAQigAXdZpD0h2vtfph8f
 Ey94GcrimOWM9L3TT/3VJON0YexG+cLeWGv3vePY4Sx2OeN5HvFSDc0252BX3HYlGVcpwjcRWx
 BPk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:02 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 04/21] btrfs: refactor find_free_dev_extent_start()
Date:   Wed, 12 Feb 2020 16:20:31 +0900
Message-Id: <20200212072048.629856-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
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
index 9fcbed9b57f9..5f4e875a42f6 100644
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
+/**
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
+static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
+				  u64 *hole_size, u64 num_bytes)
+{
+	bool changed = false;
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
+		changed = true;
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
+	return changed;
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

