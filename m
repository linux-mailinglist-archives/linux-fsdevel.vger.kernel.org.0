Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3C69116A41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 10:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfLIJyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 04:54:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34729 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfLIJyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:54:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so10200701lfc.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 01:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrN+istqMjTsOK45GjMp/wgqCgFHWcl6iEK6o+bDYyM=;
        b=FYhpnVQxjhJIIqGoA+uTyUBGndUjSdhRjhXD+hmCdSzrzcpK+TmYWixigujmqBc29g
         cQw4LhNbscwXEXbw3rcU3LO+yNZN4dWwwT14yLzwBt9UGVsjKQbYKzNpmVOFq7TREiV0
         tqL0VFCdHZ7v3c0GfjYLk46UAROJtl3WhUQa0/HUPL0P9aGB82cOgEJhIJuPNXgtlTgv
         XChrtF2KrAZb9Z8WH9sR7PodmzJ/MB6tRnFFCYP7241+kzzZXN0qeNTcontRvE52wIaE
         rVJuNBmIDPVwSZFdkYk198+xipgQqNpucAQrUMGlkaE0GDJ7z7nae9MUvq4veoX7s7YH
         UZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrN+istqMjTsOK45GjMp/wgqCgFHWcl6iEK6o+bDYyM=;
        b=B6mgcOfnY74QdQd8VIt/gisott/8R2Y/F5BKRgzE42kvFhrq3r2DrifRPXOHZiSGUY
         ufuBGbuw3dRDNa4Rxi2l6YyOM6BTKFAlcca+qiYNNEtPRN0kp7jq8uJ8St2u/wA2zM4t
         nNgz2lhoRsEAiS2n5avNwd0r52QV17hk/6nFsNDhyBREJUpeio49UANScmQIXBK8dcDV
         TqgyqmTo9waIWM3tNs2r6qJtTrreuJ3A9afh3FgXO3jfpXeQxkQFI47NS8NcxaL7R518
         P7rqX3xCehTavxUEzUlWj6JlK3YLqMilu0JndrTAhIEwDD5NXixQnOeAHdsEUvEOFzbz
         Wotw==
X-Gm-Message-State: APjAAAUxJnWvlddsEK0uvBq8TxiWd1108paNb+J94o0YZdnpinBCPvFZ
        zmkAHR3WDPHbdfjK4c4STPnuyntZs2q6bukNEATWw7QSAx8=
X-Google-Smtp-Source: APXvYqwfvOkeVUH5fg2kwnMXipvPVRUV+ZauWZg2WGQOLmGb4ZjQarFMEQy8e9EIVX91PBR/vHMnpU9Wsyptxc0KP8Y=
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr13538590lfl.125.1575885238439;
 Mon, 09 Dec 2019 01:53:58 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com> <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
In-Reply-To: <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 9 Dec 2019 10:53:46 +0100
Message-ID: <CAKfTPtDBtPuvK0NzYC0VZgEhh31drCDN=o+3Hd3fUwoffQg0fw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 7 Dec 2019 at 23:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Dec 6, 2019 at 7:50 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The "make goes slow" problem bisects down to b667b8673443 ("pipe:
> > Advance tail pointer inside of wait spinlock in pipe_read()").
>
> I'm not entirely sure that ends up being 100% true. It did bisect to
> that, but the behavior wasn't entirely stable. There definitely is
> some nasty timing trigger.
>
> But I did finally figure out what seems to have been going on with at
> least the biggest part of the build performance regression. It's seems
> to be a nasty interaction with the scheduler and the GNU make
> jobserver, and in particular the pipe wakeups really _really_ do seem
> to want to be synchronous both for the readers and the writers.
>
> When a writer wakes up a reader, we want the reader to react quickly
> and vice versa. The most obvious case was for the GNU make jobserver,
> where sub-makes would do a single-byte write to the jobserver pipe,
> and we want to wake up the reader *immediatly*, because the reader is
> actually a lot more important than the writer. The reader is what gets
> the next job going, the writer just got done with the last one.
>
> And when a reader empties a full pipe, it's because the writer is
> generating data, and you want to just get the writer going again asap.
>
> Anyway, I've spent way too much time looking at this and wondering
> about odd performance patterns. It seems to be mostly back up to
> normal.
>
> I say "mostly", because I still see times of "not as many concurrent
> compiles going as I'd expect". It might be a kbuild problem, it might
> be an issue with GNU make (I've seen problems with the make jobserver
> wanting many more tokens than expected before and the kernel makefiles
> - it migth be about deep subdirectories etc), and it might be some
> remaining pipe issue. But my allmodconfig builds aren't _enormously_
> slower than they used to be.
>
> But there's definitely some unhappy interaction with the jobserver. I
> have 16 threads (8 cores with HT), and I generally use "make -j32" to
> keep them busy because the jobserver isn't great. The pipe rework made
> even that 2x slop not work all that well. Something held on to tokens
> too long, and there was definitely some interaction with the pipe
> wakeup code. Using "-j64" hid the problem, but it was a problem.
>
> It might be the new scheduler balancing changes that are interacting
> with the pipe thing. I'm adding PeterZ, Ingo and Vincent to the cc,
> because I hadn't realized just how important the sync wakeup seems to
> be for pipe performance even at a big level.

Which version of make should I use to reproduce the problem ?
My setup is not the same and my make is a bit old but I haven't been
able to reproduce the problem described above on my arm64 octa cores
system and v5.5-rc1.
All cores are busy with -j16. And even -j8 keeps the cores almost always busy

>
> I've pushed out my pipe changes. I really didn't want to do that kind
> of stuff at the end of the merge window, but I spent a lot more time
> than I wanted looking at this code, because I was getting to the point
> where the alternative was to just revert it all.
>
> DavidH, give these a look:
>
>   85190d15f4ea pipe: don't use 'pipe_wait() for basic pipe IO
>   a28c8b9db8a1 pipe: remove 'waiting_writers' merging logic
>   f467a6a66419 pipe: fix and clarify pipe read wakeup logic
>   1b6b26ae7053 pipe: fix and clarify pipe write wakeup logic
>   ad910e36da4c pipe: fix poll/select race introduced by the pipe rework
>
> the top two of which are purely "I'm fed up looking at this code, this
> needs to go" kind of changes.
>
> In particular, that last change is because I think the GNU jobserver
> problem is partly a thundering herd issue: when a job token becomes
> free (ie somebody does a one-byte write to an empty jobserver pipe),
> it wakes up *everybody* who is waiting for a token. One of them will
> get it, and the others will go to sleep again. And then it repeats all
> over. I didn't fix it, but it _could_ be fixed with exclusive waits
> for readers/writers, but that means more smarts than pipe_wait() can
> do. And because the jobserver isn't great at keeping everybody happy,
> I'm using a much bigger "make -jX" value than the number of CPU's I
> have, which makes the herd bigger. And I suspect none of this helps
> the scheduler pick the _right_ process to run, which just makes
> scheduling an even bigger problem.
>
>             Linus
