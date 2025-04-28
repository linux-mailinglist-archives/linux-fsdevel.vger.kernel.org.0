Return-Path: <linux-fsdevel+bounces-47469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA1A9E62F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751583B2FF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 02:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEBD13B590;
	Mon, 28 Apr 2025 02:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fXK7J1ZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38FA930
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745806617; cv=none; b=Rt0Od/hKZ450NPsRyIqSE6uey8DFZO0yHiFGY5HpK+ukGfV4pRdacFQQolJYTecEt0x6Ahzq1zRF/U27YQ0AST+zE/oLi6ruNBU5fWkXa2O95uFyrgmF2oyrqAyXcaO4/QRKWl1yXlVReEdx+ZpOpnaJzSPYVhNJCsf8Ja2isYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745806617; c=relaxed/simple;
	bh=SQqRlFD5fYY2+fVv3+FPvlMoGm8Uc3q9VP/c9Mdfv9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0bNgba6O1MEoLEW5gHa7Ua0F5gKro+5y9toErcBeSqSh4uXj6E/0y1Y0CqblMA3rqWxjrP2FzinRXM+h7gXRqLItv74REog5Ej/pmHGJFsSrxjn0BD1PuCoXDknfP4Ut6GwogAc/GIoNVJCFHP03xvE219bMjgDQZTL5U4X4G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fXK7J1ZY; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 27 Apr 2025 22:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745806601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RmM07fRPec/1zzAWMCpOGJvhJQMyg467Y39fmijBlIc=;
	b=fXK7J1ZYYemrn5k/9JQGCAtrtD1+xeanhXWhDlCNThGmi28Fo/MGnwEUHnuslo69ljd+53
	rwzsonvYSj/74D3Qex4/S3faX+YH1vqkQl9vonjEhXTrJNrMln5PfjPm8hwS+LRwYTbnQD
	yVSiWaUlt9R1s3kDmh6QD+6Z/JcZ/CU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Autumn Ashton <misyl@froggi.es>
Cc: Eric Biggers <ebiggers@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <wjj4ld5jpnj57wwe6ygtldm3jazlnlbendzwpe65xce5xfv5tg@im53llnthtxd>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea8aeb1-3760-4d00-baac-a81a4c4c3986@froggi.es>
X-Migadu-Flow: FLOW_OUT

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

Does this boil all the way up to e.g. savegames?

I was imagining predetermined assets, where the name of the file would
be present in a compiled binary, and it's little more than a search and
replace. But would only work if it's present as a string literal.

> I agree with the calling about Unicode normalization being odd though, when
> I was implementing casefolding for bcachefs, I immediately thought it was a
> huge hammer to do full normalization for the intended purpose, and not just
> a big table...

Samba's historically wanted casefolding, and Windows casefolding is
Unicode (and it's full, not simple - mostly), so I'd expect that was the
other main driver.

I'm sure there's other odd corners besides just Samba where Windows
compatibility comes up, people cook up all kinds of strange things.

