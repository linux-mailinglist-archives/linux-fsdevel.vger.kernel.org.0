Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC001E69FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 21:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406088AbgE1TEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 15:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405981AbgE1TEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 15:04:33 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4F3C08C5C6
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 12:04:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s1so1928018ljo.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 12:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xmGmOOl5gLGli7OvUQS4McOy7NB6xPaIApbCKtCeXYk=;
        b=f8/b3x4fYWIUj58vxbwcT1zj5CSOCsV5h++6plCNXoHkOlz5+HIWFBcJy1hj9Iocmy
         Q6KvNGUaf7Ktx8T3H3MKSb0yiSTTXPOtIV4i3w5okfxXhRQn9jfimGy2D5TlehUTq6Ly
         3gZ8euFDfy2U4nl63gvxc9icwAuOlc7jkm8dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmGmOOl5gLGli7OvUQS4McOy7NB6xPaIApbCKtCeXYk=;
        b=C7Y/l9UDTx8c+3WzJ2sgVyj4akjcZW6lmjjXhoubr+SJNLoANXQfBmF6PT6Dj6Zo7W
         g9MjanGRxzSMBlCxNQujzvVZtbYl/NpQ3DYqHHCyylwKV5Pr2/clJUHiEdP3FHP/2fIi
         7s1lSsxEkR5gS3r5M27yJhXrUQ5MS7Q3sAnZQCywSDwmxBoTflVrC/KJLSfhsL83G1wB
         ZtZROjvkfjDOm5sv/nuhwA/8KZB+peQLke9fehsP4YQKO+/7b2/QW/NdQ0XbCB6P6Hw6
         B3jkYFGKxMTsdeHaTa/y4tGQ+HRPFPVRBxBQt6x2WbtajTcM4V4D9kzcUJZFh/w1JEcF
         ZXrQ==
X-Gm-Message-State: AOAM531BEG4Hv1jo7097qjtorGpCgsGN/V5Nuz8AJ+yQiK2Q+y2t2c31
        AdFlqGLcog1LLcFmItUCwsrIAS2o1N0=
X-Google-Smtp-Source: ABdhPJzFoMvdYVsiPvl9qLjReNJrDj4OPhXy33f5UL/VM8cwLzO3yAV/HhBuND+4ZQReEj4HBpaspA==
X-Received: by 2002:a2e:7508:: with SMTP id q8mr2073507ljc.190.1590692670371;
        Thu, 28 May 2020 12:04:30 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id w14sm1777960lfe.65.2020.05.28.12.04.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:04:29 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id x27so17199044lfg.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 12:04:28 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr2405859lfn.10.1590692668401;
 Thu, 28 May 2020 12:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org> <87eer4ysm5.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87eer4ysm5.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 12:04:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQAgKnEX3V_vep3Ah392tjiekDspnu+y6kkx2oFZBV=g@mail.gmail.com>
Message-ID: <CAHk-=wgQAgKnEX3V_vep3Ah392tjiekDspnu+y6kkx2oFZBV=g@mail.gmail.com>
Subject: Re: [PATCH 01/11] exec: Reduce bprm->per_clear to a single bit
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
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

On Thu, May 28, 2020 at 8:45 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> -       me->personality &= ~bprm->per_clear;
> +       if (bprm->per_clear)
> +               me->personality &= ~PER_CLEAR_ON_SETID;\

My only problem with this patch is that I find that 'per_clear' thing
to be a horrid horrid name,

Obviously the name didn't change, but the use *did* change, and as
such the name got worse. It used do do things like

               bprm->per_clear |= PER_CLEAR_ON_SETID;

and now it does

               bprm->per_clear = 1;

and honestly, there's a lot more semantic context in the old code that
is now missing entirely. At least you used to be able to grep for
PER_CLEAR_ON_SETID and it would make you go "Ahh.."

Put another way, I can kind of see what a line like

               bprm->per_clear |= PER_CLEAR_ON_SETID;

does, simply because now it kind of hints at what is up.

But what the heck does

               bprm->per_clear = 1;

mean? Nothing. You have to really know the code. "per_clear" makes no
sense, and now it's a short line that doesn't need to be that short.

I think "bprm->clear_personality_bits" would maybe describe what the
_effect_ of that field is. It doesn't explain _why_, but it at least
explains "what" much better than "per_clear", which just makes me go
"per what?".

Alternatively, "bprm->creds_changed" would describe what the bit
conceptually is about, and code like

          if (bprm->creds_changed)
                  me->personality &= ~PER_CLEAR_ON_SETID;\

looks sensible to me and kind of matches the comment about the
PER_CLEAR_ON_SETID bits are.

So I think that using a bitfield is fine, but I'd really like it to be
named something much better.

Plus changing the name means that you can't have any code that now
mistakenly uses the new semantics but expects the old bitmask.
Generally when something changes semantics that radically, you want to
make sure the type changes sufficiently that any out-of-tree patch
that hasn't been merged yet will get a clear warning or error if
people don't realize.

Please?

           Linus
