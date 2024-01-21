Return-Path: <linux-fsdevel+bounces-8360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5138D83543D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 03:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A47028280D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 02:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5791631A61;
	Sun, 21 Jan 2024 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CEkf+9pg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59862EB0C
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705805366; cv=none; b=Go2/tAT2hL4kIVvbpqWK77r/9C829ttxw8HerKXdmwc0SikMMcDJAAZ3VxxPhUTliDV9F8vBrm4Rf/H5/iJVlhXwzb0D2qFxNQRY6zX5nh634388/N0R3ThVJhUctr79t2EXlQiAqdHLBzDIMW7oVyQVJC1kLHQl3eLw3ZMgOFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705805366; c=relaxed/simple;
	bh=OKa4bhq0Rio0F1E3oS/YlBqfSZWHLqMzhTTAI3gLa0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdSspi2bkTdWldimboVloWyOc7BPG9UzPdHiNuJ3lFjnpJdwtrY9i1eghCrYFLopFguC5tLfl4C/X+bLY7DPyjq/fh4XMV2Y3yuWygDZze5FpD+5CYNDTQ3tbnTrY5KnjsNkHl6OoKSMvuaHNf5z5CPIGGgwSTI/EnWB4iKFjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CEkf+9pg; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 20 Jan 2024 21:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705805362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MZIC47zq/tFRXBZLU7f3NuxJxn74KUJFQlCBzt+coo=;
	b=CEkf+9pgjCbf8OZ1kGVpjLhh53FpVHbAX7uHj0jJIvQU3IGZJzoLc720zn1Z2PclQ1bhL1
	H0NRWZVqXneE+5c/leqqQOfFoqyV8d6CZZSZFJPXuYRT5drdnuv/9So1MrovgMsn7d/Gj/
	x51jk8HFC3Jgk/dcjl4LrD8W7EC7fjc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Greg KH <greg@kroah.com>, 
	Mark Brown <broonie@kernel.org>, Neal Gompa <neal@gompa.dev>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Nikolai Kondrashov <spbnick@gmail.com>, Philip Li <philip.li@intel.com>, 
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <dtarikpnqff7nkwoq552laovlgbvesuyy7jd2tkwd2tvie7jno@abry5epdlwcl>
References: <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
 <2024011532-mortician-region-8302@gregkh>
 <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>
 <20240117055457.GL911245@mit.edu>
 <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 17, 2024 at 08:03:35AM -0500, James Bottomley wrote:
> On Wed, 2024-01-17 at 00:54 -0500, Theodore Ts'o wrote:
> > On Tue, Jan 16, 2024 at 11:41:25PM -0500, Kent Overstreet wrote:
> > > > > No, it's a leadership/mentorship thing.
> > > > > 
> > > > > And this is something that's always been lacking in kernel
> > > > > culture. Witness the kind of general grousing that goes on at
> > > > > maintainer summits;maintainers complain about being overworked
> > > > > and people not stepping up to help with the grungy
> > > > > responsibilities, while simultaneously we still
> > 
> >      <blah blah blah>
> > 
> > > > > Tests and test infrastructure fall into the necessary but not
> > > > > fun category, so they languish.
> > > > 
> > > > No, they fall into the "no company wants to pay someone to do the
> > > > work" category, so it doesn't get done.
> > > > 
> > > > It's not a "leadership" issue, what is the "leadership" supposed
> > > > to do here, refuse to take any new changes unless someone ponys
> > > > up and does the infrastructure and testing work first?  That's
> > > > not going to fly, for valid reasons.
> > 
> > Greg is absolutely right about this.
> > 
> > > But good tools are important beacuse they affect the rate of
> > > everyday development; they're a multiplier on the money everone is
> > > spending on salaries.
> > 
> > Alas, companies don't see it that way.  They take the value that get
> > from Linux for granted, and they only care about the multipler effect
> > of their employees salaries (and sometimes not even that).  They most
> > certainly care about the salutary effects on the entire ecosyustem.
> > At least, I haven't seen any company make funding decisions on that
> > basis.
> 
> Actually, this is partly our fault.  Companies behave exactly like a
> selfish contributor does:
> 
> https://archive.fosdem.org/2020/schedule/event/selfish_contributor/
> 
> The question they ask is "if I'm putting money into it, what am I
> getting out of it".  If the answer to that is that it benefits
> everybody, it's basically charity  to the entity being asked (and not
> even properly tax deductible at that), which goes way back behind even
> real charitable donations (which at least have a publicity benefit) and
> you don't even get to speak to anyone about it when you go calling with
> the collecting tin.  If you can say it benefits these 5 tasks your
> current employees are doing, you might have a possible case for the
> engineering budget (you might get in the door but you'll still be
> queuing behind every in-plan budget item).  The best case is if you can
> demonstrate some useful for profit contribution it makes to the actual
> line of business (or better yet could be used to spawn a new line of
> business), so when you're asking for a tool, it has to be usable
> outside the narrow confines of the kernel and you need to be able to
> articulate why it's generally useful (git is a great example, it was
> designed to solve a kernel specific problem, but not it's in use pretty
> much everywhere source control is a thing).
> 
> Somewhere between 2000 and now we seem to have lost our ability to
> frame the argument in the above terms, because the business quid pro
> quo argument was what got us money for stuff we needed and the Linux
> Foundation and the TAB formed, but we're not managing nearly as well
> now.  The environment has hardened against us (we're no longer the new
> shiny) but that's not the whole explanation.

I think this take is closer to the mark, yeah.

The elephant in the room that I keep seeing is that MBA driven business
culture in the U.S. has gotten _insane_, and we've all been stewing in
the same pot together, collectively boiling, and not noticing or talking
about just how bad it's gotten.

Engineering culture really does matter; it's what makes the difference
between working effectively or not. And by engineering culture I mean
things like being able to set effective goals and deliver on them, and
have a good balance between product based, end user focused development;
exploratory, prototype-minded research product type stuff; and the
"clean up your messes and eat your vegetables" type stuff that keeps
tech debt from getting out of hand.

Culturally, we in the kernel community are quite good on the last front,
not so good on the first two, and I think a large part of the reason is
people being immersed in corporate culture where everything is quarterly
OKRs, "efficiency", et cetera - and everywhere I look, it's hard to find
senior engineering involved in setting a roadmap. Instead we have a lot
of "initiatives" and feifdoms, and if you ask me it's a direct result of
MBA culture run amuck.

Culturally, things seem to be a lot better in Europe - I've been seeing
a _lot_ more willingness to fund grungy difficult long term projects
there; the silicon valley mentality of "it must have the potential for a
massive impact (and we have to get it done as quick as possible) or it's
not worth looking at" is, thankfully, absent there.

> I also have to say, that for all the complaints there's just not any
> open source pull for test tools (there's no-one who's on a mission to
> make them better).  Demanding that someone else do it is proof of this
> (if you cared enough you'd do it yourself).  That's why all our testing
> infrastructure is just some random set of scripts that mostly does what
> I want, because it's the last thing I need to prove the thing I
> actually care about works.

It's awkward because the people with the greatest need, and therefore
(in theory?) the greatest understanding for what kind of tools would be
effective, are the people with massive other responsibilities.

There are things we just can't do without delegating, and delegating is
something we seem to be consistently not great at in the kernel
community. And I don't think it needs to be that way, because younger
engineers would really benefit from working closely with someone more
senior, and in my experience the way to do a lot of these tooling things
right is _not_ to build it all at once in a year of full time SWE salary
time - it's much better to take your time, spend a lot of time learning
the workflows, letting ideas percolate, and gradually build things up.

Yet the way these projects all seem to go is we have one or a few people
working full time mostly writing code, building things with a lot of
_features_... and if you ask me, ending up with something where most of
the features were things we didn't need or ask for and just make the end
result harder to use.

Tools are hard to get right; perhaps we should be spending more of our
bikeshedding time on the lists bikeshedding our tools, and a little bit
less on coding style minutia.

Personally, I've tried to get the ball rolling multiple times with
various people asking them what they want and need out of their testing
tools and how they use them, and it often feels like pulling teeth.

> Finally testing infrastructure is how OSDL (the precursor to the Linux
> foundation) got started and got its initial funding, so corporations
> have been putting money into it for decades with not much return (and
> pretty much nothing to show for a unified testing infrastructure ...
> ten points to the team who can actually name the test infrastructure
> OSDL produced) and have finally concluded it's not worth it, making it
> a 10x harder sell now.

The circle of fail continues :)

