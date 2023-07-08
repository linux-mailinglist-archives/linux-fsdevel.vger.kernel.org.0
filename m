Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFBC74BE7A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGHQnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jul 2023 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGHQnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jul 2023 12:43:10 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CD9E50;
        Sat,  8 Jul 2023 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1688834584;
        bh=eOhRCxRa33bQTogP6wXJZig9p4KuUl8R4DZju5LEYNw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CsoHrG8yuUoolQ0fir5s0wayefNertHMNkRxREmfLhljND9nXtd5tzVrkUQzzPkuX
         1XqvH0NJg6mIWC1LQeDXt1Z1Nwyji+romTEbmkXF+3uUnHI1ZwTylFpj0wFuri5fez
         +Lq/S9egoMONvvLFC75+ZHi4UWcbw3dIchXZHCfc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3D22C12816A0;
        Sat,  8 Jul 2023 12:43:04 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id AXivlkcxDbrm; Sat,  8 Jul 2023 12:43:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1688834582;
        bh=eOhRCxRa33bQTogP6wXJZig9p4KuUl8R4DZju5LEYNw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=wnEP4DSuIApwJumg429Yi4gxSWfuF1Sg0oLPykmBSxaev9DXxdJ+QNH3ooFW1FxaP
         1DZE/74XtWW5LZdXRnS4nZrb6Z1ORbNnMrBKwQhneLcJJ35OaByylMTEbE+5wgIHfD
         HGMSk+RRyky5Fcv4BiXwM3ANqmIGs8fEU+KZKV/U=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 579CC1281321;
        Sat,  8 Jul 2023 12:43:01 -0400 (EDT)
Message-ID: <f8f36ffc1360daad3df907c901144144cbcba106.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] bcachefs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>
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
Date:   Sat, 08 Jul 2023 12:42:59 -0400
In-Reply-To: <ZKjd7nQxvzRDA2tK@casper.infradead.org>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
         <20230706155602.mnhsylo3pnief2of@moria.home.lan>
         <20230706164055.GA2306489@perftesting>
         <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
         <20230706211914.GB11476@frogsfrogsfrogs>
         <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
         <20230707091810.bamrvzcif7ncng46@moria.home.lan>
         <30661670c55601ff475f2f0698c2be2958e45c38.camel@HansenPartnership.com>
         <ZKjd7nQxvzRDA2tK@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2023-07-08 at 04:54 +0100, Matthew Wilcox wrote:
> On Fri, Jul 07, 2023 at 12:26:19PM -0400, James Bottomley wrote:
> > On Fri, 2023-07-07 at 05:18 -0400, Kent Overstreet wrote:
> > > Christain, the hostility I'm reading is in your steady passive
> > > aggressive accusations, and your patronizing attitude. It's not
> > > professional, and it's not called for.
> > 
> > Can you not see that saying this is a huge red flag?  With you
> > every disagreement becomes, as Josef said, "a hill to die on" and
> > you then feel entitled to indulge in ad hominem attacks, like this,
> > or be dismissive or try to bury whoever raised the objection in
> > technical minutiae in the hope you can demonstrate you have a
> > better grasp of the details than they do and therefore their
> > observation shouldn't count.
> > 
> > One of a maintainer's jobs is to nurture and build a community and
> > that's especially important at the inclusion of a new feature. 
> > What we've seen from you implies you'd build a community of little
> > Kents (basically an echo chamber of people who agree with you) and
> > use them as a platform to attack any area of the kernel you didn't
> > agree with technically (which, apparently, would be most of block
> > and vfs with a bit of mm thrown in), leading to huge divisions and
> > infighting.  Anyone who had the slightest disagreement with you
> > would be out and would likely behave in the same way you do now
> > leading to internal community schisms and more fighting on the
> > lists.
> > 
> > We've spent years trying to improve the lists and make the
> > community welcoming.  However technically brilliant a new feature
> > is, it can't come with this sort of potential for community and
> > reputational damage.
> 
> I don't think the lists are any better, tbh.  Yes, the LF has done a
> great job of telling people not to use "bad words" any more.  But
> people are still arseholes to each other.

I don't think the LF has done much actively on the lists ... we've been
trying to self police.

>   They're just more subtle about it now. I'm not going to enumerate
> the ways because that's pointless.

Well, we can agree to differ since this isn't relevant to the main
argument.

> Consider this thread from Kent's point of view.  He's worked for
> years on bcachefs.  Now he's asking "What needs to happen to get this
> merged?" And instead of getting a clear answer as to the technical
> pieces that need to get fixed, various people are taking the
> opportunity to tell him he's a Bad Person.  And when he reacts to
> that, this is taken as more evidence that he's a Bad Person, rather
> than being a person who is in a stressful situation (Limbo? 
> Purgatory?) who is perhaps not reacting in the most constructive way.

That's a bit of a straw man: I never said or implied "bad person".  I
gave two examples, one from direct list interaction and one quoted from
Kent of what I consider to be red flags behaviours on behalf of a
maintainer.

> I don't think Kent is particularly worse as a fellow developer than
> you or I or Jens, Greg, Al, Darrick, Dave, Dave, Dave, Dave, Josef or
> Brian.

I don't believe any of us have been unable to work with a fairly
prolific contributor for 15 years ...

>  There are some social things which are a concern to me.  There's no
> obvious #2 or #3 to step in if Kent does get hit by the proverbial
> bus, but that's been discussed elsewhere in the thread.

Actually, I don't think this is a problem: a new feature has no users
and having no users, it doesn't matter if it loses its only maintainer
because it can be excised without anyone really noticing.  The bus
problem (or more accurately xkcd 2347 problem) commonly applies to a
project with a lot of users but an anaemic developer community, which
is a thing that can be grown to but doesn't happen ab initio.  The
ordinary course for a kernel feature is single developer; hobby project
(small community of users as developers); and eventually a non
technical user community.  Usually the hobby project phase grows enough
interested developers to ensure a fairly healthy developer community by
the time it actually acquires non developer users (and quite a few of
our features never actually get out of the hobby project phase).

James

