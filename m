Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD00515B697
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 02:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgBMBXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 20:23:52 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:58452 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727071AbgBMBXw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:23:52 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9A34C821B49;
        Thu, 13 Feb 2020 12:23:32 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j23Dx-0004dh-3T; Thu, 13 Feb 2020 12:23:25 +1100
Date:   Thu, 13 Feb 2020 12:23:25 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200213012325.GT10776@dread.disaster.area>
References: <20200131052520.GC6869@magnolia>
 <20200207220333.GI8731@bombadil.infradead.org>
 <20200212222118.GT6870@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212222118.GT6870@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=Yh2a_DI0EpWPktm9UrYA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 02:21:18PM -0800, Darrick J. Wong wrote:
> On Fri, Feb 07, 2020 at 02:03:33PM -0800, Matthew Wilcox wrote:
> > Third, I hear from people who work on a specific filesystem "Of the
> > twenty or so slots for the FS part of the conference, there are about
> > half a dozen generic filesystem people who'll get an invite, then maybe
> > six filesystems who'll get two slots each, but what we really want to
> > do is get everybody working on this filesystem in a room and go over
> > our particular problem areas".
> 
> Yes!  One thousand times yes!  The best value I've gotten from LSF has
> been the in-person interlocks with the XFS/ext4/btrfs developers, even
> if the thing we discuss in the hallway BOFs have not really been
> "cross-subsystem topics".

On that note, I think the rigid "3 streams and half hour timeslot"
format of LSFMM is really the biggest issues LSFMM has. Most of the
time there are only 3-4 people discussing whatever topic is
scheduled, and the other 15-20 people in the room either have no
knowledge, no interest or no interactions with the issue/code being
discussed. That has always struck me as a massive waste of valuable
face-to-face time that could be put to much better use.

Making LSFMM bigger doesn't fix this problem, either. it just makes
it worse because there's more people sitting around twiddling their
thumbs while the same 3-4 people talk across the room at each other.

Then there's the stream topics that overlap and the complete lack of
recording of the discussions. i.e. you get a schedule conflict, and
you miss out on a critically important discussion completely. You
can't even go watch it back later in the day when you're sitting
waiting for some talk you have no interest in to complete....

Further, there is no real scope to allow groups of developers to
self organise and sit down and solve a problem they need solved that
is not on the schedule. There are no small "breakout" rooms with
tables, power, and whiteboards, etc, and hence people who aren't
engaged in the scheduled topics have nowhere they can get together
and work through problems they need solved with other developers.

If you do need to skip scheduled discussions to get a group together
to solve problems not on the schedule, then everyone loses because
there's no recordings of the discussions they missed....

Unfortunately LSFMM hasn't really attempted to facilitate this sort
of face-to-face collaboration for some time - LSFMM is for talking,
not doing. What we need are better ways of doing, not talking...

> > This kills me because LSFMM has been such a critically important part of
> > Linux development for over a decade, but I think at this point it is at
> > least not serving us the way we want it to, and may even be doing more
> > harm than good.
> 
> I don't think I'd go quite that far, but it's definitely underserving
> the people who can't get in, the people who can't go, and the people who
> are too far away but gosh it would be nice to pull them in even if it's
> only for 30 minutes over a conference call.

A live stream and a restricted access IRC channel for all local and
remote participants would be just fine for all the scheduled
"talking heads" discussions....

e.g. a small group of devs are in a breakout room working on
something directly relevant to them, and they a laptop playing the
live stream of a discussion they are interested in but less
important than what they are currently doing.  Someone hears
something they need to comment on, so they quickly jump onto IRC and
their comment is noticed by everyone in the main discussion room....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
