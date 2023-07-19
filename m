Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D963E7591B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 11:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGSJc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 05:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjGSJcz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:32:55 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364AAE42
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 02:32:52 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-39a9590f9fdso835291b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 02:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689759171; x=1692351171;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+s4mQMd3ZNXcWLrOpu5M5FMS0n9iYFfLHy+Wp/G5cf0=;
        b=LnZKdgLK0zpd1C40ROfvGwmEEziAOL4zIROR9gHLN2L9mRmZ1qITwHE3tTFI9GoJ33
         EIk6WlNZf3XWC8w4gYvT867pW3yYfT1gcpXq7lRnkCquQie0ZpUKCbA8ULfbz7lFoP9L
         JPZ5Ygf4krGwAlO6lovXdx8ealgXR9sQRtc1qK2rU54BrWLIlrWplOsdm668CIthOkNK
         5ZkAFUrbmue4HqgDnOC8YKzKRcuR2Xg/iUmoze14VoS4gPdOd8SzaqXYrBH3ctR5ZO1D
         I/C5rWIlISO+3a3EXx54N2qQoXTg73MJRpE6ZIFvza6i3L3lKkzPj7c9+ksteDTFigHT
         t/JA==
X-Gm-Message-State: ABy/qLa6cHMa+Agarg5CKoOHWlpVTiBFxp7TsIPOrn15mkAlXOTAZXMg
        LH/85alKsT2BZ/NKqaNjzkPcvd7RWh4bUopQFHmCcaYJd1eC
X-Google-Smtp-Source: APBJJlF7q279ORMZqETk9cuXcfkye2OVaM9R5CcVzBvzCT3dQ/OxB1+4behLfOddQ5HWVpKO8QPgb+B/Ws/lq+Sg4ZjokzccavM6
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2183:b0:3a1:e59f:9ec9 with SMTP id
 be3-20020a056808218300b003a1e59f9ec9mr2721572oib.3.1689759171422; Wed, 19 Jul
 2023 02:32:51 -0700 (PDT)
Date:   Wed, 19 Jul 2023 02:32:51 -0700
In-Reply-To: <000000000000a054ee05bc4b2009@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b2f180600d3b79e@google.com>
Subject: Re: [syzbot] [btrfs?] [netfilter?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
 low! (2)
From:   syzbot <syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com>
To:     bakmitopiacibubur@boga.indosterling.com, clm@fb.com,
        davem@davemloft.net, dsahern@kernel.org, dsterba@suse.com,
        fw@strlen.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        josef@toxicpanda.com, kadlec@netfilter.org, kuba@kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e40939bbfc68 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15d92aaaa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4a2640e4213bc2f
dashboard link: https://syzkaller.appspot.com/bug?extid=9bbbacfbf1e04d5221f7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149b2d66a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1214348aa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d87aa312c0e/disk-e40939bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/22a11d32a8b2/vmlinux-e40939bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0978b5788b52/Image-e40939bb.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com

team3253: Mode changed to "activebackup"
BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
turning off the locking correctness validator.
CPU: 1 PID: 9973 Comm: syz-executor246 Not tainted 6.4.0-rc7-syzkaller-ge40939bbfc68 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 lookup_chain_cache_add kernel/locking/lockdep.c:3794 [inline]
 validate_chain kernel/locking/lockdep.c:3815 [inline]
 __lock_acquire+0x1c44/0x7604 kernel/locking/lockdep.c:5088
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5705
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 pl011_console_write+0x180/0x708 drivers/tty/serial/amba-pl011.c:2333
 console_emit_next_record kernel/printk/printk.c:2877 [inline]
 console_flush_all+0x5c0/0xb54 kernel/printk/printk.c:2933
 console_unlock+0x148/0x274 kernel/printk/printk.c:3007
 vprintk_emit+0x14c/0x2e4 kernel/printk/printk.c:2307
 vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2318
 vprintk+0x218/0x2f0 kernel/printk/printk_safe.c:50
 _printk+0xdc/0x128 kernel/printk/printk.c:2328
 __netdev_printk+0x1f8/0x39c net/core/dev.c:11273
 netdev_info+0x104/0x150 net/core/dev.c:11320
 team_change_mode drivers/net/team/team.c:619 [inline]
 team_mode_option_set+0x350/0x390 drivers/net/team/team.c:1388
 team_option_set drivers/net/team/team.c:374 [inline]
 team_nl_cmd_options_set+0x7e0/0xdec drivers/net/team/team.c:2663
 genl_family_rcv_msg_doit net/netlink/genetlink.c:968 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1048 [inline]
 genl_rcv_msg+0x938/0xc1c net/netlink/genetlink.c:1065
 netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2546
 genl_rcv+0x38/0x50 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x660/0x8d4 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x834/0xb18 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg net/socket.c:747 [inline]
 ____sys_sendmsg+0x568/0x81c net/socket.c:2503
 ___sys_sendmsg net/socket.c:2557 [inline]
 __sys_sendmsg+0x26c/0x33c net/socket.c:2586
 __do_sys_sendmsg net/socket.c:2595 [inline]
 __se_sys_sendmsg net/socket.c:2593 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2593
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
