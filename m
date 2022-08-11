Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B614590019
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 17:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbiHKPhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbiHKPgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:36:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B509DF9F
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 08:33:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q19so16786062pfg.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=sGProeHom9fEq63o7Ycx3Nip30ePXZJ0gg0Exlq4IDI=;
        b=UMWdbwOjt2wwwtmQmLKCxuxZoFP3P+Kg+NZEMPhle2UxLYNCN6r3p6U/q91ejgdpgO
         CcUAw61fWjwB7OkJVP+7zU8FtK6AR5mbcNGJ+/4yoLmXV694kCngxiAKxViCcEu3Awed
         gqWbkxyvPlgPMgYg3EB8cBaSS1czINm1JHFPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=sGProeHom9fEq63o7Ycx3Nip30ePXZJ0gg0Exlq4IDI=;
        b=2za12m/2673a9fLZIrzefypRFViEW7bIsd48nS5NIpJOKolgzH0CUqU9Du7Ij8+nOt
         lPlJ28pSoU+YByY6xWbLCaO1NrI1wU6Z+pul2pzoxkNG0AmVi1CgNLwImLLIJsb+B0iO
         9XAM4cfAmxwlOzz3d8hHVXyAuAxDdtNHS9H5U590PLmamjaz6nXoH2ZpQURwCYf/jkXe
         8hhyIbzKO9KT7ScDKfY1ltb77H89k3H+uBlK4JyXIqZBWtuf3y13ZDjco7dgJizq0oj/
         KSwqihlm46mMt+HBpYWYa7SfcOqB7XLMW2INEUxHnvBGOVUoYsh3QMNogY/Xt2Zxh9vz
         Q/4g==
X-Gm-Message-State: ACgBeo1CQaOtNDfhLSpKShJFIXLqlW75Noo/Q+PrCq25LuQ5ATHaOJOF
        q9YWh5GD41E15BWJde5Ho3cvuQ==
X-Google-Smtp-Source: AA6agR4pxsxSK4xz4ubUfvq9BeOZLm6V+TodQzH/llWgScehFC+RV76gVNLXyA1gZQZcrMvvoubtTA==
X-Received: by 2002:a63:eb4d:0:b0:41b:db07:8b33 with SMTP id b13-20020a63eb4d000000b0041bdb078b33mr26791093pgk.89.1660231998253;
        Thu, 11 Aug 2022 08:33:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b0016a3f9e4865sm15086863pln.148.2022.08.11.08.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:33:17 -0700 (PDT)
Date:   Thu, 11 Aug 2022 08:33:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        syzbot <syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [syzbot] linux-next boot error: BUG: unable to handle kernel
 paging request in kernel_execve
Message-ID: <202208110830.8F528D6737@keescook>
References: <0000000000008c0ba505e5f22066@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008c0ba505e5f22066@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Fabio,

It seems likely that the kmap change[1] might be causing this crash. Is
there a boot-time setup race between kmap being available and early umh
usage?

-Kees

[1] https://git.kernel.org/linus/c6e8e36c6ae4b11bed5643317afb66b6c3cadba8

On Thu, Aug 11, 2022 at 12:29:34AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    bc6c6584ffb2 Add linux-next specific files for 20220810
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=115034c3080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5784be4315a4403b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3250d9c8925ef29e975f
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com
> 
> BUG: unable to handle page fault for address: ffffdc0000000000
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 11826067 P4D 11826067 PUD 0 
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 1100 Comm: kworker/u4:5 Not tainted 5.19.0-next-20220810-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
> Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
> RSP: 0000:ffffc90005c5fe10 EFLAGS: 00010246
> RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
> RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
> R13: ffff88814764cc00 R14: ffff000000000000 R15: ffff88814764cc00
> FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  strnlen include/linux/fortify-string.h:119 [inline]
>  copy_string_kernel+0x26/0x250 fs/exec.c:616
>  copy_strings_kernel+0xb3/0x190 fs/exec.c:655
>  kernel_execve+0x377/0x500 fs/exec.c:1998
>  call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>  </TASK>
> Modules linked in:
> CR2: ffffdc0000000000
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
> Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
> RSP: 0000:ffffc90005c5fe10 EFLAGS: 00010246
> RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
> RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
> R13: ffff88814764cc00 R14: ffff000000000000 R15: ffff88814764cc00
> FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	74 3c                	je     0x3e
>    2:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
>    9:	fc ff df
>    c:	49 89 fc             	mov    %rdi,%r12
>    f:	48 89 f8             	mov    %rdi,%rax
>   12:	eb 09                	jmp    0x1d
>   14:	48 83 c0 01          	add    $0x1,%rax
>   18:	48 39 e8             	cmp    %rbp,%rax
>   1b:	74 1e                	je     0x3b
>   1d:	48 89 c2             	mov    %rax,%rdx
>   20:	48 89 c1             	mov    %rax,%rcx
>   23:	48 c1 ea 03          	shr    $0x3,%rdx
>   27:	83 e1 07             	and    $0x7,%ecx
> * 2a:	0f b6 14 1a          	movzbl (%rdx,%rbx,1),%edx <-- trapping instruction
>   2e:	38 ca                	cmp    %cl,%dl
>   30:	7f 04                	jg     0x36
>   32:	84 d2                	test   %dl,%dl
>   34:	75 11                	jne    0x47
>   36:	80 38 00             	cmpb   $0x0,(%rax)
>   39:	75 d9                	jne    0x14
>   3b:	4c 29 e0             	sub    %r12,%rax
>   3e:	48                   	rex.W
>   3f:	83                   	.byte 0x83
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

-- 
Kees Cook
