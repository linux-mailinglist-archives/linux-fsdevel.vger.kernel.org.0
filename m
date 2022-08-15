Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207F159347E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiHOSHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 14:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiHOSHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:07:31 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252AD29C9B;
        Mon, 15 Aug 2022 11:07:30 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u10so5875616qvp.12;
        Mon, 15 Aug 2022 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=9eCh53aWhcLm1zn6y2/xpmwmbmdBrAigrdEFMkqm/i8=;
        b=bX7ZQWccon6xE+igS7cG7yXqU5wwrFlJG3IHLS3WGCNEiGLxof9ki5oNzNHJcD1PUb
         WP8hd3b9eY22K14NkCp28FpJKnltuaaZ1S/l/DVUMRBHLJLFzIggZ04XQTGBaqcYEQMA
         sV3SoCCNBIey6VejyFZ+tgLcTV2mwwCgaHh4SHNY481jaUO97ksjE/ItNPN+alp6oyl4
         ck0XXA8zz/74E49mvpXkw7g3K3EhHmqlhZkOeWjLCd9KiOWyAakRArdNcZdzZkdzA0nG
         mvpXECiWCpF1UCxXtKFzNWCHmZZD5bHsxqF1keSQi1Dl1yXm/BHBEMafJplvWUutr/9A
         BSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=9eCh53aWhcLm1zn6y2/xpmwmbmdBrAigrdEFMkqm/i8=;
        b=wiyJdEZL5V8t4VDVPZMrNfhinyQo0905DPdWf3B95fkWGfnSvRKD3RUBNWG+05qxQ2
         gr2f2oNkZAfFx+tWLWYHG2zG/KL78LebrUpMbmcHfWOvKDb4cEagIc8+rzaBvdPaB5/n
         VrgmCU3jW1ZPNDFG+xKGcACQTq4GWBVLBuECeqhYw2VET7M989H+XeeJ2W7/yyRzGgzs
         7tbmgv1MIA/zv09piV1/QkPi0MfOVbvxXcjrZ5Uqj+IouqsH1NWZY/WnNwiapu5MmtHM
         GBKL1yfEoSS2lxxm8KTxr2AiUXxoxPdReE96yX7ft0c7gH6EKeMJqxrQE1PfaddvYXSi
         /39g==
X-Gm-Message-State: ACgBeo0H4075g9Qxw/kdEF5ItGYnVlWW3XF7C/GxTTaYVN31pGHMOtYQ
        AT4aptCODDbNkvo6+MLCtbZIkJkMzsQ=
X-Google-Smtp-Source: AA6agR6CeWoXzXfCtZQReGsR/nNBDmFHpV0WToEf+GcJiPay5c99NUazSCtwFXS7a/LtYQTtO2odNg==
X-Received: by 2002:a05:6a00:b44:b0:52e:d959:c05b with SMTP id p4-20020a056a000b4400b0052ed959c05bmr16953839pfo.22.1660586838204;
        Mon, 15 Aug 2022 11:07:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f6-20020aa79686000000b0052e23a5ab74sm6856531pfk.59.2022.08.15.11.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:07:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 Aug 2022 11:07:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     syzbot <syzbot+24df94a8d05d5a3e68f0@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] upstream boot error: BUG: corrupted list in new_inode
Message-ID: <20220815180715.GA3106610@roeck-us.net>
References: <00000000000041678b05e64b68c6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000041678b05e64b68c6@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git  fc4d146e8d7d25ef88d409bea1f2e9aff7f30635

On Mon, Aug 15, 2022 at 11:00:29AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5d6a0f4da927 Merge tag 'for-linus-6.0-rc1b-tag' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1399b2f3080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f6bcb425ba129b87
> dashboard link: https://syzkaller.appspot.com/bug?extid=24df94a8d05d5a3e68f0
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+24df94a8d05d5a3e68f0@syzkaller.appspotmail.com
> 
> list_add corruption. next->prev should be prev (ffff8881401c0a00), but was ffff000000000000. (next=ffff88801fb50308).
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:27!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 24 Comm: kdevtmpfs Not tainted 5.19.0-syzkaller-14374-g5d6a0f4da927 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> RIP: 0010:__list_add_valid.cold+0xf/0x58 lib/list_debug.c:27
> Code: 48 c7 c6 00 ec 48 8a 48 89 ef 49 c7 c7 ea ff ff ff e8 5b 63 05 00 e9 c2 7d b6 fa 4c 89 e1 48 c7 c7 a0 f2 48 8a e8 95 f2 f0 ff <0f> 0b 48 c7 c7 40 f2 48 8a e8 87 f2 f0 ff 0f 0b 48 c7 c7 a0 f1 48
> RSP: 0018:ffffc900001efc10 EFLAGS: 00010286
> RAX: 0000000000000075 RBX: ffff8881401c0000 RCX: 0000000000000000
> RDX: ffff888012620000 RSI: ffffffff8161f148 RDI: fffff5200003df74
> RBP: ffff88801db8b588 R08: 0000000000000075 R09: 0000000000000000
> R10: 0000000080000001 R11: 0000000000000000 R12: ffff88801fb50308
> R13: ffff88801fb50308 R14: ffff8881401c0000 R15: ffff88801db8b588
> FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  __list_add include/linux/list.h:69 [inline]
>  list_add include/linux/list.h:88 [inline]
>  inode_sb_list_add fs/inode.c:495 [inline]
>  new_inode+0x114/0x270 fs/inode.c:1049
>  shmem_get_inode+0x19b/0xe00 mm/shmem.c:2306
>  shmem_mknod+0x5a/0x1f0 mm/shmem.c:2873
>  vfs_mknod+0x4d2/0x7e0 fs/namei.c:3892
>  handle_create+0x340/0x4b3 drivers/base/devtmpfs.c:226
>  handle drivers/base/devtmpfs.c:391 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:406 [inline]
>  devtmpfsd+0x1a4/0x2a3 drivers/base/devtmpfs.c:448
>  kthread+0x2e4/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__list_add_valid.cold+0xf/0x58 lib/list_debug.c:27
> Code: 48 c7 c6 00 ec 48 8a 48 89 ef 49 c7 c7 ea ff ff ff e8 5b 63 05 00 e9 c2 7d b6 fa 4c 89 e1 48 c7 c7 a0 f2 48 8a e8 95 f2 f0 ff <0f> 0b 48 c7 c7 40 f2 48 8a e8 87 f2 f0 ff 0f 0b 48 c7 c7 a0 f1 48
> RSP: 0018:ffffc900001efc10 EFLAGS: 00010286
> RAX: 0000000000000075 RBX: ffff8881401c0000 RCX: 0000000000000000
> RDX: ffff888012620000 RSI: ffffffff8161f148 RDI: fffff5200003df74
> RBP: ffff88801db8b588 R08: 0000000000000075 R09: 0000000000000000
> R10: 0000000080000001 R11: 0000000000000000 R12: ffff88801fb50308
> R13: ffff88801fb50308 R14: ffff8881401c0000 R15: ffff88801db8b588
> FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 0000000000350ef0
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
