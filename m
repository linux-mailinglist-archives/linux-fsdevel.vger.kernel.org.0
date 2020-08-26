Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B15A2524AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 02:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHZAYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 20:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHZAYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:24:35 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586AFC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 17:24:34 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id f75so332430ilh.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 17:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PhaVc46fB3y3C+IQtYQZZ5zU6t7TWG1wQZ/Bjf9fao=;
        b=rGbJ2Yi3tEgAgxB4tjVSu9oxzSlEA/v8vXQjwgRt0dmviuoTszefr/h4MVmsMdHcIP
         O/5zMbkShEMy61fbnpMD6bsp/L1BJE/HIl3ajGibH9pGHPJf1nfgAQ4eNBB0+szyYhYr
         ryXLeNC+Q9B56lJTTe5lGxuEhHm1xjmzI/ZI2XBG2it/vZ7Y5jD56J+dufKiDqLJHnrZ
         NP0+7wKSYfyNi1MFHF8L6smcFp5df/grB0wJuOr3pjFDYX8j2bgHPhCj5Ohv5bLGPpIG
         AfU7A4BHTWfRftS5XbnVU7NYJsdPe+BMazyvfSxrDahCA4Zay7kv3INPh0NdjZf0sEBY
         8nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PhaVc46fB3y3C+IQtYQZZ5zU6t7TWG1wQZ/Bjf9fao=;
        b=SGvUVkRxVX3FmeHiMI0qflX9EXHtERFRyiF31qVuURGpXE8wDiKhXTs4GiH5VzHb6A
         t4bAW0Wez91z/AMvnJCMRC40jdMv0VXbNWic24hpn2VgDseEOiJ0N4k9xX2jJHfIlxIL
         QNYm/znduQdLDRl1QVBcYyc8WZtEu+BJBj3LDKv1JJPuRakFzia3FdqomcFSmo1d4JU2
         dNUIUm6JAqicehSq6uGwTg0EHtmGjKPfDGN/57RNRsoD7qUYCnyE0SKlVuHLlbLkF9jw
         YR7Lr4F3rONRrGfqXQuygqVsupDFrRImJDxQeWY9N5vWmwYWusFVnYHDQyuBUtEGmCw/
         xscA==
X-Gm-Message-State: AOAM533o0QYsng14Pm/kqcZD1P0vreNpP3hLOZzfyNc24HnDCXE7KoWy
        SUq2RMHIOMtG7vytVxYwT0kkLEDy54f5CwszZiP6+Q==
X-Google-Smtp-Source: ABdhPJzdIClyagWUDzamz8fAV/d2I4gI7NVREIzSGQv3DSbz0qFNSFZoQmgbvGFPGEeCYhE+Mm6VlCgbpqGu28sMmLw=
X-Received: by 2002:a92:d688:: with SMTP id p8mr11697017iln.82.1598401473429;
 Tue, 25 Aug 2020 17:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200822014018.913868-1-lokeshgidra@google.com>
 <20200822014018.913868-2-lokeshgidra@google.com> <20200824123247.finquufqpr6i7umb@linutronix.de>
In-Reply-To: <20200824123247.finquufqpr6i7umb@linutronix.de>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 25 Aug 2020 17:24:22 -0700
Message-ID: <CA+EESO5E5Kg1YaCP5FpPx4Qtnmf3H506f9ZA26=vugLDk=GkDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Add UFFD_USER_MODE_ONLY
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 5:32 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-08-21 18:40:17 [-0700], Lokesh Gidra wrote:
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1966,6 +1969,7 @@ static void init_once_userfaultfd_ctx(void *mem)
> >
> >  SYSCALL_DEFINE1(userfaultfd, int, flags)
> >  {
> > +     static const int uffd_flags = UFFD_USER_MODE_ONLY;
> >       struct userfaultfd_ctx *ctx;
> >       int fd;
> Why?

Not sure! I guess Daniel didn't want to repeat the long flag name twice.

Thanks for catching that. I'll send another version fixing this.
>
> Sebastian
