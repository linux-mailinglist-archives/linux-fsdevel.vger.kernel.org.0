Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53642668A04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 04:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjAMDUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 22:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAMDUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:20:35 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC804564D1;
        Thu, 12 Jan 2023 19:20:33 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b12so14133870pgj.6;
        Thu, 12 Jan 2023 19:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IE1N6q431EH2Cia2rHnQiwX6cEP2dOIyuc9iQ5HCLQ=;
        b=McFoz0MqXOreEmQQJ9nny3bbNsPqjRHSzaSdX/dkWn8CkWDuwl61Z8MJHH6txvlknv
         /BwDPLanerw2yEcndUp3dkvSiG0A93XrL/reZO1XYvw6ms8mYvStUxLN33zHSlaGbIvv
         IZPXBdhHNRZtQ332kAD+ryuxuv/Yt+U6mZWrinsMY+kZB90nTZUd5RZJmqPf/NUxCVK5
         yo+zR+5iL3rE28CPneE9dVuOmbeF+qFNulb8Vy9+WDVNovIZl1hPGRVZSI9i2GDbyMf9
         KMDpB62ncrXD7kL2d6tZe7f4Hvyuv0OGD3Y2GcU3cz/APVCx+pbRWPvi9EE/6VZ9SCyu
         51HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/IE1N6q431EH2Cia2rHnQiwX6cEP2dOIyuc9iQ5HCLQ=;
        b=6V4lcxstuhiYAmTc0FjywSQfi808AT3mpS0mbxKsR0pImntZHKYFTSCFHsDKG9Npv8
         ehvMESRBfINzVuyhFiovuB/vJIg4GdphROxn7lB4LQya0gOFVOi3GFo99s/3COHkIpAd
         mxzpZqukuEfjvcx/rTJTDLzZIo9KHOckBloGJ1SjeCg2wMDjvV+L0YVwHyLATY99pLsq
         gB/RuYDQf/HNXBH4TGyOW5JQd2PbkMNrA6wZt2S74LvGofIF0+f8Ps/uasHoBhk8nR1V
         rBbdU5d/8HUOOFUD6kJ889tgebnwTXtO2clCfiTGTy3wmTX9pP7Za7wVI/Gi/bra3ULM
         yKUg==
X-Gm-Message-State: AFqh2kqfLoUC6c8M1fQ2qpuZl6TO1NoswmA5HIXlVMG5vwsPuBOLOZ1o
        3BcciImSaABQxTLYg7N3QuQ=
X-Google-Smtp-Source: AMrXdXutHGiYAKxpxTgqueAfTzxcqrxv3NpMYbLi21VagD3RA/oUhBOiCEmYLqICtn4v7X0/MD9Y9g==
X-Received: by 2002:a62:1a0d:0:b0:582:7664:e912 with SMTP id a13-20020a621a0d000000b005827664e912mr38064232pfa.12.1673580033240;
        Thu, 12 Jan 2023 19:20:33 -0800 (PST)
Received: from localhost (193-116-88-198.tpgi.com.au. [193.116.88.198])
        by smtp.gmail.com with ESMTPSA id 145-20020a621697000000b00588d5c8b633sm8290654pfw.51.2023.01.12.19.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 19:20:32 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 13 Jan 2023 13:20:25 +1000
Message-Id: <CPQQLU1ISBIJ.2SHU1BOMNO7TY@bobo>
Cc:     <tony.luck@intel.com>, <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>,
        "Jan Glauber" <jan.glauber@gmail.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>
Subject: Re: lockref scalability on x86-64 vs cpu_relax
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Mateusz Guzik" <mjguzik@gmail.com>,
        "linux-arch" <linux-arch@vger.kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>
X-Mailer: aerc 0.13.0
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com> <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri Jan 13, 2023 at 10:13 AM AEST, Linus Torvalds wrote:
> [ Adding linux-arch, which is relevant but not very specific, and the
> arm64 and powerpc maintainers that are the more specific cases for an
> architecture where this might actually matter.
>
>   See
>
>         https://lore.kernel.org/all/CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ=
-aSeOofkA_=3DWdA@mail.gmail.com/
>
>   for original full email, but it might be sufficiently clear just
> from this heavily cut-down context too ]
>
> Side note on your access() changes - if it turns out that you can
> remove all the cred games, we should possibly then revert my old
> commit d7852fbd0f04 ("access: avoid the RCU grace period for the
> temporary subjective credentials") which avoided the biggest issue
> with the unnecessary cred switching.
>
> I *think* access() is the only user of that special 'non_rcu' thing,
> but it is possible that the whole 'non_rcu' thing ends up mattering
> for cases where the cred actually does change because euid !=3D uid (ie
> suid programs), so this would need a bit more effort to do performance
> testing on.
>
> On Thu, Jan 12, 2023 at 5:36 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > To my understanding on said architecture failed cmpxchg still grants yo=
u
> > exclusive access to the cacheline, making immediate retry preferable
> > when trying to inc/dec unless a certain value is found.
>
> I actually suspect that is _always_ the case - this is not like a
> contended spinlock where we want to pause because we're waiting for
> the value to change and become unlocked, this cmpxchg loop is likely
> always better off just retrying with the new value.

Yes this should be true for powerpc (POWER CPUs, at least).

> That said, the "likely always better off" is purely about performance.
>
> So I have this suspicion that the reason Tony added the cpu_relax()
> was simply not about performance, but about other issues, like
> fairness in SMT situations.
>
> That said, evern from a fairness perspective the cpu_relax() sounds a
> bit odd and unlikely - we're literally yielding when we lost a race,
> so it hurts the _loser_, not the winner, and thus might make fairness
> worse too.

Worse is that we've also actually just *won* a race when the cmpxchg
comes back, i.e., to get the line exclusive in our cache line. Then
we'll just sit there waiting and probably holding off other snoopers
for a while.

I don't see much of a fairness concern really. If there's a lot of
contention here we'll be stalled for a long time waiting on the line,
so SMT heuristics had better send resources to other threads making
better progress anyway as it should for any cache miss situation. So
this loop shouldn't be hogging up a lot of resources from the other
thread(s).

> I dunno.  Tony may have some memory of what the issue was.
>
> > ... without numbers attached to it. Given the above linked thread it
> > looks like the arch this was targeting was itanium, not x86-64, but
> > the change landed for everyone.
>
> Yeah, if it was ia64-only, it's a non-issue these days. It's dead and
> in pure maintenance mode from a kernel perspective (if even that).
>
> > Later it was further augmented with:
> > commit 893a7d32e8e04ca4d6c882336b26ed660ca0a48d
> > Author: Jan Glauber <jan.glauber@gmail.com>
> > Date:   Wed Jun 5 15:48:49 2019 +0200
> >
> >     lockref: Limit number of cmpxchg loop retries
> > [snip]
> >     With the retry limit the performance of an open-close testcase
> >     improved between 60-70% on ThunderX2.
> >
> > While the benchmark was specifically on ThunderX2, the change once more
> > was made for all archs.
>
> Actually, in that case I did ask for the test to be run on x86
> hardware too, and exactly like you found:
>
> > I should note in my tests the retry limit was never reached fwiw.
>
> the max loop retry number just isn't an issue. It fundamentally only
> affects extremely unfair platforms, so it's arguably always the right
> thing to do.
>
> So it may be "ThunderX2 specific" in that that is where it was
> noticed, but I think we can safely just consider the max loop thing to
> be a generic safety net that hopefully simply never triggers in
> practice on any sane platform.
>

If there are a lot of threads contending I'm sure x86, POWER, probably
most CPUs could quite possibly starve for hundreds if not thousands or
more of iterations here.

And I'm not really a fan of scattering random implementation specific
crutches ad hoc throughout our primitives. At least it could be specific
to the arch where it matters.

Interesting that improves performance so much though. I wonder why?
Hitting the limit will take the lock and that will cause all other CPUs
to drop out of the "fast" path so it will degenerate to a spinlock.
queued spinlock is pretty scalable but it really shouldn't be more
scalable than an atomic OP. I bet this cpu_relax isn't helping, and
probably ll/sc implementation of cmpxchg primitive doesn't help either.

I reckon if you removed the cpu_relax there, big x86 systems actually
wouldn't want that limit because the occasional case where you might hit
the limit will switch behaviour to locking and you might not recover
back to atomics if there is continued pressure on it.

> > All that said, I think the thing to do here is to replace cpu_relax
> > with a dedicated arch-dependent macro, akin to the following:
>
> I would actually prefer just removing it entirely and see if somebody
> else hollers. You have the numbers to prove it hurts on real hardware,
> and I don't think we have any numbers to the contrary.
>
> So I think it's better to trust the numbers and remove it as a
> failure, than say "let's just remove it on x86-64 and leave everybody
> else with the potentially broken code"

Agree. powerpc almost certainly doesn't want it, we would indeed hit
the issue identified which is that we'd get the line exclusive then go
to sleep for a while holding off other snoopers for a bit then probably
losing the line.

It would be nice if ThunderX2 case could be re-tested without that retry
count and without the cpu_relax too.

> Because I do think that a cmpxchg loop that updates the value it
> compares and exchanges is fundamentally different from a "busy-loop,
> trying to read while locked",

It is. powerpc (and probably other ll/sc archs) usually doesn't like this
style of cmpxchg loop.

Firstly, an initial load could bring the line in shared at first, then
it goes exclusive with the larx so 2x the transactions, but actually
worse because if it's shared it can let other CPUs go shared as well,
then the exclusive has to shoot those down, etc.

And if the value changes between those two loads, we fail it and try
again whereas we could have done the update inside the reserve. The
core isn't too happy about seeing a larx when there is already a larx
outstanding because it's worried that it has gone out of order and so it
doesn't want to let the second larx stamp on the first one potentially
before the stcx for the first one has executed. So it can hold the larx
until its the oldest instruction waiting for a stcx that never comes.
It's possible our cmpxchg primitives would actually do better with a
dummy stcx in the failure case to resolve that, but it's not necessarily
better. We don't have a light-weight cancel-reservation instruction
which is what we'd really want. The joys of ll/sc.

Actually what we'd really want is an arch specific implementation of
lockref.

Thanks,
Nick
