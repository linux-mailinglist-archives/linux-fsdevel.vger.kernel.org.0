Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E699734EE71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 18:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhC3Qt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhC3QtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:49:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0EAC061762
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 09:49:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id bx7so18973452edb.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5v4hc/VGlUR1CQnCR8YYeNZWMF7DASkNt59cpU1dZH4=;
        b=lR69pnXVECNYsUWa5S/V51yEGc1rw4jJJg5aexZ3wBuVZVbcKVjFfMnghmI7ZzwHbv
         ooCva9/YzssjWH5Wl9z5AFZCuhizQYqWL37kLTIWCGQnpkrJOCH1LNX0kBtMp9ABqrxH
         Hvnk+mg4bQmpwjswQjHvts/Ai/zEcpKCGjhlMjpvVX+cPocsLn79GNr2b412M6SUHcCG
         0PI6Ji29lMHpfRc0BxpMO80L0k+QfizloYxd3PgvOO7MdRHwr7yEdO9LSq1i8I3ZF98p
         /0TofV9HaypTHTbOFr/G/ZILt/6oF5DJIAMNXdk+VF5cYMKAneVZY6rVRucLkcB8TLmK
         Tgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5v4hc/VGlUR1CQnCR8YYeNZWMF7DASkNt59cpU1dZH4=;
        b=LB47p9y3d4jzuF5cGH6r/e9He34gQTdB5tisBd0QSHI620tWZeYky+gLMwAMsfVqdO
         3NV7mojJX4v8QIXtm5B3Xv/qaU5RnF2Tf5iVtyyHfaqkyH7Ix2DSSRULIzjLt0NC+8nl
         D1P4TAG7qWg0+KNPs7i8Rd7dGZLKU7jgaQ1WO29uRPHNnohYEAwjcrkwRyBcfr4pvpcq
         8l8Z+BYVpnwm9Rx6GisdMZFdIBbRKVXUt/hPRW94OGZ8I/O0bXfjZgL81vphtgl8SkKW
         WnyMkdtSlCtVGYwOYiuGQbDTT0PJtX3Ygf8X0zJ9kYfexRnXH1PLA80crg7RKbx7XFus
         YslA==
X-Gm-Message-State: AOAM533z68t3R8LLuJb3gqFeDov7ztJRadcRaj59nzoUCG8Mi8QpOlDP
        ogRcX5Kc2M6BPme9g7y7ka9SAqVyqoDtDy65S7W8nA==
X-Google-Smtp-Source: ABdhPJzfWqQT4aqoxa6RJ8ozcrQTxPomKMOODPfvq8LROliC8mAawrZ8dwNQ2Ao2sTMFe9k1+qA4BlK93sm2suImH/A=
X-Received: by 2002:aa7:dd99:: with SMTP id g25mr34099431edv.230.1617122956160;
 Tue, 30 Mar 2021 09:49:16 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 30 Mar 2021 22:19:04 +0530
Message-ID: <CA+G9fYvs2+0f=271is1fn4LzWh8VQkF5rR0AjN2__hRPWCWScg@mail.gmail.com>
Subject: WARNING: at fs/proc/generic.c:717 remove_proc_entry
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org
Cc:     Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        gladkov.alexey@gmail.com, Colin King <colin.king@canonical.com>,
        Greg KH <gregkh@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While running kselftest gpio on x86_64 and i386 the following warnings were
noticed and the device did not recover.

GOOD: next-20210329
BAD: next-20210330

steps to reproduce:
-------------------
# Boot linux next tag 20210330 on x86_64 machine
# cd /opt/kselftests/default-in-kernel/
# ./gpio-mockup.sh --> which is doing modprobe gpio-mockup

Test log:
------------
# selftests: gpio: gpio-mockup.sh
# 1.  Module load tests
# 1.1.  dynamic allocation of gpio
# ./gpio-mockup.sh: line 106: ./gpio-mockup-cdev: No such file or directory
# test failed: line value is 127 when 1 was[   46.136044]
------------[ cut here ]------------
[   46.141916] remove_proc_entry: removing non-empty directory
'irq/3', leaking at least 'ttyS1'
 expected
# GPI[   46.150471] WARNING: CPU: 2 PID: 603 at
/usr/src/kernel/fs/proc/generic.c:717 remove_proc_entry+0x1a8/0x1c0
[   46.161566] Modules linked in: gpio_mockup(-) x86_pkg_temp_thermal fuse
[   46.168195] CPU: 2 PID: 603 Comm: modprobe Not tainted
5.12.0-rc5-next-20210330 #1
[   46.175793] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   46.183217] RIP: 0010:remove_proc_entry+0x1a8/0x1c0
O gpio-mockup te[   46.188128] Code: 40 bc 24 a8 48 c7 c7 98 4a 6a a8
48 0f 45 c2 49 8b 94 24 b0 00 00 00 4c 8b 80 d8 00 00 00 48 8b 92 d8
00 00 00 e8 38 36 cb ff <0f> 0b e9 5b ff ff ff e8 0c f4 c5 00 66 90 66
2e 0f 1f 84 00 00 00
[   46.208252] RSP: 0018:ffff9da080293c58 EFLAGS: 00010286
[   46.213511] RAX: 0000000000000000 RBX: ffff93e8403bcbb8 RCX: 0000000000000000
[   46.220650] RDX: 0000000000000001 RSI: ffff93e9afb177f0 RDI: ffff93e9afb177f0
[   46.227820] RBP: ffff9da080293c88 R08: 0000000000000001 R09: 0000000000000001
[   46.235018] R10: ffff9da080293a80 R11: ffff9da080293a08 R12: ffff93e8403bcb00
[   46.242165] R13: ffff93e840263100 R14: 0000000000000001 R15: 0000000000000000
st FAIL
[   46.249303] FS:  00007f7dc2501740(0000) GS:ffff93e9afb00000(0000)
knlGS:0000000000000000
[   46.258164] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.263977] CR2: 00007f7dc1de67f0 CR3: 000000014f292003 CR4: 00000000003706e0
[   46.271124] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   46.278292] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   46.285459] Call Trace:
[   46.287926]  unregister_irq_proc+0xf8/0x110
[   46.292128]  free_desc+0x2e/0x70
[   46.295393]  irq_free_descs+0x54/0x80
[   46.299102]  irq_domain_free_irqs+0x11b/0x150
[   46.303507]  irq_dispose_mapping+0x77/0x120
[   46.307711]  gpio_mockup_dispose_mappings+0x4c/0x60 [gpio_mockup]
[   46.313817]  devm_action_release+0x15/0x20
[   46.317933]  release_nodes+0x11e/0x220
[   46.321707]  devres_release_all+0x3c/0x50
[   46.325733]  device_release_driver_internal+0x10e/0x1d0
[   46.331016]  driver_detach+0x4d/0xa0
[   46.334609]  bus_remove_driver+0x5f/0xe0
[   46.338553]  driver_unregister+0x2f/0x50
[   46.342495]  platform_driver_unregister+0x12/0x20
[   46.347218]  gpio_mockup_exit+0x1f/0x5cc [gpio_mockup]
[   46.352374]  __x64_sys_delete_module+0x15b/0x260
[   46.357082]  do_syscall_64+0x37/0x50
[   46.360676]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   46.365748] RIP: 0033:0x7f7dc1e0f997
[   46.369342] Code: 73 01 c3 48 8b 0d 01 a5 2b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d1 a4 2b 00 f7 d8 64 89
01 48
[   46.388108] RSP: 002b:00007ffe35506e78 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[   46.395708] RAX: ffffffffffffffda RBX: 000000000134ebd0 RCX: 00007f7dc1e0f997
[   46.402883] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000000000134ec38
[   46.410031] RBP: 0000000000000000 R08: 00007ffe35505e41 R09: 0000000000000000
[   46.417183] R10: 00000000000008da R11: 0000000000000206 R12: 000000000134ec38
[   46.424331] R13: 0000000000000001 R14: 000000000134ec38 R15: 00007ffe35508238
[   46.431507] irq event stamp: 6645
[   46.434845] hardirqs last  enabled at (6655): [<ffffffffa6e4fc4e>]
console_unlock+0x34e/0x550
[   46.443380] hardirqs last disabled at (6664): [<ffffffffa6e4fcb9>]
console_unlock+0x3b9/0x550
[   46.451915] softirqs last  enabled at (6564): [<ffffffffa800030e>]
__do_softirq+0x30e/0x421
[   46.460333] softirqs last disabled at (6559): [<ffffffffa6dce643>]
irq_exit_rcu+0xb3/0xc0
[   46.468548] ---[ end trace 89d0119dab1b1498 ]---
[ 46.477938] remove_proc_entry: removing non-empty directory 'irq/4',
leaking at least 'ttyS0'
[ 46.486512] WARNING: CPU: 0 PID: 603 at
/usr/src/kernel/fs/proc/generic.c:717 remove_proc_entry+0x1a8/0x1c0

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git describe: next-20210330
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-next/995/config

Full test log:
https://lkft.validation.linaro.org/scheduler/job/2463479#L1481

https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210330/testrun/4268028/suite/linux-log-parser/test/check-kernel-exception-2462521/log

-- 
Linaro LKFT
https://lkft.linaro.org
