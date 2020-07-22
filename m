Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA622929A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 09:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgGVHyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 03:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVHyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:54:18 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B027C0619DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 00:54:18 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id r7so366428vkf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 00:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wp7cLzalHd7kyU2cYcp7xvtQkBGEmVbye1wtB/k/l3Y=;
        b=S8luBJgFvit1zlJAsvYPv7f4ldEkJxzK4yZgF7GfFM/4xtumiUsYejg+P0RIR9DhzM
         E1qS0MG45c/nt05/BhOxdDQBOd1TxDqyormzXUBTLmnWGjcwQDVNG2G6tVwnsdiZuMwt
         aYdd17W2oDqlJpO91CX0F/ahwuFwop1WBJo9CIvjUVn+ep+q1VpisrVR0zTcsYXB8KPf
         N925FbxN/tIezpMA1LDKX7myH0ukvNCKsYDrKKGKx6jR4HrojU3hYnwI7/rC2Gu3XeWM
         02iPK2J0C7L3JtN3CdZkmZDIE1ECee4DMsrv0he+z2gBNLOJjB7UflrzQTNQTMicLjnQ
         OdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wp7cLzalHd7kyU2cYcp7xvtQkBGEmVbye1wtB/k/l3Y=;
        b=ZytDUw3Jg0DBZHJz0hqBMMe1ADKfsfVeF1SV8hCWkDyEDhWNuooNCBhAHkx/EvUox7
         pXW9fcgboktozv8+EcRVFwYVaS5cjSngWSZcczYYnkeXJpZMBfT7JXRjcUXVK3nODbN4
         cJHgMntZmqWZ8zyxTbFsZ0SDl/In9ryC4ceNiLm8wJaPDf3r8k+IDOJzyfL5R4NCqzzU
         5idbXjeLTb41br2UCnMt8+/dePnmRx8uIz1CoAbMTKFlS4JKV8wcOwiHM1l1dJK1o3fn
         vT9oGaEsdb66bJg6QnSn07BjGs+4VzlWZi6WQAbEN10v3sbCAH33OsihcGGzqNKrK5dK
         YYkA==
X-Gm-Message-State: AOAM531FSgyfq9cUbuPfDwzsYA3X0fIuQFG5B8V0tm+Gw5ZxWo6Uu96m
        0ddGoc9NHZnoqd+u/vZOAAWMz3Q/Wv760HHVSTFtUw==
X-Google-Smtp-Source: ABdhPJwpJE6nZ/4uqieQIpxG0DaJE1P7Dq3awxlUKdO1z6CLKIW3zUuJaPsYiyFK6Av4UUwsn3sIaI+KyweJiz6gKUE=
X-Received: by 2002:a1f:5e14:: with SMTP id s20mr17461433vkb.63.1595404456374;
 Wed, 22 Jul 2020 00:54:16 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 22 Jul 2020 13:24:05 +0530
Message-ID: <CA+G9fYvUOTWJdPpUM=_ciPbZ+roQBBnjH6aJffWwUfeFG2OGwg@mail.gmail.com>
Subject: WARNING: fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, walter-zh.wu@mediatek.com,
        neeraju@codeaurora.org, Vinod Koul <vinod.koul@linaro.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kernel WARNING noticed on arm64 db410c device while booting linux next
20200721 tag.
Kernel BUGs followed by kernel WARNINGS noticed on this db410c device.

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: de2e69cfe54a8f2ed4b75f09d3110c514f45d38e
  git describe: next-20200721
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-next/818/config
  build-location:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-next/818

Crash log:
[    5.802135] ------------[ cut here ]------------
[    5.802509] l12: supplied by regulator-dummy
[    5.805901] kernfs: can not remove 'supplier:regulator.14', no directory
[    5.810782] l12: Bringing 0uV into 1750000-1750000uV
[    5.814789] WARNING: CPU: 3 PID: 164 at
/usr/src/kernel/fs/kernfs/dir.c:1508
kernfs_remove_by_name_ns+0xb0/0xc0
[    5.823085] l13: supplied by regulator-dummy
[    5.826334] Modules linked in:
[    5.826354] CPU: 3 PID: 164 Comm: kworker/3:2 Tainted: G        W
      5.8.0-rc6-next-20200721 #1
[    5.826363] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    5.826378] Workqueue: rcu_gp srcu_invoke_callbacks
[    5.826396] pstate: 80000005 (Nzcv daif -PAN -UAO BTYPE=--)
[    5.826409] pc : kernfs_remove_by_name_ns+0xb0/0xc0
[    5.836530] l13: Bringing 0uV into 1750000-1750000uV
[    5.840651] lr : kernfs_remove_by_name_ns+0xb0/0xc0
[    5.840659] sp : ffff800014093be0
[    5.840667] x29: ffff800014093be0 x28: 0000000000000000
[    5.840688] x27: ffff8000101c42cc x26: ffff8000101c42cc
[    5.840708] x25: ffff8000129fee68 x24: ffff00003fcb7640
[    5.845080] l14: supplied by regulator-dummy
[    5.852811] x23: ffff00003fcb76c0 x22: 0000000000000000
[    5.852831] x21: ffff00003a5cb400 x20: 0000000000000000
[    5.852851] x19: ffff00003a604018 x18: ffffffffffffffff
[    5.852875] x17: 0000000000000000
[    5.859830] l14: Bringing 0uV into 1750000-1750000uV
[    5.864089] x16: 0000000000000000
[    5.864102] x15: ffff800012720a88 x14: ffff800094093877
[    5.864123] x13: ffff800014093885 x12: 0000000000000003
[    5.864143] x11: 0000000005f5e0ff x10: 0000000000000000
[    5.871315] l15: supplied by regulator-dummy
[    5.874505] x9 : ffff800012720a88 x8 : 0000000018bc90a0
[    5.874526] x7 : 00000000b9433f15 x6 : ffff800014093820
[    5.874546] x5 : ffff800012721000 x4 : 0000000000000003
[    5.874566] x3 : 0000000000000004 x2 : 0000000000000201
[    5.880082] l15: Bringing 0uV into 1750000-1750000uV
[    5.884311] x1 : b2684f8263e0e600 x0 : 0000000000000000
[    5.884333] Call trace:
[    5.884346]  kernfs_remove_by_name_ns+0xb0/0xc0
[    5.884358]  sysfs_remove_link+0x30/0x60
[    5.884371]  devlink_remove_symlinks+0xa8/0x138
[    5.884382]  device_del+0xf4/0x3c0
[    5.890179] l16: supplied by regulator-dummy
[    5.893172]  device_unregister+0x24/0x78
[    5.893182]  __device_link_free_srcu+0x64/0x70
[    5.898780] l16: Bringing 0uV into 1750000-1750000uV
[    5.903762]  srcu_invoke_callbacks+0x10c/0x1a0
[    5.903773]  process_one_work+0x2b0/0x768
[    5.903783]  worker_thread+0x48/0x498
[    5.903795]  kthread+0x158/0x168
[    5.903806]  ret_from_fork+0x10/0x1c
[    5.903815] irq event stamp: 18695
[    5.909658] l17: supplied by regulator-dummy
[    5.913312] hardirqs last  enabled at (18694): [<ffff800010083318>]
el1_irq+0xd8/0x180
[    5.913325] hardirqs last disabled at (18695): [<ffff8000100aaebc>]
debug_exception_enter+0xac/0xe8
[    5.913337] softirqs last  enabled at (18614): [<ffff8000101c42cc>]
srcu_invoke_callbacks+0xf4/0x1a0
[    5.913349] softirqs last disabled at (18652): [<ffff8000101c42cc>]
srcu_invoke_callbacks+0xf4/0x1a0
[    5.913358] ---[ end trace 8fa12bb0128735e5 ]---

full test log,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200721/testrun/2972385/suite/linux-log-parser/test/check-kernel-warning-1595062/log

--
Linaro LKFT
https://lkft.linaro.org
