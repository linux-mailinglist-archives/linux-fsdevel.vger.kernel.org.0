Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C9C69C578
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 07:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjBTGxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 01:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjBTGxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 01:53:51 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88214D536
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Feb 2023 22:53:49 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id b13-20020a056e02184d00b0030c45d93884so1245939ilv.16
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Feb 2023 22:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/AmDIpLZkmroQ+870/z+05HD1TcWtyHCKJNzJ4mXk4=;
        b=eVc7BQnriH/5SXWMwICtp8Bg6wA8miDknRILDAOl/hkG9LYhTLYE8ifjb2xngmydE0
         brpZxCUGlRKVOU0bmgmyGdg9tRBbQ5pXwqxiCYZvYR8q9MSKmhdcrXW3iwO7h7h2+Yx+
         hHdJT9kt8IDI1XnzZaBdj7xcuJfXlQzWuWP89TDIQDNm4PH5D/4hA9HRAMaipFQLpKGi
         tYHIgpxzaCzcizZ3gi9J5Ocq28olSjt3sRsDXV8jI97sYZjq3AoUEpsG4qJ70DTzQFYs
         /QomCQyJjE1cIQUCpCUWa3++ucYfPP7enbGVVAep/i7W1rMYZB/llWFXXSrODI+dSn7N
         Pn5g==
X-Gm-Message-State: AO0yUKXJ3dHk5qA4rfZRRYr40HtOy7SFLhr+3TAxtU955YRK+bdTGGBV
        uuptsK2z9TEMdj+03Xz4CS5lNFxw8TwPNcLfHxXtUZOKzaph
X-Google-Smtp-Source: AK7set+FFpjbtuBQBhmtm/zLYnmGRleTT9tprXbZUp+IhHGwBlFe49kIikW5fIAHkSZqc7pTfK5ZasYVUwC2QmmXE0CeT5XazSQ/
MIME-Version: 1.0
X-Received: by 2002:a5d:8614:0:b0:73b:1230:3318 with SMTP id
 f20-20020a5d8614000000b0073b12303318mr1971093iol.94.1676876028767; Sun, 19
 Feb 2023 22:53:48 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:53:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006f99205f51c2064@google.com>
Subject: [syzbot] [f2fs?] KASAN: use-after-free Read in f2fs_lookup_rb_tree_ret
From:   syzbot <syzbot+be5d4a7d1df4ced1c53c@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e1c04510f521 Merge tag 'pm-6.2-rc9' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13833880c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed360bed0f6dd86a
dashboard link: https://syzkaller.appspot.com/bug?extid=be5d4a7d1df4ced1c53c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be5d4a7d1df4ced1c53c@syzkaller.appspotmail.com

loop0: rw=1048577, sector=79920, nr_sectors = 2000 limit=40427
kworker/u17:1: attempt to access beyond end of device
loop0: rw=1048577, sector=49152, nr_sectors = 4096 limit=40427
==================================================================
BUG: KASAN: use-after-free in f2fs_lookup_rb_tree_ret+0x70e/0x750 fs/f2fs/extent_cache.c:268
Read of size 8 at addr ffff888048193118 by task kworker/u17:1/15

CPU: 2 PID: 15 Comm: kworker/u17:1 Not tainted 6.2.0-rc8-syzkaller-00021-ge1c04510f521 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x461 mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 f2fs_lookup_rb_tree_ret+0x70e/0x750 fs/f2fs/extent_cache.c:268
 __update_extent_tree_range+0x322/0x1740 fs/f2fs/extent_cache.c:712
 __update_extent_cache+0x588/0x740 fs/f2fs/extent_cache.c:962
 f2fs_outplace_write_data+0x1eb/0x280 fs/f2fs/segment.c:3453
 f2fs_do_write_data_page+0x9c7/0x1e20 fs/f2fs/data.c:2745
 f2fs_write_single_data_page+0x13f0/0x1920 fs/f2fs/data.c:2863
 f2fs_write_cache_pages+0xaa8/0x2010 fs/f2fs/data.c:3115
 __f2fs_write_data_pages fs/f2fs/data.c:3265 [inline]
 f2fs_write_data_pages+0xca8/0x1230 fs/f2fs/data.c:3292
 do_writepages+0x1af/0x690 mm/page-writeback.c:2581
 __writeback_single_inode+0x159/0x1440 fs/fs-writeback.c:1598
 writeback_sb_inodes+0x54d/0xf90 fs/fs-writeback.c:1889
 __writeback_inodes_wb+0xc6/0x280 fs/fs-writeback.c:1960
 wb_writeback+0x8d6/0xd70 fs/fs-writeback.c:2065
 wb_check_background_flush fs/fs-writeback.c:2131 [inline]
 wb_do_writeback fs/fs-writeback.c:2219 [inline]
 wb_workfn+0xa16/0x12f0 fs/fs-writeback.c:2246
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 5258:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slab.c:3263 [inline]
 slab_alloc mm/slab.c:3272 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3449 [inline]
 kmem_cache_alloc+0x225/0x460 mm/slab.c:3458
 f2fs_kmem_cache_alloc_nofail fs/f2fs/f2fs.h:2796 [inline]
 f2fs_kmem_cache_alloc fs/f2fs/f2fs.h:2806 [inline]
 __grab_extent_tree+0x278/0x5a0 fs/f2fs/extent_cache.c:423
 f2fs_init_extent_tree+0x57/0x80 fs/f2fs/extent_cache.c:533
 f2fs_new_inode+0xdfa/0x2760 fs/f2fs/namei.c:312
 __f2fs_tmpfile+0xba/0x440 fs/f2fs/namei.c:852
 f2fs_ioc_start_atomic_write+0x409/0x1260 fs/f2fs/file.c:2098
 __f2fs_ioctl+0x3f2a/0xaaf0 fs/f2fs/file.c:4150
 f2fs_ioctl+0x18e/0x220 fs/f2fs/file.c:4242
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5258:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:523
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x13b/0x1a0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 __cache_free mm/slab.c:3396 [inline]
 __do_kmem_cache_free mm/slab.c:3582 [inline]
 kmem_cache_free mm/slab.c:3607 [inline]
 kmem_cache_free+0x108/0x4c0 mm/slab.c:3600
 __destroy_extent_tree+0x1f8/0x7f0 fs/f2fs/extent_cache.c:1193
 f2fs_destroy_extent_tree+0x17/0x30 fs/f2fs/extent_cache.c:1204
 f2fs_evict_inode+0x38b/0x1df0 fs/f2fs/inode.c:789
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x59b/0x880 fs/inode.c:1773
 iput+0x5c/0x80 fs/inode.c:1763
 f2fs_abort_atomic_write+0xea/0x4f0 fs/f2fs/segment.c:196
 f2fs_release_file+0xc8/0xf0 fs/f2fs/file.c:1869
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x2450 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888048193110
 which belongs to the cache f2fs_extent_tree of size 144
The buggy address is located 8 bytes inside of
 144-byte region [ffff888048193110, ffff8880481931a0)

The buggy address belongs to the physical page:
page:ffffea00012064c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888048193ee0 pfn:0x48193
flags: 0x4fff00000000200(slab|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000200 ffff888043be9e00 ffff888043c15d40 ffff888043c15d40
raw: ffff888048193ee0 ffff888048193040 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x140c50(GFP_NOFS|__GFP_COMP|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5258, tgid 5254 (syz-executor.0), ts 231438117054, free_ts 231023552910
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x119c/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1363 [inline]
 cache_grow_begin+0x94/0x390 mm/slab.c:2576
 fallback_alloc+0x1e2/0x2d0 mm/slab.c:3119
 __do_cache_alloc mm/slab.c:3223 [inline]
 slab_alloc_node mm/slab.c:3256 [inline]
 slab_alloc mm/slab.c:3272 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3449 [inline]
 kmem_cache_alloc+0x302/0x460 mm/slab.c:3458
 f2fs_kmem_cache_alloc_nofail fs/f2fs/f2fs.h:2796 [inline]
 f2fs_kmem_cache_alloc fs/f2fs/f2fs.h:2806 [inline]
 __grab_extent_tree+0x278/0x5a0 fs/f2fs/extent_cache.c:423
 f2fs_init_extent_tree+0x57/0x80 fs/f2fs/extent_cache.c:533
 f2fs_new_inode+0xdfa/0x2760 fs/f2fs/namei.c:312
 f2fs_create+0x1db/0x670 fs/f2fs/namei.c:353
 lookup_open.isra.0+0xee7/0x1270 fs/namei.c:3413
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x975/0x2a50 fs/namei.c:3711
 do_filp_open+0x1ba/0x410 fs/namei.c:3741
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x65c/0xc00 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3464
 slab_destroy mm/slab.c:1619 [inline]
 slabs_destroy+0x85/0xc0 mm/slab.c:1639
 __cache_free_alien mm/slab.c:774 [inline]
 cache_free_alien mm/slab.c:790 [inline]
 ___cache_free+0x204/0x3d0 mm/slab.c:3423
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x4f/0x1a0 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slab.c:3263 [inline]
 slab_alloc mm/slab.c:3272 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3449 [inline]
 kmem_cache_alloc+0x225/0x460 mm/slab.c:3458
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags+0x9e/0xe0 include/linux/audit.h:320
 user_path_at_empty+0x2f/0x60 fs/namei.c:2875
 user_path_at include/linux/namei.h:57 [inline]
 ksys_umount fs/namespace.c:1927 [inline]
 __do_sys_umount fs/namespace.c:1935 [inline]
 __se_sys_umount fs/namespace.c:1933 [inline]
 __x64_sys_umount+0xfc/0x190 fs/namespace.c:1933
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888048193000: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
 ffff888048193080: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>ffff888048193100: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888048193180: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888048193200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
