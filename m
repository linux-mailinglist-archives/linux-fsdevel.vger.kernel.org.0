Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2422D79A1A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Sep 2023 05:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjIKDKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 23:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjIKDKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:10:52 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDF5106
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 20:10:47 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-225.bstnma.fios.verizon.net [173.48.113.225])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38B3AFIF002752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Sep 2023 23:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1694401819; bh=Y4MQXZptEaxvgTu5opSKlAFWAlU8amKupQTFzDGYgk4=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=Ve9KdlaGXMlb8mnOtsMW6XpFQNW2arxSCy9tfxfVP8V7CeLN8ifJn3aDPgMUfLZ8K
         596p25S9FfBGdnsVSWILGJE+JJ7FfsCW6XeZu7JiSCQXe80KX51g35S9aifD218X/7
         18sgmH9CGDOZRWdUsIuXjcdA1t+v4Ut3Ehlo4/SeoGJKwwaNStqTwzHcgkrN3GohlL
         EaZi2uh/qWYqmgAiEtgVbTvW4lQPUkVWfZ+o99uXEmc5ZoE+XvhaRts8NkJpWsV1gD
         kJGSg24/OosXrzL1bmW7d5NQP0EzbA5hdtz4t4z9WStJzo4/JIhRQvN/vE9lIuM5zY
         KeYmC8owMEZpA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B095015C023F; Sun, 10 Sep 2023 23:10:15 -0400 (EDT)
Date:   Sun, 10 Sep 2023 23:10:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <20230911031015.GF701295@mit.edu>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
 <ZPyS4J55gV8DBn8x@casper.infradead.org>
 <a21038464ad0afd5dfb88355e1c244152db9b8da.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a21038464ad0afd5dfb88355e1c244152db9b8da.camel@HansenPartnership.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 10, 2023 at 03:51:42PM -0400, James Bottomley wrote:
> On Sat, 2023-09-09 at 16:44 +0100, Matthew Wilcox wrote:
> > There hasn't been an HFS maintainer since 2011, and it wasn't a
> > problem until syzbot decreed that every filesystem bug is a security
> > bug.  And now, who'd want to be a fs maintainer with the automated
> > harassment?

The problem is that peopel are *believing* syzbot.  If we treat it as
noise, we can ignore it.  There is nothing that says we have to
*believe* syzbot's "decrees" over what is a security bug, and what
isn't.

Before doing a security assessment, you need to have a agreed-upon
threat model.  Another security aphorism, almost as well known this
one, is that security has to be designed in from the start --- and
historically, the storage device on which the file system operates is
part of the trusted computing base.  So trying to change the security
model to one that states that one must assume that the storage device
is under the complete and arbitrary control of the attacker is just
foolhardy.

There are also plenty of circumstances where this threat model is
simply not applicable.  For example, if the server is a secure data
center, and/or where USB ports are expoxy shut, and/or the automounter
is disabled, or not even installed, then this particular threat is
simply not in play.

> OK, so now we've strayed into the causes of maintainer burnout.  Syzbot
> is undoubtedly a stressor, but one way of coping with a stressor is to
> put it into perspective: Syzbot is really a latter day coverity and
> everyone was much happier when developers ignored coverity reports and
> they went into a dedicated pile that was looked over by a team of
> people trying to sort the serious issues from the wrong but not
> exploitable ones.  I'd also have to say that anyone who allows older
> filesystems into customer facing infrastructure is really signing up
> themselves for the risk they're running, so I'd personally be happy if
> older fs teams simply ignored all the syzbot reports.

Exactly.  So to the first approximation, if the syzbot doesn't have a
reliable reproducer --- ignore it.  If it involves a corrupted file
system, don't consider it a security bug.  Remember, we didn't sign up
for claiming that the file system should be proof against malicious
file system image.

I might take a look at it to see if we can improve the quality of the
implementation, but I don't treat it with any kind of urgency.  It's
more of something I do for fun, when I have a free moment or two.  And
when I have higher priority issues, syzkaller issues simply get
dropped and ignored.

The gamification which makes this difficult is when you get the
monthly syzbot reports, and you see the number of open syzkaller
issues climb.  It also doesn't help when you compare the number of
syzkaller issues for your file system with another file system.  For
me, one of the ways that I try to evade the manpulation is to remember
that the numbers are completely incomparable.

For example, if a file system is being used as the root file system,
and there some device driver or networking subsystem is getting
pounded, leading to kernel memory corruptions before the userspace
core dumps, this can generate the syzbot report which is "charged"
against the file system, when in fact it's not actually a file system
bug at all.  Or if the file system hasn't cooperated with Google's
intern project to disable metadata checksum verifications, the better
to trigger more file system corruption-triggered syzbot reports, this
can depress one file system's syzbot numbers over another.

So the bottom line is that the number of syzbot is ultimately fairly
meaningless as a comparison betweentwo different kernel subsystems,
despite the syzbot team's best attempts to manipulate you into feeling
bad about your code, and feeling obligated to Do Something about
bringing down the number of syzbot reports.

This is a "dark pattern", and you should realize this, and not let
yourself get suckered into falling for this mind game.

> The sources of stress aren't really going to decrease, but how people
> react to them could change.  Syzbot (and bugs in general) are a case in
> point.  We used not to treat seriously untriaged bug reports, but now
> lots of people feel they can't ignore any fuzzer report.  We've tipped
> to far into "everything's a crisis" mode and we really need to come
> back and think that not every bug is actually exploitable or even
> important.

Exactly.  A large number of unaddressed syzbot number is not a "kernel
security disaster" unless you let yourself get tricked into believing
that it is.  Again, it's all about threat models, and the syzbot robot
very cleverly hides any discussion over the threat model, and whether
it is valid, and whether it is one that you care about --- or whether
your employer should care.

> Perhaps we should also go
> back to seeing if we can prize some resources out of the major
> moneymakers in the cloud space.  After all, a bug that could cause a
> cloud exploit might not be even exploitable on a personal laptop that
> has no untrusted users.

Actually, I'd say this is backwards.  Many of these issues, and I'd
argue all that involve an maliciously corrupted file system, are not
actually an issue in the cloud space, because we *already* assume that
the attacker may have root.  After all, anyone can pay their $5
CPU/hour, and get an Amazon or Google or Azure VM, and then run
arbitrary workloads as root.

As near as I can tell **no** **one** is crazy enough to assume that
native containers are a security boundary.  For that reason, when a
cloud customer is using Docker, or Kubernetes, they are running it on
a VM which is dedicated to that customer.  Kubernetes jobs running on
behalf of say, Tesla Motors do not run on the same VM as the one
running Kuberentes jobs for Ford Motor Company, so even if an attacker
mounts a malicious file system iamge, they can't use that to break
security and get access to proprietary data belonging to a competitor.

The primary risk for maliciously corrupted file systems is because
GNOME automounts file systems by default, and so many a laptop is
subject to vulnerabilities if someone plugs in an untrusted USB key on
their personal laptop.  But this risk can be addressed simply by
uninstalling the automounter, and a future release of e2fsprogs will
include this patch:

https://lore.kernel.org/all/20230824235936.GA17891@frogsfrogsfrogs/

... which will install a udev rule that will fix this bad design
problem, at least for ext4 file systems.  Of course, a distro could
decide to take remove the udev rule, but at that point, I'd argue that
liability attaches to the distribution for disabling this security
mitigation, and it's no longer the file system developer's
responsibility.

						- Ted
