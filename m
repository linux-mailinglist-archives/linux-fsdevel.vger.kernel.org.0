Return-Path: <linux-fsdevel+bounces-47478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40635A9E664
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 05:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B244F3B342D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 03:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE60516F8E9;
	Mon, 28 Apr 2025 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c0H3fLlt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646A13B280
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745809299; cv=none; b=isdqxEicsBbQq9e9g4pwfWoz6kEBsdkLx8klk89Wjd641Mn68GE3LMw2/bNNFzxbBkENqL5oDPMWo07PksiMGBydVxIYdVGpyzlHYICR04SMZ+jh8vl0/5tMqJb3y3jySfZD+gSs/3nzx6gXgGliYI4ZkdN7/92exzg8W1zHfZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745809299; c=relaxed/simple;
	bh=bTIYGjUEfWV91UOUEaa0bpz8MCd2i8xgNSwVExTVcyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDUzSBfLj/MOFiKrCJh2rdRLkxxAL02R5KWoErj/ZzjZOSCIshvB52cxBuFzqH9U+v4796HbV6+RxD+kSZPaD66KGEinI4sf8/M13rkZqGYctjnEpRV4h6JQdhVZjO4M0M+Rh7Gmn5vL82+V2M71rJ+EljjSYKRFN4k9aIfzW/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c0H3fLlt; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 27 Apr 2025 23:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745809285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5Tq6qv8wJ8+w6x70ZkxVFQ2witQoKaLCUGBtBocj7Q=;
	b=c0H3fLlt+HVbqw1MRHAa+qRYdBeomy4zGslAcdQDQsE+Sp/pAkozSzCt0pJyrh8wFpFTTY
	0DsOX4GTR8U4WMIxXRk1kCmKka0Ss0JEO6VMW3Ag5XFxdlVJVZMmp6H3zfJwJBqVvdbKEC
	ewm8Wp6dtzDzCZ//dITwc8L0faiX93A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Autumn Ashton <misyl@froggi.es>, 
	Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <yarkxhxub75z3vj47cidpe4vfk5b6cdx5mip2ummgyi6v6z4eg@rnfiud3fonxs>
References: <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
 <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain>
 <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
 <5ea8aeb1-3760-4d00-baac-a81a4c4c3986@froggi.es>
 <20250428022240.GC6134@sol.localdomain>
 <CAHk-=wjGC=QF0PoqUBTo9+qW_hEGLcgb2ZHyt9V8xo5pvtj3Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjGC=QF0PoqUBTo9+qW_hEGLcgb2ZHyt9V8xo5pvtj3Ew@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 27, 2025 at 07:39:46PM -0700, Linus Torvalds wrote:
> On Sun, 27 Apr 2025 at 19:22, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > I suspect that all that was really needed was case-insensitivity of ASCII a-z.
> 
> Yes. That's my argument. I think anything else ends up being a
> mistake. MAYBE extend it to the first 256 characters in Unicode (aka
> "Latin1").
> 
> Case folding on a-z is the only thing you could really effectively
> rely on in user space even in the DOS times, because different
> codepages would make for different rules for the upper 128 characters
> anyway, and you could be in a situation where you literally couldn't
> copy files from one floppy to another, because two files that had
> distinct names on one floppy would have the *same* name on another
> one.
> 
> Of course, that was mostly a weird corner case that almost nobody ever
> actually saw in practice, because very few people even used anything
> else than the default codepage.
> 
> And the same is afaik still true on NT, although practically speaking
> I suspect it went from "unusual" to "really doesn't happen EVER in
> practice".

I'm having trouble finding anything authoritative, but what I'm seeing
indicates that NTFS does do Unicode casefolding (and their own
incompatible version, at that).

> Extending those mistakes to full unicode and mixing in things like
> nonprinting codes and other things have only made things worse.
> 
> And dealing with things like ß and ss and trying to make those compare
> as equal is a *horrible* mistake. People who really need to do that
> (usually for some legalistic local reason) tend to have very specific
> rules for sorting anyway, and they are rules specific to particular
> situations, not something that the filesystem should even try to work
> with.

Well, casefolding is something that's directly exposed to users. So I do
think that if casefolding is going to exist at all, there is a strong
argument for it to be unicode and handling things like ß to ss.

(Can you imagine being the user that gets used to typing in filenames
and ignoring capitalization, except whenever an accented letter is part
of the filename, and then your muscle-memeory breaks? That sort of thing
is maddening).

BUT:

I'm becoming more and more convinced that I want more separation between
casefolded lookups and non casefolded lookups, the potential for
casefolding rule changes to break case-sensitive lookups is just bad.

If we do a "casefolding version 2" in bcachefs, we'll just have a
separate btree for casefolded dirents, and casefolded directories will
have their dirents indexed twice.

That's trivially extensible to multiple versions if - god forbid - we
ever end up needing to support multiple "locales", and more importantly
it'd let us support a mode where it's only certain pids that get
casefolded lookups, so you don't e.g. get casefolding dependencies
creeping into your makefiles as can happen today.

