Return-Path: <linux-fsdevel+bounces-27007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891F95DA87
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 04:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797C51C21CA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 02:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6301529CFB;
	Sat, 24 Aug 2024 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pZDkD1iU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE41F949
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 02:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465644; cv=none; b=VzgOFDMcV6NgfFdYJp16DSMW323u5kp5Hw01XeaNwvUDUy1CKOhcJy5xeVBuVdYfF7hExnObQgyiWwMdEMhQjXoovTWetrkNnzJSt9YptCXtMPU40tXcFxpTu7vku0jT+ekM0XM4Fk0m7EtTCDwf90DClBh5C+SgrKo6ydhymjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465644; c=relaxed/simple;
	bh=wsggU1i1mlRkcevrebSeFBbAZvFYZY1rrXSz5oqh/vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAdmrMAdemUO85ZRPjR21DQ5cKjwS5UUskT8RQ9dGXGeGOivWWu6GGPRRdjrnHm0Kb/RJg0a3H+CwU+UUh0EEgLaRtalyc3+B+gZ1IKyniW3U+y/9u3KZ0+vXtjHvu304WY9d51Kxu4/p0ka+3XHPcjtdT83eqvk6kF/jyAxN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pZDkD1iU; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 Aug 2024 22:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724465640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9m8pwLxr3o6YtqvfL2u6T8+1Sb9ci9wPW6mDAFX1ExE=;
	b=pZDkD1iUfuADBOyJjt7TUmSM3EYJwFOHhKlp7lHHkz5RrY14pO3hR3gkggf8cGflFFxLhy
	rniL8VU61bZ8oV5rYWnj4yQIVgiedcVtrBgk+TWg7oZ6eFWF2dYt0uOwx3P6ZVhtwmu3uH
	nAKZo1xEoft+rz8pIiDZkFZJFGrjnek=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
Message-ID: <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 24, 2024 at 09:23:00AM GMT, Linus Torvalds wrote:
> On Sat, 24 Aug 2024 at 02:54, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Hi Linus, big one this time...
> 
> Yeah, no, enough is enough. The last pull was already big.
> 
> This is too big, it touches non-bcachefs stuff, and it's not even
> remotely some kind of regression.
> 
> At some point "fix something" just turns into development, and this is
> that point.
> 
> Nobody sane uses bcachefs and expects it to be stable, so every single
> user is an experimental site.

Eh?

Universal consensus has been that bcachefs is _definitely_ more
trustworthy than brtfs, in terms of "will this filesystem ever go
unrecoverable or lose my data" - I've seen many reports of people who've
put it through the same situations where btrfs falls.

I've ever seen people compare bcachefs's robustness in positive terms
vs. /xfs/; and that's the result of a *hell* of a lot of work with the
#1 goal of having a robust filesystem that _never_ loses data.

Syzbot dashboard bears this out as well, bcachefs is starting to look
better than btrfs there as well...

(Peanut gallery: Please don't rush out and switch to bcachefs just yet.
I still have a backlog of bugs and issues - some of them serious, as in
your filessystem will go emergency read only - and I don't want people
getting bit. There's still a ton to do; I'm not taking EXPERIMENTAL off
until at least the fuzz testing for on disk corruption is in play).

Look, I've been doing this for a long time, I've had people running my
code in production for a long time, and I'm working with my users on a
daily basis to address issues. I don't throw code over the wall; I do
everything I can to support it and make sure it's working well. 

And - the "srcu held for 10+s warnings" really were bad, there are going
to be a long tail of those that need to be fixed - to get to the rest,
we need the primary causes fixed first.

And when I ship code, I'm _always_ weighing "how much do we want this"
vs. "risk of regression/risk in general" - I'm not just throwing out
whatever I feel like.

Look, this is the filesystem you're all going to want to be running in -
knock on wood - just a year or two, because I'm working to to make it
more robust and reliable than xfs and ext4 (and yes, it will be) with
_end to end data integrity_.

We need this. there's still tons of people with "btrfs just crapped
itself and now I'm fucked" horror stories, and running a non
checksumming filesystem is like buying non ECC ram. I've got users with
100+ TB filesystems who trust my code, and I haven't lost anyone's
filesystem who was patient and willing to work with me.

But I've got to get this done, and right now that does mean moving fast
and grinding through a lot of issues.

(again for the peanut gallery: _please_ do not rush to install it yet
unless you are willing and able to report issues, I'll say when the bugs
have been worked through and the hardening is done).

