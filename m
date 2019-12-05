Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEC9113BAE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 07:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfLEG2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 01:28:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5551 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfLEG2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575527301; x=1607063301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LFUTIiD4dA4ZwyDSCWp2PJALt60wn/V3lEYn86QIkak=;
  b=LDUC54q/pbW93aVbQcq3HjVhYxJm4yc8iAr1zdfY9EfE7Od9OWKsVkyz
   5sMCjzpqM/RAQvQxWPfiSJko7GzKpFKsYmYlGCwU7toIDI9l/CtCODQg7
   Mw+NryAK1NSLh1DRTQL7G0U5ZVOSw4XX94VQ7K2qYHn39SegEJzUiyQFm
   yTfd7VvyB80mrRHPxqGKoboU/ZqNMfWe+iFhqGZ+4yZ0duADNPHtHd4th
   pdcCJbY3qQGrVfGnZ0u1DpQM5MNdj3+MdjrgD6HZ8zNfuEiMl8BdH1k7U
   UMkCpazP+zYupqGJVUKdhnX8O6c4iQ6UOOpc8bcwgd/tzHyB+yoGK9ThI
   g==;
IronPort-SDR: gv+/wfz6oXn9K4ru4VjshsnjQWEeBHQnGwBUxRYNwsnpcQ1asK3RrwHG+8aXobwBoFpZ+WqlMg
 BKczaBVxHo7bd3AmP4SK0p5q04o+Cpt6VlYznAzQIx+ouna8BjWkf8jzxQH/MLc9QmSAKkG18B
 0OORo48scNBAl9brhc4WoGI5OfFhEGAkJ31nIyj1eOLcH4m4cNGKEio61SsnA31qp0QRDq41s6
 qImwk5SjVHdLo+VLRqmfXhKRKL/TFVJfQYMZgmeieFEqJRAIYe7h7/UAAdzK7z2wNHKg8LFG4f
 Psg=
X-IronPort-AV: E=Sophos;i="5.69,280,1571673600"; 
   d="scan'208";a="125431328"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2019 14:28:21 +0800
IronPort-SDR: kTPqRRk+6IkNMjwBY9IRP+Or5mG1X3oFmGPbaUyDlQ5/IlYBdsx8aZO44Hg9sZntxlukoT92Xr
 +3RPG/KRBbDkBX7cqORFAgXpPsnfJwR2/u6bg7W5d+y9gid28qEZyal4p84ooYYi6aZ/RsvNtG
 Ki2zqfK2SvAxDZnPSDY4n8DHozQKVHHZi4QBo8sbTiSAa1+4ZFldqqXXwAiEvi+6D+oCNmtNsR
 ICdF54YdwUwzf31jA6M4/QLM1UhiEvn2hV7yfaQbv2wOb/DW95N5wSFiPVjSEzCJOLdEtRNbcK
 nzFwtTTFlALxN36kdn+ZjeOL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 22:23:06 -0800
IronPort-SDR: Zb27estPE0wK47Y4Q2+21WPCyjh+IwS8eVCrx4g6py7sD4UcH8NufpsKv66Gxf2GOv169AqX19
 +5QI+k/WgaPsHRAG0TRtNApqC5vF9wzR2g8XO1wD7Qz2q06UOZqlgAbbOlXs5MO6rKsJD3nlvF
 /qvTZkKeK8XSBKSxrl0woYs5csLp57GM1sJCuVsqwrQv1r1/kSm2MFlsxW8bXk5Vzr0baQd/UY
 VwlK5CwiPFdjw2uZaf16cM7QemfzKCKKRWN1zcXu7QI6Z/k6/nh0ry36Nn1XvnBvS+wncW1ECA
 WAE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 04 Dec 2019 22:28:19 -0800
Received: (nullmailer pid 2334299 invoked by uid 1000);
        Thu, 05 Dec 2019 06:28:17 -0000
Date:   Thu, 5 Dec 2019 15:28:17 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/28] btrfs: Get zone information of zoned block
 devices
Message-ID: <20191205062817.5mtuatqlzeyetcwv@naota.dhcp.fujisawa.hgst.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
 <20191204081735.852438-3-naohiro.aota@wdc.com>
 <20191204153732.GA2083@Johanness-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191204153732.GA2083@Johanness-MacBook-Pro.local>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 04:37:32PM +0100, Johannes Thumshirn wrote:
>On Wed, Dec 04, 2019 at 05:17:09PM +0900, Naohiro Aota wrote:
>[..]
>
>> +#define LEN (sizeof(device->fs_info->sb->s_id) + sizeof("(device )") - 1)
>> +	char devstr[LEN];
>> +	const int len = LEN;
>> +#undef LEN
>
>Why not:
>	const int len = sizeof(device->fs_info->sb->s_id)
>					+ sizeof("(device )") - 1;
>	char devstr[len];
>
>But that's bikeshedding territory I admit.

I once tried that way, but it shows a "warning: ISO C90 forbids array
‘devstr’ whose size can’t be evaluated". So, I avoided that.

>
>> +
>> +	if (!bdev_is_zoned(bdev))
>> +		return 0;
>> +
>> +	zone_info = kzalloc(sizeof(*zone_info), GFP_KERNEL);
>> +	if (!zone_info)
>> +		return -ENOMEM;
>> +
>> +	zone_sectors = bdev_zone_sectors(bdev);
>> +	ASSERT(is_power_of_2(zone_sectors));
>> +	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
>> +	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
>> +	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
>> +	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
>> +		zone_info->nr_zones++;
>
>You've already cached the return of bdev_zone_sectors(bdev) in
>zone_sectors at the beginning of this block and if (x & (y-1)) is the
>IS_ALIGNED() macro so the above should really be:
>	if (!IS_ALIGNED(nr_sectors, zone_sectors))
>		zone_info->nr_zones++;
>
>

Great. That's much clear.

>> +
>> +	zone_info->seq_zones = kcalloc(BITS_TO_LONGS(zone_info->nr_zones),
>> +				       sizeof(*zone_info->seq_zones),
>> +				       GFP_KERNEL);
>
>	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
>
>> +	if (!zone_info->seq_zones) {
>> +		ret = -ENOMEM;
>> +		goto free_zone_info;
>> +	}
>> +
>> +	zone_info->empty_zones = kcalloc(BITS_TO_LONGS(zone_info->nr_zones),
>> +					 sizeof(*zone_info->empty_zones),
>> +					 GFP_KERNEL);
>	
>	zone_info->empty_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
>

Thanks, I'll use the bitmap allocation helpers in the next version.

>> +	if (!zone_info->empty_zones) {
>> +		ret = -ENOMEM;
>> +		goto free_seq_zones;
>> +	}
>> +
>> +	zones = kcalloc(BTRFS_REPORT_NR_ZONES,
>> +			sizeof(struct blk_zone), GFP_KERNEL);
>> +	if (!zones) {
>> +		ret = -ENOMEM;
>> +		goto free_empty_zones;
>> +	}
>> +
>
>I personally would set nreported = 0 here instead in the declaration block. I
>had to scroll up to see what's the initial value, so I think it makes more
>sense to initialize it to 0 here.
>

OK, I'll do so.

>> +	/* Get zones type */
>> +	while (sector < nr_sectors) {
>> +		nr_zones = BTRFS_REPORT_NR_ZONES;
>> +		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT, zones,
>> +					  &nr_zones);
>> +		if (ret)
>> +			goto free_zones;
>> +
>> +		for (i = 0; i < nr_zones; i++) {
>> +			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
>> +				set_bit(nreported, zone_info->seq_zones);
>> +			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
>> +				set_bit(nreported, zone_info->empty_zones);
>> +			nreported++;
>> +		}
>> +		sector = zones[nr_zones - 1].start + zones[nr_zones - 1].len;
>> +	}
>> +
>> +	if (nreported != zone_info->nr_zones) {
>> +		btrfs_err_in_rcu(device->fs_info,
>> +				 "inconsistent number of zones on %s (%u / %u)",
>> +				 rcu_str_deref(device->name), nreported,
>> +				 zone_info->nr_zones);
>> +		ret = -EIO;
>> +		goto free_zones;
>> +	}
>> +
>> +	kfree(zones);
>> +
>> +	device->zone_info = zone_info;
>> +
>> +	devstr[0] = 0;
>> +	if (device->fs_info)
>> +		snprintf(devstr, len, " (device %s)",
>> +			 device->fs_info->sb->s_id);
>> +
>> +	rcu_read_lock();
>> +	pr_info(
>> +"BTRFS info%s: host-%s zoned block device %s, %u zones of %llu sectors",
>> +		devstr,
>> +		bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
>> +		rcu_str_deref(device->name), zone_info->nr_zones,
>> +		zone_info->zone_size >> SECTOR_SHIFT);
>> +	rcu_read_unlock();
>
>btrfs_info_in_rcu()?
>

Since this function is called before btrfs set "fs_info->sb->s_id",
btrfs_info_in_rcu() prints like "BTRFS info (device <unknown>) ...", which
is annoying. I intentionally used pr_info() and rcu_read_{lock,unlock} here
to show a cleaner print.

>> +
>> +	return 0;
>> +
>> +free_zones:
>> +	kfree(zones);
>> +free_empty_zones:
>> +	kfree(zone_info->empty_zones);
>	
>	bitmap_free(zone_info->empty_zones);
>
>> +free_seq_zones:
>> +	kfree(zone_info->seq_zones);
> 	
>	bitmap_free(zone_info->seq_zones);
>
>> +free_zone_info:
>> +	kfree(zone_info);
>> +
>> +	return ret;
>> +}
>> +
>> +void btrfs_destroy_dev_zone_info(struct btrfs_device *device)
>> +{
>> +	struct btrfs_zoned_device_info *zone_info = device->zone_info;
>> +
>> +	if (!zone_info)
>> +		return;
>> +
>> +	kfree(zone_info->seq_zones);
>> +	kfree(zone_info->empty_zones);
>
>	bitmap_free(zone_info->seq_zones);
>	bitmap_free(zone_info->empty_zones);
>
>Thanks,
>	Johannes
