Return-Path: <linux-fsdevel+bounces-32005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A4799F0CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 17:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85AB1C2173E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EC714A60D;
	Tue, 15 Oct 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PMi/9q23"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AA1CBA0C;
	Tue, 15 Oct 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005293; cv=none; b=T6jqH9vQQzb7T2HNGwAmCJrSobuLao2bnLj6phh6sP+Xn51Z4wfyA10KopIICmhoOvBs8F7UwPf6ogXdMpm9Vgjgyr55+gU0jvTbOU1NoUyI7OG02tyb+lfoiJljAeq7MMI2lzHzUhHN3ix4OOVdlEkE6uaYG9SJQgXiNjvV7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005293; c=relaxed/simple;
	bh=omRJqiYyMi/GIo5oFxWyw97b7zKSG5rF9cTg8vXNq38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iP7gTySs+9/ZrWRmSYT+yzbpBcfQX3Ao5uOULoHWdaMsCEjASkoZGqFBStA6/40FcHRZUpy/TlWhDlfJNKK+Tw9sHBbKGDy//+saUo/bhZyBn/e5AOAElr/e48fY2Vp4U1/nfis3lEfGT9AUv1DLPXp7PqMaCGWKeBdXI9Wl+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PMi/9q23; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729005289;
	bh=omRJqiYyMi/GIo5oFxWyw97b7zKSG5rF9cTg8vXNq38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PMi/9q23tf3rgAefKVzlOH89s5sUpe4w3ayxQkqYRy6H8D0tPZCPQxwKmqLe2qqH1
	 i/hQ6bLEiZpUJfUtytvDpOlLiDcezrn6/y7To8MUAblrGQl2AcOY1ngqdduVnNKfdS
	 Y4F2KWQREd8jKZEIDyZpBeW2mx31wNjoxlcczep1FuCEuZixSUZ8wP3pCn+o5L3u/w
	 yWxK2StcwnH0sLKRtrD9Cx3nHDtZF0nD2HwMZP31UzHWrlvM0E2l6CZ7W0ohb9PVjO
	 tiDzvQIO2oK14onP0h0DxfnPrctkpIfvrHK/MzU41KIp6Y7sz4PNuhBsP1/ryRsAJc
	 2JQ/IvUEVezow==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XSd1h71Lfz10rl;
	Tue, 15 Oct 2024 11:14:48 -0400 (EDT)
Message-ID: <03c26ddd-fa06-47b6-876f-b563e5aa6cbf@efficios.com>
Date: Tue, 15 Oct 2024 11:12:58 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] [mm?] stack segment fault in folio_wait_writeback
To: Dmitry Vyukov <dvyukov@google.com>,
 syzbot <syzbot+8cb2efaaad483f65f56c@syzkaller.appspotmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, willy@infradead.org
References: <670ba885.050a0220.4cbc0.002e.GAE@google.com>
 <CACT4Y+bbG_pthEYyG5mCYZVdA1Rzch2rZ5Yoit6gPaKjssPAJg@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CACT4Y+bbG_pthEYyG5mCYZVdA1Rzch2rZ5Yoit6gPaKjssPAJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-14 04:41, Dmitry Vyukov wrote:
> On Sun, 13 Oct 2024 at 13:01, syzbot
> <syzbot+8cb2efaaad483f65f56c@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    7234e2ea0edd Merge tag 'scsi-fixes' of git://git.kernel.or..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=157a085f980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
>> dashboard link: https://syzkaller.appspot.com/bug?extid=8cb2efaaad483f65f56c
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146c7fd0580000
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7234e2ea.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/aa111520a0b7/vmlinux-7234e2ea.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/07889fadba3b/bzImage-7234e2ea.xz
>> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/178fe4a5f5e7/mount_1.gz
>> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/7847e1862894/mount_2.gz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+8cb2efaaad483f65f56c@syzkaller.appspotmail.com
>>
>> loop0: detected capacity change from 0 to 256
>> exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0xcc9b7de9, utbl_chksum : 0xe619d30d)
>> Oops: stack segment: 0000 [#1] PREEMPT SMP KASAN NOPTI
>> CPU: 0 UID: 0 PID: 5340 Comm: syz.0.50 Not tainted 6.12.0-rc2-syzkaller-00305-g7234e2ea0edd #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> RIP: 0010:PageTail include/linux/page-flags.h:281 [inline]
>> RIP: 0010:const_folio_flags include/linux/page-flags.h:309 [inline]
>> RIP: 0010:folio_test_writeback include/linux/page-flags.h:555 [inline]
>> RIP: 0010:folio_wait_writeback+0x2f/0x1e0 mm/page-writeback.c:3187
>> Code: 41 57 41 56 41 55 41 54 53 48 83 ec 18 48 89 fb 49 bd 00 00 00 00 00 fc ff df e8 ac 7e c4 ff 4c 8d 73 08 4c 89 f5 48 c1 ed 03 <42> 80 7c 2d 00 00 74 08 4c 89 f7 e8 11 2f 2e 00 4d 8b 3e 4c 89 fe
>> RSP: 0018:ffffc900025a7190 EFLAGS: 00010202
>> RAX: ffffffff81d068a4 RBX: 0000000000000000 RCX: ffff888000c3c880
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
>> RBP: 0000000000000001 R08: ffffffff81cc460e R09: 1ffffd4000003328
>> R10: dffffc0000000000 R11: fffff94000003329 R12: dffffc0000000000
>> R13: dffffc0000000000 R14: 0000000000000008 R15: 0000000000000001
>> FS:  00007f7a897816c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f7a88a75c60 CR3: 000000003f406000 CR4: 0000000000352ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   __filemap_fdatawait_range+0x17c/0x2b0 mm/filemap.c:533
>>   file_write_and_wait_range+0x1e3/0x280 mm/filemap.c:792
>>   __generic_file_fsync+0x6f/0x1a0 fs/libfs.c:1528
>>   exfat_file_fsync+0xf9/0x1d0 fs/exfat/file.c:524
>>   exfat_file_write_iter+0x312/0x3f0 fs/exfat/file.c:608
>>   iter_file_splice_write+0xbfa/0x1510 fs/splice.c:743
>>   do_splice_from fs/splice.c:941 [inline]
>>   direct_splice_actor+0x11b/0x220 fs/splice.c:1164
>>   splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
>>   do_splice_direct_actor fs/splice.c:1207 [inline]
>>   do_splice_direct+0x289/0x3e0 fs/splice.c:1233
>>   do_sendfile+0x561/0xe10 fs/read_write.c:1388
>>   __do_sys_sendfile64 fs/read_write.c:1455 [inline]
>>   __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1441
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f7a8897dff9
>> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007f7a89781038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
>> RAX: ffffffffffffffda RBX: 00007f7a88b35f80 RCX: 00007f7a8897dff9
>> RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
>> RBP: 00007f7a889f0296 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000100001 R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000000000000000 R14: 00007f7a88b35f80 R15: 00007fffbdf78608
>>   </TASK>
>> Modules linked in:
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:PageTail include/linux/page-flags.h:281 [inline]
>> RIP: 0010:const_folio_flags include/linux/page-flags.h:309 [inline]
>> RIP: 0010:folio_test_writeback include/linux/page-flags.h:555 [inline]
>> RIP: 0010:folio_wait_writeback+0x2f/0x1e0 mm/page-writeback.c:3187
>> Code: 41 57 41 56 41 55 41 54 53 48 83 ec 18 48 89 fb 49 bd 00 00 00 00 00 fc ff df e8 ac 7e c4 ff 4c 8d 73 08 4c 89 f5 48 c1 ed 03 <42> 80 7c 2d 00 00 74 08 4c 89 f7 e8 11 2f 2e 00 4d 8b 3e 4c 89 fe
>> RSP: 0018:ffffc900025a7190 EFLAGS: 00010202
>> RAX: ffffffff81d068a4 RBX: 0000000000000000 RCX: ffff888000c3c880
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
>> RBP: 0000000000000001 R08: ffffffff81cc460e R09: 1ffffd4000003328
>> R10: dffffc0000000000 R11: fffff94000003329 R12: dffffc0000000000
>> R13: dffffc0000000000 R14: 0000000000000008 R15: 0000000000000001
>> FS:  00007f7a897816c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f7a8975ff98 CR3: 000000003f406000 CR4: 0000000000352ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> ----------------
>> Code disassembly (best guess):
>>     0:   41 57                   push   %r15
>>     2:   41 56                   push   %r14
>>     4:   41 55                   push   %r13
>>     6:   41 54                   push   %r12
>>     8:   53                      push   %rbx
>>     9:   48 83 ec 18             sub    $0x18,%rsp
>>     d:   48 89 fb                mov    %rdi,%rbx
>>    10:   49 bd 00 00 00 00 00    movabs $0xdffffc0000000000,%r13
>>    17:   fc ff df
>>    1a:   e8 ac 7e c4 ff          call   0xffc47ecb
>>    1f:   4c 8d 73 08             lea    0x8(%rbx),%r14
>>    23:   4c 89 f5                mov    %r14,%rbp
>>    26:   48 c1 ed 03             shr    $0x3,%rbp
>> * 2a:   42 80 7c 2d 00 00       cmpb   $0x0,0x0(%rbp,%r13,1) <-- trapping instruction
> 
> +tracing maintainers
> 
> Not sure how this instruction can cause stack segment violation.
> The reproducer does something with raw tracepoints:
> https://syzkaller.appspot.com/text?tag=ReproSyz&x=146c7fd0580000

The program attached to the raw tracepoint here is a bpf program. The
bpf verifier should ensure that the raw tracepoint inputs (e.g.
memory targeted by pointers) don't get corrupted by the bpf program.

> 
> Can raw tracepoints legally arbitrary corrupt kernel state?
> If yes, is there some safe subset at least?

 From a tracepoint perspective, that's really up to the implementer of
the probe to make sure they don't corrupt the memory received as input
from pointer arguments. AFAIU, in this case this validation should be
done by the bpf verifier.

CCing BPF maintainers.

Thanks,

Mathieu

> 
> 
>>    30:   74 08                   je     0x3a
>>    32:   4c 89 f7                mov    %r14,%rdi
>>    35:   e8 11 2f 2e 00          call   0x2e2f4b
>>    3a:   4d 8b 3e                mov    (%r14),%r15
>>    3d:   4c 89 fe                mov    %r15,%rsi
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


