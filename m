Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E743415C45F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 16:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbgBMPqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 10:46:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387796AbgBMPqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TQwUz2ZkaJ8gecpPtXHrS+wN7NxFdfsIuWKZZP0lIr8=; b=JIt6e8oqK/nTNJlPp83LkGsSZJ
        dQ14bOkbG4OWoPG257sbE/Sl2DFk69M/VsOV3tskZnsjZlUXQHrRS/bTLZBKq9owsAGxL0cfFkO+h
        9L5JaxOudrERYCw64A6HBVfFSWdw2V6UFVoMgRzfaZaN10jmxVRIZua2dESe/O/z8gtSpHmLyiBm4
        sbM1cMP2AkePgAHZYdP96KqSXRPnBqjB208zm6dy0tLOBYFiZCWDNcr72u/rm7PFBXTCImj/HZycT
        wKkmbpYm9zhveLSC8dAGHK0wifrdTNVY6+WBZq+yx6P+dHpaFuYgSRKoXEDpQXrnS78pW2moZDfwh
        ou6/2wgQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2GhF-0006W8-2K; Thu, 13 Feb 2020 15:46:33 +0000
Date:   Thu, 13 Feb 2020 07:46:32 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200213154632.GN7778@bombadil.infradead.org>
References: <20200131052520.GC6869@magnolia>
 <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com>
 <20200202214620.GA20628@dread.disaster.area>
 <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com>
 <20200212220600.GS6870@magnolia>
 <20200213151100.GC6548@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213151100.GC6548@bfoster>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:11:00AM -0500, Brian Foster wrote:
> With regard to the burnout thing, ISTM the core functionality of the
> maintainer is to maintain the integrity of the subtree. That involves
> things like enforcing development process (i.e., requiring r-b tags on
> all patches to merge), but not necessarily being obligated to resolve
> conflicts or to review every patch that comes through in detail, or
> guarantee that everything sent to the list makes it into the next
> release, etc. If certain things aren't being reviewed in time or making
> progress and that somehow results in additional pressure on the
> maintainer, ISTM that something is wrong there..?
> 
> On a more logistical note, didn't we (XFS) discuss the idea of a
> rotating maintainership at one point? I know Dave had dealt with burnout
> after doing this job for quite some time, Darrick stepped in and it
> sounds like he is now feeling it as well (and maybe Eric, having to hold
> down the xfsprogs fort). I'm not maintainer nor do I really want to be,
> but I'd be willing to contribute to maintainer like duties on a limited
> basis if there's a need. For example, if we had a per-release rotation
> of 3+ people willing to contribute, perhaps that could spread the pain
> around sufficiently..? Just a thought, and of course not being a
> maintainer I have no idea how realistic something like that might be..

Not being an XFS person, I don't want to impose anything, but have
you read/seen Dan Vetter's talk on this subject?
https://blog.ffwll.ch/2017/01/maintainers-dont-scale.html (plenty of
links to follow, including particularly https://lwn.net/Articles/705228/ )

It seems like the XFS development community might benefit from a
group maintainer model.
