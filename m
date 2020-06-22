Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A13820369E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 14:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgFVMUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 08:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFVMUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:20:51 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD753C061794;
        Mon, 22 Jun 2020 05:20:51 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z2so15636360ilq.0;
        Mon, 22 Jun 2020 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qYErUTZVrsWm+HprKFHr1MapcErFCTe/w/ncrcDLHC0=;
        b=gYE61a8e4TmEm0nHwGRlaOUwFDCdfzfU4X8ZAm55hEWtHMGD3NmoLK1hhBq1zgJfrY
         ipxWr2HLi+N08IMIacKoyFdjeFSZeh3p44+4QA/oqNxeWi1hE4zU+EcNFvUDZYkAxpuR
         Kid5AkaTObt52p8NVobw9LWW8TPo7Dw8wZOswkuaeC6Kn87tgdDf0eGL+Ki8wiMHdgHJ
         bktCGVwz1WFz2+IWDlF54FO/+IhpANjbh5JmyxqFD8lyJTqTRAOgG8JNlMKadIYXQgz8
         i4CHLBUZj2lnd0IfYwdsMnGThiBdArXKlj/8ECcr/W9H2ctKiImzmF9yviarEJujZLds
         JRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qYErUTZVrsWm+HprKFHr1MapcErFCTe/w/ncrcDLHC0=;
        b=ImUWPMXfY9sr4kHX+gm5e8sN+oEdty0WO8TcJnXBTtxUCQh9Frgov5fJm/DnDDb8Ga
         +BG6l2I5tfniiMREkWwPWA2aMBm6xQZ15gNqWAgWYLXQN/Fz3BJeM8RIJ7xRfODch7uD
         VQvQgxCuz+xJffOfZBTgyryw81s2YfE0GybAkDOiAIH6tBEyYgiV3nA9K4rsk5RnoNoo
         YGNxgGetfqb+zFwcL3pj+lkJ+udM06F1oQZuehSR/8pwrRgh2qaWkeB1Cqd3jCIAvgFp
         dFECIjOEaS2uvvX/GGyxxJGHqfJE6yv4dUPXlX/Cz81GaIBusNLbz1+eWv66sI3EIRXU
         Ahdg==
X-Gm-Message-State: AOAM533165qIrGB8+dXAhHS3K0d23+pMZCfjMVYKKsozTUkLhdTHZMZJ
        qnjD/4zRZe/uOE1wWnNxh8ZnT6mtnYyv3DGDKGc=
X-Google-Smtp-Source: ABdhPJyWfR5/Wysh8IYbtLjmCjwT6Sj2VxSZEXLGZdncK+PArH2IPdEj4zfvtSXsyVYIb3Hw+x+wkGrGVnAXTB6rDEQ=
X-Received: by 2002:a05:6e02:13cd:: with SMTP id v13mr16347835ilj.93.1592828450922;
 Mon, 22 Jun 2020 05:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com> <20200622012340.GO5535@shao2-debian>
In-Reply-To: <20200622012340.GO5535@shao2-debian>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 22 Jun 2020 20:20:14 +0800
Message-ID: <CALOAHbDmo7+TcuKtzzNeo8evC=hOtVqOpNr2dMJF2uii30BbsA@mail.gmail.com>
Subject: Re: [xfs] 59d77e81c5: WARNING:at_fs/iomap/buffered-io.c:#iomap_do_writepage
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 9:24 AM kernel test robot <rong.a.chen@intel.com> w=
rote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 59d77e81c5d114f74768d05d4d5faa87232a1efe ("[PATCH v3] xfs: avoid =
deadlock when trigger memory reclaim in ->writepages")
> url: https://github.com/0day-ci/linux/commits/Yafang-Shao/xfs-avoid-deadl=
ock-when-trigger-memory-reclaim-in-writepages/20200615-195749
> base: https://git.kernel.org/cgit/fs/xfs/xfs-linux.git for-next
>
> in testcase: xfstests
> with following parameters:
>
>         disk: 4HDD
>         fs: xfs
>         test: generic-group20
>
> test-description: xfstests is a regression test suite for xfs and other f=
iles ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>
>
> +------------------------------------------------------------------------=
----+------------+------------+
> |                                                                        =
    | 8cc0072469 | 59d77e81c5 |
> +------------------------------------------------------------------------=
----+------------+------------+
> | boot_successes                                                         =
    | 9          | 6          |
> | boot_failures                                                          =
    | 2          | 14         |
> | Kernel_panic-not_syncing:VFS:Unable_to_mount_root_fs_on_unknown-block(#=
,#) | 2          |            |
> | WARNING:at_fs/iomap/buffered-io.c:#iomap_do_writepage                  =
    | 0          | 14         |
> | RIP:iomap_do_writepage                                                 =
    | 0          | 14         |
> | WARNING:at_fs/iomap/direct-io.c:#iomap_dio_actor                       =
    | 0          | 8          |
> | RIP:iomap_dio_actor                                                    =
    | 0          | 8          |
> | Assertion_failed                                                       =
    | 0          | 8          |
> | kernel_BUG_at_fs/xfs/xfs_message.c                                     =
    | 0          | 8          |
> | invalid_opcode:#[##]                                                   =
    | 0          | 8          |
> | RIP:assfail[xfs]                                                       =
    | 0          | 8          |
> | Kernel_panic-not_syncing:Fatal_exception                               =
    | 0          | 8          |
> +------------------------------------------------------------------------=
----+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
>
> [   52.588044] WARNING: CPU: 1 PID: 2062 at fs/iomap/buffered-io.c:1544 i=
omap_do_writepage+0x1d3/0x1f0
> [   52.591594] Modules linked in: xfs libcrc32c dm_mod bochs_drm drm_vram=
_helper drm_ttm_helper ttm sr_mod cdrom drm_kms_helper sg snd_pcm ata_gener=
ic pata_acpi intel_rapl_msr snd_timer syscopyarea ppdev sysfillrect snd sys=
imgblt fb_sys_fops joydev ata_piix soundcore intel_rapl_common drm crc32c_i=
ntel libata serio_raw pcspkr i2c_piix4 parport_pc floppy parport ip_tables
> [   52.602353] CPU: 1 PID: 2062 Comm: fsstress Not tainted 5.7.0-rc4-0013=
1-g59d77e81c5d114 #1
> [   52.605523] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.12.0-1 04/01/2014
> [   52.608722] RIP: 0010:iomap_do_writepage+0x1d3/0x1f0
> [   52.611186] Code: 41 5e 41 5f c3 f6 c2 04 75 24 85 d2 0f 84 54 ff ff f=
f c6 00 00 f6 c2 02 0f 84 48 ff ff ff 31 c9 66 89 4c 10 fe e9 3c ff ff ff <=
0f> 0b eb b7 c7 00 00 00 00 00 c7 44 10 fc 00 00 00 00 e9 25 ff ff
> [   52.618316] RSP: 0018:ffffbe1d42927a98 EFLAGS: 00010206
> [   52.620962] RAX: 0000000000440140 RBX: ffffbe1d42927b18 RCX: 000000000=
0000010
> [   52.624026] RDX: 0000000000000000 RSI: ffffbe1d42927cc8 RDI: fffff7ef4=
74323c0
> [   52.627075] RBP: ffffbe1d42927cc8 R08: ffff9966bffd5000 R09: 000000000=
00323d5
> [   52.630195] R10: 0000000000032380 R11: 000000000000020c R12: fffff7ef4=
74323c0
> [   52.633406] R13: ffffbe1d42927be0 R14: fffff7ef474323c0 R15: ffff99665=
1b56140
> [   52.636616] FS:  00007f0ed0b09b40(0000) GS:ffff9966bfd00000(0000) knlG=
S:0000000000000000
> [   52.639920] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   52.642665] CR2: 000055b70fba1000 CR3: 00000001cbf54000 CR4: 000000000=
00006e0
> [   52.645780] Call Trace:
> [   52.647878]  write_cache_pages+0x171/0x470
> [   52.650230]  ? iomap_write_begin+0x4f0/0x4f0
> [   52.652608]  iomap_writepages+0x1c/0x40
> [   52.656698]  xfs_vm_writepages+0x86/0xc0 [xfs]
> [   52.659277]  do_writepages+0x43/0xe0
> [   52.661535]  __filemap_fdatawrite_range+0xce/0x110
> [   52.664108]  filemap_write_and_wait_range+0x42/0xa0
> [   52.666830]  xfs_setattr_size+0x29d/0x490 [xfs]
> [   52.669419]  ? setattr_prepare+0x6a/0x1d0
> [   52.671908]  xfs_vn_setattr+0x70/0xb0 [xfs]
> [   52.674277]  notify_change+0x357/0x4d0
> [   52.676615]  do_truncate+0x76/0xd0
> [   52.678836]  vfs_truncate+0x161/0x1c0
> [   52.681042]  do_sys_truncate+0x8a/0xa0
> [   52.683473]  do_syscall_64+0x5b/0x1f0
> [   52.685670]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   52.688176] RIP: 0033:0x7f0ed000fe97
> [   52.690338] Code: 00 00 00 48 8b 15 01 60 2b 00 f7 d8 64 89 02 b8 ff f=
f ff ff c3 66 0f 1f 44 00 00 48 89 d6 e9 20 ff ff ff b8 4c 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d1 5f 2b 00 f7 d8 64 89 01 48
> [   52.697406] RSP: 002b:00007ffd47b3b828 EFLAGS: 00000206 ORIG_RAX: 0000=
00000000004c
> [   52.700542] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0ed=
000fe97
> [   52.703615] RDX: 00000000000b7add RSI: 00000000000b7add RDI: 000055b70=
fb9b4b0
> [   52.706522] RBP: 00007ffd47b3b990 R08: 000000000000006a R09: 000000000=
0000003
> [   52.709555] R10: 00000000000002eb R11: 0000000000000206 R12: 000000000=
00b7add
> [   52.712596] R13: 0000000051eb851f R14: 00007ffd47b3be80 R15: 000055b70=
f5bef00
> [   52.715559] ---[ end trace bfc085456879090f ]---
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.7.0-rc4-00131-g59d77e81c5d114 .config
>         make HOSTCC=3Dgcc-9 CC=3Dgcc-9 ARCH=3Dx86_64 olddefconfig prepare=
 modules_prepare bzImage modules
>         make HOSTCC=3Dgcc-9 CC=3Dgcc-9 ARCH=3Dx86_64 INSTALL_MOD_PATH=3D<=
mod-install-dir> modules_install
>         cd <mod-install-dir>
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script =
is attached in this email
>
>
>

Thanks for the report.
That issue has already been addressed in another thread[1] .

[1]. https://lore.kernel.org/linux-xfs/1592222181-9832-1-git-send-email-lao=
ar.shao@gmail.com/

--=20
Thanks
Yafang
