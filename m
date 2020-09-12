Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF0C267C41
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 22:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgILUdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 16:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgILUc5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 16:32:57 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF8AC061573;
        Sat, 12 Sep 2020 13:32:57 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id di5so6978646qvb.13;
        Sat, 12 Sep 2020 13:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K1qbVxia3WZiTfVB02YSq1pCnj48i+WbchFzwtZcl60=;
        b=qThkYvIxyy/sSlxrk0L1GahcfGa+XGSMiSagyqC6dbp/ZaehI8PdIdbOF3lU5gS++1
         dk2v6oY9PiB7H1UPl+5n2migpGVdCPoPQJuu8fmNT+t1WgVM2FJCH8T06mKUMvqTuGIL
         sZQxBxyBrT5tqnndH3NbFGGVoeKUxgj/8E8S1+blueeEmHaSh0Ds4a5cGAp7rNa2atyi
         Y6yJ8gyjPJZTasiniStAEE5uKvzWbHCfbB+hvlLcMcVePYLXCgFqv5Wsc6Nty775jL2F
         Jp9QOUF81iDc+oN3tCavPyBLeMB7+rsxoCm2K6iQ59rDtVJaOvVZJiEu0g6TZ2htnEq6
         VFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K1qbVxia3WZiTfVB02YSq1pCnj48i+WbchFzwtZcl60=;
        b=fIjcOiarV3xLaRE9d2yuuBjDL0p3DPOI2JWc6KCtEb0fYuPvtOdyjy0oaN7THov4aA
         uRBU4IUB/cbdHb49bI6xbfzJp/jgU677mRcxVaJv9dkIP4myDUgX0gupww8y/Jrsvdi7
         U1A65fA8Y0o0qQJqajQUIajdZnhWIkvIOdiD/11Ng4r98Nc919PZocKBlHGGFBWCK6JM
         9kFm/ipPoIDsNuP1spZWy0w1yHMpbnwrypAdmpTXiPDz1tZXTs4CSXn0sEfCStufMO78
         eV4g/B33D+6oxucKYVxTKcu4LLdxK1QAqBLmahxKHmQsXmlhXeZ9AxasCcB9IIUua4A0
         71hA==
X-Gm-Message-State: AOAM5309XsbDPbR4aE/KcwTOC4l281JRzVO6WHsDXkPj5KqO4Dv5yQFF
        PD4NE3uEjUXA/wSnqU3/jZc=
X-Google-Smtp-Source: ABdhPJwc5T4CkPKK/FYu/L1HrYaE3Bwa5OUQjz6yp8p2NhiW8/lzQ9BQD7ed+ihHoYCLZu3nXAJsgA==
X-Received: by 2002:a0c:f584:: with SMTP id k4mr7732677qvm.6.1599942775289;
        Sat, 12 Sep 2020 13:32:55 -0700 (PDT)
Received: from [192.168.1.120] ([191.23.96.207])
        by smtp.gmail.com with ESMTPSA id c193sm7130700qke.20.2020.09.12.13.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2020 13:32:54 -0700 (PDT)
Subject: Re: Kernel Benchmarking
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?Rog=c3=a9rio_Theodoro_de_Brito?= <rbrito@ime.usp.br>
References: <CAHk-=wiZnE409WkTOG6fbF_eV1LgrHBvMtyKkpTqM9zT5hpf9A@mail.gmail.com>
 <CAHk-=wgEE4GuNjcRaaAvaS97tW+239-+tjcPjTq2FGhEuM8HYg@mail.gmail.com>
 <6e1d8740-2594-c58b-ff02-a04df453d53c@MichaelLarabel.com>
 <CAHk-=wgJ3-cEkU-5zXFPvRCHKkCCuKxVauYWGphjePEhJJgtgQ@mail.gmail.com>
 <d2023f4c-ef14-b877-b5bb-e4f8af332abc@MichaelLarabel.com>
 <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
From:   =?UTF-8?Q?Rog=c3=a9rio_Brito?= <rbrito@ime.usp.br>
Message-ID: <c1970d94-52c7-5b8b-bf35-42f285ae6a3d@ime.usp.br>
Date:   Sat, 12 Sep 2020 17:32:41 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Linus and other people.

On 12/09/2020 14.59, Linus Torvalds wrote:
> On Sat, Sep 12, 2020 at 12:28 AM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> Can you please add a reference to the original problem report and
>> to the offending commit? This conversation appeared on the list without
>> this information.
>>
>> Are filesystems other than ext4 also affected by this performance
>> regression?
> 
> So let me expand on this, because it actually comes from a really old
> problem that has been around for ages, and that I think I finally
> understand.
> 
> And sadly, the regression comes from the fix to that old problem.
> 
> So I think the VM people (but perhaps not necessarily all filesystem
> people) have been aware of a long-time problem with certain loads
> causing huge latencies, up to and including watchdogs firing because
> processes wouldn't make progress for over half a minute (or whatever
> the default blocking watchdog timeout is - I would like to say that
> it's some odd number like 22 seconds, but maybe that was RCU).
> 
> We've known it's related to long queues for the page lock, and about
> three years ago now we added a "bookmark" entry to the page wakeup
> queues, because those queues got so long that even just traversing the
> wakeup queue was a big latency hit. But it's generally been some heavy
> private load on a customer machine, and nobody ever really had a good
> test-case for it.
> 
> We've actually had tons of different page lockers involved. One of the
> suspects (and in fact I think it really was one of the causes, just
> not the only one) was the NUMA migration, where under certain loads
> with lots and lots of threads, the kernel would decide to try to
> migrate a hot page, and lots of threads would come in and all
> NUMA-fault on it (because it was some core page everything used), and
> as part of the fault they would get the page lock to serialize, and
> you'd end up with wait queues that were multiple _thousands_ of
> entries long.
> 
> So the reports of watchdogs firing go back many many years, and over
> the years we've had various band-aid fixes - things that really do
> help the symptoms a lot, but really seem to be fixes for the symptoms
> rather than something fundamental. That "let's break up the wait queue
> with a bookmark so that we can at least enable interrupts" is perhaps
> the best example of code that just shouldn't exist, but comes about
> because there's been incredible contention on the page lock.
> 
> See commits 2554db916586 ("sched/wait: Break up long wake list walk")
> and 11a19c7b099f ("sched/wait: Introduce wakeup bookmark in
> wake_up_page_bit") for that bookmark thing and some of the list
> numbers.
> 
> There's been a few actual fixes too - I think Hugh Dickins really
> ended up fixing at least part of the NUMA balancing case by changing
> some of the reference counting. So I don't think it's _all_ been
> band-aids, but the page lock has been a thing that has come up
> multiple times over the years.
> 
> See for example commit 9a1ea439b16b ("mm:
> put_and_wait_on_page_locked() while page is migrated") for a patch
> that ended up hopefully fixing at least one of the causes of the long
> queues during migration. I say "hopefully", because (again) the loads
> that cause these things were those "internal customer load" things
> that we don't really have a lot of insight into. Hugh has been
> involved over the years presumably exactly because google has been one
> of those customers, although not the only one by far.
> 
> But the point here is that the page lock has been problematic for
> years - with those reports of watchdogs (after tens of seconds!)
> firing going back long before the fixes above. It's definitely not a
> new thing, although I think it has perhaps become more common due to
> "bigger machines running more complex loads becoming more common", but
> who knows..


First of all, please excuse my layman questions, but this conversation 
picked up my interest.

Now, to the subject: is this that you describe (RCU or VFS), in some 
sense, related to, say, copying a "big" file (e.g., a movie) to a "slow" 
media (in my case, a USB thumb drive, so that I can watch said movie on 
my TV)?

I've seen backtraces mentioning "task xxx hung for yyy seconds" and a 
non-reponsive cp process at that... I say RCU or VFS because I see this 
with the thumb drives with vfat filesystems (so, it wouldn't be quite 
related to ext4, apart from the fact that all my Linux-specific 
filesystems are ext4).

The same thing happens with my slow home network when I copy things to 
my crappy NFS server (an armel system that has only 128MB of RAM).

In both cases (a local or a remote fs), whenever I try to send SIGSTOP 
to the cp process, it stays there without being stopped for many 
minutes... I would venture a guess that this is because nothing else is 
done unless the outstanding bytes are actually committed to the 
filesystem...

In some sense, a very slow system with "moderate load" is akin to a 
high-end, loaded server with many threads competing for resources, in my 
experience...

OK, so many guesses and conjectures on my side, but the interactivity to 
the end-user suffers a lot (have not yet tested any 5.9 kernel).


Thanks,

Rogério.


> 
> Anyway, for various reasons I was looking at this again a couple of
> months ago: we had _yet_ another report of softlockups:
> 
>    https://lore.kernel.org/lkml/20200721063258.17140-1-mhocko@kernel.org/
> 
> and we had an unrelated thread about a low-level race in page wakeup
> (the original report was wrong, but it led to figuring out another
> race):
> 
>    https://lore.kernel.org/lkml/20200624161142.GA12184@redhat.com/
> 
> and there was something else going on too that I can't recall, that
> had made me look at the page locking.
> 
> And while there, I realized that the simplest explanation for all
> those years of softlockups was simply that the page waiting is very
> very unfair indeed.
> 
> While somebody is patiently waiting for a page, another process can
> (and will) come in and get the page lock from under it, and the
> original waiter will end up just re-queueing - at the end of the list.
> Which explains how you can get those half-minute latencies - not
> because any page lock holder really holds the lock for very long
> (almost all of them are CPU-bound, not IO bound), but because under
> heavy load and contention, you end up with the poor waiters scheduling
> away and *new* page lockers end up being treated very preferentially,
> with absolutely nothing keeping them from taking the lock while
> somebody else is waiting for it.
> 
> ANYWAY. That's a long email of background for the commit that I then
> put in the tree this merge window:
> 
>    2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
> 
> which actually makes the page locking truly fair (well, there's a
> small window that allows new lockers to come in, but now it's about
> CPU instructions rather than "scheduling a sleeping process to run",
> so it's essentially gone as a major and recurring unfairness issue).
> 
> And that commit actually had a fair number of positive reports: even
> before merging it, Hugh had tested this on yet another "company
> internal load" (*cough*google*cough*) that used to show watchdog
> failures, and it did seem to solve those, and some of the kernel test
> robot benchmarks improved by tens of percent, in one case by 160%.
> 
> So everything looked fine. It solves a long-running problem, and for
> once I think it really _solves_ it by fixing a fundamental problem,
> rather than papering over the symptoms.
> 
> But there were a couple of nagging concerns. Hackbench showed wildly
> fluctuating performance: some tests improved by a lot, others
> regressed by a lot. Not a huge deal, I felt: hackbench isn't a great
> benchmark, and the performance fluctuations really seemed to be going
> both ways and be very dependent on exact test and machine. So it was a
> slight concern, but on the whole not really worth worrying about.
> 
> But the reason Michal is on the Cc is because the Phoronix benchmark
> suite showed a rather marked decrease in the apache test. Unlike
> hackbench, I think that's much more of a "real" test, and it seemed to
> be a lot more consistent too. So I asked for profiles (and eventually
> just recreated the test locally), and I think I understand what's
> going on.
> 
> It's the fairness.
> 
> Fairness is good, but fairness is usually bad for performance even if
> it does get rid of the worst-case issues. In this case, it's _really_
> bad for performance, because that page lock has always been unfair,
> and we have a lot of patterns that have basically come to
> (unintentionally) depend on that unfairness.
> 
> In particular, the page locking is often used for just verifying
> simple things, with the most common example being "lock page, check
> that the mapping is still valid, insert page into page tables, unlock
> page".
> 
> The reason the apache benchmark regresses is that it basically does a
> web server test with a single file ("test.html") that gets served by
> just mmap'ing it, and sending it out that way. Using lots of threads,
> and using lots of different mappings. So they *all* fault on the read
> of that page, and they *all* do that "lock page, check that the
> mapping is valid, insert page" dance.
> 
> That actually worked ok - not great, but ok - when the page lock was
> unfair, and anybody runnable would basically just get it. Yes, people
> would occasionally get put on the wait-queue, but those waiting
> lockers wouldn't really affect the other ones that are going through
> that dance since they would just take the lock anyway. VERY unfair,
> but hey, very nice for that load.
> 
> It works much less well when the page lock is suddenly fair, and if
> anybody starts waiting for it, gets the lock handed to it when the
> page is unlocked. Now the page is owned by the next waiter in line,
> and they're sleeping, and new page lockers don't magically and
> unfairly get to just bypass the older waiter.
> 
> This is not a new issue. We've had exactly the same thing happen when
> we made spinlocks, semaphores, and rwlocks be fair.
> 
> And like those other times, we had to make them fair because *not*
> making them fair caused those unacceptable outliers under contention,
> to the point of starvation and watchdogs firing.
> 
> Anyway, I don't have a great solution. I have a few options (roughly
> ordered by "simplest to most complex"):
> 
>   (a) just revert
>   (b) add some busy-spinning
>   (c) reader-writer page lock
>   (d) try to de-emphasize the page lock
> 
> but I'd love to hear comments.
> 
> Honestly, (a) is trivial to do. We've had the problem for years, the
> really *bad* cases are fairly rare, and the workarounds mostly work.
> Yeah, you get watchdogs firing, but it's not exactly _common_.
> 
> But equally honestly, I hate (a). I feel like this change really fixed
> a fundamental issue, and after looking at the apache benchmark, in
> many ways it's not a great benchmark. The reason it shows such a
> (relatively) huge regression is that it hammers on just a single small
> file. So my inclination is to say "we know how to fix the performance
> regression, even if we may not be able to do so for 5.9, and this
> benchmark behavior is very unlikely to actually hit a real load".
> 
> Option (b) is just because right now the page lock is very much a
> black-and-white "try to lock once or sleep". Where most lockers (the
> initial actual IO to fill the page being the main exception) are
> CPU-bound, not IO bound. So spinning is the usual simplistic fix for
> locking behavior like that. It doesn't really "fix" anything, but it
> helps the bad contended performance case and we wouldn't get the
> scheduling and sleeping behavior.
> 
> I can imagine coming up with a ten-liner patch to add some spinning
> that claws back much of the performance on that benchmark. Maybe.
> 
> I don't like option (b) very much, but it might be the band-aid for
> 5.9 if we feel that the benchmark results _might_ translate to real
> loads.
> 
> Option (c) is, I feel, the best one. Reader-writer locks aren't
> wonderful, but the page lock really tends to have two very distinct
> uses: exclusive for the initial IO and for the (very very unlikely)
> truncate and hole punching issues, and then the above kind of "lock to
> check that it's still valid" use, which is very very common and
> happens on every page fault and then some. And it would be very
> natural to make the latter be a read-lock (or even just a sequence
> counting one with retry rather than a real lock).
> 
> Option (d) is "we already have a locking in many filesystems that give
> us exclusion between faulting in a page, and the truncate/hole punch,
> so we shouldn't use the page lock at all".
> 
> I do think that the locking that filesystems do is in many ways
> inferior - it's done on a per-inode basis rather than on a per-page
> basis. But if the filesystems end up doing that *anyway*, what's the
> advantage of the finer granularity one? And *because* the common case
> is all about the reading case, the bigger granularity tends to work
> very well in practice, and basically never sees contention.
> 
> So I think option (c) is potentially technically better because it has
> smaller locking granularity, but in practice (d) might be easier and
> we already effectively do it for several filesystems.
> 
> Also, making the page lock be a rw-lock may be "easy" in theory, but
> in practice we have the usual "uhhuh, 'struct page' is very crowded,
> and finding even just one more bit in the flags to use as a read bit
> is not great, and finding a whole reader _count_ would likely require
> us to go to that hashed queue, which we know has horrendous cache
> behavior from past experience".
> 
> This turned out to be a very long email, and probably most people
> didn't get this far. But if you did, comments, opinions, suggestions?
> 
> Any other suggestions than those (a)-(d) ones above?
> 
>                 Linus
> 

