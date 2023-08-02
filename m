Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C4276C4C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 07:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjHBFUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 01:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjHBFUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:20:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5BB272B;
        Tue,  1 Aug 2023 22:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690953575; x=1691558375; i=quwenruo.btrfs@gmx.com;
 bh=w/TScA02ogqhMMolhH46P9UN02nEO/zVcArS9T+/saY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=IORdsgOx+/qB7WnS/dvEO9Ugn3e5E3cj0pVhcT1hqC1VC5m2TFzyWDxTwDgfvVC4vrsZ1a1
 W9xaIG0uH2Vx0swS8P+3wE9BV4BtFLQwD77N/OBhAOc8NLbdTCiTEhCklqdCbIl1hB0OqY1Js
 Bh8329dpZ7KH6k4WWRtW5x+6ZEhAu5sqYbiDQqkfA4f4YkuJjbWJ8llp7ekk7amHy9+mT9nOF
 8dcAff0v6rCsFHPt8hO2SWMNSyCyfdZG/u0f1MrljVd9p6WdtQGlPTm4hJhRXMRAnGBXZQHzn
 ztcPmo4e5QtSIX1Uzq7PhWvwjIvZe4/qgVxI/aQ/yNgMwg0XfwtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M72sJ-1qUf2f12PH-008aV7; Wed, 02
 Aug 2023 07:19:34 +0200
Message-ID: <8d17478c-f1d7-d1fa-3012-06b0ba8d534c@gmx.com>
Date:   Wed, 2 Aug 2023 13:19:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
Content-Language: en-US
To:     syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nogikh@google.com,
        syzkaller-bugs@googlegroups.com
References: <000000000000812c200601ddc8de@google.com>
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
In-Reply-To: <000000000000812c200601ddc8de@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mIIxj0WpHO3rjxsIe1WuG918amMGZOPOazE2o1MRO5cl8CwJZsD
 w1/vhRpTAYyimijG6nU3YjBNio6HujOd6WAz7oONK7hTTHGAqakBS8/pBv8Pq+0SEkZrxFw
 FTGabLNoI0kuHI/f9e0oYoxx1CvuyryN0EOIqe8wbctlyeN8M5krvrBsp5/iF2nvfXGm8VS
 VbngFSbGh8niisXy8S10w==
UI-OutboundReport: notjunk:1;M01:P0:ZdGh3AeLqNI=;uEWK2DMK8GQjxkuboOS8QknoT5G
 t2jIRBoisa1DIOghuawrdhvg3rMHhFPZKEug7ruWj0R+bqSuF8nEhYHCFrbbsImAHiFZDfi1Z
 iOSy9LfvszGUBE8Z6J30v7NTPEF86b7b74FaFX6zt/0St+bhcl8Szm0uIF5dYz4yEsfgDCh2w
 rmN1tIxRdQovI3gzbP099QG6U78MMCgptVSZlBhpUa0nmhysdNklGhqul9qOYBPATAQ4uRJ+d
 OuZiy0tjs5VwZS3ATRVnpiAFJvW/fN6zF5L9f8pMYRCIRbMorp+mKnJ1FnAP5Dd2UcJcqDsu9
 MgZ99Nebyq6+qg9+pIUkqJr13eoVlCEUxahnzl/tZN7EGBWI3CZEiG29vawUrL/+0CRN8Ejou
 3TykBQUMh4RNxcI6G7O9cegV0iWN2BcG918pTvAlpxRBo+qoIS4yJ4MLCrQMv/uqK6s7xQR0+
 W7zGevE1tVIY8XuZrgyr9IrPUnycJAP9LyMzvXQONBN8l7lHfh88H5V1XJPJL+jInMAazjpyT
 eKw5cBwgd22BLh/xGb+nGIkpN93tb8YjPxDrgitU4Q6duVB5KovsMji4zpAEuSCVQLuDIIzKV
 ccOwRVzCDlodpLy/Gg1IjPGJr6WI+XbVUbn0viXNw06a81n5juwfciakeyruOqgsSJ16b+aKK
 XnNzk/JC9/+8zhzYNcdMwqu3Cvra7PCDsvW77XZGE3xNY1jpM5gl23PEY8DZdSirD1qlKCHyc
 VdF8rjaxCWo/xVEByXKwaaQlpBytvEuJmP8Jz7+ikP3Phz2ziyhJKEDe0KFqM5TySBex9iZAU
 IUvp9Zq0CUXqx9hNytJEItbaK+vmAeCDveXNYh2Dvaidq+dmycHRkbP1p09sBHD1nt4rwow0W
 Y3Rkkg6zhqrjZOAfHKOzKTg1vBbSLsCQHJdX6/KKpoV0bK+pCqyEVpJRoIu8oss8HFIGf2BdP
 mcBrRdOBe8FFJQB4yXUa+TcNL3w=
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/8/1 22:58, syzbot wrote:
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still trigger=
ing an issue:
> WARNING in prepare_to_merge
>
> BTRFS error (device loop3): reloc tree mismatch, root 8 has no reloc roo=
t, expect reloc root key (-8, 132, 8) gen 17

#syz test: https://github.com/adam900710/linux graceful_reloc_mismatch

I have added another patch to reject those invalid reloc tree keys, thus
at least we could have a more graceful rejection (without kernel warnings)=
.

But the previous patch is still needed to catch not-so-obvious corrupted
reloc root keys.

Thanks,
Qu
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -117)
> WARNING: CPU: 1 PID: 10413 at fs/btrfs/relocation.c:1946 prepare_to_merg=
e+0x10e0/0x1460 fs/btrfs/relocation.c:1946
> Modules linked in:
> CPU: 1 PID: 10413 Comm: syz-executor.3 Not tainted 6.5.0-rc3-syzkaller-g=
9f2c8c9193cc #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1=
.16.2-1 04/01/2014
> RIP: 0010:prepare_to_merge+0x10e0/0x1460 fs/btrfs/relocation.c:1946
> Code: 8b 7e 50 44 89 e2 48 c7 c6 20 d8 b6 8a e8 58 1b 10 00 eb c1 e8 d1 =
83 00 fe be 8b ff ff ff 48 c7 c7 80 d7 b6 8a e8 f0 4b c7 fd <0f> 0b e9 bf =
fe ff ff 48 8b 7c 24 28 e8 af 93 53 fe e9 3e f5 ff ff
> RSP: 0018:ffffc90003ebf6b0 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff8880478f2b78 RCX: 0000000000000000
> RDX: ffff8880466c9300 RSI: ffffffff814c5346 RDI: 0000000000000001
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000046525442 R12: 0000000000000000
> R13: 0000000000000084 R14: ffff8880478f2b28 R15: ffff888030e28000
> FS:  00007fcc9098a6c0(0000) GS:ffff88806b700000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcc90968f28 CR3: 000000001fa0c000 CR4: 0000000000350ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   relocate_block_group+0x8d1/0xe70 fs/btrfs/relocation.c:3782
>   btrfs_relocate_block_group+0x714/0xd90 fs/btrfs/relocation.c:4120
>   btrfs_relocate_chunk+0x143/0x440 fs/btrfs/volumes.c:3277
>   __btrfs_balance fs/btrfs/volumes.c:4012 [inline]
>   btrfs_balance+0x20fc/0x3ef0 fs/btrfs/volumes.c:4389
>   btrfs_ioctl_balance fs/btrfs/ioctl.c:3604 [inline]
>   btrfs_ioctl+0x1362/0x5cf0 fs/btrfs/ioctl.c:4637
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:870 [inline]
>   __se_sys_ioctl fs/ioctl.c:856 [inline]
>   __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fcc8fc7cae9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fcc9098a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fcc8fd9bf80 RCX: 00007fcc8fc7cae9
> RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000005
> RBP: 00007fcc8fcc847a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007fcc8fd9bf80 R15: 00007ffd6ad55508
>   </TASK>
>
>
> Tested on:
>
> commit:         9f2c8c91 btrfs: exit gracefully if reloc roots don't m..
> git tree:       https://github.com/adam900710/linux graceful_reloc_misma=
tch
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D173afb31a800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D23c579cf0ae1=
addd
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dae97a827ae1c33=
36bbb4
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for =
Debian) 2.40
>
> Note: no patches were applied.
