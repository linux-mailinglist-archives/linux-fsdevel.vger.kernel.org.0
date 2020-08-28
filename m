Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA82559CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgH1MGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 08:06:06 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41506 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbgH1MFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:05:10 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kBd7v-004mhT-SY; Fri, 28 Aug 2020 06:05:03 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kBd7u-0002Pn-7T; Fri, 28 Aug 2020 06:05:03 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     syzbot <syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        christian@brauner.io, gladkov.alexey@gmail.com,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        walken@google.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <00000000000063640c05ade8e3de@google.com>
Date:   Fri, 28 Aug 2020 07:01:17 -0500
In-Reply-To: <00000000000063640c05ade8e3de@google.com> (syzbot's message of
        "Thu, 27 Aug 2020 21:57:22 -0700")
Message-ID: <87mu2fj7xu.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kBd7u-0002Pn-7T;;;mid=<87mu2fj7xu.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18AGG0tSGzkF5BhdcJjiSpCGwDDfHdMK3Q=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4734]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;syzbot <syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1139 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 14 (1.2%), b_tie_ro: 12 (1.0%), parse: 1.59
        (0.1%), extract_message_metadata: 25 (2.2%), get_uri_detail_list: 6
        (0.5%), tests_pri_-1000: 8 (0.7%), tests_pri_-950: 1.42 (0.1%),
        tests_pri_-900: 1.14 (0.1%), tests_pri_-90: 280 (24.6%), check_bayes:
        265 (23.3%), b_tokenize: 27 (2.4%), b_tok_get_all: 17 (1.5%),
        b_comp_prob: 5.0 (0.4%), b_tok_touch_all: 211 (18.5%), b_finish: 1.13
        (0.1%), tests_pri_0: 789 (69.3%), check_dkim_signature: 1.13 (0.1%),
        check_dkim_adsp: 3.1 (0.3%), poll_dns_idle: 0.37 (0.0%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 12 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: possible deadlock in proc_pid_syscall (2)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot <syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15349f96900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
> dashboard link: https://syzkaller.appspot.com/bug?extid=db9cdf3dd1f64252c6ef
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> Unfortunately, I don't have any reproducer for this issue yet.

Ok.

So if I read this set of traces correctly:

- perf_event_open holds exec_update_mutex

- perf_event_open can call kern_path which for overlayfs takes ovl_i_mutex

- chown on overlayfs calls mnt_want_write which takes sb_writes

- sendfile/splice can read from a seq_file (which takes p->lock)
  while holding mnt_want_write  aka sb_writes of the target file. 

- There are proc files that are seq_files that first take p->lock
  then take exec_update_mutex

So this looks real, if painful.

I have added some likely looking overlayfs and perf people to look at
this.

This feels like an issue where perf can just do too much under
exec_update_mutex.  In particular calling kern_path from
create_local_trace_uprobe.  Calling into the vfs at the very least
makes it impossible to know exactly which locks will be taken.

Thoughts?

Eric

> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.9.0-rc2-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor.0/18445 is trying to acquire lock:
> ffff88809f2e0dc8 (&sig->exec_update_mutex){+.+.}-{3:3}, at: lock_trace fs/proc/base.c:408 [inline]
> ffff88809f2e0dc8 (&sig->exec_update_mutex){+.+.}-{3:3}, at: proc_pid_syscall+0xaa/0x2b0 fs/proc/base.c:646
>
> but task is already holding lock:
> ffff88808e9a3c30 (&p->lock){+.+.}-{3:3}, at: seq_read+0x61/0x1070 fs/seq_file.c:155
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #3 (&p->lock){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
>        __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
>        seq_read+0x61/0x1070 fs/seq_file.c:155
>        pde_read fs/proc/inode.c:306 [inline]
>        proc_reg_read+0x221/0x300 fs/proc/inode.c:318
>        do_loop_readv_writev fs/read_write.c:734 [inline]
>        do_loop_readv_writev fs/read_write.c:721 [inline]
>        do_iter_read+0x48e/0x6e0 fs/read_write.c:955
>        vfs_readv+0xe5/0x150 fs/read_write.c:1073
>        kernel_readv fs/splice.c:355 [inline]
>        default_file_splice_read.constprop.0+0x4e6/0x9e0 fs/splice.c:412
>        do_splice_to+0x137/0x170 fs/splice.c:871
>        splice_direct_to_actor+0x307/0x980 fs/splice.c:950
>        do_splice_direct+0x1b3/0x280 fs/splice.c:1059
>        do_sendfile+0x55f/0xd40 fs/read_write.c:1540
>        __do_sys_sendfile64 fs/read_write.c:1601 [inline]
>        __se_sys_sendfile64 fs/read_write.c:1587 [inline]
>        __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1587
>        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> -> #2 (sb_writers#4){.+.+}-{0:0}:
>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>        __sb_start_write+0x234/0x470 fs/super.c:1672
>        sb_start_write include/linux/fs.h:1643 [inline]
>        mnt_want_write+0x3a/0xb0 fs/namespace.c:354
>        ovl_setattr+0x5c/0x850 fs/overlayfs/inode.c:28
>        notify_change+0xb60/0x10a0 fs/attr.c:336
>        chown_common+0x4a9/0x550 fs/open.c:674
>        do_fchownat+0x126/0x1e0 fs/open.c:704
>        __do_sys_lchown fs/open.c:729 [inline]
>        __se_sys_lchown fs/open.c:727 [inline]
>        __x64_sys_lchown+0x7a/0xc0 fs/open.c:727
>        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> -> #1 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
>        down_read+0x96/0x420 kernel/locking/rwsem.c:1492
>        inode_lock_shared include/linux/fs.h:789 [inline]
>        lookup_slow fs/namei.c:1560 [inline]
>        walk_component+0x409/0x6a0 fs/namei.c:1860
>        lookup_last fs/namei.c:2309 [inline]
>        path_lookupat+0x1ba/0x830 fs/namei.c:2333
>        filename_lookup+0x19f/0x560 fs/namei.c:2366
>        create_local_trace_uprobe+0x87/0x4e0 kernel/trace/trace_uprobe.c:1574
>        perf_uprobe_init+0x132/0x210 kernel/trace/trace_event_perf.c:323
>        perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9580
>        perf_try_init_event+0x12a/0x560 kernel/events/core.c:10899
>        perf_init_event kernel/events/core.c:10951 [inline]
>        perf_event_alloc.part.0+0xdee/0x3770 kernel/events/core.c:11229
>        perf_event_alloc kernel/events/core.c:11608 [inline]
>        __do_sys_perf_event_open+0x72c/0x2cb0 kernel/events/core.c:11724
>        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> -> #0 (&sig->exec_update_mutex){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:2496 [inline]
>        check_prevs_add kernel/locking/lockdep.c:2601 [inline]
>        validate_chain kernel/locking/lockdep.c:3218 [inline]
>        __lock_acquire+0x2a6b/0x5640 kernel/locking/lockdep.c:4426
>        lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:5005
>        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
>        __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
>        lock_trace fs/proc/base.c:408 [inline]
>        proc_pid_syscall+0xaa/0x2b0 fs/proc/base.c:646
>        proc_single_show+0x116/0x1e0 fs/proc/base.c:775
>        seq_read+0x432/0x1070 fs/seq_file.c:208
>        do_loop_readv_writev fs/read_write.c:734 [inline]
>        do_loop_readv_writev fs/read_write.c:721 [inline]
>        do_iter_read+0x48e/0x6e0 fs/read_write.c:955
>        vfs_readv+0xe5/0x150 fs/read_write.c:1073
>        do_preadv fs/read_write.c:1165 [inline]
>        __do_sys_preadv fs/read_write.c:1215 [inline]
>        __se_sys_preadv fs/read_write.c:1210 [inline]
>        __x64_sys_preadv+0x231/0x310 fs/read_write.c:1210
>        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> other info that might help us debug this:
>
> Chain exists of:
>   &sig->exec_update_mutex --> sb_writers#4 --> &p->lock
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&p->lock);
>                                lock(sb_writers#4);
>                                lock(&p->lock);
>   lock(&sig->exec_update_mutex);
>
>  *** DEADLOCK ***
>
> 1 lock held by syz-executor.0/18445:
>  #0: ffff88808e9a3c30 (&p->lock){+.+.}-{3:3}, at: seq_read+0x61/0x1070 fs/seq_file.c:155
>
> stack backtrace:
> CPU: 0 PID: 18445 Comm: syz-executor.0 Not tainted 5.9.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  check_noncircular+0x324/0x3e0 kernel/locking/lockdep.c:1827
>  check_prev_add kernel/locking/lockdep.c:2496 [inline]
>  check_prevs_add kernel/locking/lockdep.c:2601 [inline]
>  validate_chain kernel/locking/lockdep.c:3218 [inline]
>  __lock_acquire+0x2a6b/0x5640 kernel/locking/lockdep.c:4426
>  lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:5005
>  __mutex_lock_common kernel/locking/mutex.c:956 [inline]
>  __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
>  lock_trace fs/proc/base.c:408 [inline]
>  proc_pid_syscall+0xaa/0x2b0 fs/proc/base.c:646
>  proc_single_show+0x116/0x1e0 fs/proc/base.c:775
>  seq_read+0x432/0x1070 fs/seq_file.c:208
>  do_loop_readv_writev fs/read_write.c:734 [inline]
>  do_loop_readv_writev fs/read_write.c:721 [inline]
>  do_iter_read+0x48e/0x6e0 fs/read_write.c:955
>  vfs_readv+0xe5/0x150 fs/read_write.c:1073
>  do_preadv fs/read_write.c:1165 [inline]
>  __do_sys_preadv fs/read_write.c:1215 [inline]
>  __se_sys_preadv fs/read_write.c:1210 [inline]
>  __x64_sys_preadv+0x231/0x310 fs/read_write.c:1210
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x45d5b9
> Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fb613f9ec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
> RAX: ffffffffffffffda RBX: 0000000000025740 RCX: 000000000045d5b9
> RDX: 0000000000000333 RSI: 00000000200017c0 RDI: 0000000000000006
> RBP: 000000000118cf90 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
> R13: 00007ffe2a82bbbf R14: 00007fb613f9f9c0 R15: 000000000118cf4c
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
