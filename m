Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B1159FA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 04:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgBLDv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 22:51:57 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41756 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727784AbgBLDv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:51:56 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01C3pdNK003917
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 22:51:40 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 77450420324; Tue, 11 Feb 2020 22:51:39 -0500 (EST)
Date:   Tue, 11 Feb 2020 22:51:39 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200212035139.GF3630@mit.edu>
References: <20200131052520.GC6869@magnolia>
 <20200207220333.GI8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207220333.GI8731@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 02:03:33PM -0800, Matthew Wilcox wrote:
> On Thu, Jan 30, 2020 at 09:25:20PM -0800, Darrick J. Wong wrote:
> > It turns out that this system doesn't scale very well either.  Even with
> > three maintainers sharing access to the git trees,,,
>
> I think the LSFMMBPF conference is part of the problem.  With the best of
> intentions, we have set up a system which serves to keep all but the most
> dedicated from having a voice at the premier conference for filesystems,
> memory management, storage (and now networking).  It wasn't intended to
> be that way, but that's what has happened, and it isn't serving us well
> as a result.
>
> ...
>
> This kills me because LSFMM has been such a critically important part of
> Linux development for over a decade, but I think at this point it is at
> least not serving us the way we want it to, and may even be doing more
> harm than good.  I think it needs to change, and more people need to
> be welcomed to the conference.  Maybe it needs to not be invite-only.
> Maybe it can stay invite-only, but be twice as large.  Maybe everybody
> who's coming needs to front $100 to put towards the costs of a larger
> meeting space with more rooms.

One of the things that I've trying to suggest for at least the last
year or two is that we need colocate LSF/MM with a larger conference.
In my mind, what would be great would be something sort of like
Plumbers, but in the first half of year.  The general idea would be to
have two major systems-level conferences about six months apart.

The LSF/MM conference could still be invite only, much like we have
had the Maintainer's Summit and the Networking Summit colocated with
Plumbers in Lisbon in 2019 and Vancouver in 2018.  But it would be
colocated with other topic specific workshops / summits, and there
would be space for topics like what you described below:

> There are 11 people on that list, plus Jason, plus three more than I
> recommended.  That's 15, just for that one topic.  I think maybe half
> of those people will get an invite anyway, but adding on an extra 5-10
> people for (what I think is) a critically important topic at the very
> nexus of storage, filesystems, memory management, networking and graphics
> is almost certainly out of bounds for the scale of the current conference.

After all, this is *precisely* the scaling problem that we had with
the Kernel Summit.  The LSF/MM summit can really only deal with
subjects that require high-level coordination between maintainers.
For more focused topics, we will need a wider set of developers than
can fit in size constraints of the LSF/MM venue.

This also addresses Darrick's problem, in that most of us can probably
point to more junior engineers that we would like to help to develop,
which means they need to meet other Storage, File System, and MM
developers --- both more senior ones, and other colleagues in the
community.  Right now, we don't have a venue for this except for
Plumbers, and it's suffering from bursting at the seams.  If we can
encourage grow our more junior developers, it will help us delegate
our work to a larger group of talent.  In other words, it will help us
scale.

There are some tradeoffs to doing this; if we are going to combine
LSF/MM with other workshops and summits into a larger "systems-level"
conference in the first half of the year, we're not going to be able
to fit in some of the smaller, "fun" cities, such as Palm Springs, San
Juan, Park City, etc.

One of the things that I had suggested for 2020 was to colocate
LSF/MM/BPF, the Kernel Summit, Maintainer's Summit, and perhaps Linux
Security Symposium to June, in Austin.  (Why Austin?  Because finding
kernel hackers who are interested in planning a conference in a hands
on fashion ala Plumbers is *hard*.  And if we're going to leverage the
LF Events Staff on short notice, holding something in the same city as
OSS was the only real option.)  I thought it made a lot of sense last
year, but a lot of people *hated* Austin, and they didn't want to be
anywhere near the Product Manager "fluff" talks that unfortunately,
are in large supply at OSS.   So that idea fell through.

In any case, this is a problem that has been recently discussed at the
TAB, but this is not an issue where we can force anybody to do
anything.  We need to get the stakeholders who plan all of these
conferences to get together, and figure out something for 2021 or
maybe 2022 that we can all live with.  It's going to require some
compromising on all sides, and we all will have different things that
we consider "must haves" versus "would be nice" as far as conference
venues are concerned, and as well as dealing with financial
constraints.

Assuming I get an invite to LSF/MM (I guess they haven't gone out
yet?), I'd like to have a chance to chat with anyone who has strong
opinions on this issue in Palm Springs.  Maybe we could schedule a BOF
slot to hear from the folks who attend LSF/MM/BPF and learn what
things we all consider important vis-a-vis the technical conferences
that we attend?

Cheers,

							- Ted
