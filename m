Return-Path: <linux-fsdevel+bounces-47479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EA3A9E669
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 05:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2911A173A69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 03:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A605190072;
	Mon, 28 Apr 2025 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7btd6TS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FBA4A21;
	Mon, 28 Apr 2025 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745809991; cv=none; b=Bhd6S5s8pauZ5GHBwxlYvwNb5D9v4DpTHpsUB9h6YvPO0cJcF2VqVTvcYtuatVNFZMUD0dfdD20FgUzOBooSP9kCdswUyi8eTFfaiakrts9znkxHNkd/a9eGDimGwHdw1htVeiw4OUHVLKLay3bqQgDi+HM86smr+sGspgbEEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745809991; c=relaxed/simple;
	bh=ZZ8CsgJ2JxxmsHVXoY9ofLBRyaAGVgqPT3CphX0cMlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMe3qRVpKQIcuCuWkPLfdgVH38z1LNksJ+gtttndIGLBureJAnIwsea7X7Wcd/OcaExa/ac6ijl3tS/VPccyNcatfSkjxkTsFQfX1MlRkSRPYfpJLPkKbbloGCOcpFFbuM9gfSD1aWyMoultMQVWPmnH93eUj6A/FIqheFWbdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7btd6TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE117C4CEE3;
	Mon, 28 Apr 2025 03:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745809989;
	bh=ZZ8CsgJ2JxxmsHVXoY9ofLBRyaAGVgqPT3CphX0cMlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7btd6TSMtwna9jc0x4mxrsToRD6NB5S7/RxzZN61RTzSWg4u0i0xlqG5Gry0MpZ4
	 DYKUodiD/YO38yERMVvqLMcmU1EpqcMzs9HOcD5vPRAETy7iHsZWcfkENJWFkpJtuI
	 v0qk8DRgw/ZnBECEKeh2a6oavxtkxGZD4PXozPFSmAslXnnTYB+Zmidzw96RUvr9pt
	 CibWc7YdHoGRiGE1emNBldVZnYfPAfx+Jgs0VLXH59PlT1k5E6S5uzHgg59/DaDGc3
	 iBg3ZRCK7008+SRVZ9Sh6XSYSMTOKMBePYjH81r6Go5GylJ7fpOpMmFPWcXlD7qQY5
	 JGQ/2N0JLTb8Q==
Date: Sun, 27 Apr 2025 20:13:07 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Autumn Ashton <misyl@froggi.es>,
	Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <20250428031307.GE6134@sol.localdomain>
References: <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
 <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain>
 <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
 <5ea8aeb1-3760-4d00-baac-a81a4c4c3986@froggi.es>
 <20250428022240.GC6134@sol.localdomain>
 <CAHk-=wjGC=QF0PoqUBTo9+qW_hEGLcgb2ZHyt9V8xo5pvtj3Ew@mail.gmail.com>
 <yarkxhxub75z3vj47cidpe4vfk5b6cdx5mip2ummgyi6v6z4eg@rnfiud3fonxs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yarkxhxub75z3vj47cidpe4vfk5b6cdx5mip2ummgyi6v6z4eg@rnfiud3fonxs>

On Sun, Apr 27, 2025 at 11:01:20PM -0400, Kent Overstreet wrote:
> On Sun, Apr 27, 2025 at 07:39:46PM -0700, Linus Torvalds wrote:
> > On Sun, 27 Apr 2025 at 19:22, Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > I suspect that all that was really needed was case-insensitivity of ASCII a-z.
> > 
> > Yes. That's my argument. I think anything else ends up being a
> > mistake. MAYBE extend it to the first 256 characters in Unicode (aka
> > "Latin1").
> > 
> > Case folding on a-z is the only thing you could really effectively
> > rely on in user space even in the DOS times, because different
> > codepages would make for different rules for the upper 128 characters
> > anyway, and you could be in a situation where you literally couldn't
> > copy files from one floppy to another, because two files that had
> > distinct names on one floppy would have the *same* name on another
> > one.
> > 
> > Of course, that was mostly a weird corner case that almost nobody ever
> > actually saw in practice, because very few people even used anything
> > else than the default codepage.
> > 
> > And the same is afaik still true on NT, although practically speaking
> > I suspect it went from "unusual" to "really doesn't happen EVER in
> > practice".
> 
> I'm having trouble finding anything authoritative, but what I'm seeing
> indicates that NTFS does do Unicode casefolding (and their own
> incompatible version, at that).

NTFS "just" has a 65536-entry table that maps UTF-16 coding units to their
"upper case" equivalents.  So it only does 1-to-1 codepoint mappings, and only
for U+FFFF and below.

I suspect that it's the same, or at least nearly the same, as what
https://www.unicode.org/Public/16.0.0/ucd/CaseFolding.txt calls "simple"
casefolding (as opposed to "full" casefolding), but only for U+FFFF and below.

Of course, to implement the same with Linux's UTF-8 names, we won't be able to
just do a simple table lookup like Windows does.  But it could still be
implemented -- we'd just decode the Unicode codepoints from the string and apply
the same mapping from there.  Still much simpler than normalization.

- Eric

