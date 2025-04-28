Return-Path: <linux-fsdevel+bounces-47471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F975A9E63B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD207A8C6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 02:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A499A1624C0;
	Mon, 28 Apr 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0iY5bad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441E4C80;
	Mon, 28 Apr 2025 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745806963; cv=none; b=V27r9TymOIIGHLMxRlhBLtGbAKgiJMACmP3jKy+Nc+VUEIcA+qyQChK0neRraEjtYWWc8MFbZh8puXVK6rV8M7FRjW87zR9Zj+o0Gm4TsUy9N4VzsYC9NstaCBQC9tvINUqxJ4v0vLPKy+gC1oSHYp/PcmnvMNafC6FQOIHGf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745806963; c=relaxed/simple;
	bh=QuqCy+3t7hxV+nKMKZmPQlH1nktnAtsU0pqtylUPRlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps0rFJ2Or9DYriJuTJKR52e3uzRzv3qaq1tuYfnN57n3FT6D9LA7LVJ+oW0mD4RrZtbWrTxwe24Tr6F2qpNhYtjDBrKc4ca3/pLVilYVEdaZzYlrcAJi9AoZE/GF6eh453R+6+GGsxzwFipI5xkVdzyORDOp+3d2NU57kAof+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0iY5bad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBAEC4CEE3;
	Mon, 28 Apr 2025 02:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745806962;
	bh=QuqCy+3t7hxV+nKMKZmPQlH1nktnAtsU0pqtylUPRlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0iY5badWrKuDAN+rvW6ulgb5QAaAPNdb0Dl/OSQm3ljKEvT1VQMYiOH19noo02p8
	 bTbp3sRq6KM2cuD0Lm4Ei9AIo3ywJjNEqwhtWCJMmuHg4H2EB9BUBroh1pPHk6Gf95
	 X3QrM89K3wJO2aLt9A9YAq+4cIf6+MW5NQlaYhspG+O/oAf49R6noigdeP2NmkFFZb
	 C/LeMepsTfQ3ZsNIjcNdt8sZ6MhKerN95dgAr0nXDEKQfl6weUqK+sGYncm1fKVnU/
	 GpHmhR8ZmUBL9R6zU0XJ0FfkuKVecVJKxX2oaE0lU9HV8luY+v+PiCC8SFn15Y2EUn
	 ooEajkcY9l2cw==
Date: Sun, 27 Apr 2025 19:22:40 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Autumn Ashton <misyl@froggi.es>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <20250428022240.GC6134@sol.localdomain>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
 <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain>
 <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
 <5ea8aeb1-3760-4d00-baac-a81a4c4c3986@froggi.es>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ea8aeb1-3760-4d00-baac-a81a4c4c3986@froggi.es>

On Mon, Apr 28, 2025 at 03:05:19AM +0100, Autumn Ashton wrote:
> 
> 
> On 4/28/25 2:43 AM, Kent Overstreet wrote:
> > On Sun, Apr 27, 2025 at 06:30:59PM -0700, Eric Biggers wrote:
> > > On Sun, Apr 27, 2025 at 08:55:30PM -0400, Kent Overstreet wrote:
> > > > The thing is, that's exactly what we're doing. ext4 and bcachefs both
> > > > refer to a specific revision of the folding rules: for ext4 it's
> > > > specified in the superblock, for bcachefs it's hardcoded for the moment.
> > > > 
> > > > I don't think this is the ideal approach, though.
> > > > 
> > > > That means the folding rules are "whatever you got when you mkfs'd".
> > > > Think about what that means if you've got a fleet of machines, of
> > > > different ages, but all updated in sync: that's a really annoying way
> > > > for gremlins of the "why does this machine act differently" variety to
> > > > creep in.
> > > > 
> > > > What I'd prefer is for the unicode folding rules to be transparently and
> > > > automatically updated when the kernel is updated, so that behaviour
> > > > stays in sync. That would behave more the way users would expect.
> > > > 
> > > > But I only gave this real thought just over the past few days, and doing
> > > > this safely and correctly would require some fairly significant changes
> > > > to the way casefolding works.
> > > > 
> > > > We'd have to ensure that lookups via the case sensitive name always
> > > > works, even if the casefolding table the dirent was created with give
> > > > different results that the currently active casefolding table.
> > > > 
> > > > That would require storing two different "dirents" for each real dirent,
> > > > one normalized and one un-normalized, because we'd have to do an
> > > > un-normalized lookup if the normalized lookup fails (and vice versa).
> > > > Which should be completely fine from a performance POV, assuming we have
> > > > working negative dentries.
> > > > 
> > > > But, if the unicode folding rules are stable enough (and one would hope
> > > > they are), hopefully all this is a non-issue.
> > > > 
> > > > I'd have to gather more input from users of casefolding on other
> > > > filesystems before saying what our long term plans (if any) will be.
> > > 
> > > Wouldn't lookups via the case-sensitive name keep working even if the
> > > case-insensitivity rules change?  It's lookups via a case-insensitive name that
> > > could start producing different results.  Applications can depend on
> > > case-insensitive lookups being done in a certain way, so changing the
> > > case-insensitivity rules can be risky.
> > 
> > No, because right now on a case-insensitive filesystem we _only_ do the
> > lookup with the normalized name.
> > 
> > > Regardless, the long-term plan for the case-insensitivity rules should be to
> > > deprecate the current set of rules, which does Unicode normalization which is
> > > way overkill.  It should be replaced with a simple version of case-insensitivity
> > > that matches what FAT does.  And *possibly* also a version that matches what
> > > NTFS does (a u16 upcase_table[65536] indexed by UTF-16 coding units), if someone
> > > really needs that.
> > > 
> > > As far as I know, that was all that was really needed in the first place.
> > > 
> > > People misunderstood the problem as being about language support, rather than
> > > about compatibility with legacy filesystems.  And as a result they incorrectly
> > > decided they should do Unicode normalization, which is way too complex and has
> > > all sorts of weird properties.
> > 
> > Believe me, I do see the appeal of that.
> > 
> > One of the things I should really float with e.g. Valve is the
> > possibility of providing tooling/auditing to make it easy to fix
> > userspace code that's doing lookups that only work with casefolding.
> 
> This is not really about fixing userspace code that expects casefolding, or
> providing some form of stopgap there.
> 
> The main need there is Proton/Wine, which is a compat layer for Windows
> apps, which needs to pretend it's on NTFS and everything there expects
> casefolding to work.
> 
> No auditing/tooling required, we know the problem. It is unavoidable.
> 
> I agree with the calling about Unicode normalization being odd though, when
> I was implementing casefolding for bcachefs, I immediately thought it was a
> huge hammer to do full normalization for the intended purpose, and not just
> a big table...
> 
> FWIR, there is actually two forms of casefolding in unicode, full
> casefolding, C+F, (eg. ß->ss) and the simpler one, simple casefolding (C+S),
> where lengths don't change and it's glyph for glyph.

Yet, ext4 and f2fs's (and now bcachefs's...) "casefolding" is *not* compatible
with NTFS.

Nor is it compatible with FAT (which is what Android needed).

Nor does it actually do Unicode casefolding
(https://www.unicode.org/Public/16.0.0/ucd/CaseFolding.txt), but rather
Unicode normalization which is more complex.

I suspect that all that was really needed was case-insensitivity of ASCII a-z.
All of these versions of case-insensitivity provide that, so that is why they
may "seem" compatible...

- Eric

