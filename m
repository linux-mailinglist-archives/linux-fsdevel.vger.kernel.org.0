Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0B72A3B0D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 04:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgKCDbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 22:31:23 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39903 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCDbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604374282; x=1635910282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6dg2MjaQ3fBrE+RwetY5JDOizc0MApdyd2jM72U8yfY=;
  b=WPe3j7j37k6ZJkLH5hm+G8GKtRCSzxwMZrDm4aAI3vR0IvymwaRcPGnB
   hH6KQIXa3UHy1Mv+vFpv0xOr/LW4zQ+nnApfgqo0Egw7qotYUQmwiKvYu
   XcCcoMcdiGjlhZYYPk9H6IyxI2qxV0XaERSRIinNCaQSHL5qxFKbyUYuV
   y0Mwz2fjI8EIc+8df1+JmwpbN9qim5oTK/P9VI8qmlLFxsldANjbdUQM3
   2yQs3jlWb4sAbeiwnOAMOJvM5yKpQJGZuch5Bi5azrcZfTUNsM26y7z7S
   3EvasQR08ES93n+DJBzs2DrEs8jZmAvccwjjod6TXERhw7dAXLFCYq8HN
   Q==;
IronPort-SDR: hzIHEfAW6bHAMDbJ9kwQqAnGDf9P7SNR0FjuIuowmqqxYXGeV4fYyhmuRvEZD59wa2Ps2KAvF4
 cBm42VZcu8JfC0O9ySD5DgFop0k0a4wRNtzj0blDSQSr710MSYXJ9WBVpyS/b8P6ISszhcw+xO
 9BCNLMnWDgeXtbanWRoW22edtqJU86LNxiJdffczvs6Xruakn6hGxbxuUWBzyEY1WpgNIViSex
 JwYgmmNo1rPgnzA3nW9YdEb86Gd/x7ArGqTr1ETybAvdHdRBMDGGplEJa1sY0523+7aywPXCEA
 NyI=
X-IronPort-AV: E=Sophos;i="5.77,446,1596470400"; 
   d="scan'208";a="156052417"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 11:31:21 +0800
IronPort-SDR: iIstjG9NT0aETyDNwoRRu5yTDmDokKaRqnGZJ1TWpLUZvO3z/u+Hf/ex9pIiM9rRA3W9GCY7Ih
 996J7jBLIi+1fwwpEB5Ci5YDTntG1h9DePgpUWSD+bfb8WVENoQVgHF8XeYdrZPii3f5KuX4h8
 aOEVYYqpVQAx9xE/rhIQYry9ejbvxlh3MibBdZH7Mj7afH562Q9sPzDa21S+dsdaE+jASfYZaa
 utp8llBQtCri7S20hNNvebKv2JjdbcnaSltygTWbsTDTw+EwMcEsd5ZKRYZF80M0J/oB+Z4TRS
 AhtBvzDGzFR8yZGksjkmthP8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 19:17:31 -0800
IronPort-SDR: MMKlh3fEEzvaOofR0XQr2wst5E6qXL/RoxY3z6lpqawRUZoLnn7BNGSlsHZaNgxulF8/9BgvH1
 ZpZC2zsSaTjW8h1iD+lkLO51Kc7mMG0+4jV4u2UbevGEEhKbWMXVQEN5pl9T8p0+yyRjxd8GhX
 OqJOcgGaM6lfZF48QpRq6IdlqteDBZIjb8W+AxRObcDMw+HrOOkRqR4rjgXPMwuFgVkoQWrnbG
 fOjBz+KdyOO/WpgK21w9cAnQB306/7vS6wb3woYpLs9SAWYISWje4+BC7wZCBonCeUdQu//fix
 ZlY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 02 Nov 2020 19:31:21 -0800
Received: (nullmailer pid 16124 invoked by uid 1000);
        Tue, 03 Nov 2020 03:31:20 -0000
Date:   Tue, 3 Nov 2020 12:31:20 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 11/41] btrfs: implement log-structured superblock for
 ZONED mode
Message-ID: <20201103033120.yi423j34yzesuyhk@naota.dhcp.fujisawa.hgst.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
 <b3447a50-0178-6779-060d-655d596d27a0@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b3447a50-0178-6779-060d-655d596d27a0@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 01:54:14PM -0500, Josef Bacik wrote:
>On 10/30/20 9:51 AM, Naohiro Aota wrote:
>>Superblock (and its copies) is the only data structure in btrfs which has a
>>fixed location on a device. Since we cannot overwrite in a sequential write
>>required zone, we cannot place superblock in the zone. One easy solution is
>>limiting superblock and copies to be placed only in conventional zones.
>>However, this method has two downsides: one is reduced number of superblock
>>copies. The location of the second copy of superblock is 256GB, which is in
>>a sequential write required zone on typical devices in the market today.
>>So, the number of superblock and copies is limited to be two.  Second
>>downside is that we cannot support devices which have no conventional zones
>>at all.
>>
>>To solve these two problems, we employ superblock log writing. It uses two
>>zones as a circular buffer to write updated superblocks. Once the first
>>zone is filled up, start writing into the second buffer. Then, when the
>>both zones are filled up and before start writing to the first zone again,
>>it reset the first zone.
>>
>>We can determine the position of the latest superblock by reading write
>>pointer information from a device. One corner case is when the both zones
>>are full. For this situation, we read out the last superblock of each
>>zone, and compare them to determine which zone is older.
>>
>>The following zones are reserved as the circular buffer on ZONED btrfs.
>>
>>- The primary superblock: zones 0 and 1
>>- The first copy: zones 16 and 17
>>- The second copy: zones 1024 or zone at 256GB which is minimum, and next
>>   to it
>>
>>If these reserved zones are conventional, superblock is written fixed at
>>the start of the zone without logging.
>>
>
><snip>
>
>>  /*
>>   * This is only the first step towards a full-features scrub. It reads all
>>@@ -3704,6 +3705,8 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>>  		if (bytenr + BTRFS_SUPER_INFO_SIZE >
>>  		    scrub_dev->commit_total_bytes)
>>  			break;
>>+		if (!btrfs_check_super_location(scrub_dev, bytenr))
>>+			continue;
>
>Any reason in particular we're skipping scrubbing supers here?  Can't 
>we just lookup the bytenr and do the right thing here?

Hmm, technically, we can do something here, but I'm not sure it's useful to
scrub superblocks for zoned devices where superblocks are log-structured.
We can read and check if the latest superblock in the log is valid. But,
when we find it's not correct, we cannot overwrite it anyway. Instead, we
can append a new superblock to the log. But this is no different than
normal sync... Furthermore, the scrub-checked superblock might already be
out-dated at the time of reading.

We might want to read and check each entry of the log. And warn the user
when a superblock is corrupted. It's totally different from current
scrub_supers(), so we will need another helper function for it.

>
>>  		ret = scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
>>  				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
>>diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>index 10827892c086..db884b96a5ea 100644
>>--- a/fs/btrfs/volumes.c
>>+++ b/fs/btrfs/volumes.c
>>@@ -1282,7 +1282,8 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
>>  }
>>  static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
>>-						       u64 bytenr)
>>+						       u64 bytenr,
>>+						       u64 bytenr_orig)
>>  {
>>  	struct btrfs_super_block *disk_super;
>>  	struct page *page;
>>@@ -1313,7 +1314,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
>>  	/* align our pointer to the offset of the super block */
>>  	disk_super = p + offset_in_page(bytenr);
>>-	if (btrfs_super_bytenr(disk_super) != bytenr ||
>>+	if (btrfs_super_bytenr(disk_super) != bytenr_orig ||
>>  	    btrfs_super_magic(disk_super) != BTRFS_MAGIC) {
>>  		btrfs_release_disk_super(p);
>>  		return ERR_PTR(-EINVAL);
>>@@ -1348,7 +1349,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>>  	bool new_device_added = false;
>>  	struct btrfs_device *device = NULL;
>>  	struct block_device *bdev;
>>-	u64 bytenr;
>>+	u64 bytenr, bytenr_orig;
>>+	int ret;
>>  	lockdep_assert_held(&uuid_mutex);
>>@@ -1358,14 +1360,18 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>>  	 * So, we need to add a special mount option to scan for
>>  	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
>>  	 */
>>-	bytenr = btrfs_sb_offset(0);
>>  	flags |= FMODE_EXCL;
>>  	bdev = blkdev_get_by_path(path, flags, holder);
>>  	if (IS_ERR(bdev))
>>  		return ERR_CAST(bdev);
>>-	disk_super = btrfs_read_disk_super(bdev, bytenr);
>>+	bytenr_orig = btrfs_sb_offset(0);
>>+	ret = btrfs_sb_log_location_bdev(bdev, 0, READ, &bytenr);
>>+	if (ret)
>>+		return ERR_PTR(ret);
>>+
>>+	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr_orig);
>>  	if (IS_ERR(disk_super)) {
>>  		device = ERR_CAST(disk_super);
>>  		goto error_bdev_put;
>>@@ -2029,6 +2035,11 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
>>  		if (IS_ERR(disk_super))
>>  			continue;
>>+		if (bdev_is_zoned(bdev)) {
>>+			btrfs_reset_sb_log_zones(bdev, copy_num);
>>+			continue;
>>+		}
>>+
>>  		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
>>  		page = virt_to_page(disk_super);
>>diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>index ae509699da14..d5487cba203b 100644
>>--- a/fs/btrfs/zoned.c
>>+++ b/fs/btrfs/zoned.c
>>@@ -20,6 +20,25 @@ static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx,
>>  	return 0;
>>  }
>>+static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zone,
>>+			    u64 *wp_ret);
>>+
>>+static inline u32 sb_zone_number(u8 shift, int mirror)
>>+{
>>+	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
>>+
>>+	switch (mirror) {
>>+	case 0:
>>+		return 0;
>>+	case 1:
>>+		return 16;
>>+	case 2:
>>+		return min(btrfs_sb_offset(mirror) >> shift, 1024ULL);
>>+	}
>>+
>
>Can we get a comment here explaining the zone numbers?

Sure. I'll add one.

>
>>+	return 0;
>>+}
>>+
>>  static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>>  			       struct blk_zone *zones, unsigned int *nr_zones)
>>  {
>>@@ -123,6 +142,49 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>>  		goto out;
>>  	}
>>+	/* validate superblock log */
>>+	nr_zones = 2;
>>+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
>>+		u32 sb_zone = sb_zone_number(zone_info->zone_size_shift, i);
>>+		u64 sb_wp;
>>+
>
>I'd rather see
>
>#define BTRFS_NR_ZONED_SB_ZONES 2
>
>or something equally poorly named and use that instead of our magic 2 everywhere.
>
>Then you can just do
>
>int index = i * BTRFS_NR_ZONED_SB_ZONES;
>&zone_info->sb_zones[index];

I'll do so. BTRFS_NR_ZONED_SB_ZONES is duplicating "ZONE", so how about
BTRFS_NR_SB_LOG_ZONES ?


>
><snip>
>
>>+static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
>>+			   int rw, u64 *bytenr_ret)
>>+{
>>+	u64 wp;
>>+	int ret;
>>+
>>+	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
>>+		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
>>+		return 0;
>>+	}
>>+
>>+	ret = sb_write_pointer(bdev, zones, &wp);
>>+	if (ret != -ENOENT && ret < 0)
>>+		return ret;
>>+
>>+	if (rw == WRITE) {
>>+		struct blk_zone *reset = NULL;
>>+
>>+		if (wp == zones[0].start << SECTOR_SHIFT)
>>+			reset = &zones[0];
>>+		else if (wp == zones[1].start << SECTOR_SHIFT)
>>+			reset = &zones[1];
>>+
>>+		if (reset && reset->cond != BLK_ZONE_COND_EMPTY) {
>>+			ASSERT(reset->cond == BLK_ZONE_COND_FULL);
>>+
>>+			ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
>>+					       reset->start, reset->len,
>>+					       GFP_NOFS);
>
>What happens if we crash right after this?  Is the WP set to the start 
>of the zone here?  Does this mean we'll simply miss the super block?  
>I understand we're resetting one zone here, but we're doing this in 
>order, so we'll reset one and write one, then reset the other and 
>write the next.  We don't wait until we've issued the writes for 
>everything, so it appears to me that there's a gap where we could have 
>the WP pointed at the start of the zone, which we view as an invalid 
>state and thus won't be able to mount the file system.  Or am I 
>missing something?  Thanks,

Here, we reset a zone we're going to write which contains the older
superblocks. And in this case, we should have the other zone fully written.
So, even after a reset and a crash, we still have the latest superblock in
the other zone.

>
>Josef
