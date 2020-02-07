Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64E71552BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 08:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgBGHIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 02:08:41 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17146 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGHIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581059320; x=1612595320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RKdfAN9ww0gG2V/iZer/uAd+gY0uAFMVYY1JFWipPf8=;
  b=lUpjwB+mbeHgczfknSJxXwwhEXqNjaeXWUWb+YLqxlvUCgEGAI3MZkCm
   suSOSok9qRxpfLNnGtqQUut5IQpPbbcH6OlFOwcRj+vAA/IsHWM/sI5lO
   GL/JuUhipym5zyPK3207yICBaHFCkdZ74MawBAj4qTrCRsoduVME7qfnO
   9DiJzQOwbOvsB1A6BVuWQFzsFSJzfowBXbG4MX4sF4CinJRnv42/V+2Bm
   GQxgUcJbs/V2Y5VUuP2SspfGp0U7U1hBCs3H0XN00P/r6OmOeBmXnc+xR
   8VSHW7x3mX+n0cRI2SuZIIPu35BXS7exgwUcTWvRCvNTwHB5WOhr61xiR
   A==;
IronPort-SDR: EEP6zcIGJyGhiKLy1g7rL4F7HKvKXc1TWqwGiKuuQADvtT1htzdcD6B2Fjlit1C9hW1o+TsKKJ
 ELv7QTP8R06mX4TMUHb9FCL6YirN3EWMJsWZHepG8tJdZJLAIvnGFUnD1honoYxPjqIoS/a3OZ
 4OPJ++tygCIpDs8d+rrXt5CX6X08QYvmW/dZJfvivQCAvCis1FbuB62EM/YFVqDGdxqmzTBpjZ
 x488FONyvrPjmS20O9LrG7ejXuhxE11xhBlYgJ93IujnykbJl1IQIKkpAI1kFrUTZSGIYxGKbX
 ZlE=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="237313421"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 15:08:39 +0800
IronPort-SDR: 34c/Dx3ZjKiWfc5uP56gi65QTBzGWD1I6qNZTiLxRL1dus8411DQe+eY9DNZ57O6iMT6KXQ0MI
 E7qZfc1Tha2vJO2dohjADN8etoQSziD2Z2879i15JrNCOrMPUDrYsxmxt4q3y/dll9OzPsNslp
 f7S+BfbsXGFqlqzGkUlgoa+g18j7R944fNOEdkTAXc6HrLWwp+bRe84UJcx07UeY8nM8dribit
 WIbYaWC1bKr0phF/6+1xBZfH1YLrAnX3vpnmrI0wI2A+KN7mIw+PBu9T+ARcH/MKIaMJWHexVu
 4Z/CEziow0jqu/+FArqRYHzK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 23:01:37 -0800
IronPort-SDR: FEyHFu1e9sKbbnQjItdtsFC0aJ55++KyvDxvzXxucNY1e48nddQujMBEe7kt7acXFX1yfgz5Fq
 OyGhfnnoWxlhgZ3RWVy1rFjij8hE3aWGYgti3QqUsaebNOSaQtkm9B3xQcuIjwUhNcqVk9br2n
 X7AZ53hJE54HmiHWzWKlIBFLMWlwwcE+JxRsa9geSZfdCyCYeKyfR5dun9Q2f2bA4dvUqIylmh
 1vxD2nKSKZtYVxACKZEGI71cRkAWsh1WDzYxdLBXuEZ1yaqnihPOmSCcZo17044FpJJbfoSoiq
 SN0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 06 Feb 2020 23:08:38 -0800
Received: (nullmailer pid 806499 invoked by uid 1000);
        Fri, 07 Feb 2020 07:08:37 -0000
Date:   Fri, 7 Feb 2020 16:08:37 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/20] btrfs: introduce alloc_chunk_ctl
Message-ID: <20200207070837.ntitaxng6wvcmne5@naota.dhcp.fujisawa.hgst.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-5-naohiro.aota@wdc.com>
 <bcccefe4-8cff-d50d-ddd1-784e3d194607@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bcccefe4-8cff-d50d-ddd1-784e3d194607@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 11:38:14AM -0500, Josef Bacik wrote:
>On 2/6/20 5:41 AM, Naohiro Aota wrote:
>>Introduce "struct alloc_chunk_ctl" to wrap needed parameters for the chunk
>>allocation.  This will be used to split __btrfs_alloc_chunk() into smaller
>>functions.
>>
>>This commit folds a number of local variables in __btrfs_alloc_chunk() into
>>one "struct alloc_chunk_ctl ctl". There is no functional change.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/volumes.c | 143 +++++++++++++++++++++++++--------------------
>>  1 file changed, 81 insertions(+), 62 deletions(-)
>>
>>diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>index 9bb673df777a..cfde302bf297 100644
>>--- a/fs/btrfs/volumes.c
>>+++ b/fs/btrfs/volumes.c
>>@@ -4818,6 +4818,29 @@ static void check_raid1c34_incompat_flag(struct btrfs_fs_info *info, u64 type)
>>  	btrfs_set_fs_incompat(info, RAID1C34);
>>  }
>>+/*
>>+ * Structure used internally for __btrfs_alloc_chunk() function.
>>+ * Wraps needed parameters.
>>+ */
>>+struct alloc_chunk_ctl {
>>+	u64 start;
>>+	u64 type;
>>+	int num_stripes;	/* total number of stripes to allocate */
>>+	int sub_stripes;	/* sub_stripes info for map */
>>+	int dev_stripes;	/* stripes per dev */
>>+	int devs_max;		/* max devs to use */
>>+	int devs_min;		/* min devs needed */
>>+	int devs_increment;	/* ndevs has to be a multiple of this */
>>+	int ncopies;		/* how many copies to data has */
>>+	int nparity;		/* number of stripes worth of bytes to
>>+				   store parity information */
>>+	u64 max_stripe_size;
>>+	u64 max_chunk_size;
>>+	u64 stripe_size;
>>+	u64 chunk_size;
>>+	int ndevs;
>>+};
>>+
>>  static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>  			       u64 start, u64 type)
>>  {
>>@@ -4828,23 +4851,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>  	struct extent_map_tree *em_tree;
>>  	struct extent_map *em;
>>  	struct btrfs_device_info *devices_info = NULL;
>>+	struct alloc_chunk_ctl ctl;
>>  	u64 total_avail;
>>-	int num_stripes;	/* total number of stripes to allocate */
>>  	int data_stripes;	/* number of stripes that count for
>>  				   block group size */
>>-	int sub_stripes;	/* sub_stripes info for map */
>>-	int dev_stripes;	/* stripes per dev */
>>-	int devs_max;		/* max devs to use */
>>-	int devs_min;		/* min devs needed */
>>-	int devs_increment;	/* ndevs has to be a multiple of this */
>>-	int ncopies;		/* how many copies to data has */
>>-	int nparity;		/* number of stripes worth of bytes to
>>-				   store parity information */
>>  	int ret;
>>-	u64 max_stripe_size;
>>-	u64 max_chunk_size;
>>-	u64 stripe_size;
>>-	u64 chunk_size;
>>  	int ndevs;
>>  	int i;
>>  	int j;
>>@@ -4858,32 +4869,36 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>  		return -ENOSPC;
>>  	}
>>+	ctl.start = start;
>>+	ctl.type = type;
>>+
>>  	index = btrfs_bg_flags_to_raid_index(type);
>>-	sub_stripes = btrfs_raid_array[index].sub_stripes;
>>-	dev_stripes = btrfs_raid_array[index].dev_stripes;
>>-	devs_max = btrfs_raid_array[index].devs_max;
>>-	if (!devs_max)
>>-		devs_max = BTRFS_MAX_DEVS(info);
>>-	devs_min = btrfs_raid_array[index].devs_min;
>>-	devs_increment = btrfs_raid_array[index].devs_increment;
>>-	ncopies = btrfs_raid_array[index].ncopies;
>>-	nparity = btrfs_raid_array[index].nparity;
>>+	ctl.sub_stripes = btrfs_raid_array[index].sub_stripes;
>>+	ctl.dev_stripes = btrfs_raid_array[index].dev_stripes;
>>+	ctl.devs_max = btrfs_raid_array[index].devs_max;
>>+	if (!ctl.devs_max)
>>+		ctl.devs_max = BTRFS_MAX_DEVS(info);
>>+	ctl.devs_min = btrfs_raid_array[index].devs_min;
>>+	ctl.devs_increment = btrfs_raid_array[index].devs_increment;
>>+	ctl.ncopies = btrfs_raid_array[index].ncopies;
>>+	ctl.nparity = btrfs_raid_array[index].nparity;
>>  	if (type & BTRFS_BLOCK_GROUP_DATA) {
>>-		max_stripe_size = SZ_1G;
>>-		max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
>>+		ctl.max_stripe_size = SZ_1G;
>>+		ctl.max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
>>  	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
>>  		/* for larger filesystems, use larger metadata chunks */
>>  		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
>>-			max_stripe_size = SZ_1G;
>>+			ctl.max_stripe_size = SZ_1G;
>>  		else
>>-			max_stripe_size = SZ_256M;
>>-		max_chunk_size = max_stripe_size;
>>+			ctl.max_stripe_size = SZ_256M;
>>+		ctl.max_chunk_size = ctl.max_stripe_size;
>>  	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
>>-		max_stripe_size = SZ_32M;
>>-		max_chunk_size = 2 * max_stripe_size;
>>-		devs_max = min_t(int, devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
>>+		ctl.max_stripe_size = SZ_32M;
>>+		ctl.max_chunk_size = 2 * ctl.max_stripe_size;
>>+		ctl.devs_max = min_t(int, ctl.devs_max,
>>+				      BTRFS_MAX_DEVS_SYS_CHUNK);
>>  	} else {
>>  		btrfs_err(info, "invalid chunk type 0x%llx requested",
>>  		       type);
>>@@ -4891,8 +4906,8 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>  	}
>>  	/* We don't want a chunk larger than 10% of writable space */
>>-	max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
>>-			     max_chunk_size);
>>+	ctl.max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
>>+				  ctl.max_chunk_size);
>>  	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
>>  			       GFP_NOFS);
>>@@ -4929,20 +4944,20 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>  			continue;
>>  		ret = find_free_dev_extent(device,
>>-					   max_stripe_size * dev_stripes,
>>+				ctl.max_stripe_size * ctl.dev_stripes,
>>  					   &dev_offset, &max_avail);
>
>If you are going to adjust the indentation of arguments, you need to 
>adjust them all.
>

So, the below would be fine here, right?

		ret = find_free_dev_extent(
			device, ctl.max_stripe_size * ctl.dev_stripes,
			&dev_offset, &max_avail);


>>  		if (ret && ret != -ENOSPC)
>>  			goto error;
>>  		if (ret == 0)
>>-			max_avail = max_stripe_size * dev_stripes;
>>+			max_avail = ctl.max_stripe_size * ctl.dev_stripes;
>>-		if (max_avail < BTRFS_STRIPE_LEN * dev_stripes) {
>>+		if (max_avail < BTRFS_STRIPE_LEN * ctl.dev_stripes) {
>>  			if (btrfs_test_opt(info, ENOSPC_DEBUG))
>>  				btrfs_debug(info,
>>  			"%s: devid %llu has no free space, have=%llu want=%u",
>>  					    __func__, device->devid, max_avail,
>>-					    BTRFS_STRIPE_LEN * dev_stripes);
>>+				BTRFS_STRIPE_LEN * ctl.dev_stripes);
>
>Same here.

Actually, the line fit in just 80 characters, so I removed the indent.

>>  			continue;
>>  		}
>>@@ -4957,30 +4972,31 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>  		devices_info[ndevs].dev = device;
>>  		++ndevs;
>>  	}
>>+	ctl.ndevs = ndevs;
>>  	/*
>>  	 * now sort the devices by hole size / available space
>>  	 */
>>-	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>>+	sort(devices_info, ctl.ndevs, sizeof(struct btrfs_device_info),
>>  	     btrfs_cmp_device_info, NULL);
>>  	/*
>>  	 * Round down to number of usable stripes, devs_increment can be any
>>  	 * number so we can't use round_down()
>>  	 */
>>-	ndevs -= ndevs % devs_increment;
>>+	ctl.ndevs -= ctl.ndevs % ctl.devs_increment;
>>-	if (ndevs < devs_min) {
>>+	if (ctl.ndevs < ctl.devs_min) {
>>  		ret = -ENOSPC;
>>  		if (btrfs_test_opt(info, ENOSPC_DEBUG)) {
>>  			btrfs_debug(info,
>>  	"%s: not enough devices with free space: have=%d minimum required=%d",
>>-				    __func__, ndevs, devs_min);
>>+				    __func__, ctl.ndevs, ctl.devs_min);
>>  		}
>>  		goto error;
>>  	}
>>-	ndevs = min(ndevs, devs_max);
>>+	ctl.ndevs = min(ctl.ndevs, ctl.devs_max);
>>  	/*
>>  	 * The primary goal is to maximize the number of stripes, so use as
>>@@ -4989,14 +5005,15 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>  	 * The DUP profile stores more than one stripe per device, the
>>  	 * max_avail is the total size so we have to adjust.
>>  	 */
>>-	stripe_size = div_u64(devices_info[ndevs - 1].max_avail, dev_stripes);
>>-	num_stripes = ndevs * dev_stripes;
>>+	ctl.stripe_size = div_u64(devices_info[ctl.ndevs - 1].max_avail,
>>+				   ctl.dev_stripes);
>>+	ctl.num_stripes = ctl.ndevs * ctl.dev_stripes;
>>  	/*
>>  	 * this will have to be fixed for RAID1 and RAID10 over
>>  	 * more drives
>>  	 */
>>-	data_stripes = (num_stripes - nparity) / ncopies;
>>+	data_stripes = (ctl.num_stripes - ctl.nparity) / ctl.ncopies;
>>  	/*
>>  	 * Use the number of data stripes to figure out how big this chunk
>>@@ -5004,44 +5021,44 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>  	 * and compare that answer with the max chunk size. If it's higher,
>>  	 * we try to reduce stripe_size.
>>  	 */
>>-	if (stripe_size * data_stripes > max_chunk_size) {
>>+	if (ctl.stripe_size * data_stripes > ctl.max_chunk_size) {
>>  		/*
>>  		 * Reduce stripe_size, round it up to a 16MB boundary again and
>>  		 * then use it, unless it ends up being even bigger than the
>>  		 * previous value we had already.
>>  		 */
>>-		stripe_size = min(round_up(div_u64(max_chunk_size,
>>+		ctl.stripe_size = min(round_up(div_u64(ctl.max_chunk_size,
>>  						   data_stripes), SZ_16M),
>>-				  stripe_size);
>>+				       ctl.stripe_size);
>
>And here.  Thanks,

Changed to:

		ctl.stripe_size =
			min(round_up(div_u64(ctl.max_chunk_size, data_stripes),
				     SZ_16M),
			    ctl.stripe_size);

Thanks,
