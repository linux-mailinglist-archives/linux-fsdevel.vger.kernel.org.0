Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE7174B517
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 18:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjGGQ03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 12:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGGQ02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:26:28 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807222108
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1688747183;
        bh=90SzTQ+O56P59omlR6wixIrAK1jUQw+GPtx152jELUs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=TnFAbtCrIFTDx13xgkQ87nOntvZmAtLbFCkqVaOh+EsTDiFNXj1DyIwqqoSTgM2po
         0CU68DjDo70xA+Z0m3LGTgozn8PTF+vT7z1nY0Dm9T/FSBwHX6NUDnJ8uyLzZ8IpT1
         A6w4U8xjni5O/XtmUpzA5+iYOXeGDqwgKX6zXNNk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9195B128603A;
        Fri,  7 Jul 2023 12:26:23 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Gp6G2lKGBYRA; Fri,  7 Jul 2023 12:26:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1688747183;
        bh=90SzTQ+O56P59omlR6wixIrAK1jUQw+GPtx152jELUs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=TnFAbtCrIFTDx13xgkQ87nOntvZmAtLbFCkqVaOh+EsTDiFNXj1DyIwqqoSTgM2po
         0CU68DjDo70xA+Z0m3LGTgozn8PTF+vT7z1nY0Dm9T/FSBwHX6NUDnJ8uyLzZ8IpT1
         A6w4U8xjni5O/XtmUpzA5+iYOXeGDqwgKX6zXNNk=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DCB47128189E;
        Fri,  7 Jul 2023 12:26:21 -0400 (EDT)
Message-ID: <30661670c55601ff475f2f0698c2be2958e45c38.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] bcachefs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com
Date:   Fri, 07 Jul 2023 12:26:19 -0400
In-Reply-To: <20230707091810.bamrvzcif7ncng46@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
         <20230706155602.mnhsylo3pnief2of@moria.home.lan>
         <20230706164055.GA2306489@perftesting>
         <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
         <20230706211914.GB11476@frogsfrogsfrogs>
         <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
         <20230707091810.bamrvzcif7ncng46@moria.home.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-07-07 at 05:18 -0400, Kent Overstreet wrote:
> On Fri, Jul 07, 2023 at 10:48:55AM +0200, Christian Brauner wrote:
> > > just merge it and let's move on to the next thing."
> > 
> > "and let the block and vfs maintainers and developers deal with the
> > fallout"
> > 
> > is how that reads to others that deal with 65+ filesystems and
> > counting.
> > 
> > The offlist thread that was started by Kent before this pr was sent
> > has seen people try to outline calmly what problems they currently
> > still have both maintenance wise and upstreaming wise. And it seems
> > there's just no way this can go over calmly but instead requires
> > massive amounts of defensive pushback and grandstanding.
> > 
> > Our main task here is to consider the concerns of people that
> > constantly review and rework massive amounts of generic code. And I
> > can't in good conscience see their concerns dismissed with snappy
> > quotes.
> > 
> > I understand the impatience, I understand the excitement, I really
> > do. But not in this way where core people just drop off because
> > they don't want to deal with this anymore.
> > 
> > I've spent enough time on this thread.
> 
> Christain, the hostility I'm reading is in your steady passive
> aggressive accusations, and your patronizing attitude. It's not
> professional, and it's not called for.

Can you not see that saying this is a huge red flag?  With you every
disagreement becomes, as Josef said, "a hill to die on" and you then
feel entitled to indulge in ad hominem attacks, like this, or be
dismissive or try to bury whoever raised the objection in technical
minutiae in the hope you can demonstrate you have a better grasp of the
details than they do and therefore their observation shouldn't count.

One of a maintainer's jobs is to nurture and build a community and
that's especially important at the inclusion of a new feature.  What
we've seen from you implies you'd build a community of little Kents
(basically an echo chamber of people who agree with you) and use them
as a platform to attack any area of the kernel you didn't agree with
technically (which, apparently, would be most of block and vfs with a
bit of mm thrown in), leading to huge divisions and infighting.  Anyone
who had the slightest disagreement with you would be out and would
likely behave in the same way you do now leading to internal community
schisms and more fighting on the lists.

We've spent years trying to improve the lists and make the community
welcoming.  However technically brilliant a new feature is, it can't
come with this sort of potential for community and reputational damage.

> Can we please try to stay focused on the code, and the process, and
> the _actual_ concerns?
> 
> In that offlist thread, I don't recall much in the way of actual,
> concrete concerns. I do recall Christoph doing his usual schpiel; and
> to be clear, I cut short my interactions with Christoph because in
> nearly 15 years of kernel development he's never been anything but
> hostile to anything I've posted, and the criticisms he posts tend to
> be vague and unaware of the surrounding discussion, not anything
> actionable.

This too is a red flag.  Working with difficult people is one of a
maintainer's jobs as well.  Christoph has done an enormous amount of
highly productive work over the years.  Sure, he's prickly and sure
there have been fights, but everyone except you seems to manage to
patch things up and accept his contributions.  If it were just one
personal problem it might be overlookable, but you seem to be having
major fights with the maintainer of every subsystem you touch...

James


