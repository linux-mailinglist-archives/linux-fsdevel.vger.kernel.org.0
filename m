Return-Path: <linux-fsdevel+bounces-53678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF85DAF5EB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E553AE59B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AD430115C;
	Wed,  2 Jul 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kha0xlGH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D22FF478
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474049; cv=none; b=so5lBRc+ZWaxyXVQ3MNY79T5A44uyX/QnZPSb8lK8veZrlQio7BvRl3h5ODVRk1llyyQwk+ymdwFf/3W19bCel7CWJouUHBLzmKDI3r78RFmEepqIp8UUB9piDmwgfaG2j2ccIBgmPKVT9Eqk7nc0L5SYxF1pGpNq31Ubt3hni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474049; c=relaxed/simple;
	bh=4lR1Xh08/sQLiOaBFrRDSvCEUOK2+dsuYmN7W/oIA+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYQIN90V/AdOdO3d+jWI9q00A7kdj5eCMUli4KWWa6XJvgfqQ96n56Tg5DWMea7c3eLj3S+Gm1Dfcv9y3UJMwfzFuJGzpIqo14Yx3avoTxIk4vgwjgG1MePSCqRNiZIbnE9cNAdWlp0DAszksoa5lt7bugodO3wGxJSFKn977H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kha0xlGH; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Jul 2025 12:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751474044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNtQyZYN8r1glr1xYZPVCQJBFCDyqJ1sFSVx2i0k8WI=;
	b=Kha0xlGHuC4/w2TjLggwX8g2P81eHQpGKN0WXnaAsxtU4LIv44fQ42AD8Oj26wBBlcn4D1
	oHmR/uXz7Ujdze8OQhPOeWrT2mQFCpe138xQJQvK5qqsKfmzlsaDTUMFZH7ps4SeyScohp
	UWnTH96+aFPGpv/H8DFHV4WvW9lkZyc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: John Stoffel <john@stoffel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kerenl@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
Message-ID: <gq2c4qlivewr2j5tp6cubfouvr42jww4ilhx3l55cxmbeotejk@emoy2z2ztmi2>
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
 <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
 <xl2fyyjk4kjcszcgypirhoyflxojzeyxkzoevvxsmo26mklq7i@jw2ou76lh2py>
 <26723.62463.967566.748222@quad.stoffel.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26723.62463.967566.748222@quad.stoffel.home>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 01, 2025 at 10:43:11AM -0400, John Stoffel wrote:
> >>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
> 
> I wasn't sure if I wanted to chime in here, or even if it would be
> worth it.  But whatever.
> 
> > On Thu, Jun 26, 2025 at 08:21:23PM -0700, Linus Torvalds wrote:
> >> On Thu, 26 Jun 2025 at 19:23, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >> >
> >> > per the maintainer thread discussion and precedent in xfs and btrfs
> >> > for repair code in RCs, journal_rewind is again included
> >> 
> >> I have pulled this, but also as per that discussion, I think we'll be
> >> parting ways in the 6.17 merge window.
> >> 
> >> You made it very clear that I can't even question any bug-fixes and I
> >> should just pull anything and everything.
> 
> > Linus, I'm not trying to say you can't have any say in bcachefs. Not at
> > all.
> 
> > I positively enjoy working with you - when you're not being a dick,
> > but you can be genuinely impossible sometimes. A lot of times...
> 
> Kent, you can be a dick too.  Prime example, the lines above.  And
> how you've treated me and others who gave feedback on bcachefs in the
> past.  I'm not a programmer, I'm in IT and follow this because it's
> interesting, and I've been doing data management all my career.  So
> new filesystems are interesting.  

Oh yes, I can be. I apologize if I've been a dick to you personally, I
try to be nice to my users and build good working relationships. But
kernel development is a high stakes, high pressure, stressful job, as I
often remind people. I don't ever take it personally, although sometimes
we do need to cool off before we drive each other completely mad :)

If there was something that was unresolved, and you'd like me to look at
it again, I'd be more than happy to. If you want to share what you were
hitting here, I'll tell you what I know - and if it was from a year or
more ago it's most likely been fixed.

> Slow down.  

This is the most critical phase in the 10+ year process of shipping a
new filesystem.

We're seeing continually increasing usage (hopefully by users who are
prepared to accept that risk, but not always!), but we're not yet ready
for true widespread deployment.

Shipping a project as large and complex as a filesystem must be done
incrementally, in stages where we're deploying to gradually increasing
numbers of users, fixing everything they find and assessing where we're
at before opening it up to more users.

Working with users, supporting with them, checking in on how it's doing,
and getting them the fixes for what they find is how we iterate and
improve. The job is not done until it's working well for everyone.

Right now, everyone is concerned because this is a hotly anticipated
project, and everyone wants to see it done right.

And in 6.16, we had two massive pull requests (30+ patches in a week,
twice in a row); that also generates concern when people are wondering
"is this thing stabilizing?".

6.16 was largely a case of a few particularly interesting bug reports
generating a bunch of fixes (and relatively simple and localized fixes,
which is what we like to see) for repair corner cases, the biggest
culprit (again) being snapshots.

If you look at the bug tracker, especially rate of incoming bugs and the
severity of bug reports (and also other sources of bug reports, like
reddit and IRC) - yes, we are stabilizing fast.

There is still a lot of work to be done, but we're on the right track.

"Slowing down" is not something you do without a concrete reason. Right
now we need to be getting those fixes out to users so they can keep
testing and finding the next bug. When someone has invested time and
effort learning how the system works and how to report bugs, we don't
watn them getting frustrated and leaving - we want to work with them, so
they can keep testing and finding new bugs.

The signals that would tell me it's time to slow down are:

- Regressions getting through (quantity, severity, time spent on fixing
  them)
- Bugs getting through that show that show that something fundamental is
  missing (testing, hardening), or broken in our our design.
- Frequency of bug reports going up to where I can't keep up (it's been
  in steady, gradual decline)

We actually do not want this to be 100% perfect before it sees users.
That would result in a filesystem that's brittle - a glass cannon. We
might get it to the point where it works 99% of the time, but then when
it breaks we'd be in a panic - and if you discover it then, when it's in
the wild, it's too late.

The processes for how we debug and recover from failures, in the wild,
is a huge part (perhaps the majority) of what we're working on now. That
stuff has to be baked into the design on a deep level, and like all
other complex design it requires continual iteration.

That is how we'll get the reliability and robustness we hope to achieve.

