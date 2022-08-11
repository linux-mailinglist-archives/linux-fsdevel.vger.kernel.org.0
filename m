Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9E95907A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 23:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiHKVBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 17:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbiHKVBD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:01:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8CF32BAF
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 14:01:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p8so17904386plq.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=lWnO1M/dZk+khdcoUQPWpNlUVOu1wZfObn0OsAZQlYM=;
        b=V9LZbFMbnnJyDYc0rpjV/ChWjvtnWh+ePvVn/SP+LbwIcJ4Xdttmmyc/gItE5BgYmo
         zCCvuQvaDvZyK+OiBAVZUMAdVDztrxKkFXnXhUewtrr8K1JijIMo13YQqM7nSfWqFAh9
         tVor4+kI9QcbF/sCYWR3cdWd5idHKtq01tmoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lWnO1M/dZk+khdcoUQPWpNlUVOu1wZfObn0OsAZQlYM=;
        b=yvNgromCf3A6mEEA9pLr8/cchjskMsakr8rjwVKFOOqnYvDXQYYZiPRBkvbUxeXEg7
         olOl3vON5Ycwwgr/KdWMbObqhxOjU8Zn/20Vsmaj6WVTAAYLO2cPVTFuG2eUSF11/qmo
         96CLPqSkojrhs85r7H9xH+Vs2H2NU1UGDj+v7C5dSySAHM6yK5k9rqwly67ydg/vNsVP
         bPGtXkhuqwuhCQdGMGABfdoIEERnHTR/Xou7N0/p9wuQBVY7x1oaf5XSc/fKcJrNty7h
         PmdXKb/QFQIiKDFXSzVjWC9vD9DcTqZ/x4qP/xVlY4o0CN3/84uqhfv7dD+jRkBfE/so
         vKSw==
X-Gm-Message-State: ACgBeo1Z/aZChljBpCGqXYBhGC8SOcpBbvafePfb17oYgwnB/1PEy6/k
        P2x3tGrQxEqv6lx8Jo2KwbwJGw==
X-Google-Smtp-Source: AA6agR44dr1MfmhPd+9TrxTTBk9F8wZLKavuhV0JOxK+yOCG0NW8aR/qUetK1eh0ZVL0y8Y2x31TVA==
X-Received: by 2002:a17:902:dac5:b0:16f:81c1:93d3 with SMTP id q5-20020a170902dac500b0016f81c193d3mr954362plx.70.1660251661554;
        Thu, 11 Aug 2022 14:01:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id je2-20020a170903264200b0016dafeda062sm91816plb.232.2022.08.11.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 14:01:00 -0700 (PDT)
Date:   Thu, 11 Aug 2022 14:00:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        syzbot <syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com>
Subject: Re: [syzbot] linux-next boot error: BUG: unable to handle kernel
 paging request in kernel_execve
Message-ID: <202208111356.97951D32@keescook>
References: <0000000000008c0ba505e5f22066@google.com>
 <202208110830.8F528D6737@keescook>
 <YvU+0UHrn9Ab4rR8@iweiny-desk3>
 <YvVPtuel8NMmiTKk@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvVPtuel8NMmiTKk@iweiny-desk3>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 11, 2022 at 11:51:34AM -0700, Ira Weiny wrote:
> On Thu, Aug 11, 2022 at 10:39:29AM -0700, Ira wrote:
> > On Thu, Aug 11, 2022 at 08:33:16AM -0700, Kees Cook wrote:
> > > Hi Fabio,
> > > 
> > > It seems likely that the kmap change[1] might be causing this crash. Is
> > > there a boot-time setup race between kmap being available and early umh
> > > usage?
> > 
> > I don't see how this is a setup problem with the config reported here.
> > 
> > CONFIG_64BIT=y
> > 
> > ...and HIGHMEM is not set.
> > ...and PREEMPT_RT is not set.
> > 
> > So the kmap_local_page() call in that stack should be a page_address() only.
> > 
> > I think the issue must be some sort of race which was being prevented because
> > of the preemption and/or pagefault disable built into kmap_atomic().
> > 
> > Is this reproducable?
> > 
> > The hunk below will surely fix it but I think the pagefault_disable() is
> > the only thing that is required.  It would be nice to test it.
> 
> Fabio and I discussed this.  And he also mentioned that pagefault_disable() is
> all that is required.

Okay, sounds good.

> Do we have a way to test this?

It doesn't look like syzbot has a reproducer yet, so its patch testing
system[1] will not work. But if you can send me a patch, I could land it
in -next and we could see if the reproduction frequency drops to zero.
(Looking at the dashboard, it's seen 2 crashes, most recently 8 hours
ago.)

-Kees

[1] https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

> > > > syzbot found the following issue on:
> > > > 
> > > > HEAD commit:    bc6c6584ffb2 Add linux-next specific files for 20220810
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=115034c3080000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5784be4315a4403b
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3250d9c8925ef29e975f
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com
> > > > 
> > > > BUG: unable to handle page fault for address: ffffdc0000000000
> > > > #PF: supervisor read access in kernel mode
> > > > #PF: error_code(0x0000) - not-present page
> > > > PGD 11826067 P4D 11826067 PUD 0 
> > > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > > CPU: 0 PID: 1100 Comm: kworker/u4:5 Not tainted 5.19.0-next-20220810-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> > > > RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
> > > > Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
> > > > RSP: 0000:ffffc90005c5fe10 EFLAGS: 00010246
> > > > RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> > > > RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
> > > > RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
> > > > R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
> > > > R13: ffff88814764cc00 R14: ffff000000000000 R15: ffff88814764cc00
> > > > FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  <TASK>
> > > >  strnlen include/linux/fortify-string.h:119 [inline]
> > > >  copy_string_kernel+0x26/0x250 fs/exec.c:616
> > > >  copy_strings_kernel+0xb3/0x190 fs/exec.c:655
> > > >  kernel_execve+0x377/0x500 fs/exec.c:1998
> > > >  call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
> > > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> > > >  </TASK>
> [...]
> > > > ---
> > > > This report is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > > 
> > > > syzbot will keep track of this issue. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

-- 
Kees Cook
