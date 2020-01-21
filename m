Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735E914374A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 07:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgAUGyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 01:54:54 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:12969 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUGyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 01:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579589707; x=1611125707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VM8n4B2KCLj6FrbDK+vHfO1Tub9REhBofVMbH2CRB+0=;
  b=b1xIIaLzrU4GQbyiIm+fYX1sFp1KnSSm6xmbM5uNaUw9uhILf1vLtjTj
   i2Pia1o2ZXRETp7SAMdcKWxqf0QQ0RCVK2nG0opCuv9Yx2Rcji9gg708j
   HgdZLxy4fruVpbWvtIsbpJpcDDhtmjsFE2b2tawkQmqee/dU9mmlcJOl9
   pG7SUB988B9Maq/kZ1lgyGXw1j6kw7/FL93iFF/SPkcTqx4YzYTv24MRa
   G6O/O8j8DV8Ti5hJCdT/++j96ZgMmU4sK4oo7FLf0p9BQrFQd8wlMIxky
   +oTgNxNNzZ+iN/yBm+/m4oA65wrmDh6wVe24EVFWnTcuVCiykRll45rWj
   g==;
IronPort-SDR: ZXYhSnB9dDZik8K3owrTlyyI467VIEUaD85LmK2lBtmX09gV5Cj5gq34RIn5k7G94oJPvsUMl0
 VozmyAmQZHsBJvfj6O9USk/m6HI7aNAfcIhzu/6yB459dTo6z6eyrGfRLyue57qpO7aKO5ZV/P
 68+IWJUXcSchGrgJLs22WN2JzlfiMIfuRCAd3UnoZyAdslGkGl2uDBNGxz2Ctx8k9b/bWgon+Y
 cVL5S4vSviR3dBMnojsnkanj4SWNKEUGHwLVHoPg50YAciRJyBzY/FxOwgCSLJfDBVyIq30wuT
 lA8=
X-IronPort-AV: E=Sophos;i="5.70,345,1574092800"; 
   d="c'?scan'208";a="229728723"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2020 14:55:07 +0800
IronPort-SDR: Xy++j/ZCDLs6ierBMCHyIJaJ1+h0VmYQ9JFHQqhsgBIP6LUw74DWL82YVbvZWWlqye3h4lU6Cu
 wG+odGGvK+rV43JH0dSIA5VsuPkc1heXmnxVciqbgYcCGPwDlYNy7FG5gX5RZIiwRS30BavPJQ
 Qmi3UvuVUs9Q1oJmMGPxRZ8U9GZcvN9dK2K0Uf2RiMJH6EyxsVarYAUMMDXvd7YK74anveJfyg
 ikAwYxkvEn89NlljAtrbu9wDahWRgqrkDiP+ugln2ckC6t3APA5HdoyK1iVRRW7X/LJVRq075s
 vuirFzu7uEgi0ZFk1QrkK/s5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 22:48:20 -0800
IronPort-SDR: /KT0thwvyBJfyEwWaaYX6QE0txm+YvmLmmpRQR+sGysMIPT4Gv9g6pon0By6qNRA6drSVLbGIn
 vwBCV8gjZugyGklNSqNUfyqR/ls5wa+7foltGNrFvrm8rUMqsaTW27XgmfrYMTYc9r1njQJpfR
 LmrD9qQNfqTGEaR0d21kavkBPCPRoI5XPvxHqvyyqE7Nh+OlKS1fpNYrMe5FDK2+kBmfJD6iqS
 HUUGyuZbrVuaZjgg51afMpEt6SyLLsQKU9/wQ6X1WOin1ExzAtbvhztHKRNyxYLzif5NMV2pAd
 hYU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 20 Jan 2020 22:54:51 -0800
Received: (nullmailer pid 4099874 invoked by uid 1000);
        Tue, 21 Jan 2020 06:54:51 -0000
Date:   Tue, 21 Jan 2020 15:54:51 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v6 15/28] btrfs: serialize data allocation and submit IOs
Message-ID: <20200121065451.ygfj3kapm7ls4olm@naota.dhcp.fujisawa.hgst.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-16-naohiro.aota@wdc.com>
 <b11ca55e-adb6-6aa7-4494-cffafedb487f@toxicpanda.com>
 <20191219065457.rhd4wcycylii33c3@naota.dhcp.fujisawa.hgst.com>
 <ce94fc27-0167-087e-28f1-17e885ff5ddb@toxicpanda.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="b32ppy2a4cplfziv"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce94fc27-0167-087e-28f1-17e885ff5ddb@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--b32ppy2a4cplfziv
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 19, 2019 at 09:01:35AM -0500, Josef Bacik wrote:
>On 12/19/19 1:54 AM, Naohiro Aota wrote:
>>On Tue, Dec 17, 2019 at 02:49:44PM -0500, Josef Bacik wrote:
>>>On 12/12/19 11:09 PM, Naohiro Aota wrote:
>>>>To preserve sequential write pattern on the drives, we must serialize
>>>>allocation and submit_bio. This commit add per-block group mutex
>>>>"zone_io_lock" and find_free_extent_zoned() hold the lock. The lock is kept
>>>>even after returning from find_free_extent(). It is released when submiting
>>>>IOs corresponding to the allocation is completed.
>>>>
>>>>Implementing such behavior under __extent_writepage_io() is almost
>>>>impossible because once pages are unlocked we are not sure when submiting
>>>>IOs for an allocated region is finished or not. Instead, this commit add
>>>>run_delalloc_hmzoned() to write out non-compressed data IOs at once using
>>>>extent_write_locked_rage(). After the write, we can call
>>>>btrfs_hmzoned_data_io_unlock() to unlock the block group for new
>>>>allocation.
>>>>
>>>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>>
>>>Have you actually tested these patches with lock debugging on?  
>>>The submit_compressed_extents stuff is async, so the unlocker 
>>>owner will not be the lock owner, and that'll make all sorts of 
>>>things blow up. This is just straight up broken.
>>
>>Yes, I have ran xfstests on this patch series with lockdeps and
>>KASAN. There was no problem with that.
>>
>>For non-compressed writes, both allocation and submit is done in
>>run_delalloc_zoned(). Allocation is done in cow_file_range() and
>>submit is done in extent_write_locked_range(), so both are in the same
>>context, so both locking and unlocking are done by the same execution
>>context.
>>
>>For compressed writes, again, allocation/lock is done under
>>cow_file_range() and submit is done in extent_write_locked_range() and
>>unlocked all in submit_compressed_extents() (this is called after
>>compression), so they are all in the same context and the lock owner
>>does the unlock.
>>
>>>I would really rather see a hmzoned block scheduler that just 
>>>doesn't submit the bio's until they are aligned with the WP, that 
>>>way this intellligence doesn't have to be dealt with at the file 
>>>system layer. I get allocating in line with the WP, but this whole 
>>>forcing us to allocate and submit the bio in lock step is just 
>>>nuts, and broken in your subsequent patches.  This whole approach 
>>>needs to be reworked. Thanks,
>>>
>>>Josef
>>
>>We tried this approach by modifying mq-deadline to wait if the first
>>queued request is not aligned at the write pointer of a zone. However,
>>running btrfs without the allocate+submit lock with this modified IO
>>scheduler did not work well at all. With write intensive workloads, we
>>observed that a very long wait time was very often necessary to get a
>>fully sequential stream of requests starting at the write pointer of a
>>zone. The wait time we observed was sometimes in larger than 60 seconds,
>>at which point we gave up.
>
>This is because we will only write out the pages we've been handed but 
>do cow_file_range() for a possibly larger delalloc range, so as you 
>say there can be a large gap in time between writing one part of the 
>range and writing the next part.
>
>You actually solve this with your patch, by doing the cow_file_range 
>and then following it up with the extent_write_locked_range() for the 
>range you just cow'ed.
>
>There is no need for the locking in this case, you could simply do 
>that and then have a modified block scheduler that keeps the bio's in 
>the correct order.  I imagine if you just did this with your original 
>block layer approach it would work fine.  Thanks,
>
>Josef

We have once again tried the btrfs SMR (Zoned Block Device) support
series without the locking around extent allocation and bio issuing,
with a modified version of mq-deadline as the scheduler for the block
layer. As you already know, mq-deadline will order read and write
requests separately in increasing sector order, which is essential for
SMR sequential writing. However, mq-deadline does not provide
guarantees regarding the completeness of a sequential write stream. If
there are missing requests ("holes" in the write stream), mq-deadline
will still dispatch the next write request in order, leading to write
errors on SMR drives.

The modifications we added to mq-deadline is the addition of a wait
time when a hole in a sequential write stream is discovered. This is
reminiscent of the old anticipatory scheduler, somewhat. The wait time
is limited, so if a hole is not filled up by newly inserted requests
after a timeout elapses, write requests are issued as is (and errors
happen on SMR). The default timeout we used initially was set to the
value of "/sys/block/<dev>/queue/iosched/write_expire" which is 5
seconds.

With this, tests show that unaligned write errors happen with a simple
workload of 48 threads simultaneously doing write() to their dedicated
file and fdatasync() (Code of the application doing this is attached
to this email).

Despite the wait time of 5 seconds, the holes in a zone sequential
write stream are not filled up by issued BIOs because of a "buffer
bloat." First, bio whose LBA is not aligned with the write pointer
reaches the IO scheduler (call it bio#1). For proceeding with bio#1,
the IO scheduler must wait for a hole filling bio aligned with the
write pointer (call it bio#0).  If the size of bio#1 is large, the
scheduler needs to split the bio#1 into many numbers of requests. Each
request must first obtain a scheduler tag to be inserted into the
scheduler queue. Since the number of the scheduler tag is limited and
tags are freed only with the completion of queued and inflight
requests, requests in bio#1 can fully use all the tags. This is not a
problem if forward progress is made (i.e., requests dispatched to the
disk), but if all requests in the scheduler using tags are bio#1 and
subsequent writes in sequence, these are all waiting for bio#0 to be
issued. We thus end up with a soft deadlock for request issuing and no
possibility of progress. That results in the timeout to trigger, no
matter how large we set it, and in unaligned write errors. Large bios
needing lots of requests for processing will trigger this problem all
the time.

In addition to unaligned write error, we also observed hung_task
timeout with a larger timeout. The reason is the same as above:
writing threads get stuck with blk_mq_get_tag() to acquire its
scheduler tag. We more often hit hung_task than unaligned write by
increasing the timeout seconds.

Jan 07 11:17:11 naota-devel kernel: INFO: task multi-proc-writ:2202 blocked for more than 122 seconds.
Jan 07 11:17:11 naota-devel kernel:       Not tainted 5.4.0-rc8-BTRFS-ZNS+ #165
Jan 07 11:17:11 naota-devel kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan 07 11:17:11 naota-devel kernel: multi-proc-writ D    0  2202   2168 0x00004000
Jan 07 11:17:11 naota-devel kernel: Call Trace:
Jan 07 11:17:11 naota-devel kernel:  __schedule+0x8ab/0x1db0
Jan 07 11:17:11 naota-devel kernel:  ? pci_mmcfg_check_reserved+0x130/0x130
Jan 07 11:17:11 naota-devel kernel:  ? blk_insert_cloned_request+0x3e0/0x3e0
Jan 07 11:17:11 naota-devel kernel:  schedule+0xdb/0x260
Jan 07 11:17:11 naota-devel kernel:  io_schedule+0x21/0x70
Jan 07 11:17:11 naota-devel kernel:  blk_mq_get_tag+0x3b6/0x940
Jan 07 11:17:11 naota-devel kernel:  ? __blk_mq_tag_idle+0x80/0x80
Jan 07 11:17:11 naota-devel kernel:  ? finish_wait+0x270/0x270
Jan 07 11:17:11 naota-devel kernel:  blk_mq_get_request+0x340/0x1750
Jan 07 11:17:11 naota-devel kernel:  blk_mq_make_request+0x339/0x1bd0
Jan 07 11:17:11 naota-devel kernel:  ? blk_queue_enter+0x8a4/0xa30
Jan 07 11:17:11 naota-devel kernel:  ? blk_mq_try_issue_directly+0x150/0x150
Jan 07 11:17:11 naota-devel kernel:  generic_make_request+0x20c/0xa70
Jan 07 11:17:11 naota-devel kernel:  ? blk_queue_enter+0xa30/0xa30
Jan 07 11:17:11 naota-devel kernel:  ? find_held_lock+0x35/0x130
Jan 07 11:17:11 naota-devel kernel:  ? __kasan_check_read+0x11/0x20
Jan 07 11:17:11 naota-devel kernel:  submit_bio+0xd5/0x3c0
Jan 07 11:17:11 naota-devel kernel:  ? submit_bio+0xd5/0x3c0
Jan 07 11:17:11 naota-devel kernel:  ? generic_make_request+0xa70/0xa70
Jan 07 11:17:11 naota-devel kernel:  btrfs_map_bio+0x5f5/0xfb0 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? btrfs_rmap_block+0x820/0x820 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? unlock_page+0x9f/0x110
Jan 07 11:17:11 naota-devel kernel:  ? __extent_writepage+0x5aa/0x800 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? lock_downgrade+0x770/0x770
Jan 07 11:17:11 naota-devel kernel:  btrfs_submit_bio_hook+0x336/0x600 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? btrfs_fiemap+0x50/0x50 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  submit_one_bio+0xba/0x130 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  extent_write_locked_range+0x2f9/0x3e0 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? extent_write_full_page+0x1f0/0x1f0 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? lock_downgrade+0x770/0x770
Jan 07 11:17:11 naota-devel kernel:  ? account_page_redirty+0x2bb/0x490
Jan 07 11:17:11 naota-devel kernel:  run_delalloc_zoned+0x108/0x2f0 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  btrfs_run_delalloc_range+0xc4b/0x1170 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? test_range_bit+0x360/0x360 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? find_get_pages_range_tag+0x6f8/0x9d0
Jan 07 11:17:11 naota-devel kernel:  ? sched_clock_cpu+0x1b/0x170
Jan 07 11:17:11 naota-devel kernel:  ? mark_lock+0xc0/0x1160
Jan 07 11:17:11 naota-devel kernel:  writepage_delalloc+0x11e/0x270 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? find_lock_delalloc_range+0x400/0x400 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? rcu_read_lock_sched_held+0xa1/0xd0
Jan 07 11:17:11 naota-devel kernel:  ? rcu_read_lock_bh_held+0xb0/0xb0
Jan 07 11:17:11 naota-devel kernel:  __extent_writepage+0x3a2/0x800 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? lock_downgrade+0x770/0x770
Jan 07 11:17:11 naota-devel kernel:  ? __do_readpage+0x13a0/0x13a0 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? clear_page_dirty_for_io+0x32a/0x6e0
Jan 07 11:17:11 naota-devel kernel:  ? __kasan_check_read+0x11/0x20
Jan 07 11:17:11 naota-devel kernel:  extent_write_cache_pages+0x61c/0xaf0 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? __extent_writepage+0x800/0x800 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? __kasan_check_read+0x11/0x20
Jan 07 11:17:11 naota-devel kernel:  ? mark_lock+0xc0/0x1160
Jan 07 11:17:11 naota-devel kernel:  ? sched_clock_cpu+0x1b/0x170
Jan 07 11:17:11 naota-devel kernel:  ? __kasan_check_read+0x11/0x20
Jan 07 11:17:11 naota-devel kernel:  extent_writepages+0xf8/0x1a0 [btrfs]
Jan 07 11:17:11 naota-devel kernel:  ? __kasan_check_read+0x11/0x20
Jan 07 11:17:11 naota-devel kernel:  ? extent_write_locked_range+0x3e0/0x3e0 [btrfs]
Jan 07 11:17:12 naota-devel kernel:  ? find_held_lock+0x35/0x130
Jan 07 11:17:12 naota-devel kernel:  ? __kasan_check_read+0x11/0x20
Jan 07 11:17:12 naota-devel kernel:  btrfs_writepages+0xe/0x10 [btrfs]
Jan 07 11:17:12 naota-devel kernel:  do_writepages+0xe0/0x270
Jan 07 11:17:12 naota-devel kernel:  ? lock_downgrade+0x770/0x770
Jan 07 11:17:12 naota-devel kernel:  ? page_writeback_cpu_online+0x20/0x20
Jan 07 11:17:12 naota-devel kernel:  ? __kasan_check_read+0x11/0x20
Jan 07 11:17:12 naota-devel kernel:  ? do_raw_spin_unlock+0x59/0x250
Jan 07 11:17:12 naota-devel kernel:  ? _raw_spin_unlock+0x28/0x40
Jan 07 11:17:12 naota-devel kernel:  ? wbc_attach_and_unlock_inode+0x432/0x840
Jan 07 11:17:12 naota-devel kernel:  __filemap_fdatawrite_range+0x264/0x340
Jan 07 11:17:12 naota-devel kernel:  ? tty_ldisc_deref+0x35/0x40
Jan 07 11:17:12 naota-devel kernel:  ? delete_from_page_cache_batch+0xab0/0xab0
Jan 07 11:17:12 naota-devel kernel:  filemap_fdatawrite_range+0x13/0x20
Jan 07 11:17:12 naota-devel kernel:  btrfs_fdatawrite_range+0x4d/0xf0 [btrfs]
Jan 07 11:17:12 naota-devel kernel:  btrfs_sync_file+0x235/0xb30 [btrfs]
Jan 07 11:17:12 naota-devel kernel:  ? rcu_read_lock_sched_held+0xd0/0xd0
Jan 07 11:17:12 naota-devel kernel:  ? btrfs_file_write_iter+0x1430/0x1430 [btrfs]
Jan 07 11:17:12 naota-devel kernel:  ? do_dup2+0x440/0x440
Jan 07 11:17:12 naota-devel kernel:  ? __x64_sys_futex+0x29b/0x3f0
Jan 07 11:17:12 naota-devel kernel:  ? ksys_write+0x1c3/0x220
Jan 07 11:17:12 naota-devel kernel:  ? btrfs_file_write_iter+0x1430/0x1430 [btrfs]
Jan 07 11:17:12 naota-devel kernel:  vfs_fsync_range+0xf6/0x220
Jan 07 11:17:12 naota-devel kernel:  ? __fget_light+0x184/0x1f0
Jan 07 11:17:12 naota-devel kernel:  do_fsync+0x3d/0x70
Jan 07 11:17:12 naota-devel kernel:  ? trace_hardirqs_on+0x28/0x190
Jan 07 11:17:12 naota-devel kernel:  __x64_sys_fdatasync+0x36/0x50
Jan 07 11:17:12 naota-devel kernel:  do_syscall_64+0xa4/0x4b0
Jan 07 11:17:12 naota-devel kernel:  entry_SYSCALL_64_after_hwframe+0x49/0xbe
Jan 07 11:17:12 naota-devel kernel: RIP: 0033:0x7f7ba395f9bf
Jan 07 11:17:12 naota-devel kernel: Code: Bad RIP value.
Jan 07 11:17:12 naota-devel kernel: RSP: 002b:00007f7ba385de80 EFLAGS: 00000293 ORIG_RAX: 000000000000004b
Jan 07 11:17:12 naota-devel kernel: RAX: ffffffffffffffda RBX: 0000000000100000 RCX: 00007f7ba395f9bf
Jan 07 11:17:12 naota-devel kernel: RDX: 0000000000000001 RSI: 0000000000000081 RDI: 0000000000000003
Jan 07 11:17:12 naota-devel kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000404198
Jan 07 11:17:12 naota-devel kernel: R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000100000
Jan 07 11:17:12 naota-devel kernel: R13: 0000000000000000 R14: 00007f7ba2f5d010 R15: 00000000008592a0

Considering the above cases, I do not think it is possible to
implement such a "waiting IO scheduler" that would allow removing the
mutex around block allocation and bio issuing. Such a method would
require an intermediate bio reordering layer either using a device
mapper, or as was implemented initially directly in btrfs (but that is
now a layering violation, so we do not want that).

Entirely relying on the block layer for achieving a perfect sequential
write request sequence is fragile. The current block layer interface
semantic for zoned block devices is: "If BIOs are issued sequentially,
they will be dispatched to the drive in the same order, sequentially."
That directly reflects the drive constraint, so this is compatible
with other regular block devices in the sense that no intelligence is
added for trying to create sequential streams of requests when the
issuer is not issuing the said request in perfect order. Trying to
change this interface to something like: "OK, I can accept some
out-of-ordered writes, but you must fill the hole quickly in the
stream" cannot be implemented directly in the block layer. Device
mapper should be used for that, but if we do so, then one could argue
that all SMR support can simply rely on dm-zoned, which is really
sub-optimal from a performance perspective. We can do much better than
dm-zoned with direct support in btrfs, but that support requires
guarantees of sequential write BIO issuing. The current implementation
relies on a mutex for that, which considering the complexity of
dm-zoned, is a *very* simple and clean solution.

--b32ppy2a4cplfziv
Content-Type: text/x-c; charset=us-ascii
Content-Disposition: attachment; filename="multi-proc-write.c"

#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <time.h>
#include <pthread.h>
#include <assert.h>
#include <stdbool.h>

#define NUM_BASE_THREAD 16
#define NUM_CPU 8

int NUM_THREAD;

pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
bool exit_run = false;
int num_running;
int num_waiting;
int cnt = 0;

struct thread_data {
	int fd;
	char name[16];
	size_t size;
	pthread_barrier_t *barrier;
	pthread_t id;
};

#define min_t(type, x, y) ({			\
	type __min1 = (x);			\
	type __min2 = (y);			\
	__min1 < __min2 ? __min1: __min2; })

static void* write_file(void *arg)
{
	struct thread_data *data = arg;
	char *buf;
	ssize_t written;
	size_t left;
	struct timespec ts;
	ssize_t bufsize = 1 << 20;

	buf = malloc(bufsize);
	if (!buf) {
		fprintf(stderr, "failed to alloc %lu size buffer: %s", bufsize, strerror(errno));
		return NULL;
	}
	memset(buf, 0, bufsize);

	pthread_barrier_wait(data->barrier);

	for (;;) {
		/* clock_gettime(CLOCK_MONOTONIC, &ts); */
		/* printf("%10ld.%09ld writing file %s\n", ts.tv_sec, ts.tv_nsec, data->name); */
		left = data->size;
		while (left) {
			ssize_t write_size = min_t(ssize_t, bufsize, left);

			written = write(data->fd, buf, write_size);
			if (written < 0) {
				clock_gettime(CLOCK_MONOTONIC, &ts);
				fprintf(stderr, "%10ld.%09ld failed to write file %s %s\n",
					ts.tv_sec, ts.tv_nsec, data->name, strerror(errno));
				goto out;
			}
			if (written < write_size) {
				clock_gettime(CLOCK_MONOTONIC, &ts);
				fprintf(stderr, "%10ld.%09ld failed to write file %s %ld < %ld\n",
					ts.tv_sec, ts.tv_nsec, data->name, written, data->size);
				goto out;
			}
			left -= write_size;
		}

		pthread_mutex_lock(&lock);
		if (num_running < NUM_THREAD) {
			pthread_mutex_unlock(&lock);
			goto out;
		}
		num_waiting++;
		assert(num_waiting <= num_running);
		if (num_waiting == num_running) {
			pthread_cond_broadcast(&cond);
			num_waiting--;
			printf(".");
			fflush(stdout);
			cnt++;
			if (cnt == 80) {
				printf("\n");
				cnt = 0;
			}
		} else {
			pthread_cond_wait(&cond, &lock);
			num_waiting--;
		}
		pthread_mutex_unlock(&lock);

		/* clock_gettime(CLOCK_MONOTONIC, &ts); */
		/* printf("%10ld.%09ld fdatasync file %s\n", ts.tv_sec, ts.tv_nsec, data->name); */
		if (fdatasync(data->fd)) {
			fprintf(stderr, "failed to fdatasync file %s: %s\n", data->name, strerror(errno));
			goto out;
		}
		/* clock_gettime(CLOCK_MONOTONIC, &ts); */
		/* printf("%10ld.%09ld fdatasync done file %s\n", ts.tv_sec, ts.tv_nsec, data->name); */
	}

out:
	free(buf);

	pthread_mutex_lock(&lock);
	num_running--;
	assert(num_waiting <= num_running);
	if (num_waiting == num_running)
		pthread_cond_broadcast(&cond);
	pthread_mutex_unlock(&lock);

	return NULL;
}

int main(int argc, char *argv[])
{
	if (argc < 2)
		return 1;
	NUM_THREAD = atoi(argv[1]);

	pthread_barrier_t barrier;
	if (pthread_barrier_init(&barrier, NULL, NUM_THREAD)) {
		perror("failed to initialize barrier");
		exit(1);
	}

	num_running = NUM_THREAD;
	num_waiting = 0;

	struct thread_data *tds;

	tds = calloc(NUM_THREAD, sizeof(*tds));
	if (!tds) {
		perror("failed to allocate thread data");
		exit(1);
	}

	cpu_set_t cpuset;

	for (int i = 0; i < NUM_THREAD; i++) {
		sprintf(tds[i].name, "%03d", i);
		tds[i].fd = open(tds[i].name, O_RDWR | O_CREAT, 0644);
		if (tds[i].fd < 0) {
			perror("failed to open file");
			exit(1);
		}
		int shift = 20 - 1 - (i % NUM_BASE_THREAD);
		assert(shift >= 4);
		tds[i].size = 256 << shift;
		tds[i].barrier = &barrier;
		CPU_ZERO(&cpuset);
		CPU_SET(i % NUM_CPU, &cpuset);
		pthread_create(&tds[i].id, NULL, write_file, &tds[i]);
		pthread_setaffinity_np(tds[i].id, sizeof(cpu_set_t), &cpuset);
	}

	for (int i = 0; i < NUM_THREAD; i++) {
		pthread_join(tds[i].id, NULL);
		close(tds[i].fd);
	}

	pthread_barrier_destroy(&barrier);
}


--b32ppy2a4cplfziv--
