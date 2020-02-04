Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0C415235A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 00:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgBDXtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 18:49:19 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62723 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbgBDXtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580860161; x=1612396161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ckYcLi5YC5b2Po3ECoBPoiB/ys4kTWBG3lKNwDFgPe0=;
  b=oryHwn0eB4f4QeZYcZK/x4CqzJYHqVrfZPAlb1YrxjRXT/cBnL4XhlWI
   AzjZ517tExMyy9VSS+7Q6gYcvB9cMwqvbJAnKXBkoszEJuX/pkNiHvDuI
   sY9MXjZ4XEs6HaYirb4j114YfZNa6oXpaYOwUsu45SJTsTUr61pco35XQ
   SX2CnX/F6xH+jJfPPTTi5VnKUoTe6lXxqeueDarbJ6yPXjW/IRI7FkCfO
   cdiYx2J9F3wZWlolRexn6IRqQjd2kY4J1cp/aSGod9ujbZsgQoNmV7FNJ
   ytU7Oalvt5Lb+i8KvtOQWpcKTakBApg6rbiV/vbBGfHbGxQfZwe12Br3h
   w==;
IronPort-SDR: QG+r9fMCmXMj1NIAlJSFIvGaLS6LH0EkgmLP7/1mEH+3kxyNLArfEUv1fRSPt1AQwBg4pxmMPz
 DcgMwt/cmwWSkEkkD2qN2oQVDFgvGRJdvTX3yPGLWk9t3S5dweOsNAmNSlXyd9Q1IGdtnW5fWs
 6uyMlcvd2AfZx4j1ZIUqVbSPi4dVRLoY38B9ay2kfhn1r67dw4ZkPtBxR5sHTloti6uh4B1FiR
 iRAQt0dm0YHJ31VdnmDXay24+OUBhVmop6ct8oGf4PIRnuY5umbmBhYr0csgfgSozWuhk8y5d4
 h+M=
X-IronPort-AV: E=Sophos;i="5.70,403,1574092800"; 
   d="scan'208";a="230842178"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 07:49:20 +0800
IronPort-SDR: PZg7g6iEtcy1TMxuVK/xRABS3hA1JYUVt3T4JYfsCescB8lDWWZN/g4E1LpiNwDK8KhP/GIqd9
 Y8MBUNlCI2Fgizp6WsGreVoykqmNiO8q4tjq0q7nC0oEcMvtYD8BQvknOokfOz+zgioLjzDKZZ
 OJc8aTh/4Mc5v1+1f4BwuXdOdPX4AhnC0aOQfNuq0B8zaVGvQbzStt1/93EnwfJU6E2wI2IRKQ
 cJmuoAttzzcpWDTWInHy/ngfS9CVUioZ81La6ZL8DmKqjvmiA4aG6DXK41FshEkKwRZSAAtH0a
 cIhr2sRdaF3VQdR9wnREmnor
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 15:42:19 -0800
IronPort-SDR: g7OB+PPOihiqJ7yEeBwgDznQ+9Bv73Dkx0gMW+L1Z8epVrbQzYLo1CkCkxCa4c1HnozbDcfpH4
 xJJd3GSS1tULNdiG7Z7/7RNc3dMm1fDVk86CPOpq4ypIhnWR6HYuFn9ymSj0D+ZD/L72eMgU6D
 RiRGe7pJ81swEsYp12+foKwB1KSFAI9/xQ8NQo1XdXCbUMWzjRfQf7kR+Xo3DTMRTwUYAUdbWb
 3Ma4F1ryjO2JSUNN+P8q7n2Lurafjg6jXxDHtMq49w5wYNKX4fhfO23ANOrVjhbD01hIQ4tjLP
 aDA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 04 Feb 2020 15:49:17 -0800
Received: (nullmailer pid 1090808 invoked by uid 1000);
        Tue, 04 Feb 2020 23:49:16 -0000
Date:   Wed, 5 Feb 2020 08:49:16 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mm, swap: unlock inode in error path of claim_swapfile
Message-ID: <20200204234916.s6zx6i2ko4mvxim2@naota.dhcp.fujisawa.hgst.com>
References: <20200204095943.727666-1-naohiro.aota@wdc.com>
 <20200204154229.GC6874@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200204154229.GC6874@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 07:42:29AM -0800, Darrick J. Wong wrote:
>On Tue, Feb 04, 2020 at 06:59:43PM +0900, Naohiro Aota wrote:
>> claim_swapfile() currently keeps the inode locked when it is successful, or
>> the file is already swapfile (with -EBUSY). And, on the other error cases,
>> it does not lock the inode.
>>
>> This inconsistency of the lock state and return value is quite confusing
>> and actually causing a bad unlock balance as below in the "bad_swap"
>> section of __do_sys_swapon().
>>
>> This commit fixes this issue by unlocking the inode on the error path. It
>> also reverts blocksize and releases bdev, so that the caller can safely
>> forget about the inode.
>>
>>     =====================================
>>     WARNING: bad unlock balance detected!
>>     5.5.0-rc7+ #176 Not tainted
>>     -------------------------------------
>>     swapon/4294 is trying to release lock (&sb->s_type->i_mutex_key) at:
>>     [<ffffffff8173a6eb>] __do_sys_swapon+0x94b/0x3550
>>     but there are no more locks to release!
>>
>>     other info that might help us debug this:
>>     no locks held by swapon/4294.
>>
>>     stack backtrace:
>>     CPU: 5 PID: 4294 Comm: swapon Not tainted 5.5.0-rc7-BTRFS-ZNS+ #176
>>     Hardware name: ASUS All Series/H87-PRO, BIOS 2102 07/29/2014
>>     Call Trace:
>>      dump_stack+0xa1/0xea
>>      ? __do_sys_swapon+0x94b/0x3550
>>      print_unlock_imbalance_bug.cold+0x114/0x123
>>      ? __do_sys_swapon+0x94b/0x3550
>>      lock_release+0x562/0xed0
>>      ? kvfree+0x31/0x40
>>      ? lock_downgrade+0x770/0x770
>>      ? kvfree+0x31/0x40
>>      ? rcu_read_lock_sched_held+0xa1/0xd0
>>      ? rcu_read_lock_bh_held+0xb0/0xb0
>>      up_write+0x2d/0x490
>>      ? kfree+0x293/0x2f0
>>      __do_sys_swapon+0x94b/0x3550
>>      ? putname+0xb0/0xf0
>>      ? kmem_cache_free+0x2e7/0x370
>>      ? do_sys_open+0x184/0x3e0
>>      ? generic_max_swapfile_size+0x40/0x40
>>      ? do_syscall_64+0x27/0x4b0
>>      ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>      ? lockdep_hardirqs_on+0x38c/0x590
>>      __x64_sys_swapon+0x54/0x80
>>      do_syscall_64+0xa4/0x4b0
>>      entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>     RIP: 0033:0x7f15da0a0dc7
>>
>> Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> ---
>>  mm/swapfile.c | 29 ++++++++++++++++++++++-------
>>  1 file changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index bb3261d45b6a..dd5d7fa42282 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -2886,24 +2886,37 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
>>  		p->old_block_size = block_size(p->bdev);
>>  		error = set_blocksize(p->bdev, PAGE_SIZE);
>>  		if (error < 0)
>> -			return error;
>> +			goto err;
>>  		/*
>>  		 * Zoned block devices contain zones that have a sequential
>>  		 * write only restriction.  Hence zoned block devices are not
>>  		 * suitable for swapping.  Disallow them here.
>>  		 */
>> -		if (blk_queue_is_zoned(p->bdev->bd_queue))
>> -			return -EINVAL;
>> +		if (blk_queue_is_zoned(p->bdev->bd_queue)) {
>> +			error = -EINVAL;
>> +			goto err;
>> +		}
>>  		p->flags |= SWP_BLKDEV;
>>  	} else if (S_ISREG(inode->i_mode)) {
>>  		p->bdev = inode->i_sb->s_bdev;
>>  	}
>>
>>  	inode_lock(inode);
>> -	if (IS_SWAPFILE(inode))
>> -		return -EBUSY;
>> +	if (IS_SWAPFILE(inode)) {
>> +		inode_unlock(inode);
>> +		error = -EBUSY;
>> +		goto err;
>> +	}
>>
>>  	return 0;
>> +
>> +err:
>> +	if (S_ISBLK(inode->i_mode)) {
>> +		set_blocksize(p->bdev, p->old_block_size);
>> +		blkdev_put(p->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
>> +	}
>> +
>> +	return error;
>>  }
>>
>>
>> @@ -3157,10 +3170,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>  	mapping = swap_file->f_mapping;
>>  	inode = mapping->host;
>>
>> -	/* If S_ISREG(inode->i_mode) will do inode_lock(inode); */
>> +	/* do inode_lock(inode); */
>
>What if we made this function responsible for calling inode_lock (and
>unlock) instead of splitting it between sys_swapon and claim_swapfile?

I think we cannot take inode_lock before claim_swapfile() because we can
have circular locking dependency as:

claim_swapfile()
-> blkdev_get() 
    -> __blkdev_get()
       -> mutex_lock(&bdev->bd_mutex)
       -> bd_set_size()
          -> inode_lock(&bdev->bd_inode);

So, one thing we can do is to move inode_lock() and "if (IS_SWAPFILE(..))
..." out of claim_swapfile(). In this case, the "bad_swap" section must
check if "inode_is_locked" to call "inode_unlock".

>
>--D
>
>>  	error = claim_swapfile(p, inode);
>> -	if (unlikely(error))
>> +	if (unlikely(error)) {
>> +		inode = NULL;
>>  		goto bad_swap;
>> +	}
>>
>>  	/*
>>  	 * Read the swap header.
>> --
>> 2.25.0
>>
