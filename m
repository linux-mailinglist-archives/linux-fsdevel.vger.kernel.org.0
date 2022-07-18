Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AF6577F60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 12:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiGRKMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 06:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGRKMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:12:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9465B1B780;
        Mon, 18 Jul 2022 03:12:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ss3so20246944ejc.11;
        Mon, 18 Jul 2022 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=sQuZmfoFAzWtRppAl4q15k3VzhUc5gvElEfHAQRxO9Y=;
        b=LSojY5r2dONSiRw5eojeQkKVeYgeSTEapQdOy63YusIEiMRB529CnTazntjEQGQTsj
         /3xJznBCRyk5kVZAjFEayKb/o3Yj7zJFZ3PY9MKu8MEf6J6S02bYuJ/33A2nUxRFWI3W
         d+KKF3ezpPL6HFuTbTULe8GSmJtFVRIxsZtzARxdLOor/UUfqkJmh/UjvLffRRSnaQ0Y
         gw4aepT36szeNk1nr2sMq5oTh3GuQe26k0kWsAgEeH2/kfIieGAph9eWC/4eqjiqQaJ4
         0ReSwj4p4wK/HPVqQTNtuO/2XYyJDHVjDt+Wxx3x6bEeelglBE4qE3uoboTYXwWNF2s3
         LgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sQuZmfoFAzWtRppAl4q15k3VzhUc5gvElEfHAQRxO9Y=;
        b=Zm5nqwuY5fzuHojPzL5eChOQVG33/Ou2Bdv0UYPnUAJvKtg8LdUbCvB00pOKhg6Phq
         UFIgDn8EOjTp3nOR8+c+wCMuAUPOECdZ0Pv5HQnmx4gfnuCVLy9wsJHRU6Pb0dWihRma
         tRxMjiFvwz27A+IrqDQON0gbLExbC6Pg8hehoO19G6aHUVHcTFZaXEHgHYAxu0NKCuT9
         wLzL0O9wTioF6TJlXolyZvwlWx3nqt0YbJvwI4qp6YL4m9HjrsNHHEmO8UMhRwWoiDYS
         YZlr1EJtVBUoZnTYyRM0LMFfMDuwvZFsxhovp5IL4lZK7W35vOZOHn5sUXvx6hbJyD/t
         GcoQ==
X-Gm-Message-State: AJIora/SnrZvuNhZYieMk0DAsaAccuzFEzPuGcMoNIs0V2lOuzIF4aPC
        i4b8rLYPgtS+SAtbsGzczfHRVlLRnGvdQKoo8CTTMyiohRzWNNMI
X-Google-Smtp-Source: AGRyM1td3kYaxhRt7FD1Dotmu3DzsYdEuSSxC9HRKsRQ6FFM9zkrSv/jtcTOBFkUDKlE4o3ovhfnDsRzyAldZH/7/7I=
X-Received: by 2002:a17:906:7951:b0:72f:4733:5885 with SMTP id
 l17-20020a170906795100b0072f47335885mr369029ejo.172.1658139131832; Mon, 18
 Jul 2022 03:12:11 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 18 Jul 2022 18:11:37 +0800
Message-ID: <CAO4mrffrR_C1y=07=Sxgj6r=SAyA3yN-h-atcGkoKrnSku026A@mail.gmail.com>
Subject: INFO: task hung in __block_write_begin_int
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1dk3H5-D3ppxAONucKu_Vh7uXI2e94HyI/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1dcYG-en7_om3HWtUUMip3vooPxr38is2/view?usp=sharing
C reproducer: https://drive.google.com/file/d/15cJ2SBbvNIBJXFux85lmVFz5kbwNsY4w/view?usp=sharing
kernel config: https://drive.google.com/file/d/1lNwvovjLNrcuyFGrg05IoSmgO5jaKBBJ/view?usp=sharing

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

INFO: task syz-executor:14691 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc5+ #14
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:25712 pid:14691 ppid:  6522 flags:0x00004004
Call Trace:
 __schedule+0xc1a/0x11e0
 schedule+0x14b/0x210
 io_schedule+0x83/0x100
 bit_wait_io+0xe/0xc0
 __wait_on_bit+0xbb/0x180
 out_of_line_wait_on_bit+0x1c3/0x240
 __block_write_begin_int+0x187e/0x1a10
 block_write_begin+0x54/0x2c0
 generic_perform_write+0x28c/0x5e0
 __generic_file_write_iter+0x26d/0x540
 blkdev_write_iter+0x3a2/0x560
 vfs_write+0x868/0xf50
 ksys_write+0x175/0x2b0
 do_syscall_64+0x3d/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f08ee707c4d
RSP: 002b:00007f08ebc6fc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f08ee82e0a0 RCX: 00007f08ee707c4d
RDX: 00000000000006a8 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f08ee780d80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f08ee82e0a0
R13: 00007ffc57334f2f R14: 00007ffc573350d0 R15: 00007f08ebc6fdc0

Showing all locks held in the system:
2 locks held by kworker/u2:1/10:
1 lock held by khungtaskd/21:
 #0: ffffffff8cf1c040 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
1 lock held by in:imklog/6329:
 #0: ffff888016c2dc70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x26c/0x310

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 21 Comm: khungtaskd Not tainted 5.15.0-rc5+ #14
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 dump_stack_lvl+0x1d8/0x2c4
 nmi_cpu_backtrace+0x452/0x480
 nmi_trigger_cpumask_backtrace+0x1a3/0x330
 watchdog+0xdbe/0xe30
 kthread+0x419/0x510
 ret_from_fork+0x1f/0x30

Best,
Wei
