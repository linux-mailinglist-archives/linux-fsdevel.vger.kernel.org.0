Return-Path: <linux-fsdevel+bounces-47464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50E0A9E5E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 03:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C737A170EEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 01:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8FF15A85E;
	Mon, 28 Apr 2025 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xs3Y1uxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7FD3211
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745804634; cv=none; b=DW8fC5ZqrPQpB/oVKzDNATwn++W+tXc9LjNyJ7aE2KeWx8gNwuDvzzf0DxNFj82eZq9hX5mlq0E+7hVjSUfzfKQzG3XHZgl+D7wGT8WuUknXZrIZVTpfsoQOVNiCGwxWIz3hdTpPuZULSUVQR9gVj78oKrzBx0iUwYA+9TH6IUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745804634; c=relaxed/simple;
	bh=+z8s4NRg+vluVW0bANv1ENerc7PuASiqv1WqBf6olv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcY0Dl/ECcnZ2Q2eQYK2CZjJq3D0t9Nt4Ed9kq2QnAVlYKXocfU2Aa7gWbNED8RKEnb0Zq/ogBTNMpOenFbbYgf2UMMUeJj6Y25IAEdOehQmHtgZMa67XJc8HXNixTZkKYxbxFdAvGHZ2/tOT5BRqkgWERTPxl/ScEcUQK6pqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xs3Y1uxg; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 27 Apr 2025 21:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745804629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VMhrp+exMrjPtRykhMgVAHxGjayNq4JxRu9e/LqfsE0=;
	b=Xs3Y1uxgJTQiU/M6jPzlTXWeXVJkDsRMGYt+B6bnu6sM/iVo6Eo5oS9pkWhVC8u5e8Vyx8
	sQYWWee6tJzLr5j/seKSbIUIumxR//CTglVSYWujHieLXGGIXECaCIeMEQzE3w5dbI3vW2
	cdzZGX9Rww6jgiJVqFrYNZ8MgAD2/4c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
 <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428013059.GA6134@sol.localdomain>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 27, 2025 at 06:30:59PM -0700, Eric Biggers wrote:
> On Sun, Apr 27, 2025 at 08:55:30PM -0400, Kent Overstreet wrote:
> > The thing is, that's exactly what we're doing. ext4 and bcachefs both
> > refer to a specific revision of the folding rules: for ext4 it's
> > specified in the superblock, for bcachefs it's hardcoded for the moment.
> > 
> > I don't think this is the ideal approach, though.
> > 
> > That means the folding rules are "whatever you got when you mkfs'd".
> > Think about what that means if you've got a fleet of machines, of
> > different ages, but all updated in sync: that's a really annoying way
> > for gremlins of the "why does this machine act differently" variety to
> > creep in.
> > 
> > What I'd prefer is for the unicode folding rules to be transparently and
> > automatically updated when the kernel is updated, so that behaviour
> > stays in sync. That would behave more the way users would expect.
> > 
> > But I only gave this real thought just over the past few days, and doing
> > this safely and correctly would require some fairly significant changes
> > to the way casefolding works.
> > 
> > We'd have to ensure that lookups via the case sensitive name always
> > works, even if the casefolding table the dirent was created with give
> > different results that the currently active casefolding table.
> > 
> > That would require storing two different "dirents" for each real dirent,
> > one normalized and one un-normalized, because we'd have to do an
> > un-normalized lookup if the normalized lookup fails (and vice versa).
> > Which should be completely fine from a performance POV, assuming we have
> > working negative dentries.
> > 
> > But, if the unicode folding rules are stable enough (and one would hope
> > they are), hopefully all this is a non-issue.
> > 
> > I'd have to gather more input from users of casefolding on other
> > filesystems before saying what our long term plans (if any) will be.
> 
> Wouldn't lookups via the case-sensitive name keep working even if the
> case-insensitivity rules change?  It's lookups via a case-insensitive name that
> could start producing different results.  Applications can depend on
> case-insensitive lookups being done in a certain way, so changing the
> case-insensitivity rules can be risky.

No, because right now on a case-insensitive filesystem we _only_ do the
lookup with the normalized name.

> Regardless, the long-term plan for the case-insensitivity rules should be to
> deprecate the current set of rules, which does Unicode normalization which is
> way overkill.  It should be replaced with a simple version of case-insensitivity
> that matches what FAT does.  And *possibly* also a version that matches what
> NTFS does (a u16 upcase_table[65536] indexed by UTF-16 coding units), if someone
> really needs that.
> 
> As far as I know, that was all that was really needed in the first place.
> 
> People misunderstood the problem as being about language support, rather than
> about compatibility with legacy filesystems.  And as a result they incorrectly
> decided they should do Unicode normalization, which is way too complex and has
> all sorts of weird properties.

Believe me, I do see the appeal of that.

One of the things I should really float with e.g. Valve is the
possibility of providing tooling/auditing to make it easy to fix
userspace code that's doing lookups that only work with casefolding.

And, another thing I'd like is a way to make casefolding per-process, so
that it could be opt-in for the programs that need it - so that new code
isn't accidentally depending on casefolding.

That's something we really should have, anyways.

But, as much as we might hate it, casefolding is something that users
like and do expect in other contexts, so if casefolding is going to
exist (as more than just a compatibility thing for legacy code) - it
really ought to be unicode, and utf8 really has won at this point.

Mainly though, it's not a decision I care to revisit, I intend to stick
with casefolding that's compatible with how it's done on our other
filesystems where it's widely used.

