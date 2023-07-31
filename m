Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D6B7691E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 11:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGaJgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 05:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjGaJgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:36:48 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D3199;
        Mon, 31 Jul 2023 02:36:43 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="114190180"
X-IronPort-AV: E=Sophos;i="6.01,244,1684767600"; 
   d="scan'208";a="114190180"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:36:40 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 01A51D29E8;
        Mon, 31 Jul 2023 18:36:39 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 36D85D6059;
        Mon, 31 Jul 2023 18:36:38 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id BFCA410211;
        Mon, 31 Jul 2023 18:36:37 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.234.230])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id BBDA81A0070;
        Mon, 31 Jul 2023 17:36:36 +0800 (CST)
Message-ID: <da239482-b3e4-a9d4-a1cc-c13973fb9cef@fujitsu.com>
Date:   Mon, 31 Jul 2023 17:36:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, mcgrof@kernel.org
References: <20230629081651.253626-1-ruansy.fnst@fujitsu.com>
 <20230629081651.253626-3-ruansy.fnst@fujitsu.com>
 <20230729151506.GI11352@frogsfrogsfrogs>
Content-Language: en-US
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20230729151506.GI11352@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27784.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27784.006
X-TMASE-Result: 10--21.513100-10.000000
X-TMASE-MatchedRID: fQs1WIo05PGPvrMjLFD6eHchRkqzj/bEC/ExpXrHizxBqLOmHiM3wxem
        4OLSGy1EiNggJ6Pbm2FbtzD5SJbjLpGZilTi8ctSxDiakrJ+Splt9UVWhqbRIWtEzrC9eANpEJm
        hpJ8aMPMs4TH6G8STucqWFlCQS6PJay2H+VAa8iXTCZHfjFFBzxokPBiBBj9/WAuSz3ewb23jE7
        v208scT4Cx+Toe1sV/EUEPr56O2WIv+0FNnM7lDRFbgtHjUWLyGB9/bxS68hPMtotGtpF5VgimM
        t6TSXWl9IAP3W8IJ6ROaA8tMUkyucwitucT3dE79Ib/6w+1lWQ0YL9SJPufX7E9dgiHWXp2dCIZ
        l7SNYAwqrSgxSiVy6T4BGdad1mqh8p7loYJT/FuDpW5ZeDjLZEEe5VjFzwNbFCmwHLoxcsa20nP
        Q2eZ7CcNUkvwuYWUMsNZuYAtJw80900H1KQL9bG03YawHJvPCTfK5j0EZbyuHvxzu1FG4kbEOoi
        tFQVcIGBKlWUwuGka5HjqbLog5/l7FLEpyoHYAgnMtC97jHVQXivwflisSrHd17Y6gGqDCbxGoC
        yAt4uiBwOiAXd70LJNHG+DwJ1Q9najGxrJsU4OeAiCmPx4NwFkMvWAuahr8AsMBg/gBdVHudjnW
        XAurT7xAi7jPoeEQftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/7/29 23:15, Darrick J. Wong 写道:
> On Thu, Jun 29, 2023 at 04:16:51PM +0800, Shiyang Ruan wrote:
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
>>   
>>   	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
>>   	synchronize_srcu(&dax_srcu);
>> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
>> index 4a9bbd3fe120..f6ec56b76db6 100644
>> --- a/fs/xfs/xfs_notify_failure.c
>> +++ b/fs/xfs/xfs_notify_failure.c
>> @@ -22,6 +22,7 @@
>>   
>>   #include <linux/mm.h>
>>   #include <linux/dax.h>
>> +#include <linux/fs.h>
>>   
>>   struct xfs_failure_info {
>>   	xfs_agblock_t		startblock;
>> @@ -73,10 +74,16 @@ xfs_dax_failure_fn(
>>   	struct xfs_mount		*mp = cur->bc_mp;
>>   	struct xfs_inode		*ip;
>>   	struct xfs_failure_info		*notify = data;
>> +	struct address_space		*mapping;
>> +	pgoff_t				pgoff;
>> +	unsigned long			pgcnt;
>>   	int				error = 0;
>>   
>>   	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>>   	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
>> +		/* Continue the query because this isn't a failure. */
>> +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
>> +			return 0;
>>   		notify->want_shutdown = true;
>>   		return 0;
>>   	}
>> @@ -92,14 +99,55 @@ xfs_dax_failure_fn(
>>   		return 0;
>>   	}
>>   
>> -	error = mf_dax_kill_procs(VFS_I(ip)->i_mapping,
>> -				  xfs_failure_pgoff(mp, rec, notify),
>> -				  xfs_failure_pgcnt(mp, rec, notify),
>> -				  notify->mf_flags);
>> +	mapping = VFS_I(ip)->i_mapping;
>> +	pgoff = xfs_failure_pgoff(mp, rec, notify);
>> +	pgcnt = xfs_failure_pgcnt(mp, rec, notify);
>> +
>> +	/* Continue the rmap query if the inode isn't a dax file. */
>> +	if (dax_mapping(mapping))
>> +		error = mf_dax_kill_procs(mapping, pgoff, pgcnt,
>> +					  notify->mf_flags);
>> +
>> +	/* Invalidate the cache in dax pages. */
>> +	if (notify->mf_flags & MF_MEM_PRE_REMOVE)
>> +		invalidate_inode_pages2_range(mapping, pgoff,
>> +					      pgoff + pgcnt - 1);
>> +
>>   	xfs_irele(ip);
>>   	return error;
>>   }
>>   
>> +static void
>> +xfs_dax_notify_failure_freeze(
>> +	struct xfs_mount	*mp)
>> +{
>> +	struct super_block 	*sb = mp->m_super;
> 
> Nit: extra space right    ^ here.
> 
>> +
>> +	/* Wait until no one is holding the FREEZE_HOLDER_KERNEL. */
>> +	while (freeze_super(sb, FREEZE_HOLDER_KERNEL) != 0) {
>> +		// Shall we just wait, or print warning then return -EBUSY?
> 
> Hm.  PRE_REMOVE gets called before the pmem gets unplugged, right?  So
> we'll send a second notification after it goes away, right?

For the first question, yes.

But I'm not sure about the second one.  Do you mean: we'll send this 
notification again if unbind didn't success because freeze_super() 
returns -EBUSY?  In other words, if the previous unbind operation did 
not work, we could unbind the device again.

> 
> If so, then I'd say return the error here instead of looping, and live
> with a kernel-frozen fs discarding the PRE_REMOVE message.
> 
>> +		delay(HZ / 10);
>> +	}
>> +}
>> +
>> +static void
>> +xfs_dax_notify_failure_thaw(
>> +	struct xfs_mount	*mp)
>> +{
>> +	struct super_block	*sb = mp->m_super;
>> +	int			error;
>> +
>> +	error = thaw_super(sb, FREEZE_HOLDER_KERNEL);
>> +	if (error)
>> +		xfs_emerg(mp, "still frozen after notify failure, err=%d",
>> +			  error);
>> +	/*
>> +	 * Also thaw userspace call anyway because the device is about to be
>> +	 * removed immediately.
>> +	 */
>> +	thaw_super(sb, FREEZE_HOLDER_USERSPACE);
>> +}
>> +
>>   static int
>>   xfs_dax_notify_ddev_failure(
>>   	struct xfs_mount	*mp,
>> @@ -120,7 +168,7 @@ xfs_dax_notify_ddev_failure(
>>   
>>   	error = xfs_trans_alloc_empty(mp, &tp);
>>   	if (error)
>> -		return error;
>> +		goto out;
>>   
>>   	for (; agno <= end_agno; agno++) {
>>   		struct xfs_rmap_irec	ri_low = { };
>> @@ -165,11 +213,23 @@ xfs_dax_notify_ddev_failure(
>>   	}
>>   
>>   	xfs_trans_cancel(tp);
>> +
>> +	/*
>> +	 * Determine how to shutdown the filesystem according to the
>> +	 * error code and flags.
>> +	 */
>>   	if (error || notify.want_shutdown) {
>>   		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>>   		if (!error)
>>   			error = -EFSCORRUPTED;
>> -	}
>> +	} else if (mf_flags & MF_MEM_PRE_REMOVE)
>> +		xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
>> +
>> +out:
>> +	/* Thaw the fs if it is freezed before. */
>> +	if (mf_flags & MF_MEM_PRE_REMOVE)
>> +		xfs_dax_notify_failure_thaw(mp);
> 
> _thaw should be called from the same function that called _freeze.

Will fix this.

> 
> The rest of the patch seems ok to me.

Thank you!


--
Ruan.

> 
> --D
> 
>> +
>>   	return error;
>>   }
>>   
>> @@ -197,6 +257,8 @@ xfs_dax_notify_failure(
>>   
>>   	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>>   	    mp->m_logdev_targp != mp->m_ddev_targp) {
>> +		if (mf_flags & MF_MEM_PRE_REMOVE)
>> +			return 0;
>>   		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>>   		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>>   		return -EFSCORRUPTED;
>> @@ -210,6 +272,12 @@ xfs_dax_notify_failure(
>>   	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
>>   	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
>>   
>> +	/* Notify failure on the whole device. */
>> +	if (offset == 0 && len == U64_MAX) {
>> +		offset = ddev_start;
>> +		len = bdev_nr_bytes(mp->m_ddev_targp->bt_bdev);
>> +	}
>> +
>>   	/* Ignore the range out of filesystem area */
>>   	if (offset + len - 1 < ddev_start)
>>   		return -ENXIO;
>> @@ -226,6 +294,12 @@ xfs_dax_notify_failure(
>>   	if (offset + len - 1 > ddev_end)
>>   		len = ddev_end - offset + 1;
>>   
>> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
>> +		xfs_info(mp, "device is about to be removed!");
>> +		/* Freeze fs to prevent new mappings from being created. */
>> +		xfs_dax_notify_failure_freeze(mp);
>> +	}
>> +
>>   	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
>>   			mf_flags);
>>   }
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 27ce77080c79..a80c255b88d2 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3576,6 +3576,7 @@ enum mf_flags {
>>   	MF_UNPOISON = 1 << 4,
>>   	MF_SW_SIMULATED = 1 << 5,
>>   	MF_NO_RETRY = 1 << 6,
>> +	MF_MEM_PRE_REMOVE = 1 << 7,
>>   };
>>   int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>>   		      unsigned long count, int mf_flags);
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 5b663eca1f29..483b75f2fcfb 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -688,7 +688,7 @@ static void add_to_kill_fsdax(struct task_struct *tsk, struct page *p,
>>    */
>>   static void collect_procs_fsdax(struct page *page,
>>   		struct address_space *mapping, pgoff_t pgoff,
>> -		struct list_head *to_kill)
>> +		struct list_head *to_kill, bool pre_remove)
>>   {
>>   	struct vm_area_struct *vma;
>>   	struct task_struct *tsk;
>> @@ -696,8 +696,15 @@ static void collect_procs_fsdax(struct page *page,
>>   	i_mmap_lock_read(mapping);
>>   	read_lock(&tasklist_lock);
>>   	for_each_process(tsk) {
>> -		struct task_struct *t = task_early_kill(tsk, true);
>> +		struct task_struct *t = tsk;
>>   
>> +		/*
>> +		 * Search for all tasks while MF_MEM_PRE_REMOVE, because the
>> +		 * current may not be the one accessing the fsdax page.
>> +		 * Otherwise, search for the current task.
>> +		 */
>> +		if (!pre_remove)
>> +			t = task_early_kill(tsk, true);
>>   		if (!t)
>>   			continue;
>>   		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
>> @@ -1793,6 +1800,7 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>>   	dax_entry_t cookie;
>>   	struct page *page;
>>   	size_t end = index + count;
>> +	bool pre_remove = mf_flags & MF_MEM_PRE_REMOVE;
>>   
>>   	mf_flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
>>   
>> @@ -1804,9 +1812,10 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>>   		if (!page)
>>   			goto unlock;
>>   
>> -		SetPageHWPoison(page);
>> +		if (!pre_remove)
>> +			SetPageHWPoison(page);
>>   
>> -		collect_procs_fsdax(page, mapping, index, &to_kill);
>> +		collect_procs_fsdax(page, mapping, index, &to_kill, pre_remove);
>>   		unmap_and_kill(&to_kill, page_to_pfn(page), mapping,
>>   				index, mf_flags);
>>   unlock:
>> -- 
>> 2.40.1
>>
