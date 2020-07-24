Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2BF22C850
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGXOqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 10:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgGXOqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:46:14 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850C6C0619D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 07:46:14 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x9so7420482ila.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ooxbKiMWNxM2Qkg9OCv+AGbzLM8cpI7Yz8Qh84quFec=;
        b=ejwR60RWkPZ9/VVKHthh3FpYSzqmZIanKKHiIZIzNQfGxkc34Rg8Z9LYBQPYpo1teZ
         SZz9q9XA9dY263aHUQ2ps+DaSxtV0Dz1nnNw4Nko5bTb0QAWMHSxWoRW56nnr0xT2d8f
         N0LyUn2C3G9JYflsDNQE/0EhPghMtFdYKsOqAVk/yJyN54LNZSzsM9V88gijgsLn1KZK
         saK9TyhP/8yogG+tYgBngjt1QmJhVi/HN8Jg2czuum+IvvJfuKZfmilrJ8v2XGSPhDNG
         eeMHriv7AnjefyokfOeATQlWcY2nOw95zZn4vGsOfE9Ya6LxXfX0Gps6lYzq0x/F+S1y
         oEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooxbKiMWNxM2Qkg9OCv+AGbzLM8cpI7Yz8Qh84quFec=;
        b=YRK6xpp+k9dg4IkCtnR9riQCadPZIfDNlLNzeYS2UyozPQ5DCBuIZn+I+lDyEWo+MN
         DZNbvEIrWaHGZrrm7+i0tbCbxVAZDgqesbochhHcfXyowTe3dNMFphVY6GHj2x+Hy/PO
         EsYGS3zL+HZkCCsFynd0zf7hfX1vp6MqyDo6vU0zc/dk/ERQfNWV0XkoBblGKtc81IiG
         YF5LGXoQufItqjVMQgYVDWYjnXeZVZlJJlclGN5VtM0claGk3JdQ5tWLAT7Iidz7AiNy
         8/3vNNO7J6U7nlGcjWWAbD46OJ18mKC/YhFPt9nFyB+dxVOw7jLHiH/iw/ocAPHrrUoK
         tIAg==
X-Gm-Message-State: AOAM533Bm+eHaKCXpYl+Tk7wogxdu0X5UohczV1AQbHO8N7pyjncTKN0
        86q2LO1RX3KKTZuvxmu5zGaY2yuI3+k0eeYFqTfnZA==
X-Google-Smtp-Source: ABdhPJyPvAM0JnGaS6jm4dJ5xNruS00zsCyrN9+cibN31itzCWNJYwmf6/zGbKSKU1KI+6JSZWEekKEjpUlnYPbQH7I=
X-Received: by 2002:a92:dc90:: with SMTP id c16mr10596811iln.202.1595601973678;
 Fri, 24 Jul 2020 07:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200423002632.224776-1-dancol@google.com> <20200423002632.224776-2-dancol@google.com>
 <20200724100153-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200724100153-mutt-send-email-mst@kernel.org>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Fri, 24 Jul 2020 07:46:02 -0700
Message-ID: <CA+EESO4yw+qoGx9WWJDcDea8EvGQNzHHQFzfG2FcN=iCcET8tg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add UFFD_USER_MODE_ONLY
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Nick Kralevich <nnk@google.com>, kernel@android.com,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 7:28 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Apr 22, 2020 at 05:26:31PM -0700, Daniel Colascione wrote:
> > userfaultfd handles page faults from both user and kernel code.  Add a
> > new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes the
> > resulting userfaultfd object refuse to handle faults from kernel mode,
> > treating these faults as if SIGBUS were always raised, causing the
> > kernel code to fail with EFAULT.
> >
> > A future patch adds a knob allowing administrators to give some
> > processes the ability to create userfaultfd file objects only if they
> > pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
> > will exploit userfaultfd's ability to delay kernel page faults to open
> > timing windows for future exploits.
> >
> > Signed-off-by: Daniel Colascione <dancol@google.com>
>
> Something to add here is that there is separate work on selinux to
> support limiting specific userspace programs to only this type of
> userfaultfd.
>
> I also think Kees' comment about documenting what is the threat being solved
> including some links to external sources still applies.
>
> Finally, a question:
>
> Is there any way at all to increase security without breaking
> the assumption that copy_from_user is the same as userspace read?
>
>
> As an example of a drastical approach that might solve some issues, how
> about allocating some special memory and setting some VMA flag, then
> limiting copy from/to user to just this subset of virtual addresses?
> We can then do things like pin these pages in RAM, forbid
> madvise/userfaultfd for these addresses, etc.
>
> Affected userspace then needs to use a kind of a bounce buffer for any
> calls into kernel.  This needs much more support from userspace and adds
> much more overhead, but on the flip side, affects more ways userspace
> can slow down the kernel.
>
> Was this discussed in the past? Links would be appreciated.
>
Adding Nick and Jeff to the discussion.
>
> > ---
> >  fs/userfaultfd.c                 | 7 ++++++-
> >  include/uapi/linux/userfaultfd.h | 9 +++++++++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index e39fdec8a0b0..21378abe8f7b 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -418,6 +418,9 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> >
> >       if (ctx->features & UFFD_FEATURE_SIGBUS)
> >               goto out;
> > +     if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
> > +         ctx->flags & UFFD_USER_MODE_ONLY)
> > +             goto out;
> >
> >       /*
> >        * If it's already released don't get it. This avoids to loop
> > @@ -2003,6 +2006,7 @@ static void init_once_userfaultfd_ctx(void *mem)
> >
> >  SYSCALL_DEFINE1(userfaultfd, int, flags)
> >  {
> > +     static const int uffd_flags = UFFD_USER_MODE_ONLY;
> >       struct userfaultfd_ctx *ctx;
> >       int fd;
> >
> > @@ -2012,10 +2016,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
> >       BUG_ON(!current->mm);
> >
> >       /* Check the UFFD_* constants for consistency.  */
> > +     BUILD_BUG_ON(uffd_flags & UFFD_SHARED_FCNTL_FLAGS);
> >       BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
> >       BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
> >
> > -     if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
> > +     if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | uffd_flags))
> >               return -EINVAL;
> >
> >       ctx = kmem_cache_alloc(userfaultfd_ctx_cachep, GFP_KERNEL);
> > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> > index e7e98bde221f..5f2d88212f7c 100644
> > --- a/include/uapi/linux/userfaultfd.h
> > +++ b/include/uapi/linux/userfaultfd.h
> > @@ -257,4 +257,13 @@ struct uffdio_writeprotect {
> >       __u64 mode;
> >  };
> >
> > +/*
> > + * Flags for the userfaultfd(2) system call itself.
> > + */
> > +
> > +/*
> > + * Create a userfaultfd that can handle page faults only in user mode.
> > + */
> > +#define UFFD_USER_MODE_ONLY 1
> > +
> >  #endif /* _LINUX_USERFAULTFD_H */
> > --
> > 2.26.2.303.gf8c07b1a785-goog
> >
>
