Return-Path: <linux-fsdevel+bounces-2775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BD47E8FDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 14:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB921C20993
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 13:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA609C8D8;
	Sun, 12 Nov 2023 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoaflFqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF468BF2;
	Sun, 12 Nov 2023 13:08:11 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F099B2688;
	Sun, 12 Nov 2023 05:08:09 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c396ef9a3dso2964175b3a.1;
        Sun, 12 Nov 2023 05:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699794489; x=1700399289; darn=vger.kernel.org;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HquC3fxZfnilBbv0e908pVXYIGC5CQCykcD7pmBBSLk=;
        b=HoaflFqibQ6Va2Qx0R0kEk1YKp2dotpNBpu9hWkc82vJWA9w2zkReyD0tEIkiz0boi
         GBTk6MBEiSmgevFX7X4Awhfqd+rLh5jOlFfFO7p5xHtYyQeyFxSEKyyhCOvwAjjXjp6h
         WRh5D8+OtS35fdt9H+FvShnuHfHc7a0rk1sxfYSwj1bEpO4AnlIVgG9jf0oaWVlGnnMG
         XKTAdqOni00WzKE3osB5kJqlh5Exb2SrD+LIY2RD0Nzgwd3Oj/TbCys7CGnMu2iD/t/O
         VHCh+3m6exC8HLBa5CVZzcWmfYvsAK8wBfe0tpGEvTtkT6PK2JU1c2EkzH3fas9bSv95
         oSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699794489; x=1700399289;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HquC3fxZfnilBbv0e908pVXYIGC5CQCykcD7pmBBSLk=;
        b=ZlEGOXrHgmRxICJyiCq0zsD0r4mUym1tE4lKaIxnZWp+OhbE6ZHrjXbdPfehEVIlki
         vQCaxTGfC5/y/fpGTauW4veDaM3ycM8YHLr3KjDQthUpE4xSubAjA0zwOwVBVqz41E3j
         oYn/izjOOyhSsrOFixyhmuMbj2rMGC85t22yV3SzjSrQfVVrizDh/l4QJ6MC1hU2vIBQ
         gBmIXpYy0rmAj7ES9vC+7GHUWDKT5UU0dVqgtG6LrAcqfu5LyGKdCU7Nnol5Y/n+YxeF
         NCc8biounW1MfNa+yINw4UD0uidIu9WFxZUaZ93thfepbK70+7/N2/QSanRvzYo9wR3R
         qswA==
X-Gm-Message-State: AOJu0Yy03c7ebUPNwa35Y85bzgRnNBq3cwW+tnNYKG5S+ognEr08UkPA
	MyhgzSCQ8iTliRf2EdQ4eS4=
X-Google-Smtp-Source: AGHT+IHV8rCwlK03nDKxv7Gcx8uBao3j+lD80mkPCmd7qomAr8NcfUxpe1c9Ata4vc08CEulG0b4Ng==
X-Received: by 2002:a17:902:c14c:b0:1cc:6e5e:a980 with SMTP id 12-20020a170902c14c00b001cc6e5ea980mr2569249plj.3.1699794489282;
        Sun, 12 Nov 2023 05:08:09 -0800 (PST)
Received: from [192.168.1.4] ([117.243.91.115])
        by smtp.gmail.com with ESMTPSA id ix9-20020a170902f80900b001c74876f018sm2580571plb.18.2023.11.12.05.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 05:08:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------bkfPW3idvi5GL50KfXYs2VQC"
Message-ID: <10dd4562-81bf-48c7-b2a2-42ea51ba8843@gmail.com>
Date: Sun, 12 Nov 2023 18:38:00 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
Content-Language: en-US
To: syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f5ce160602f29dd6@google.com>
From: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <000000000000f5ce160602f29dd6@google.com>

This is a multi-part message in MIME format.
--------------bkfPW3idvi5GL50KfXYs2VQC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 
25aa0bebba72b318e71fe205bfd1236550cc9534

On 15/08/23 14:45, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    25aa0bebba72 Merge tag 'net-6.5-rc6' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=169577fda80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf8962e4f7984f4
> dashboard link: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148191c3a80000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/76b0857d2814/disk-25aa0beb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a01574755257/vmlinux-25aa0beb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/262002db770e/bzImage-25aa0beb.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/b93cffaa6717/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com
>
> BUG: memory leak
> unreferenced object 0xffff888129851240 (size 64):
>    comm "syz-executor.0", pid 5069, jiffies 4294977377 (age 16.480s)
>    hex dump (first 32 bytes):
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff815545e5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1076
>      [<ffffffff821731b1>] kmalloc include/linux/slab.h:582 [inline]
>      [<ffffffff821731b1>] btrfs_ref_tree_mod+0x211/0xb80 fs/btrfs/ref-verify.c:768
>      [<ffffffff820444f6>] btrfs_free_tree_block+0x116/0x450 fs/btrfs/extent-tree.c:3250
>      [<ffffffff8202d775>] __btrfs_cow_block+0x6a5/0xa30 fs/btrfs/ctree.c:601
>      [<ffffffff8202dc54>] btrfs_cow_block+0x154/0x2b0 fs/btrfs/ctree.c:712
>      [<ffffffff8206013c>] commit_cowonly_roots+0x8c/0x3f0 fs/btrfs/transaction.c:1276
>      [<ffffffff820647c9>] btrfs_commit_transaction+0x999/0x15c0 fs/btrfs/transaction.c:2410
>      [<ffffffff8205a516>] btrfs_commit_super+0x86/0xb0 fs/btrfs/disk-io.c:4195
>      [<ffffffff8205c743>] close_ctree+0x543/0x730 fs/btrfs/disk-io.c:4349
>      [<ffffffff8166b44e>] generic_shutdown_super+0x9e/0x1c0 fs/super.c:499
>      [<ffffffff8166b769>] kill_anon_super+0x19/0x30 fs/super.c:1110
>      [<ffffffff8202357d>] btrfs_kill_super+0x1d/0x30 fs/btrfs/super.c:2138
>      [<ffffffff8166ca46>] deactivate_locked_super+0x46/0xd0 fs/super.c:330
>      [<ffffffff8166cb6c>] deactivate_super fs/super.c:361 [inline]
>      [<ffffffff8166cb6c>] deactivate_super+0x9c/0xb0 fs/super.c:357
>      [<ffffffff816a8931>] cleanup_mnt+0x121/0x210 fs/namespace.c:1254
>      [<ffffffff812becaf>] task_work_run+0x8f/0xe0 kernel/task_work.c:179
>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
--------------bkfPW3idvi5GL50KfXYs2VQC
Content-Type: text/x-patch; charset=UTF-8; name="btrfs.diff"
Content-Disposition: attachment; filename="btrfs.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3JlZi12ZXJpZnkuYyBiL2ZzL2J0cmZzL3JlZi12ZXJp
ZnkuYwppbmRleCA5NWQyODQ5N2RlN2MuLjUwYjU5YjNkYzQ3NCAxMDA2NDQKLS0tIGEvZnMv
YnRyZnMvcmVmLXZlcmlmeS5jCisrKyBiL2ZzL2J0cmZzL3JlZi12ZXJpZnkuYwpAQCAtNzkx
LDYgKzc5MSw3IEBAIGludCBidHJmc19yZWZfdHJlZV9tb2Qoc3RydWN0IGJ0cmZzX2ZzX2lu
Zm8gKmZzX2luZm8sCiAJCQlkdW1wX3JlZl9hY3Rpb24oZnNfaW5mbywgcmEpOwogCQkJa2Zy
ZWUocmVmKTsKIAkJCWtmcmVlKHJhKTsKKwkJCWtmcmVlKHJlKTsKIAkJCWdvdG8gb3V0X3Vu
bG9jazsKIAkJfSBlbHNlIGlmIChiZS0+bnVtX3JlZnMgPT0gMCkgewogCQkJYnRyZnNfZXJy
KGZzX2luZm8sCkBAIC04MDAsNiArODAxLDcgQEAgaW50IGJ0cmZzX3JlZl90cmVlX21vZChz
dHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywKIAkJCWR1bXBfcmVmX2FjdGlvbihmc19p
bmZvLCByYSk7CiAJCQlrZnJlZShyZWYpOwogCQkJa2ZyZWUocmEpOworCQkJa2ZyZWUocmUp
OwogCQkJZ290byBvdXRfdW5sb2NrOwogCQl9CiAKQEAgLTgyMiw2ICs4MjQsNyBAQCBpbnQg
YnRyZnNfcmVmX3RyZWVfbW9kKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLAogCQkJ
CWR1bXBfcmVmX2FjdGlvbihmc19pbmZvLCByYSk7CiAJCQkJa2ZyZWUocmVmKTsKIAkJCQlr
ZnJlZShyYSk7CisJCQkJa2ZyZWUocmUpOwogCQkJCWdvdG8gb3V0X3VubG9jazsKIAkJCX0K
IAkJCWV4aXN0LT5udW1fcmVmcy0tOwpAQCAtODM4LDYgKzg0MSw3IEBAIGludCBidHJmc19y
ZWZfdHJlZV9tb2Qoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sCiAJCQlkdW1wX3Jl
Zl9hY3Rpb24oZnNfaW5mbywgcmEpOwogCQkJa2ZyZWUocmVmKTsKIAkJCWtmcmVlKHJhKTsK
KwkJCWtmcmVlKHJlKTsKIAkJCWdvdG8gb3V0X3VubG9jazsKIAkJfQogCQlrZnJlZShyZWYp
OwpAQCAtODQ5LDYgKzg1Myw3IEBAIGludCBidHJmc19yZWZfdHJlZV9tb2Qoc3RydWN0IGJ0
cmZzX2ZzX2luZm8gKmZzX2luZm8sCiAJCQlkdW1wX3JlZl9hY3Rpb24oZnNfaW5mbywgcmEp
OwogCQkJa2ZyZWUocmVmKTsKIAkJCWtmcmVlKHJhKTsKKwkJCWtmcmVlKHJlKTsKIAkJCWdv
dG8gb3V0X3VubG9jazsKIAkJfQogCX0K

--------------bkfPW3idvi5GL50KfXYs2VQC--

