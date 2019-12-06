Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11290114C14
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 06:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfLFFdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 00:33:18 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23754 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbfLFFdS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 00:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575610397; x=1607146397;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=YPJSarCpmWchZc8jP/nRd6xal0knym22bpqf0CKTQfg=;
  b=mAhPxJ405XiRapLOFBVB/dBGoOLkD2dwamKiecUNzSaS9ggt8TEAcKp8
   qEpmOrbl1UYQg3IK6fmkYO9gmgH/blf506Mh80ZG46HePlopf08dso6Fw
   I61WfmbsTQu6ULhUGgv9c1YOyOWxLgX66owHRF2pbiN/OUZP3gTGAlFO4
   gk/0tecyb3JFGPXcNHbab8d6lzTgdsuheZNh14iilh3NPAVV21NRBqCM2
   joegwla/1px/trpQiGf8wcSD4eZfNOB7YOwhN+0DU2YSHuefa1hxJL4O7
   KHn9EG3x9JhAFgYl7KXh+3ZrCW7H4CY1mLqP4BoDGvsvtPZuTLtiJi9f5
   A==;
IronPort-SDR: 7FCQZ+1KMH1dpZjL5VyuLgU3yeF/FLZhPxSFtc5hnK8zJrDmpMzYomKiLSwqXGglN0uFpkApCr
 Jg/dnuxpeTPt0yUV0vgpvbnz0Cnvp+MuSxBvepJHprIVgQHCXdxHNdJYyfbOU2/7mTVtZxszjR
 mmQDbaIDV9uDirJCfuQqohXpZf/nCwB3ACtT4WOmt+3a5OLaYcvXGCQWZ2xZPNrFuD8vocnfvM
 QxYNrLUGpedgMAOVChgwU9NGnOL3POtT1oxp3puohBchRK0nEaFlypO2W/D9+tdopaE2qel+Jm
 kcs=
X-IronPort-AV: E=Sophos;i="5.69,283,1571673600"; 
   d="scan'208";a="232259211"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2019 13:32:47 +0800
IronPort-SDR: YMiQXmdAuhEbzxGp7+kpMFY9khcCIKpFv6l/wf/jV97PvoG6Dr7i1KYyzDAo05+cOBh4c+28VP
 7Edu4Ln5rPFE6NIM5tEFVxYRHIu0bpbghdFbemiCgz5c5hC/t+CdPS81nUTqXOp/KUp5638Uva
 J7VJz6S46jRRcQy2lHuLNwTym3H+dOGmoS5JQ2dGsrglkRIi0r798Z30J58gj4SmSNyKyaT6tl
 jhoy2vvYccPxDd6Cq3AD8Avv0a4IF9Adzu2eXwuEEBOXTEjQEhr8rCeguk5ZOjrnQJLwGoxZCz
 DhrX0eeW1oryt4xxTJfs1DbE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 21:27:31 -0800
IronPort-SDR: QEOxGiWl61aUIkE3r+rjWSO/Ji3LnCDuEYESohJYmHArp6ERqFZdyxvnPue1zRQ9D0qonRyYwa
 iUB/q4CSRBD545fUgsadizidKJCgiF7MHOte1eHNq3kwQD7jx1B6HScYAIFRE6oQMtd1yAW86K
 ZiJCJ+hGBxn6GV2Ma/yfGFV0WwSjdi4VuRG+1zIqZ7NlLjEbviPx/K22Oi4Qf8vyCq5nEilENK
 PU2Xpl/U+XUhfG1sUU60K3unvAldrLhKpWyWzk/XTIL8HE2JOdcNKiwCLiJtK0kC70YW/NJRKQ
 l/M=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 05 Dec 2019 21:32:45 -0800
Received: (nullmailer pid 3646735 invoked by uid 1000);
        Fri, 06 Dec 2019 05:32:44 -0000
Date:   Fri, 6 Dec 2019 14:32:44 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 05/28] btrfs: disallow space_cache in HMZONED mode
Message-ID: <20191206053244.r2en7jydhyohd45k@naota.dhcp.fujisawa.hgst.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
 <20191204081735.852438-6-naohiro.aota@wdc.com>
 <20191205153953.GV2734@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191205153953.GV2734@twin.jikos.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 04:39:53PM +0100, David Sterba wrote:
>On Wed, Dec 04, 2019 at 05:17:12PM +0900, Naohiro Aota wrote:
>> As updates to the space cache are in-place, the space cache cannot be
>> located over sequential zones and there is no guarantees that the device
>> will have enough conventional zones to store this cache. Resolve this
>> problem by disabling completely the space cache.  This does not introduces
>> any problems with sequential block groups: all the free space is located
>> after the allocation pointer and no free space before the pointer. There is
>> no need to have such cache.
>>
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> ---
>>  fs/btrfs/hmzoned.c | 18 ++++++++++++++++++
>>  fs/btrfs/hmzoned.h |  5 +++++
>>  fs/btrfs/super.c   | 10 ++++++++--
>>  3 files changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
>> index b74581133a72..1c015ed050fc 100644
>> --- a/fs/btrfs/hmzoned.c
>> +++ b/fs/btrfs/hmzoned.c
>> @@ -253,3 +253,21 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
>>  out:
>>  	return ret;
>>  }
>> +
>> +int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
>> +{
>> +	if (!btrfs_fs_incompat(info, HMZONED))
>> +		return 0;
>> +
>> +	/*
>> +	 * SPACE CACHE writing is not CoWed. Disable that to avoid
>> +	 * write errors in sequential zones.
>
>Please format comments to 80 columns
>

Fixed, thanks.

>> +	 */
>> +	if (btrfs_test_opt(info, SPACE_CACHE)) {
>> +		btrfs_err(info,
>> +		  "cannot enable disk space caching with HMZONED mode");
>
>"space cache v1 not supported in HMZONED mode, use v2 (free-space-tree)"
>
>> +		return -EINVAL;

Yes, we can technically use free-space-tree on HMZONED mode. But,
since HMZONED mode now always allocate extents in a block group
sequentially regardless of underlying device zone type, it's no use to
enable and maintain the tree anymore.

So, just telling "space cache v1 not supported in HMZONED mode" is
better?

>>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 616f5abec267..d411574298f4 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -442,8 +442,12 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>>  	cache_gen = btrfs_super_cache_generation(info->super_copy);
>>  	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
>>  		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
>> -	else if (cache_gen)
>> -		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
>> +	else if (cache_gen) {
>> +		if (btrfs_fs_incompat(info, HMZONED))
>> +			WARN_ON(1);
>
>So this is supposed to catch invalid combination, hmzoned-compatible
>options are verified at the beginning. 'cache_gen' can be potentially
>non-zero (fuzzed image, accidental random overwrite from last time), so
>I think a message should be printed. If it's possible to continue, eg.
>completely ignoring the existing space cache that's more user friendly
>than a plain unexplained WARN_ON.

We can just ignore the generation value and continue. I'll rewrite to
use btrfs_info(info, "ignoring existing space cache in HMZONED mode.")
instead of WARN_ON.

Thanks,
