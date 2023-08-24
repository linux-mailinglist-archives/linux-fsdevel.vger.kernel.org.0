Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E3C786C31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 11:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbjHXJmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 05:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbjHXJmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:42:03 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A200A10F9;
        Thu, 24 Aug 2023 02:42:00 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="129334414"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="129334414"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 18:41:57 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 43EB8CD7E2;
        Thu, 24 Aug 2023 18:41:53 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 711AFE4AE7;
        Thu, 24 Aug 2023 18:41:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C0CD320093563;
        Thu, 24 Aug 2023 18:41:51 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.234.230])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id C63971A0073;
        Thu, 24 Aug 2023 17:41:50 +0800 (CST)
Message-ID: <999e83ca-df65-4a43-9d32-ff13a252c2d7@fujitsu.com>
Date:   Thu, 24 Aug 2023 17:41:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13] mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, mcgrof@kernel.org
References: <20230629081651.253626-3-ruansy.fnst@fujitsu.com>
 <20230823081706.2970430-1-ruansy.fnst@fujitsu.com>
 <20230823233601.GH11263@frogsfrogsfrogs>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20230823233601.GH11263@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27832.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27832.006
X-TMASE-Result: 10--25.814300-10.000000
X-TMASE-MatchedRID: WXBh9Xkni9aPvrMjLFD6eHchRkqzj/bEC/ExpXrHizxBqLOmHiM3wyDU
        0t/WFgAcM21CreAEMZhHW7omdzHbHeVaI0j/eUAPxDiakrJ+Spl4fCfFRQ30yN20KhkCTcTU0Eq
        FjE9+26goQVAihVrNS4NRyZUAEJtaRtJQAvHxVGkvun/+8u/hs4OeZuUUsCzCuzdiHYg4JjN0O3
        P7NRJ5H5ytBOG1WZxWyksi4Z4sCs2eTALXPNvL0hmCYUYerLHro8tN19oTXleaDNlRJumzuRFup
        4CINH3JYGFrrc6fVM/jpCo1bCzvK2sth/lQGvIl0wmR34xRQc8aJDwYgQY/f1gLks93sG9t4xO7
        9tPLHE+Asfk6HtbFfxFBD6+ejtliL/tBTZzO5Q3R7uN8GOEHx9DEMPvvoocvHTMj5a5/7iYUXKi
        zhC4rw6zTHbhNDPvt6rDhzwOXTehS0bd+i8J5ed+pUF0HsjxRyeUl7aCTy8iC1l3nLH+RlRWZS6
        woN/9Fd5/rOwjY0Ilf9c8yqC+c5mXZNELg4fvBlTsGW3DmpUulY4F8r0vXP0DM9hRIPPFMIa7NU
        ssol07Azu336p/mXrDWbmALScPNPdNB9SkC/WxYUconbBJWJPEpHaRtv5/XZUgeE6Z9kRN79xCS
        a3QbsQRxo9aqLgqrYDm9oSi8Og9keVpWP2Sy+a5bb5QEYSkdrzl8sNiWClKbKItl61J/ybLn+0V
        m71Lc3t//bkkogL6/v0UhTKC9nMRB0bsfrpPI6T/LTDsmJmg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/8/24 7:36, Darrick J. Wong 写道:
> On Wed, Aug 23, 2023 at 04:17:06PM +0800, Shiyang Ruan wrote:
>> ====
>> Changes since v12:
>>   1. correct flag name in subject (MF_MEM_REMOVE => MF_MEM_PRE_REMOVE)
>>   2. complete the behavior when fs has already frozen by kernel call
>>        NOTICE: Instead of "call notify_failure() again w/o PRE_REMOVE",
>>                I tried this proposal[0].
>>   3. call xfs_dax_notify_failure_freeze() and _thaw() in same function
>>   4. rebase on: xfs/xfs-linux.git vfs-for-next
>> ====
>>
>> Now, if we suddenly remove a PMEM device(by calling unbind) which
>> contains FSDAX while programs are still accessing data in this device,
>> e.g.:
>> ```
>>   $FSSTRESS_PROG -d $SCRATCH_MNT -n 99999 -p 4 &
>>   # $FSX_PROG -N 1000000 -o 8192 -l 500000 $SCRATCH_MNT/t001 &
>>   echo "pfn1.1" > /sys/bus/nd/drivers/nd_pmem/unbind
>> ```
>> it could come into an unacceptable state:
>>    1. device has gone but mount point still exists, and umount will fail
>>         with "target is busy"
>>    2. programs will hang and cannot be killed
>>    3. may crash with NULL pointer dereference
>>
>> To fix this, we introduce a MF_MEM_PRE_REMOVE flag to let it know that we
>> are going to remove the whole device, and make sure all related processes
>> could be notified so that they could end up gracefully.
>>
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
>> [0]: https://lore.kernel.org/linux-xfs/25cf6700-4db0-a346-632c-ec9fc291793a@fujitsu.com/
>> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
>> [2]: https://lore.kernel.org/linux-xfs/169116275623.3187159.16862410128731457358.stg-ugh@frogsfrogsfrogs/
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/dax/super.c         |  3 +-
>>   fs/xfs/xfs_notify_failure.c | 99 ++++++++++++++++++++++++++++++++++---
>>   include/linux/mm.h          |  1 +
>>   mm/memory-failure.c         | 17 +++++--
>>   4 files changed, 109 insertions(+), 11 deletions(-)
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
>> index 4a9bbd3fe120..6496c32a9172 100644
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
>> @@ -92,14 +99,60 @@ xfs_dax_failure_fn(
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
>> +static int
>> +xfs_dax_notify_failure_freeze(
>> +	struct xfs_mount	*mp)
>> +{
>> +	struct super_block	*sb = mp->m_super;
>> +	int			error;
>> +
>> +	error = freeze_super(sb, FREEZE_HOLDER_KERNEL);
>> +	if (error)
>> +		xfs_emerg(mp, "already frozen by kernel, err=%d", error);
>> +
>> +	return error;
>> +}
>> +
>> +static void
>> +xfs_dax_notify_failure_thaw(
>> +	struct xfs_mount	*mp,
>> +	bool			kernel_frozen)
>> +{
>> +	struct super_block	*sb = mp->m_super;
>> +	int			error;
>> +
>> +	if (!kernel_frozen) {
>> +		error = thaw_super(sb, FREEZE_HOLDER_KERNEL);
>> +		if (error)
>> +			xfs_emerg(mp, "still frozen after notify failure, err=%d",
>> +				error);
>> +	}
>> +
>> +	/*
>> +	 * Also thaw userspace call anyway because the device is about to be
>> +	 * removed immediately.
> 
> Does a userspace freeze inhibit or otherwise break device removal?

It doesn't.  Device can be removed.  But after that, the mount point 
still exists, and `umount /mnt/scratch` fails with "target is busy." 
`xfs_freeze -u /mnt/scratch` cannot work too.

So, I think thaw_super() anyway here is needed.


> 
>> +	 */
>> +	thaw_super(sb, FREEZE_HOLDER_USERSPACE);
>> +}
>> +
>>   static int
>>   xfs_dax_notify_ddev_failure(
>>   	struct xfs_mount	*mp,
>> @@ -112,15 +165,29 @@ xfs_dax_notify_ddev_failure(
>>   	struct xfs_btree_cur	*cur = NULL;
>>   	struct xfs_buf		*agf_bp = NULL;
>>   	int			error = 0;
>> +	bool			kernel_frozen = false;
>>   	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
>>   	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
>>   	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp,
>>   							     daddr + bblen - 1);
>>   	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
>>   
>> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
>> +		xfs_info(mp, "Device is about to be removed!");
>> +		/* Freeze fs to prevent new mappings from being created. */
>> +		error = xfs_dax_notify_failure_freeze(mp);
>> +		if (error) {
>> +			/* Keep going on if filesystem is frozen by kernel. */
>> +			if (error == -EBUSY)
>> +				kernel_frozen = true;
> 
> EBUSY means that xfs_dax_notify_failure_freeze did /not/ succeed in
> kernel-freezing the fs.  Someone else did, and they're expecting that
> thaw_super will undo that.
> 
> 	switch (error) {
> 	case -EBUSY:
> 		/* someone else froze the fs, keep going */
> 		break;
> 	case 0:
> 		/* we froze the fs */
> 		kernel_frozen = true;
> 		break;
> 	default:
> 		/* something else broke, should we continue anyway? */
> 		return error;
> 	}
> 
> TBH I wonder why all that isn't just:
> 
> 	kernel_frozen = xfs_dax_notify_failure_freeze(mp) == 0;
> 
> Since we'd want to keep going even if (say) the pmem was already
> starting to fail and the freeze actually failed due to EIO, right?

Yes.  So we can say it is a *try* to _freeze() here.  No matter what its 
result is, we continue.

Then I think the `kernel_frozen` becomes useless as well.  Because we 
should try to call both _thaw(KERNEL_CALL) and _thaw(USER_CALL) to make 
sure umount can work after device is gone.

Then, I think it's better to change them:
   `static int xfs_dax_notify_failure_freeze()`,
   `static void xfs_dax_notify_failure_thaw()`
to
   `static void xfs_dax_notify_failure_try_freeze()`,
   `static void xfs_dax_notify_failure_try_thaw()`.


--
Thanks,
Ruan.

> 
> --D
> 
>> +			else
>> +				return error;
>> +		}
>> +	}
>> +
>>   	error = xfs_trans_alloc_empty(mp, &tp);
>>   	if (error)
>> -		return error;
>> +		goto out;
>>   
>>   	for (; agno <= end_agno; agno++) {
>>   		struct xfs_rmap_irec	ri_low = { };
>> @@ -165,11 +232,23 @@ xfs_dax_notify_ddev_failure(
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
>> +	/* Thaw the fs if it is frozen before. */
>> +	if (mf_flags & MF_MEM_PRE_REMOVE)
>> +		xfs_dax_notify_failure_thaw(mp, kernel_frozen);
>> +
>>   	return error;
>>   }
>>   
>> @@ -197,6 +276,8 @@ xfs_dax_notify_failure(
>>   
>>   	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>>   	    mp->m_logdev_targp != mp->m_ddev_targp) {
>> +		if (mf_flags & MF_MEM_PRE_REMOVE)
>> +			return 0;
>>   		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>>   		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>>   		return -EFSCORRUPTED;
>> @@ -210,6 +291,12 @@ xfs_dax_notify_failure(
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
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 799836e84840..944a1165a321 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3577,6 +3577,7 @@ enum mf_flags {
>>   	MF_UNPOISON = 1 << 4,
>>   	MF_SW_SIMULATED = 1 << 5,
>>   	MF_NO_RETRY = 1 << 6,
>> +	MF_MEM_PRE_REMOVE = 1 << 7,
>>   };
>>   int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>>   		      unsigned long count, int mf_flags);
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index dc5ff7dd4e50..92f18c9e0aaf 100644
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
>> +		 * Search for all tasks while MF_MEM_PRE_REMOVE is set, because
>> +		 * the current may not be the one accessing the fsdax page.
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
>> 2.41.0
>>
