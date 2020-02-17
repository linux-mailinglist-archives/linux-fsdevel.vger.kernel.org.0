Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBE4160773
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 01:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgBQAMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 19:12:01 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45541 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgBQAMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 19:12:00 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2F8AE7EAA4D;
        Mon, 17 Feb 2020 11:11:55 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j3U0w-0003yN-4s; Mon, 17 Feb 2020 11:11:54 +1100
Date:   Mon, 17 Feb 2020 11:11:54 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Allison Collins <allison.henderson@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200217001153.GE10776@dread.disaster.area>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
 <20200202214620.GA20628@dread.disaster.area>
 <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com>
 <20200212233929.GS10776@dread.disaster.area>
 <20200213151928.GD6548@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213151928.GD6548@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=FwfG1oZkZnbn-Rx3F64A:9 a=MQPR91JcLZq2PT75:21
        a=vrZHQR_nSnNfxiTR:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:19:28AM -0500, Brian Foster wrote:
> I agree with just about all of this mail, but I do have a question for
> Darrick and Dave.. in what ways do we (XFS community) place the burden
> on the maintainer to garner/coordinate review? I get the impression that
> some of this is implied or unintentional simply by reviews coming in
> slow or whatever, and the maintainer feeling the need to fill the gap. I

That's pretty much it. If nobody else reviews the code, if has
fallen to the maintainer to review it so that it can be merged. i.e.
review is needed to make forwards progress, to get stuff merged
we need review, but if nobody reviews the code for weeks, it
essentially falls to the maintainer to do a review to determine if
the patchset should be merged or not.

> can sort of understand that behavior as being human nature, but OTOH
> there's only so many developers with so much time available for review.

Yet all those developers seem to be happen to write code under the
assumption that someone will review it....

> That's not generally something we can control. Given that, I don't think
> it's necessarily useful to say that review throughput is the fundamental
> problem vs. this unfortunate dynamic of limited reviews not meeting
> demand leading to excess maintainer pressure. I'm trying to think about
> how we can deal with this more fundamentally beyond just saying "do more
> review" or having some annoying ownership process, but I think this
> requires more input from you guys who have experienced it...

/me rocks back and forth on his rocking chair....

Back in the days of being an SGI engineer working on IRIX - which is
where this process of review came from - each 3 monthly OS release
had a couple of "release tech leads" whose only responsibility for
those entire 3 months of the release was to review and accept code
into the Irix tree from the entire of engineering.  Every 3 month
release had different engineers performing the release lead role. It
was not a fixed position, and when you were assigned this role you
were given leave from your team responsibilities. i.e. the release
lead performed duties for the entire engineering department, not
just a single team.

Nothing got to the release leads without first having been peer
reviewed, unit tested and signed off by the reviewer. It was the
responsibility of the person who wrote the code to find a reviewer
and to get the review done, and only then could they tick the box
in the bug system that said "here's the change, here's the tree to
pull from, please review for inclusion". That's when the release
lead is notified that a change is ready to be merged.

IOWs, the release lead only ever saw reviewed, tested, completed
code ready for merge. Everything else was the responsibility of the
engineer tasks with implementing the change/fix via the bug system.
The release lead would check all the commit metadata was correct,
that the code merged cleanly, looked sane and, finally, passed
basic integration tests. They typically could not do more review
than this because most of what they looked at was outside of their
specific area of expertise.

Once the the release lead approved the change, the engineer would
then run the "commit script" which would check approvals in the bug
system and then merge the code into the main tree (i.e. the release
lead didn't actually do the commits themselves, just approved them).

We've always held that the position of "XFS Maintainer" was
effectively that of a "Release Lead" - someone who checks over
reviewed, tested, completed code, except with the added requirement
that they maintain the tree that everyone works from and sends
requests for the tree to be merged with upstream.

That is, organising review and/or reviewing every patch at great
detail was completely outside the scope of the Release Leads' role.
They look for integration and merge issues, not the fine details of
how a feature or fix is implemented. IOWs, the Release Lead role is
one of high level staging co-ordination, testing, oversight and tree
management.

Now, compare that to the traditional role of a Lead Developer. A LD
tends to spend a lot of their time on knowledge transfer, review,
architecture and project direction. The LD typically only looks at
code in their domain of expertise, and works with other LDs at
architectural/design levels.

But when the shit hits the fan, it's the LD who digs in to that
problem and does what is necessary to Get Stuff Done or find that
difficult bug. Hence if nobody is reviewing code and that is
creating a backlog, then the LD has a responsibility to the team to
make sure that review gets done in a timely fashion so code meets
the requirement for merging.

This is a very different role to a release lead role.

The problem is that Linux Maintainer role combines the roles of
"Lead Developer" with "Release Lead". i.e. the person who has the
release lead role for maintaining the tree for the team is also
expected to perform the LD role, and that means they are also the
"reviewer of last resort".  Hence if no-one else reviews code, it
comes down to the maintainer to do that review.

IOWs, the Linux Maintainer has the responsibility to the team to
keep making forwards progress by merging code, but they also have
the responsibility to be the person who reviews code when nobody
else does. Rather than a separation of these roles, it makes the
assumption that someone who is a good enough engineer to reach a
senior position in a team is also proficient at managing source
trees, automating testing, dealing with upstream merges.

Making your best developer also responsible for doing largely the
same thing over and over again (merge, test, push) is not a good use
of their time. Often it's a step too far - talented engineers often
only want to build things and don't respond well to being asked to
do mundane repetitive tasks. It's kinda like asking an areospace
engineer who designs planes to also be the mechanic that makes sure
every bolt on every plane is tight and won't come undone during
flight...

In reality, anyone who can use git and has a decent understanding of
the code base, team rules and git workflow can perform the Release
Lead role. But a fair few people have said they don't want to do it
because they are scared of making a mistake and being yelled at by
Our Mighty Leaders.

That is a result of the fact that a Linux Maintainer is seen as a
_powerful position_ because of the _control and influence_ it gives
that person. It's also treated like an exclusive club (e.g.
invite-only conferences for Maintainers) and it's effectively a "job
for life". i.e. Once people get to this level, they don't want to
step away from the role even if they are bad at it or it stresses
them out severely.  How many people do you know who have voluntarily
given up a Maintainer position because they really didn't want to do
it or they thought someone else could do a better job?

Personally, I never wanted to be a Maintainer. For a long time I was
simply a "Lead Developer" and through no choice of my own I ended up
as the community elected Maintainer. Performing the roles of LD + TL
for XFS kernel, xfsprogs and xfstests was too much for me - I
dislike the mechanical, repetitive process of managing patches and
branches for a release and when combined with doing review for so
many different things, it eventually that burnt the care-factor out
of me.

Which brings us to today - when I stepped back, we ended up with
separate maintainers for kernel, progs and fstests. fstests is
relatively low volume compared to the XFS kernel and xfsprogs so
that's been fine. However, we're seeing that the maintainers of both
of the XFS trees are showing signs of the stress of the
responsibility of maintaining both the trees, the reviewer of last
resort, doing all the integration testing and trying to keep up with
all the craziness that is happening throughout the rest of the
kernel.

So, really, it sounds like splitting what I was doing into 3
separate Maintainers hasn't really been that successful. It hasn't
solved the burnout issues, but we've known that for quite some time.
The concept of a rotating Maintainer role was born out of the idea
that we'd move it back closer to a Release Lead role and separate it
from the reviewer of last resort problem. We haven't really got past
talking about it, though, so perhaps we need to actually do
something about it.

I know this probably doesn't really answer your question, Brian, but
I thought it might be useful to given some further background on
how/why we have the review processes we do for XFS, and where the
maintainer has tended to fit in to the picture. Up until I was
elected maintainer, we'd kept the role of release lead separate to
the role of lead developer and we didn't have a burnout problem. It
certainly seems to me like we took a step in the wrong direction by
trying to conform to the Linux norms for selecting our most
productive developers to perform the official Linux Maintainer
role....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
