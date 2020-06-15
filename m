Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210DD1FA0B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 21:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgFOTph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 15:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOTph (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:45:37 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E851C061A0E;
        Mon, 15 Jun 2020 12:45:36 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s18so19321344ioe.2;
        Mon, 15 Jun 2020 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcEsP5XHkAYWjVB1MFDssViF4cxMQLWXk2Kgbxji0hs=;
        b=d1N76KYXqQ1fpaIX30dgZBqRd8wI/sojfUihP9H9n7SrJl5fw8AIM1QjJHFUie0ynn
         Ba7u2YUNcGPgUH5k5/xR7j1g1AD4ubDfekbuaJsUIn8tpQbEqATe7gJrtx3bqoUJmH4s
         5+bquUS4RYotC8sNbFVFKTlUv9aULk2bwxwqhhxgC1NWXrZ2b3J+MnEA2epJN5YcPwJd
         seJUjothmBUqRpHkR2X5MhScZehYA2HegUeEnFWW4JD2VuEs9SDBgZ0eGzbMT5M7oi0/
         XAULqncIPF3a7VQsBQHJiygHfxiVk4UqM7Xb3uuuIVXJb73uzIjZdrMQlG7Z9vwbj0Z+
         CyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcEsP5XHkAYWjVB1MFDssViF4cxMQLWXk2Kgbxji0hs=;
        b=oD8rqe1WbSqXPeGF+kDGc8ny/y8ZwR4nKi3K9xLvoeN5cmrNEsfuIvRKjrB9b7cCiJ
         aDCzAMYetaJJYLn4POxwKcLWyDI6do9l4LZ0aeCbK2KLF3ogWlhDpI8t563TOxzlbiZi
         XsZTmklNrV1zI+xAv3WWoQcNa3ktsCTo2/rDEpvnpDmW6nmx08TKX5jQtJTPE6WEr6wT
         +KIDoOpMRYvPoSjcw46UA9Xq02vIsOmDgE92qyte4GfseqBE8SDPaTjV9IN2h423Pu1U
         Yk/lBu3IiMSLLtpuLiRGJeYlp8q905CasW9zE37EJjIJPmzDMe+v1HFJb6r1JIQDTV09
         8loQ==
X-Gm-Message-State: AOAM5319MNyHR3uHQK7Fo+4VDz/IfJHwZzc5RA/G6XG2nu1ijlVfVvDg
        SRSa0DwKOOS+q/xtbhN83gIl0E1UlgXQQZlNUA==
X-Google-Smtp-Source: ABdhPJxruXU+i+P2JjGW09+nvoxmHKpEF1SP+mxNnwxG3exn2/HqUJry5Lh3ZGwSfno6ZlJbUa99xQueu/DZAVZXhg0=
X-Received: by 2002:a05:6602:80b:: with SMTP id z11mr29222473iow.109.1592250335524;
 Mon, 15 Jun 2020 12:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de>
 <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com>
 <20200615141239.GA12951@lst.de> <CAMzpN2heSzZzg16ws3yQkd7YZwmPPx_4RFCpb9JYfFWJ9gfPhA@mail.gmail.com>
 <CAK8P3a3q-hC7kZwLPbc+E5VYcqthQS4J4Rqo+rKkBRU2n071XA@mail.gmail.com>
In-Reply-To: <CAK8P3a3q-hC7kZwLPbc+E5VYcqthQS4J4Rqo+rKkBRU2n071XA@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 15 Jun 2020 15:45:24 -0400
Message-ID: <CAMzpN2iDPKatOqs+Uuw70ACbnB-D__dgSRZU0wBjOUBwTGOJ-A@mail.gmail.com>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 2:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jun 15, 2020 at 4:48 PM Brian Gerst <brgerst@gmail.com> wrote:
> > On Mon, Jun 15, 2020 at 10:13 AM Christoph Hellwig <hch@lst.de> wrote:
> > > On Mon, Jun 15, 2020 at 03:31:35PM +0200, Arnd Bergmann wrote:
>
> > >
> > > I'd rather keep it in common code as that allows all the low-level
> > > exec stuff to be marked static, and avoid us growing new pointless
> > > compat variants through copy and paste.
> > > smart compiler to d
> > >
> > > > I don't really understand
> > > > the comment, why can't this just use this?
> > >
> > > That errors out with:
> > >
> > > ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1040): undefined reference to
> > > `__x32_sys_execve'
> > > ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1108): undefined reference to
> > > `__x32_sys_execveat'
> > > make: *** [Makefile:1139: vmlinux] Error 1
> >
> > I think I have a fix for this, by modifying the syscall wrappers to
> > add an alias for the __x32 variant to the native __x64_sys_foo().
> > I'll get back to you with a patch.
>
> Do we actually need the __x32 prefix any more, or could we just
> change all x32 specific calls to use __x64_compat_sys_foo()?

I suppose that would work too.  The prefix really describes the
register mapping.

--
Brian Gerst
