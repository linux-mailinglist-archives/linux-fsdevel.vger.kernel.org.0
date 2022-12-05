Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F158F642A71
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 15:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiLEOef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 09:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLEOed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:34:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06EE186D5;
        Mon,  5 Dec 2022 06:34:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bs21so18892007wrb.4;
        Mon, 05 Dec 2022 06:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cztX5Ue33tQ3eMiQbG6qcXAJ75+hHLZXrTtuSbFa9F4=;
        b=W6c7NEmuUfQ8+4lVrVaU30vp1q9GAU4udyMiNHpVxYgcTRjmuxC+EdB/ZxPzS8KgVn
         Q7XDq3N0jwMv11o6peTlai0RfxlTsi2Tlnz9SIMipmlrTwoeR/UdWSHdx1hFzEBnMP+g
         v5FdXm1oIEo7kSEvGR7zxd6e9qU6Sgy7I07ttKGqPME3YpqVrK0neqoMzrTSu9kZNhLq
         CIjTVJD5+X7p/tANcaopIqE99Txa12m3rWtKeE5QJHDoeMmSmBReqoMK/PP3Ng4F6RKM
         KysKaspO9sj/ujAeZOVhwEHd9vrB6NYttrO83hdHsvVfwQoya/IxYcPGrFldAq4T/W2Y
         MXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cztX5Ue33tQ3eMiQbG6qcXAJ75+hHLZXrTtuSbFa9F4=;
        b=UHPgqDX4x1nbweQIbIyOX3ZMUl+wE3FQk4VXafUGaZALxlFJsnAYp1ArY/vPxPkQWR
         8lJpjCBrpuTIBhc+Cg5gNYo1PJq3Wknj7+TR41RJt8k2FuTyg2UpkmHrrqE+6F0uyQKa
         WZnU52SJ/tPRx5H7nw+dbct3gtB46N/b8Uya3rgn7HbIkF/GCfsdYKCYJGmIzx3j02Rj
         MEnfq2J9J3xQ+LZMSbfGKKXbHlsYgl/b6CYjyXMJAgZ650l7W7ukZGMQp3ASy9PhVRXu
         921P2wJloUEWw7hL2uEq0aPgLsR3nnIziHZheZ4dwyk839zF+/lgFW7ZYMzf2WOd03wy
         0czA==
X-Gm-Message-State: ANoB5pmIRIU+7D5e1Drwk/N8dDNzjkP65KPC1OoHK3WUI8YkDIdiU0h4
        rz0cqN3sIJuqHEOlPijLD2l53aMae3hGwmDnFSxN7uuzaixdrH5n
X-Google-Smtp-Source: AA0mqf563T7zMkt+85nHmLQqY3CwK5GpWtZ5WrXRuMZ0xJ2xp8EQiLwr9FtYo8v8YQPI1dZl/gaDFRWmLb6o3RZDxdY=
X-Received: by 2002:a5d:51ce:0:b0:236:78cd:f3e7 with SMTP id
 n14-20020a5d51ce000000b0023678cdf3e7mr48591560wrv.140.1670250870227; Mon, 05
 Dec 2022 06:34:30 -0800 (PST)
MIME-Version: 1.0
References: <CAHnGgyHAo+XQPchU4HaKshFbnyHYuD0EuHy17QvPRAZ4MFVq-w@mail.gmail.com>
 <20221129102524.ulsthvmf6tbfwhmb@wittgenstein> <CAHnGgyEQjcGSDPC=k-ikGQC460jov2bum0AzjD+Jm-8fDwXGbg@mail.gmail.com>
In-Reply-To: <CAHnGgyEQjcGSDPC=k-ikGQC460jov2bum0AzjD+Jm-8fDwXGbg@mail.gmail.com>
From:   ditang chen <ditang.c@gmail.com>
Date:   Mon, 5 Dec 2022 22:34:19 +0800
Message-ID: <CAHnGgyEX9ZnK6FabDOs8=Y_kCX=QkhTiryW4AQDURaepJWNh6w@mail.gmail.com>
Subject: Re: fs/pnode.c: propagate_one Oops in ltp/fs_bind test
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cc linux-fsdevel@vger.kernel.org linux-kernel@vger.kernel.org

ditang chen <ditang.c@gmail.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=884=E6=97=
=A5=E5=91=A8=E6=97=A5 23:46=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your reply ~~
>
> In the second step, it's easier to reproduce using the following script=
=EF=BC=9A
> # cat /opt/ltp/testcases/bin/fs_bind24.sh
> #!/bin/sh
> FS_BIND_TESTFUNC=3Dtest
>
> test()
> {
>         tst_res TINFO "bind: shared child to shared parent"
>
>         fs_bind_makedir rshared dir1
>         mkdir dir1/1 dir1/1/2 dir1/1/2/3 dir1/1/2/fs_bind_check dir2 dir3=
 dir4
>         touch dir4/ls
>
>         EXPECT_PASS mount --bind dir1/1/2 dir2
>         EXPECT_PASS mount --make-rslave dir1
>         EXPECT_PASS mount --make-rshared dir1
>
>         EXPECT_PASS mount --bind dir1/1/2/3 dir3
>         EXPECT_PASS mount --make-rslave dir1
>
>         while true
>         do
>                 EXPECT_PASS mount --bind dir4 dir2/fs_bind_check
>                 EXPECT_PASS umount dir2/fs_bind_check
>         done
>
>         fs_bind_check dir1/1/2/fs_bind_check/ dir4
>
>         EXPECT_PASS umount dir2/fs_bind_check
>         EXPECT_PASS umount dir3
>         EXPECT_PASS umount dir2
>         EXPECT_PASS umount dir1
> }
>
> . fs_bind_lib.sh
> tst_run
>
> And then=EF=BC=8Crun netns.sh while running fs_bind:
> # /opt/ltp/runltp -f fs_bind
>
> Here is a reproducer in 6.1.0-rc7:
> [  115.848393] BUG: kernel NULL pointer dereference, address: 00000000000=
00010
> [  115.848967] #PF: supervisor read access in kernel mode
> [  115.849386] #PF: error_code(0x0000) - not-present page
> [  115.849803] PGD 0 P4D 0
> [  115.850012] Oops: 0000 [#1] PREEMPT SMP PTI
> [  115.850354] CPU: 0 PID: 15591 Comm: mount Not tainted 6.1.0-rc7 #3
> [  115.850851] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006
> [  115.851510] RIP: 0010:propagate_one.part.0+0x7f/0x1a0
> [  115.851924] Code: 75 eb 4c 8b 05 c2 25 37 02 4c 89 ca 48 8b 4a 10
> 49 39 d0 74 1e 48 3b 81 e0 00 00 00 74 26 48 8b 92 e0 00 00 00 be 01
> 00 00 00 <48> 8b 4a 10 49 39 d0 75 e2 40 84 f6 74 38 4c 89 05 84 25 37
> 02 4d
> [  115.853441] RSP: 0018:ffffb8d5443d7d50 EFLAGS: 00010282
> [  115.853865] RAX: ffff8e4d87c41c80 RBX: ffff8e4d88ded780 RCX: ffff8e4da=
4333a00
> [  115.854458] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8e4d8=
8ded780
> [  115.855044] RBP: ffff8e4d88ded780 R08: ffff8e4da4338000 R09: ffff8e4da=
43388c0
> [  115.855693] R10: 0000000000000002 R11: ffffb8d540158000 R12: ffffb8d54=
43d7da8
> [  115.856304] R13: ffff8e4d88ded780 R14: 0000000000000000 R15: 000000000=
0000000
> [  115.856859] FS:  00007f92c90c9800(0000) GS:ffff8e4dfdc00000(0000)
> knlGS:0000000000000000
> [  115.857531] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  115.858006] CR2: 0000000000000010 CR3: 0000000022f4c002 CR4: 000000000=
00706f0
> [  115.858598] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  115.859393] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  115.860099] Call Trace:
> [  115.860358]  <TASK>
> [  115.860535]  propagate_mnt+0x14d/0x190
> [  115.860848]  attach_recursive_mnt+0x274/0x3e0
> [  115.861212]  path_mount+0x8c8/0xa60
> [  115.861503]  __x64_sys_mount+0xf6/0x140
> [  115.861819]  do_syscall_64+0x5b/0x80
> [  115.862117]  ? do_faccessat+0x123/0x250
> [  115.862435]  ? syscall_exit_to_user_mode+0x17/0x40
> [  115.862826]  ? do_syscall_64+0x67/0x80
> [  115.863133]  ? syscall_exit_to_user_mode+0x17/0x40
> [  115.863527]  ? do_syscall_64+0x67/0x80
> [  115.863835]  ? do_syscall_64+0x67/0x80
> [  115.864144]  ? do_syscall_64+0x67/0x80
> [  115.864452]  ? exc_page_fault+0x70/0x170
> [  115.864775]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  115.865187] RIP: 0033:0x7f92c92b0ebe
> [  115.865480] Code: 48 8b 0d 75 4f 0c 00 f7 d8 64 89 01 48 83 c8 ff
> c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 42 4f 0c 00 f7 d8 64 89
> 01 48
> [  115.866984] RSP: 002b:00007fff000aa728 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a5
> [  115.867607] RAX: ffffffffffffffda RBX: 000055a77888d6b0 RCX: 00007f92c=
92b0ebe
> [  115.868240] RDX: 000055a77888d8e0 RSI: 000055a77888e6e0 RDI: 000055a77=
888e620
> [  115.868823] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
0000001
> [  115.869403] R10: 0000000000001000 R11: 0000000000000246 R12: 000055a77=
888e620
> [  115.869994] R13: 000055a77888d8e0 R14: 00000000ffffffff R15: 00007f92c=
93e4076
> [  115.870581]  </TASK>
> [  115.870763] Modules linked in: nft_fib_inet nft_fib_ipv4
> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
> nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 ip_set rfkill nf_tables nfnetlink qrtr snd_intel8x0
> sunrpc snd_ac97_codec ac97_bus snd_pcm snd_timer intel_rapl_msr
> intel_rapl_common snd vboxguest intel_powerclamp video rapl joydev
> soundcore i2c_piix4 wmi fuse zram xfs vmwgfx crct10dif_pclmul
> crc32_pclmul crc32c_intel polyval_clmulni polyval_generic
> drm_ttm_helper ttm e1000 ghash_clmulni_intel serio_raw ata_generic
> pata_acpi scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath
> [  115.875288] CR2: 0000000000000010
> [  115.875641] ---[ end trace 0000000000000000 ]---
> [  115.876135] RIP: 0010:propagate_one.part.0+0x7f/0x1a0
> [  115.876551] Code: 75 eb 4c 8b 05 c2 25 37 02 4c 89 ca 48 8b 4a 10
> 49 39 d0 74 1e 48 3b 81 e0 00 00 00 74 26 48 8b 92 e0 00 00 00 be 01
> 00 00 00 <48> 8b 4a 10 49 39 d0 75 e2 40 84 f6 74 38 4c 89 05 84 25 37
> 02 4d
> [  115.878086] RSP: 0018:ffffb8d5443d7d50 EFLAGS: 00010282
> [  115.878511] RAX: ffff8e4d87c41c80 RBX: ffff8e4d88ded780 RCX: ffff8e4da=
4333a00
> [  115.879128] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8e4d8=
8ded780
> [  115.879715] RBP: ffff8e4d88ded780 R08: ffff8e4da4338000 R09: ffff8e4da=
43388c0
> [  115.880359] R10: 0000000000000002 R11: ffffb8d540158000 R12: ffffb8d54=
43d7da8
> [  115.880962] R13: ffff8e4d88ded780 R14: 0000000000000000 R15: 000000000=
0000000
> [  115.881548] FS:  00007f92c90c9800(0000) GS:ffff8e4dfdc00000(0000)
> knlGS:0000000000000000
> [  115.882234] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  115.882713] CR2: 0000000000000010 CR3: 0000000022f4c002 CR4: 000000000=
00706f0
> [  115.883314] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  115.883966] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
>
> Best regards,
> --
>
>
> Christian Brauner <brauner@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=882=
9=E6=97=A5=E5=91=A8=E4=BA=8C 18:25=E5=86=99=E9=81=93=EF=BC=9A
>
>
> >
> > On Tue, Nov 15, 2022 at 11:04:01PM +0800, ditang chen wrote:
> > > Here is a reproducer:
> > > 1. Run netns.sh script in loop
> > > # while true; do ./netns.sh; done
> > > # cat netns.sh
> > > #!/bin/bash
> > > num=3D1000
> > > function create_netns()
> > > {
> > > for((i=3D0; i<$num; i++))
> > > do
> > >   ip netns add local$i
> > >   ip netns exec local$i pwd &
> > > done
> > > }
> > > function clean_netns()
> > > {
> > > for((i=3D0; i<$num; i++))
> > > do
> > >     ip netns del local$i
> > > done
> > > }
> > > create_netns
> > > clean_netns
> > >
> > > 2.  run fs_bind/fs_bind24 in loop, fs_bind24 only
> > > # cat /opt/ltp/runtest/fs_bind
> > > #DESCRIPTION:Bind mounts and shared subtrees
> > > fs_bind24_sh fs_bind24.sh
> > > # while true; do /opt/ltp/runltp -f fs_bind; done
> > >
> > > This oops also exists in the latest kernel code=EF=BC=9A
> >
> > I've been running this since yesterday on v6.1-rc7 to reproduce and it
> > didn't trigger. It's unclear whether you're saying that you've managed
> > to reproduce this on mainline. It doesn't seem to be.
