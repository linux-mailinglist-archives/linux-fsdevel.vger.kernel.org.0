Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA22D9EAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 19:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440544AbgLNSH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 13:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440020AbgLNSHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:07:24 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24D3C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 10:06:43 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 23so32458614lfg.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 10:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hit8h4ESFzLD2aZUmbjsdA8DAR+89Dl324fKdk1F1es=;
        b=LtAn/9pezEs7qht34GBhYcUMojtLlHZ2QHntz4DsoZSodhKi9expi4rRE4xXDPrHpq
         SzXZQ1aFMdNgSHX1Famm7cxkBb4x31pG039EQh3clMHDIWbV8MIo7+zBvdOV9fqeFp5s
         Xn0BeLdEMTAFyJvSQStdZf36Jngv6XWKIm7p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hit8h4ESFzLD2aZUmbjsdA8DAR+89Dl324fKdk1F1es=;
        b=I8QR3vtxG3iGbP/jv2Gu7it7oMvKV+6WuEzSleH3GvkI/Ecmn8tBcoVVRmaUmEcQ5X
         tK3oYiuHIIKuMjhYNW/tF7ArDzHs19jYR/mLLjnVGT2bDLTeutR2VR9nyJ/ZuohUGaOU
         IVpntkcYigKs2WN5pA2bsnKMnpV+MEA3s5Q2NLy35SfBbV0d6P/Rszer+MdChnzA6hrX
         fwnOEb/ntrj6K8J73U07flzAasSbZ4T57h0Th5oOGy5YkZODs1r85He7iMTCiOEFAILK
         ApDPGPO2mX5wqcPAtVN48AnQFstHVt1Ozfj1UcmECVlxxcK+EYPspEWss93SJHubukzE
         Kygg==
X-Gm-Message-State: AOAM53287L12uhzNmc7YzIcSAjkt/R9Xdxd3kJxCsZc9eWhzAqXK7kYj
        i38+0KIMO8eQqTRutrxhc11pIE67nhp6zw==
X-Google-Smtp-Source: ABdhPJwvY0qdia1AzvunxlVFnEd7WGyCt6tsckb34YTKSyJfZ9Oty7eFewG7IsS/x6gf7O635ONjoQ==
X-Received: by 2002:a19:8606:: with SMTP id i6mr10964456lfd.350.1607969201085;
        Mon, 14 Dec 2020 10:06:41 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id y12sm2171487lfy.300.2020.12.14.10.06.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 10:06:39 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id x20so12917394lfe.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 10:06:39 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr10700872lji.251.1607969198940;
 Mon, 14 Dec 2020 10:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20201212165105.902688-1-axboe@kernel.dk> <20201212165105.902688-5-axboe@kernel.dk>
 <CAHk-=wiA1+MuCLM0jRrY4ajA0wk3bs44n-iskZDv_zXmouk_EA@mail.gmail.com>
 <8c4e7013-2929-82ed-06f6-020a19b4fb3d@kernel.dk> <20201213225022.GF3913616@dread.disaster.area>
 <CAHk-=wg5AXnXE3bjqj0fgH2os1ptKeF-ee6i0p5GCw1o63EdgQ@mail.gmail.com> <20201214015248.GG3913616@dread.disaster.area>
In-Reply-To: <20201214015248.GG3913616@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Dec 2020 10:06:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh90545S-_aR0kEz3+26fi711FoO9A5LXv_R0DxEfthaQ@mail.gmail.com>
Message-ID: <CAHk-=wh90545S-_aR0kEz3+26fi711FoO9A5LXv_R0DxEfthaQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] fs: honor LOOKUP_NONBLOCK for the last part of file open
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 13, 2020 at 5:52 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sun, Dec 13, 2020 at 04:45:39PM -0800, Linus Torvalds wrote:
> > On Sun, Dec 13, 2020 at 2:50 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > >
> > > > > Only O_CREAT | O_TRUNC should matter, since those are the ones that
> > > > > cause writes as part of the *open*.
> > >
> > > And __O_TMPFILE, which is the same as O_CREAT.
> >
> > This made me go look at the code, but we seem to be ok here -
> > __O_TMPFILE should never get to the do_open() logic at all, because it
> > gets caught before that and does off to do_tmpfile() and then
> > vfs_tmpfile() instead.
> >
> > And then it's up to the filesystem to do the inode locking if it needs
> > to - it has a separate i_io->tempfile function for that.
>
> Sure, and then it blocks.

Yes. I was more just double-checking that currently really odd

        if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {

condition that didn't make sense to me (it basically does two
different kinds of writablity checks). So it was more that you pointed
out that __O_TMPFILE was also missing from that odd condition, and
that turns out to be because it was handled separately.

So no disagreement about __O_TMPFILE being a "not a cached operation"
- purely a "that condition is odd".

It was just that O_WRONLY | O_RDWR didn't make tons of sense to me,
since we then get the write count only to then drop it immediately
immediately without having actually done any writes.

But I guess they are there only as a "even if we don't write to the
filesystem right now, we do want to get the EROFS error return from
open(), rather than at write() time".

I think technically it shouldn't need to do the pointless "synchronize
and increment writers only to decrement them again" dance, and could
just do a "mnt_is_readonly()" test for the plain "open writably, but
without O_CREAT/O_TRUNC" case.

But I guess there's no real downside to doing it the way we're doing
it - it just looked odd to me when I was looking at it in the context
of just pathname lookup.

In do_faccessat() we have that bare __mnt_is_readonly() for the "I
want EROFS, but I'm not actually writing now" case.

            Linus
