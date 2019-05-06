Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17678149E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEFMiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 08:38:08 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:44943 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFMiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 08:38:08 -0400
Received: by mail-vs1-f51.google.com with SMTP id j184so7986765vsd.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RsUGg8WUJe0zzMXWW6OQ4E1OeXYLueqiaPUlZxvBj+Y=;
        b=BJ7CnLhWwfy9/aIAf252Ak2Vl5JpD+8ZAbELBN3KrKEtMR6YzVjG/dGA2M0bBoqPgB
         3MRfAlKaMU0IZIb03oWD9Aef2GGpsy/9asZ0xsmh64oMiXzA33rIrJk5VT/EJTQjcbFA
         7kZGScWxgdzgEIJRIs4uWS9WqhitayI8qmTN9YsUOoy4CBl+swDRk4aYKTEXepcpwAEi
         rCpo0Uor2FTsh2ujYzcyY9L/TMLQcGonwMJwyFh0mdF2np5Mq2EBRXf1SngIu9VO776f
         +wL8kRuiR9XtIfu8fVwVaviRzzix/kg+sUoKbDo+h2gPdSmcGX+G7W7QYJpwnTnCJTh9
         wOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RsUGg8WUJe0zzMXWW6OQ4E1OeXYLueqiaPUlZxvBj+Y=;
        b=CXEKLVKQB0osHnSGJSn5MYfi1292mAAiyy9t2GdHIIB2ev4ewnIVi4fWegpc1GGvBc
         c7tEReol2j4fok3BdRC4h+/hwiIKJVuw+A06/CAufWkVErMHSreCuyFW1Fcqdn4yFxQA
         TOphqkmkx+fSoVIJq0tBDCayAmsS+xTTR0fnZh/zuaV2te7R8xeONLtC6ZbEC2D1leGO
         4R+oNGSSnvs9fMMeKqUatw1/yajeHvnUoAIsQgAsQhCXZxD28itOT1qrOsN8jAGl6wp2
         3Yf6UgYT5wbtX37VJrnvc1UvrvBwsY6zPZPuND/D6HJ9Gbg5mgRFKbrzeUE3jcouTlXE
         rLog==
X-Gm-Message-State: APjAAAVNdhEHZ3yg6c4z8ofCSNkJQPC6XeF1HgHinkkjJupjVXF5kwRR
        CI23IgZDtxCkU01DrY0alFS7VQlSCjRcUSlCd5nwfk8ucM0=
X-Google-Smtp-Source: APXvYqwFtw4aw8eduOWugXTMI7gFQ0uRildy/Or974PsXCvKhTQkYvN01se+aUN0IYZjK+l7GmCxnerYTmyBPF4oZ84=
X-Received: by 2002:a05:6102:403:: with SMTP id d3mr4712702vsq.131.1557146286508;
 Mon, 06 May 2019 05:38:06 -0700 (PDT)
MIME-Version: 1.0
From:   Temp Sha <temp.sha@gmail.com>
Date:   Mon, 6 May 2019 18:07:55 +0530
Message-ID: <CANe=CUncr_PY4uUfQUaJhYhKJELi_VBYKqTjUfNdEcSE74g51g@mail.gmail.com>
Subject: soft lockup after gcc upgrade
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All,

building my Linux kernel will newer version of gcc is giving soft
loockup on any file system related commands eg on fdisk -l.
I could not understand how  gcc upgrade might be linked with this
issue. Can any one help me
to point out how can I debug this lockup in kernel ? and how could
this be linked up with gcc upgrade.

OLD GCC VERSION =  4.8.5
NEW GCC VERSION =  4.9.4


/ # fdisk -l

Disk /dev/sda: 998.9 GB, 998999326720 bytes
255 heads, 63 sectors/track, 121454 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks  Id System
/dev/sda1   *           1         123      987966  83 Linux
/dev/sda4             124      121454   974591257+  5 Extended
/dev/sda5             124         246      987966  83 Linux
/dev/sda6             247         369      987966  83 Linux
/dev/sda7             370         856     3911796  83 Linux
/dev/sda8             857        1343     3911796  83 Linux
/dev/sda9            1344        4262    23446836  83 Linux
/dev/sda10           4263        4385      987966  83 Linux
/dev/sda11           4386        5359     7823623+ 82 Linux swap
/dev/sda12           5360        5361       16033+ 83 Linux
/dev/sda13           5362        7794    19543041  83 Linux
/dev/sda14           7795      121454   912973918+ 83 Linux



BUG: soft lockup - CPU#1 stuck for 61s! [fdisk:268]
Modules linked in:
CPU 1:
Modules linked in:
Pid: 268, comm: fdisk Not tainted 2.6.32.24-ws-symbol #1 S5520UR
RIP: 0010:[<ffffffff81068c1a>]  [<ffffffff81068c1a>]
smp_call_function_many+0x1aa/0x220
RSP: 0018:ffff88096ccd5d48  EFLAGS: 00000202
RAX: 0000000000000018 RBX: ffff88096ccd5d88 RCX: 0000000000000035
RDX: 0000000000000018 RSI: 0000000000000018 RDI: 0000000000000292
RBP: ffffffff810128de R08: ffffffff8168cd30 R09: ffff88096ccd5d80
R10: ffff88096c802d20 R11: 0000000000000001 R12: 000000000e898fff
R13: 0000000000000000 R14: 00000000fffffffb R15: ffff88096c802d20
FS:  00007f1ce9f37700(0000) GS:ffff880502400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1ce93d8c60 CR3: 000000096aea6000 CR4: 00000000000006a0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 [<ffffffff81068bfe>] ? smp_call_function_many+0x18e/0x220
 [<ffffffff810e00b0>] ? invalidate_bh_lru+0x0/0x80
 [<ffffffff810e00b0>] ? invalidate_bh_lru+0x0/0x80
 [<ffffffff81068cc5>] ? smp_call_function+0x35/0x60
 [<ffffffff810456a1>] ? on_each_cpu+0x31/0x80
 [<ffffffff810de767>] ? invalidate_bh_lrus+0x17/0x20
 [<ffffffff810e5cf5>] ? __blkdev_put+0x195/0x1b0
 [<ffffffff81420a29>] ? _spin_unlock+0x9/0x30
 [<ffffffff810e61a0>] ? blkdev_close+0x30/0x60
 [<ffffffff810ba6dd>] ? __fput+0xdd/0x240
 [<ffffffff810ba859>] ? fput+0x19/0x20
 [<ffffffff810b7424>] ? filp_close+0x54/0x80
 [<ffffffff810c6c90>] ? sys_dup3+0x100/0x1b0
 [<ffffffff810c6d53>] ? sys_dup2+0x13/0x90
 [<ffffffff810b891a>] ? sys_open+0x1a/0x20
 [<ffffffff81011e02>] ? system_call_fastpath+0x16/0x1b
Kernel panic - not syncing: softlockup: hung tasks
Rebooting in 1 seconds..



thanks.
