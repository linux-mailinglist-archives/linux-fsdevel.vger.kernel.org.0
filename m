Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E252A92DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 10:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgKFJg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 04:36:28 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28571 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgKFJg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604655844; x=1636191844;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=LNTGPvW2rXbc4sY6UH3O2/uy6ZSk/ZkVxJfrdNq3btw=;
  b=mniwXobWcKBeQFHmC9jKndmon/GA3gToY+gfJgYZliJhUL4ryyB+spJO
   iFQm6QYtKtG+8taCM81ow37WCXxaJnxlRO2Qy8xLxeOdAxRXUUPU27Pxh
   sUwTiV+kar3yiEYt2smUDizgXAFS/W+tTtnVLGIj2VcfWWTI9oecLqGXq
   PhCYk5HbjjRdZlbPASnHRGIqGSh+ZH97Qi2nnozaQDaibGsl9VsT32Cmm
   NzpTsGJSo8KRVW5KzL6XRLcGgk060b2hisJkyFwskC7AuZd7PCR43hyUM
   ytbOQhAnSsuaryr1UN+/htTR8NPtCbqcCnf7AiOGac1d8QMb5B0XDSWk6
   Q==;
IronPort-SDR: 8OD7dgZkxmBgVrtLObcAXrN/Epocet/0A5loDhH+yXNTySM+GQuvFPGFgV+jQnDiLkWCKggu1o
 howgCpURQD5F8ZTQKpTZ5K9kJLbYcz2KJ9pE/aySKt7LRwFtxnuqO73e9b97buOK1ISKKmuOtg
 zPjRPSpVFjOV839YgPIXC1IuNf1qdW0YewZ0EBIhAP54Dqlul6//sfEon3QB2QMNsXfvqaPqcm
 gI4veBYMdM7cTP7XX8e0JHZNQk9Lij/s+37msc3SeNzMvzZYNYPB/ss1V+/R2/KxhU3kYkAl+D
 veo=
X-IronPort-AV: E=Sophos;i="5.77,456,1596470400"; 
   d="scan'208";a="255564748"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 17:44:03 +0800
IronPort-SDR: vU04VRNKxRYzSVBAv7JHx7KNYuw1jK6lylP42S1YhxqpBsAfgtuatpYQefjpkpSOHbLWL183LO
 xTv2I7Gxr8VRP8xRSb7c5I5cCou5sFtpAGbxAh5Yq1xBzRnp1mLqrtDZddJdK3uUJCQPbhfx7F
 64oqlt7yP7Ud50nNvemz9k9hTrkd6AV4P0rAajp4FsYDYBhSCPIb6jtYBK5YLI1z2vsMtKqg0w
 16UvTC9zbYfXwLq+YQReCZF/+5suwhdr3Sd5+SK1z8rWwKJjMoJTd6sNDb9NH4Di0tdzH0sPVj
 S7KQIc6sGEaf8+ByRi38TVTY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 01:22:32 -0800
IronPort-SDR: levOFlVTtLGMSVW+ESaiCHPxEmtAM+R8kM0W0P04EcKx8yQ2c/O7S27K0EBUXRNl1FNWynIE9S
 5iPoLVSxjh0PhK1H4SQvQVZDl82mVBp6rl6YoZcgf8hml7Lj2tBHTSFIahgGkRseq+1rMZ7bnt
 swxfwrwNFdPW8POw0D8b9Pv2VTk4OimREjDP3EtrcvT76WtsziTP8wkRvffCDLI+4dWUHqv6lm
 hESy8cS33VS4RFr7kI7DGFVuwq3NS61CQPTTlmy1zbhPZHI16FsMLaflAA+821zHvq+14Mv2zF
 8qw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 06 Nov 2020 01:36:26 -0800
Received: (nullmailer pid 1927775 invoked by uid 1000);
        Fri, 06 Nov 2020 09:36:24 -0000
Date:   Fri, 6 Nov 2020 18:36:24 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v9 05/41] btrfs: Check and enable ZONED mode
Message-ID: <20201106093624.asuonbl75g52uu7s@naota.dhcp.fujisawa.hgst.com>
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <599d306d41880e3e3242120a40a78b81f6ed0473.1604065695.git.naohiro.aota@wdc.com>
 <20201103121345.GP6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201103121345.GP6756@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:13:45PM +0100, David Sterba wrote:
>Below are suggested message updates, common prefix "zoned:" in case it
>happens inside the zone mode implementation. Some of them sound strange
>when repeating 'zoned', but for clarity I think it should stay, unless
>somebody has a better suggestion.
>
>On Fri, Oct 30, 2020 at 10:51:12PM +0900, Naohiro Aota wrote:
>> index aac3d6f4e35b..25fd4e97dd2a 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -3595,4 +3601,8 @@ static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
>>  }
>>  #endif
>>
>> +static inline bool btrfs_is_zoned(struct btrfs_fs_info *fs_info)
>> +{
>> +	return fs_info->zoned != 0;
>> +}
>
>newline
>
>>  #endif
>
>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
>> index 6f6d77224c2b..5e3554482af1 100644
>> --- a/fs/btrfs/dev-replace.c
>> +++ b/fs/btrfs/dev-replace.c
>> @@ -238,6 +238,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>>  		return PTR_ERR(bdev);
>>  	}
>>
>> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
>> +		btrfs_err(fs_info,
>> +			  "zone type of target device mismatch with the filesystem!");
>
>		"dev-replace: zoned type of target device mismatch with filesystem"
>
>> +		ret = -EINVAL;
>> +		goto error;
>> +	}
>> +
>>  	sync_blockdev(bdev);
>>
>>  	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 764001609a15..9bc51cff48b8 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3130,7 +3133,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>
>>  	btrfs_free_extra_devids(fs_devices, 1);
>>
>> +	ret = btrfs_check_zoned_mode(fs_info);
>> +	if (ret) {
>> +		btrfs_err(fs_info, "failed to init ZONED mode: %d",
>
>		"failed to inititialize zoned mode: %d"
>
>> +				ret);
>> +		goto fail_block_groups;
>> +	}
>> +
>>  	ret = btrfs_sysfs_add_fsid(fs_devices);
>> +
>>  	if (ret) {
>>  		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
>>  				ret);
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> +	u64 nr_devices = 0;
>> +	u64 zone_size = 0;
>> +	int incompat_zoned = btrfs_is_zoned(fs_info);
>
>	const bool
>
>> +	int ret = 0;
>> +
>> +	/* Count zoned devices */
>> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
>> +		enum blk_zoned_model model;
>> +
>> +		if (!device->bdev)
>> +			continue;
>> +
>> +		model = bdev_zoned_model(device->bdev);
>> +		if (model == BLK_ZONED_HM ||
>> +		    (model == BLK_ZONED_HA && incompat_zoned)) {
>> +			hmzoned_devices++;
>> +			if (!zone_size) {
>> +				zone_size = device->zone_info->zone_size;
>> +			} else if (device->zone_info->zone_size != zone_size) {
>> +				btrfs_err(fs_info,
>> +					  "Zoned block devices must have equal zone sizes");
>
>				"zoned: unequal block device zone sizes: have %u found %u"
>
>> +				ret = -EINVAL;
>> +				goto out;
>> +			}
>> +		}
>> +		nr_devices++;
>> +	}
>> +
>> +	if (!hmzoned_devices && !incompat_zoned)
>> +		goto out;
>> +
>> +	if (!hmzoned_devices && incompat_zoned) {
>> +		/* No zoned block device found on ZONED FS */
>> +		btrfs_err(fs_info,
>> +			  "ZONED enabled file system should have zoned devices");
>
>		"zoned: no zoned devices found on a zoned filesystem"
>
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	if (hmzoned_devices && !incompat_zoned) {
>> +		btrfs_err(fs_info,
>> +			  "Enable ZONED mode to mount HMZONED device");
>
>Is HMZONED reference leftover from previous iterations?
>
>		"zoned: mode not enabled but zoned device found"

It was intentional here to use "hmzoned", because we can technically use
Host-Aware Zoned device as regular device, so I'd like to distinguish
hmzoned vs hazoned. But, reading the code again, I changed my mind. We can
just say "a HMZONED device" or "a HAZONED device in ZONED mode" as a zoned
device. Actually, I was not counting "hazoned_devices" anyway. So, I'll
rename hmzoned_devices to zoned_devices in the next version.
