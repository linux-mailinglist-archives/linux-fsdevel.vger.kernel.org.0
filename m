Return-Path: <linux-fsdevel+bounces-47463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D4EA9E5C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 03:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AFC18927E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 01:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE04155725;
	Mon, 28 Apr 2025 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIQJw4hI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C83595D;
	Mon, 28 Apr 2025 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745803862; cv=none; b=QrXlHmHdsdC6mMopamyognq8ErxWmxsJj81Ut9VabNfrRHrPttdEiSQg+NUxjju0bOCwwtvGR4Gqg0pmaBHAsgih2pMoNB4aK9rT5h5SQO1k68mO4nvoJEnhIk36TZjVz8Re2XplAlLofyrBzoy9uFr5/LZiWLtPa7jJjE/xiao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745803862; c=relaxed/simple;
	bh=LtCEiezzdAb4Ir6Z+bIbN7I3Y0lzoYPI69aL8qow0Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm5m+9s7AlLTOyE2xqqNL0ljCEr/Ogk+sw+Zf9WqN4PS+yxjupPaw4QusZi572LIr0h1KSZuWMYZFdyUwNp1l+rxAUp9f9HJGRxBFZCJf6Myg5hbkG7Vq0LVq4Vd2eW2ty7sul/UD5MsUMP6tvxhkJ1iGJ/bHGYb9QJxlmEft3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIQJw4hI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379FAC4CEE3;
	Mon, 28 Apr 2025 01:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745803861;
	bh=LtCEiezzdAb4Ir6Z+bIbN7I3Y0lzoYPI69aL8qow0Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIQJw4hI9rruo0Zkd27/+oIpA5J5+jnEMVRhtbPuF8RmDkxPW5uFH4YR2KKh9DKVe
	 2sqtvyXjJ8vy4NEdwFgkKg3jSCZ+Np+ye4A33tW5UQZcIrXHKkk5xMy1zHvApHAewg
	 tq3gKDgw7cbxOfUHCDywImfdb1i5mqI8jseeJwtTEwtZsAr/UxMr3WFNTAXSAj8aNg
	 XK/8vOtf3XccUQ4S9Rd63p5rug43ut0tm9D7B7BQWh9zKF4iLhk2vL5XFh1qeeVgCH
	 OCt+uRCWZ2y1fA5EpgZIy6UPVFzwVCBS6m4jAeunZZvRE8doApityDFRcVdxtOzWIl
	 /Z+aEvsQc1dkg==
Date: Sun, 27 Apr 2025 18:30:59 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <20250428013059.GA6134@sol.localdomain>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
 <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>

On Sun, Apr 27, 2025 at 08:55:30PM -0400, Kent Overstreet wrote:
> On Fri, Apr 25, 2025 at 08:40:35PM +0100, Matthew Wilcox wrote:
> > On Fri, Apr 25, 2025 at 09:35:27AM -0700, Linus Torvalds wrote:
> > > Now, if filesystem people were to see the light, and have a proper and
> > > well-designed case insensitivity, that might change. But I've never
> > > seen even a *whiff* of that. I have only seen bad code that
> > > understands neither how UTF-8 works, nor how unicode works (or rather:
> > > how unicode does *not* work - code that uses the unicode comparison
> > > functions without a deeper understanding of what the implications
> > > are).
> > > 
> > > Your comments blaming unicode is only another sign of that.
> > > 
> > > Because no, the problem with bad case folding isn't in unicode.
> > > 
> > > It's in filesystem people who didn't understand - and still don't,
> > > after decades - that you MUST NOT just blindly follow some external
> > > case folding table that you don't understand and that can change over
> > > time.
> > 
> > I think this is something that NTFS actually got right.  Each filesystem
> > carries with it a 128KiB table that maps each codepoint to its
> > case-insensitive equivalent.  So there's no ambiguity about "which
> > version of the unicode standard are we using", "Does the user care
> > about Turkish language rules?", "Is Aachen a German or Danish word?".
> > The sysadmin specified all that when they created the filesystem, and it
> > doesn't matter what the Unicode standard changes in the future; if you
> > need to change how the filesystem sorts things, you can update the table.
> > 
> > It's not the perfect solution, but it might be the least-bad one I've
> > seen.
> 
> The thing is, that's exactly what we're doing. ext4 and bcachefs both
> refer to a specific revision of the folding rules: for ext4 it's
> specified in the superblock, for bcachefs it's hardcoded for the moment.
> 
> I don't think this is the ideal approach, though.
> 
> That means the folding rules are "whatever you got when you mkfs'd".
> Think about what that means if you've got a fleet of machines, of
> different ages, but all updated in sync: that's a really annoying way
> for gremlins of the "why does this machine act differently" variety to
> creep in.
> 
> What I'd prefer is for the unicode folding rules to be transparently and
> automatically updated when the kernel is updated, so that behaviour
> stays in sync. That would behave more the way users would expect.
> 
> But I only gave this real thought just over the past few days, and doing
> this safely and correctly would require some fairly significant changes
> to the way casefolding works.
> 
> We'd have to ensure that lookups via the case sensitive name always
> works, even if the casefolding table the dirent was created with give
> different results that the currently active casefolding table.
> 
> That would require storing two different "dirents" for each real dirent,
> one normalized and one un-normalized, because we'd have to do an
> un-normalized lookup if the normalized lookup fails (and vice versa).
> Which should be completely fine from a performance POV, assuming we have
> working negative dentries.
> 
> But, if the unicode folding rules are stable enough (and one would hope
> they are), hopefully all this is a non-issue.
> 
> I'd have to gather more input from users of casefolding on other
> filesystems before saying what our long term plans (if any) will be.

Wouldn't lookups via the case-sensitive name keep working even if the
case-insensitivity rules change?  It's lookups via a case-insensitive name that
could start producing different results.  Applications can depend on
case-insensitive lookups being done in a certain way, so changing the
case-insensitivity rules can be risky.

Regardless, the long-term plan for the case-insensitivity rules should be to
deprecate the current set of rules, which does Unicode normalization which is
way overkill.  It should be replaced with a simple version of case-insensitivity
that matches what FAT does.  And *possibly* also a version that matches what
NTFS does (a u16 upcase_table[65536] indexed by UTF-16 coding units), if someone
really needs that.

As far as I know, that was all that was really needed in the first place.

People misunderstood the problem as being about language support, rather than
about compatibility with legacy filesystems.  And as a result they incorrectly
decided they should do Unicode normalization, which is way too complex and has
all sorts of weird properties.

- Eric

