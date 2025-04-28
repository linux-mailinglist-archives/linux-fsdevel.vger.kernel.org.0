Return-Path: <linux-fsdevel+bounces-47481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BD7A9E678
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 05:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B50C3BB48C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 03:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C67192B84;
	Mon, 28 Apr 2025 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qnip4csX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00422CCDB
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745810569; cv=none; b=JEqJsEGpGSMUY2HVKYXBLDvwWMLXcEDWlnpW/HbVV8VZccp1+LssrKNiIaXdHsuydSAVbl/aMg7/e4Skre9oeVjZHfnM6DFxjOwj+R5Yx9ko/3SqPYVhiwJCkG/0IbZTsadk9gPrJ2zN/b/X5Y5F3EfVb8MHFAACKVZX2TbzRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745810569; c=relaxed/simple;
	bh=fh0l8pT+tBZe/tgZTW7kgPHgKjYoR7Jz5k89rvD98Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kW2YfOfCxvnGiCCxbUlnSzh+dk3dvxmLMCwA9itFh0TapZpVKFy00KI3mhZ4C8N0Mhg8cWzzack0aUQEhX8DrruvVIFJvxolsA3DuXr/aMBNwTxZ1l5YpGpwrtHTzrYNdNkF1UkB3ilvTohHBVQvFtPtQRmOI+LNj5EC9WF3SHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qnip4csX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 27 Apr 2025 23:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745810561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1d0gnMbI3wrj6va90KVgR1RaOdT662gg90Ap7bnkaRQ=;
	b=qnip4csXyrVcIi4JsA0lz8ltVsSQGmKNBxW96mDXQ5asRoWdeIr5pD32uQuI5550FjqEpx
	a8Mquno5kAfT9Oj3Nx3Qjm7eQz+hi2tkg9VoY+lBJXYEwEdS2QPPb8VIlP5K32dSUY2xNr
	t0AVsoYaMXt4GrVEWBe87Yikdtvv9mM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Autumn Ashton <misyl@froggi.es>, 
	Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <jqodgs2ui26a2rvphdlxbabcwertvollwquiwg7eekai4pmwxl@amgb2mfhh3lb>
References: <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
 <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain>
 <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
 <5ea8aeb1-3760-4d00-baac-a81a4c4c3986@froggi.es>
 <20250428022240.GC6134@sol.localdomain>
 <dorhk5yr66eemxszl6hrujiqxnpera5kpvkkd4ebumh6xc3q2c@gtvl3cjfqfln>
 <CAHk-=wgtibpSH3+th-YjbQUSZVMbGNxG87oBDeqx+UkbHWejGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgtibpSH3+th-YjbQUSZVMbGNxG87oBDeqx+UkbHWejGw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 27, 2025 at 07:53:26PM -0700, Linus Torvalds wrote:
> On Sun, 27 Apr 2025 at 19:34, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Do you mean to say that we invented yet another incompatible unicode
> > casefolding scheme?
> >
> > Dear god, why?
> 
> Oh, Unicode itself comes with multiple "you can do this" schemes.
> 
> It's designed by committee, and meant for different situations and
> different uses.  Because the rules for things like sorting names are
> wildly different even for the same language, just for different
> contexts.
> 
> Think of Unicode as "several decades of many different people coming
> together, all having very different use cases".
> 
> So you find four different normalization forms, all with different use-cases.

I'm still dying to know why we had to invent our own, though. The
proliferation of standards is just ridiculous.

> And guess what? The only actual *valid* scheme for a filesystem is
> none of the four. Literally. It's to say "we don't normalize".
> 
> Because the normalization forms are not meant to be some kind of "you
> should do this".
> 
> They are meant as a kind of "if you are going to do X, then you can
> normalize into form Y, which makes doing X easier". And often the
> normalized form should only ever be an intermediate _temporary_ form
> for doing comparisons, not the actual form you save things in.
> 
> Sadly, people so often get it wrong.
> 
> For example, one very typical "you got it wrong, because you didn't
> understand the problem" case is to do comparisons by normalizing both
> sides (in one of the normalization forms) and then doing the
> comparison in that form.
> 
> And guess what? 99.9% of the time, you just wasted enormous amounts of
> time, because you could have done the comparison first *without* any
> normalization at all, because equality is equality even when neither
> side is normalized.

Yeah, that's another point in favor of "index both the normalized and
un-normalized form".

i.e.: the normalized index is a special thing that doesn't have to
exist, and we only check it if the lookup in the un-normalized index
fails.

Case-insensitive capable filesystems could act just like normal
filesystems, unless specific pids opted into the extra "normalized
lookups" path.

