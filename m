Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D27F64D8F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 10:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiLOJtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 04:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiLOJsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:48:31 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB9B60CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 01:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671097704; x=1702633704;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+4h6CXuiVFb8vhBCK6tdyMaP2lNBwUBXYRNDdJHjs8s=;
  b=OqVmgb3EglZG1pfB5cgG3DbltvaVEW6Mpz6tectuyMc6ib9MC+uA6axm
   Y2Dpx5xCYnKjbiXXCFcTgSvDqxhKo+E4xB3lwzD5K7PjQJXir0xNY241K
   in77/8n7Gj589GgPqVNW0iK3TLJqgn6RbfK9Yx9YWmBhVyc8L+wGM0z5D
   wKGCneeExYTdAiGVpXBf0pIcGy93z2X8jvNmH0OtiOGvrcJNksK8U5j0o
   35oROtwnbPB1mtWEbezUNS6B78Mw5/CLq4iG0dwWlPiTLhUtLZYopEW0E
   N4dwVHd5o15Aoq1sv3XvelwImI4c9rSYiOp+khTx0X6hU/u9xI82NfuGl
   A==;
X-IronPort-AV: E=Sophos;i="5.96,247,1665417600"; 
   d="scan'208";a="216913403"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2022 17:48:24 +0800
IronPort-SDR: m9M+5MDi86XBH2dE05GdZAOEv8DTwUQerNpWRUpk4k0To+zuzDUm6Uh1SKA0NuhQ1ABwCjQHe8
 KuXu/Y3+nC4mLQDXwpeSUi8/pr1lCu9+D7NBIxBzonVgTvxoDlZgFSSE4ZjFlnMdKvixwOPE6I
 MjxcOtzwQO4Mxu/JraKkGz7Ol8RbV6QskZf/IaqVbqGv/APzcCzGSSydnufZFBaolvvSa3AjlS
 bZKIyFG0tRBUAb0q6wfuk1TvEdsVj/20mMbKKw7N2birZoTN6687WSdv/cqbRQPTrzs6pixqb+
 uNY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 01:06:45 -0800
IronPort-SDR: OkL72Nk4FZKIkRjH4QR5HI811EG6voDN8pv/qZGrtDSRzK3w3/18nEgao/NYlq/lK0ClqI6YOp
 s5iVdzLz7Q9LJEOaFe4uxvTJAckVUx6rtd6oQG/cFtPaiJMj7ANFB3GvOOhcJntKfo/k3HfVt0
 LmSK+eJ+F7eO7bEYcm3KXE9fyGGhdoTb9rESzBODWS8facGzY68zGE6rin1hPc6yRd4ggdSbaq
 eP3+2lLFJTVU3si60npviRAId5lY+Y3BDz/sFx3Z28k2oa5+geWsBFfLJ/4np+cFGav2faxRAV
 f5A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 01:48:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NXnVH5vswz1RvTp
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 01:48:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671097702; x=1673689703; bh=+4h6CXuiVFb8vhBCK6tdyMaP2lNBwUBXYRN
        DdJHjs8s=; b=OQcbTSpIpiSI/fqEgD7OP9SxxNcuQ9fsWS0rNKsKZGfz/7cDw7u
        CZPxLnGoRsvr8/3WLSCr3gGoGBsaSa6dxH7vfOeNCtfu+w1GiGF0Ln5tz8FYxxaD
        asV2I/Sw73pTQKrFNDAm60TbKA2zOHL7hHPPSZjy37j5xRPsdi1jwSmmBpaT+Yf4
        p+I3tDxMOTB6KtgLRPjFVCcdIsA+TsG4ijoYWmubEk3TcU9sQVkOuA4MXlBoqWNr
        pi69At+s9U04Pl+HnETRRbq12/i1k3M6tm8oRTLAHB/m+YD3g3tBWyo5BLUwl80C
        rGEQfdNFOLjWkUYRtl0sTlr1iodT2/qQF+Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c8-BOdWW8xhW for <linux-fsdevel@vger.kernel.org>;
        Thu, 15 Dec 2022 01:48:22 -0800 (PST)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NXnVF3TmXz1RvLy;
        Thu, 15 Dec 2022 01:48:21 -0800 (PST)
Message-ID: <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
Date:   Thu, 15 Dec 2022 18:48:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: possible deadlock in __ata_sff_interrupt
Content-Language: en-US
To:     Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/14/22 00:09, Wei Chen wrote:
> Dear Linux Developer,
> 
> Recently, when using our tool to fuzz kernel, the following crash was triggered.
> 
> HEAD commit: 094226ad94f4 Linux v6.1-rc5
> git tree: upstream
> compiler: clang 12.0.1
> console output:
> https://drive.google.com/file/d/1QZttkbuLed4wp6U32UR6TpxfY_HHCIqQ/view?usp=share_link
> kernel config: https://drive.google.com/file/d/1TdPsg_5Zon8S2hEFpLBWjb8Tnd2KA5WJ/view?usp=share_link
> 
> Unfortunately, I didn't have a reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
> 
> =====================================================
> WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> 6.1.0-rc5 #40 Not tainted
> -----------------------------------------------------
> syz-executor.0/27911 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> ffff888076cc4f30 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu
> fs/fcntl.c:996 [inline]
> ffff888076cc4f30 (&new->fa_lock){....}-{2:2}, at:
> kill_fasync+0x13b/0x430 fs/fcntl.c:1017

[...]

> stack backtrace:
> CPU: 0 PID: 27911 Comm: syz-executor.0 Not tainted 6.1.0-rc5 #40
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>  print_bad_irq_dependency kernel/locking/lockdep.c:2611 [inline]
>  check_irq_usage kernel/locking/lockdep.c:2850 [inline]
>  check_prev_add kernel/locking/lockdep.c:3101 [inline]
>  check_prevs_add+0x4e5f/0x5b70 kernel/locking/lockdep.c:3216
>  validate_chain kernel/locking/lockdep.c:3831 [inline]
>  __lock_acquire+0x4411/0x6070 kernel/locking/lockdep.c:5055
>  lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5668
>  __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
>  _raw_read_lock_irqsave+0xbb/0x100 kernel/locking/spinlock.c:236
>  kill_fasync_rcu fs/fcntl.c:996 [inline]
>  kill_fasync+0x13b/0x430 fs/fcntl.c:1017
>  sg_rq_end_io+0x604/0xf50 drivers/scsi/sg.c:1403

The problem is here: sg_rq_end_io() calling kill_fasync(). But at a quick
glance, this is not the only driver calling kill_fasync() with a spinlock
held with irq disabled... So there may be a fundamental problem with
kill_fasync() function if drivers are allowed to do that, or the reverse,
all drivers calling that function with a lock held with irq disabled need
to be fixed.

Al, Chuck, Jeff,

Any thought ?

>  __blk_mq_end_request+0x2c7/0x380 block/blk-mq.c:1011
>  scsi_end_request+0x4ed/0x9c0 drivers/scsi/scsi_lib.c:576
>  scsi_io_completion+0xc25/0x27a0 drivers/scsi/scsi_lib.c:985
>  ata_scsi_simulate+0x336e/0x3dd0 drivers/ata/libata-scsi.c:4190
>  __ata_scsi_queuecmd+0x20b/0x1020 drivers/ata/libata-scsi.c:4009
>  ata_scsi_queuecmd+0xa0/0x130 drivers/ata/libata-scsi.c:4052
>  scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1524 [inline]
>  scsi_queue_rq+0x1ea6/0x2ec0 drivers/scsi/scsi_lib.c:1760
>  blk_mq_dispatch_rq_list+0x104f/0x2ca0 block/blk-mq.c:1992
>  __blk_mq_sched_dispatch_requests+0x382/0x490 block/blk-mq-sched.c:306
>  blk_mq_sched_dispatch_requests+0xef/0x160 block/blk-mq-sched.c:339
>  __blk_mq_run_hw_queue+0x1cf/0x260 block/blk-mq.c:2110
>  blk_mq_sched_insert_request+0x1e2/0x430 block/blk-mq-sched.c:458
>  blk_execute_rq_nowait+0x2e8/0x3b0 block/blk-mq.c:1305
>  sg_common_write+0x8c0/0x1970 drivers/scsi/sg.c:832
>  sg_new_write+0x61f/0x860 drivers/scsi/sg.c:770
>  sg_ioctl_common drivers/scsi/sg.c:935 [inline]
>  sg_ioctl+0x1c51/0x2be0 drivers/scsi/sg.c:1159
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f153dc8bded
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f153ede2c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f153ddabf80 RCX: 00007f153dc8bded
> RDX: 0000000020000440 RSI: 0000000000002285 RDI: 0000000000000006
> RBP: 00007f153dcf8ce0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f153ddabf80
> R13: 00007ffc72e5108f R14: 00007ffc72e51230 R15: 00007f153ede2dc0
>  </TASK>
> 
> Best,
> Wei

-- 
Damien Le Moal
Western Digital Research

