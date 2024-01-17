Return-Path: <linux-fsdevel+bounces-8156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4832830687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 14:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773C51C22ED5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 13:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C2A1EB39;
	Wed, 17 Jan 2024 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="G9rI+nq+";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="G9rI+nq+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE01D541;
	Wed, 17 Jan 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496623; cv=none; b=SbP+EWe9rU02T1Jhx/ubXBAY72dfBWr4KmfdLveGvN+BDz4sss3EDICO3BAhnUBG6sZn4DbU5jI1STWnWCBHWBOv5x1UJI6XP+geGaF81FObqinm5gQKeRRO2ETYOkAQMJmrHCRyVejD6rrhgj2mZqp1aW5wukaCX4SKWXNeHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496623; c=relaxed/simple;
	bh=qQ+6vp4VGyv67J/0qhk1+D+vVpToII5A/94TKdAHneM=;
	h=DKIM-Signature:Received:Received:DKIM-Signature:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:User-Agent:MIME-Version:Content-Transfer-Encoding; b=V19nklbzauADGrz4/5tTHpgM6ySos7ho1DfZtBEVCiF5+DHgEnaFKsyxta5NJqmNIfYJ5gCGSjJeraTNGfsMiOcV1hMB0ao4QM8JIReGjWjCDK6KWx7uSYev7UzhRjtwp7Pwm+KxFz0iDk46D+qnYgZ3T8aEP13kk7djWbuXu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=G9rI+nq+; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=G9rI+nq+; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705496619;
	bh=qQ+6vp4VGyv67J/0qhk1+D+vVpToII5A/94TKdAHneM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=G9rI+nq+tqwHZXAyV0JeLHpDJrzo6kT87Rl1hWZ5NJ1NVO5+ZFBpVL0Rwij2Ao7Su
	 NQxKrF64t65NvHEfYNB/rrueCucvvq3FLUcdqBN5MiMiQHv8AXca7ZE8+e7fW1y+lS
	 rXhtNfNEwAzsqYv+JfNYMWtdSzQ6ptWTaN0aSFfE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 82C3A1281A31;
	Wed, 17 Jan 2024 08:03:39 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Br1jjjRF4HNd; Wed, 17 Jan 2024 08:03:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705496619;
	bh=qQ+6vp4VGyv67J/0qhk1+D+vVpToII5A/94TKdAHneM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=G9rI+nq+tqwHZXAyV0JeLHpDJrzo6kT87Rl1hWZ5NJ1NVO5+ZFBpVL0Rwij2Ao7Su
	 NQxKrF64t65NvHEfYNB/rrueCucvvq3FLUcdqBN5MiMiQHv8AXca7ZE8+e7fW1y+lS
	 rXhtNfNEwAzsqYv+JfNYMWtdSzQ6ptWTaN0aSFfE=
Received: from [172.20.4.189] (unknown [173.211.218.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BE03012808E8;
	Wed, 17 Jan 2024 08:03:37 -0500 (EST)
Message-ID: <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Theodore Ts'o <tytso@mit.edu>, Kent Overstreet
 <kent.overstreet@linux.dev>
Cc: Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>, Neal Gompa
	 <neal@gompa.dev>, Kees Cook <keescook@chromium.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>, 
	Philip Li <philip.li@intel.com>, Luis Chamberlain <mcgrof@kernel.org>
Date: Wed, 17 Jan 2024 08:03:35 -0500
In-Reply-To: <20240117055457.GL911245@mit.edu>
References: 
	<xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
	 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
	 <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
	 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
	 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
	 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
	 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
	 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
	 <2024011532-mortician-region-8302@gregkh>
	 <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>
	 <20240117055457.GL911245@mit.edu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-01-17 at 00:54 -0500, Theodore Ts'o wrote:
> On Tue, Jan 16, 2024 at 11:41:25PM -0500, Kent Overstreet wrote:
> > > > No, it's a leadership/mentorship thing.
> > > > 
> > > > And this is something that's always been lacking in kernel
> > > > culture. Witness the kind of general grousing that goes on at
> > > > maintainer summits;maintainers complain about being overworked
> > > > and people not stepping up to help with the grungy
> > > > responsibilities, while simultaneously we still
> 
>      <blah blah blah>
> 
> > > > Tests and test infrastructure fall into the necessary but not
> > > > fun category, so they languish.
> > > 
> > > No, they fall into the "no company wants to pay someone to do the
> > > work" category, so it doesn't get done.
> > > 
> > > It's not a "leadership" issue, what is the "leadership" supposed
> > > to do here, refuse to take any new changes unless someone ponys
> > > up and does the infrastructure and testing work first?  That's
> > > not going to fly, for valid reasons.
> 
> Greg is absolutely right about this.
> 
> > But good tools are important beacuse they affect the rate of
> > everyday development; they're a multiplier on the money everone is
> > spending on salaries.
> 
> Alas, companies don't see it that way.  They take the value that get
> from Linux for granted, and they only care about the multipler effect
> of their employees salaries (and sometimes not even that).  They most
> certainly care about the salutary effects on the entire ecosyustem.
> At least, I haven't seen any company make funding decisions on that
> basis.

Actually, this is partly our fault.  Companies behave exactly like a
selfish contributor does:

https://archive.fosdem.org/2020/schedule/event/selfish_contributor/

The question they ask is "if I'm putting money into it, what am I
getting out of it".  If the answer to that is that it benefits
everybody, it's basically charity  to the entity being asked (and not
even properly tax deductible at that), which goes way back behind even
real charitable donations (which at least have a publicity benefit) and
you don't even get to speak to anyone about it when you go calling with
the collecting tin.  If you can say it benefits these 5 tasks your
current employees are doing, you might have a possible case for the
engineering budget (you might get in the door but you'll still be
queuing behind every in-plan budget item).  The best case is if you can
demonstrate some useful for profit contribution it makes to the actual
line of business (or better yet could be used to spawn a new line of
business), so when you're asking for a tool, it has to be usable
outside the narrow confines of the kernel and you need to be able to
articulate why it's generally useful (git is a great example, it was
designed to solve a kernel specific problem, but not it's in use pretty
much everywhere source control is a thing).

Somewhere between 2000 and now we seem to have lost our ability to
frame the argument in the above terms, because the business quid pro
quo argument was what got us money for stuff we needed and the Linux
Foundation and the TAB formed, but we're not managing nearly as well
now.  The environment has hardened against us (we're no longer the new
shiny) but that's not the whole explanation.

I also have to say, that for all the complaints there's just not any
open source pull for test tools (there's no-one who's on a mission to
make them better).  Demanding that someone else do it is proof of this
(if you cared enough you'd do it yourself).  That's why all our testing
infrastructure is just some random set of scripts that mostly does what
I want, because it's the last thing I need to prove the thing I
actually care about works.

Finally testing infrastructure is how OSDL (the precursor to the Linux
foundation) got started and got its initial funding, so corporations
have been putting money into it for decades with not much return (and
pretty much nothing to show for a unified testing infrastructure ...
ten points to the team who can actually name the test infrastructure
OSDL produced) and have finally concluded it's not worth it, making it
a 10x harder sell now.

James


