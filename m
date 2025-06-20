Return-Path: <linux-fsdevel+bounces-52303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562C6AE14B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 09:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0028D1698DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 07:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E135E227B9A;
	Fri, 20 Jun 2025 07:20:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5430E85C;
	Fri, 20 Jun 2025 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404020; cv=none; b=KrH4qZOB+EftGcQlCqJa+h0M2UjhHvRgk632GzIjqSJv/aKJ84rm7JOpZQprJ5JGoqp48u0Jir1SBl4ms724l5zG5FzXhO3jLhGAQ6D1Db2jQXqFoYXhzWXj2ezudxgdQOCa6pZTwfWoaIdO/AtsL7ZxTjovrzbenLbXIg1XPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404020; c=relaxed/simple;
	bh=640FEkkWd+camIx2PfPKgGyzSdcB8xu/mk++Zu4dM30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPnyetH+xJE8ijgQ8GtLDeyzWk5Av1MgTqAqLmwCbxe8vs+5+bj4ArFsryZZIB/0hc+2fs7/yLTg1ZE+0ustnSnakcrY0YQRD0wVXDQ1YSATOOTOgwJJiml9shXbGWcjh1O8d17oD9cdEt7qcXGItMkzumdA+TNyUpu3ezZaaqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 406E510F721;
	Fri, 20 Jun 2025 07:12:24 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Jani Partanen <jiipee@sotapeli.fi>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
Date: Fri, 20 Jun 2025 09:12:21 +0200
Message-ID: <3366564.44csPzL39Z@lichtvoll.de>
In-Reply-To: <ep4g2kphzkxp3gtx6rz5ncbbnmxzkp6jsg6mvfarr5unp5f47h@dmo32t3edh2c>
References:
 <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
 <06f75836-8276-428e-b128-8adffd0664ee@sotapeli.fi>
 <ep4g2kphzkxp3gtx6rz5ncbbnmxzkp6jsg6mvfarr5unp5f47h@dmo32t3edh2c>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Kent, hi,

Kent Overstreet - 20.06.25, 03:51:45 CEST:
> On Fri, Jun 20, 2025 at 04:25:58AM +0300, Jani Partanen wrote:
> > On 20/06/2025 4.09, Kent Overstreet wrote:
> > > I'm not seeing that _you_ get that.
> >=20
> > How hard it is?
> >=20
> > New feature window for 6.16 was 2 weeks ago.
> >=20
> > rc<insert number here> is purely for fixing bugs, not adding new
> > features and potential new bugs.
>=20
> That's an easy rule for the rest of the kernel, where all your mistakes
> are erased at a reboot. Filesystems don't have that luxury.
>=20
> In the past, I've had to rush entire new on disk format features in
> response to issues I saw starting to arise - I think more than once, but
> the btree bitmap in the member info section was the big one that sticks
> in my mind; that one was very hectic, but 100% proved its worth.

Kent, from what I gathered, you'd like to change some window rules =E2=80=
=93 at=20
least for filesystems or new-in-kernel filesystems.

And from what I observed: You try to do so by just not adhering to at=20
least one of those rules at least once in a while. Maybe for a good=20
reason, but still, you just do not adhere to the rule of only fixes. Or at=
=20
the very least, you define a fix to be something that is (way) more than a=
=20
fix for other kernel developers.

It may make sense to change some merge window rules or it may not, I don't=
=20
know. However=E2=80=A6 from what I observe:

Just unilaterally changing a rule or redefining a word in that rule may=20
not be a sustainable and working (!) approach to go about it. Just from=20
observing the communication pattern here I conclude that.

I'd rather recommend to bring this up the next opportunity you can discuss=
=20
it with fellow kernel developers, ideally while meeting face to face.=20
Cause let's face it: The Linux kernel is a team effort.

If you stick to your approach about merge window rules and many other=20
kernel developers including Linus stick to their rules this will go in=20
circles.

Indefinitely so.

Not sure whether that is a good use of your time. But your call really.

So how about adhering to the current rules for now and bringing up the=20
topic in a meeting you will have at one point in the future?

Just my two cents from observing the repeated (!) communication pattern=20
here. Cause it is not at all the first time the discussion arrives exactly=
=20
at this point.

> For a lot of users, compiling a kernel from some random git repository
> is a lot to ask. I spend a lot of time doing what amounts to support;
> that's just how it is these days. But rc kernels are packaged by most
> kernels, and we absolutely do not want to wait an additional 3 months
> for it to show up in a release kernel -

Those users should probably not use BCacheFS right now already to begin=20
with but wait for it to be marked as stable?

It reminds my about Debian Unstable users wanting the newest and greatest=20
and then complaining that at times some things are not stable. Which is=20
the very definition of what can happen in Debian Unstable.

I meanwhile use BCacheFS. On Devuan. But for now that means I have to=20
compile BCacheFS tools myself, and better also the kernel to have the=20
latest and probably greatest during the hard freeze of Debian.

And I use it for data that is backed up or that I can afford to loose.


And about what you wrote in your previous mail:

Kent Overstreet - 20.06.25, 03:09:07 CEST:
> There are a _lot_ of people who've been burned by btrfs. I've even been
> seeing more and more people in recent discussions talking about
> unrecoverable filesystems with XFS (!).

And I have seen a lot of threads on XFS over the years where XFS=20
developers went great lengths to help users recover their data. I have=20
seen those threads also on the BTRFS mailing list. Those users had no=20
support contract, they did not pay anything for that free service either.

So I am not sure it is wise or even just accurate to implicitly imply that=
=20
other than BCacheFS filesystem developers do not care about user data.=20
=46rom what I have seen I conclude: They do!

But maybe that is not even the point: Other filesystems are maintained by=20
other people and they do what they think is best. If you like to see a=20
change in some merge window rules for what you try to achieve with=20
BCacheFS you can independently from what other filesystem developers do=20
ask for a slot to talk in one of the next face to face kernel developer=20
meetings.

Best,
=2D-=20
Martin



