Return-Path: <linux-fsdevel+bounces-57188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D47B1F83C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 05:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F314E3B804E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 03:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC1F14884C;
	Sun, 10 Aug 2025 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JfhLq573"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE51401B
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Aug 2025 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754795874; cv=none; b=KyGBncstYZkXoGWR863qtJSUAXntoqVckuFWJHcO4LcOfa0WU7SRffbo2KSLvuh2pqYZhatpfw1XThl7MUJd3ub9G9IBQKDfAN50p2y6MPdHVmS53CG2X0Hurf8UuPabcELuErK5HyxF5z70XD/ol1qTR2z6p1UEOi3cpalMP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754795874; c=relaxed/simple;
	bh=22P7DLdflwAsPb30ly4UPh8Dai9AvMRYCaY2LSYqiPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiJguyn8v9/mXfH8hVJbbJsTjhwGqAN9Xatx0EEvELMZYQkmk1QIBzaWUFreRHaP92bW75YYRHz1soWL64hjHrMUEQ9Bkq+KuLh3xnHH06Bf2nn21gJPj6iQmJjBCpcVqeIA3gPFdhwR78c+4RzCgOislCcOy8NRHVUp42EyuNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JfhLq573; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 9 Aug 2025 23:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754795868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vXbU2WwUnaf/JbXlfo+A6q0wkok3ZP8oUqJ1zUirNHk=;
	b=JfhLq573Ft+AsgCIcSkHh2MDsQPDPISbI9kWXxAahlkHU91F0XI8gq7BMK/FLstwjJKApi
	yGetRS021Vrb2uSiPfjdwos+XcCUAdYhV3uqz6vaY8rs2fUy+/cKLBCz4YWRyWPyi5xT/k
	cEgTWRCxY0o1QCDKWCehmMsPKaKy5wo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Josef Bacik <josef@toxicpanda.com>, Aquinas Admin <admin@aquinas.su>, 
	Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Carl E. Thompson" <list-bcachefs@carlthompson.net>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <k6e6f3evjptze7ifjmrz2g5vhm4mdsrgm7dqo7jdatkde5pfvi@3oiymjvy6f3e>
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <20250809192156.GA1411279@fedora>
 <2z3wpodivsysxhxmkk452pa4zrwxsu5jk64iqazwdzkh3rmg5y@xxtklrrebip2>
 <20250810022436.GA966107@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810022436.GA966107@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 09, 2025 at 10:24:36PM -0400, Theodore Ts'o wrote:
> On Sat, Aug 09, 2025 at 04:37:51PM -0400, Kent Overstreet wrote:
> > showed that it was possible, but the common consensus in the user
> > community, among people with the data (i.e. quite a few of the distros)
> > is that btrfs dropped the ball, and regressed on reliability from
> > ext4/xfs.
> 
> Kent, you eeem to have ignored the primary point of Josef's message,
> and instead, prceeded to prove *exactly* what he was pointing out.
> Let me quote the most relevant parts of his e-mail, in case you missed
> it:
> 
> > Btrfs doesn't need me or anybody else wandering around screaming
> > about how everybody else sucks to gain users. The proof is in the
> > pudding. If you read anything that I've wrote in my commentary about
> > other file systems you will find nothing but praise and respect,
> > because this is hard and we all make our tradeoffs.
> >
> > That courtesy has been extended to you in the past, and still
> > extends to your file system. Because I don't need to tear you down
> > or your work down to make myself feel good. And because I truly
> > beleive you've done some great things with bcachefs, things I wish
> > we had had the foresight to do with btrfs.
> >
> > I'm yet again having to respond to this silly childishness because
> > people on the outside do not have the context or historical
> > knowledge to understand that they should ignore every word that
> > comes out of your mouth. If there are articles written about these
> > claims I want to make sure that they are not unchallenged and thus
> > viewed as if they are true or valid.
> > 
> > ...
> > Emails like this are why nobody wants to work with you. Emails like
> > this are why I've been on literally dozens of email threads, side
> > conversations, chat threads, and in person discussions about what to
> > do when we have exceedingly toxic developers in our community.
> > 
> > Emails like this are why a majority of the community filters your emails to
> > /dev/null.
> > 
> > You alone with your toxic behavior have wasted a fair amount of mine
> > and other peoples time trying to figure out how do we exist in our
> > place of work with somebody who is bent on tearing down the
> > community and the people who work in it.
> 
> And how did you respond?  By criticizing another file system, and
> talking about how wonderful you believe bcachefs to be, all of which
> is beside the point.  In fact, you once again demonstrated exactly why
> a very large number of kernel deevlopers have decided you are
> extremely toxic, and have been clamoring that your code be ejected
> from the kernel.  Not because of the code, but because your behavior.

I would dearly love to have not opened that up, but "let's now delete
bcachefs from the kernel" opened up that discussion, because our first
priority has to be doing right by users - and a decision like that
should absolutely be discussed publicly, well in advance, with all
technical arguments put forth.

Or was that going to happen without giving users advance notice?
Without a discussion of why we need a filesystem that's prioritizing
basic reliability and robustness?

Moreover -

"Work as service to others" is something I think worth thinking about.
We're not supposed to be in this for ourselves; I don't write code to
stroke my own ego, I do it to be useful.

I honestly can't even remember the last time I wrote code purely for
enjoyment, or worked on a project because it was what I wanted to work
on. My life consists of writing code base on what's needed; to fix a
bug, to incorporate a good idea someone else had, to smooth something
over to make someone else's life easier down the line. Very rarely does
it come from my own vision.

My feelings are entirely secondary to the work I do.

And yet again, in this thread, we keep hearing about how pissed off
people are, and how that's supposed to be our primary concern. I'm
afraid I can't agree.

And if someone's going to start outright swearing over technical
criticism, that's a flagrant CoC violation - and just beyond
unprofessional. That is one of the interactions you guys are apparently
basing this one, and that wasn't me.

And I have to point out, this has been escalated, over and over and
over, over a patch that was purely internal to fs/bcachefs.

I think you guys have been taking this a bit too far.

