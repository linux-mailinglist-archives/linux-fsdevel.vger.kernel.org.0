Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C374DD58B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 08:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiCRHvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 03:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiCRHvq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:51:46 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DF892BB7E2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 00:50:25 -0700 (PDT)
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 18 Mar 2022 16:50:23 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.127 with ESMTP; 18 Mar 2022 16:50:23 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 18 Mar 2022 16:49:45 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: [PATCH RFC v5 00/21] DEPT(Dependency Tracker)
Message-ID: <20220318074945.GA17484@X58A-UD3R>
References: <1647397593-16747-1-git-send-email-byungchul.park@lge.com>
 <YjKtZxjIKDJqsSrP@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjKtZxjIKDJqsSrP@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 11:39:19PM -0400, Theodore Ts'o wrote:
> On Wed, Mar 16, 2022 at 11:26:12AM +0900, Byungchul Park wrote:
> > I'm gonna re-add RFC for a while at Ted's request. But hard testing is
> > needed to find false alarms for now that there's no false alarm with my
> > system. I'm gonna look for other systems that might produce false
> > alarms. And it'd be appreciated if you share it when you see any alarms
> > with yours.
> 
> Is dept1.18_on_v5.17-rc7 roughly equivalent to the v5 version sent to

Yes.

> the list.  The commit date is March 16th, so I assume it was.  I tried
> merging it with the ext4 dev branch, and tried enabling CONFIG_DEPT
> and running xfstests.  The result was nearly test failing, because a 
> DEPT warning.
> 
> I assume that this is due to some misconfiguration of DEPT on my part?

I guess it was becasue of the commit b1fca27d384e8("kernel debug:
support resetting WARN*_ONCE"). Your script seems to reset WARN*_ONCE
repeatedly.

But, yeah. It's *too much* that Dept warns it on the lack of pools. I
will switch it to just pr_warn_once().

Plus, I will implement a new functionality to expand pools to prevent
facing the situation in advance.

> And I'm curious why DEPT_WARN_ONCE is apparently getting many, many
> times?
> 
> [  760.990409] DEPT_WARN_ONCE: Pool(ecxt) is empty.
> [  770.319656] DEPT_WARN_ONCE: Pool(ecxt) is empty.
> [  772.460360] DEPT_WARN_ONCE: Pool(ecxt) is empty.
> [  784.039676] DEPT_WARN_ONCE: Pool(ecxt) is empty.
> 
> (and this goes on over and over...)
> 
> Here's the full output of the DEPT warning from trying to run
> generic/001.  There is a similar warning for generic/002, generic/003,
> etc., for a total of 468 failures out of 495 tests run.

Sorry for the noise. I will prevent this as described above.

> [  760.945068] run fstests generic/001 at 2022-03-16 08:16:53
> [  760.985440] ------------[ cut here ]------------
> [  760.990409] DEPT_WARN_ONCE: Pool(ecxt) is empty.
> [  760.995166] WARNING: CPU: 1 PID: 73369 at kernel/dependency/dept.c:297 from_pool+0xc2/0x110
> [  761.003915] CPU: 1 PID: 73369 Comm: bash Tainted: G        W         5.17.0-rc7-xfstests-00649-g5456f2312272 #520
> [  761.014389] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> [  761.024363] RIP: 0010:from_pool+0xc2/0x110
> [  761.028598] Code: 3d 32 62 96 01 00 75 c2 48 6b db 38 48 c7 c7 00 94 f1 ad 48 89 04 24 c6 05 1a 62 96 01 01 48 8b b3 20 9a 2f ae e8 2f dd bf 00 <0f> 0b 48 8b 04 24 eb 98 48 63 c2 48 0f af 86 28 9a 2f ae 48 03 86
> [  761.048189] RSP: 0018:ffffa7ce4425fd48 EFLAGS: 00010086
> [  761.053617] RAX: 0000000000000000 RBX: 00000000000000a8 RCX: 0000000000000000
> [  761.060965] RDX: 0000000000000001 RSI: ffffffffadfb95e0 RDI: 00000000ffffffff
> [  761.068322] RBP: 00000000001dc598 R08: 0000000000000000 R09: ffffa7ce4425fb90
> [  761.075789] R10: fffffffffffe0aa0 R11: fffffffffffe0ae8 R12: ffff9768e07f0600
> [  761.083063] R13: 0000000000000000 R14: 0000000000000246 R15: 0000000000000000
> [  761.090312] FS:  00007fd4ecc4c740(0000) GS:ffff976999400000(0000) knlGS:0000000000000000
> [  761.098623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  761.104580] CR2: 0000563c61657eb0 CR3: 00000001328fa001 CR4: 00000000003706e0
> [  761.111921] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  761.119171] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  761.126617] Call Trace:
> [  761.129175]  <TASK>
> [  761.131385]  add_ecxt+0x54/0x1c0
> [  761.134736]  ? simple_attr_write+0x87/0x100
> [  761.139063]  dept_event+0xaa/0x1d0
> [  761.142687]  ? simple_attr_write+0x87/0x100
> [  761.147089]  __mutex_unlock_slowpath+0x60/0x2d0
> [  761.151866]  simple_attr_write+0x87/0x100
> [  761.155997]  debugfs_attr_write+0x40/0x60
> [  761.160124]  vfs_write+0xec/0x390
> [  761.163557]  ksys_write+0x68/0xe0
> [  761.167004]  do_syscall_64+0x43/0x90
> [  761.170782]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  761.176204] RIP: 0033:0x7fd4ecd3df33
> [  761.180010] Code: 8b 15 61 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> [  761.199551] RSP: 002b:00007ffe772d4808 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  761.207240] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fd4ecd3df33
> [  761.214583] RDX: 0000000000000002 RSI: 0000563c61657eb0 RDI: 0000000000000001
> [  761.221835] RBP: 0000563c61657eb0 R08: 000000000000000a R09: 0000000000000001
> [  761.229537] R10: 0000563c61902240 R11: 0000000000000246 R12: 0000000000000002
> [  761.237239] R13: 00007fd4ece0e6a0 R14: 0000000000000002 R15: 00007fd4ece0e8a0
> [  761.245283]  </TASK>
> [  761.247586] ---[ end trace 0000000000000000 ]---
> [  761.761829] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
> [  769.903489] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
> 
> Let me know what I should do in order to fix this DEPT_WARN_ONCE?

I will let you know on all works done.

Thank you very much for all your feedback,
Byungchul
