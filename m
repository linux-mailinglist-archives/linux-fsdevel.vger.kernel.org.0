Return-Path: <linux-fsdevel+bounces-31093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F73991B48
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140271C20EDF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 22:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9208416E860;
	Sat,  5 Oct 2024 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FhvwGWEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CC1607B7
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728168868; cv=none; b=W5HUDIPVB0UOFCu+x4zMbI3m3OZALCgs2Gze/3bkSUSPaBqyC+aLEo0sS+cvSMqiobb82XRCg0qph1vjwO4TR1A0f001VFX2Zj+OB4BUtD3oE3dBswaHtTdCtMH8WfN0zwGytHtT8H3K3fLyzyiv+2FnCSFCEgqCso4/5KXMyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728168868; c=relaxed/simple;
	bh=FeV7YQD/aXL95iV4idM4e669wjt5NsYJxr4nuBrTGrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLmwMWbDqjW+dRlq7m93/hZD0yyFiKjlxV1TED1xiZRPZKU+gx6kUbxG7g3u/nGURLfY1GjetXwnIb9unZL8MF/HcP7L6dEkNo9/WyCC2ISZPr9OpdFxQFJOe4J94hhHDpWFWsGp0tbwk1Z2gpAiw9aWLuFCOFl77SGvBBj4e2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FhvwGWEt; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 5 Oct 2024 18:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728168863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+M3sEo5jrIzIGfIg+yt1bfUXNU4+0FblBb6q+YIsb0=;
	b=FhvwGWEt74rEGjEeBwrC+BHGDD7gyBBxB8UEEK7AHKb5kjOagABgW7SmrCye0y1Fw/VRE0
	wEXg1jctoemlxucNOaR/vKl/Z0ghkE2f2wf1OykkzVsBddWW7dhADpr0qv9mA39rMdrJaj
	4qonLZERRN/zyQTtKTQXNzCRdNvYtN8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 05, 2024 at 03:34:56PM GMT, Linus Torvalds wrote:
> On Sat, 5 Oct 2024 at 11:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Several more filesystems repaired, thank you to the users who have been
> > providing testing. The snapshots + unlinked fixes on top of this are
> > posted here:
> 
> I'm getting really fed up here Kent.
> 
> These have commit times from last night. Which makes me wonder how
> much testing they got.

The /commit/ dates are from last night, because I polish up commit
messages and reorder until the last might (I always push smaller fixes
up front and fixes that are likely to need rework to the back).

The vast majority of those fixes are all ~2 weeks old.

> And before you start whining - again - about how you are fixing bugs,
> let me remind you about the build failures you had on big-endian
> machines because your patches had gotten ZERO testing outside your
> tree.

No, there simply aren't that many people running big endian. I have
users building and running my trees on a daily basis. If I push
something broken before I go to bed I have bug reports waiting for me
_the next morning_ when I wake up.

> That was just last week, and I'm getting the strong feeling that
> absolutely nothing was learnt from the experience.
> 
> I have pulled this, but I searched for a couple of the commit messages
> on the lists, and found *nothing* (ok, I found your pull request,
> which obviously mentioned the first line of the commit messages).
> 
> I'm seriously thinking about just stopping pulling from you, because I
> simply don't see you improving on your model. If you want to have an
> experimental tree, you can damn well have one outside the mainline
> kernel. I've told you before, and nothing seems to really make you
> understand.

At this point, it's honestly debatable whether the experimental label
should apply. I'm getting bug reports that talk about production use and
working on metadata dumps where the superblock indicates the filesystem
has been in continuous use for years.

And many, many people talking about how even at this relatively early
point it doesn't fall over like btrfs does.

Let that sink in.

Btrfs has been mainline for years, and it still craps out on people. I
was just in a meeting two days ago, closing funding, and a big reason it
was an easy sell was because they have to run btrfs in _read only_ mode
because otherwise it craps out.

So if the existing process, the existing way of doing things, hasn't
been able to get btrfs to a point where people can rely on it after 10
years - perhaps you and the community don't know quite as much as you
think you do about the realities of what it takes to ship a working
filesystem.

And from where I sit, on the bcachefs side of things, things are going
smoothly and quickly. Bug reports are diminishing in frequency and
severity, even as userbase is going up; distros are picking it up (just
not Debian and Fedora); the timeline I laid out at LSF is still looking
reasonable.

> I was hoping and expecting that bcachefs being mainlined would
> actually help development.  It has not. You're still basically the
> only developer, there's no real sign that that will change, and you
> seem to feel like sending me untested stuff that nobody else has ever
> seen the day before the next rc release is just fine.

I've got a team lined up, just secured funding to start paying them and
it looks like I'm about to secure more.

And the community is growing, I'm reviewing and taking patches from more
people, and regularly mentoring them on the codebase.

And on top of all that, you shouting about "process" rings pretty hollow
when I _remember_ the days when you guys were rewriting core mm code in
rc kernels.

Given where bcachefs is at in the lifecycle of a big codebase being
stabilized, you should be expecting to see stuff like that here. Stuff
is getting found and fixed, and then we ship those fixes so we can find
the next stuff.

> You're a smart person. I feel like I've given you enough hints. Why
> don't you sit back and think about it, and let's make it clear: you
> have exactly two choices here:
> 
>  (a) play better with others
> 
>  (b) take your toy and go home

You've certainly yelled a lot...

