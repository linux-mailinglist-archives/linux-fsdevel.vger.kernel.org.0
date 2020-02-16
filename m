Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9569C1606D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 22:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBPV4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 16:56:04 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:35981 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgBPV4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 16:56:03 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 265F9581697;
        Mon, 17 Feb 2020 08:55:58 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j3RtN-0003F1-09; Mon, 17 Feb 2020 08:55:57 +1100
Date:   Mon, 17 Feb 2020 08:55:56 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200216215556.GZ10776@dread.disaster.area>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
 <20200202214620.GA20628@dread.disaster.area>
 <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com>
 <20200212220600.GS6870@magnolia>
 <20200213151100.GC6548@bfoster>
 <20200213154632.GN7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213154632.GN7778@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=25-AhOLfAAAA:8 a=07d9gI8wAAAA:8 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=MlCfdl6fjhP_pz4a8zAA:9 a=CjuIK1q_8ugA:10 a=OFP1li_Ydx4A:10
        a=dnuY3_Gu-P7Vi9ynLKQe:22 a=e2CUPOnPG4QKp8I52DXD:22
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 07:46:32AM -0800, Matthew Wilcox wrote:
> On Thu, Feb 13, 2020 at 10:11:00AM -0500, Brian Foster wrote:
> > With regard to the burnout thing, ISTM the core functionality of the
> > maintainer is to maintain the integrity of the subtree. That involves
> > things like enforcing development process (i.e., requiring r-b tags on
> > all patches to merge), but not necessarily being obligated to resolve
> > conflicts or to review every patch that comes through in detail, or
> > guarantee that everything sent to the list makes it into the next
> > release, etc. If certain things aren't being reviewed in time or making
> > progress and that somehow results in additional pressure on the
> > maintainer, ISTM that something is wrong there..?
> > 
> > On a more logistical note, didn't we (XFS) discuss the idea of a
> > rotating maintainership at one point? I know Dave had dealt with burnout
> > after doing this job for quite some time, Darrick stepped in and it
> > sounds like he is now feeling it as well (and maybe Eric, having to hold
> > down the xfsprogs fort). I'm not maintainer nor do I really want to be,
> > but I'd be willing to contribute to maintainer like duties on a limited
> > basis if there's a need. For example, if we had a per-release rotation
> > of 3+ people willing to contribute, perhaps that could spread the pain
> > around sufficiently..? Just a thought, and of course not being a
> > maintainer I have no idea how realistic something like that might be..
> 
> Not being an XFS person, I don't want to impose anything, but have
> you read/seen Dan Vetter's talk on this subject?
> https://blog.ffwll.ch/2017/01/maintainers-dont-scale.html (plenty of
> links to follow, including particularly https://lwn.net/Articles/705228/ )

Yes, and I've talked to Dan in great detail about it over several
past LCAs... :)

> It seems like the XFS development community might benefit from a
> group maintainer model.

Yes, it may well do. The problem is the pool of XFS developers is
*much smaller* than the graphics subsystem and so a "group
maintainership" if kinda what we do already. I mean, I do have
commit rights to the XFS trees kernel.org, even though I'm not a
maintainer. I'm essentially the backup at this point - if someone
needs to take time off, I'll take over.

I think the biggest barrier to maintaining the XFS tree is the
amount of integration testing that the maintainer does on the merged
tree.  That's non-trivial, especially with how long it takes to run
fstests these days. If you're not set up to run QA 24x7 across a
bunch of different configs, then you need to get that into place
before being able to do the job of maintaining the XFS kernel
tree...

If everyone had that capability and resources at their disposal, then
rotating the tree maintenance responsibilities would be much
easier...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
