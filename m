Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3EB2D9A43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 15:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408275AbgLNOsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 09:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731101AbgLNOrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:47:53 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4ABC0613CF;
        Mon, 14 Dec 2020 06:47:13 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id i18so17083870ioa.1;
        Mon, 14 Dec 2020 06:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7cynCFYbdf1gPvm9bpSof6fvbviPpKlg5br5sZOt4Q=;
        b=h1OOPH0MU6BKrc+UxlfmIVrHGGygucAUJCvZgG7eo4wUkJGMhpxXpH2DqFMAMZJdy9
         UCeAFKYfYjw7ESvqdJom0uaLZUPdL903HjOrprnFJYH9857kAtrOTwtvQIxNFmH9VYxI
         79oASVPyA7SUN488m7ktMGyQHA+/43ev9S62V1dyS54a4FdE3XZ98xhxOD8wlVOUYE/F
         DdPij0lDQTBy+/jnunLI/q06xQcKRa0xeltSez+KZDTHgEHVBfFuHjA43FSIo7RPAbrq
         +LuYY1o3LvjzVl/V99SR57rx15OUqTZJ/4Tavtkxp9tJmovD/vIMxEUS6pdAXXfV1c3u
         bU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7cynCFYbdf1gPvm9bpSof6fvbviPpKlg5br5sZOt4Q=;
        b=uDmbL6vHavMSKtpbRyPs8Tut5yC70TpqC3SOwyYI+dQo00BQHVJB+9+uqC6P5UG4tg
         dzTUnD5zMSPd0ifHGN1am3eqNlamDgziUsiaivQXZzMgOHIrvZ4/rodFECC7ZfQhQgdP
         AXonOtnY7QzKveHxwyhKiZyMdhVAOBaA+FW7tB7lzHbuT+Tle8nhaPBPUC8QU9EjlJ2w
         7JwI2Y3rKEjdHDpBP4WbMIOPSYwcePK+3pTvLwEkc7AEeoWtSep/v4Fl1+N9Cn1PJqMb
         9L2ef3LfmRe56h1yCsON5+hKOzvlqCtyL90QxkErd/BFTx+m9/HWB8gv6llg2v1aUDtv
         HtcA==
X-Gm-Message-State: AOAM532KhthIr8BXD8SbhJoI6M3yX2GQIZ9UQzuLQj+jzkanw/AdPT14
        rrtUfvRy1zloJowmHCQ+9u0E2MHsQ6O/7v4AmihEgEsU
X-Google-Smtp-Source: ABdhPJzc1L8a2m+x9Cl1Y7Y3R5xvwiw+Dr9lE76WtoQNKu1mzfjfIQMsayg39oNPsADG4iO4bgqQk7DFykev3J+AVq8=
X-Received: by 2002:a05:6602:1608:: with SMTP id x8mr32220716iow.72.1607957232695;
 Mon, 14 Dec 2020 06:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-5-mszeredi@redhat.com>
 <CAOQ4uxhv+33nVxNQmZtf-uzZN0gMXBaDoiJYm88cWwa1fRQTTg@mail.gmail.com>
 <CAJfpegsxku5D+08F6SUixQUfF6eDVm+o2pu6feLooq==ye0GDg@mail.gmail.com>
 <CAOQ4uxj6130FkTPQ0_83bBj2vJGaehdYk1dix6c8FgLStqN6qw@mail.gmail.com> <CAJfpegvS3pD89GTfFTsAnRwQ+Oxuo+r7mP0JY1usDC3n3tT48Q@mail.gmail.com>
In-Reply-To: <CAJfpegvS3pD89GTfFTsAnRwQ+Oxuo+r7mP0JY1usDC3n3tT48Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 14 Dec 2020 16:47:01 +0200
Message-ID: <CAOQ4uxh-L4dFsbkhHMCacMjLtPimF1OvJgd6uWJP9xYT3rufRA@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ovl: make ioctl() safe
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 3:24 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Dec 14, 2020 at 6:44 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Perhaps, but there is a much bigger issue with this change IMO.
> > Not because of dropping rule (b) of the permission model, but because
> > of relaxing rule (a).
> >
> > Should overlayfs respect the conservative interpretation as it partly did
> > until this commit, a lower file must not lose IMMUTABLE/APPEND_ONLY
> > after copy up, but that is exactly what is going to happen if we first
> > copy up and then fail permission check on setting the flags.
>
> Yeah, it's a mess.   This will hopefully sort it out, as it will allow
> easier copy up of flags:
>
> https://lore.kernel.org/linux-fsdevel/20201123141207.GC327006@miu.piliscsaba.redhat.com/
>
> In actual fact losing S_APPEND is not currently prevented by copy-up
> triggered by anything other than FS_IOC_SETX*, and even that is prone
> to races as indicated by the bug report that resulted in this patch.
>
> Let's just fix the IMMUTABLE case:
>
>   - if the file is already copied up with data (since the overlay
> ioctl implementation currently uses the realdata), then we're fine to
> copy up
>
>   - if the file is not IMMUTABLE to start with, then also fine to copy
> up; even if the op will fail after copy up we haven't done anything
> that wouldn't be possible without this particular codepath
>
>   - if task has CAP_LINUX_IMMUTABLE (can add/remove immutable) then
> it's also fine to copy up since we can be fairly sure that the actual
> setflags will succeed as well.  If not, that can be a problem, but as
> I've said copying up IMMUTABLE and other flags should really be done
> by the copy up code, otherwise it won't work properly.
>
> Something like this incremental should be good,  I think:
>
> @@ -576,6 +576,15 @@ static long ovl_ioctl_set_flags(struct f
>
>   inode_lock(inode);
>
> + /*
> + * Prevent copy up if immutable and has no CAP_LINUX_IMMUTABLE
> + * capability.
> + */
> + ret = -EPERM;
> + if (!ovl_has_upperdata(inode) && IS_IMMUTABLE(inode) &&
> +     !capable(CAP_LINUX_IMMUTABLE))
> + goto unlock;
> +
>   ret = ovl_maybe_copy_up(file_dentry(file), O_WRONLY);
>   if (ret)
>   goto unlock;
>

I guess that looks ok for a band aid.

Thanks,
Amir.
