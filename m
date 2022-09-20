Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE25BE5AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 14:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiITMZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 08:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiITMZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:25:19 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232BF1145D;
        Tue, 20 Sep 2022 05:25:18 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oacJP-0002zc-Ez; Tue, 20 Sep 2022 14:25:15 +0200
Message-ID: <a0d08409-6f68-c991-5b56-1af087a03a07@leemhuis.info>
Date:   Tue, 20 Sep 2022 14:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US, de-DE
To:     regressions@lists.linux.dev
Cc:     lkp@lists.01.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
References: <20220831021311.GA5507@inn2.lkp.intel.com>
 <bc0089a3-1e80-f46c-7ec6-577019e34d11@intel.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [pipe] 8cefc107ca:
 BUG:KASAN:slab-out-of-bounds_in_iov_iter_alignment #forregzbot
In-Reply-To: <bc0089a3-1e80-f46c-7ec6-577019e34d11@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663676718;065ae07f;
X-HE-SMSGID: 1oacJP-0002zc-Ez
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

As per recent general discussions with the 0-day folks, I'm dropping
below regression report from the list of tracked issues, as this report
didn't gain any traction. That for example can happen if the developers
considered the regression of no practical relevance, as they assume it
only materializes in micro-benchmarks, is due to a broken test case, or
some fluke – and then they often not even reply.

Not sure if that or something else is the reason why this particular
report didn't gain any traction, but I lack the bandwidth to follow-up
on each and every performace regression 0-day bot found and reported. At
the same time I don't want to keep these reports in the list of tracked
issues forever, as that creates noise and makes it harder to spot the
important issues in regzbot's reports and lists. That's why I hereby
remove it:

#regzbot invalid: report from 0-day that didn't get traction; likely of
no relevance, not totally sure

Ciao, Thorsten

On 31.08.22 05:27, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 8cefc107ca54c8b06438b7dc9cc08bc0a11d5b98 ("pipe: Use head and
> tail pointers for the ring, not cursor and length")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: xfstests
> version: xfstests-x86_64-c1144bf-1_20220808
> with following parameters:
> 
>     disk: 6HDD
>     fs: btrfs
>     test: btrfs-group-21
> 
> test-description: xfstests is a regression test suite for xfs and other
> files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @
> 3.40GHz (Haswell) with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):
> 
> 
> [   94.464594][ T8860] BTRFS: device fsid
> 69c7bcba-33c9-484e-9d7e-7441a9dda3c6 devid 1 transid 5 /dev/loop0
> [   94.484786][T10999] BTRFS info (device loop0): disk space caching is
> enabled
> [   94.492786][T10999] BTRFS info (device loop0): has skinny extents
> [   94.499803][T10999] BTRFS info (device loop0): flagging fs with big
> metadata feature
> [   94.513599][T10999] BTRFS info (device loop0): enabling ssd
> optimizations
> [   94.521806][T10999] BTRFS info (device loop0): checking UUID tree
> [   94.707069][ T9438] BTRFS: device fsid
> 69c7bcba-33c9-484e-9d7e-7441a9dda3c6 devid 1 transid 7 /dev/loop0
> [   94.750396][T11032]
> ==================================================================
> [   94.759245][T11032] BUG: KASAN: slab-out-of-bounds in
> iov_iter_alignment+0x493/0x600
> [   94.767978][T11032] Read of size 4 at addr ffff8882171847c0 by task
> loop0/11032
> [   94.776222][T11032]
> [   94.779325][T11032] CPU: 2 PID: 11032 Comm: loop0 Not tainted
> 5.4.0-rc2-00004-g8cefc107ca54c #1
> [   94.788997][T11032] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN,
> BIOS A05 12/05/2013
> [   94.797908][T11032] Call Trace:
> [   94.802003][T11032]  dump_stack+0x5b/0xa0
> [   94.806977][T11032]  print_address_description+0x1f/0x280
> [   94.814376][T11032]  __kasan_report.cold+0x7a/0xd4
> [   94.820115][T11032]  ? generic_file_buffered_read+0xdc0/0x1ac0
> [   94.826908][T11032]  ? iov_iter_alignment+0x493/0x600
> [   94.832893][T11032]  kasan_report+0xe/0x12
> [   94.837903][T11032]  iov_iter_alignment+0x493/0x600
> [   94.843756][T11032]  ? current_time+0x72/0x240
> [   94.849117][T11032]  btrfs_direct_IO+0x1df/0xa40 [btrfs]
> [   94.855360][T11032]  ? atime_needs_update+0x1d0/0x540
> [   94.861285][T11032]  ? may_destroy_subvol+0x580/0x580 [btrfs]
> [   94.867889][T11032]  ? touch_atime+0xcb/0x280
> [   94.873096][T11032]  ? filemap_check_errors+0x50/0x100
> [   94.879106][T11032]  generic_file_read_iter+0x1e8/0x480
> [   94.885189][T11032]  lo_rw_aio+0x9e2/0xe80 [loop]
> [   94.890755][T11032]  ? __switch_to_asm+0x40/0x70
> [   94.896227][T11032]  ? __switch_to_asm+0x34/0x70
> [   94.901722][T11032]  ? __switch_to_asm+0x40/0x70
> [   94.907179][T11032]  ? lo_read_simple+0x640/0x640 [loop]
> [   94.913307][T11032]  ? __switch_to_asm+0x40/0x70
> [   94.918775][T11032]  ? __switch_to_asm+0x34/0x70
> [   94.924237][T11032]  ? __switch_to_asm+0x40/0x70
> [   94.929681][T11032]  ? __switch_to_asm+0x40/0x70
> [   94.935123][T11032]  ? __switch_to_asm+0x34/0x70
> [   94.940538][T11032]  ? __switch_to_asm+0x40/0x70
> [   94.945943][T11032]  ? __switch_to_asm+0x34/0x70
> [   94.951303][T11032]  ? __switch_to_asm+0x40/0x70
> [   94.956692][T11032]  ? __switch_to_asm+0x34/0x70
> [   94.962079][T11032]  ? __switch_to_asm+0x40/0x70
> [   94.967432][T11032]  ? __switch_to_asm+0x34/0x70
> [   94.972796][T11032]  ? kthread_worker_fn+0x212/0x700
> [   94.978434][T11032]  do_req_filebacked+0x6d6/0x940 [loop]
> [   94.984557][T11032]  ? __switch_to_asm+0x34/0x70
> [   94.989908][T11032]  ? __schedule+0x5de/0x1180
> [   94.995042][T11032]  ? lo_read_transfer+0x740/0x740 [loop]
> [   95.001159][T11032]  ? io_schedule_timeout+0x180/0x180
> [   95.006991][T11032]  ? _raw_spin_lock_irq+0x82/0xd2
> [   95.012577][T11032]  ? kthread_worker_fn+0x212/0x700
> [   95.018174][T11032]  loop_queue_work+0xd0/0x200 [loop]
> [   95.024000][T11032]  kthread_worker_fn+0x195/0x700
> [   95.029411][T11032]  ? __wake_up_common+0x110/0x600
> [   95.034946][T11032]  ? kthread_destroy_worker+0xc0/0xc0
> [   95.040797][T11032]  ? __kthread_parkme+0xbd/0x1c0
> [   95.046169][T11032]  ? loop_info64_to_compat+0x6c0/0x6c0 [loop]
> [   95.052699][T11032]  kthread+0x337/0x440
> [   95.057216][T11032]  ? __kthread_bind_mask+0xc0/0xc0
> [   95.062765][T11032]  ret_from_fork+0x35/0x40
> [   95.067602][T11032]
> [   95.070314][T11032] Allocated by task 9438:
> [   95.075030][T11032]  save_stack+0x1b/0x80
> [   95.079589][T11032]  __kasan_kmalloc+0xc2/0x100
> [   95.085713][T11032]  kmem_cache_alloc+0xb8/0x240
> [   95.090888][T11032]  mempool_alloc+0x103/0x300
> [   95.095912][T11032]  bio_alloc_bioset+0x198/0x4c0
> [   95.101168][T11032]  mpage_alloc+0x30/0x240
> [   95.105893][T11032]  do_mpage_readpage+0x1081/0x1d40
> [   95.111397][T11032]  mpage_readpages+0x23f/0x500
> [   95.116560][T11032]  read_pages+0x102/0x500
> [   95.121892][T11032]  __do_page_cache_readahead+0x316/0x3c0
> [   95.127928][T11032]  force_page_cache_readahead+0x19a/0x300
> [   95.134015][T11032]  generic_file_buffered_read+0x7e6/0x1ac0
> [   95.140188][T11032]  new_sync_read+0x3f1/0x700
> [   95.145180][T11032]  vfs_read+0x14e/0x340
> [   95.149733][T11032]  ksys_read+0xed/0x1c0
> [   95.154260][T11032]  do_syscall_64+0x9a/0x1c0
> [   95.159137][T11032]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   95.165412][T11032]
> [   95.168118][T11032] Freed by task 0:
> [   95.172227][T11032]  save_stack+0x1b/0x80
> [   95.176815][T11032]  __kasan_slab_free+0x12e/0x180
> [   95.182158][T11032]  kmem_cache_free+0x8a/0x300
> [   95.187288][T11032]  blk_update_request+0x2c2/0x1000
> [   95.192862][T11032]  scsi_end_request+0x70/0x480
> [   95.198075][T11032]  scsi_io_completion+0x175/0x3c0
> [   95.203573][T11032]  blk_done_softirq+0x218/0x340
> [   95.208932][T11032]  __do_softirq+0x1ac/0x6ff
> [   95.213925][T11032]
> [   95.216756][T11032] The buggy address belongs to the object at
> ffff888217184700
> [   95.216756][T11032]  which belongs to the cache bio-0 of size 192
> [   95.231456][T11032] The buggy address is located 0 bytes to the right of
> [   95.231456][T11032]  192-byte region [ffff888217184700,
> ffff8882171847c0)
> [   95.246252][T11032] The buggy address belongs to the page:
> [   95.252390][T11032] page:ffffea00085c6100 refcount:1 mapcount:0
> mapping:ffff8881a778e000 index:0x0 compound_mapcount: 0
> [   95.263922][T11032] flags: 0x17ffffc0010200(slab|head)
> [   95.269787][T11032] raw: 0017ffffc0010200 0000000000000000
> 0000000100000001 ffff8881a778e000
> [   95.278978][T11032] raw: 0000000000000000 0000000080200020
> 00000001ffffffff 0000000000000000
> [   95.288164][T11032] page dumped because: kasan: bad access detected
> [   95.295190][T11032]
> [   95.298132][T11032] Memory state around the buggy address:
> [   95.304350][T11032]  ffff888217184680: fb fb fb fb fb fb fb fb fc fc
> fc fc fc fc fc fc
> [   95.313069][T11032]  ffff888217184700: 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00
> [   95.321773][T11032] >ffff888217184780: 00 00 00 00 00 00 00 00 fc fc
> fc fc fc fc fc fc
> [   95.330449][T11032]                                            ^
> [   95.337238][T11032]  ffff888217184800: fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb
> [   95.345956][T11032]  ffff888217184880: fb fb fb fb fb fb fb fb fc fc
> fc fc fc fc fc fc
> [   95.354680][T11032]
> ==================================================================
> [   95.363378][T11032] Disabling lock debugging due to kernel taint
> [   95.376123][T11041] BTRFS info (device loop0): disk space caching is
> enabled
> [   95.384125][T11041] BTRFS info (device loop0): has skinny extents
> [   95.403358][T11041] BTRFS info (device loop0): enabling ssd
> optimizations
> [   95.551044][T11069] BTRFS info (device loop1): disk space caching is
> enabled
> [   95.558972][T11069] BTRFS info (device loop1): has skinny extents
> [   95.565934][T11069] BTRFS info (device loop1): flagging fs with big
> metadata feature
> [   95.579741][T11069] BTRFS info (device loop1): enabling ssd
> optimizations
> [   95.587894][T11069] BTRFS info (device loop1): checking UUID tree
> [   95.813369][T11103] BTRFS info (device loop0): disk space caching is
> enabled
> [   95.821286][T11103] BTRFS info (device loop0): has skinny extents
> [   95.834962][T11103] BTRFS info (device loop0): enabling ssd
> optimizations
> [   95.951085][T11132] BTRFS: device fsid
> 69c7bcba-33c9-484e-9d7e-7441a9dda3c6 devid 1 transid 9 /dev/loop0
> [   95.971297][T11132] BTRFS info (device loop0): disk space caching is
> enabled
> [   95.979241][T11132] BTRFS info (device loop0): has skinny extents
> [   95.992721][T11132] BTRFS info (device loop0): enabling ssd
> optimizations
> [   96.020891][ T9438] BTRFS warning (device loop0): duplicate device
> fsid:devid for 69c7bcba-33c9-484e-9d7e-7441a9dda3c6:1 old:/dev/loop0
> new:/dev/loop1
> [   96.036297][T11157] BTRFS warning (device loop0): duplicate device
> fsid:devid for 69c7bcba-33c9-484e-9d7e-7441a9dda3c6:1 old:/dev/loop0
> new:/dev/loop1
> [   96.176083][T11159] BTRFS: device fsid
> a03b6786-417c-4664-b28f-f1992a86ad7c devid 1 transid 7 /dev/sda2
> [   96.502141][T11186] BTRFS info (device sdb1): disk space caching is
> enabled
> [   96.510169][T11186] BTRFS info (device sdb1): has skinny extents
> [   96.550613][  T422] btrfs/219       _check_dmesg: something found in
> dmesg (see /lkp/benchmarks/xfstests/results//btrfs/219.dmesg)
> 
> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/disk/fs/test:
>  
> lkp-hsw-d01/xfstests/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/6HDD/btrfs/btrfs-group-21
> 
> commit:
>   f94df9890e98f2 ("Add wake_up_interruptible_sync_poll_locked()")
>   8cefc107ca54c8 ("pipe: Use head and tail pointers for the ring, not
> cursor and length")
> 
> f94df9890e98f209 8cefc107ca54c8b06438b7dc9cc
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :12         100%          12:12    xfstests.btrfs.219.fail
>            :12          92%          11:12   
> dmesg.BUG:KASAN:slab-out-of-bounds_in_iov_iter_alignment
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <yujie.liu@intel.com>
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached
> in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file
> for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> #regzbot introduced: 8cefc107ca
> 
