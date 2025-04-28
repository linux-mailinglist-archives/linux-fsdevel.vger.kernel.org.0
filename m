Return-Path: <linux-fsdevel+bounces-47472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28794A9E645
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7FD17783E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 02:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2B156C62;
	Mon, 28 Apr 2025 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oEj4e8W0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC084BE67
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745807621; cv=none; b=dJWj1GZbDLkeS44QUtn4jPlLuHvE+NNh5EceFg+rs6DO/WXPxYpEEHb5GqWL1pn02W3zZN+aGSbIDgshTuaazGxcx1teckSZlLHCK1UWzLj6HankFy19GtBM19MbVDgT2PX+hDCTQGN372kDe/rq81iuykRxdTr5SHsrBBf9gQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745807621; c=relaxed/simple;
	bh=DKLbDWf9uKQXbVFxsu2pn2EL2EuFGM6ImWSv256I7rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maj28D2ksr7c2iyOTkMzGCyh/KZvdjSazjLHjw+cK77w0OXMx8Kwbb/IMgzoHwJO0FneuZiV3IWBKvTRvdtEgF46EdfNpGpHY4Bo16wLCSphUuQR3lqzUyWyBccwX5pe/xSBUX+p21eMjbAjSBG17JFcacxdOlhxFQwsteSLH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oEj4e8W0; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 27 Apr 2025 22:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745807616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+pdkbsXzv3EJJcbLvktiLnbo0al+9T3EXAV22sII1M=;
	b=oEj4e8W0oFk2mGNhPgirxXJHhuIOkV8i7UsVb6fMFH+AEwkqQilH0pFNHZpFuGA/JJhiB5
	z/D1xop6a5oQZ5EPZxmKCSWdyPo1bxRAAJx9iH0+LggTRfiXov4ucbKoyK6jlGHaZH5aoP
	4Bwh5gX4QPFWOcUUpgjglk2jLqYpQNM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <ogtnxaeyjldd6lapfbhwj3ptpvwkjpn66e3gejawdjs7s7hg2v@pksyrq3gzwal>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
 <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain>
 <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
 <20250428021514.GB6134@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428021514.GB6134@sol.localdomain>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 27, 2025 at 07:15:14PM -0700, Eric Biggers wrote:
> On Sun, Apr 27, 2025 at 09:43:43PM -0400, Kent Overstreet wrote:
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
> 
> Well, changing the case-insensitivity rules on an existing filesystem breaks the
> directory indexing, so when the filesystem does an indexed lookup in a directory
> it might no longer look in the right place.  But if the dentry were to be
> examined regardless, it would still match.  (Again, assuming that the lookup
> uses a name that is case-sensitively the same as the name the file was created
> with.  If it's not case-sensitively the same, that's another story.)  ext4 and
> f2fs recently added a fallback to a linear search for dentries in "casefolded"
> directories, which handle this by no longer relying solely on the directory
> indexing.  See commits 9e28059d56649 and 91b587ba79e1b.

bcachefs stores the normalized d_name, in addition to the
un-normalized version, so our low level directory indexing works just
fine if the normalization rules change.

That is, bcachefs could be changed to always load the latest unicode
normalization table, and internally everything will work completely
fine.

BUT:

If the normalization rules change for an existing dirent, then looking up
the un-normalized name with the new rules gives you a different
normalization than what's on disk and would return -ENOENT. You'd have
to look up the old normalized name, or something that normalized to the
old normalized name, to find it. Obviously, that's broken.

IOW: bcachefs doesn't have the linear search fallback, and that's not
something I'd ever add. That effectively means a silent fallback to
O(n^2) algorithms, and I don't want the bug reports that would someday
generate.

