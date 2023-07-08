Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2233674BB9D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 05:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjGHDyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 23:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHDye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 23:54:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FEF1FEA;
        Fri,  7 Jul 2023 20:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KkR6qQII6aUIOqjfcYh+jGFmxvXMfkpuLpVAT1tWvzU=; b=wDqhxdEK8D1gCf+DCso8yvWjHr
        poJ5ezfh9CHO90JSHQ14g1EBhG1/YUu0gWZtaKa7+p0d0fWFHbt+f9ux1PnDIK8fw+5fBfqhM1aER
        griu+BUNMlQXyVvB+K58VZX2Sm1xFq7Gtx8+RxAOYMBxTB8gVJFJWNkr21fJ8bt8bs6t498/fyAur
        wAVbCQzHWiyn30ZtecyXUT6weD1KcB944L96I2IY6pQeH+AORcsftDPu0IdOMocY08U/RJBo9DtV0
        hbI+8aw2RXmTw+CSmqv5s3gxPYOdl4pvZLGuVA1zkLOi9h+UPu4yiubxY4AXkoyW7VqKfUt0fZoKv
        KQAYhDtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHz1a-00CcC5-Hj; Sat, 08 Jul 2023 03:54:23 +0000
Date:   Sat, 8 Jul 2023 04:54:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, tytso@mit.edu,
        bfoster@redhat.com, jack@suse.cz, andreas.gruenbacher@gmail.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZKjd7nQxvzRDA2tK@casper.infradead.org>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <20230706211914.GB11476@frogsfrogsfrogs>
 <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
 <20230707091810.bamrvzcif7ncng46@moria.home.lan>
 <30661670c55601ff475f2f0698c2be2958e45c38.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30661670c55601ff475f2f0698c2be2958e45c38.camel@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 07, 2023 at 12:26:19PM -0400, James Bottomley wrote:
> On Fri, 2023-07-07 at 05:18 -0400, Kent Overstreet wrote:
> > Christain, the hostility I'm reading is in your steady passive
> > aggressive accusations, and your patronizing attitude. It's not
> > professional, and it's not called for.
> 
> Can you not see that saying this is a huge red flag?  With you every
> disagreement becomes, as Josef said, "a hill to die on" and you then
> feel entitled to indulge in ad hominem attacks, like this, or be
> dismissive or try to bury whoever raised the objection in technical
> minutiae in the hope you can demonstrate you have a better grasp of the
> details than they do and therefore their observation shouldn't count.
> 
> One of a maintainer's jobs is to nurture and build a community and
> that's especially important at the inclusion of a new feature.  What
> we've seen from you implies you'd build a community of little Kents
> (basically an echo chamber of people who agree with you) and use them
> as a platform to attack any area of the kernel you didn't agree with
> technically (which, apparently, would be most of block and vfs with a
> bit of mm thrown in), leading to huge divisions and infighting.  Anyone
> who had the slightest disagreement with you would be out and would
> likely behave in the same way you do now leading to internal community
> schisms and more fighting on the lists.
> 
> We've spent years trying to improve the lists and make the community
> welcoming.  However technically brilliant a new feature is, it can't
> come with this sort of potential for community and reputational damage.

I don't think the lists are any better, tbh.  Yes, the LF has done a great
job of telling people not to use "bad words" any more.  But people are
still arseholes to each other.  They're just more subtle about it now.
I'm not going to enumerate the ways because that's pointless.

Consider this thread from Kent's point of view.  He's worked for years
on bcachefs.  Now he's asking "What needs to happen to get this merged?"
And instead of getting a clear answer as to the technical pieces that
need to get fixed, various people are taking the opportunity to tell him
he's a Bad Person.  And when he reacts to that, this is taken as more
evidence that he's a Bad Person, rather than being a person who is in
a stressful situation (Limbo?  Purgatory?) who is perhaps not reacting
in the most constructive way.

I don't think Kent is particularly worse as a fellow developer than you
or I or Jens, Greg, Al, Darrick, Dave, Dave, Dave, Dave, Josef or Brian.
There are some social things which are a concern to me.  There's no
obvious #2 or #3 to step in if Kent does get hit by the proverbial bus,
but that's been discussed elsewhere in the thread.

Anyway, I'm in favour of bcachefs inclusion.  I think the remaining
problems can be worked out post-merge.  I don't see Kent doing a
drop-and-run on the codebase.  Maintaining this much code outside the
main kernel tree is hard.  One thing I particularly like about btrfs
compared to ntfs3 is that it doesn't use old legacy code like the buffer
heads, which means that it doesn't add to the technical debt.  From the
page cache point of view, it's fairly clean.  I wish it used iomap, but
iomap would need quite a lot of new features to accommodate everything
bcachefs wants to do.  Maybe iomap will grow those features over time.
