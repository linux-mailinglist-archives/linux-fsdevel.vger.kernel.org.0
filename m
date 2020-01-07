Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D93613214E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 09:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgAGIX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 03:23:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34910 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgAGIX5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:23:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so52828010wro.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 00:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6mEj8hlQzGKALdLErXEuwCuykGhOOxyxJOLmeQvbbY=;
        b=k92fYNraJxRgt4vvi7yOiAJZKjjQHOFJzFDfNj35+SqnMGu1vPlT1GrSF1P6sOG6Gh
         WZ41viNKYlvctoeeGOzVsmRVSCuS/fgxHn3sB12Hew64PdbkIF7tOPCAeBwS9yn80zQs
         zkSaosucNjHij4fp/5FlOJKgzKZ8hBcJhC93UbDd3y4ejAJtKIjvMsK0oFPjRsndSaV3
         KDfTLjrP2hb/XfjrD2FqHI6v6tCeTeYXRNBYM2IB74ineSCOHXx3lejkD4nbthCkHNgH
         dXNsi+F8hInzFAsnHj5MBBVf9LqaGwmFc8IoP+DjOoMtt46bpN3wBAMU314pTQ7pOtXh
         jifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6mEj8hlQzGKALdLErXEuwCuykGhOOxyxJOLmeQvbbY=;
        b=hy66YTT2/E3YPT+c1gfjJv9GPa9/sodAd/jBKPDxUrIvKpurdTySDN/qhDtJH+AD7g
         QpQmnr3CLpw09wLd55FDtWa5BpPE1U3apXP3kSY/qkjHFAYlqaaHroObBEEm1EtqeG8A
         LKq3yhVfAtcEBL713ovKbUB6pJ+ETg23Oy7PKjphNSvMCqcmyMKvoL7cWbsodMN8aHS9
         iCQ6whYJsB/H4m7N4AOUdLOxXym5pOqUQqmBmO+RAF+jSAkqcTVYMgGFnH2Qr+PM7XJb
         MlIJNWE/MGj9zG10/bqcWKAlNVyeWzgkK5QSR+i7/qeRKdyT7OSwJm+SDTp21s80zB8t
         CIkw==
X-Gm-Message-State: APjAAAWcwLf4N6DEUH2aurqwDMm94Rb+53V8tDiQC27ysZG0gHfhPwEf
        0HtudCVXUgFl49bqQhpxAiyjGnlnS7v460fm4BaZnA==
X-Google-Smtp-Source: APXvYqy6WLx8JbEgE35DitDA0cNP7PmoEir6VdIMCuxyKoEAKiTYC2eWm5gJUqeYFD4NnXh14wQ6+9J7joUdHamrK00=
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr111400099wrm.262.1578385434699;
 Tue, 07 Jan 2020 00:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20191231125908.GD6788@bombadil.infradead.org> <20200106115514.GG12699@dhcp22.suse.cz>
 <20200106232100.GL23195@dread.disaster.area>
In-Reply-To: <20200106232100.GL23195@dread.disaster.area>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 Jan 2020 01:23:38 -0700
Message-ID: <CAJCQCtTPtveHb8gJ7EPdck4WLsN6=RbS+kh0bGN_=-hrrWpuow@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Congestion
To:     Dave Chinner <david@fromorbit.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 6, 2020 at 4:21 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Jan 06, 2020 at 12:55:14PM +0100, Michal Hocko wrote:
> > On Tue 31-12-19 04:59:08, Matthew Wilcox wrote:
> > >
> > > I don't want to present this topic; I merely noticed the problem.
> > > I nominate Jens Axboe and Michael Hocko as session leaders.  See the
> > > thread here:
> >
> > Thanks for bringing this up Matthew! The change in the behavior came as
> > a surprise to me. I can lead the session for the MM side.
> >
> > > https://lore.kernel.org/linux-mm/20190923111900.GH15392@bombadil.infradead.org/
> > >
> > > Summary: Congestion is broken and has been for years, and everybody's
> > > system is sleeping waiting for congestion that will never clear.
> > >
> > > A good outcome for this meeting would be:
> > >
> > >  - MM defines what information they want from the block stack.
> >
> > The history of the congestion waiting is kinda hairy but I will try to
> > summarize expectations we used to have and we can discuss how much of
> > that has been real and what followed up as a cargo cult. Maybe we just
> > find out that we do not need functionality like that anymore. I believe
> > Mel would be a great contributor to the discussion.
>
> We most definitely do need some form of reclaim throttling based on
> IO congestion, because it is trivial to drive the system into swap
> storms and OOM killer invocation when there are large dirty slab
> caches that require IO to make reclaim progress and there's little
> in the way of page cache to reclaim.
>
> This is one of the biggest issues I've come across trying to make
> XFS inode reclaim non-blocking - the existing code blocks on inode
> writeback IO congestion to throttle the overall reclaim rate and
> so prevents swap storms and OOM killer rampages from occurring.
>
> The moment I remove the inode writeback blocking from the reclaim
> path and move the backoffs to the core reclaim congestion backoff
> algorithms, I see a sustantial increase in the typical reclaim scan
> priority. This is because the reclaim code does not have an
> integrated back-off mechanism that can balance reclaim throttling
> between slab cache and page cache reclaim. This results in
> insufficient page reclaim backoff under slab cache backoff
> conditions, leading to excessive page cache reclaim and swapping out
> all the anonymous pages in memory. Then performance goes to hell as
> userspace then starts to block on page faults swap thrashing like
> this:

This really caught my attention, however unrelated it may actually be.
The gist of my question is: what are distributions doing wrong, that
it's possible for an unprivileged process to take down a system such
that an ordinary user reaches for the power button? [1] More helpful
would be, what should distributions be doing better to avoid the
problem in the first place? User space oom daemons are now popular,
and there's talk about avoiding swap thrashing and oom by strict use
of cgroupsv2 and PSI. Some people say, oh yeah duh, just don't make a
swap device at all, what are you crazy? Then there's swap on ZRAM. And
alas zswap too. So what's actually recommended to help with this
problem?

I don't have many original thoughts, but I can't find a reference for
why my brain is telling me the kernel oom-killer is mainly concerned
about kernel survival in low memory situations, and not user space.
But an approximate is "It is the job of the linux 'oom killer' to
sacrifice one or more processes in order to free up memory for the
system when all else fails." [2]

However, a) failure has happened way before oom-killer is invoked,
back when the GUI became unresponsive, and b) often it kills some
small thing, seemingly freeing up just enough memory that the kernel
is happy to stay in this state for indeterminate time. For my testing
that's 30 minutes, but I'm compelled to defend a user who asserts a
mere 15 second grace period before reaching for the power button.

This isn't a common experience across a broad user population, but
those who have experienced it once are really familiar with it (they
haven't experienced it only once). And I really want to know what can
be done to make the user experience better, but it's not clear to me
how to do that.

[1]
Fedora 30/31 default installation, 8G RAM, 8G swap (on plain SSD
partition), and compile webkitgtk. Within ~5 minutes all RAM is
cosumed, and the "swap storm" begins. The GUI stutters, even the mouse
pointer starts to gets choppy, and soon after it's pretty much locked
up and for all practical purposes it's locked up. Most typical, it
stays this way for 30+ minutes. Occasionally oom-killer kicks in and
clobbers something. Sometimes it's one of the compile threads. And
also occasionally it'll be something absurd like sshd, sssd, or
systemd-journald - which really makes no sense at all.

[2]
https://linux-mm.org/OOM_Killer

--
Chris Murphy
