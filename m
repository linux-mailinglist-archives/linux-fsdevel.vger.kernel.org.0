Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C312156E71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 05:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgBJEZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Feb 2020 23:25:16 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8840 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgBJEZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Feb 2020 23:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581308716; x=1612844716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xCqR/3TqqcEaElnFbr8xy71PvTuhQoezMiXwBlsjsdk=;
  b=DR+X4qfCmphl0GLKLTQHk1m2p773Io2GOE4tc2OpG3ey4pk1xt0IFqC4
   BoOeGKBzPGhNNcNQ4ljZ5U70r/A7dbnVCua0sGgZrCwg6M9seVhp2shAk
   e+DiiEvioBly7NyvPGs2Xth0ia0BwXDZxUJ9rkVnp98URJPWzbz5ZXbau
   whhIPq0MQvYDpUhg0U6/6njzmr6m0fP/Xc310NNzTYp3rsboGq+gKuxZF
   wesaTZ/wBcvtTpywj6Mi29MhZHcE225mAU547iOwTduwUTHIdwoN5qI5o
   S0Oy1f5hKx+w/8djvY5DHe01X68iuq+xzk83seekcAIG9aS/VP74BNlvL
   w==;
IronPort-SDR: ZfFPazZoHeQi0Y/HZAvSJVA3BFcg5TKXbwJY591vySpr4JkIJm6WhJQ1jHvRDGulyDMt10hKhy
 RmiyXDFSF9/JXLlbxsMxEkV8cwsnN27v78BcCjHzoiFWhEdyqiL1YS/E+WctkP9ou7Vtpvcysq
 Ivnuu9FSJlITPujt58a5bpqNsAoMdEDC93/SEiMPjWz/wsd9PQVnH7fokVUQlLyg5JIblBZhJ1
 1Jo3NYJulIasPj4T++pB+TKAF4V929IAMefWxKjMM4X1Ai6ye0ySZyLLsfWX+wTq9kll4byRWA
 toU=
X-IronPort-AV: E=Sophos;i="5.70,423,1574092800"; 
   d="scan'208";a="133824001"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2020 12:25:16 +0800
IronPort-SDR: GNFdp0nLFMyadicH5eXca7CzXEUXizAbAdZC9P1GKuMCmhLGkH9PYTxitNHV3eB0EivIU2MhBW
 YClWH4PvqjRjo4fU2tgSoLfKl8HFtCxatIPN45ebGbgwQhLiWmPUVPCrfxNngLUVIP1r+E2hXS
 VajYj36WnSL3GQw+eYbeD8aidBzW3vlssdX5Drkf4/Q9DF+cl776YF4mnXRmX4uRUtNlCf+lIv
 YGw/uKEuXELII4RbmzBwzFSjQsI5TOKneds/yS0e+DUL1MTqIHDhw2iRUaKqwutBjSiZAOrmhm
 coW9D5S9MK/inBDo/VWFiL/t
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 20:18:08 -0800
IronPort-SDR: l3Fa99Y5i8cW2YP21x0i6xbpTm6ZSnTYUZUMQC6VnbMeDU8f8rQtf0ZF5Udzvv0DxrmlIRxL/z
 mHn8dCywQlDLPmsAqxr48adS3BePeaMRgvltxOdEh7glhYhc/Ch2Hfv3hFRCpD6fbMGChH5bB8
 hqKv22x4ykcTf9LHwaAYCD5NNgyU5DGcbjbDm02ig0se3fiHEjlyGUqRlLCd2zJEXBjm+yf0sQ
 npx3d8AKzSzgpa1T3meErCNiHjSAgPNlAt1EFefSzKgiq9KZXvWKPmhnDAM091yWuH6c142uDB
 lrs=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 09 Feb 2020 20:25:14 -0800
Received: (nullmailer pid 2754475 invoked by uid 1000);
        Mon, 10 Feb 2020 04:25:14 -0000
Date:   Mon, 10 Feb 2020 13:25:14 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] mm, swap: move inode_lock out of claim_swapfile
Message-ID: <20200210042514.h3hhuqs2v3qketjy@naota.dhcp.fujisawa.hgst.com>
References: <20200206090132.154869-1-naohiro.aota@wdc.com>
 <20200209201612.e5f234b357823df574104cb9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200209201612.e5f234b357823df574104cb9@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 09, 2020 at 08:16:12PM -0800, Andrew Morton wrote:
>On Thu,  6 Feb 2020 18:01:32 +0900 Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
>> claim_swapfile() currently keeps the inode locked when it is successful, or
>> the file is already swapfile (with -EBUSY). And, on the other error cases,
>> it does not lock the inode.
>>
>> This inconsistency of the lock state and return value is quite confusing
>> and actually causing a bad unlock balance as below in the "bad_swap"
>> section of __do_sys_swapon().
>>
>> This commit fixes this issue by moving the inode_lock() and IS_SWAPFILE
>> check out of claim_swapfile(). The inode is unlocked in
>> "bad_swap_unlock_inode" section, so that the inode is ensured to be
>> unlocked at "bad_swap". Thus, error handling codes after the locking now
>> jumps to "bad_swap_unlock_inode" instead of "bad_swap".
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
>>  mm/swapfile.c | 41 ++++++++++++++++++++---------------------
>>  1 file changed, 20 insertions(+), 21 deletions(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index bb3261d45b6a..2c4c349e1101 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>
>Look correct to me.
>
>But I don't think this code at the end of sys_swapon():
>
>	if (inode)
>		inode_unlock(inode);
>
>will ever execute?  `inode' is always NULL here?

On the successful case, inode is not NULL and unlocked here.

>
