Return-Path: <linux-fsdevel+bounces-47475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62877A9E656
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EAE67A7056
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 02:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB549188CB1;
	Mon, 28 Apr 2025 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiI9H4TQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF03433A4;
	Mon, 28 Apr 2025 02:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745808588; cv=none; b=OL/5g3Y2lHwzgcg3xZACdLy/zWpLhj0+NPm4sTaIZhvgkYkMqzUmb8oVF4kVfYQeW+Msu5+GOI3YfOPQjr+5/12wh2hF2y4SvaEf74qMleg7E/H7k9bHLMviPNNK6wBQIgbhVgnRZaG7ceS7nrRD/WYsbqMMzf/ZunDnAltSp2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745808588; c=relaxed/simple;
	bh=98HfE2dlq4WpfSJg1ONEisZcjBEtV62vo0nBKsafKPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCnLuJLwzkOQvG72mTOcYDLnh5EjiaEWAj9ZVFRxx6m4G1hdiALLzbIe2GbK7Ibfs9xZz1n/DvU1xh2nGAN2xkuNHXNNG/cjFeVgoflnI8E34Eojyfmsal5wp0/zjMVF271MP028oLBunjSaSf7cFqjK9jyZbpKPXYRT3/mjCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiI9H4TQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC99C4CEE3;
	Mon, 28 Apr 2025 02:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745808587;
	bh=98HfE2dlq4WpfSJg1ONEisZcjBEtV62vo0nBKsafKPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WiI9H4TQDt8j82A0Le+ljUnpZ6NNXsYQgnQ/u0OGoL6Dgd5u+qNvIb+G/vyiXAd2g
	 WQMbAlKyYKs1zjhAkrplxdrtRuYTeuE/zKQv58EOB6BVIn7Zi8CQ/LducZAWsh91F6
	 VoYbhoJ6dyTO3xUGLfiBOcnwGo0oKSmQYa0MOlTld0T20wQY0+xt1YoBHjgQbq/iHA
	 mUckhk1eZ7cJBy9KekB49jKyAkbbM0UAntHDCu6Jkqbm+HRVVt4HeXotiesoe6FIhT
	 JqVkMO7Jn2sZUC+biMF6K3r376tk2tbPe5L3BLtugDSJL/vAIlprf5FjzpEt5wqNst
	 JJ+Hyv3bt4gkA==
Date: Sun, 27 Apr 2025 19:49:45 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <20250428024945.GD6134@sol.localdomain>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
 <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain>
 <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
 <20250428021514.GB6134@sol.localdomain>
 <ogtnxaeyjldd6lapfbhwj3ptpvwkjpn66e3gejawdjs7s7hg2v@pksyrq3gzwal>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ogtnxaeyjldd6lapfbhwj3ptpvwkjpn66e3gejawdjs7s7hg2v@pksyrq3gzwal>

On Sun, Apr 27, 2025 at 10:33:29PM -0400, Kent Overstreet wrote:
> On Sun, Apr 27, 2025 at 07:15:14PM -0700, Eric Biggers wrote:
> > On Sun, Apr 27, 2025 at 09:43:43PM -0400, Kent Overstreet wrote:
> > > On Sun, Apr 27, 2025 at 06:30:59PM -0700, Eric Biggers wrote:
> > > > On Sun, Apr 27, 2025 at 08:55:30PM -0400, Kent Overstreet wrote:
> > > > > The thing is, that's exactly what we're doing. ext4 and bcachefs both
> > > > > refer to a specific revision of the folding rules: for ext4 it's
> > > > > specified in the superblock, for bcachefs it's hardcoded for the moment.
> > > > > 
> > > > > I don't think this is the ideal approach, though.
> > > > > 
> > > > > That means the folding rules are "whatever you got when you mkfs'd".
> > > > > Think about what that means if you've got a fleet of machines, of
> > > > > different ages, but all updated in sync: that's a really annoying way
> > > > > for gremlins of the "why does this machine act differently" variety to
> > > > > creep in.
> > > > > 
> > > > > What I'd prefer is for the unicode folding rules to be transparently and
> > > > > automatically updated when the kernel is updated, so that behaviour
> > > > > stays in sync. That would behave more the way users would expect.
> > > > > 
> > > > > But I only gave this real thought just over the past few days, and doing
> > > > > this safely and correctly would require some fairly significant changes
> > > > > to the way casefolding works.
> > > > > 
> > > > > We'd have to ensure that lookups via the case sensitive name always
> > > > > works, even if the casefolding table the dirent was created with give
> > > > > different results that the currently active casefolding table.
> > > > > 
> > > > > That would require storing two different "dirents" for each real dirent,
> > > > > one normalized and one un-normalized, because we'd have to do an
> > > > > un-normalized lookup if the normalized lookup fails (and vice versa).
> > > > > Which should be completely fine from a performance POV, assuming we have
> > > > > working negative dentries.
> > > > > 
> > > > > But, if the unicode folding rules are stable enough (and one would hope
> > > > > they are), hopefully all this is a non-issue.
> > > > > 
> > > > > I'd have to gather more input from users of casefolding on other
> > > > > filesystems before saying what our long term plans (if any) will be.
> > > > 
> > > > Wouldn't lookups via the case-sensitive name keep working even if the
> > > > case-insensitivity rules change?  It's lookups via a case-insensitive name that
> > > > could start producing different results.  Applications can depend on
> > > > case-insensitive lookups being done in a certain way, so changing the
> > > > case-insensitivity rules can be risky.
> > > 
> > > No, because right now on a case-insensitive filesystem we _only_ do the
> > > lookup with the normalized name.
> > 
> > Well, changing the case-insensitivity rules on an existing filesystem breaks the
> > directory indexing, so when the filesystem does an indexed lookup in a directory
> > it might no longer look in the right place.  But if the dentry were to be
> > examined regardless, it would still match.  (Again, assuming that the lookup
> > uses a name that is case-sensitively the same as the name the file was created
> > with.  If it's not case-sensitively the same, that's another story.)  ext4 and
> > f2fs recently added a fallback to a linear search for dentries in "casefolded"
> > directories, which handle this by no longer relying solely on the directory
> > indexing.  See commits 9e28059d56649 and 91b587ba79e1b.
> 
> bcachefs stores the normalized d_name, in addition to the
> un-normalized version, so our low level directory indexing works just
> fine if the normalization rules change.
> 
> That is, bcachefs could be changed to always load the latest unicode
> normalization table, and internally everything will work completely
> fine.
> 
> BUT:
> 
> If the normalization rules change for an existing dirent, then looking up
> the un-normalized name with the new rules gives you a different
> normalization than what's on disk and would return -ENOENT. You'd have
> to look up the old normalized name, or something that normalized to the
> old normalized name, to find it. Obviously, that's broken.
> 
> IOW: bcachefs doesn't have the linear search fallback, and that's not
> something I'd ever add. That effectively means a silent fallback to
> O(n^2) algorithms, and I don't want the bug reports that would someday
> generate.

Is there a reason why you don't just do what ext4 and f2fs does and store (only)
the case-preserved original name on-disk?

Note that generic_ci_match() has a fast path that compares the bytes of the
on-disk name to the bytes of the user-requested name.  Only if they don't match
is the "casefolded" comparison done.  It's true that if the filesystem were to
store the "casefolded" name on-disk too, then it wouldn't have to be computed
for each "casefolded" comparison with that dentry.  But that's already the "slow
path" that is executed only when the name wasn't case-sensitively the same.

- Eric

