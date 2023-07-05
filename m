Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6FB747DAD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGEG6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 02:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjGEG6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1291709;
        Tue,  4 Jul 2023 23:58:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 560AA61453;
        Wed,  5 Jul 2023 06:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8055AC433C8;
        Wed,  5 Jul 2023 06:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688540306;
        bh=3q2hIZu8dF8g1deiKyz8mzWMkIE/10Dzben+thumg+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJvFCpi5LqN7jD3itUneKU3llpFDXChQLxVUEFYcSgdiHBtpfhgSpVPYMhKQamtKN
         PZIaj1iNzr8cMK6AaUClSvAoeTSsHRT9/dYTonwpikOxMIFh8YYao6qyETamVK+WDl
         8PLve4Pjg3Qo9tfRuMurHBbuYsbrq3ViMnCiAwW/NWjq6l/5tGTID1n1zBJ+KRcOA3
         l2H4snct26/6ujWW1iEeZpN3CDvYcUGAYZYwUNf33sIpWEumz1966T5vCtdoI3oYdD
         +9re4mbebjlcm9dH13T3D4iQHcG9OoA2nNPKHgMaxgn3dirE8KO9ov7kUFFqHhWhan
         wUXlI1wpf53tg==
Date:   Wed, 5 Jul 2023 08:58:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+339b02f826caafd5f7a8@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] WARNING in handle_userfault
Message-ID: <20230705-heerscharen-lehrreich-da606cbc833f@brauner>
References: <0000000000002db68f05ffb791bc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000002db68f05ffb791bc@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 04, 2023 at 11:32:43PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e1f6a8eaf1c2 Add linux-next specific files for 20230705
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ceea78a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=347a3e7e531c1809
> dashboard link: https://syzkaller.appspot.com/bug?extid=339b02f826caafd5f7a8
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2d0435d8ff5d/disk-e1f6a8ea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d28b2df82094/vmlinux-e1f6a8ea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fb4e5bfa0a0f/bzImage-e1f6a8ea.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+339b02f826caafd5f7a8@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 15927 at include/linux/mmap_lock.h:71 mmap_assert_write_locked include/linux/mmap_lock.h:71 [inline]
> WARNING: CPU: 1 PID: 15927 at include/linux/mmap_lock.h:71 __is_vma_write_locked include/linux/mm.h:712 [inline]
> WARNING: CPU: 1 PID: 15927 at include/linux/mmap_lock.h:71 vma_assert_locked include/linux/mm.h:753 [inline]
> WARNING: CPU: 1 PID: 15927 at include/linux/mmap_lock.h:71 assert_fault_locked include/linux/mm.h:786 [inline]
> WARNING: CPU: 1 PID: 15927 at include/linux/mmap_lock.h:71 handle_userfault+0x149b/0x27a0 fs/userfaultfd.c:440
> Modules linked in:
> CPU: 1 PID: 15927 Comm: syz-executor.1 Not tainted 6.4.0-next-20230705-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> RIP: 0010:mmap_assert_write_locked include/linux/mmap_lock.h:71 [inline]
> RIP: 0010:__is_vma_write_locked include/linux/mm.h:712 [inline]
> RIP: 0010:vma_assert_locked include/linux/mm.h:753 [inline]
> RIP: 0010:assert_fault_locked include/linux/mm.h:786 [inline]
> RIP: 0010:handle_userfault+0x149b/0x27a0 fs/userfaultfd.c:440
> Code: ff 49 8d bc 24 a0 01 00 00 31 f6 e8 2f b9 23 08 31 ff 41 89 c5 89 c6 e8 c3 a2 87 ff 45 85 ed 0f 85 83 ed ff ff e8 95 a6 87 ff <0f> 0b e9 77 ed ff ff e8 89 a6 87 ff 49 8d bc 24 a0 01 00 00 be ff
> RSP: 0000:ffffc9000316fb68 EFLAGS: 00010212
> RAX: 0000000000000177 RBX: ffffc9000316fd88 RCX: ffffc9000be81000
> RDX: 0000000000040000 RSI: ffffffff81fd6ddb RDI: 0000000000000005
> RBP: 0000000000000200 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff888023cc8000
> R13: 0000000000000000 R14: ffff88802c77af10 R15: ffff88802c77af00
> FS:  00007fa68c277700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020c067e0 CR3: 0000000045d25000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  do_anonymous_page mm/memory.c:4151 [inline]
>  do_pte_missing mm/memory.c:3671 [inline]
>  handle_pte_fault mm/memory.c:4949 [inline]
>  __handle_mm_fault+0x35ff/0x3cc0 mm/memory.c:5089
>  handle_mm_fault+0x3c2/0xa20 mm/memory.c:5254
>  do_user_addr_fault+0x2ed/0x13a0 arch/x86/mm/fault.c:1365
>  handle_page_fault arch/x86/mm/fault.c:1509 [inline]
>  exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1565
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> RIP: 0033:0x7fa68b486dcf
> Code: a4 c3 80 fa 08 73 12 80 fa 04 73 1e 80 fa 01 77 26 72 05 0f b6 0e 88 0f c3 48 8b 4c 16 f8 48 8b 36 48 89 4c 17 f8 48 89 37 c3 <8b> 4c 16 fc 8b 36 89 4c 17 fc 89 37 c3 0f b7 4c 16 fe 0f b7 36 66
> RSP: 002b:00007fa68c277158 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00007fa68b5ac050 RCX: 0000000000c06620
> RDX: 0000000000000004 RSI: 0000000020c067e0 RDI: 0000000000000000
> RBP: 00007fa68b4d7493 R08: 0000000000000004 R09: 0000000000000000
> R10: 0000000000000000 R11: 00000000200001c0 R12: 0000000000000000
> R13: 00007ffc0b167b2f R14: 00007fa68c277300 R15: 0000000000022000
>  </TASK>

#syz set subsystems: mm
