Return-Path: <linux-fsdevel+bounces-47462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF3BA9E596
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 02:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F65189B741
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 00:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E79D7DA9C;
	Mon, 28 Apr 2025 00:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ov22VojP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDF035979
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 00:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745801750; cv=none; b=S9ar99WBu1i3453E8iqb5jg/dr5UQRp2vAoKjsdwWl5qeV5QR3swoPTZw6tM43cjBhe36cyHhkRh1DOiEwBUCCVhHy/ibVgMWW695ymRcdp049vEZYesAyG9Ds9s7IRXROG8LTIQXNHJPOl+pQyLexw8/B3dlhKmcV97aE2Nho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745801750; c=relaxed/simple;
	bh=FU00C0T481/jSCv3vgzcjHa0ie/Ez9/9TTNaJickNx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYZZirMUIq79C91cOvbzAX8m4Ha0GnbgM7bjoRmXjlm3jeKZO32eClL7INoyaqS6jJmdv0GyTuQS9p6vLvb2l9ZntmWT1NwGPqi/ugiJATbs65PbF3ONy3ZxB/ypWIpWjOeot/i0mK1k3wz3Ea6FjEpSnE9dr8yJVBMnNiIvcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ov22VojP; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 27 Apr 2025 20:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745801735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxq7q7wAknwL4KNeKYIKF+Dh28c38IM2QaZFmvN2tR8=;
	b=ov22VojPyR6U+Dt50uvsEFx8zb6wU6MSXTD4gUGUMU8piBroz6kmPaXycfNU7S1TOSYVKQ
	68PwjzvTI9rCqAlEVW4tZGszYk+++mJqpNYSIZA0VJpmlD8BFzQUadKupUijjn0itONKcy
	mkKWeVRwbhzFhXajrCm4PWzMF7jWZyo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAvlM1G1k94kvCs9@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 25, 2025 at 08:40:35PM +0100, Matthew Wilcox wrote:
> On Fri, Apr 25, 2025 at 09:35:27AM -0700, Linus Torvalds wrote:
> > Now, if filesystem people were to see the light, and have a proper and
> > well-designed case insensitivity, that might change. But I've never
> > seen even a *whiff* of that. I have only seen bad code that
> > understands neither how UTF-8 works, nor how unicode works (or rather:
> > how unicode does *not* work - code that uses the unicode comparison
> > functions without a deeper understanding of what the implications
> > are).
> > 
> > Your comments blaming unicode is only another sign of that.
> > 
> > Because no, the problem with bad case folding isn't in unicode.
> > 
> > It's in filesystem people who didn't understand - and still don't,
> > after decades - that you MUST NOT just blindly follow some external
> > case folding table that you don't understand and that can change over
> > time.
> 
> I think this is something that NTFS actually got right.  Each filesystem
> carries with it a 128KiB table that maps each codepoint to its
> case-insensitive equivalent.  So there's no ambiguity about "which
> version of the unicode standard are we using", "Does the user care
> about Turkish language rules?", "Is Aachen a German or Danish word?".
> The sysadmin specified all that when they created the filesystem, and it
> doesn't matter what the Unicode standard changes in the future; if you
> need to change how the filesystem sorts things, you can update the table.
> 
> It's not the perfect solution, but it might be the least-bad one I've
> seen.

The thing is, that's exactly what we're doing. ext4 and bcachefs both
refer to a specific revision of the folding rules: for ext4 it's
specified in the superblock, for bcachefs it's hardcoded for the moment.

I don't think this is the ideal approach, though.

That means the folding rules are "whatever you got when you mkfs'd".
Think about what that means if you've got a fleet of machines, of
different ages, but all updated in sync: that's a really annoying way
for gremlins of the "why does this machine act differently" variety to
creep in.

What I'd prefer is for the unicode folding rules to be transparently and
automatically updated when the kernel is updated, so that behaviour
stays in sync. That would behave more the way users would expect.

But I only gave this real thought just over the past few days, and doing
this safely and correctly would require some fairly significant changes
to the way casefolding works.

We'd have to ensure that lookups via the case sensitive name always
works, even if the casefolding table the dirent was created with give
different results that the currently active casefolding table.

That would require storing two different "dirents" for each real dirent,
one normalized and one un-normalized, because we'd have to do an
un-normalized lookup if the normalized lookup fails (and vice versa).
Which should be completely fine from a performance POV, assuming we have
working negative dentries.

But, if the unicode folding rules are stable enough (and one would hope
they are), hopefully all this is a non-issue.

I'd have to gather more input from users of casefolding on other
filesystems before saying what our long term plans (if any) will be.

