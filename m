Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDE1CDA92
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 05:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfJGDMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 23:12:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40080 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfJGDMC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 23:12:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id d17so8143219lfa.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2019 20:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDcKffdvuqawza0UsRIeKoMOjxaGrHiLDaMxMP7R+Og=;
        b=TzkUcPe3jgWRh63W6pegVfsKQkTjDOVY+VCfmpEGgY5jThNrnZLxkzh36wG3e9K0PT
         UVSwX/FKj0M3kXvbCaiJ0Era2CeA3A+JZE6Tnc3rENEv3b79wlor4kWQoydgdwj/K0Wp
         DhxQAvxugbDUkuztHE62XrzM6B3I9zvnIS6Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDcKffdvuqawza0UsRIeKoMOjxaGrHiLDaMxMP7R+Og=;
        b=f7/YS7j+LohYTAGqMFLT+KddDUG6lALyHHxeig+zI3AV1i6yz+UFkaEZcsxgqpudCZ
         SOQc7aP+mM8mPBKdsM4MVt/wnHL+dwoWEIyhzrou7N8UrxxJQR8WaF5upIRlSyCmFK67
         cKDuT5lb8o1ssJWORkKxT0w9ZoOspBuyaOfUD8VSkYih4EB8DexkyTJquUvMzR+7iaEh
         BwFrO9xVvZlj22PKDvxwqffmUmXS90yeQC/jEq9HoSFKgyBayfzuhfRpu+jy06XnghYZ
         2YvuI0CrD8qbRHsErgPi8FrjVXF2oF6P/Oo/2+WLYjBcUSwLT/hZBYpFImzxFwijbOAS
         4MAg==
X-Gm-Message-State: APjAAAXixnkdpYNd6g7Ld/+zV4iWSPan4f+lRvcA135OyNO390BToenM
        tiTvIUN4ZvoKgAZz6MEunKNDHReIcrc=
X-Google-Smtp-Source: APXvYqyxOqw1cgl+YMKUHbsC2gni91PVduM/vMryl7JwArc4rGyCXHN7PemZ77btGmLjpyxn9v+LFA==
X-Received: by 2002:ac2:5326:: with SMTP id f6mr15615681lfh.33.1570417920065;
        Sun, 06 Oct 2019 20:12:00 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t10sm2846659ljt.68.2019.10.06.20.11.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 20:11:59 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id a22so11991769ljd.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2019 20:11:58 -0700 (PDT)
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr16761156ljj.1.1570417918300;
 Sun, 06 Oct 2019 20:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
In-Reply-To: <20191007025046.GL26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 20:11:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
Message-ID: <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 6, 2019 at 7:50 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Out of those, only __copy_to_user_inatomic(), __copy_to_user(),
> _copy_to_user() and iov_iter.c:copyout() can be called on
> any architecture.
>
> The last two should just do user_access_begin()/user_access_end()
> instead of access_ok().  __copy_to_user_inatomic() has very few callers as well:

Yeah, good points.

It looks like it would be better to just change over semantics
entirely to the unsafe_copy_user() model.

> So few, in fact, that I wonder if we want to keep it at all; the only
> thing stopping me from "let's remove it" is that I don't understand
> the i915 side of things.  Where does it do an equivalent of access_ok()?

Honestly, if you have to ask, I think the answer is: just add one.

Every single time we've had people who optimized things to try to
avoid the access_ok(), they just caused bugs and problems.

In this case, I think it's done a few callers up in i915_gem_pread_ioctl():

        if (!access_ok(u64_to_user_ptr(args->data_ptr),
                       args->size))
                return -EFAULT;

but honestly, trying to optimize away another "access_ok()" is just
not worth it. I'd rather have an extra one than miss one.

> And mm/maccess.c one is __probe_kernel_write(), so presumably we don't
> want stac/clac there at all...

Yup.

> So do we want to bother with separation between raw_copy_to_user() and
> unsafe_copy_to_user()?  After all, __copy_to_user() also has only few
> callers, most of them in arch/*

No, you're right. Just switch over.

> I'll take a look into that tomorrow - half-asleep right now...

Thanks. No huge hurry.

             Linus
