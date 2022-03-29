Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676D44EB26B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbiC2RFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 13:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbiC2RFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:05:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E20D3630C
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 10:03:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u16so25763229wru.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V2mK/GsiDB6jSsh94TktYA/cNlJWWdzzMrW25b6MQFU=;
        b=L0sJYCmHG4h8ktHT5NCxzT+7zGUZlmVCZebNLAsk4tYjkdICUJrMhzEkYrUh8vRikP
         j73Csn6yKx5LOnBoSEHnybeuRPwwz9jj+7KYLSnz2z/bWK4FaOTr5KUFlPXA74OwxDuT
         dMsUeuzjIWiRoGDncvFSC7BeQpCnXu8xW51NNEYRQhpxBUhKCXhXovbbL7KFVAi9SHFN
         6WJgRyscWAOnxcyuxUpSc8ofXlRkarNFohCUyKk6Oi9miwqtVBCTPR3gv1FL1J100mMB
         HSKX6W7qPn06tjiq2tzrTW6fRTs4SmtncWQhd8pTJsj1yOVrr2WmvbPvuY7Fl5CuORVx
         fYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V2mK/GsiDB6jSsh94TktYA/cNlJWWdzzMrW25b6MQFU=;
        b=TUi/RMWz0+497SiiLo5QYJgeEXvfZqDmzIq00al8qYN0nG3nD2DWrb0LCDtF3wnxnr
         EXRVvElYxXzZpjjOt2wK7H5q8tYCfuHlSMR/yxMMRg0kVpZ4au3rwZSvx1f7d+H0Kqu2
         uC56bmkGzyB4BskgRDvv6GRtj+9lvDW2ameQAmJyPfLFYC1d4V7LUNz66boXDylIaNbD
         GDWGgj4dtPoPzY+GbDoPRJJ9O5xmBVX8DI5o0AIax/uANItN9w2F5SjcdNcYHSIjkuNQ
         SKnRe+lxQZvRHagvjfjvmZt+T/SMqwuxDa509OCYLGakPaFYbFtD7C0r7GWG7JvNOZWc
         6ryw==
X-Gm-Message-State: AOAM531M3O33bxbNP1+reCNAu5N3wH6jJCPqzkFX1SFyp+PxPfa3gZIm
        PBdaGyKFteJnw4U+7dBRlOWYvA==
X-Google-Smtp-Source: ABdhPJwVkRTYEWbXNu0+NXuvAPsUGJ5k+18L1FuiALL8n6soft/RGp8eK9pkktx8BEEbF8ljO/UMdQ==
X-Received: by 2002:a05:6000:1704:b0:203:f042:156d with SMTP id n4-20020a056000170400b00203f042156dmr33053435wrc.164.1648573405955;
        Tue, 29 Mar 2022 10:03:25 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:c121:bc3e:9:bb31])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm3605926wmq.35.2022.03.29.10.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 10:03:25 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:03:20 +0200
From:   Marco Elver <elver@google.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] pipe: Make poll_usage boolean and annotate its
 access.
Message-ID: <YkM72JuG0mEoaGoE@elver.google.com>
References: <20220322002653.33865-1-kuniyu@amazon.co.jp>
 <20220322002653.33865-2-kuniyu@amazon.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322002653.33865-2-kuniyu@amazon.co.jp>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 09:26AM +0900, Kuniyuki Iwashima wrote:
> pipe_poll() runs locklessly and assigns 1 to poll_usage.  Once poll_usage
> is set to 1, it never changes in other places.  However, concurrent writes
> of a value trigger KCSAN, so let's make KCSAN happy.
> 
> BUG: KCSAN: data-race in pipe_poll / pipe_poll
> 
> write to 0xffff8880042f6678 of 4 bytes by task 174 on cpu 3:
>  pipe_poll (fs/pipe.c:656)
>  ep_item_poll.isra.0 (./include/linux/poll.h:88 fs/eventpoll.c:853)
>  do_epoll_wait (fs/eventpoll.c:1692 fs/eventpoll.c:1806 fs/eventpoll.c:2234)
>  __x64_sys_epoll_wait (fs/eventpoll.c:2246 fs/eventpoll.c:2241 fs/eventpoll.c:2241)
>  do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113)
> 
> write to 0xffff8880042f6678 of 4 bytes by task 177 on cpu 1:
>  pipe_poll (fs/pipe.c:656)
>  ep_item_poll.isra.0 (./include/linux/poll.h:88 fs/eventpoll.c:853)
>  do_epoll_wait (fs/eventpoll.c:1692 fs/eventpoll.c:1806 fs/eventpoll.c:2234)
>  __x64_sys_epoll_wait (fs/eventpoll.c:2246 fs/eventpoll.c:2241 fs/eventpoll.c:2241)
>  do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113)
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 177 Comm: epoll_race Not tainted 5.17.0-58927-gf443e374ae13 #6
> Hardware name: Red Hat KVM, BIOS 1.11.0-2.amzn2 04/01/2014
> 
> Fixes: 3b844826b6c6 ("pipe: avoid unnecessary EPOLLET wakeups under normal loads")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> ---
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
> Note that the message is false positive for now, so the Fixes tag might not
> be necessary.
> ---
>  fs/pipe.c                 | 2 +-
>  include/linux/pipe_fs_i.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 9648ac151..e9f8290f8 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -653,7 +653,7 @@ pipe_poll(struct file *filp, poll_table *wait)
>  	unsigned int head, tail;
>  
>  	/* Epoll has some historical nasty semantics, this enables them */
> -	pipe->poll_usage = 1;
> +	WRITE_ONCE(pipe->poll_usage, true);

This reminds me of [1] (look for "idempotent write").

I'm not sure what KCSAN config you're using, but it looks like it's not
a default config (you seem to have KCSAN_REPORT_VALUE_CHANGE_ONLY off).
My guess is you can't see this data race with the default config, which
was a choice made from discussion in [1].

[1] https://lore.kernel.org/linux-fsdevel/CAHk-=wh_-1pj0vsAHiHf_FVardKkN7AZGX73QwGpViMyF7_mvQ@mail.gmail.com/T/

It's your choice to change the default of course, but if the report/fix
is picked up is anyone's guess (if you are not the code's maintainer).

Also see https://lwn.net/Articles/816854/

Thanks,

--Marco
