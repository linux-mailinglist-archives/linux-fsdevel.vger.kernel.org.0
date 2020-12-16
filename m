Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F9A2DB9B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 04:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgLPDkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 22:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPDkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:40:51 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FBCC0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 19:40:10 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id p5so21297491iln.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 19:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2euMQXTSmTH9cGZBYC6xKCOdLkgCzCEb6e5P3VCiPGo=;
        b=Vv0zx/sDxUVQDmc3a6ZGga1f7sXAynI+GzScgA7OsysVu49iyQFGn4hcBscMlVQScY
         /aYJBB4HwSlAyJaG6xzU6gVote5yJ29hitS9HvD9IQH514ofu/fEMe6+t7vPQ6t2NMNB
         rIW8F0BayGhF4E8RMo86tc7jmS+pxR4RpRuxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2euMQXTSmTH9cGZBYC6xKCOdLkgCzCEb6e5P3VCiPGo=;
        b=PBSiLFSgrabDXreYu0En/rvWK/eHFaNIz27DKLJjrxdyCUk7l98GLFKe3YcXgN7wMq
         L7+eYntn/iKVXUwUMtgAU0++Sz22RllqYDBWe+O6msjbeyK6GXIa7wdtaVkwBM2v0uLp
         zI/7OVvYWbaXBgNH5x9qPsZC/xNhzjre9uxQU9q5ARbNuPeYsh+YqjjMG2SBYk5exjXY
         7R4GrjbQ7ZjcDZWK5MtPR7KMGeYbbS3sQ8Wh3HPXnbQAqb18h2g+Z3RFWzcX2V9LhTGC
         jVXtmWr8b13X7m4pf6+0J1A9jVeIGeltZe0Y99EyEJwkd+FVNX43jJSrDZ9zR6NYEIW+
         Bomg==
X-Gm-Message-State: AOAM533WooHrhQFk8xNd5XyvmmVndedj6YwvEL87OomOQwy3Gio0C27L
        eXVSjB0RPqJw8g8jmVR9RUCcJ2nBnzeZiw==
X-Google-Smtp-Source: ABdhPJz8L0g0M6/99Lyg7B6jVIEeiqgS0vgpkhgBzoCNlsuSJhWP5o1Ivt/eAZCCJdWujZGBzwCJ6Q==
X-Received: by 2002:a92:a308:: with SMTP id a8mr45034693ili.13.1608090007793;
        Tue, 15 Dec 2020 19:40:07 -0800 (PST)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id t16sm309963ilb.50.2020.12.15.19.40.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 19:40:06 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id k8so21310055ilr.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 19:40:06 -0800 (PST)
X-Received: by 2002:a92:c6c9:: with SMTP id v9mr44187766ilm.161.1608090006766;
 Tue, 15 Dec 2020 19:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20201214191323.173773-1-axboe@kernel.dk> <20201214191323.173773-4-axboe@kernel.dk>
 <20201216023707.GI3579531@ZenIV.linux.org.uk>
In-Reply-To: <20201216023707.GI3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 19:39:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjjoygH4OUGwZL2CFfOtCznWKJL0JMny6VT2g40JffLzA@mail.gmail.com>
Message-ID: <CAHk-=wjjoygH4OUGwZL2CFfOtCznWKJL0JMny6VT2g40JffLzA@mail.gmail.com>
Subject: Re: [PATCH 3/4] fs: expose LOOKUP_NONBLOCK through openat2() RESOLVE_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 6:37 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > +     if (how->resolve & RESOLVE_NONBLOCK) {
> > +             /* Don't bother even trying for create/truncate open */
> > +             if (flags & (O_TRUNC | O_CREAT))
> > +                     return -EAGAIN;
>
> Why not O_TMPFILE here as well?

Yup, I think that's just missing.

           Linus
