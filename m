Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DC83C7D20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 05:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhGNEAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 00:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229850AbhGNEAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 00:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626235051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y9QvDv09QA6mu12KBeZ/DpHpTjLAasre0eaQPq/jn+A=;
        b=Df0x0RiS8MGbjqP0GYkGpu/pW0a7wgTbuvTv7x0LOcPlh25iqptHL0kOSba8n9N2gELZjA
        xo4+lLtvKTYju3IUSiSTQ2j1hC9Mzw4ivSQJuVS9FoNujHo8fy/uGDaKaN71mX8aXuLG/w
        lPTxdFzFi9A+U+L/UZ3KIdrP99Bg9NE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-ZxJXg6eVPKOg1Guvok-i2A-1; Tue, 13 Jul 2021 23:57:30 -0400
X-MC-Unique: ZxJXg6eVPKOg1Guvok-i2A-1
Received: by mail-pf1-f200.google.com with SMTP id t18-20020a056a001392b02903039eb2e663so671457pfg.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 20:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9QvDv09QA6mu12KBeZ/DpHpTjLAasre0eaQPq/jn+A=;
        b=DlA5K2Qu2MFwgJemUmH0NJ9htWdmu9QULc8ZkWV4ZCkQIR1XBOIepYGvh0bARtIebk
         FsIe67IE4N9+vuUBE+651ejRgdr/kw17AKQbcncV61HXSnv7PmkGSogrU83bKCYuieCd
         uL65rhQIOSgpUds2JILhaZqdiXoKeSPvv1wy5hkpJBCzAmA5k9OUgiz/+ccWNOfMwXQD
         Ovl4pg7YazTpGuvzSQy3Bg6ycC/ngGr/ytOWZ0gNKAF3NCoAqRv/XaBoq3PPeCbbx/63
         mx4UP/Z40m09CZvlLbFpYaTMkJ2uBo3HwA7Yip6wJzNEyZCKxER+/A/yFB0Z5Hz0sF7P
         7gpw==
X-Gm-Message-State: AOAM533AWiKvURvalNPsFQLptWpjnSsUUwJG0Ik9kd7wey5xgW8e1WFc
        tyVWkurUB/vLNmS5FLydWoFNqNmY/7oe+99TJxjSEZXCNZrJS5l9Fc3Yy7qfpj/S17GERDMLT1L
        3mHpVqbuP0qndnMyIR4IUZto43TFKhgHT1SZ/PB15nw==
X-Received: by 2002:a17:903:4051:b029:12a:181c:9305 with SMTP id n17-20020a1709034051b029012a181c9305mr6202368pla.25.1626235048633;
        Tue, 13 Jul 2021 20:57:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSFtkzlX2ZNmcuVoQUGD9GUEZQcfWg5biFjZBVAqu+zvPOJXJD2W/w9XIsLe1R0BaEMacgcJbuYA4MVLwILCQ=
X-Received: by 2002:a17:903:4051:b029:12a:181c:9305 with SMTP id
 n17-20020a1709034051b029012a181c9305mr6202358pla.25.1626235048329; Tue, 13
 Jul 2021 20:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
In-Reply-To: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
From:   Boyang Xue <bxue@redhat.com>
Date:   Wed, 14 Jul 2021 11:57:17 +0800
Message-ID: <CAHLe9YbCCS=W7Uj-QSoG4fMRR8f9Kp=2MYEPuZMVPMHpiSZxPg@mail.gmail.com>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
To:     linux-fsdevel@vger.kernel.org
Cc:     guro@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 11:21 AM Boyang Xue <bxue@redhat.com> wrote:
>
> Hello,
>
> I'm not sure if this is the right place to report this bug, please
> correct me if I'm wrong.
>
> I found kernel-5.14.0-rc1 (built from the Linus tree) crash when it's
> running xfstests generic/256 on ext4 [1]. Looking at the call trace,
> it looks like the bug had been introduced by the commit
>
> c22d70a162d3 writeback, cgroup: release dying cgwbs by switching attached inodes
>
> It only happens on aarch64, not on x86_64, ppc64le and s390x. Testing

Correction: It only happens on aarch64 and ppc64le, not on x86_64 and s390x.

> was performed with the latest xfstests, and the bug can be reproduced
> on ext{2, 3, 4} with {1k, 2k, 4k} block sizes.
>
> Thanks,
> Boyang
>
> 1. dmesg
> ```
> [ 4366.380974] run fstests generic/256 at 2021-07-12 05:41:40
> [ 4368.337078] EXT4-fs (vda3): mounted filesystem with ordered data
> mode. Opts: . Quota mode: none.
> [ 4371.275986] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [ 4371.278210] Mem abort info:
> [ 4371.278880]   ESR = 0x96000005
> [ 4371.279603]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 4371.280878]   SET = 0, FnV = 0
> [ 4371.281621]   EA = 0, S1PTW = 0
> [ 4371.282396]   FSC = 0x05: level 1 translation fault
> [ 4371.283635] Data abort info:
> [ 4371.284333]   ISV = 0, ISS = 0x00000005
> [ 4371.285246]   CM = 0, WnR = 0
> [ 4371.285975] user pgtable: 64k pages, 48-bit VAs, pgdp=00000000b0502000
> [ 4371.287640] [0000000000000000] pgd=0000000000000000,
> p4d=0000000000000000, pud=0000000000000000
> [ 4371.290016] Internal error: Oops: 96000005 [#1] SMP
> [ 4371.291251] Modules linked in: dm_flakey dm_snapshot dm_bufio
> dm_zero dm_mod loop tls rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver
> nfs lockd grace fscache netfs rfkill sunrpc ext4 vfat fat mbcache jbd2
> drm fuse xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64
> sha1_ce virtio_blk virtio_net net_failover virtio_console failover
> virtio_mmio aes_neon_bs [last unloaded: scsi_debug]
> [ 4371.300059] CPU: 0 PID: 408468 Comm: kworker/u8:5 Tainted: G
>        X --------- ---  5.14.0-0.rc1.15.bx.el9.aarch64 #1
> [ 4371.303009] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [ 4371.304685] Workqueue: events_unbound cleanup_offline_cgwbs_workfn
> [ 4371.306329] pstate: 004000c5 (nzcv daIF +PAN -UAO -TCO BTYPE=--)
> [ 4371.307867] pc : cleanup_offline_cgwbs_workfn+0x320/0x394
> [ 4371.309254] lr : cleanup_offline_cgwbs_workfn+0xe0/0x394
> [ 4371.310597] sp : ffff80001554fd10
> [ 4371.311443] x29: ffff80001554fd10 x28: 0000000000000000 x27: 0000000000000001
> [ 4371.313320] x26: 0000000000000000 x25: 00000000000000e0 x24: ffffd2a2fbe671a8
> [ 4371.315159] x23: ffff80001554fd88 x22: ffffd2a2fbe67198 x21: ffffd2a2fc25a730
> [ 4371.316945] x20: ffff210412bc3000 x19: ffff210412bc3280 x18: 0000000000000000
> [ 4371.318690] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [ 4371.320437] x14: 0000000000000000 x13: 0000000000000030 x12: 0000000000000040
> [ 4371.322444] x11: ffff210481572238 x10: ffff21048157223a x9 : ffffd2a2fa276c60
> [ 4371.324243] x8 : ffff210484106b60 x7 : 0000000000000000 x6 : 000000000007d18a
> [ 4371.326049] x5 : ffff210416a86400 x4 : ffff210412bc0280 x3 : 0000000000000000
> [ 4371.327898] x2 : ffff80001554fd88 x1 : ffff210412bc0280 x0 : 0000000000000003
> [ 4371.329748] Call trace:
> [ 4371.330372]  cleanup_offline_cgwbs_workfn+0x320/0x394
> [ 4371.331694]  process_one_work+0x1f4/0x4b0
> [ 4371.332767]  worker_thread+0x184/0x540
> [ 4371.333732]  kthread+0x114/0x120
> [ 4371.334535]  ret_from_fork+0x10/0x18
> [ 4371.335440] Code: d63f0020 97f99963 17ffffa6 f8588263 (f9400061)
> [ 4371.337174] ---[ end trace e250fe289272792a ]---
> [ 4371.338365] Kernel panic - not syncing: Oops: Fatal exception
> [ 4371.339884] SMP: stopping secondary CPUs
> [ 4372.424137] SMP: failed to stop secondary CPUs 0-2
> [ 4372.436894] Kernel Offset: 0x52a2e9fa0000 from 0xffff800010000000
> [ 4372.438408] PHYS_OFFSET: 0xfff0defca0000000
> [ 4372.439496] CPU features: 0x00200251,23200840
> [ 4372.440603] Memory Limit: none
> [ 4372.441374] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
> ```

