Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6988A15249B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 03:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgBECBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 21:01:30 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19643 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbgBECBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580868089; x=1612404089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SyD/cpSqf3fsyjP7v6TIGvkanp29RFxaNJ9Ii2ufFlg=;
  b=P88E5yN/WgpaOUPIA8BTsC4DckrKxVabCVA7cA/+ZpAKkQwc0Dn4nJY/
   J3d9b+BX4Pb2I24ShKaFBitvOL3aQEko/jBcxj/EXLKkgaIyI4rj0EgPV
   3GXmnIGRPcfC1Kkg0kbZ4uE6Ch1/44a+GbLw8meZP/2aduFINILrup+mg
   HmKC0vGolAM3gQShNZ7F9V07xSeWNBABzMt6DvxcPpt29hhxgTnbuhoUI
   Yw89OPtBYse65PzG0OvwxzWOdnwmgb1gkJroHf9jmC67qsZX/TAE3XNtg
   8v8qsuidiNaUSPJG4W4NJHrmFqZ+8x5bN63CAICUMhKv2iWnLaG5pCbgm
   A==;
IronPort-SDR: a7jtzxFE2rDCsGYlFn8TrX/pjjAdpIeQjVudC6ZKL3dUpDq/i0mHrpjMuRrSRlBI1aJmcxecv/
 C9P/SUMHBrAE3qhT0PL80OeyOTR+tnsFFUBr8bH4LkgKGFAH4MY+YFVtIF9BY59Ml5s6xqFpnF
 m/Rxi1HrJpr3aoV8unkfv8ckKUqjJVdP3/l1/pLr8rxliQ55pTzIqwxlgtPDU/p1CjUpX7ZmQV
 c5t8IknyxJWrspT4GYB21Xi5O+IjxZwgVF4gJka9ww3rBA4q2+/icmRtsOaX8zR6ReCYM5Eomz
 N8g=
X-IronPort-AV: E=Sophos;i="5.70,404,1574092800"; 
   d="scan'208";a="237075800"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 10:01:29 +0800
IronPort-SDR: qR8/dUn9JRRfgme8xu/X5929kqJqmNjg1DWE8TvCSjmZTX/SFfVCsl6S9fmMiLPgOeK2Z6dd9S
 pjpG9Vkx/dT0fDcSxz+3UmqhGIXMj1/lp3iAJy7IvkBWTL1YJ2c2Ho9Sp/+kyRt5uruH0W5WiR
 X37kU8eKPE0fkS5UtIo24eNiqAfNOWMZPW/wUBOyghYG9o0qQc0szvMS1mZ/iuBmUeoenD2nSB
 nmGUXUv9D0/DdJo0ytpsWNWu1MzmWFzdBUsk5FE9vT8/4J+Z/y+4DDvN9qFw8s1ri6p6i6YeNs
 dm04QTWr3/I+ouiH4pD567BO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 17:54:30 -0800
IronPort-SDR: cqmtsDlZ7qsPDgjufUiSSi88Qmix/oHaXZmFMVf9B6sbKU/AXd7KSjufcreyMxsVr6d5fGsEKP
 nfASaZKfbkTwg7JJj9t5QG4qTfC7YoV4yZoJPbkkJYAkd7dnlr6xwOO1U4SdzQ5vO+UmfqMhwu
 tbGvIfhVQJx8lfpeJJZWWnHZRfYV94UGvgPcVrwzwnOMavN26CT1Mg2z1Fqn2REUbSXK0VtKMP
 cOBGRGOVBqI16gsxLXCyLJqBNWDU21jVF8MMgYQxKUQ+KBQuN1mXaj7KASzKcWNnWREbJ5g5ww
 g/w=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 04 Feb 2020 18:01:28 -0800
Received: (nullmailer pid 1228849 invoked by uid 1000);
        Wed, 05 Feb 2020 02:01:27 -0000
Date:   Wed, 5 Feb 2020 11:01:27 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mm, swap: unlock inode in error path of claim_swapfile
Message-ID: <20200205020127.v3rhbndyr6e7edbn@naota.dhcp.fujisawa.hgst.com>
References: <20200204095943.727666-1-naohiro.aota@wdc.com>
 <20200204154229.GC6874@magnolia>
 <20200204234916.s6zx6i2ko4mvxim2@naota.dhcp.fujisawa.hgst.com>
 <20200204235608.GG6874@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200204235608.GG6874@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:56:08PM -0800, Darrick J. Wong wrote:
>On Wed, Feb 05, 2020 at 08:49:16AM +0900, Naohiro Aota wrote:
>> On Tue, Feb 04, 2020 at 07:42:29AM -0800, Darrick J. Wong wrote:
>> > On Tue, Feb 04, 2020 at 06:59:43PM +0900, Naohiro Aota wrote:
>> > > claim_swapfile() currently keeps the inode locked when it is successful, or
>> > > the file is already swapfile (with -EBUSY). And, on the other error cases,
>> > > it does not lock the inode.
>> > >
>> > > This inconsistency of the lock state and return value is quite confusing
>> > > and actually causing a bad unlock balance as below in the "bad_swap"
>> > > section of __do_sys_swapon().
>> > >
>> > > This commit fixes this issue by unlocking the inode on the error path. It
>> > > also reverts blocksize and releases bdev, so that the caller can safely
>> > > forget about the inode.
>> > >
>> > >     =====================================
>> > >     WARNING: bad unlock balance detected!
>> > >     5.5.0-rc7+ #176 Not tainted
>> > >     -------------------------------------
>> > >     swapon/4294 is trying to release lock (&sb->s_type->i_mutex_key) at:
>> > >     [<ffffffff8173a6eb>] __do_sys_swapon+0x94b/0x3550
>> > >     but there are no more locks to release!
>> > >
>> > >     other info that might help us debug this:
>> > >     no locks held by swapon/4294.
>> > >
>> > >     stack backtrace:
>> > >     CPU: 5 PID: 4294 Comm: swapon Not tainted 5.5.0-rc7-BTRFS-ZNS+ #176
>> > >     Hardware name: ASUS All Series/H87-PRO, BIOS 2102 07/29/2014
>> > >     Call Trace:
>> > >      dump_stack+0xa1/0xea
>> > >      ? __do_sys_swapon+0x94b/0x3550
>> > >      print_unlock_imbalance_bug.cold+0x114/0x123
>> > >      ? __do_sys_swapon+0x94b/0x3550
>> > >      lock_release+0x562/0xed0
>> > >      ? kvfree+0x31/0x40
>> > >      ? lock_downgrade+0x770/0x770
>> > >      ? kvfree+0x31/0x40
>> > >      ? rcu_read_lock_sched_held+0xa1/0xd0
>> > >      ? rcu_read_lock_bh_held+0xb0/0xb0
>> > >      up_write+0x2d/0x490
>> > >      ? kfree+0x293/0x2f0
>> > >      __do_sys_swapon+0x94b/0x3550
>> > >      ? putname+0xb0/0xf0
>> > >      ? kmem_cache_free+0x2e7/0x370
>> > >      ? do_sys_open+0x184/0x3e0
>> > >      ? generic_max_swapfile_size+0x40/0x40
>> > >      ? do_syscall_64+0x27/0x4b0
>> > >      ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> > >      ? lockdep_hardirqs_on+0x38c/0x590
>> > >      __x64_sys_swapon+0x54/0x80
>> > >      do_syscall_64+0xa4/0x4b0
>> > >      entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> > >     RIP: 0033:0x7f15da0a0dc7
>> > >
>> > > Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
>> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> > > ---
>> > >  mm/swapfile.c | 29 ++++++++++++++++++++++-------
>> > >  1 file changed, 22 insertions(+), 7 deletions(-)
>> > >
>> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> > > index bb3261d45b6a..dd5d7fa42282 100644
>> > > --- a/mm/swapfile.c
>> > > +++ b/mm/swapfile.c
>> > > @@ -2886,24 +2886,37 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
>> > >  		p->old_block_size = block_size(p->bdev);
>> > >  		error = set_blocksize(p->bdev, PAGE_SIZE);
>> > >  		if (error < 0)
>> > > -			return error;
>> > > +			goto err;
>> > >  		/*
>> > >  		 * Zoned block devices contain zones that have a sequential
>> > >  		 * write only restriction.  Hence zoned block devices are not
>> > >  		 * suitable for swapping.  Disallow them here.
>> > >  		 */
>> > > -		if (blk_queue_is_zoned(p->bdev->bd_queue))
>> > > -			return -EINVAL;
>> > > +		if (blk_queue_is_zoned(p->bdev->bd_queue)) {
>> > > +			error = -EINVAL;
>> > > +			goto err;
>> > > +		}
>> > >  		p->flags |= SWP_BLKDEV;
>> > >  	} else if (S_ISREG(inode->i_mode)) {
>> > >  		p->bdev = inode->i_sb->s_bdev;
>> > >  	}
>> > >
>> > >  	inode_lock(inode);
>> > > -	if (IS_SWAPFILE(inode))
>> > > -		return -EBUSY;
>> > > +	if (IS_SWAPFILE(inode)) {
>> > > +		inode_unlock(inode);
>> > > +		error = -EBUSY;
>> > > +		goto err;
>> > > +	}
>> > >
>> > >  	return 0;
>> > > +
>> > > +err:
>> > > +	if (S_ISBLK(inode->i_mode)) {
>> > > +		set_blocksize(p->bdev, p->old_block_size);
>> > > +		blkdev_put(p->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
>> > > +	}
>> > > +
>> > > +	return error;
>> > >  }
>> > >
>> > >
>> > > @@ -3157,10 +3170,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>> > >  	mapping = swap_file->f_mapping;
>> > >  	inode = mapping->host;
>> > >
>> > > -	/* If S_ISREG(inode->i_mode) will do inode_lock(inode); */
>> > > +	/* do inode_lock(inode); */
>> >
>> > What if we made this function responsible for calling inode_lock (and
>> > unlock) instead of splitting it between sys_swapon and claim_swapfile?
>>
>> I think we cannot take inode_lock before claim_swapfile() because we can
>> have circular locking dependency as:
>>
>> claim_swapfile()
>> -> blkdev_get()    -> __blkdev_get()
>>       -> mutex_lock(&bdev->bd_mutex)
>>       -> bd_set_size()
>>          -> inode_lock(&bdev->bd_inode);
>
>Ah, good point. Thank you for doing the research on that. :)
>
>> So, one thing we can do is to move inode_lock() and "if (IS_SWAPFILE(..))
>> ..." out of claim_swapfile(). In this case, the "bad_swap" section must
>> check if "inode_is_locked" to call "inode_unlock".
>
>I think I wouldn't rely on inode_is_locked and structure the error
>escape as follows:
>
>	err = claim_swapfile()
>	if (err)
>		goto bad_swap;
>
>	inode_lock()
>	if (IS_SWAPFILE)
>		goto unlock_swap;
>
>	other_stuff()
>
>unlock_swap:
>	inode_unlock()
>bad_swap:
>	fput()
>
>since that's how we (well, XFS anyway :)) tend to do it.

That's possible, but current error handling (the "bad_swap" section) is not
well organized, so we may hit some other lock issue or race problem ... OK,
I'll investigate and try to reorder the error handling code to be cleaner.

Thanks,

>
>--D
>
>> >
>> > --D
>> >
>> > >  	error = claim_swapfile(p, inode);
>> > > -	if (unlikely(error))
>> > > +	if (unlikely(error)) {
>> > > +		inode = NULL;
>> > >  		goto bad_swap;
>> > > +	}
>> > >
>> > >  	/*
>> > >  	 * Read the swap header.
>> > > --
>> > > 2.25.0
>> > >
