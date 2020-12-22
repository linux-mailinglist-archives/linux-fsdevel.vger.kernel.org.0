Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D6E2E04E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgLVDwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:52:02 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46443 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgLVDwC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609121; x=1640145121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tSXU9OaAmTXe/euJxQi8T9mOgyCni/SVnixZLuW3GNU=;
  b=SstOubEVj1paSKLn3PE6ZlfPol4eztNLo9wa3RfapJAiRl8a9U4m37MZ
   aoO0CBxWoshcOAG6qD3Jcz0ZatF9HU7aVxSJbvGi8b3OAAyRrIErDvUWT
   MAlFHncL7H64u0S2j8Ndf+RcTJwTNBJghxTuUW2Jv6rjleQcHET457WCE
   MUGYxZFWLRGvLpBCeQjjsK6FCr+odVvA3zccUK1pWFrqTlVRLH98MFZaZ
   d26/YyVD2zuYOVhSMRjbDfkyBTPR1AM+NoOLPKlTdI1I1WBL7BFEMVVpX
   OPv09bOH+0rsFul6AIf8Lpnyi/SNFp1lhcS+KoR1PU4Ce6KG02nzE17mO
   w==;
IronPort-SDR: +pVDATlNSj3CyuorvZKgQfkAcvG0197cqnmZK7DPLmgCrMlqRVqxUomf4bNSTs9ACsxSLu1YUE
 6LWuEXTJSe35bHbsttmvsf1Q2JroZhWXKkUhOTVt+8FTJ1/FCWZCYFvTarxnu0T/pNEJ20Fihj
 7DeDT6T0dW7kIk7v2BGWYro997Id+SK2fsMyavaAApHTODCJ4EIm21E/rXmEXLWcnw7ZWme4p4
 jBR0pefUpj8kbVbyFteGZ4LnHRGx4/eKgMZHVd7oSsQXHq9gUjfFnFNRDQ3tane/kdXhUP7K43
 +2Y=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193719"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:28 +0800
IronPort-SDR: ql0D5faosnJywUGyZ2zRaItSKaZwj4ypZuROW4Y63X99PlR4vF1lqEEUit9foVAR1u7tJYS0Um
 1KvSWtugVxhrska7ff6CewcdumngvvkNXopE9HiccUmSsIxYbIi+Qv1Kx09IQQg7ZSnIGn969i
 y29080V5NxRNeAKJpH+WDbRn5bSlclKReEIhh6M7Rzrbux/fpbSWA56vNvg9UPjijeDIaoR4Fp
 T6YNNyZ8KqhkmG0jvlFa9uF6pxGn2GQh4366YcgN7Wd4LYlW4FxwzBUTH2yr+shivBwR/lSGya
 izxwpH86ap8Im3Okz9+ALRMN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:35:39 -0800
IronPort-SDR: 8f/F1RMZlcGujEVUi6wh49V5UtvzpvGX21jHcSyQLn+zzxGr1vDiorysPC4vfagm9dEHnAZ+tr
 NAo916jtDKnsZcdUXeywnV50uJZrwKsTV8mL0BogEg1Llcw49ERTtWDIAg23eESYDY4VWuWisJ
 alpuiZpjNSNlJeMJJ89jkQ06MbT96qzkt6VZlSYexOLbQMA9JG7IPejjN3z//9QeRyRcgqWDNq
 QwtSYxBKx0LLiclYs1lZIuV10W+A+437VOpyKUgXwdIqiQczme3tQ9olj7yuTlUB/vvCp3vkPx
 dMU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:28 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 03/40] btrfs: defer loading zone info after opening trees
Date:   Tue, 22 Dec 2020 12:48:56 +0900
Message-Id: <ba41ebbfe3a47b0088a50d7d6eddb28d99cc9d83.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is preparation patch to implement zone emulation on a regular device.

To emulate zoned mode on a regular (non-zoned) device, we need to decide an
emulating zone size. Instead of making it compile-time static value, we'll
make it configurable at mkfs time. Since we have one zone == one device
extent restriction, we can determine the emulated zone size from the size
of a device extent. We can extend btrfs_get_dev_zone_info() to show a
regular device filled with conventional zones once the zone size is
decided.

The current call site of btrfs_get_dev_zone_info() during the mount process
is earlier than reading the trees, so we can't slice a regular device to
conventional zones. This patch defers the loading of zone info to
open_ctree() to load the emulated zone size from a device extent.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 13 +++++++++++++
 fs/btrfs/volumes.c |  4 ----
 fs/btrfs/zoned.c   | 24 ++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  7 +++++++
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 948661554db4..e7b451d30ae2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3257,6 +3257,19 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (ret)
 		goto fail_tree_roots;
 
+	/*
+	 * Get zone type information of zoned block devices. This will also
+	 * handle emulation of the zoned mode for btrfs if a regular device has
+	 * the zoned incompat feature flag set.
+	 */
+	ret = btrfs_get_dev_zone_info_all_devices(fs_info);
+	if (ret) {
+		btrfs_err(fs_info,
+			  "failed to read device zone info: %d",
+			  ret);
+		goto fail_block_groups;
+	}
+
 	/*
 	 * If we have a uuid root and we're not being told to rescan we need to
 	 * check the generation here so we can set the
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2c0aa03b6437..7d92b11ea603 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -669,10 +669,6 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	device->mode = flags;
 
-	ret = btrfs_get_dev_zone_info(device);
-	if (ret != 0)
-		goto error_free_page;
-
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 155545180046..90b8d1d5369f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -143,6 +143,30 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	return 0;
 }
 
+int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	int ret = 0;
+
+	if (!btrfs_fs_incompat(fs_info, ZONED))
+		return 0;
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		/* We can skip reading of zone info for missing devices */
+		if (!device->bdev)
+			continue;
+
+		ret = btrfs_get_dev_zone_info(device);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
+
+	return ret;
+}
+
 int btrfs_get_dev_zone_info(struct btrfs_device *device)
 {
 	struct btrfs_zoned_device_info *zone_info = NULL;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 8abe2f83272b..5e0e7de84a82 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -25,6 +25,7 @@ struct btrfs_zoned_device_info {
 #ifdef CONFIG_BLK_DEV_ZONED
 int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone);
+int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info);
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
@@ -42,6 +43,12 @@ static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 	return 0;
 }
 
+static inline int btrfs_get_dev_zone_info_all_devices(
+	struct btrfs_fs_info *fs_info)
+{
+	return 0;
+}
+
 static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
 {
 	return 0;
-- 
2.27.0

