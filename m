Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CF768AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 07:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGaFLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 01:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjGaFLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:11:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8201E102;
        Sun, 30 Jul 2023 22:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690780268; x=1691385068; i=quwenruo.btrfs@gmx.com;
 bh=zjBugx4fwQ7xfuqpyuUGWqKp7bn3qQEDZOSgu5kSFc4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=U0JbCdZFYBUY5VVYqt4+Fb0pl9cUo17KIfbkqimuNpgDRpSpECIZnYhyklHFEBtJUt31xZH
 NsOXSwcHzXAz1O6fx0wukE6mUXn7CbhggVqhxmgH160KceaJOdN+69wlqMbgHggu/e+v42l5M
 On1a5cSQN6ydhEC3/RQVr2Y+9kDwFtCEoAdqkb9UU/OVNF2MK3v3JotypCaZqrA5QUGg2Nf8D
 LpU6KjO3IdjkPth243NMVCBjuIl8UtVn9Q2XewiCfVqFMNv8pg/r8xtD5j+O7uSvdGUZM7nop
 KZzKKlc3AfqruBQUh2fS4v8bQXPRyx3ZkJSR/w/RJjoW/r02ub8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQvD5-1qBAU83gut-00NwOr; Mon, 31
 Jul 2023 07:11:08 +0200
Message-ID: <0a79a1ad-697a-7687-ff94-2f4897648c22@gmx.com>
Date:   Mon, 31 Jul 2023 13:11:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
Content-Language: en-US
To:     syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f20fc00601b75a80@google.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <000000000000f20fc00601b75a80@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8FByRqop/gOGm0yOJ72yjdBv+Z+19DKkKxhpCnt0GF04P8Hubhy
 dT8I7yj2Ban5WaOzfUjBBy1Kx/aU4lOQMKJDFcl2pMgptNntxhP0lMqvqMH/0MIyyJWltgs
 MfgQW2PiBoAsxYMizZlV+6/6JPbmSB7mG1x0KTDjwGNi6RVq+v1WD+VRLI/42+0sazg77O8
 glqBMEy6Nwbc06xs5V00g==
UI-OutboundReport: notjunk:1;M01:P0:mk9kIDNkifA=;wh+kakODi/K95NID5xTgFlWQyo4
 3mvqPlRcNQZY0/o3SeRnYyyJ6CqEEPDXsSNt5zm6QPl153RzG6EV3PxIzG7ze6F5iksj/7rD5
 mUwe8Cg7JjtSoKzufLoVzrJz+0+NFkJVJCX1Y8YIOTXmPZimzJ1TX3NUlZKqAfawnBLWMjc+U
 71xAALiV+0IxL7bXeRgWtH2ZB+bGZWMhx/YaGGcBbXaq3waNnxWb1d5RlBHUr6Fv082oItIep
 DZetJhewdSa02wTAOeMo8l7R6Nn8USLjPnyXMaum6A5Mtp/VatDr50lHYwkznzOGYoGqfwYbs
 tFcNe3HhixjsP5Nem59hjqvXdsDfdx405RQki8EGneMH3kQdcZIF146pt/vcpjGzCMbQwgeVE
 iacxFe1iR/odqNL5UFj7Jk4uf4BnCCz+Tcmpgkji/8A06B6S/x3a0K4tjio1IXt9/XBqvFBjd
 0fEyHXCNt/04y62SWYteeFcuALy16RJr6rAAtWwObaw7moqeS+L/AUhBWn7RcdmjMu9q9aWoG
 478m+324Xrg76rPbBjOfinmGipd1VN1U1lAeUNghtOf4c6c1vdpn1vWz/W8pR3pkX9zKILS/a
 bUXm+5fqfedK4TdNvKSWSBvjcZfhyKmUS3OS0ynMWd1b/w1vkWrjijMOYQSVfVSiX9pnwfyra
 xDweQx11HWzgNx9GpgCtrd6f7+8yVNSM8hoyfTvWzwIZazpjhRbDVWcGDh8J8eYNZNfQfKcKF
 V1n3OdfQ3BcfbPdE6rywg5uoBBkRwUW+xacJl3KBzLLdJzADb2ZQqjrJTtf7e5KCoeBtYknJi
 5lmEwIxIbHsvGhMyrOjKXOp1eU45tjArPvwEfy+UQk7HAx6iBJyXQOkWOx8mHLYcRwD3npuvw
 Urst0pprtS2SKY6WOJy588xqCQFSeX2RqgXNm7soO53eKy7o6MmF6H1yTXttSfLxD+40p/zgg
 DvzSKTz/DI4/7zNaQ60ireNr3UE=
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/31 01:07, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    d31e3792919e Merge tag '6.5-rc3-smb3-client-fixes' of gi=
t:..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17afd745a800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9d670a4f6850=
b6f4
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dae97a827ae1c33=
36bbb4
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for =
Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15278939a8=
0000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14dd3f31a800=
00
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/=
7bc7510fe41f/non_bootable_disk-d31e3792.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c6c2342933c9/vmlin=
ux-d31e3792.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/42df60b42886/=
bzImage-d31e3792.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/78ffd1ddf=
f6c/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
>
> BTRFS info (device loop1): relocating block group 5242880 flags data|met=
adata
> assertion failed: root->reloc_root =3D=3D reloc_root, in fs/btrfs/reloca=
tion.c:1919
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/relocation.c:1919!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 12638 Comm: syz-executor311 Not tainted 6.5.0-rc3-syzkaller-=
00297-gd31e3792919e #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1=
.16.2-1 04/01/2014
> RIP: 0010:prepare_to_merge+0x9cc/0xcd0 fs/btrfs/relocation.c:1919
> Code: c5 e9 81 fd ff ff e8 e3 59 00 fe b9 7f 07 00 00 48 c7 c2 40 d9 b6 =
8a 48 c7 c6 20 e6 b6 8a 48 c7 c7 a0 da b6 8a e8 54 bc e3 fd <0f> 0b 4c 8b =
7c 24 38 48 8b 5c 24 10 44 8b 6c 24 0c e8 ae 59 00 fe
> RSP: 0018:ffffc90023e176d0 EFLAGS: 00010282
> RAX: 000000000000004f RBX: ffff88801e898560 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81698120 RDI: 0000000000000005
> RBP: ffff88801e898558 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000000 R11: 6f69747265737361 R12: dffffc0000000000
> R13: ffff88801e898000 R14: ffff88802d944000 R15: ffff888017616618
> FS:  00007fb31aba26c0(0000) GS:ffff88806b600000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb31ac3a758 CR3: 000000002e1dc000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   relocate_block_group+0x8d1/0xe70 fs/btrfs/relocation.c:3749
>   btrfs_relocate_block_group+0x714/0xd90 fs/btrfs/relocation.c:4087
>   btrfs_relocate_chunk+0x143/0x440 fs/btrfs/volumes.c:3283
>   __btrfs_balance fs/btrfs/volumes.c:4018 [inline]
>   btrfs_balance+0x20fc/0x3ef0 fs/btrfs/volumes.c:4395
>   btrfs_ioctl_balance fs/btrfs/ioctl.c:3604 [inline]
>   btrfs_ioctl+0x1362/0x5cf0 fs/btrfs/ioctl.c:4637
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:870 [inline]
>   __se_sys_ioctl fs/ioctl.c:856 [inline]
>   __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fb31abe6e49
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb31aba2168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fb31ac73728 RCX: 00007fb31abe6e49
> RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000005
> RBP: 00007fb31ac73720 R08: 00007fb31aba26c0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb31ac7372c
> R13: 0000000000000006 R14: 00007ffe768d5660 R15: 00007ffe768d5748
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:prepare_to_merge+0x9cc/0xcd0 fs/btrfs/relocation.c:1919
> Code: c5 e9 81 fd ff ff e8 e3 59 00 fe b9 7f 07 00 00 48 c7 c2 40 d9 b6 =
8a 48 c7 c6 20 e6 b6 8a 48 c7 c7 a0 da b6 8a e8 54 bc e3 fd <0f> 0b 4c 8b =
7c 24 38 48 8b 5c 24 10 44 8b 6c 24 0c e8 ae 59 00 fe
> RSP: 0018:ffffc90023e176d0 EFLAGS: 00010282
> RAX: 000000000000004f RBX: ffff88801e898560 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81698120 RDI: 0000000000000005
> RBP: ffff88801e898558 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000000 R11: 6f69747265737361 R12: dffffc0000000000
> R13: ffff88801e898000 R14: ffff88802d944000 R15: ffff888017616618
> FS:  00007fb31aba26c0(0000) GS:ffff88806b600000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb31ac3a758 CR3: 000000002e1dc000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>

I failed to reproduce it locally, although it's on David's misc-next.

# syz test: git://github.com/kdave/btrfs-devel.git misc-next

Thanks,
Qu
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
