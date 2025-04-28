Return-Path: <linux-fsdevel+bounces-47482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88437A9E685
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 05:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F8A189AD4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 03:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959AE198E81;
	Mon, 28 Apr 2025 03:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kFrJ/8bw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7232AEFE;
	Mon, 28 Apr 2025 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745810973; cv=none; b=ZujFxrOu8r9KkxwLeAHGgxiBlYOrnAv+ncefIgV69cIMTwKIZUuKjM0Hlk8Km+MO3dhM+2qZxvKwRT+3ujcPpMWur1+M1Ob2u68qbvUCLkIR7AlQk1rSvygBof7/d+oFvVxqq1CxvyiZhe/DIBnk0W4rhy6YFp2gAfCRpaq0/3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745810973; c=relaxed/simple;
	bh=4nP/baMD4oquilMCRz8k0tMUo6MIljDDu2fhy3swcB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcmddJUJn3lwBM3Ozcon1IllXEz2MX6Utk5WrF8GWIr7BX/M7L2VJZXu8NJWqW9iGwXewZ+SMJR/gMnoJQysQkFB+J/eefAKQpKXMgTuDsmPTohE+wbN2ytly1Ym2uE02xZHZgb/o+YmQUT+D67Z9pGg6vdNUw/ttd/BeVh+VQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kFrJ/8bw; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 27 Apr 2025 23:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745810959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvncevIkwnzEnKaCJvSdWp+ofwn0LIBiUkyT7jpXV9o=;
	b=kFrJ/8bwkzqVM727G+tBD3jhsWnSKF8T80hONyOf3AXjONp9Tm29AfRLKN+aynVuDp7Fam
	fy4/njaRNCES7r+XubcysB4EIvfmLnh4ZjYoU2nshg80uip7IYvPSn2OiW1ewa/8cmxelr
	Zh3tOHZBmGK7zi2ISi37YWgc759mbhM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <lskt5tzoqnklkezad2rsqs5ezitmrn4vyppwlwrcusasebkaea@qtdmnqyusunk>
References: <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
 <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain>
 <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
 <20250428021514.GB6134@sol.localdomain>
 <ogtnxaeyjldd6lapfbhwj3ptpvwkjpn66e3gejawdjs7s7hg2v@pksyrq3gzwal>
 <20250428024945.GD6134@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428024945.GD6134@sol.localdomain>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 27, 2025 at 07:49:45PM -0700, Eric Biggers wrote:
> Is there a reason why you don't just do what ext4 and f2fs does and store (only)
> the case-preserved original name on-disk?

The rationale was performance.

In hindsight I think that made zero sense, but perhaps it will turn out
to be useful in a way - because that's what got me thinking about
compatibility more, and then "separate indexes for casefolded and non
casefolded".

I'm not sure that this is honestly pressing enough that we'll write the
code, but that is feeling like the actual correct approach here.

> 
> Note that generic_ci_match() has a fast path that compares the bytes of the
> on-disk name to the bytes of the user-requested name.  Only if they don't match
> is the "casefolded" comparison done.  It's true that if the filesystem were to
> store the "casefolded" name on-disk too, then it wouldn't have to be computed
> for each "casefolded" comparison with that dentry.  But that's already the "slow
> path" that is executed only when the name wasn't case-sensitively the same.

Yeah, and all this is only hit on dcache misses, which makes it pretty
irrelevant.

