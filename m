Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B7D799F99
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 21:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjIJTvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 15:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjIJTvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 15:51:54 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EE510F
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1694375506;
        bh=XepJZ8ppITnO5tGxRwSWXbVdhRx0odSe2uZgxL2BIgA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ftkiIfjv4DnKw/nJo0cdXKdZJenB2sbEvBDzl0YoAxFGhNm1+GxFsvVYU3VUfZnVG
         m9bETagkl2eXdZGfry1gnscGBsIPHxsUcvZvIxeZh+3JolYQ1QTY5D8t1rD3VAGdX5
         zCK/Lm8IkrZCafFpLHX94V8XG5YvS0j9Syv438sE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0A1EB1281786;
        Sun, 10 Sep 2023 15:51:46 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id cdjjbHX5Fk0j; Sun, 10 Sep 2023 15:51:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1694375504;
        bh=XepJZ8ppITnO5tGxRwSWXbVdhRx0odSe2uZgxL2BIgA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CjsYqhL1/jjX4HwqOhowc4PQg/pbAFw1LmnnMbsPKyml6qoXcBf/Vb5un6jzfPoy6
         xVh7JtgGJbmySBQMCfvEdm3vwj4GOm+j4w81Ld/tZi6JmmG0LAelIEKqgVHxoo28pd
         NtRF/6XRn6ro8YY2aJMMYm6XyT+cbC1btrrmSGyY=
Received: from [IPv6:2601:5c4:4302:c21:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4302:c21:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2DA3A12816EE;
        Sun, 10 Sep 2023 15:51:44 -0400 (EDT)
Message-ID: <a21038464ad0afd5dfb88355e1c244152db9b8da.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file
 systems
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Date:   Sun, 10 Sep 2023 15:51:42 -0400
In-Reply-To: <ZPyS4J55gV8DBn8x@casper.infradead.org>
References: <ZO9NK0FchtYjOuIH@infradead.org>
         <ZPe0bSW10Gj7rvAW@dread.disaster.area>
         <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
         <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
         <ZPyS4J55gV8DBn8x@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2023-09-09 at 16:44 +0100, Matthew Wilcox wrote:
> On Sat, Sep 09, 2023 at 08:50:39AM -0400, James Bottomley wrote:
> > On Wed, 2023-09-06 at 00:23 +0100, Matthew Wilcox wrote:
> > > On Wed, Sep 06, 2023 at 09:06:21AM +1000, Dave Chinner wrote:
> > [...]
> > > > > E.g. the hfsplus driver is unmaintained despite collecting
> > > > > odd fixes. It collects odd fixes because it is really useful
> > > > > for interoperating with MacOS and it would be a pity to
> > > > > remove it.  At the same time it is impossible to test changes
> > > > > to hfsplus sanely as there is no mkfs.hfsplus or fsck.hfsplus
> > > > > available for Linux.  We used to have one that was ported
> > > > > from the open source Darwin code drops, and I managed to get
> > > > > xfstests to run on hfsplus with them, but this old version
> > > > > doesn't compile on any modern Linux distribution and new
> > > > > versions of the code aren't trivially portable to Linux.
> > > > > 
> > > > > Do we have volunteers with old enough distros that we can
> > > > > list as testers for this code?  Do we have any other way to
> > > > > proceed?
> > > > > 
> > > > > If we don't, are we just going to untested API changes to
> > > > > these code bases, or keep the old APIs around forever?
> > > > 
> > > > We do slowly remove device drivers and platforms as the
> > > > hardware, developers and users disappear. We do also just
> > > > change driver APIs in device drivers for hardware that no-one
> > > > is actually able to test. The assumption is that if it gets
> > > > broken during API changes, someone who needs it to work will
> > > > fix it and send patches.
> > > > 
> > > > That seems to be the historical model for removing
> > > > unused/obsolete code from the kernel, so why should we treat
> > > > unmaintained/obsolete filesystems any differently?  i.e. Just
> > > > change the API, mark it CONFIG_BROKEN until someone comes along
> > > > and starts fixing it...
> > > 
> > > Umm.  If I change ->write_begin and ->write_end to take a folio,
> > > convert only the filesystems I can test via Luis' kdevops and
> > > mark the rest as CONFIG_BROKEN, I can guarantee you that Linus
> > > will reject that pull request.
> > 
> > I think really everyone in this debate needs to recognize two
> > things:
> > 
> >    1. There are older systems out there that have an active group
> > of
> >       maintainers and which depend on some of these older
> > filesystems
> >    2. Data image archives will ipso facto be in older formats and
> >       preserving access to them is a historical necessity.
> 
> I don't understand why you think people don't recognise those things.

Well, people recognize them as somebody else's problem, yes, like
virtualization below.

> > So the problem of what to do with older, less well maintained,
> > filesystems isn't one that can be solved by simply deleting them
> > and we have to figure out a way to move forward supporting them
> > (obviously for some value of the word "support"). 
> > 
> > By the way, people who think virtualization is the answer to this
> > should remember that virtual hardware is evolving just as fast as
> > physical hardware.
> 
> I think that's a red herring.  Of course there are advances in
> virtual hardware for those who need the best performance.  But
> there's also qemu's ability to provide to you a 1981-vintage PC (or
> more likely a 2000-era PC).  That's not going away.

So Red Hat dropping support for the pc type (alias i440fx)

https://bugzilla.redhat.com/show_bug.cgi?id=1946898

And the QEMU deprecation schedule

https://www.qemu.org/docs/master/about/deprecated.html

showing it as deprecated after 7.0 are wrong?  That's not to say
virtualization can't help at all; it can certainly lengthen the time
horizon, it's just not a panacea.

> > > I really feel we're between a rock and a hard place with our
> > > unmaintained filesystems.  They have users who care passionately,
> > > but not the ability to maintain them.
> > 
> > So why is everybody making this a hard either or? The volunteer
> > communities that grow around older things like filesystems are
> > going to be enthusiastic, but not really acquainted with the
> > technical intricacies of the modern VFS and mm. Requiring that they
> > cope with all the new stuff like iomap and folios is building an
> > unbridgeable chasm they're never going to cross. Give them an
> > easier way and they might get there.
> 
> Spoken like someone who has been paying no attention at all to what's
> going on in filesystems.

Well, that didn't take long;  one useful way to reduce stress on
everyone is actually to reduce the temperature of the discourse.

>   The newer APIs are easier to use.  The problem is understanding
> what the hell the old filesystems are doing with the old APIs.

OK, so we definitely have some filesystems that were experimental at
the time and pushed the boundaries, but not every (or even the
majority) of the older filesystems fall into this category.

> Nobody's interested.  That's the problem.  The number of filesystem
> developers we have is shrinking.  

What I actually heard was that there's communities of interested users,
they just don't get over the hump of becoming developers.  Fine, I get
it that a significant number of users will never become developers, but
that doesn't relieve us of the responsibility for lowering the barriers
for the small number that have the capacity.

> There hasn't been an HFS maintainer since 2011, and it wasn't a
> problem until syzbot decreed that every filesystem bug is a security
> bug.  And now, who'd want to be a fs maintainer with the automated
> harassment?

OK, so now we've strayed into the causes of maintainer burnout.  Syzbot
is undoubtedly a stressor, but one way of coping with a stressor is to
put it into perspective: Syzbot is really a latter day coverity and
everyone was much happier when developers ignored coverity reports and
they went into a dedicated pile that was looked over by a team of
people trying to sort the serious issues from the wrong but not
exploitable ones.  I'd also have to say that anyone who allows older
filesystems into customer facing infrastructure is really signing up
themselves for the risk they're running, so I'd personally be happy if
older fs teams simply ignored all the syzbot reports.

> Burnout amongst fs maintainers is a real problem.  I have no idea how
> to solve it.

I already suggested we should share coping strategies:

https://lore.kernel.org/ksummit/ab9cfd857e32635f626a906410ad95877a22f0db.camel@HansenPartnership.com/

The sources of stress aren't really going to decrease, but how people
react to them could change.  Syzbot (and bugs in general) are a case in
point.  We used not to treat seriously untriaged bug reports, but now
lots of people feel they can't ignore any fuzzer report.  We've tipped
to far into "everything's a crisis" mode and we really need to come
back and think that not every bug is actually exploitable or even
important.  We should go back to  requiring an idea how important the
report is before immediately acting on it.  Perhaps we should also go
back to seeing if we can prize some resources out of the major
moneymakers in the cloud space.  After all, a bug that could cause a
cloud exploit might not be even exploitable on a personal laptop that
has no untrusted users.  So if we left it to the monied cloud farms 
to figure out how to get us a triage of the report and concentrated on
fixing say only the obvious personal laptop exploits, that might be a
way of pushing off some of the stressors.

James


