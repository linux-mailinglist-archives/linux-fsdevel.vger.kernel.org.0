Return-Path: <linux-fsdevel+bounces-57180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5511EB1F5AB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 19:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0F4189B63B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3B82BE7CD;
	Sat,  9 Aug 2025 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UDM50cGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6C26FDB2
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Aug 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754761009; cv=none; b=dfeeYVYa7uBW5H8wFDAbneUehrfVqKxbq1IsUhq7i3Lqy8m6wPpgKFA2hvzJeVSejl9nr2gU4qMQ/IvcL2NU4LFjjZHF5r7NRn2PqaMXqZtLE90AvlZy8M3PwEAhSeFh3V93kgMOEq7335jm6p08PUZNozNamD3KUjwEBP4jMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754761009; c=relaxed/simple;
	bh=Gd5oTh9r3zVpFn4RTFnhoJRGiU6NiPZSIlKtemeFeR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKC1UDOm8WD/79L335f0G++0cQFrFn7/60yC8j3IfqV/22vCjiSebcEN54QxvNTFQgqZopVd+AsIeFB/O6MyJTt9SnYrR6X0hmPnio51JWE6d3w5fNN03Uk1pLBSdyUZqgzjftPLOTxJOzOoY3yr7G7fju9c39NDBuuT5zWA1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UDM50cGi; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 9 Aug 2025 13:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754761002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4TOJ5bZ6qxtbqVJ+u9DQ1EQ7xsWRrlaYDcuhb+mjSE=;
	b=UDM50cGi46OyE2YaxkWdmoARb71f/qnsgkcZM/J/B9M+BS6sW6dkYjdPGPGkrWZ9sT0v+J
	YRirirJejPjPgr3Mm0by+bmZoPXV1GodeWfW6lvCAaMCgmX9D5pUFiAwHkyDLLtlYAyw7n
	LF1DkWDQlgpumZkcROh6oCYgy4PCeb4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Aquinas Admin <admin@aquinas.su>
Cc: Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, "Carl E. Thompson" <list-bcachefs@carlthompson.net>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5909824.DvuYhMxLoT@woolf>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 07, 2025 at 07:42:38PM +0700, Aquinas Admin wrote:
> Generally, this drama is more like a kindergarten. I honestly don't understand 
> why there's such a reaction. It's a management issue, solely a management 
> issue. The fact is that there are plenty of administrative possibilities to 
> resolve this situation.

Yes, this is accurate. I've been getting entirely too many emails from
Linus about how pissed off everyone is, completely absent of details -
or anything engineering related, for that matter. Lots of "you need to
work with us better" - i.e. bend to demands - without being willing to
put forth an argument that stands to scrutiny.

This isn't high school, and it's not a popularity contest. This is
engineering, and it's about engineering standards.

Those engineering standards have been notably lacking in the Linux
filesystem world.

When brtfs shipped, it did so with clear design issues that have never
been adequately resolved. These were brought up on the list in the very
early days of btrfs, when it was still experimental, with detailed
analysis - that was ignored.

The issues in btrfs are the stuff of legend; I've been to conferences
(past LSFs) where after dinner the stories kept coming out from people
who had worked on it - for easily an _hour_ - and had people falling out
of their chairs.

As a result, to this day, people don't trust it, and for good reason.
Multidevice data corruptions, unfixed bugs with no real information,
people who have tried to help out and fund getting this stuff fixed only
to be turned away. This stuff is still going on:
https://news.ycombinator.com/item?id=44508601

This is what you'd expect to happen when you rush to have all the
features, skip the design, and don't build a community that's focused on
working with users.

Let's compare what's going on in bcachefs:

Bug tracker:
https://github.com/koverstreet/bcachefs/issues?q=is%3Aissue%20state%3Aopen%20-label%3Aenhancement%20-label%3A%22waiting%20confirmation%20fixed%22

Syzbot, and the other major filesystems for comparison:
https://syzkaller.appspot.com/upstream/s/bcachefs
https://syzkaller.appspot.com/upstream/s/ext4
https://syzkaller.appspot.com/upstream/s/xfs
https://syzkaller.appspot.com/upstream/s/btrfs

(Does btrfs even have a central bug tracker?)

An important note, with bcachefs most of the activity doesn't happen on
the bug tracker, it's on IRC (and the IRC channel is by far the most
active out of all the major filesystems). The bug tracker is for making
sure bugs don't get lost if they can't get fixed right away - most bugs
never make it there. So the bug tracker is a good measure of outstanding
bugs, but not fixed bugs or gauging usage.

How did we get here, what are we doing differently - and where are we
now?

The recipe has been: patient, methodical engineering, with a focus on
the users and building the user community, and working closely with the
people who are using, testing and QAing.

Get the design right, keep the codebase reasonably clean and well
organized so that we can work efficiently; _heavy_ focus on assertions,
automated testing (i.e. basic modern engineering best practices),
introspection and debug tooling.

Get enough feature work done to validate the design, and then - fix
every last bug, and work with users to make sure that bugs are fixed and
it's working well; work with people who are doing every kind of torture
testing imaginable.

A refrain I've been hearing has been about "working with the community",
but to the kernel community, I need to hammer the point home that the
community is not just us; it's all the people running our code, too.

We have to actively work with those people if we want our code to
actually work reliably in the real world, and this is something that's
been frighteningly absent elsewhere, in filesystem development these
days.

30 years ago, Linux took over by being a real community effort.

But now, most of the development is very corporate, and getting
corporate developers to actually engage with the community and do
anything that smells of unpaid support is worse than pulling teeth - it
just doesn't happen.

Now bcachefs is the community based up and comer...

But it's not really "up and coming" anymore.

6.16 is "unofficially unexperimental" - it's solid.

It's attracting real interest and feedback from the ZFS community, and
that hasn't happened before; those are the people who care about
reliability and good engineering above all else.

All the hard engineering problems are solved, stabilizing is basically
done. We've got petabyte scalability, the majority of online fsck in
place, all the multi device stuff rock solid (a major area where brtfs
falls over); the error handling, logging and debugging tools are top
notch. Repair is comprehensive and robust, with real defense in depth,
and an extensive suite of tools for analyzing issues and making sure we
can debug anything that may occur in the wild.

The kernel community is being caught with their pants down here.

The desicionmaking process has, at every step in the way, been "things
couldn't possibly be that insane" - and yet, I am continually proven
wrong.

Post btrfs, I seriously expected there to be real design review for any
future filesystems, and a retrospective on development process.

Needless to say, that did not happen - it seems we're still in the
"trust me bro, I got this" stage in the development of an engineering
culture.

But a cowboy culture only takes you so far, at some point you really do
need actual engineer standards; you need to be able to explain your
designs, your methods, your processes and decisionmaking.

I've talked at length in the past about the need for a tight feedback
loop on getting bugs out to users if we want to be able to work with
those users (and to be honest, that should not even have been a
discussion; I've been going over RC pull requests and there's been
nothing remotely unusual about what I've been sending - except for
volume, which is exactly what you want and expect for a filesystem
that's been rapidly stabilizing).

But "shipping bugfixes" has been called "whining" - that's the mentality
we're dealing with here.

I have to hammer on this one: there are certain bedrock principles of
systems engineering we all know.  "Make sure things work and stay
working" is one of them. The rest of the kernel knows this as "do not
break userspace", but in filesystem land that same underlying principle
is written as "we do not lose user data".

Our job is to ship things that work, and make sure they work.

I also talk a lot about the need for automated testing; and that's
another area where the kernel is woefully behind - and it's been one of
the sources of conflict. I've asked people in other subsystems to please
make sure they tests when regressions have hit bcachefs; it's good for
everyone, not just bcachefs. But this has been cited (!) as one of the
causes of conflict that's been pissing Linus off.

Engineering principles. Basic stuff, here.

And regarding manegement processes: Linus has been saying repeatedly
(and loudly, and in public) that it's his decision whether or not to
remove bcachefs from the kernel - but the criteria and decisionmaking
process have been notably absent.

It is not for me to say whether or not the kernel should still be a
personal project, with decisions made in this way. And at the end of the
day, we're all human beings, I'm not going to argue against the human
factor, or against considering the people behind these projects.

But the uncertainty this has caused has created massive problems for
building a sustainable developer community around this thing, it should
be noted.

For my part, I just want to reassure people that I'm not going anywhere;
bcachefs will continue to be developed and supported, in or out of the
kernel.

Cheers,
Kent

