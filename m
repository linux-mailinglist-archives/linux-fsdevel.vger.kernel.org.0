Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC961D0375
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 02:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbgEMAUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 20:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731604AbgEMAUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 20:20:21 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480C4C061A0C
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 17:20:21 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z22so12133773lfd.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 17:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0PRvXxFUisddotTdBWpwJBi56fBlnghxS/KLoaylUY=;
        b=PmnnQc+OKVtN2R2QhsqsUQiuEyo/dwB98MAi74pKsaTnCjpiuB8N7ddD8/XwjmOVDn
         iVLPl6CHuig97AYCTWXQLOyRFYnkwZZZd9JZD2F2iCfxMZFY5wDBleD8UQP7k8z5jvv4
         nQ6a8JLSWN3xdLUCKegUjtyG+YsAu2zwn/TPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0PRvXxFUisddotTdBWpwJBi56fBlnghxS/KLoaylUY=;
        b=GWOBO615KvoEWsUPRzv3uqEtr6U+DKuE+lf5SpzymFUwQHlR+6vsM0Ld/WDajuqQvZ
         BJ4K4C1CFkgTU1/5cwH/TLfOh6JTTJGUI7JSkkcAxxsomIxQcr1taHntVcMspmR4ZrHz
         +rtz46ZSUsKvNhisaAU/dBwrCewBvjaowkWZ0obf9rXcy4m+nz6Y50BqSotDafk755Gt
         eRTKb1yk/gV8CfrnO/eeH/tu9OIZhNBoy3MMqffXBEuuCKJcREq+qIJlvTuI39nAH57+
         xDqh+TMTrJuEtQHWTZtT9gUigRJkeRCYZovAfjL9XuVTwmyXULMzf+nWTH9jFrBPLSUn
         ajIg==
X-Gm-Message-State: AOAM533rUjfF+nD9CMIv+SZajquxqmvQvgnY3HWxEeXLYl2AOnzfVa+w
        ipRHQ1LjMmzET7Yz0YlnUA5ttQcj6s8=
X-Google-Smtp-Source: ABdhPJxjuG/4S9DyKBO6+KYYCuZzVp04oflfrWICwp9VIhD+qHBSTptUQGuJl/Laxf5KKMpfMm/Vig==
X-Received: by 2002:ac2:5999:: with SMTP id w25mr15703747lfn.196.1589329219024;
        Tue, 12 May 2020 17:20:19 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id c2sm13640675ljk.97.2020.05.12.17.20.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 17:20:17 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id z22so12133718lfd.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 17:20:17 -0700 (PDT)
X-Received: by 2002:a19:4816:: with SMTP id v22mr6011610lfa.30.1589329216771;
 Tue, 12 May 2020 17:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org> <202005111428.B094E3B76A@keescook> <874kslq9jm.fsf@x220.int.ebiederm.org>
In-Reply-To: <874kslq9jm.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 May 2020 17:20:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhmoGLcMgcDB0rT-n6waC+rdnjU3FRKAwSTMSG=gaK9Q@mail.gmail.com>
Message-ID: <CAHk-=wjhmoGLcMgcDB0rT-n6waC+rdnjU3FRKAwSTMSG=gaK9Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 11:46 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> I am still thinking about this one, but here is where I am at.  At a
> practical level passing the file descriptor of the script to interpreter
> seems like something we should encourage in the long term.  It removes
> races and it is cheaper because then the interpreter does not have to
> turn around and open the script itself.

Yeah, I think we should continue to support it, because I think it's
the right thing to do (and we might just end up having compatibility
issues if we don't).

How about trying to move the logic to the common code, out of binfmt_misc?

IOW, how about something very similar to your "brpm->preserve_creds"
thing that you did for the credentials (also for binfmt_misc, which
shouldn't surprise anybody: binfmt_misc is simply the "this is the
generic thing for letting user mode do the final details").

> Calling fd_install in binfmt_misc still seems wrong, as that exposes
> the new file descriptor to user space with the old creds.

Right.  And it really would be good to simply not have these kinds of
very special cases inside the low-level binfmt code: I'd much rather
have the special cases in the generic code, so that we see what the
ordering is etc. One of the big problems with all these binfmt
callbacks has been the fact that it makes it so hard to think about
and change the generic code, because the low-level binfmt handlers all
do their own special thing.

So moving it to generic code would likely simplify things from that
angle, even if the actual complexity of the feature itself remains.

Besides, we really have exposed this to other code anyway thanks to
that whole bprm->interp_data thing, and the AT_EXECFD AUX entries that
we have. So it's not really "internal" to binfmt_misc _anyway_.

So how about we just move the fd_binary logic to the generic execve
code, and just binfmt_misc set the flag for "yes, please do this",
exactly like "preserve_creds"?

> It is possible although unlikely for userspace to find the file
> descriptor without consulting AT_EXECFD so just to be conservative I
> think we should install the file descriptor in begin_new_exec even if
> the next interpreter does not support AT_EXECFD.

Ack. I think the AT_EXECFD thing is a sign that this isn't internal to
binfmt_misc, but it also shouldn't be gating this issue. In reality,
ELF is the only real binary format that matters - the script/misc
binfmts are just indirection entries - and it supports AT_EXECFD, so
let's just ignore the theoretical case of "maybe nobody exposes it".

So yes, just make it part of begin_new_exec(), and there's no reason
to support more than a single fd. No stacks or arrays of these things
required, I feel. It's not like AT_EXECFD supports the notion of
multiple fd's being reported anyway, nor does it make any sense to
have some kind of nested misc->misc binfmt nesting.

So making that whole interp_data and fd_binary thing be a generic
layer thing would make the search_binary_handler() code in binfmt_misc
be a pure tailcall too, and then the conversion to a loop ends up
working and being the right thing.

No?

                Linus
