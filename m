Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDB725716F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 03:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgHaBPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 21:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgHaBPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:15:34 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C3C061575
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 18:15:33 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m22so4802746ljj.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 18:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqUWQbTaTXuhonfPRcWx/5CuPzZ/iSXPPKYi6cmnxaA=;
        b=uTtwIMq+zW+o4aunGvghOfJaFbl+9Nfl8a6X133j24hZCsYvegdEvYEDZ1cn6YiXL2
         oc0Z1pG8TgwaNp67lsAaDhKMWF8KX5u4VRWuwQOfcQyAnXOmB2GQuP6H7vnNDAF/n3fO
         RB3zKm7wy70tJHVT7bFJM1uufiTgK/XZ10tbz6uNhmpSt3Xv+519kh34Dqa0HyihLwmy
         wZ+pKEINVkQzqtc6q/kevGuDtfG6m4jit8IRlQhQfPw+W/fw8Fnbcs+Blu/X/lQN8n+d
         qO2dnfbKL2xqGMw2yuF/vWkz4qDVy0OXAHJQOxp6b36uHo99WHRyooVIEzQRxw9jxxq9
         gowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqUWQbTaTXuhonfPRcWx/5CuPzZ/iSXPPKYi6cmnxaA=;
        b=h2WUWg4PFjpIYSQZqttmyBvvlrwxzRXfGAA0AzYHxtGz31IOic7qq9id3hT7YacCEG
         KYyhrEvHcjZy2ZroV1x2yp8D0adbLYPXu45dsxg+K5Cfn6USYmHsA/XkepT3vweMna1q
         sv9A5i4lH2fKcpXFvCxfnYI8ddy1EgKnxSH8ze3XAA/9pqS8z4otjtBnL28brMAry5zk
         7PKqPV0/0TFv2I4h485iH7O/ZuOAcPRNHeA4Vi/DuPfJMZovQifg/O4AkVvhWAzaDuCV
         moJqjy6uYyRGdI6p5mgN4c1Btj3eeoB5GrS0UUAha81LaZhWvmLKZvlovkiU0vmgkM+Y
         dEcw==
X-Gm-Message-State: AOAM531ySINnkfMqkwJlVEubF4+ZUFh6TxY5tnYxLp6cC+FxZ+z+jEL2
        587n7VQxJc5NuYTezacF5lFJ+wC25zGi3jpPs7i1fWORyJs=
X-Google-Smtp-Source: ABdhPJyrdu517siGjMDH4/Hzxq0grj9bjXKHwadgRENiyu81gHSD9vEvdAEiN4XvZknaPnf8wkHI2CH6MRE+WZGG6iU=
X-Received: by 2002:a2e:92cd:: with SMTP id k13mr2330316ljh.138.1598836531623;
 Sun, 30 Aug 2020 18:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200829020002.GC3265@brightrain.aerifal.cx> <CAG48ez1BExw7DdCEeRD1hG5ZpRObpGDodnizW2xD5tC0saTDqg@mail.gmail.com>
 <20200830163657.GD3265@brightrain.aerifal.cx> <CAG48ez00caDqMomv+PF4dntJkWx7rNYf3E+8gufswis6UFSszw@mail.gmail.com>
 <20200830184334.GE3265@brightrain.aerifal.cx> <CAG48ez3LvbWLBsJ+Edc9qCjXDYV0TRjVRrANhiR2im1aRUQ6gQ@mail.gmail.com>
 <20200830200029.GF3265@brightrain.aerifal.cx>
In-Reply-To: <20200830200029.GF3265@brightrain.aerifal.cx>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 31 Aug 2020 03:15:04 +0200
Message-ID: <CAG48ez2tOBAKLaX-siRZPCLiiy-s65w2mFGDGr4q2S7WFxpK1A@mail.gmail.com>
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

On Sun, Aug 30, 2020 at 10:00 PM Rich Felker <dalias@libc.org> wrote:
> On Sun, Aug 30, 2020 at 09:02:31PM +0200, Jann Horn wrote:
> > On Sun, Aug 30, 2020 at 8:43 PM Rich Felker <dalias@libc.org> wrote:
> > > On Sun, Aug 30, 2020 at 08:31:36PM +0200, Jann Horn wrote:
> > > > On Sun, Aug 30, 2020 at 6:36 PM Rich Felker <dalias@libc.org> wrote:
> > > > > So just checking IS_APPEND in the code paths used by
> > > > > pwritev2 (and erroring out rather than silently writing output at the
> > > > > wrong place) should suffice to preserve all existing security
> > > > > invariants.
> > > >
> > > > Makes sense.
> > >
> > > There are 3 places where kiocb_set_rw_flags is called with flags that
> > > seem to be controlled by userspace: aio.c, io_uring.c, and
> > > read_write.c. Presumably each needs to EPERM out on RWF_NOAPPEND if
> > > the underlying inode is S_APPEND. To avoid repeating the same logic in
> > > an error-prone way, should kiocb_set_rw_flags's signature be updated
> > > to take the filp so that it can obtain the inode and check IS_APPEND
> > > before accepting RWF_NOAPPEND? It's inline so this should avoid
> > > actually loading anything except in the codepath where
> > > flags&RWF_NOAPPEND is nonzero.
> >
> > You can get the file pointer from ki->ki_filp. See the RWF_NOWAIT
> > branch of kiocb_set_rw_flags().
>
> Thanks. I should have looked for that. OK, so a fixup like this on top
> of the existing patch?
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 473289bff4c6..674131e8d139 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3457,8 +3457,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>                 ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
>         if (flags & RWF_APPEND)
>                 ki->ki_flags |= IOCB_APPEND;
> -       if (flags & RWF_NOAPPEND)
> +       if (flags & RWF_NOAPPEND) {
> +               if (IS_APPEND(file_inode(ki->ki_filp)))
> +                       return -EPERM;
>                 ki->ki_flags &= ~IOCB_APPEND;
> +       }
>         return 0;
>  }
>
> If this is good I'll submit a v2 as the above squashed with the
> original patch.

Looks good to me.
