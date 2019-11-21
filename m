Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDB610550E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 16:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKUPEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 10:04:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37797 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUPEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:04:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id d5so3606540ljl.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 07:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=42t7D2wdqGIYRj10Qaxo8l7BzAoA3dpUW1eNQTAzO7Y=;
        b=WtpoPo74m4Twlein8mStNnC4TJiJbteo06x17jRs8PG5JS+zlTWU+XwjLf50KVjxmR
         ixzHeSE8ZfdxC/OIXX8u3jjMi0zP6Mul96c/1jWetshPdx6yxnV7QMJWuBMMuMZzUQeV
         NgqyyRMNOCCflOpmyRIV4t2Mi3seNujBU9xSuu7AYT+kEQxkNbWWETtOPxcS67DmXzIo
         cQffiCB+PPNx5/vqOSVt2jk3kQPJF6gqY6TvrpuvOWyacTOJoUWINwZSGtld5/ttWR3u
         bCvK55i1l7hN5RrWd5wE2qCstbqXTMCgM5CQRLR4y4syzSvQ3c3qAWIB3rgtvciqBMFD
         Xpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=42t7D2wdqGIYRj10Qaxo8l7BzAoA3dpUW1eNQTAzO7Y=;
        b=N3H//kKy8up2uKbXyB8kkj5s3dRqTVD7qqScmPYUR+lMbYwUrhOZ5FqvwekrYY3yvo
         uowxm4Go3jZXKbR3VllQb+SH282PDJNZFELoQbHcXk1cXnyrkMnG2LN0QCO6zjqyMxWB
         5wo0hOe1Pp30N9JIAG8GR1SdBtan4VQSL4/hcIeK1IAg4lK3U5xB+fR6e7vqGdoiBwoY
         k5HZRJhMyBiARfYpCtAk6+GPe9QqWFUJCP3DspKwls39cnVSVUlig0IkQnyCVGmHDBTV
         h9miKjZ2fHZiGNIAPWJ+9T0B3lIZeFKG4prVCsrkC543F37sAbf+a67Z+zn4yjtcqSPz
         GaZw==
X-Gm-Message-State: APjAAAXmc2N5aevP+fRhdsH3NRChzYoTKOm0gyrbujJo9IfaGZbSw7ca
        gT3OTqLPtH0plnpapJLD+StnneewElG9NqUTj/Ssew==
X-Google-Smtp-Source: APXvYqzwt7DlANhxd6ivsX3X2eV5yFA/0+QX1JyvTdHj9eO58mXNgqJ8w1t2WRrVp3TaqXcCRO51NX+TsolYDBFIa/o=
X-Received: by 2002:a05:651c:299:: with SMTP id b25mr8052100ljo.195.1574348680501;
 Thu, 21 Nov 2019 07:04:40 -0800 (PST)
MIME-Version: 1.0
References: <20191121200549.04122bbf@canb.auug.org.au>
In-Reply-To: <20191121200549.04122bbf@canb.auug.org.au>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Nov 2019 20:34:29 +0530
Message-ID: <CA+G9fYsrRw2SRb92eROCt6aU==j6Qr9Fe4AmJyn4fMj5gDFt=w@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 21
To:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        lkft-triage@lists.linaro.org, Tejun Heo <tj@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Results from Linaro=E2=80=99s test farm.
Regressions detected on x86_64.

On Thu, 21 Nov 2019 at 14:36, Stephen Rothwell <sfr@canb.auug.org.au> wrote=
:
>
> Hi all,
>
> Changes since 20191120:
>
> The arm64 tree gained a conflict against the arm64-fixes tree.
>
> The net-next tree gained a conflict against the net tree.
>
> The tip tree gained a conflict against the nfsd tree and a semantic
> conflict against the drm tree.
>
> The ftrace tree gained a conflict against the tip tree.
>
> Non-merge commits (relative to Linus' tree): 11984
>  10573 files changed, 519935 insertions(+), 230163 deletions(-)
>
> -------------------------------------------------------------------------=
---
>
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git


[    4.153683] printk: console [netcon0] enabled
[    4.158053] netconsole: network logging started
[    4.163783] sd 2:0:0:0: [sda] Attached SCSI disk
[    4.189026] BUG: kernel NULL pointer dereference, address: 0000000000000=
090
[    4.195991] #PF: supervisor read access in kernel mode
[    4.201127] #PF: error_code(0x0000) - not-present page
[    4.206260] PGD 0 P4D 0
[    4.208800] Oops: 0000 [#1] SMP PTI
[    4.212291] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
5.4.0-rc8-next-20191121 #1
[    4.219673] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[    4.227149] RIP: 0010:kernfs_find_ns+0x1f/0x120
[    4.231679] Code: fe ff ff 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
55 48 89 e5 41 57 41 56 41 55 41 54 49 89 d5 53 49 89 ff 49 89 f6 48
83 ec 08 <44> 0f b7 a7 90 00 00 00 8b 05 d7 6c 84 01 48 8b 5f 68 66 41
83 e4
[    4.250415] RSP: 0000:ffffb75580027ba0 EFLAGS: 00010286
[    4.255632] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff891=
c0d55
[    4.262756] RDX: 0000000000000000 RSI: ffffffff892be782 RDI: 00000000000=
00000
[    4.269881] RBP: ffffb75580027bd0 R08: ffffffff87de4e75 R09: 00000000000=
00001
[    4.277005] R10: ffffb75580027bd0 R11: 0000000000000001 R12: ffffffff892=
be782
[    4.284129] R13: 0000000000000000 R14: ffffffff892be782 R15: 00000000000=
00000
[    4.291251] FS:  0000000000000000(0000) GS:ffff8c4fdfa80000(0000)
knlGS:0000000000000000
[    4.299329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.305066] CR2: 0000000000000090 CR3: 0000000073a10001 CR4: 00000000003=
606e0
[    4.312190] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    4.319315] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    4.326437] Call Trace:
[    4.328886]  kernfs_find_and_get_ns+0x33/0x60
[    4.333243]  sysfs_remove_group+0x2a/0x90
[    4.337256]  netdev_queue_update_kobjects+0xc6/0x150
[    4.342221]  netif_set_real_num_tx_queues+0x7e/0x230
[    4.347178]  ? igb_configure_msix+0xde/0x170
[    4.351443]  __igb_open+0x19e/0x5e0
[    4.354937]  igb_open+0x10/0x20
[    4.358081]  __dev_open+0xda/0x170
[    4.361478]  __dev_change_flags+0x17f/0x1d0
[    4.365658]  dev_change_flags+0x29/0x60
[    4.369497]  ip_auto_config+0x2b9/0xfbb
[    4.373333]  ? tcp_set_default_congestion_control+0xac/0x140
[    4.378986]  ? root_nfs_parse_addr+0xa5/0xa5
[    4.383258]  ? set_debug_rodata+0x17/0x17
[    4.387270]  do_one_initcall+0x61/0x2ea
[    4.391098]  ? do_one_initcall+0x61/0x2ea
[    4.395103]  ? set_debug_rodata+0x17/0x17
[    4.399108]  ? rcu_read_lock_sched_held+0x4f/0x80
[    4.403807]  kernel_init_freeable+0x1ce/0x261
[    4.408164]  ? rest_init+0x250/0x250
[    4.411737]  kernel_init+0xe/0x110
[    4.415143]  ret_from_fork+0x3a/0x50
[    4.418724] Modules linked in:
[    4.421781] CR2: 0000000000000090
[    4.425093] ---[ end trace 4a9e2dba4e956a47 ]---
[    4.429710] RIP: 0010:kernfs_find_ns+0x1f/0x120
[    4.434233] Code: fe ff ff 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
55 48 89 e5 41 57 41 56 41 55 41 54 49 89 d5 53 49 89 ff 49 89 f6 48
83 ec 08 <44> 0f b7 a7 90 00 00 00 8b 05 d7 6c 84 01 48 8b 5f 68 66 41
83 e4
[    4.452970] RSP: 0000:ffffb75580027ba0 EFLAGS: 00010286
[    4.458189] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff891=
c0d55
[    4.465311] RDX: 0000000000000000 RSI: ffffffff892be782 RDI: 00000000000=
00000
[    4.472435] RBP: ffffb75580027bd0 R08: ffffffff87de4e75 R09: 00000000000=
00001
[    4.479559] R10: ffffb75580027bd0 R11: 0000000000000001 R12: ffffffff892=
be782
[    4.486684] R13: 0000000000000000 R14: ffffffff892be782 R15: 00000000000=
00000
[    4.493809] FS:  0000000000000000(0000) GS:ffff8c4fdfa80000(0000)
knlGS:0000000000000000
[    4.501885] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.507620] CR2: 0000000000000090 CR3: 0000000073a10001 CR4: 00000000003=
606e0
[    4.514745] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    4.521869] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    4.528994] BUG: sleeping function called from invalid context at
/usr/src/kernel/include/linux/percpu-rwsem.h:38
[    4.539239] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid:
1, name: swapper/0
[    4.547056] INFO: lockdep is turned off.
[    4.550973] irq event stamp: 1299518
[    4.554542] hardirqs last  enabled at (1299517):
[<ffffffff8887bb61>] _raw_spin_unlock_irqrestore+0x31/0x50
[    4.564268] hardirqs last disabled at (1299518):
[<ffffffff87a01e2b>] trace_hardirqs_off_thunk+0x1a/0x1c
[    4.573732] softirqs last  enabled at (1297328):
[<ffffffff88c00338>] __do_softirq+0x338/0x43a
[    4.582339] softirqs last disabled at (1297319):
[<ffffffff87b003c8>] irq_exit+0xb8/0xc0
[    4.590422] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G      D
  5.4.0-rc8-next-20191121 #1
[    4.599193] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[    4.606663] Call Trace:
[    4.609108]  dump_stack+0x7a/0xa5
[    4.612418]  ___might_sleep+0x163/0x250
[    4.616251]  __might_sleep+0x4a/0x80
[    4.619831]  exit_signals+0x33/0x2d0
[    4.623407]  ? rcu_read_lock_sched_held+0x4f/0x80
[    4.628105]  do_exit+0xb6/0xcd0
[    4.631242]  ? kernel_init_freeable+0x1ce/0x261
[    4.635766]  ? rest_init+0x250/0x250
[    4.639339]  rewind_stack_do_exit+0x17/0x20
[    4.643644] Kernel panic - not syncing: Attempted to kill init!
exitcode=3D0x00000009
[    4.651332] Kernel Offset: 0x6a00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

ref:
https://lkft.validation.linaro.org/scheduler/job/1017506#L896

Summary
------------------------------------------------------------------------
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
  git commit: 9942eae47585ee056b140bbfa306f6a1d6b8f383
  git describe: next-20191121
  make_kernelversion: 5.4.0-rc8
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkf=
t/linux-next/651/config
  build-location:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkf=
t/linux-next/651

--=20
Linaro LKFT
https://lkft.linaro.org
