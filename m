Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF05476C915
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 11:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjHBJMZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 05:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjHBJMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:12:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB432D40;
        Wed,  2 Aug 2023 02:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690967531; x=1691572331; i=quwenruo.btrfs@gmx.com;
 bh=hx3IByo9OBm/sfhGGa21X9t5gR5jnr8TcT1M7n0r4bc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=GzbdQTxULWlIntybjZWdAv2Bx/OwIB3c77UGDd0+/S28zkbIGJ9CLVfy0FistAq0lbZk3e1
 JQg2Q6LMljPdPUl0BaXJIK0FkgT5Ocx6yXs7BGh9OzFRwCO7mFqDZcSAxR8iLsQZZ+Y5jb5WQ
 7bFATA/JIFhD29WlG9xeM1IIGoEOoDkLrCBgpa4apqAUlFOBCOEJhLoMfp9BR+Ri4onej1Pup
 Z1bNB0XyHKxz7WlHvwNnSsUwhEoBACjzNnziqK0bLWHvSG0AHSluwiDpSekDuiOZrKdXrBPPd
 IZiTyzNYJ7PEuTaDN0ZDdMxzN4LHNNFNriSdvzQNEgKYPOp6GjvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wPb-1qT1iD2dR5-007UZr; Wed, 02
 Aug 2023 11:12:11 +0200
Message-ID: <73e2d2a8-9c15-0865-bc38-4cfb17c4c19d@gmx.com>
Date:   Wed, 2 Aug 2023 17:12:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
Content-Language: en-US
To:     syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000a3d67705ff730522@google.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <000000000000a3d67705ff730522@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7evTPCTACus+qpXGWvA5jbYXsPEPK0QQWrY9nS5cGiv+EUJhq0j
 2wHdmstRdGUD3tVJKLcAru1/Dv9zcDApWje8vpitgTbH/EKwZPVl5IqT8pVUxjqlBzcTzcy
 bh1zFd62jxjv7Jk6o4MQVft+Gl9TV6iOvajNIgbWAES0SG4sCdizv2mCzFVcCV+Jhc5GB0l
 CqYIyVTizgIaB+ujfiryQ==
UI-OutboundReport: notjunk:1;M01:P0:BiYx0PuhM6k=;fzjN03DiRwVnUq6foNROO9814N7
 p3aSe0E5ZAuaxj1OY9tLM+pdniiabQs1IKAlYVKeA7byQ7DlDx/DbQ4KzcvVab+UaGsnuAHob
 THdiZz+rQnCzCiAXAZnfQMd93K7l1c+pBQlCw6BT19b1r6vGDJzXz9wiViJ8MSHPPcLNSihIW
 YeIm30umo8Dl+S8XdUEeAUwwijtBTReWuBGdWvZ0y89UBBAAAjsiMuG05HRnrevhqevZyPnmp
 jrobwMqY8qJqY/iR4rh0PTXh/8qnM6CBUjv1Ht9g8bd0zgYG90SvxQ/+F+CBm5T3eBxA4BpGm
 rakRHivgZT9B3zetqNXxURueJgPKCOkrrAJBWncXna0WLYzj326tsm941mA4zE/uS9hRKRmq4
 u2OIPxy0zh/v1YhmsUVjfTPLEwVx8jlDI2n72UB5YYhSEGQidaQf174CWRN+4aoMXqD3+Ewu4
 cq18tEctv6zNeS0rjObQzaF0y4ZEcbgspJ74fninmNBWJkPHLvMkk4K8NbP9h7jPm+g2MNluh
 MjPn3428yCdpnPx0anZGLSBctwqfLubcxAIYVauN6JoMHXHV+Wue72qXr6qF27r+OeQBs5KM3
 OaU9wPUAiRfyj1w8p9m0/q6IjLM6WBuL404wmZkavpH/67mBY11MidTn/aOugYLuoJhwIWaTf
 oANDGdgHxq3m/DuabiZ+0m4Nu4G84EttiVfGDRK7KJ1PEruwXAWsgT5jZ55qJn7SxQ41nIWrm
 3e0O3+Z+cGMslCDzhYmQT2CsqAGXkYjFm727Ue7mDe18em5P4IcsYYVn+qSgedgiLlEJB2jdV
 W3AF3f8OdgD7wToRKmMsv+EKY5HzCCPV6Y9xmxdCg1wfywQE2zfWu0915P4+et6TSR7g8LyEv
 VehKPbydrv3Ibukq2L/rTddjH9eR7UhiXgQj+fIIK+Coi46l5f3oU73ehjMJYn5LpsaXfj7UQ
 kavcUP2Mjr5X+/tZLRlO7D3T20Q=
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/2 04:46, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    533925cb7604 Merge tag 'riscv-for-linus-6.5-mw1' of git:=
//..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14d8b610a800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D12464973c17d=
2b37
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dae97a827ae1c33=
36bbb4
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for De=
bian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7b23da6a6f6c/di=
sk-533925cb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f163e9ea9946/vmlin=
ux-533925cb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5b943aa5a1e1/=
bzImage-533925cb.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
>

#syz test: https://github.com/adam900710/linux graceful_reloc_mismatch

> assertion failed: root->reloc_root =3D=3D reloc_root, in fs/btrfs/reloca=
tion.c:1919
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/relocation.c:1919!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 9904 Comm: syz-executor.3 Not tainted 6.4.0-syzkaller-08881-=
g533925cb7604 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 05/27/2023
> RIP: 0010:prepare_to_merge+0xbb2/0xc40 fs/btrfs/relocation.c:1919
> Code: fe e9 f5 f7 ff ff e8 6d 62 ec fd 48 c7 c7 20 5e 4b 8b 48 c7 c6 c0 =
6d 4b 8b 48 c7 c2 a0 5e 4b 8b b9 7f 07 00 00 e8 8e d8 15 07 <0f> 0b e8 d7 =
17 18 07 f3 0f 1e fa e8 3e 62 ec fd 43 80 3c 2f 00 74
> RSP: 0018:ffffc9000325f760 EFLAGS: 00010246
> RAX: 000000000000004f RBX: ffff888075644030 RCX: 1481ccc522da5800
> RDX: ffffc90005c09000 RSI: 00000000000364ca RDI: 00000000000364cb
> RBP: ffffc9000325f870 R08: ffffffff816f33ac R09: 1ffff9200064bea0
> R10: dffffc0000000000 R11: fffff5200064bea1 R12: ffff888075644000
> R13: ffff88803b166000 R14: ffff88803b166560 R15: ffff88803b166558
> FS:  00007f4e305fd700(0000) GS:ffff8880b9800000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056080679c000 CR3: 00000000193ad000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   relocate_block_group+0xa5d/0xcd0 fs/btrfs/relocation.c:3749
>   btrfs_relocate_block_group+0x7ab/0xd70 fs/btrfs/relocation.c:4087
>   btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3283
>   __btrfs_balance+0x1b06/0x2690 fs/btrfs/volumes.c:4018
>   btrfs_balance+0xbdb/0x1120 fs/btrfs/volumes.c:4402
>   btrfs_ioctl_balance+0x496/0x7c0 fs/btrfs/ioctl.c:3604
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:870 [inline]
>   __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f4e2f88c389
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4e305fd168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f4e2f9abf80 RCX: 00007f4e2f88c389
> RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000005
> RBP: 00007f4e2f8d7493 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffdbefc213f R14: 00007f4e305fd300 R15: 0000000000022000
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:prepare_to_merge+0xbb2/0xc40 fs/btrfs/relocation.c:1919
> Code: fe e9 f5 f7 ff ff e8 6d 62 ec fd 48 c7 c7 20 5e 4b 8b 48 c7 c6 c0 =
6d 4b 8b 48 c7 c2 a0 5e 4b 8b b9 7f 07 00 00 e8 8e d8 15 07 <0f> 0b e8 d7 =
17 18 07 f3 0f 1e fa e8 3e 62 ec fd 43 80 3c 2f 00 74
> RSP: 0018:ffffc9000325f760 EFLAGS: 00010246
> RAX: 000000000000004f RBX: ffff888075644030 RCX: 1481ccc522da5800
> RDX: ffffc90005c09000 RSI: 00000000000364ca RDI: 00000000000364cb
> RBP: ffffc9000325f870 R08: ffffffff816f33ac R09: 1ffff9200064bea0
> R10: dffffc0000000000 R11: fffff5200064bea1 R12: ffff888075644000
> R13: ffff88803b166000 R14: ffff88803b166560 R15: ffff88803b166558
> FS:  00007f4e305fd700(0000) GS:ffff8880b9800000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055555657e888 CR3: 00000000193ad000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
