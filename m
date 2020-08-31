Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A53257654
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 11:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgHaJQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgHaJQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:16:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D639C061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 02:16:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w3so795091ljo.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55/Zf9rAIVF2kUG8rDto+YwWXVLRuy+wKA6jaN7DLOk=;
        b=KKEMb3kJI7ez9Bm/BEEpsM198peCQW4f1a3IsIAl2Lt2wbuOMOQZYCfSJDLVCXz6P+
         V0iUyL+GbuGezGr9WLBou0/q1pVbB+vqgqyK3EJy45jAl/yyc1HV/bDS23AxJp4eMPDw
         CBrN3UbdEZAjNqM02K5vz+pHnRfkN+wHESXNfLoVFTkdcsyspNAWtH42wK5uqt/oJ4WY
         OzWMF/RrSocJMkuPCsIl7PmaG9ayIg/M7qOI49GsODBFzvxbmMWiQFKS3ymSk5Av7uvx
         xdrY28cz0dFqBRGEZXc13cVlQ9TCfrs6mRl3ewUNj+Wq2NugiNi6jupJipnCT+8CplY1
         SsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55/Zf9rAIVF2kUG8rDto+YwWXVLRuy+wKA6jaN7DLOk=;
        b=HRZWMgnwr1XlvkweQMuaQh7m66O5Lt5NMRFxg4UoVkc6D3wnDvg5PcF6/LT3qVwoGo
         27PnWXMWRzDoahqxkz+BI/n5yDzRPhraOb5jFqMz3mHO1z4gQIcYHtYDX/aKQ4+k58qU
         cv3PY6a5vSXOY99W6mye46ksRgZfaj8IvL1i+IEDRgxBmD1bm4fQQ7OqRUjsgYd6Fz9Y
         /ov29dIXdRRHwgJy0uJgpzcQFbONTrl/R27RoCjwIcw+rTzaCeM7mM4nLCpsBXfrtcWl
         wCmPYburYv7j0glNdylhPoqsfWjHupX7LQ9i4jJiECvpo9FIQolD0vPRVkxGjt8yTKfZ
         unTA==
X-Gm-Message-State: AOAM531dEMdQFT8Mga4xo4RAJaopN+8IKECbV2xOmKXdXr6Tf9ngr4gJ
        CSLwNwjIyHOnsIFnjKAy1FkGESWNyFVtpequ7nh3OZZXHEP+YA==
X-Google-Smtp-Source: ABdhPJwRqpxTn+QBkx32vO8E+P0yBSG9XSLYl5oBgIcl9jEXu/3HnpJk0F40jQz1JdOX0PwsGBbcM9sl+9qWKefNaPo=
X-Received: by 2002:a2e:9617:: with SMTP id v23mr219049ljh.365.1598865383349;
 Mon, 31 Aug 2020 02:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200829020002.GC3265@brightrain.aerifal.cx> <CAG48ez1BExw7DdCEeRD1hG5ZpRObpGDodnizW2xD5tC0saTDqg@mail.gmail.com>
 <20200830163657.GD3265@brightrain.aerifal.cx> <CAG48ez00caDqMomv+PF4dntJkWx7rNYf3E+8gufswis6UFSszw@mail.gmail.com>
 <20200830184334.GE3265@brightrain.aerifal.cx> <CAG48ez3LvbWLBsJ+Edc9qCjXDYV0TRjVRrANhiR2im1aRUQ6gQ@mail.gmail.com>
 <20200830200029.GF3265@brightrain.aerifal.cx> <CAG48ez2tOBAKLaX-siRZPCLiiy-s65w2mFGDGr4q2S7WFxpK1A@mail.gmail.com>
 <20200831014633.GJ3265@brightrain.aerifal.cx>
In-Reply-To: <20200831014633.GJ3265@brightrain.aerifal.cx>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 31 Aug 2020 11:15:57 +0200
Message-ID: <CAG48ez0aKz8wedhNsW0CWk70-tUu8tmnOE4Yi4Cv5=uLghestA@mail.gmail.com>
Subject: Re: [RESEND PATCH] vfs: add RWF_NOAPPEND flag for pwritev2
To:     Rich Felker <dalias@libc.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 3:46 AM Rich Felker <dalias@libc.org> wrote:
> On Mon, Aug 31, 2020 at 03:15:04AM +0200, Jann Horn wrote:
> > On Sun, Aug 30, 2020 at 10:00 PM Rich Felker <dalias@libc.org> wrote:
> > > On Sun, Aug 30, 2020 at 09:02:31PM +0200, Jann Horn wrote:
> > > > On Sun, Aug 30, 2020 at 8:43 PM Rich Felker <dalias@libc.org> wrote:
> > > > > On Sun, Aug 30, 2020 at 08:31:36PM +0200, Jann Horn wrote:
> > > > > > On Sun, Aug 30, 2020 at 6:36 PM Rich Felker <dalias@libc.org> wrote:
> > > > > > > So just checking IS_APPEND in the code paths used by
> > > > > > > pwritev2 (and erroring out rather than silently writing output at the
> > > > > > > wrong place) should suffice to preserve all existing security
> > > > > > > invariants.
> > > > > >
> > > > > > Makes sense.
> > > > >
> > > > > There are 3 places where kiocb_set_rw_flags is called with flags that
> > > > > seem to be controlled by userspace: aio.c, io_uring.c, and
> > > > > read_write.c. Presumably each needs to EPERM out on RWF_NOAPPEND if
> > > > > the underlying inode is S_APPEND. To avoid repeating the same logic in
> > > > > an error-prone way, should kiocb_set_rw_flags's signature be updated
> > > > > to take the filp so that it can obtain the inode and check IS_APPEND
> > > > > before accepting RWF_NOAPPEND? It's inline so this should avoid
> > > > > actually loading anything except in the codepath where
> > > > > flags&RWF_NOAPPEND is nonzero.
> > > >
> > > > You can get the file pointer from ki->ki_filp. See the RWF_NOWAIT
> > > > branch of kiocb_set_rw_flags().
> > >
> > > Thanks. I should have looked for that. OK, so a fixup like this on top
> > > of the existing patch?
> > >
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 473289bff4c6..674131e8d139 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -3457,8 +3457,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
> > >                 ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
> > >         if (flags & RWF_APPEND)
> > >                 ki->ki_flags |= IOCB_APPEND;
> > > -       if (flags & RWF_NOAPPEND)
> > > +       if (flags & RWF_NOAPPEND) {
> > > +               if (IS_APPEND(file_inode(ki->ki_filp)))
> > > +                       return -EPERM;
> > >                 ki->ki_flags &= ~IOCB_APPEND;
> > > +       }
> > >         return 0;
> > >  }
> > >
> > > If this is good I'll submit a v2 as the above squashed with the
> > > original patch.
> >
> > Looks good to me.
>
> Actually it's not quite. I think it should be:
>
>         if ((flags & RWF_NOAPPEND) & (ki->ki_flags & IOCB_APPEND)) {
>                 if (IS_APPEND(file_inode(ki->ki_filp)))
>                         return -EPERM;
>                 ki->ki_flags &= ~IOCB_APPEND;
>         }
>
> i.e. don't refuse RWF_NOAPPEND on a file that was already successfully
> opened without O_APPEND that only subsequently got chattr +a. The
> permission check should only be done if it's overriding the default
> action for how the file is open.
>
> This is actually related to the fcntl corner case mentioned before.
>
> Are you ok with this change? If so I'll go ahead and prepare a v2.

Ah, yeah, I guess that makes sense to keep things more consistent.

(You'll have to write that as "(flags & RWF_NOAPPEND) && (ki->ki_flags
& IOCB_APPEND)" though (logical AND, not bitwise AND).)
