Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F7A3A33BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 21:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhFJTMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFJTMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:12:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C2FC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 12:10:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a1so4843542lfr.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMdGbg5qY7Xril8PIwC2aCilKl3gyih4vJXN13qnRQs=;
        b=cqfvjt39dMqE03b8Qk8T6nxGqG5CE1oOqhjvJmr5822PMJQr4Sbq2nJYsWDStaAAwb
         iZ8tDefBwOO4B7DqY2HZw7POkKfUguqqt97g4qUSfGrtUCu0Qk1R3Aww0cBYlsV+BMuQ
         btfcXVmLIGGv1LLx4UfLfPNWQHDLhab4yvwWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMdGbg5qY7Xril8PIwC2aCilKl3gyih4vJXN13qnRQs=;
        b=VgTDz/9ySg1cdkzUFN38eeJCghtI+6mCkGwqglPUDugqlSflDbrj90gJNsjPLIg3DL
         SO8a6UxlWr3t3oRyp5R8N6uGQjUpHaSysu/OWQrqNvVuhTo6dEQXELmPmRkLVuPeCM5N
         UK5MKAUIom1K33AugBO3jeqrajoL8jsAgm4obmqaEgn9cbXgWwy4vMmnylgYeLt7hUOy
         J3HsgLWUltn9N8TH8Ia4JysUzlWulct7hY/EeyKpleV56MlfKYshiyIVMKPK+6Ybv8L0
         yjA6hS18e6H2Bo1FG3F3PH5N+dnrjKLmEc6JsZ1psXa9dPn1nbRJgtW/5tGC4TsftZ9Y
         pCWA==
X-Gm-Message-State: AOAM531U6RvT+Pbei9wAkJhPkzOGIzfCewrXO5mdaBzVhpVM9B96T0OF
        NOtwfU3PYUvOSm5WGLCPnCN6dSvH8DRZl37IaVE=
X-Google-Smtp-Source: ABdhPJyqY5SLU7adKOUB3H7YqrB54Pu5Dp2ZaECRKVlS8dDGXN5G7P8Pcw/FnyG8MgBtVyXNA8JG+w==
X-Received: by 2002:a19:4096:: with SMTP id n144mr193979lfa.433.1623352241222;
        Thu, 10 Jun 2021 12:10:41 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t17sm375151lfd.205.2021.06.10.12.10.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 12:10:39 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id r16so6471683ljc.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 12:10:36 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr50548ljh.507.1623352236538;
 Thu, 10 Jun 2021 12:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <192c9697e379bf084636a8213108be6c3b948d0b.camel@trillion01.com>
 <9692dbb420eef43a9775f425cb8f6f33c9ba2db9.camel@trillion01.com>
 <87h7i694ij.fsf_-_@disp2133> <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
 <198e912402486f66214146d4eabad8cb3f010a8e.camel@trillion01.com>
 <87eeda7nqe.fsf@disp2133> <b8434a8987672ab16f9fb755c1fc4d51e0f4004a.camel@trillion01.com>
 <87pmwt6biw.fsf@disp2133> <87czst5yxh.fsf_-_@disp2133>
In-Reply-To: <87czst5yxh.fsf_-_@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jun 2021 12:10:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiax83WoS0p5nWvPhU_O+hcjXwv6q3DXV8Ejb62BfynhQ@mail.gmail.com>
Message-ID: <CAHk-=wiax83WoS0p5nWvPhU_O+hcjXwv6q3DXV8Ejb62BfynhQ@mail.gmail.com>
Subject: Re: [CFT}[PATCH] coredump: Limit what can interrupt coredumps
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Olivier Langlois <olivier@trillion01.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov>" <asml.silence@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 12:01 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index f7c6ffcbd044..83d534deeb76 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -943,8 +943,6 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
>         sigset_t flush;
>
>         if (signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) {
> -               if (!(signal->flags & SIGNAL_GROUP_EXIT))
> -                       return sig == SIGKILL;
>                 /*
>                  * The process is in the middle of dying, nothing to do.
>                  */

I do think this part of the patch is correct, but I'd like to know
what triggered this change?

It seems fairly harmless - SIGKILL used to be the only signal that was
passed through in the coredump case, now you pass through all
non-ignored signals.

But since SIGKILL is the only signal that is relevant for the
fatal_signal_pending() case, this change seems irrelevant for the
coredump issue. Any other signals passed through won't matter.

End result: I think removing those two lines is likely a good idea,
but I also suspect it could/should just be a separate patch with a
separate explanation for it.

Hmm?

              Linus
