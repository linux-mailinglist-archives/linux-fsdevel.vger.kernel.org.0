Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6E116155D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 16:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgBQPCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 10:02:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26894 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729283AbgBQPCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581951721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FuJ4fQWgOvejZSFPi9OoEBO7YMKJN8qK1I/qSd4VJdg=;
        b=Slnbiz4fOsmZxCUwCMouHWnwS28O5E5T0eHubzLhrnlggxxG8SXSEfwwHDVSxoc64e5d7O
        /GIddSxQ2KEZi19rRsIX/eFwpIwBM19TE+UFhRTo7U8XHqNy0IsVQnYXMZD/0cl9f9jX4F
        OGXuK3kqubdR/Fr2CM3GQF0ESudpyWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-P_Zj016qPDStatg5P-ZoPA-1; Mon, 17 Feb 2020 10:01:59 -0500
X-MC-Unique: P_Zj016qPDStatg5P-ZoPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A19C1005512;
        Mon, 17 Feb 2020 15:01:58 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0EF82CC39;
        Mon, 17 Feb 2020 15:01:54 +0000 (UTC)
Date:   Mon, 17 Feb 2020 10:01:53 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Allison Collins <allison.henderson@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200217150153.GA6419@bfoster>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
 <20200202214620.GA20628@dread.disaster.area>
 <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com>
 <20200212233929.GS10776@dread.disaster.area>
 <20200213151928.GD6548@bfoster>
 <20200217001153.GE10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217001153.GE10776@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:11:54AM +1100, Dave Chinner wrote:
> On Thu, Feb 13, 2020 at 10:19:28AM -0500, Brian Foster wrote:
> > I agree with just about all of this mail, but I do have a question for
> > Darrick and Dave.. in what ways do we (XFS community) place the burden
> > on the maintainer to garner/coordinate review? I get the impression that
> > some of this is implied or unintentional simply by reviews coming in
> > slow or whatever, and the maintainer feeling the need to fill the gap. I
> 
> That's pretty much it. If nobody else reviews the code, if has
> fallen to the maintainer to review it so that it can be merged. i.e.
> review is needed to make forwards progress, to get stuff merged
> we need review, but if nobody reviews the code for weeks, it
> essentially falls to the maintainer to do a review to determine if
> the patchset should be merged or not.
> 
> > can sort of understand that behavior as being human nature, but OTOH
> > there's only so many developers with so much time available for review.
> 
> Yet all those developers seem to be happen to write code under the
> assumption that someone will review it....
> 

I think all of our regular patch contributers also do a fair amount of
review. I'm sure we could all stand to do more review at times, but that
doesn't strike me as the fundamental problem here...

> > That's not generally something we can control. Given that, I don't think
> > it's necessarily useful to say that review throughput is the fundamental
> > problem vs. this unfortunate dynamic of limited reviews not meeting
> > demand leading to excess maintainer pressure. I'm trying to think about
> > how we can deal with this more fundamentally beyond just saying "do more
> > review" or having some annoying ownership process, but I think this
> > requires more input from you guys who have experienced it...
> 
> /me rocks back and forth on his rocking chair....
> 

Heh. ;)

> Back in the days of being an SGI engineer working on IRIX - which is
> where this process of review came from - each 3 monthly OS release
> had a couple of "release tech leads" whose only responsibility for
> those entire 3 months of the release was to review and accept code
> into the Irix tree from the entire of engineering.  Every 3 month
> release had different engineers performing the release lead role. It
> was not a fixed position, and when you were assigned this role you
> were given leave from your team responsibilities. i.e. the release
> lead performed duties for the entire engineering department, not
> just a single team.
> 
> Nothing got to the release leads without first having been peer
> reviewed, unit tested and signed off by the reviewer. It was the
> responsibility of the person who wrote the code to find a reviewer
> and to get the review done, and only then could they tick the box
> in the bug system that said "here's the change, here's the tree to
> pull from, please review for inclusion". That's when the release
> lead is notified that a change is ready to be merged.
> 
> IOWs, the release lead only ever saw reviewed, tested, completed
> code ready for merge. Everything else was the responsibility of the
> engineer tasks with implementing the change/fix via the bug system.
> The release lead would check all the commit metadata was correct,
> that the code merged cleanly, looked sane and, finally, passed
> basic integration tests. They typically could not do more review
> than this because most of what they looked at was outside of their
> specific area of expertise.
> 
> Once the the release lead approved the change, the engineer would
> then run the "commit script" which would check approvals in the bug
> system and then merge the code into the main tree (i.e. the release
> lead didn't actually do the commits themselves, just approved them).
> 
> We've always held that the position of "XFS Maintainer" was
> effectively that of a "Release Lead" - someone who checks over
> reviewed, tested, completed code, except with the added requirement
> that they maintain the tree that everyone works from and sends
> requests for the tree to be merged with upstream.
> 

Yep, this has always been my general perception of the XFS maintainer
role. Merge code while acting somewhat as a gatekeeper, send pull
requests, perform some very basic coordination/communication between
developers when necessary (i.e., if working on conflicting things, a
controversial change, etc.). The maintainer also sends and reviews code,
but I've always viewed those as developer tasks as the maintainer
usually happens to also be a developer.

> That is, organising review and/or reviewing every patch at great
> detail was completely outside the scope of the Release Leads' role.
> They look for integration and merge issues, not the fine details of
> how a feature or fix is implemented. IOWs, the Release Lead role is
> one of high level staging co-ordination, testing, oversight and tree
> management.
> 
> Now, compare that to the traditional role of a Lead Developer. A LD
> tends to spend a lot of their time on knowledge transfer, review,
> architecture and project direction. The LD typically only looks at
> code in their domain of expertise, and works with other LDs at
> architectural/design levels.
> 
> But when the shit hits the fan, it's the LD who digs in to that
> problem and does what is necessary to Get Stuff Done or find that
> difficult bug. Hence if nobody is reviewing code and that is
> creating a backlog, then the LD has a responsibility to the team to
> make sure that review gets done in a timely fashion so code meets
> the requirement for merging.
> 
> This is a very different role to a release lead role.
> 
> The problem is that Linux Maintainer role combines the roles of
> "Lead Developer" with "Release Lead". i.e. the person who has the
> release lead role for maintaining the tree for the team is also
> expected to perform the LD role, and that means they are also the
> "reviewer of last resort".  Hence if no-one else reviews code, it
> comes down to the maintainer to do that review.
> 

Hmm.. I can only give my .02, but I've never really considered a generic
maintainer as necessarily an LD by default. I wonder a bit how much of
this is a general expectation of the role, particularly since I'm not
convinced other subsystems even have as stringent review requirements as
we happen to have in XFS.

Though perhaps that is part and parcel of the same thing.. if other
subsystems don't have some form of an independent Reviewed-By:
requirement for merging patches, then the maintainer might feel more
pressure to (at least informally) review everything that comes through
by virtue of being responsible for the subtree.

> IOWs, the Linux Maintainer has the responsibility to the team to
> keep making forwards progress by merging code, but they also have
> the responsibility to be the person who reviews code when nobody
> else does. Rather than a separation of these roles, it makes the
> assumption that someone who is a good enough engineer to reach a
> senior position in a team is also proficient at managing source
> trees, automating testing, dealing with upstream merges.
> 
> Making your best developer also responsible for doing largely the
> same thing over and over again (merge, test, push) is not a good use
> of their time. Often it's a step too far - talented engineers often
> only want to build things and don't respond well to being asked to
> do mundane repetitive tasks. It's kinda like asking an areospace
> engineer who designs planes to also be the mechanic that makes sure
> every bolt on every plane is tight and won't come undone during
> flight...
> 
> In reality, anyone who can use git and has a decent understanding of
> the code base, team rules and git workflow can perform the Release
> Lead role. But a fair few people have said they don't want to do it
> because they are scared of making a mistake and being yelled at by
> Our Mighty Leaders.
> 
> That is a result of the fact that a Linux Maintainer is seen as a
> _powerful position_ because of the _control and influence_ it gives
> that person. It's also treated like an exclusive club (e.g.
> invite-only conferences for Maintainers) and it's effectively a "job
> for life". i.e. Once people get to this level, they don't want to
> step away from the role even if they are bad at it or it stresses
> them out severely.  How many people do you know who have voluntarily
> given up a Maintainer position because they really didn't want to do
> it or they thought someone else could do a better job?
> 

I've always found that a bit strange. I've never considered it a
glamorous position. ;P

> Personally, I never wanted to be a Maintainer. For a long time I was
> simply a "Lead Developer" and through no choice of my own I ended up
> as the community elected Maintainer. Performing the roles of LD + TL
> for XFS kernel, xfsprogs and xfstests was too much for me - I
> dislike the mechanical, repetitive process of managing patches and
> branches for a release and when combined with doing review for so
> many different things, it eventually that burnt the care-factor out
> of me.
> 
> Which brings us to today - when I stepped back, we ended up with
> separate maintainers for kernel, progs and fstests. fstests is
> relatively low volume compared to the XFS kernel and xfsprogs so
> that's been fine. However, we're seeing that the maintainers of both
> of the XFS trees are showing signs of the stress of the
> responsibility of maintaining both the trees, the reviewer of last
> resort, doing all the integration testing and trying to keep up with
> all the craziness that is happening throughout the rest of the
> kernel.
> 
> So, really, it sounds like splitting what I was doing into 3
> separate Maintainers hasn't really been that successful. It hasn't
> solved the burnout issues, but we've known that for quite some time.
> The concept of a rotating Maintainer role was born out of the idea
> that we'd move it back closer to a Release Lead role and separate it
> from the reviewer of last resort problem. We haven't really got past
> talking about it, though, so perhaps we need to actually do
> something about it.
> 
> I know this probably doesn't really answer your question, Brian, but
> I thought it might be useful to given some further background on
> how/why we have the review processes we do for XFS, and where the
> maintainer has tended to fit in to the picture. Up until I was
> elected maintainer, we'd kept the role of release lead separate to
> the role of lead developer and we didn't have a burnout problem. It
> certainly seems to me like we took a step in the wrong direction by
> trying to conform to the Linux norms for selecting our most
> productive developers to perform the official Linux Maintainer
> role....
> 

It kind of does and it doesn't, but a good discussion nonetheless...
While I agree with much of what you've written here, you've touched on
something that I suspected was missing up until the very end. I do
recall the time before your maintainership, but I don't recall any
explicit decision to fundamentally combine the LD and maintainer roles.
We just gave the maintainer role to somebody who also has LD
responsibilities, which is subtely different IMO. ;)

To me, the LD is more something that describes the regular contributions
of certain people than an explicit role (in Linux, anyways). The broader
point is that perhaps some of this is self-imposed by virtue of the
maintainer being somebody who is instinctively an LD (beyond saying this
is just "the Linux maintainer way of doing things," which also has an
element of truth to it).

For example, as an individual XFS developer, I have no real perception
of the natural strain that should be fed back from the maintainer in a
situation where there's a bunch of pending code, not enough review and
there's a hurdle to progress to the point where the maintainer is
feeling undue pressure. That's presumably because the maintainer jumps
in to fill the gap, but even though I do try to do my part and review
as much as possible, I don't recall being asked to look at some
particular thing or for thoughts on the priority of some particular
work, etc. since.. as far as I can remember..? So it's kind of hard for
others to help out without any kind of feedback or communication along
those lines. Somewhat related, how often do we not land patches in a
release due to lack of review? ISTM that _should_ happen from time to
time simply as a function of prioritization, and I wonder if we're
resisting that in some way.

I also think lack of communication (in both directions) makes
prioritization of patch series difficult. I.e., I might see something
pop up on the list and explicitly prioritize it as something that I
probably wouldn't get to within the next couple/few weeks, where the
maintainer might consider it unreviewed in the meantime and feel the
need to review it sooner. Unfortunately as it stands, neither person
really has any window into the other's priorities.

I'm not sure what the answer is to that. I hate the idea of "assigning"
reviewers, but at the same time it might be nice to have a way to say "I
acknowledge your series, I don't think it's critical for this release
but I plan to review it." At least then the maintainer could make a more
informed decision or poke reviewers about such things before
reviewing/merging. Tracking stuff like that is probably where it gets
difficult.

Anyways, ISTM that _something_ that separates maintainership tasks from
this implied individual responsibility to make progress might help
mitigate this. To me, maintainership is really just a set of tasks that
need to be done periodically in service to the broader project. It would
be nice if we found a way for everybody to be able to contribute in some
form from time to time, but I'm not sure how realistic that is. Perhaps
something like rotating, or further subdivision of work like per-release
tree maintenance vs. integration/regression testing, etc. might help
force more communication between us and isolate the shared
responsibility to review/test code from the maintainer responsibility to
merge it.

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

