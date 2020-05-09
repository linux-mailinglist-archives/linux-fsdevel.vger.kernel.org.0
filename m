Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7881CC409
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 21:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgEITS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 15:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727938AbgEITS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 15:18:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91029C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2020 12:18:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so5212290ljd.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTaQjuSq7+Uk0mjz5XhiS0By4Z0ZIBHeP5OQxoY0AXY=;
        b=bb8lv33/xdxQCjzNvqgBwiUcCYj652YvhdbqcvSHcY1rj9neVWryv4l1j6MmeGq4jo
         AEH6Z8NxA7GKp1r/srByCIJnplyXBSDQ62DfynP6rinchtYP4IYYLHytr7y6o8ZD6J1K
         ZVP3pi5JLSulmR+djlIuZSg8uAVtxAHd0IwZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTaQjuSq7+Uk0mjz5XhiS0By4Z0ZIBHeP5OQxoY0AXY=;
        b=jjhMuVDTTrmLsDlhuZSHEecceFoEMxiYGgWh2Y4cDn8Cen8rtgjFykYVKACRSnVIYY
         Fg0+fCuc9TV7MIMPwwhYx2Z3LAXv4QLX5g6oAAieDKntQ/2jJ3lB90Na5ZjA4X8tc8Pg
         zAZVAs3F5MQxlbVEpMgtvArA8RhNyKG6+UmLiarH6lhjL/hUAbK4XxfwCl3mdrCtAIsK
         HZ9D005HLMFEzf/mxF9Xwv+ALjexbnvl6O5KPwIjafUW+z0r6/IUpPy6URi2Q3OLimc3
         oyCC6x/9gRbP4sUP/YbSJZdiFGn5Pc48PlKjFDx6C76oV1ACyPnKDV9jcP8vc7oNqdiD
         tecw==
X-Gm-Message-State: AOAM531eWjE354nob6Tf4R6P7e8RvbIJRd70mCms7aLusNu+Tkqguqru
        o/xw9DmyxzWw7Ji6P53kSpmhta5BFhI=
X-Google-Smtp-Source: ABdhPJxqL7JBaf9MCLvk5kgSBZfPjXeBH27v6yNZo/FrOT+t40A6vq7Qx80mrlWZ0XwfYhDAwGuyYg==
X-Received: by 2002:a2e:8590:: with SMTP id b16mr5728311lji.45.1589051904705;
        Sat, 09 May 2020 12:18:24 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y9sm4505596ljy.31.2020.05.09.12.18.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 12:18:23 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id b26so4108914lfa.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 12:18:23 -0700 (PDT)
X-Received: by 2002:ac2:418b:: with SMTP id z11mr5854254lfh.30.1589051902927;
 Sat, 09 May 2020 12:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87blmy6zay.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87blmy6zay.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 12:18:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguq6FwYb8_WZ_ZOxpHtwyc0xpz+PitNuf4pVxjWFmjFQ@mail.gmail.com>
Message-ID: <CAHk-=wguq6FwYb8_WZ_ZOxpHtwyc0xpz+PitNuf4pVxjWFmjFQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] exec: Stop open coding mutex_lock_killable of cred_guard_mutex
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
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 8, 2020 at 11:48 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
> Oleg modified the code that did
> "mutex_lock_interruptible(&current->cred_guard_mutex)" to return
> -ERESTARTNOINTR instead of -EINTR, so that userspace will never see a
> failure to grab the mutex.
>
> Slightly earlier Liam R. Howlett defined mutex_lock_killable for
> exactly the same situation but it does it a little more cleanly.

What what what?

None of this makes sense. Your commit message is completely wrong, and
the patch is utter shite.

mutex_lock_interruptible() and mutex_lock_killable() are completely
different operations, and the difference has absolutely nothing to do
with  -ERESTARTNOINTR or -EINTR.

mutex_lock_interruptible() is interrupted by any signal.

mutex_lock_killable() is - surprise surprise - only interrupted by
SIGKILL (in theory any fatal signal, but we never actually implemented
that logic, so it's only interruptible by the known-to-always-be-fatal
SIGKILL).

> Switch the code to mutex_lock_killable so that it is clearer what the
> code is doing.

This nonsensical patch makes me worry about all your other patches.
The explanation is wrong, the patch is wrong, and it changes things to
be fundamentally broken.

Before this, ^C would break out of a blocked execve()/ptrace()
situation. After this patch, you need special tools to do so.

This patch is completely wrong.

And Kees, what the heck is that "Reviewed-by" for? Worthless review too.

                Linus
