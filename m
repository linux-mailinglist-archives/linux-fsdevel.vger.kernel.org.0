Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CCB785310
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 10:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjHWItT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 04:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjHWIsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:48:21 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0D11BF4;
        Wed, 23 Aug 2023 01:36:34 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="108493203"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="108493203"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 17:36:33 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8043ECA1E6;
        Wed, 23 Aug 2023 17:36:30 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B78B9BF4B8;
        Wed, 23 Aug 2023 17:36:29 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5AA5A2B1CF3;
        Wed, 23 Aug 2023 17:36:29 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.234.230])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 644271A008F;
        Wed, 23 Aug 2023 16:36:28 +0800 (CST)
Message-ID: <f28c7eca-0eb5-7338-2362-93d10a16cd64@fujitsu.com>
Date:   Wed, 23 Aug 2023 16:36:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
To:     Dan Williams <dan.j.williams@intel.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Cc:     willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org,
        djwong@kernel.org, mcgrof@kernel.org
References: <20230629081651.253626-1-ruansy.fnst@fujitsu.com>
 <20230629081651.253626-3-ruansy.fnst@fujitsu.com>
 <64d18cd6c6e09_5ea6e294fb@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <64d18cd6c6e09_5ea6e294fb@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27830.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27830.005
X-TMASE-Result: 10--29.976500-10.000000
X-TMASE-MatchedRID: UomY2wWC/KyPvrMjLFD6eCkMR2LAnMRp2q80vLACqaeqvcIF1TcLYI5a
        mlqOXwWavgUEAzu+ZVNbtzD5SJbjLpGZilTi8ctSxDiakrJ+Splt9UVWhqbRIWtEzrC9eANpEJm
        hpJ8aMPMs4TH6G8STucqWFlCQS6PJay2H+VAa8iXTCZHfjFFBzxokPBiBBj9/WAuSz3ewb23jE7
        v208scT7xxBqTj7wDsupZIYbG9DPyAsoqIP3ENkIvefyp1glN0MzbF1gbxlQZFms6YEs23D3Nrl
        Eb9qTKUfNghynX3+4Fh7mDBbvo6VLHUOxwKYaKnYCs5AYZvXC/4qCLIu0mtIMC5DTEMxpeQ3JB1
        YIf9iAoPNxz2EvpSIL/t8hsriyc8pANxWw95dxPY6EGR3k/uitG3Y6ijqBt3teXjSBMYnmklVDj
        pDxeIWyolWOAMg2fcFR2lGwd2c9E/O/cxE+VGcUWX0DfhVamwvD4YKo9SttxAzPYUSDzxTFDczN
        /SMpBY+u+xXVO1LUDeLyT0oSNhxXAA9eFj9SfYngIgpj8eDcBZDL1gLmoa/ALDAYP4AXVR7nY51
        lwLq0+8QIu4z6HhEH7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/8/8 8:31, Dan Williams 写道:
> Shiyang Ruan wrote:
>> This patch is inspired by Dan's "mm, dax, pmem: Introduce
>> dev_pagemap_failure()"[1].  With the help of dax_holder and
>> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
>> on it to unmap all files in use, and notify processes who are using
>> those files.
>>
>> Call trace:
>> trigger unbind
>>   -> unbind_store()
>>    -> ... (skip)
>>     -> devres_release_all()
>>      -> kill_dax()
>>       -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
>>        -> xfs_dax_notify_failure()
>>        `-> freeze_super()             // freeze (kernel call)
>>        `-> do xfs rmap
>>        ` -> mf_dax_kill_procs()
>>        `  -> collect_procs_fsdax()    // all associated processes
>>        `  -> unmap_and_kill()
>>        ` -> invalidate_inode_pages2_range() // drop file's cache
>>        `-> thaw_super()               // thaw (both kernel & user call)
>>
>> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
>> event.  Use the exclusive freeze/thaw[2] to lock the filesystem to prevent
>> new dax mapping from being created.  Do not shutdown filesystem directly
>> if configuration is not supported, or if failure range includes metadata
>> area.  Make sure all files and processes(not only the current progress)
>> are handled correctly.  Also drop the cache of associated files before
>> pmem is removed.
> 
> I would say more about why this is important for DAX users. Yes, the
> devm_memremap_pages() vs get_user_pages() infrastructure can be improved
> if it has a mechanism to revoke all pages that it has handed out for a
> given device, but that's not an end user visible effect.
> 
> The end user impact needs to be clear. Is this for existing deployed
> pmem where a user accidentally removes a device and wants failures and
> process killing instead of hangs?
> 
> The reason Linux has got along without this for so long is because pmem
> is difficult to remove (and with the sunset of Optane, difficult to
> acquire). One motivation to pursue this is CXL where hotplug is better
> defined and use cases like dynamic capacity devices where making forward
> progress to kill processes is better than hanging.
> 
> It would help to have an example of what happens without this patch.
> 
>>
>> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
>> [2]: https://lore.kernel.org/linux-xfs/168688010689.860947.1788875898367401950.stgit@frogsfrogsfrogs/
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/dax/super.c         |  3 +-
>>   fs/xfs/xfs_notify_failure.c | 86 ++++++++++++++++++++++++++++++++++---
>>   include/linux/mm.h          |  1 +
>>   mm/memory-failure.c         | 17 ++++++--
>>   4 files changed, 96 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
>> index c4c4728a36e4..2e1a35e82fce 100644
>> --- a/drivers/dax/super.c
>> +++ b/drivers/dax/super.c
>> @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
>>   		return;
>>   
>>   	if (dax_dev->holder_data != NULL)
>> -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
>> +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
>> +				MF_MEM_PRE_REMOVE);
> 
> The motivation in the original proposal was to convey the death of
> large extents to memory_failure(). However, that proposal predated your
> mf_dax_kill_procs() approach. With mf_dax_kill_procs() the need for a
> new bulk memory_failure() API is gone.
> 
> This is where the end user impact needs to be clear. It seems that
> without this patch the filesystem may assume failure while the device is
> already present, but that seems ok. The goal is forward progress after a
> mistake not necessarily minimizing damage after a mistake. The fact that
> the current code is not as gentle could be considered a feature because
> graceful shutdown should always unmount before unplug, and if one
> unplugs before unmount it is already understood that they get to keep
> the pieces.
> 
> Because the driver ->remove() callback can not enforce that the device
> is still present it seems unnecessary to optimize for the case where the
> filesystem is the device is being removed from an actively mounted
> filesystem, but the device is still present.
> 
> The dax_holder_notify_failure(dax_dev, 0, U64_MAX) is sufficient to say
> "userspace failed to umount before hardware eject, stop trying to access
> this range", rather than "try to finish up in this range, but it might
> already be too late".

Hi Dan,

I added an simple example of "accidentally remove pmem device" and its 
consequences of not having this patch in the latest version.  Please review.


--
Thanks,
Ruan.
