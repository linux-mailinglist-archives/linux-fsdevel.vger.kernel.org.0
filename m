Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B54411E7F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 17:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfLMQS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 11:18:57 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44015 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbfLMQS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:18:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so2113535qke.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 08:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+ElOkwYuZmhuEggAYqFWeqRcKURvbMbcbDB8ADBw9E=;
        b=q6BW2zJ5NaOI/L9MQ4C/pxsZUKCb6HgQKWitgRFUdOinrERr9wEOw98ktZOUHb/ob4
         2RfKgX8QPwH/edKbdIXGcCFHSgGOs6ILDmU+p3zZ76E+SKEdaQ/GD1uVd4ii3QcBayqV
         ejxtDwdBat4ViXlb758oBJ86NwhEMjTp8Ub4qHgKg4r+QdFyGm1FSO8Z/ywI9s3sQ3yE
         mIjio+8xzwIWc1yyWLOqXp95eJ5qsQHkNHt4iRebhZWKpmzV4sLFuKB9Leyts3IA162F
         bW43sm0YpNoZSBQgzbaIfxu8CQAp2STZLm0Kh03fd1pS3Js9T92oMxUTUSKuWtC6oUcg
         b22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+ElOkwYuZmhuEggAYqFWeqRcKURvbMbcbDB8ADBw9E=;
        b=puDjA4RausSJbT+RKL1Lk3bvXyhYWs0aMZRr8G0wvEFZnXkdapdoOe2BJawKQnVA6q
         Ff3+EO+6fqiuiL26ob+MWqysOGSsz4BCS6iUI5CZ185t5Ecv77KxXA8jRUlJ2sUHA60m
         Fj8i/hROY8y/A3DG3m3f9UO1tEqePWHjPKSdRAPpGFueBgjKzYZ0sQeCoK1KNOXQjHR7
         cjVY+mNDTMccf/T0D2lwJaEWn+Mrqzupw0ccaw/j17RQxsCHnPrXHdpGRcT2j4Pe5XIh
         9zgP1WsIOOVe0vGd/WHRR/4uoybzACAxnPq2/yidL4Ydj0tR0lQtQHHYjrywE9oIYFNF
         s+Dg==
X-Gm-Message-State: APjAAAW9u/hdsLYogl4q9vwlSb4KB5eIjWXoxeCl52rfd8QpeDwChJn7
        8NUU6xNQERVpa1btA8ncYjKYOrHUenvtTA==
X-Google-Smtp-Source: APXvYqzblLdAg3Ari9GYwdZQr6vkb9XotV55rB2jNuuV9r5FO01Q2Bph9sGltPhx27cVAKAJY6XHgQ==
X-Received: by 2002:a37:e404:: with SMTP id y4mr14254163qkf.356.1576253935503;
        Fri, 13 Dec 2019 08:18:55 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4e65])
        by smtp.gmail.com with ESMTPSA id z8sm3647407qth.16.2019.12.13.08.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 08:18:54 -0800 (PST)
Subject: Re: [PATCH v6 02/28] btrfs: Get zone information of zoned block
 devices
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-3-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d4cccf98-a01a-8d2f-40fe-e2f356a037a0@toxicpanda.com>
Date:   Fri, 13 Dec 2019 11:18:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-3-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> If a zoned block device is found, get its zone information (number of zones
> and zone size) using the new helper function btrfs_get_dev_zone_info().  To
> avoid costly run-time zone report commands to test the device zones type
> during block allocation, attach the seq_zones bitmap to the device
> structure to indicate if a zone is sequential or accept random writes. Also
> it attaches the empty_zones bitmap to indicate if a zone is empty or not.
> 
> This patch also introduces the helper function btrfs_dev_is_sequential() to
> test if the zone storing a block is a sequential write required zone and
> btrfs_dev_is_empty_zone() to test if the zone is a empty zone.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/Makefile  |   1 +
>   fs/btrfs/hmzoned.c | 168 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/hmzoned.h |  92 +++++++++++++++++++++++++
>   fs/btrfs/volumes.c |  18 ++++-
>   fs/btrfs/volumes.h |   4 ++
>   5 files changed, 281 insertions(+), 2 deletions(-)
>   create mode 100644 fs/btrfs/hmzoned.c
>   create mode 100644 fs/btrfs/hmzoned.h
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 82200dbca5ac..64aaeed397a4 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -16,6 +16,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>   btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>   btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
>   btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
> +btrfs-$(CONFIG_BLK_DEV_ZONED) += hmzoned.o
>   
>   btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
>   	tests/extent-buffer-tests.o tests/btrfs-tests.o \
> diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
> new file mode 100644
> index 000000000000..6a13763d2916
> --- /dev/null
> +++ b/fs/btrfs/hmzoned.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + * Authors:
> + *	Naohiro Aota	<naohiro.aota@wdc.com>
> + *	Damien Le Moal	<damien.lemoal@wdc.com>
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/blkdev.h>
> +#include "ctree.h"
> +#include "volumes.h"
> +#include "hmzoned.h"
> +#include "rcu-string.h"
> +
> +/* Maximum number of zones to report per blkdev_report_zones() call */
> +#define BTRFS_REPORT_NR_ZONES   4096
> +
> +static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
> +			       struct blk_zone *zones, unsigned int *nr_zones)
> +{
> +	int ret;
> +
> +	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, zones,
> +				  nr_zones);
> +	if (ret != 0) {
> +		btrfs_err_in_rcu(device->fs_info,
> +				 "get zone at %llu on %s failed %d", pos,
> +				 rcu_str_deref(device->name), ret);
> +		return ret;
> +	}
> +	if (!*nr_zones)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +int btrfs_get_dev_zone_info(struct btrfs_device *device)
> +{
> +	struct btrfs_zoned_device_info *zone_info = NULL;
> +	struct block_device *bdev = device->bdev;
> +	sector_t nr_sectors = bdev->bd_part->nr_sects;
> +	sector_t sector = 0;
> +	struct blk_zone *zones = NULL;
> +	unsigned int i, nreported = 0, nr_zones;
> +	unsigned int zone_sectors;
> +	int ret;
> +	char devstr[sizeof(device->fs_info->sb->s_id) +
> +		    sizeof(" (device )") - 1];
> +
> +	if (!bdev_is_zoned(bdev))
> +		return 0;
> +
> +	zone_info = kzalloc(sizeof(*zone_info), GFP_KERNEL);
> +	if (!zone_info)
> +		return -ENOMEM;
> +
> +	zone_sectors = bdev_zone_sectors(bdev);
> +	ASSERT(is_power_of_2(zone_sectors));
> +	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
> +	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
> +	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
> +	if (!IS_ALIGNED(nr_sectors, zone_sectors))
> +		zone_info->nr_zones++;
> +
> +	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
> +	if (!zone_info->seq_zones) {
> +		ret = -ENOMEM;
> +		goto free_zone_info;
> +	}
> +
> +	zone_info->empty_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
> +	if (!zone_info->empty_zones) {
> +		ret = -ENOMEM;
> +		goto free_seq_zones;
> +	}
> +
> +	zones = kcalloc(BTRFS_REPORT_NR_ZONES,
> +			sizeof(struct blk_zone), GFP_KERNEL);
> +	if (!zones) {
> +		ret = -ENOMEM;
> +		goto free_empty_zones;
> +	}
> +
> +	/* Get zones type */
> +	while (sector < nr_sectors) {
> +		nr_zones = BTRFS_REPORT_NR_ZONES;
> +		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT, zones,
> +					  &nr_zones);
> +		if (ret)
> +			goto free_zones;
> +
> +		for (i = 0; i < nr_zones; i++) {
> +			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
> +				set_bit(nreported, zone_info->seq_zones);
> +			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
> +				set_bit(nreported, zone_info->empty_zones);
> +			nreported++;
> +		}
> +		sector = zones[nr_zones - 1].start + zones[nr_zones - 1].len;
> +	}
> +
> +	if (nreported != zone_info->nr_zones) {
> +		btrfs_err_in_rcu(device->fs_info,
> +				 "inconsistent number of zones on %s (%u / %u)",
> +				 rcu_str_deref(device->name), nreported,
> +				 zone_info->nr_zones);
> +		ret = -EIO;
> +		goto free_zones;
> +	}
> +
> +	kfree(zones);
> +
> +	device->zone_info = zone_info;
> +
> +	devstr[0] = 0;
> +	if (device->fs_info)
> +		snprintf(devstr, sizeof(devstr), " (device %s)",
> +			 device->fs_info->sb->s_id);
> +
> +	rcu_read_lock();
> +	pr_info(
> +"BTRFS info%s: host-%s zoned block device %s, %u zones of %llu sectors",
> +		devstr,
> +		bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
> +		rcu_str_deref(device->name), zone_info->nr_zones,
> +		zone_info->zone_size >> SECTOR_SHIFT);
> +	rcu_read_unlock();
> +
> +	return 0;
> +
> +free_zones:
> +	kfree(zones);
> +free_empty_zones:
> +	bitmap_free(zone_info->empty_zones);
> +free_seq_zones:
> +	bitmap_free(zone_info->seq_zones);
> +free_zone_info:

bitmap_free is just a kfree which handles NULL pointers properly, so you only 
need one goto here for cleaning up the zone_info.  Once that's fixed you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Josef
