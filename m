Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DD174387A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 11:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjF3Jkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 05:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjF3Jkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:40:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AAC102;
        Fri, 30 Jun 2023 02:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4EC561711;
        Fri, 30 Jun 2023 09:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBF2C433C8;
        Fri, 30 Jun 2023 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688118037;
        bh=ehDPDeZJhnSrHL5jnxRgTuJeypAvNTdTtajSPzZMEHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aaP971a01ZkjeSwtKsJnHu7+h+J1HplZK16y5TQ0RgpXXuJ7Rvh5RMCwUrInEqmXP
         8K9VD6T2W4ZDSiKmDjIhPWRbqfXUONbf3EGf5JliWmSFD9COMk4aBaCpg2iBZrDQGy
         5p/YBriNacrD25o72EtRHPKz58XBAx544obG9/dqMr+97E6KoWRvJJjUgRPmh9pS1v
         Q7HUh1uFdKVBUIVZeqY7alym1B3JZV/7Dv1LxB72X8703oP+rqYsxInEBOt3PJcYbn
         TnIDJmp/9vzue7/Mrm/eC/cZ4zhjbpckUbqTX5Dbq6SbaZiUltYoiUHJrOE9YdTG2L
         4gjCR3iG2Dk+g==
Date:   Fri, 30 Jun 2023 11:40:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230630-aufwiegen-ausrollen-e240052c0aaa@brauner>
References: <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
 <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
 <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
 <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
 <1e2134f1-f48b-1459-a38e-eac9597cd64a@kernel.dk>
 <20230628235018.ttvtzpfe42fri4yq@moria.home.lan>
 <ZJzXs6C8G2SL10vq@dread.disaster.area>
 <d6546c44-04db-cbca-1523-a914670a607f@kernel.dk>
 <20230629-fragen-dennoch-fb5265aaba23@brauner>
 <20230629153108.wyn32bvaxmztnakl@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230629153108.wyn32bvaxmztnakl@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:31:09AM -0400, Kent Overstreet wrote:
> On Thu, Jun 29, 2023 at 01:18:11PM +0200, Christian Brauner wrote:
> > On Wed, Jun 28, 2023 at 07:33:18PM -0600, Jens Axboe wrote:
> > > On 6/28/23 7:00?PM, Dave Chinner wrote:
> > > > On Wed, Jun 28, 2023 at 07:50:18PM -0400, Kent Overstreet wrote:
> > > >> On Wed, Jun 28, 2023 at 05:14:09PM -0600, Jens Axboe wrote:
> > > >>> On 6/28/23 4:55?PM, Kent Overstreet wrote:
> > > >>>>> But it's not aio (or io_uring or whatever), it's simply the fact that
> > > >>>>> doing an fput() from an exiting task (for example) will end up being
> > > >>>>> done async. And hence waiting for task exits is NOT enough to ensure
> > > >>>>> that all file references have been released.
> > > >>>>>
> > > >>>>> Since there are a variety of other reasons why a mount may be pinned and
> > > >>>>> fail to umount, perhaps it's worth considering that changing this
> > > >>>>> behavior won't buy us that much. Especially since it's been around for
> > > >>>>> more than 10 years:
> > > >>>>
> > > >>>> Because it seems that before io_uring the race was quite a bit harder to
> > > >>>> hit - I only started seeing it when things started switching over to
> > > >>>> io_uring. generic/388 used to pass reliably for me (pre backpointers),
> > > >>>> now it doesn't.
> > > >>>
> > > >>> I literally just pasted a script that hits it in one second with aio. So
> > > >>> maybe generic/388 doesn't hit it as easily, but it's surely TRIVIAL to
> > > >>> hit with aio. As demonstrated. The io_uring is not hard to bring into
> > > >>> parity on that front, here's one I posted earlier today for 6.5:
> > > >>>
> > > >>> https://lore.kernel.org/io-uring/20230628170953.952923-4-axboe@kernel.dk/
> > > >>>
> > > >>> Doesn't change the fact that you can easily hit this with io_uring or
> > > >>> aio, and probably more things too (didn't look any further). Is it a
> > > >>> realistic thing outside of funky tests? Probably not really, or at least
> > > >>> if those guys hit it they'd probably have the work-around hack in place
> > > >>> in their script already.
> > > >>>
> > > >>> But the fact is that it's been around for a decade. It's somehow a lot
> > > >>> easier to hit with bcachefs than XFS, which may just be because the
> > > >>> former has a bunch of workers and this may be deferring the delayed fput
> > > >>> work more. Just hand waving.
> > > >>
> > > >> Not sure what you're arguing here...?
> > > >>
> > > >> We've had a long standing bug, it's recently become much easier to hit
> > > >> (for multiple reasons); we seem to be in agreement on all that. All I'm
> > > >> saying is that the existence of that bug previously is not reason to fix
> > > >> it now.
> > > > 
> > > > I agree with Kent here  - the kernel bug needs to be fixed
> > > > regardless of how long it has been around. Blaming the messenger
> > > > (userspace, fstests, etc) and saying it should work around a
> > > > spurious, unpredictable, undesirable and user-undebuggable kernel
> > > > behaviour is not an acceptible solution here...
> > > 
> > > Not sure why you both are putting words in my mouth, I've merely been
> > > arguing pros and cons and the impact of this. I even linked the io_uring
> > > addition for ensuring that side will work better once the deferred fput
> > > is sorted out. I didn't like the idea of fixing this through umount, and
> > > even outlined how it could be fixed properly by ensuring we flush
> > > per-task deferred puts on task exit.
> > > 
> > > Do I think it's a big issue? Not at all, because a) nobody has reported
> > > it until now, and b) it's kind of a stupid case. If we can fix it with
> > 
> > Agreed.
> 
> yeah, the rest of this email that I snipped is _severely_ confused about
> what is going on here.
> 
> Look, the main thing I want to say is - I'm not at all impressed by this
> continual evasiveness from you and Jens. It's a bug, it needs to be
> fixed.
> 
> We are engineers. It is our literal job to do the hard work and solve
> the hard problems, and leave behind a system more robust and more
> reliable for the people who come after us to use.
> 
> Not to kick the can down the line and leave lurking landmines in the
> form of "oh you just have to work around this like x..."

We're all not very impressed with that's going on here. I think everyone
has made that pretty clear.

It's worrying that this reply is so quickly and happily turning to
"I'm a real engineer" and "you're confused" tropes and then isn't even
making a clear point. Going forward this should stop otherwise I'll
cease replying.

Nothing I said was confused. The discussion was initially trying to fix
this in umount and we're not going to fix async aio behavior in umount.

My earlier mail clearly said that io_uring can be changed by Jens pretty
quickly to not cause such test failures.

But there's a trade-off to be considered where we have to introduce new
sensitive and complicated file cleanup code for the sake of the legacy
aio api that even the manpage marks as incomplete and buggy. And all for
an issue that was only ever found out in a test and for behavior that's
existed since the dawn of time.

"We're real engineers" is not an argument for that trade off being
sensible.
