Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D75C114C7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 08:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfLFHDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 02:03:23 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20988 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLFHDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575615989; x=1607151989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o2kvg8QILHdjk8t4J36S87wN0EcI3xNO7LEpcLpeQ9s=;
  b=Q339jTo3XEPCLpoHWYpt3i/XwRcWI/4NMKONXVhMh8FfVCMVGnhtG11X
   ZranS91NqOAfmvppUlhnm21TXlLgi4x4Htl+rUivWyp4iUEMQ0+tvahWQ
   YaGBBlZHQw2AxD1+uJQ/RQNawq+gRLvEoYoI1aRhnI6omFFN5xqgICgcc
   8jaZMnHWRizaR/uHlbJrjspYlE53v5U64d2X9Uza1b8hRlKDWmcZHtYhX
   RyfDAR+7F4TPIHo+ExECDiXA91kTdTbPdGM1xgoY6AyNqadxNnJntRhSP
   SS1gyemc0p1ffk1jbimy7bNbRDiBl9VoE6Qn9bWXxYUxm1ZSspEJS24Tw
   w==;
IronPort-SDR: tS8sStOj606x4kk/aMVXc3U7kDgdenHySRfFL7RBF8cA2eXYjppLDHWwga/apxvsninrGK8+PS
 6/vqAzgAfyL+wPC0dDLh10JmEV6QyLstE7Mgl/kDwnqghFxH/fhU3npDs2M9E5zyNKI/K73v6O
 ydkY8lBxNWMEcxNzY4Ru5uojdvd2McEyJKpCcaC9/0xvBbONhCR6dhoFdyZ68vpHdr6BfnR1j4
 EcnKMTZv61e5wNKJuCRQGNeIijeHMB3CMuPY3CVjJT07YLjuOVQaq/qGTrbEaVrcsCyzHeBowW
 4M4=
X-IronPort-AV: E=Sophos;i="5.69,283,1571673600"; 
   d="scan'208";a="226216664"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2019 15:06:28 +0800
IronPort-SDR: HW0F4DJNyshoGdLByr/gvchU4grqbuR3cfnmLiGBXzTjsJf10hDAjVfnafKNEWYeNeDN9gRPP/
 lyc6psTCXH/anyaQ+KRdraE9ZbbjiGEMGsbsWWkPX6sFrtXA/WJvJtFDFluU7rnLuton58siW8
 aj4V9Upv6MFWpavWjHTHjfswV2mK+jcsnGAMBP6RsiU3QrCTqCpEaB5lEGjuHwUmOxV3puZCdz
 Nqgb2VdJGLto7tPbdN32bVsr5rYYsbEk5I0RyytydlsYKkz3hni0xUJ3DqxWD8oSRu07ug3RCL
 zaMPPMN/2S7OCGQTrxswjJIp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 22:57:45 -0800
IronPort-SDR: +5Lc1HFgCibhCQlWggVncTV792+UZwGJVxz/mPYWL+wti7bq+EGy8BzhSPc11p+rxlUWnRxSsY
 DIloiVd1KgHa57oHPFxJxmp5tpJX2MXbbl1M29A9Jg1uWiKSp2yD975HRobsHECH9wKbHjGci7
 fpkxL1AXDaFWmXGRaNrNcQwuuVmef/OnCR8QM2ue+HgtONdMYwegyxzonx+VScUqVClGzJmvSQ
 L3gvVr4417hBKW1tSfVyVtGXBDgwbDGDhirQvyQP6A0MVpGPDoba1MM8DUI+xyOta0V2/HJSJP
 Yok=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 05 Dec 2019 23:03:21 -0800
Received: (nullmailer pid 3791522 invoked by uid 1000);
        Fri, 06 Dec 2019 07:03:20 -0000
Date:   Fri, 6 Dec 2019 16:03:20 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Vyacheslav Dubeyko <slava@dubeyko.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] libblkid: implement zone-aware probing for HMZONED btrfs
Message-ID: <20191206070320.fzvqe4ketl3lx5q6@naota.dhcp.fujisawa.hgst.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
 <20191204083023.861495-1-naohiro.aota@wdc.com>
 <5eb099b6886358f3a478658e25a26a42ab674e7f.camel@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5eb099b6886358f3a478658e25a26a42ab674e7f.camel@dubeyko.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 03:15:32PM +0300, Vyacheslav Dubeyko wrote:
>On Wed, 2019-12-04 at 17:30 +0900, Naohiro Aota wrote:
>> This is a proof-of-concept patch to make libblkid zone-aware. It can
>> probe the magic located at some offset from the beginning of some
>> specific zone of a device.
>>
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> ---
>>  libblkid/src/blkidP.h            |   4 +
>>  libblkid/src/probe.c             |  25 +++++-
>>  libblkid/src/superblocks/btrfs.c | 132
>> ++++++++++++++++++++++++++++++-
>>  3 files changed, 157 insertions(+), 4 deletions(-)
>>
>> diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
>> index f9bbe008406f..5bb6771ee9c6 100644
>> --- a/libblkid/src/blkidP.h
>> +++ b/libblkid/src/blkidP.h
>> @@ -148,6 +148,10 @@ struct blkid_idmag
>>
>>  	long		kboff;		/* kilobyte offset of
>> superblock */
>>  	unsigned int	sboff;		/* byte offset within
>> superblock */
>> +
>> +	int		is_zone;
>> +	long		zonenum;
>> +	long		kboff_inzone;
>>  };
>
>Maybe, it makes sense to add the comments for added fields? How do you
>feel?

I agree. This is still a prototype version to test HMZONED btrfs. So,
I'll add comments and clean up codes in the later version.

>>
>>  /*
>> diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
>> index f6dd5573d5dd..56e42ac28559 100644
>> --- a/libblkid/src/probe.c
>> +++ b/libblkid/src/probe.c
>> @@ -94,6 +94,7 @@
>>  #ifdef HAVE_LINUX_CDROM_H
>>  #include <linux/cdrom.h>
>>  #endif
>> +#include <linux/blkzoned.h>
>>  #ifdef HAVE_SYS_STAT_H
>>  #include <sys/stat.h>
>>  #endif
>> @@ -1009,8 +1010,25 @@ int blkid_probe_get_idmag(blkid_probe pr,
>> const struct blkid_idinfo *id,
>>  	/* try to detect by magic string */
>>  	while(mag && mag->magic) {
>>  		unsigned char *buf;
>> -
>> -		off = (mag->kboff + (mag->sboff >> 10)) << 10;
>> +		uint64_t kboff;
>> +
>> +		if (!mag->is_zone)
>> +			kboff = mag->kboff;
>> +		else {
>> +			uint32_t zone_size_sector;
>> +			int ret;
>> +
>> +			ret = ioctl(pr->fd, BLKGETZONESZ,
>> &zone_size_sector);
>> +			if (ret == EOPNOTSUPP)
>
>-EOPNOTSUPP??? Or this is the libblk peculiarity?
>

My bad... It should check errno in the userland code. I'll fix.

>> +				goto next;
>> +			if (ret)
>> +				return -errno;
>> +			if (zone_size_sector == 0)
>> +				goto next;
>> +			kboff = (mag->zonenum * (zone_size_sector <<
>> 9)) >> 10;
>> +			kboff += mag->kboff_inzone;
>> +		}
>> +		off = (kboff + (mag->sboff >> 10)) << 10;
>>  		buf = blkid_probe_get_buffer(pr, off, 1024);
>>
>>  		if (!buf && errno)
>> @@ -1020,13 +1038,14 @@ int blkid_probe_get_idmag(blkid_probe pr,
>> const struct blkid_idinfo *id,
>>  				buf + (mag->sboff & 0x3ff), mag->len))
>> {
>>
>>  			DBG(LOWPROBE, ul_debug("\tmagic sboff=%u,
>> kboff=%ld",
>> -				mag->sboff, mag->kboff));
>> +				mag->sboff, kboff));
>>  			if (offset)
>>  				*offset = off + (mag->sboff & 0x3ff);
>>  			if (res)
>>  				*res = mag;
>>  			return BLKID_PROBE_OK;
>>  		}
>> +next:
>>  		mag++;
>>  	}
>>
>> diff --git a/libblkid/src/superblocks/btrfs.c
>> b/libblkid/src/superblocks/btrfs.c
>> index f0fde700d896..4254220ef423 100644
>> --- a/libblkid/src/superblocks/btrfs.c
>> +++ b/libblkid/src/superblocks/btrfs.c
>> @@ -9,6 +9,9 @@
>>  #include <unistd.h>
>>  #include <string.h>
>>  #include <stdint.h>
>> +#include <stdbool.h>
>> +
>> +#include <linux/blkzoned.h>
>>
>>  #include "superblocks.h"
>>
>> @@ -59,11 +62,131 @@ struct btrfs_super_block {
>>  	uint8_t label[256];
>>  } __attribute__ ((__packed__));
>>
>> +#define BTRFS_SUPER_INFO_SIZE 4096
>
>I believe that 4K is very widely used constant.
>Are you sure that it needs to introduce some
>additional constant? Especially, it looks slightly
>strange to see the BTRFS specialized constant.
>Maybe, it needs to generalize the constant?

I don't think so...

I think it is better to define BTRFS_SUPER_INFO_SIZE here. This is an
already defined constant in btrfs-progs and this is key value to
calculate the last superblock location. I think it's OK to define
btrfs local constant in btrfs.c file...

>> +#define SECTOR_SHIFT 9
>
>Are you sure that libblkid hasn't such constant?
>
>> +
>> +#define READ 0
>> +#define WRITE 1
>> +
>> +typedef uint64_t u64;
>> +typedef uint64_t sector_t;
>
>I see the point to introduce the sector_t type.
>But is it really necessary to introduce the u64 type?
>

These SECTOR_SHIFT to sector_t are mainly introduced to unify the code
between btrfs-progs, util-linux and btrfs kernel so that I can ease
the development at least in this early stage. So, in the later
version, I'll drop some of these definitions. Maybe using
DEFAULT_SECTOR_SIZE instead of SECTOR_SHIFT, just use uint64_t instead
of u64.

>> +
>> +static int sb_write_pointer(struct blk_zone *zones, u64 *wp_ret)
>> +{
>> +	bool empty[2];
>> +	bool full[2];
>> +	sector_t sector;
>> +
>> +	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
>> +		*wp_ret = zones[0].start << SECTOR_SHIFT;
>> +		return -ENOENT;
>> +	}
>> +
>> +	empty[0] = zones[0].cond == BLK_ZONE_COND_EMPTY;
>> +	empty[1] = zones[1].cond == BLK_ZONE_COND_EMPTY;
>> +	full[0] = zones[0].cond == BLK_ZONE_COND_FULL;
>> +	full[1] = zones[1].cond == BLK_ZONE_COND_FULL;
>> +
>> +	/*
>> +	 * Possible state of log buffer zones
>> +	 *
>> +	 *   E I F
>> +	 * E * x 0
>> +	 * I 0 x 0
>> +	 * F 1 1 x
>> +	 *
>> +	 * Row: zones[0]
>> +	 * Col: zones[1]
>> +	 * State:
>> +	 *   E: Empty, I: In-Use, F: Full
>> +	 * Log position:
>> +	 *   *: Special case, no superblock is written
>> +	 *   0: Use write pointer of zones[0]
>> +	 *   1: Use write pointer of zones[1]
>> +	 *   x: Invalid state
>> +	 */
>> +
>> +	if (empty[0] && empty[1]) {
>> +		/* special case to distinguish no superblock to read */
>> +		*wp_ret = zones[0].start << SECTOR_SHIFT;
>
>
>So, even if we return the error then somebody will check
>the *wp_ret value? Looks slightly unexpected.

I admit it is confusing. error is returned to distinguish 1) case of
both zones are empty and 2) case of having written the two zones and
wrapped around to the head. Both cases have their write position at
the beginning of the first zone. But, read position is different: the
beginning of the zones or invalid in the case 1, and the (nearly) end
of the zones in the case 2.

Since libblkid is read-only for superblocks, we can drop this setting
the *wp_ret value.

>> +		return -ENOENT;
>> +	} else if (full[0] && full[1]) {
>> +		/* cannot determine which zone has the newer superblock
>> */
>> +		return -EUCLEAN;
>> +	} else if (!full[0] && (empty[1] || full[1])) {
>> +		sector = zones[0].wp;
>> +	} else if (full[0]) {
>> +		sector = zones[1].wp;
>> +	} else {
>> +		return -EUCLEAN;
>> +	}
>> +	*wp_ret = sector << SECTOR_SHIFT;
>> +	return 0;
>> +}
>> +
>> +static int sb_log_offset(uint32_t zone_size_sector, blkid_probe pr,
>> +			 uint64_t *offset_ret)
>> +{
>> +	uint32_t zone_num = 0;
>> +	struct blk_zone_report *rep;
>> +	struct blk_zone *zones;
>> +	size_t rep_size;
>> +	int ret;
>> +	uint64_t wp;
>> +
>> +	rep_size = sizeof(struct blk_zone_report) + sizeof(struct
>> blk_zone) * 2;
>> +	rep = malloc(rep_size);
>> +	if (!rep)
>> +		return -errno;
>> +
>> +	memset(rep, 0, rep_size);
>> +	rep->sector = zone_num * zone_size_sector;
>> +	rep->nr_zones = 2;
>> +
>> +	ret = ioctl(pr->fd, BLKREPORTZONE, rep);
>> +	if (ret)
>> +		return -errno;
>
>So, the valid case if ioctl returns 0? Am I correct?

Yes.

>
>> +	if (rep->nr_zones != 2) {
>> +		free(rep);
>> +		return 1;
>> +	}
>> +
>> +	zones = (struct blk_zone *)(rep + 1);
>> +
>> +	ret = sb_write_pointer(zones, &wp);
>> +	if (ret != -ENOENT && ret)
>> +		return -EIO;
>
>
>If ret is positive then we could return the error. Am I correct?

Right. But, sb_write_pointer() will return 0 or negative (error value).

>
>> +	if (ret != -ENOENT) {
>> +		if (wp == zones[0].start << SECTOR_SHIFT)
>> +			wp = (zones[1].start + zones[1].len) <<
>> SECTOR_SHIFT;
>> +		wp -= BTRFS_SUPER_INFO_SIZE;
>> +	}
>> +	*offset_ret = wp;
>> +
>> +	return 0;
>> +}
>> +
>>  static int probe_btrfs(blkid_probe pr, const struct blkid_idmag
>> *mag)
>>  {
>>  	struct btrfs_super_block *bfs;
>> +	uint32_t zone_size_sector;
>> +	int ret;
>> +
>> +	ret = ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector);
>> +	if (ret)
>> +		return errno;
>
>You returned -errno for another ioctls above. Is everything correct
>here?

My mistake. I need to return "-errno" here.

>> +	if (zone_size_sector != 0) {
>> +		uint64_t offset = 0;
>>
>> -	bfs = blkid_probe_get_sb(pr, mag, struct btrfs_super_block);
>> +		ret = sb_log_offset(zone_size_sector, pr, &offset);
>> +		if (ret)
>> +			return ret;
>
>What about a positive value of ret? I suppose it needs to return ret
>only if we have an error. Am I correct?

sb_log_offset() can return 0 on success, negative value on error and 1
when the device has less than two zones. In the last case, we can
return the value "1" as is to indicate that there is no magic number
on this device. I should replace "1" with BLKID_PROBE_NONE to make it
clear.

>Thanks,
>Viacheslav Dubeyko.
>
>> +		bfs = (struct btrfs_super_block*)
>> +			blkid_probe_get_buffer(pr, offset,
>> +					       sizeof(struct
>> btrfs_super_block));
>> +	} else {
>> +		bfs = blkid_probe_get_sb(pr, mag, struct
>> btrfs_super_block);
>> +	}
>>  	if (!bfs)
>>  		return errno ? -errno : 1;
>>
>> @@ -88,6 +211,13 @@ const struct blkid_idinfo btrfs_idinfo =
>>  	.magics		=
>>  	{
>>  	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40, .kboff = 64
>> },
>> +	  /* for HMZONED btrfs */
>> +	  { .magic = "!BHRfS_M", .len = 8, .sboff = 0x40,
>> +	    .is_zone = 1, .zonenum = 0, .kboff_inzone = 0 },
>> +	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40,
>> +	    .is_zone = 1, .zonenum = 0, .kboff_inzone = 0 },
>> +	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40,
>> +	    .is_zone = 1, .zonenum = 1, .kboff_inzone = 0 },
>>  	  { NULL }
>>  	}
>>  };
>
