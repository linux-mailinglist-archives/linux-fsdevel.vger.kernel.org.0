Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B45113B1F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 06:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfLEFRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 00:17:24 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50127 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfLEFRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 00:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575523046; x=1607059046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eD3gperu3n0s0CwyuZBnXMCCRZbyITUejDKe0xEi9Cw=;
  b=o9fVgqBWnCdr2q+6HJ+W/16hJJYkrEYQjyJZMBHG/K5TotUxVlFPAmUt
   GjtVbxVVloZu/yWzu323B83e/wnCj7sluHMzSYxykIlJqxoDu9cqvzyE8
   PEKTJR55Os1l2xubxiMSdz3h6IHsjM4lHko4fll15SfSlojcKuBUoPEMY
   5Hp/6154dcvkpqQrbqqqdgMk1mzvKTSD8eh7T1UhARR7X5Lx46K67060A
   NVG92YBZShKeYn/aY3z6hL/oYuJpezFTogHufTfrcujzvefg2soIMkuTh
   WnVwvRzq5VKkTMHytSzf6rMVO9gT4BUpaC7eGkULEHKQrvFcNP8Jo6W73
   w==;
IronPort-SDR: YNOxhh2LJSCaXMVfmpMOclgbvvRpOTeYjKhTL2l2uWyyHk3Zfq3sknvU0zNcfRMLqXQnAoU8RO
 4dBf7dUZFqodMt1axCznafy/hpWiM9tL2PYfXAwPBwelCLV5J6pyfQN3LZfdS/HwPDxaFo9wao
 nXAroqYqz6hcUePJ9tp8No1xxSmWnqSj17ggmyaC52L4LUbCGe2IKTIt6ZgXT3prQ0X7m4m6xu
 dYDZxb/gYG+OWzPwNQ+qKRF1nTcZtQ4zl0ttQyX3Yzj6xKJaMwoZAPhxOYY6hPLW1BZfh5fPrH
 +sc=
X-IronPort-AV: E=Sophos;i="5.69,279,1571673600"; 
   d="scan'208";a="226109600"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2019 13:19:13 +0800
IronPort-SDR: L5oXpQhx4Vzj93Tgh8w25N83/3Gd9oRQv/bFdpfPmiKAnvcp2iK3YUm99q5xXD6Bq3+mb3H/gt
 gbW5eLFVltmotj9+htokdB5W0egCBWWzzC+80tmssGcCeUGRABdSBzNn6S7pbW/sllCxEI42LE
 zzcOK8GU3tUxEry7pDUfIwpHvTvSxdLV6yHVx6QobkvLr26mcQZC/zBUxDQFzo+5MeQdXb+l2P
 PE9y89vBIrsczpdKqE/DdZML33h29sdrDGyOALpNfPslm29m9HGs6/VAjnnAtnJSXoh0xt5v9y
 W2qcuIoOoh4wVGhUXnSqn5Tk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 21:11:53 -0800
IronPort-SDR: zmB0JFjMBTjzvas4XhZbg/F/SaKDGjN9ThC00dYUEgvDc5K4T18qnheZdm1xBW48m7hcv0AW0c
 gy5k+d2YT3zZ3MfLmwAeCiN6xK7jbMUVAJSG8zBRYxDrFaEP2liaUjrAeBfKcEpAjV+OrkK9Pf
 IrSBQTnbjZLXjyI0gYpeK+5KnxYF0IodLEx9ipytUgsIoe7yMmZS2wBolSPw9UNYf4LlA8Tf/5
 LZkJZWR/byuXhRvqw04QXxrWSZs/bN/zco+ICldhNJcRQd4IWxHYzckEzSar2GSgpfN9XN5xNi
 0Oo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 04 Dec 2019 21:17:06 -0800
Received: (nullmailer pid 2018833 invoked by uid 1000);
        Thu, 05 Dec 2019 05:17:04 -0000
Date:   Thu, 5 Dec 2019 14:17:04 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 03/28] btrfs: Check and enable HMZONED mode
Message-ID: <20191205051704.pyelplxjuje6jl6v@naota.dhcp.fujisawa.hgst.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
 <20191204081735.852438-4-naohiro.aota@wdc.com>
 <20191204160734.GA3950@Johanness-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191204160734.GA3950@Johanness-MacBook-Pro.local>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 05:07:34PM +0100, Johannes Thumshirn wrote:
>On Wed, Dec 04, 2019 at 05:17:10PM +0900, Naohiro Aota wrote:
>> HMZONED mode cannot be used together with the RAID5/6 profile for now.
>> Introduce the function btrfs_check_hmzoned_mode() to check this. This
>> function will also check if HMZONED flag is enabled on the file system and
>> if the file system consists of zoned devices with equal zone size.
>
>I have a question, you wrote you check for a file system consisting of zoned
>devices with equal zone size. What happens if you create a multi device file
>system combining zoned and regular devices? Is this even supported and if no
>where are the checks for it?

We don't allow creaing a file system mixed with zoned and regular device.
This is checked by btrfs_check_hmzoned_mode() (called from open_ctree()) at
the mount time. "if (hmzoned_devices != nr_devices) { ... }" is doing the
actual check.

# I noticed putting "fs_info->zone_size = zone_size;" after this check is
# better.

Also, btrfs_check_device_zone_type() (called from btrfs_init_new_device()
and btrfs_init_dev_replace_tgtdev()) does the similar check against new
device for "btrfs device add" and "btrfs replace".

>
>[...]
>
>> +int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
>> +{
>> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>> +	struct btrfs_device *device;
>> +	u64 hmzoned_devices = 0;
>> +	u64 nr_devices = 0;
>> +	u64 zone_size = 0;
>> +	int incompat_hmzoned = btrfs_fs_incompat(fs_info, HMZONED);
>> +	int ret = 0;
>> +
>> +	/* Count zoned devices */
>> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
>> +		if (!device->bdev)
>> +			continue;
>
>Nit:
>		enum blk_zoned_model zone_model = blk_zoned_model(device->bdev);
>
>		if (zone_model == BLK_ZONED_HM ||
>		    zone_model == BLK_ZONED_HA &&
>		    incompat_hmzoned) {
>

Thanks, it's clearer.

>> +		if (bdev_zoned_model(device->bdev) == BLK_ZONED_HM ||
>> +		    (bdev_zoned_model(device->bdev) == BLK_ZONED_HA &&
>> +		     incompat_hmzoned)) {
>> +			hmzoned_devices++;
>> +			if (!zone_size) {
>> +				zone_size = device->zone_info->zone_size;
>> +			} else if (device->zone_info->zone_size != zone_size) {
>> +				btrfs_err(fs_info,
>> +					  "Zoned block devices must have equal zone sizes");
>> +				ret = -EINVAL;
>> +				goto out;
>> +			}
>> +		}
>> +		nr_devices++;
>> +	}
