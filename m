Return-Path: <linux-fsdevel+bounces-47468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92292A9E628
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A9F189B515
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 02:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138F13A258;
	Mon, 28 Apr 2025 02:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reVZvE9K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF68460;
	Mon, 28 Apr 2025 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745806517; cv=none; b=Da79w1Z4x7ncrfhrqN/4+Oki3aUbGdMg23/U7h5UI621k6ZJiMYV7ihw9m+4HbrNEsbiSv6P/BfqrIi4L9NiDqD4bgnBjec4zdHNPUM7ORoAmTil0oaznIATzpQdHzwTYdwdJpK6/aSvK3PQpXPCpMK0n0Sv2DvwjscdRPk9G94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745806517; c=relaxed/simple;
	bh=R5BZyUZJNqf7kFB4ElGeI8qLK3cY5fD1DOoVzkYDkSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpc7Uc24WGaRQsCMJQ8vKjMD5NLjGb2REUEGIo9+asovcYS+Mxs2OhOC209H7BuSgN1ISXzj+qmZTwGgzdGRpdCBAkjLKW7GyhCr71CW0Nzga35LdxNCwSDhgWQj/ZJ98D/3Qjwuyyf8g4rfjzDYOkHArg21xerMEScEKRxFPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reVZvE9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECD4C4CEE3;
	Mon, 28 Apr 2025 02:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745806516;
	bh=R5BZyUZJNqf7kFB4ElGeI8qLK3cY5fD1DOoVzkYDkSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=reVZvE9K460TlqXKQgxoCldD0z5NRQz5FMCQV2tOSP7Uv3AnKFzerQg0MF9RHSOXb
	 Ra9Bd3uMGrsrxiH9ORCsya1asAoIc8d+lPCBK4DYDs7m/Lnr1sviYS6zXEygU4u4aT
	 f9tqzQh0qGXi8+2Cx/HyZhlCpqwXFfBtYItOyt/2fCTSVutIaGAWtWEY7uYpqpKQVm
	 4pRGp0zQY65zBtRycgze1szYUnl0b7+PJrKfc0E6ao8EOcwLtwIbuhGDnjsDkCtKg5
	 DCWuCdlaqAcfkHQDUtWumjhpN2S5dHVZHn6h9DnjRY0Xm/zilc30pUhBc+GhRgGG2J
	 kC2ikmwyDuXIQ==
Date: Sun, 27 Apr 2025 19:15:14 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <20250428021514.GB6134@sol.localdomain>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
 <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain>
 <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>

On Sun, Apr 27, 2025 at 09:43:43PM -0400, Kent Overstreet wrote:
> On Sun, Apr 27, 2025 at 06:30:59PM -0700, Eric Biggers wrote:
> > On Sun, Apr 27, 2025 at 08:55:30PM -0400, Kent Overstreet wrote:
> > > The thing is, that's exactly what we're doing. ext4 and bcachefs both
> > > refer to a specific revision of the folding rules: for ext4 it's
> > > specified in the superblock, for bcachefs it's hardcoded for the moment.
> > > 
> > > I don't think this is the ideal approach, though.
> > > 
> > > That means the folding rules are "whatever you got when you mkfs'd".
> > > Think about what that means if you've got a fleet of machines, of
> > > different ages, but all updated in sync: that's a really annoying way
> > > for gremlins of the "why does this machine act differently" variety to
> > > creep in.
> > > 
> > > What I'd prefer is for the unicode folding rules to be transparently and
> > > automatically updated when the kernel is updated, so that behaviour
> > > stays in sync. That would behave more the way users would expect.
> > > 
> > > But I only gave this real thought just over the past few days, and doing
> > > this safely and correctly would require some fairly significant changes
> > > to the way casefolding works.
> > > 
> > > We'd have to ensure that lookups via the case sensitive name always
> > > works, even if the casefolding table the dirent was created with give
> > > different results that the currently active casefolding table.
> > > 
> > > That would require storing two different "dirents" for each real dirent,
> > > one normalized and one un-normalized, because we'd have to do an
> > > un-normalized lookup if the normalized lookup fails (and vice versa).
> > > Which should be completely fine from a performance POV, assuming we have
> > > working negative dentries.
> > > 
> > > But, if the unicode folding rules are stable enough (and one would hope
> > > they are), hopefully all this is a non-issue.
> > > 
> > > I'd have to gather more input from users of casefolding on other
> > > filesystems before saying what our long term plans (if any) will be.
> > 
> > Wouldn't lookups via the case-sensitive name keep working even if the
> > case-insensitivity rules change?  It's lookups via a case-insensitive name that
> > could start producing different results.  Applications can depend on
> > case-insensitive lookups being done in a certain way, so changing the
> > case-insensitivity rules can be risky.
> 
> No, because right now on a case-insensitive filesystem we _only_ do the
> lookup with the normalized name.

Well, changing the case-insensitivity rules on an existing filesystem breaks the
directory indexing, so when the filesystem does an indexed lookup in a directory
it might no longer look in the right place.  But if the dentry were to be
examined regardless, it would still match.  (Again, assuming that the lookup
uses a name that is case-sensitively the same as the name the file was created
with.  If it's not case-sensitively the same, that's another story.)  ext4 and
f2fs recently added a fallback to a linear search for dentries in "casefolded"
directories, which handle this by no longer relying solely on the directory
indexing.  See commits 9e28059d56649 and 91b587ba79e1b.

- Eric

