Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D9F6EBC24
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Apr 2023 02:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDWAFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Apr 2023 20:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDWAFr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Apr 2023 20:05:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F4211E;
        Sat, 22 Apr 2023 17:05:46 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oBx-1qBb0e2s4L-00wmTv; Sun, 23
 Apr 2023 02:05:38 +0200
Message-ID: <805af2ef-f789-55fc-71fc-9c9c02735abc@gmx.com>
Date:   Sun, 23 Apr 2023 08:05:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [syzbot] [btrfs?] kernel BUG in scrub_handle_errored_block
To:     syzbot <syzbot+e19c41a2f26eccf41aab@syzkaller.appspotmail.com>,
        chris@chrisdown.name, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000041d47405f9f56290@google.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <00000000000041d47405f9f56290@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:msgNTn8rWOsLwuTjEZ2O/4uG4VSBkoMnyMjJ7XXkU0ZZdf+ayOg
 qOEBOh1UnyPF6KSAIbcDcCfWk8DQwNLSrqk12xaV9YlqnJgCjrZYJGuV+Ja2n9JoFoVrLe9
 DRkaC9lPaxHUUM4+o7c4tjM8SY0hcLTg2mAhS+5gPaXRdmUA88wp+QzH+n/b9QIMUARWUtl
 2sOUkmtwlygWGGbvTQKLQ==
UI-OutboundReport: notjunk:1;M01:P0:D2grNhg9A/A=;yrLXiXVXPJRiaF8Z93O4wGs9HLa
 TnulD1K6BesCPTdRx4H80X8gLBLUlH8upvAw6fQhgFXOvTHRxqW8VqkVyNyv1zgcPFLz/znr5
 H5Wx0azlqXdueHZRzniuRXr4H2jSM31bJB0JJ24GXlZNFc8HUe9pcrnV1ddsxw6NEaHvZwY8B
 meQHP9LMkQHH4isVB1mWgCJfTdtnWeEuHZujMMvWvXrtwJmSseBZndop+6oe/WQftiX1ICTvv
 BsT7FkUrFXTr2zZH7jk2/qvynvG+WNsHM/gXIOkTmjnQj8KetsAyUn8w5AxRHcn8gcezs5VFJ
 320Be5NmbzaPBGvt1f+9TQ+muWVE8UcFc8QaOBi+5iVUYFIpOHRPXI0h2KXzAVliJUl0JiKgu
 hT3gKV7jIUSWrUTp+/R9wzhyOcwIPCBim7Pf3h0JTpyGOsK6bJTvsZLoUc6OnkvaeMAj06wzB
 Nd8vxFJBfd231GKt93cCkq8YlQvjQ/DoXFyWO4oOJi/dmeF2i13gM4xFEx/g9CStPYQsPIJ4K
 PB/r7sMJ2L/WV1dF/TaDeycCkeeg8XD1raeXooUjVSUYs5diyPyMndGWwSqXmoq2PUHuiRL0d
 +1127sMtY4V8nLX8BThoyJh/+S3APgt1gRJZeJosaYDXyShiu265FO1N+zNgR8y5MMj8RgaZ3
 iBuKnDYdbbzBGGXAgtKTB1lKvA5oa2NXYRRUc+Jo7l5a5VkIB1c3khzgmFuj2HB1jICxgsYMR
 2zc+CR11p9cBP+Ei8ZkxqZeSZNghTwqdMlURxCXr8LlZGGkeGtabGZFksSwE8sBrVteATXUX7
 q1jcUuuOemYueq8iCPAV5O/uocg5yzws0qdAmJzMD8lVMyi3TGtLyi/lhXwnfKg6XbmWFKR07
 VgNQw9UNzFBlBqa2e/PuLrh/HB02BbrYqK1vk+QYWpK/3IYqirYyFc8cxVG2788bEiIqGj4ix
 yOo0nj2Xyz2QHKD1dr3wUz6ZyHQ=
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/4/23 07:46, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    af67688dca57 Merge tag 'mmc-v6.3-rc3' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17f8020bc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4afb87f3ec27b7fd
> dashboard link: https://syzkaller.appspot.com/bug?extid=e19c41a2f26eccf41aab
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/eaa3ac1127b4/disk-af67688d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/02dd376f6bb3/vmlinux-af67688d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0162b8821f2f/bzImage-af67688d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e19c41a2f26eccf41aab@syzkaller.appspotmail.com
> 
> BTRFS warning (device loop5): tree block 5423104 mirror 1 has bad bytenr, has 0 want 5423104
> assertion failed: 0, in fs/btrfs/scrub.c:614

This happens because we expect to got an block group during scrub.

I guess it's due to the concurrent balance and scrub runs, as most of 
the code would check if the block group is removed, but not in that call 
site.

Anyway the code is already removed in the incoming scrub rework, thus 
should not be a problem.

But I'm a little surprised that we even allow scrub and balance to run 
at the same time...

Thanks,
Qu
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/messages.c:259!
> invalid opcode: 0000 [#2] PREEMPT SMP KASAN
> CPU: 0 PID: 17944 Comm: kworker/u4:18 Tainted: G      D            6.3.0-rc7-syzkaller-00043-gaf67688dca57 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
> Workqueue: btrfs-scrub scrub_bio_end_io_worker
> RIP: 0010:btrfs_assertfail+0x18/0x20 fs/btrfs/messages.c:259
> Code: df e8 2c 4c 43 f7 e9 50 fb ff ff e8 42 80 01 00 66 90 66 0f 1f 00 89 d1 48 89 f2 48 89 fe 48 c7 c7 80 ef 2b 8b e8 68 60 ff ff <0f> 0b 66 0f 1f 44 00 00 66 0f 1f 00 53 48 89 fb e8 a3 8b ed f6 48
> RSP: 0018:ffffc900166a7638 EFLAGS: 00010246
> RAX: 000000000000002c RBX: 0000000004248060 RCX: 8c5f616438692d00
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffffc900166a7910 R08: ffffffff816df7fc R09: fffff52002cd4e41
> R10: 0000000000000000 R11: dffffc0000000001 R12: ffffc900166a7860
> R13: ffff888030d3d000 R14: dffffc0000000000 R15: ffff88801cd20000
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b33342000 CR3: 0000000029ac2000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   lock_full_stripe fs/btrfs/scrub.c:614 [inline]
>   scrub_handle_errored_block+0x1ee1/0x4730 fs/btrfs/scrub.c:1067
>   scrub_bio_end_io_worker+0x9bb/0x1370 fs/btrfs/scrub.c:2559
>   process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
>   worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
>   kthread+0x270/0x300 kernel/kthread.c:376
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>   </TASK>
> Modules linked in:
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
