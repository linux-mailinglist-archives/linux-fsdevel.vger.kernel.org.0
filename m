Return-Path: <linux-fsdevel+bounces-60452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C3CB46E2F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 15:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AC61BC831F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8026B2F1FF7;
	Sat,  6 Sep 2025 13:32:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D10286D7C;
	Sat,  6 Sep 2025 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757165525; cv=none; b=Je1WY4iZs6HlO1bttit2SyyHX+VMy/pwacyeAtG1BUGHCPbjEN/gNU5pD4PMeBBmGNARVDYGqvXjwfwclVIhmplHVgyWkUNiIdPkaXW+r2p0ePul3Vy4QL1Na8ldxgjCa07egiKu3UhpDcQVo99hAJpibR4umgY7coxucMo/6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757165525; c=relaxed/simple;
	bh=nrHwt+sfW3m3rjuEacOQDG1CQbYgvI4yMSgcHGAZdNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MK+OrU7UFy8Iy5bayKyYs6C+yspgzab7OaxL5ejRDDpdfW4mBAVG2bSgK0MQ9pmCQEQmKke5E/eKEeqaIfC+65xOiCUBEKSOKEIkYe+FvWfvppSrZpfGLoeN5R1Iak8P6O0ouxZDZzX4E0hQ/jliQPb0A3e9Q3LmrBCKUyJ1O4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 586DUZVP092719;
	Sat, 6 Sep 2025 22:30:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 586DUZ8m092716
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 6 Sep 2025 22:30:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fa7b2e99-f91d-4126-9d0a-1b0330023394@I-love.SAKURA.ne.jp>
Date: Sat, 6 Sep 2025 22:30:31 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hfs?] INFO: task hung in deactivate_super (3)
To: syzbot <syzbot+cba6270878c89ed64a2d@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, brauner@kernel.org, frank.li@vivo.com,
        glaubitz@physik.fu-berlin.de, jack@suse.cz,
        jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org,
        shaggy@kernel.org, slava@dubeyko.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
References: <00000000000091e466061cee5be7@google.com>
 <68b55245.050a0220.3db4df.01bc.GAE@google.com>
 <20250902144655.5em4trxkeks7nwgx@offworld>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250902144655.5em4trxkeks7nwgx@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/09/02 23:46, Davidlohr Bueso wrote:
> On Mon, 01 Sep 2025, syzbot wrote:
> 
>> syzbot has bisected this issue to:
>>
>> commit 5b67d43976828dea2394eae2556b369bb7a61f64
>> Author: Davidlohr Bueso <dave@stgolabs.net>
>> Date:   Fri Apr 18 01:59:17 2025 +0000
>>
>>    fs/buffer: use sleeping version of __find_get_block()
> 
> I don't think this bisection is right, considering this issue was first
> triggered last year (per the dashboard).

I think this bisection is not bogus; at least that commit made this problem
easily triggerable enough to find a reproducer...

What is common to this report is that deactivate_super() is blocked waiting
for hfs_sync_fs() to complete and release sb->s_umount lock.

Current sample crash report (shown below) tells us that PID = 5962 (who is trying
to hold for write) is blocked inside deactivate_super() waiting for PID = 6254
(who is already holding for read) to release sb->s_umount lock. But since PID = 6254
is blocked at io_schedule(), PID = 6254 can't release sb->s_umount lock.

The question is why PID = 6254 is blocked for two minutes waiting for io_schedule()
to complete. I suspect that commit 5b67d4397682 is relevant, for that commit has
changed the behavior of bdev_getblk() which PID = 6254 is blocked. Some method for
reporting what is happening (e.g. report details when folio_lock() is blocked for
more than 10 seconds) is wanted. Of course, it is possible that a corrupted hfs
filesystem image is leading to an infinite loop...



INFO: task syz-executor:5962 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21832 pid:5962  tgid:5962  ppid:1      task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7339
 rwbase_write_lock+0x3dd/0x750 kernel/locking/rwbase_rt.c:272
 __super_lock fs/super.c:57 [inline]
 __super_lock_excl fs/super.c:72 [inline]
 deactivate_super+0xa9/0xe0 fs/super.c:506
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1375
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_to_user_mode_loop+0[  309.321754][   T38]  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0[  309.321754][   T38]  exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff4a4aaff17
RSP: 002b:00007ffe8b16a008 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007ff4a4b31c05 RCX: 00007ff4a4aaff17
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe8b16a0c0
RBP: 00007ffe8b16a0c0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe8b16b150
R13: 00007ff4a4b31c05 R14: 00000000000257d4 R15: 00007ffe8b16b190
 </TASK>
1 lock held by syz-executor/5962:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:506

INFO: task syz.4.168:6254 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.168       state:D stack:25800 pid:6254  tgid:6254  ppid:5967   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x81/0xe0 kernel/sched/core.c:7903
 folio_wait_bit_common+0x6b5/0xb90 mm/filemap.c:1317
 folio_lock include/linux/pagemap.h:1133 [inline]
 __find_get_block_slow fs/buffer.c:205 [inline]
 find_get_block_common+0x2e6/0xfc0 fs/buffer.c:1408
 bdev_getblk+0x4b/0x660 fs/buffer.c:-1
 __bread_gfp+0x89/0x3c0 fs/buffer.c:1515
 sb_bread include/linux/buffer_head.h:346 [inline]
 hfs_mdb_commit+0xa42/0x1160 fs/hfs/mdb.c:318
 hfs_sync_fs+0x15/0x20 fs/hfs/super.c:37
 __iterate_supers+0x13a/0x290 fs/super.c:924
 ksys_sync+0xa3/0x150 fs/sync.c:103
 __ia32_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35c0abebe9
RSP: 002b:00007fff821c57b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f35c0cf5fa0 RCX: 00007f35c0abebe9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f35c0cf5fa0 R14: 00007f35c0cf5fa0 R15: 0000000000000000
 </TASK>
1 lock held by syz.4.168/6254:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121


