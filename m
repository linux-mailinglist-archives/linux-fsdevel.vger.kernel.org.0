Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7845B707876
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 05:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjERDaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 23:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjERDaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 23:30:10 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD1A19B2;
        Wed, 17 May 2023 20:30:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QMFpg3j7Rz4f3kkR;
        Thu, 18 May 2023 11:30:03 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbG2m2VkMMu0Jg--.58916S3;
        Thu, 18 May 2023 11:30:00 +0800 (CST)
Subject: Re: INFO: task hung in blkdev_open bug
To:     yang lan <lanyang0908@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com, brauner@kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAAehj2=HQDk-AMYpVR7i91hbQC4G5ULKd9iYoP05u_9tay8VMw@mail.gmail.com>
 <ZGTGiNItObrI2Z34@casper.infradead.org>
 <CAAehj2k2Sjt-kMwdJTP2uDJTtDzF_hzzHQJ=YVg3FN4bZYo2tQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c3391bd5-9e4a-226c-9f21-4474a0929cd4@huaweicloud.com>
Date:   Thu, 18 May 2023 11:29:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAehj2k2Sjt-kMwdJTP2uDJTtDzF_hzzHQJ=YVg3FN4bZYo2tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbG2m2VkMMu0Jg--.58916S3
X-Coremail-Antispam: 1UD129KBjvAXoW3Kw17Jr4furyxXw1rKw48JFb_yoW8GryDGo
        WrJas3uay8G345Jr17Gw4jg3srAw1vy3Z7ZF1Ik347Z3W7Ww45t3WDWr1UG3y3JrW8GFnx
        C34ft3W0g347t3s7n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYs7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI
        62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

在 2023/05/18 0:27, yang lan 写道:
> Hi,
> 
> Thank you for your response.
> 
>> Does this reproduce on current kernels, eg 6.4-rc2?
> 
> Yeah, it can be reproduced on kernel 6.4-rc2.
> 

Below log shows that io hang, can you collect following debugfs so
that we can know where is the io now.

cd /sys/kernel/debug/block/[test_device] && find . -type f -exec grep 
-aH . {} \;

Thanks,
Kuai
> root@syzkaller:~# uname -a
> Linux syzkaller 6.4.0-rc2 #1 SMP PREEMPT_DYNAMIC Wed May 17 22:58:52
> CST 2023 x86_64 GNU/Linux
> root@syzkaller:~# gcc poc_blkdev.c -o poc_blkdev
> root@syzkaller:~# ./poc_blkdev
> [  128.718051][ T7121] nbd0: detected capacity change from 0 to 4
> [  158.917678][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 30 seconds
> [  188.997677][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 60 seconds
> [  219.077191][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 90 seconds
> [  249.157312][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 120 seconds
> [  279.237409][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 150 seconds
> [  309.317843][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 180 seconds
> [  339.397950][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 210 seconds
> [  369.478031][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 240 seconds
> [  399.558253][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 270 seconds
> [  429.638372][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 300 seconds
> [  459.718454][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 330 seconds
> [  489.798571][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 360 seconds
> [  519.878643][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 390 seconds
> [  549.958966][  T998] block nbd0: Possible stuck request
> ffff888016f08000: control (read@0,2048B). Runtime 420 seconds
> [  571.719145][   T30] INFO: task systemd-udevd:7123 blocked for more
> than 143 seconds.
> [  571.719652][   T30]       Not tainted 6.4.0-rc2 #1
> [  571.719900][   T30] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  571.720307][   T30] task:systemd-udevd   state:D stack:26224
> pid:7123  ppid:3998   flags:0x00004004
> [  571.720756][   T30] Call Trace:
> [  571.720923][   T30]  <TASK>
> [  571.721073][   T30]  __schedule+0x9ca/0x2630
> [  571.721348][   T30]  ? firmware_map_remove+0x1e0/0x1e0
> [  571.721618][   T30]  ? find_held_lock+0x33/0x1c0
> [  571.721866][   T30]  ? lock_release+0x3b9/0x690
> [  571.722108][   T30]  ? do_read_cache_folio+0x4ff/0xb20
> [  571.722447][   T30]  ? lock_downgrade+0x6b0/0x6b0
> [  571.722785][   T30]  ? mark_held_locks+0xb0/0x110
> [  571.723044][   T30]  schedule+0xd3/0x1b0
> [  571.723264][   T30]  io_schedule+0x1b/0x70
> [  571.723489][   T30]  ? do_read_cache_folio+0x58c/0xb20
> [  571.723760][   T30]  do_read_cache_folio+0x58c/0xb20
> [  571.724036][   T30]  ? blkdev_readahead+0x20/0x20
> [  571.724319][   T30]  ? __filemap_get_folio+0x8e0/0x8e0
> [  571.724588][   T30]  ? __sanitizer_cov_trace_switch+0x53/0x90
> [  571.724885][   T30]  ? __sanitizer_cov_trace_pc+0x1e/0x50
> [  571.725246][   T30]  ? format_decode+0x1cf/0xb50
> [  571.725547][   T30]  ? __sanitizer_cov_trace_pc+0x1e/0x50
> [  571.725837][   T30]  ? fill_ptr_key+0x30/0x30
> [  571.726072][   T30]  ? default_pointer+0x4a0/0x4a0
> [  571.726335][   T30]  ? __isolate_free_page+0x220/0x220
> [  571.726608][   T30]  ? filemap_fdatawrite_wbc+0x1c0/0x1c0
> [  571.726888][   T30]  ? __sanitizer_cov_trace_pc+0x1e/0x50
> [  571.727172][   T30]  ? read_part_sector+0x229/0x420
> [  571.727434][   T30]  ? adfspart_check_ADFS+0x560/0x560
> [  571.727707][   T30]  read_part_sector+0xfa/0x420
> [  571.727963][   T30]  adfspart_check_POWERTEC+0x90/0x690
> [  571.728244][   T30]  ? adfspart_check_ADFS+0x560/0x560
> [  571.728520][   T30]  ? __kasan_slab_alloc+0x33/0x70
> [  571.728780][   T30]  ? adfspart_check_ICS+0x8f0/0x8f0
> [  571.729889][   T30]  ? snprintf+0xb2/0xe0
> [  571.730145][   T30]  ? vsprintf+0x30/0x30
> [  571.730374][   T30]  ? __sanitizer_cov_trace_pc+0x1e/0x50
> [  571.730659][   T30]  ? adfspart_check_ICS+0x8f0/0x8f0
> [  571.730928][   T30]  bdev_disk_changed+0x674/0x1260
> [  571.731189][   T30]  ? write_comp_data+0x1f/0x70
> [  571.731439][   T30]  ? iput+0xd0/0x780
> [  571.731646][   T30]  blkdev_get_whole+0x186/0x260
> [  571.731886][   T30]  blkdev_get_by_dev+0x4ce/0xae0
> [  571.732139][   T30]  blkdev_open+0x140/0x2c0
> [  571.732366][   T30]  do_dentry_open+0x6de/0x1450
> [  571.732612][   T30]  ? blkdev_close+0x80/0x80
> [  571.732848][   T30]  path_openat+0xd6d/0x26d0
> [  571.733084][   T30]  ? lock_downgrade+0x6b0/0x6b0
> [  571.733336][   T30]  ? vfs_path_lookup+0x110/0x110
> [  571.733591][   T30]  do_filp_open+0x1bb/0x290
> [  571.733824][   T30]  ? may_open_dev+0xf0/0xf0
> [  571.734061][   T30]  ? __phys_addr_symbol+0x30/0x70
> [  571.734324][   T30]  ? do_raw_spin_unlock+0x176/0x260
> [  571.734595][   T30]  do_sys_openat2+0x5fd/0x980
> [  571.734837][   T30]  ? file_open_root+0x3f0/0x3f0
> [  571.735087][   T30]  ? seccomp_notify_ioctl+0xff0/0xff0
> [  571.735368][   T30]  do_sys_open+0xce/0x140
> [  571.735596][   T30]  ? filp_open+0x80/0x80
> [  571.735820][   T30]  ? __secure_computing+0x1e3/0x340
> [  571.736090][   T30]  do_syscall_64+0x38/0x80
> [  571.736325][   T30]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  571.736626][   T30] RIP: 0033:0x7fb212210840
> [  571.736857][   T30] RSP: 002b:00007fffb37bbbe8 EFLAGS: 00000246
> ORIG_RAX: 0000000000000002
> [  571.737269][   T30] RAX: ffffffffffffffda RBX: 0000560e09072e10
> RCX: 00007fb212210840
> [  571.737651][   T30] RDX: 0000560e08e39fe3 RSI: 00000000000a0800
> RDI: 0000560e090813b0
> [  571.738037][   T30] RBP: 00007fffb37bbd60 R08: 0000560e08e39670
> R09: 0000000000000010
> [  571.738432][   T30] R10: 0000560e08e39d0c R11: 0000000000000246
> R12: 00007fffb37bbcb0
> [  571.739563][   T30] R13: 0000560e09087a70 R14: 0000000000000003
> R15: 000000000000000e
> [  571.739973][   T30]  </TASK>
> [  571.740133][   T30]
> [  571.740133][   T30] Showing all locks held in the system:
> [  571.740495][   T30] 1 lock held by rcu_tasks_kthre/13:
> [  571.740758][   T30]  #0: ffffffff8b6badd0
> (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at:
> rcu_tasks_one_gp+0x2b/0xdb0
> [  571.741301][   T30] 1 lock held by rcu_tasks_trace/14:
> [  571.741571][   T30]  #0: ffffffff8b6baad0
> (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at:
> rcu_tasks_one_gp+0x2b/0xdb0
> [  571.742134][   T30] 1 lock held by khungtaskd/30:
> [  571.742385][   T30]  #0: ffffffff8b6bb960
> (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x5b/0x300
> [  571.742947][   T30] 2 locks held by kworker/u8:0/50:
> [  571.743198][   T30]  #0: ffff888016e7b138
> ((wq_completion)nbd0-recv){+.+.}-{0:0}, at:
> process_one_work+0x94b/0x17b0
> [  571.743809][   T30]  #1: ffff888011e4fdd0
> ((work_completion)(&args->work)){+.+.}-{0:0}, at:
> process_one_work+0x984/0x17b0
> [  571.744393][   T30] 1 lock held by in:imklog/6784:
> [  571.744643][   T30]  #0: ffff88801106e368
> (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100
> [  571.745122][   T30] 1 lock held by systemd-udevd/7123:
> [  571.745381][   T30]  #0: ffff8880431854c8
> (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x24b/0xae0
> [  571.745885][   T30]
> [  571.746008][   T30] =============================================
> [  571.746008][   T30]
> [  571.746424][   T30] NMI backtrace for cpu 1
> [  571.746642][   T30] CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.4.0-rc2 #1
> [  571.746989][   T30] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.12.0-1 04/01/2014
> [  571.747440][   T30] Call Trace:
> [  571.747606][   T30]  <TASK>
> [  571.747764][   T30]  dump_stack_lvl+0x91/0xf0
> [  571.747997][   T30]  nmi_cpu_backtrace+0x21a/0x2b0
> [  571.748257][   T30]  ? lapic_can_unplug_cpu+0xa0/0xa0
> [  571.748525][   T30]  nmi_trigger_cpumask_backtrace+0x28c/0x2f0
> [  571.748830][   T30]  watchdog+0xe4b/0x10c0
> [  571.749057][   T30]  ? proc_dohung_task_timeout_secs+0x90/0x90
> [  571.749366][   T30]  kthread+0x33b/0x430
> [  571.749596][   T30]  ? kthread_complete_and_exit+0x40/0x40
> [  571.749891][   T30]  ret_from_fork+0x1f/0x30
> [  571.750126][   T30]  </TASK>
> [  571.750347][   T30] Sending NMI from CPU 1 to CPUs 0:
> [  571.750620][    C0] NMI backtrace for cpu 0
> [  571.750626][    C0] CPU: 0 PID: 3987 Comm: systemd-journal Not
> tainted 6.4.0-rc2 #1
> [  571.750637][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.12.0-1 04/01/2014
> [  571.750643][    C0] RIP: 0033:0x7fb1d8c34bd1
> [  571.750652][    C0] Code: ed 4d 89 cf 75 a3 0f 1f 00 48 85 ed 75 4b
> 48 8b 54 24 28 48 8b 44 24 18 48 8b 7c 24 20 48 29 da 48 8b 70 20 48
> 0f af 54 24 08 <48> 83 c4 38 5b 5d 41 5c 41 5d 41 5e 41 5f e9 ac f2 04
> 00 0f 1f 40
> [  571.750662][    C0] RSP: 002b:00007ffff9686c30 EFLAGS: 00000202
> [  571.750670][    C0] RAX: 00007ffff9686e50 RBX: 0000000000000002
> RCX: 0000000000000010
> [  571.750677][    C0] RDX: 0000000000000010 RSI: 00007ffff9686d80
> RDI: 00007ffff9686f20
> [  571.750683][    C0] RBP: 0000000000000000 R08: 0000000000000010
> R09: 00007ffff9686d90
> [  571.750689][    C0] R10: 00007ffff9686fb0 R11: 00007fb1d8d6a060
> R12: 00007ffff9686f30
> [  571.750696][    C0] R13: 00007fb1d9d20ee0 R14: 00007ffff9686f30
> R15: 00007ffff9686d90
> [  571.750703][    C0] FS:  00007fb1da33d8c0 GS:  0000000000000000
> [  571.752358][   T30] Kernel panic - not syncing: hung_task: blocked tasks
> [  571.757337][   T30] CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.4.0-rc2 #1
> [  571.757686][   T30] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.12.0-1 04/01/2014
> [  571.758131][   T30] Call Trace:
> [  571.758302][   T30]  <TASK>
> [  571.758462][   T30]  dump_stack_lvl+0x91/0xf0
> [  571.758714][   T30]  panic+0x62d/0x6a0
> [  571.758926][   T30]  ? panic_smp_self_stop+0x90/0x90
> [  571.759188][   T30]  ? preempt_schedule_common+0x1a/0xc0
> [  571.759486][   T30]  ? preempt_schedule_thunk+0x1a/0x20
> [  571.759785][   T30]  ? watchdog+0xc21/0x10c0
> [  571.760020][   T30]  watchdog+0xc32/0x10c0
> [  571.760240][   T30]  ? proc_dohung_task_timeout_secs+0x90/0x90
> [  571.760541][   T30]  kthread+0x33b/0x430
> [  571.760753][   T30]  ? kthread_complete_and_exit+0x40/0x40
> [  571.761052][   T30]  ret_from_fork+0x1f/0x30
> [  571.761286][   T30]  </TASK>
> [  571.761814][   T30] Kernel Offset: disabled
> [  571.762047][   T30] Rebooting in 86400 seconds..
> 
>> You need to include poc_blkdev.c as part of your report.
> 
> It's a little confusing and I'm sorry for that.
> The poc_blkdev.c is exactly the C reproducer
> (https://pastebin.com/raw/6mg7uF8W).
> 
>> I suspect you've done something that is known to not work (as root,
>> so we won't necessarily care).  But I can't really say without seeing
>> what you've done.  Running syzkaller is an art, and most people aren't
>> good at it.  It takes a lot of work to submit good quality bug reports,
>> see this article:
>>
>> https://blog.regehr.org/archives/2037
> 
> I have read this article and thanks for your recommendations.
> I'm not familiar with this module and I haven't figured out the root
> cause of this bug yet.
> 
> Regards,
> 
> Yang
> 
> Matthew Wilcox <willy@infradead.org> 于2023年5月17日周三 20:20写道：
>>
>> On Wed, May 17, 2023 at 07:12:23PM +0800, yang lan wrote:
>>> root@syzkaller:~# uname -a
>>> Linux syzkaller 5.10.179 #1 SMP PREEMPT Thu Apr 27 16:22:48 CST 2023
>>
>> Does this reproduce on current kernels, eg 6.4-rc2?
>>
>>> root@syzkaller:~# gcc poc_blkdev.c -o poc_blkdev
>>
>> You need to include poc_blkdev.c as part of your report.
>>
>>> Please let me know if I can provide any more information, and I hope I
>>> didn't mess up this bug report.
>>
>> I suspect you've done something that is known to not work (as root,
>> so we won't necessarily care).  But I can't really say without seeing
>> what you've done.  Running syzkaller is an art, and most people aren't
>> good at it.  It takes a lot of work to submit good quality bug reports,
>> see this article:
>>
>> https://blog.regehr.org/archives/2037
> 
> Matthew Wilcox <willy@infradead.org> 于2023年5月17日周三 20:20写道：
>>
>> On Wed, May 17, 2023 at 07:12:23PM +0800, yang lan wrote:
>>> root@syzkaller:~# uname -a
>>> Linux syzkaller 5.10.179 #1 SMP PREEMPT Thu Apr 27 16:22:48 CST 2023
>>
>> Does this reproduce on current kernels, eg 6.4-rc2?
>>
>>> root@syzkaller:~# gcc poc_blkdev.c -o poc_blkdev
>>
>> You need to include poc_blkdev.c as part of your report.
>>
>>> Please let me know if I can provide any more information, and I hope I
>>> didn't mess up this bug report.
>>
>> I suspect you've done something that is known to not work (as root,
>> so we won't necessarily care).  But I can't really say without seeing
>> what you've done.  Running syzkaller is an art, and most people aren't
>> good at it.  It takes a lot of work to submit good quality bug reports,
>> see this article:
>>
>> https://blog.regehr.org/archives/2037
> .
> 

