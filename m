Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E5E267AF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 16:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgILOhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgILOhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 10:37:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF71C061573;
        Sat, 12 Sep 2020 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x6nBYphj0AF/pOZ4flCMGtPE2h9UZxTEO79MZBPKz6s=; b=G7+w2x63lTwbCwdO7/Xqy3P2qE
        cpV3hPuvwctYAHgXjOdTLORNXUgsasu7is/Z+fJBmcnD2MfJXrt3scopS13uKaf/lrioIGVg1JQkc
        HD4u4UO7XEkkdw7xh9MLibec2E3B44bOkKjfC1tW/s2Iy5CM3KDI0s9FGWdbMDl5/ULsVD4oAMKs5
        9+B2iFx15YiDnqstLDAnroRjzDI0oPum+uy1NQ4h4JSAPVWxTyr3e9EBYuf6/2Tg+mZILB7p7c/3m
        Tqj/yt1gGl+zN38+HSVbIfSDU9S8lPnV5wy0YF/5yQo+AxsyyYsiAYzY95gdWQyzy7BIoUFzDuQMb
        DEhTtpYw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kH6eG-00072o-9v; Sat, 12 Sep 2020 14:37:04 +0000
Date:   Sat, 12 Sep 2020 15:37:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michael Larabel <Michael@michaellarabel.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200912143704.GB6583@casper.infradead.org>
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 05:32:11AM -0500, Michael Larabel wrote:
> On 9/12/20 2:28 AM, Amir Goldstein wrote:
> > On Sat, Sep 12, 2020 at 1:40 AM Michael Larabel
> > <Michael@michaellarabel.com> wrote:
> > > On 9/11/20 5:07 PM, Linus Torvalds wrote:
> > > > On Fri, Sep 11, 2020 at 9:19 AM Linus Torvalds
> > > > <torvalds@linux-foundation.org> wrote:
> > > > > Ok, it's probably simply that fairness is really bad for performance
> > > > > here in general, and that special case is just that - a special case,
> > > > > not the main issue.
> > > > Ahh. It turns out that I should have looked more at the fault path
> > > > after all. It was higher up in the profile, but I ignored it because I
> > > > found that lock-unlock-lock pattern lower down.
> > > > 
> > > > The main contention point is actually filemap_fault(). Your apache
> > > > test accesses the 'test.html' file that is mmap'ed into memory, and
> > > > all the threads hammer on that one single file concurrently and that
> > > > seems to be the main page lock contention.
> > > > 
> > > > Which is really sad - the page lock there isn't really all that
> > > > interesting, and the normal "read()" path doesn't even take it. But
> > > > faulting the page in does so because the page will have a long-term
> > > > existence in the page tables, and so there's a worry about racing with
> > > > truncate.
> > > > 
> > > > Interesting, but also very annoying.
> > > > 
> > > > Anyway, I don't have a solution for it, but thought I'd let you know
> > > > that I'm still looking at this.
> > > > 
> > > >                   Linus
> > > I've been running your EXT4 patch on more systems and with some
> > > additional workloads today. While not the original problem, the patch
> > > does seem to help a fair amount for the MariaDB database sever. This
> > > wasn't one of the workloads regressing on 5.9 but at least with the
> > > systems tried so far the patch does make a meaningful improvement to the
> > > performance. I haven't run into any apparent issues with that patch so
> > > continuing to try it out on more systems and other database/server
> > > workloads.
> > > 
> > Michael,
> > 
> > Can you please add a reference to the original problem report and
> > to the offending commit? This conversation appeared on the list without
> > this information.
> > 
> > Are filesystems other than ext4 also affected by this performance
> > regression?
> > 
> > Thanks,
> > Amir.
> 
> On Linux 5.9 Git, Apache HTTPD, Redis, Nginx, and Hackbench appear to be the
> main workloads that are running measurably slower than on Linux 5.8 and
> prior on multiple systems.
> 
> The issue was bisected to 2a9127fcf2296674d58024f83981f40b128fffea. The
> Kernel Test Robot also previously was triggered by the commit in question
> with mixed Hackbench results. In looking at the problem Linus had a hunch
> when looking at the perf data that it may have had an adverse reaction with
> the EXT4 locking behavior to which he sent out that patch. That EXT4 patch
> didn't end up addressing the performance issue with the original workloads
> in question (though in testing other workloads it seems to have benefit for
> MariaDB at least depending upon the system there can be slightly better
> performance).

Based on this limited amount of information, I would suspect there would
also be a problem with XFS, and that would be even _more_ sad because
XFS already excludes a truncate-vs-mmap race with the MMAPLOCK_SHARED in
__xfs_filemap_fault vs MMAPLOCK_EXCL ... somewhere in the truncate path,
I'm sure.  It's definitely there for the holepunch.

So maybe XFS should have its own implementation of filemap_fault,
or we should have a filemap_fault_locked() for filesystems which have
their own locking that excludes truncate.
