Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346752AD344
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 11:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgKJKOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 05:14:48 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:48568 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJKOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605003287; x=1636539287;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=+ktcotJ711Ij3hBKaE3Epw6R5YChevtldrCEvvx3y2w=;
  b=q8qDHxHLlGSXGGRglWzUNDMGTBbRvlHTEjnseswcXBt4mX5LzWoay9pL
   Ois8wUImHhy1E/h89Kf6T0mkkBh3vdYy6hpixnBoMrzDuWTqijc/PhGT1
   FUllbtUHYDm8WbaIYp6fTWNAFGAVfjN4yapg05ztovwRvxvUk69XaZzHF
   D2XkstnML3Q0I95+XLIkuMZyaRCvLZNMMVqH4XoVCdESm+KV4lgFbr6b0
   cyv0GPlIJexAyIh0lZb5ZeIE6bc0AqHF68PrzKjjX27qSYKD6JzcZxcIc
   pmvXXrs0OiyI2frNifc94H0/q+/mDZ8+14TsLW3D1Vr3RIBKCAqQU2HmJ
   A==;
IronPort-SDR: W6cD1FCD6FhE3Roijw0eFvU3et4RIy2/GyK1upVDx6JF2RlIsMjAkBwqvqgToeBzAkglOHZEz+
 kHiaCjOQie17rLf5VtboJ5k1VVkbqBgsSnWZlZiAFWvlIoAOGIZsMmL2Q+Vw2Xk4VOGdgywVOp
 ZD6Qg3mF2GU5GxPaSKKQS1wPwex80kMZBIIFQRA1xiXP49z5AljV7tpyQXC7qbGzVP+GQl13CD
 v4wNMNO4D1XyRxpCJMgI1md8P9AqzMdNY4iritxYdt4HK7csKHMtiH0K+uJgUGh/Jftg58i37Y
 C/I=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="262273867"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 18:14:46 +0800
IronPort-SDR: BECK0f6sFN8QxcQ/cd698nMkyKqQCnvNOIR8U7mGUDRzuK0dGolBX7X5Zyc1CZeqnugGTXj4Vm
 Rk9dfbvL0UM7Sw+z2Rl0c2kS2RxLtGnISmIuobh96xTfQddNQ2QGQxN1N87v7z3JLaAlgx4fYO
 V9XvDOdo0giBsXXmCHJv0amD5cOWqqe+hl8YZ8F20PpmqVYKhPi4GO6y2h41xLo1K9ClCYMoMC
 XrPLZOe1fD51jbOxRT0PZ8OUPiTkyzIu1mEAegE6w3oaORdLfoTR8ThFEZpeoCbJ+6HVYpwxa/
 coAd52HvJa52IVuriT+p0Nea
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 01:59:34 -0800
IronPort-SDR: Wl58OE7AYaE5c957/B6Ux27HDDUMl3IpBvz8VHXWzjKZVOnXhuxsNz4ZeOB9/5m/ZflI9rHyD6
 2o6ZhGOazj1Xhuv6NqB/hGW9O44FmL81FIiGKYCGBVxHSif6F+mSQkjCLWiWr023uPQXrW9jMg
 0RwdcUUyDcHRN/FFDnQanWLlVklmiBB9hq+Xcmc7eIw3s3aw0OyzloS4sZ+wG4bXiDSpCa0tll
 xFnTN7T4YrN4MGyty+bIwkncllMpb2uKJtKA9/g1CWSRNV2CzIxaHff1fi+IGTvPEbMKw4J7xM
 Z+A=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 10 Nov 2020 02:14:46 -0800
Received: (nullmailer pid 1881648 invoked by uid 1000);
        Tue, 10 Nov 2020 10:14:45 -0000
Date:   Tue, 10 Nov 2020 19:14:45 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        hare@suse.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 07/41] btrfs: disallow space_cache in ZONED mode
Message-ID: <20201110101445.qflxmjw3lhgrf4if@naota.dhcp.fujisawa.hgst.com>
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <f0a4ae9168940bf1756f89a140cabedb8972e0d1.1604065695.git.naohiro.aota@wdc.com>
 <20201103124834.GR6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201103124834.GR6756@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:48:34PM +0100, David Sterba wrote:
>On Fri, Oct 30, 2020 at 10:51:14PM +0900, Naohiro Aota wrote:
>> INODE_MAP_CACHE inode.
>>
>> In summary, ZONED will disable:
>>
>> | Disabled features | Reason                                              |
>> |-------------------+-----------------------------------------------------|
>> | RAID/Dup          | Cannot handle two zone append writes to different   |
>> |                   | zones                                               |
>> |-------------------+-----------------------------------------------------|
>> | space_cache (v1)  | In-place updating                                   |
>> | NODATACOW         | In-place updating                                   |
>> |-------------------+-----------------------------------------------------|
>> | fallocate         | Reserved extent will be a write hole                |
>> | INODE_MAP_CACHE   | Need pre-allocation. (and will be deprecated?)      |
>
>space_cache is deprecated and actually in current dev cycle (5.11)
>
>> |-------------------+-----------------------------------------------------|
>> | MIXED_BG          | Allocated metadata region will be write holes for   |
>> |                   | data writes                                         |
>>
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> ---
>>  fs/btrfs/super.c | 12 ++++++++++--
>>  fs/btrfs/zoned.c | 18 ++++++++++++++++++
>>  fs/btrfs/zoned.h |  5 +++++
>>  3 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 3312fe08168f..9064ca62b0a0 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -525,8 +525,14 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>>  	cache_gen = btrfs_super_cache_generation(info->super_copy);
>>  	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
>>  		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
>> -	else if (cache_gen)
>> -		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
>> +	else if (cache_gen) {
>> +		if (btrfs_is_zoned(info)) {
>> +			btrfs_info(info,
>> +			"clearring existing space cache in ZONED mode");
>
>			"zoned: clearing existing space cache"
>
>Is it clearing or just invalidating it? We have the same problem with
>enabling v2 so this could share some code once Boris' patches are
>merged.


Yep, this is just invalidating it. I'll use
btrfs_set_free_space_cache_v1_active here once the patches are merged.
