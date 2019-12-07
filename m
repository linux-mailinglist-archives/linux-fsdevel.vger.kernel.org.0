Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2686115F8B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 23:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfLGWsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 17:48:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38484 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLGWsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 17:48:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id k8so11478220ljh.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Dec 2019 14:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+bzarr7WGG9UNw/1xFlnTHXwkh2li5KYb8dKx07T4w=;
        b=D6hYWc8qs0agBGRnbrYf1SDdMDgkvhKHwhdLZrSu85/3YN1ltTHpwMKTMhYoV/i120
         1onptQLl9ldf+3ruI4Bz9iKb/qrxCtvUs5vwPUmv15J/Ti+o0GKsC5Bp9Pf8ipD+F8TH
         n4jC3g0rUdz+iIu4PIDtkZQjZvGINraOeGlyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+bzarr7WGG9UNw/1xFlnTHXwkh2li5KYb8dKx07T4w=;
        b=oIfbH6j3ecsV7FcJ0g4mDADqE5YJwEdiDt+7si4ydL7WcgV732368XbfC/8ykhVHFc
         L+TLxhoihR7uO1r3QJdWmesKVFM12Y+5/+5fiad78i3Tv8dEd5JRad7B0Xz0IjOC7SQI
         4otsnR8P22B5EDDoqWQjNdN34X82JSRUuE24PLTuzNhtl1QKMebH2zsyaFXBTI/OI9kZ
         wh3p67zKwAx9mLvyT8paj7WGzoxMG90+LaIuRh+mmOJSWfE6A7p+Sh8///8Ow8y4pif4
         h9WKLF76N4h/NngUrqx+xqlwU12IF/80LU554bkDtHIEsD1LwdzcTgWCCa2u2J0vCP07
         m+LA==
X-Gm-Message-State: APjAAAX5kQ3CzQbGYul1H0exZXne5wUDFRUsgW+emrsgPp/gGL8VSFo0
        VARxsQ5L6OpqIBUy+0n6Ubunb+Snw9U=
X-Google-Smtp-Source: APXvYqy8912fzP/h8ASLHl+qrs2jmFLMaKxeCKo+jRr/VJBXfF7DgWDguXEs9ks62ecQoDdLEKrY6A==
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr12359648ljc.39.1575758891442;
        Sat, 07 Dec 2019 14:48:11 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u20sm8626023lju.34.2019.12.07.14.48.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 14:48:09 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id j6so11519662lja.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Dec 2019 14:48:09 -0800 (PST)
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr10211828ljg.82.1575758888845;
 Sat, 07 Dec 2019 14:48:08 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com> <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
In-Reply-To: <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Dec 2019 14:47:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
Message-ID: <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 6, 2019 at 7:50 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The "make goes slow" problem bisects down to b667b8673443 ("pipe:
> Advance tail pointer inside of wait spinlock in pipe_read()").

I'm not entirely sure that ends up being 100% true. It did bisect to
that, but the behavior wasn't entirely stable. There definitely is
some nasty timing trigger.

But I did finally figure out what seems to have been going on with at
least the biggest part of the build performance regression. It's seems
to be a nasty interaction with the scheduler and the GNU make
jobserver, and in particular the pipe wakeups really _really_ do seem
to want to be synchronous both for the readers and the writers.

When a writer wakes up a reader, we want the reader to react quickly
and vice versa. The most obvious case was for the GNU make jobserver,
where sub-makes would do a single-byte write to the jobserver pipe,
and we want to wake up the reader *immediatly*, because the reader is
actually a lot more important than the writer. The reader is what gets
the next job going, the writer just got done with the last one.

And when a reader empties a full pipe, it's because the writer is
generating data, and you want to just get the writer going again asap.

Anyway, I've spent way too much time looking at this and wondering
about odd performance patterns. It seems to be mostly back up to
normal.

I say "mostly", because I still see times of "not as many concurrent
compiles going as I'd expect". It might be a kbuild problem, it might
be an issue with GNU make (I've seen problems with the make jobserver
wanting many more tokens than expected before and the kernel makefiles
- it migth be about deep subdirectories etc), and it might be some
remaining pipe issue. But my allmodconfig builds aren't _enormously_
slower than they used to be.

But there's definitely some unhappy interaction with the jobserver. I
have 16 threads (8 cores with HT), and I generally use "make -j32" to
keep them busy because the jobserver isn't great. The pipe rework made
even that 2x slop not work all that well. Something held on to tokens
too long, and there was definitely some interaction with the pipe
wakeup code. Using "-j64" hid the problem, but it was a problem.

It might be the new scheduler balancing changes that are interacting
with the pipe thing. I'm adding PeterZ, Ingo and Vincent to the cc,
because I hadn't realized just how important the sync wakeup seems to
be for pipe performance even at a big level.

I've pushed out my pipe changes. I really didn't want to do that kind
of stuff at the end of the merge window, but I spent a lot more time
than I wanted looking at this code, because I was getting to the point
where the alternative was to just revert it all.

DavidH, give these a look:

  85190d15f4ea pipe: don't use 'pipe_wait() for basic pipe IO
  a28c8b9db8a1 pipe: remove 'waiting_writers' merging logic
  f467a6a66419 pipe: fix and clarify pipe read wakeup logic
  1b6b26ae7053 pipe: fix and clarify pipe write wakeup logic
  ad910e36da4c pipe: fix poll/select race introduced by the pipe rework

the top two of which are purely "I'm fed up looking at this code, this
needs to go" kind of changes.

In particular, that last change is because I think the GNU jobserver
problem is partly a thundering herd issue: when a job token becomes
free (ie somebody does a one-byte write to an empty jobserver pipe),
it wakes up *everybody* who is waiting for a token. One of them will
get it, and the others will go to sleep again. And then it repeats all
over. I didn't fix it, but it _could_ be fixed with exclusive waits
for readers/writers, but that means more smarts than pipe_wait() can
do. And because the jobserver isn't great at keeping everybody happy,
I'm using a much bigger "make -jX" value than the number of CPU's I
have, which makes the herd bigger. And I suspect none of this helps
the scheduler pick the _right_ process to run, which just makes
scheduling an even bigger problem.

            Linus
