Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9571E73C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbgE2Dmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388995AbgE2Dmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 23:42:45 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF7DC08C5C7
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 20:42:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v16so798098ljc.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 20:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykCqer43vvinTLl1/KaSTddkvLcnjIn2m2bT/JiFhwY=;
        b=E2rNqx0swaCy081n6r34uQJWGEBtWcGNDZzf83xsFcZDAUMLwb8XgmJ5cMfUy50Whw
         Q13wMk7KW68F+h5PLSKyBMeYVXY/H3tdiRjBMyTs1/9BXGS7QKjCvNYoq9h9U7oAv/RJ
         lbHJGbX8Jd1OJmqDQDSIzju38gQE7bg+bU298=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykCqer43vvinTLl1/KaSTddkvLcnjIn2m2bT/JiFhwY=;
        b=YYO++ertt4r7EUoFhe16BHIBtYGTXz6u8RZgvB1N/uJJt+MnWVGvdP94p4hkl0Z8mz
         z+oqgK4Y2wBAs74n7hWXurOVvwRel6Iv2eHh+1uJrbZvLNNPlO78xR2Zz0hX6n+Tw6A8
         7UIlX/NFnkB2osVaygE1ac6M6QeVnzKenh1s59xd5BxIGGt8RYwUwb0zoUKb6h89sXVr
         nzfnlIlJFJaLXdQBvJYnxDwCwsypjmQtH0n1UQZeE25JcKBLG7pkFsYjdRShiORbrQLv
         amHQ4GiWSGbKuIoNG1jrUGZUAqdFelr/Oc8fr2CSwHE1zFIpnDDGyD+VhufJ6GxMM1Yz
         O8eQ==
X-Gm-Message-State: AOAM531OkqkjTljqrcARAtkNlQScL5JTENDjY2nQYB6XLHuI2/iJiaJ2
        Z7HA/GW7aKSoWTILoRoKpvovRqzKLm0=
X-Google-Smtp-Source: ABdhPJx/FsYQg1G0YPVJRCrJFM1JP6ut4ztNqZrNQ7MmqSH5rEdxxstZXPdun2RK2bs5xkKwbpBOGg==
X-Received: by 2002:a2e:9105:: with SMTP id m5mr3339031ljg.408.1590723763411;
        Thu, 28 May 2020 20:42:43 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id a6sm1768662lji.29.2020.05.28.20.42.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 20:42:42 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id k5so777515lji.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 20:42:42 -0700 (PDT)
X-Received: by 2002:a2e:9f43:: with SMTP id v3mr3270285ljk.285.1590723761862;
 Thu, 28 May 2020 20:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200529000345.GV23230@ZenIV.linux.org.uk> <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
 <20200529000419.4106697-2-viro@ZenIV.linux.org.uk> <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
 <20200529014753.GZ23230@ZenIV.linux.org.uk> <CAHk-=wiBqa6dZ0Sw0DvHjnCp727+0RAwnNCyA=ur_gAE4C05fg@mail.gmail.com>
 <20200529031036.GB23230@ZenIV.linux.org.uk>
In-Reply-To: <20200529031036.GB23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 20:42:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgM0KbsiYd+USqbiDgW8WyvAFMfLXMgebc7Z+-Q6WjZqQ@mail.gmail.com>
Message-ID: <CAHk-=wgM0KbsiYd+USqbiDgW8WyvAFMfLXMgebc7Z+-Q6WjZqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 8:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, regarding uaccess - how badly does the following offend your taste?
> Normally I'd just go for copy_from_user(), but these syscalls just might
> be hot enough for overhead to matter...

Hmm. So the code itself per se doesn't really offend me, but:

> +static inline int unkludge_sigmask(void __user *sig,
> +                                  sigset_t __user **up,
> +                                  size_t *sigsetsize)

That's a rather odd function, and if there's a reason for it I have no
issue, but I dislike the combination of "odd semantics" together with
"nondescriptive naming".

"unkludge" really doesn't describe anything.

Why is that "sig" pointer "void __user *" instead of being an actually
descriptive structure pointer:

   struct sigset_argpack {
        sigset_t __user *sigset;
        size_t sigset_size;
  };

and then it would be "struct sigset_size_argpack __user *" instead?
And same with compat_uptr_t */compat_size_t for the compat case?

Yeah, yeah, maybe I got that struct definition wrong when writing it
in the email, but wouldn't that make it much more understandable?

Then the output arguments could be just a pointer to that struct too
(except now in kernel space), and change that "unkludge" to
"get_sigset_argpack()", and the end result would be

    static inline int get_sigset_argpack(
          struct sigset_argpack __user *uarg,
          struct sigset_argpack *out)

and I think the implementation would be simpler and more
understandable too when it didn't need those odd casts and "+sizeof"
things etc..

So then the call-site would go from

>         size_t sigsetsize = 0;
>         sigset_t __user *up = NULL;
>
>         if (unkludge_sigmask(sig, &up, &sigsetsize))
>                 return -EFAULT;

to

>         struct sigset_argpack argpack = { NULL, 0 };
>
>         if (get_sigset_argpack(sig, &argpack))
>                 return -EFAULT;

and now you can use "argpack.sigset" and "argpack.sigset_size".

No?

Same exact deal for the compat case, where you'd just need that compat
struct (using "compat_uptr_t" and "compat_size_t"), and then

>         struct compat_sigset_argpack argpack = { 0, 0 };
>
> +       if (get_compat_sigset_argpack(sig, &argpack))
> +               return -EFAULT;

and then you use the result with "compat_ptr(argpack.sigset)" and
"argpack.sigset_size".

Or did I mis-read anything and get confused by that code in your patch?

                 Linus
