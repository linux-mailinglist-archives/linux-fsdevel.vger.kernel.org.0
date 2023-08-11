Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B1A77862A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 05:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjHKDpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 23:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHKDpe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:45:34 -0400
Received: from out-80.mta0.migadu.com (out-80.mta0.migadu.com [IPv6:2001:41d0:1004:224b::50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1B22D44
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 20:45:32 -0700 (PDT)
Date:   Thu, 10 Aug 2023 23:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691725531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5KksEpEJrdBUNIt2cuyr71Cn5RvvrON9yUkpmN/LnLY=;
        b=qh8J++02pQXJYe/neN5u3AAou0afnjguhbrzR2y+ampGTqvK80x5jl8lYpELh1MZoOyMcC
        TKXCaN00TxJN9GWfkNjWrXNmkQ2YTllxQSypPKL/3BdDpQGj4RaF88yVzbzC1TtiXKPj7c
        iZCKqE7v42K+mUud8MzaYZOfc13Jnhc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, dchinner@redhat.com,
        sandeen@redhat.com, willy@infradead.org, josef@toxicpanda.com,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230811034526.itwk7h6ibzje6tfr@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230810223942.GG11336@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810223942.GG11336@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 03:39:42PM -0700, Darrick J. Wong wrote:
> I've said this previously, and I'll say it again: we're severely
> under-resourced.  Not just XFS, the whole fsdevel community.  As a
> developer and later a maintainer, I've learnt the hard way that there is
> a very large amount of non-coding work is necessary to build a good
> filesystem.  There's enough not-really-coding work for several people.
> Instead, we lean hard on maintainers to do all that work.  That might've
> worked acceptably for the first 20 years, but it doesn't now.

Yeah, that was my takeaway too when I started doing some more travelling
last fall to talk to people about bcachefs - the teams are not what they
were 10 years ago, and a lot of the effort in the filesystem space feels
a lot more fragmented. It feels like there's a real lack of leadership
or any kind of a long term plan in the filesystem space, and I think
that's one of the causes of all the burnout; we don't have a clear set
of priorities or long term goals.

> Nowadays we have all these people running bots and AIs throwing a steady
> stream of bug reports and CVE reports at Dave [Chinner] and I.  Most of
> these people *do not* help fix the problems they report.  Once in a
> while there's an actual *user* report about data loss, but those
> (thankfully) aren't the majority of the reports.
> 
> However, every one of these reports has to be triaged, analyzed, and
> dealt with.  As soon as we clear one, at least one more rolls in.  You
> know what that means?  Dave and I are both in a permanent state of
> heightened alert, fear, and stress.  We never get to settle back down to
> calm.  Every time someone brings up syzbot, CVEs, or security?  I feel
> my own stress response ramping up.  I can no longer have "rational"
> conversations about syzbot because those discussions push my buttons.
> 
> This is not healthy!

Yeah, we really need to take a step back and ask ourselves what we're
trying to do here.

At this point, I'm not so sure hardening xfs/ext4 in all the ways people
are wanting them to be hardened is a realistic idea: these are huge, old
C codebases that are tricky to work on, and they weren't designed from
the start with these kinds of considerations. Yes, in a perfect world
all code should be secure and all bugs should be fixed, but is this the
way to do it?

Personally, I think we'd be better served by putting what manpower we
can spare into starting on an incremental Rust rewrite; at least that's
my plan for bcachefs, and something I've been studying for awhile (as
soon as the gcc rust stuff lands I'll be adding Rust code to
fs/bcachefs, some code already exists). For xfs/ext4, teasing things
apart and figuring out how to restructure data structures in a way to
pass the borrow checker may not be realistic, I don't know the codebases
well enough to say - but clearly the current approach is not working,
and these codebases are almost definitely still going to be in use 50
years from now, we need to be coming up with _some_ sort of plan.

And if we had a coherent long term plan, maybe that would help with the
funding and headcount issues...

> A group dynamic that I keep observing around here is that someone tries
> to introduce some unfamiliar (or even slightly new) concept, because
> they want the kernel to do something it didn't do before.  The author
> sends out patches for review, and some of the reviewers who show up
> sound like they're so afraid of ... something ... that they throw out
> vague arguments that something might break.
> 
> [I have had people tell me in private that while they don't have any
> specific complaints about online fsck, "something" is wrong and I need
> to stop and consider more thoroughly.  Consider /what/?]

Yup, that's just broken. If you're telling someone they're doing it
wrong and you're not offering up any ideas, maybe _you're_ the problem.

The fear based thing is very real, and _very_ understandable. In the
filesystem world, we have to live with our mistakes in a way no one else
in kernel land does. There's no worse feeling than realizing you fucked
up something in the on disk format, and you didn't realize it until six
months later, and now you've got incompatibilities that are a nightmare
to sort out - never mind the more banal "oh fuck, sorry I ate your data"
stories.

> Or, worse, no reviewers show up.  The author merges it, and a month
> later there's a freakout because something somewhere else broke.  Angry
> threads spread around fsdevel because now there's pressure to get it
> fixed before -rc8 (in the good case) or ASAP (because now it's
> released).  Did the author have an incomplete understanding of the code?
> Were there potential reviewers who might've said something but bailed?
> Yes and yes.
> 
> What do we need to reduce the amount of fear and anger around here,
> anyway?  20 years ago when I started my career in Linux I found the work
> to be challenging and enjoyable.  Now I see a lot more anger, and I am
> sad, because there /are/ still enjoyable challenges to be undertaken.
> Can we please have that conversation?

I've been through the burnout cycle too (many times!), and for me the
answer was: slow down, and identify the things that really matter, the
things that will make my life easier in the long run, and focus on
_that_.

I've been through cycles more than once where I wasn't keeping up with
bug reports, and I had to tell my users "hang on - this isn't efficient,
I need to work on the testing automation because stuff is slipping
through; give me a month".

(And also make sure to leave some time for the things I actually do
enjoy; right now that means working on the fuse port here and there).

> People and groups do not do well when they feel like they're under
> constant attack, like they have to brace themselves for whatever
> bullshit is coming next.  That is how I feel most weeks, and I choose
> not to do that anymore.
> 
> > and I _really_
> > hope people are taking notice about Darrick stepping away from XFS and
> > asking themselves what needs to be sorted out.
> 
> Me too.  Ted expressed similar laments about ext4 after I announced my
> intention to reduce my own commitments to XFS.

Oh man, we can't lose Ted.

> > Darrick writes
> > meticulous, well documented code; when I think of people who slip by
> > hacks other people are going to regret later, he's not one of them.
> 
> I appreciate the compliment. ;)
> 
> From what I can tell (because I lolquit and finally had time to start
> scanning the bcachefs code) I really like the thought that you've put
> into indexing and record iteration in the filesystem.  I appreciate the
> amount of work you've put into making it easy and fast to run QA on
> bcachefs, even if we don't quite agree on whether or not I should rip
> and replace my 20yo Debian crazyquilt.

Thanks, the database layer is something I've put a _ton_ of work into. I
feel like we're close to being able to get into some really exciting
stuff once we get past the "stabilizing a new filesystem with a massive
featureset" madness - people have been trying to do the
filesystem-as-a-database thing for years, and I think bcachefs is the
first to actually seriously pull it off.

And I'm really hoping to make the test infrastructure its own real
project for the whole fs community, and more. There's a lot of good
stuff in there I just need to document better and create a proper
website for.

> > And yet, online fsck for XFS has been pushed back repeatedly because
> > of petty bullshit.
> 
> A broader dynamic here is that I ask people to review the code so that I
> can merge it; they say they will do it; and then an entire cycle goes by
> without any visible progress.
> 
> When I ask these people why they didn't follow through on their
> commitments, the responses I hear are pretty uniform -- they got buried
> in root cause analysis of a real bug report but lol there were no other
> senior people available; their time ended up being spent on backports or
> arguing about backports; or they got caught up in that whole freakout
> thing I described above.

Yeah, that set of priorities makes sense when we're talking about
patches that modify existing code; if you can't keep up with bug reports
then you have to slow down on changes, and changes to existing code
often do need the meticulous review - and hopefully while people are
waiting on code review they'll be helping out with bug reports.

But for new code that isn't going to upset existing users, if we trust
the author to not do crazy things then code review is really more about
making sure someone else understands the code. But if they're putting in
all the proper effort to document, to organize things well, to do things
responsibly, does it make sense for that level of code review to be an
up front requirement? Perhaps we could think a _bit_ more about how we
enable people to do good work.

I'm sure the XFS people have thought about this more than I have, but
given how long this has been taking you and the amount of pushback I
feel it ought to be asked.
