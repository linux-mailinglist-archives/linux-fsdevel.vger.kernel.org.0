Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF092D7D0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 18:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405520AbgLKRhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 12:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395387AbgLKRhR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:37:17 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6018C061248
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 09:36:04 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y22so11783526ljn.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 09:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gRMetona612aZg2wWS92XJvreyw/EI82eqLu+eZfclw=;
        b=ZCkbGhWVHEWrj0coPlurDxgWKb+XOKp8wNf6a3JUOJOoHoneJLbK5UPubMd9Q5HzpY
         vRWlg7xG/xludMCxOGCDdntL4U3aPBP88fb6NKvLcnVZNA9qZB8wPbLgIu1g42JT7HgU
         L8H+3CwXZ5IfOVehi5f8N0dlj54OFJCmCpOcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRMetona612aZg2wWS92XJvreyw/EI82eqLu+eZfclw=;
        b=hktagMpHaAt5OUqwD/fBd39MG19EFeIM1Fwo8+RJrzY39prCzTcZ/Uwv4kzPxKNIvl
         MIVV8N4lz3hbZZBET1GkHYVyXUcZaFcpHfFBdm0/jgQjE2WgJv+CoSQ37uEiCE11BV+V
         nw3bRYwTDtptOHe2V7hIcG9Pnwn6WTb1u+w2uiHJtGBfEkf7/+PmLxYXq7ryz96A/vl/
         7MqHrIQkiJkXdx4U0RoAipvozQO4Y2nRp+FnjBdyUlR0HnpAz89k89jOw7XEQwHlJID5
         XUnya0XvsnXVpLHRfS/G1/ZfV1Ygr+cz0eyLlsNMF9fMASTEqav8Ul68TVP4dx4LCV5S
         YUww==
X-Gm-Message-State: AOAM53264+mEmlEbFeOMuV8Ro4Wz2o0h0+uOInmeZOJmasANnOjVQDle
        cjkwHsDRSGfMbFscXkuQxKqHtzCCq/ENlQ==
X-Google-Smtp-Source: ABdhPJzTBB1KroFud1TEqNM+zBm34zBE++NgFBFR/q5aWdXLFc+HrCJ9X/nGPPcoAbQCk8CC49jZXA==
X-Received: by 2002:a2e:98d9:: with SMTP id s25mr5141164ljj.476.1607708162521;
        Fri, 11 Dec 2020 09:36:02 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id h8sm388485ljj.33.2020.12.11.09.36.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 09:36:01 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id b10so9492517ljp.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 09:36:01 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr5661626ljm.507.1607708160917;
 Fri, 11 Dec 2020 09:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20201210200114.525026-1-axboe@kernel.dk> <20201210200114.525026-2-axboe@kernel.dk>
 <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
 <139ecda1-bb08-b1f2-655f-eeb9976e8cff@kernel.dk> <20201211024553.GW3579531@ZenIV.linux.org.uk>
 <89f96b42-9d58-cd46-e157-758e91269d89@kernel.dk> <20201211172054.GX3579531@ZenIV.linux.org.uk>
In-Reply-To: <20201211172054.GX3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Dec 2020 09:35:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgSe_ZmHTjpVw5VJ6zrmKxR4oH3hx=ZvQf4w4h4rhVCQ@mail.gmail.com>
Message-ID: <CAHk-=whgSe_ZmHTjpVw5VJ6zrmKxR4oH3hx=ZvQf4w4h4rhVCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 9:21 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Explain, please.  What's the difference between blocking in a lookup and
> blocking in truncate?  Either your call site is fine with a potentially
> long sleep, or it is not; I don't understand what makes one source of
> that behaviour different from another.

So I'm not Jens, and I don't know exactly what io_uring loads he's
looking at, but the reason I'm interested in this is that this is very
much not the first time this has come up.

The big difference between filename lookup and truncate is that one is
very common indeed, and the other isn't.

Sure, something like truncate happens. And it might even be a huge
deal and very critical for some load. But realistically, I don't think
I've ever seen a load where if it's important, and you can do it
asynchronously, you couldn't just start a thread for it (particularly
a kthread).

> "Fast path" in context like "we can't sleep here, but often enough we
> won't need to; here's a function that will bail out rather than blocking,
> let's call that and go through offload to helper thread in rare case
> when it does bail out" does make sense; what you are proposing to do
> here is rather different and AFAICS saying "that's my fast path" is
> meaningless here.

The fast path context here is not "we can't sleep here".

No, the fast-path context here is "we want highest performance here",
with the understanding that there are other things to be done. The
existing code already simply starts a kernel thread for the open - not
because it "can't sleep", but because of that "I want to get this
operation started, but there are other things I want to start too".

And in that context, it's not about "can't sleep". It's about "if we
already have the data in a very fast cache, then doing this
asynchronously with a thread is SLOWER than just doing it directly".

In particular it's not about correctness: doing it synchronously or
asynchronously are both "equally correct". You get the same answer in
the end. It's purely about that "if we can do it really quickly, it's
better to just do it".

Which gets me back to the first part: this has come up before. Tux2
used to want to do _exactly_ this same thing.

But what has happened is that
 (a) we now have a RCU lookup that is an almost exact match for this
and
 (b) we now have a generic interface for user space to use it in the
form of io_uring

So this is not about "you have to get it right".  In fact, if it was,
the RCU lookup model would be the wrong thing, because the RCU name
lookup is optimistic, and will fail for a variety of reasons.

Bo, this is literally about "threads and synchronization is a real
overhead, so if you care about performance, you don't actually want to
use them if you can do the operation so fast that the thread and
synchronization overhead is a real issue".

Which is why LOOKUP_RCU is such a good match.

And while Tux was never very successful because it was so limited and
so special, io_uring really looks like it could be the interface to
make a lot of performance-sensitive people happy. And getting that
"low-latency cached behaviour vs bigger operations that might need
lots of locks or IO" balance right would be a very good thing, I
suspect.

            Linus
