Return-Path: <linux-fsdevel+bounces-21793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8E2909EEB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 20:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A225D1C2236B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 17:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E577E446AF;
	Sun, 16 Jun 2024 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="waqRj/iO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C229CE1
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718560789; cv=none; b=YI22cmzLhabdpJg6hOlR1KalHdGI8+gbadLm0a7K4a0/SXh9z7CJchTk/fLusZTKDkGa+l/P6jCGAYZtgbgi5JZmGS0juILMhADn0Z7K7TqB8NpxE4cJ1u8yJ9Bbser+J9QheuNv7mKKkpQyfzv6d8LhdfKU8yhNoOjdfcXPM/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718560789; c=relaxed/simple;
	bh=GNPznmVFlPR3RsVpPl6vOlMLYCC+mkWvMEha016EnDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGDInD9izvi8qilO1qhbCC7NLrV1cak7QnZcTUpT2SWSpQ1+496rOdjX9CM3NkjOEPGmwOv06NR9IYQeQbLK650ZzhU+tMyoCSkq4My4IQurA9cD48bDuMazb6BgehdfUwRuohpw4wK7J7/eYy+1pbkjb/gs+Wqn3NTWlIFuXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=waqRj/iO; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: boqun.feng@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718560784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNPznmVFlPR3RsVpPl6vOlMLYCC+mkWvMEha016EnDw=;
	b=waqRj/iOWdlIknFWuHS+bl2iwJKaGwkmSmoER3qnBi2cU6jyj6pim9RBPZJTsvIFoN+Ii6
	bfnSzxPd9ZMrsReZBavtTbyBc9AMXcz6bj9lBRNnNmrPub+/3CcLQWi3cLSuriwpl8yCNY
	JY0b35ukzm8v8Rr5bUIJhdXyFlowHEA=
X-Envelope-To: miguel.ojeda.sandonis@gmail.com
X-Envelope-To: benno.lossin@proton.me
X-Envelope-To: gary@garyguo.net
X-Envelope-To: rust-for-linux@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-arch@vger.kernel.org
X-Envelope-To: llvm@lists.linux.dev
X-Envelope-To: ojeda@kernel.org
X-Envelope-To: alex.gaynor@gmail.com
X-Envelope-To: wedsonaf@gmail.com
X-Envelope-To: bjorn3_gh@protonmail.com
X-Envelope-To: a.hindborg@samsung.com
X-Envelope-To: aliceryhl@google.com
X-Envelope-To: stern@rowland.harvard.edu
X-Envelope-To: parri.andrea@gmail.com
X-Envelope-To: will@kernel.org
X-Envelope-To: peterz@infradead.org
X-Envelope-To: npiggin@gmail.com
X-Envelope-To: dhowells@redhat.com
X-Envelope-To: j.alglave@ucl.ac.uk
X-Envelope-To: luc.maranget@inria.fr
X-Envelope-To: paulmck@kernel.org
X-Envelope-To: akiyks@gmail.com
X-Envelope-To: dlustig@nvidia.com
X-Envelope-To: joel@joelfernandes.org
X-Envelope-To: nathan@kernel.org
X-Envelope-To: ndesaulniers@google.com
X-Envelope-To: kent.overstreet@gmail.com
X-Envelope-To: gregkh@linuxfoundation.org
X-Envelope-To: elver@google.com
X-Envelope-To: mark.rutland@arm.com
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: mingo@redhat.com
X-Envelope-To: bp@alien8.de
X-Envelope-To: dave.hansen@linux.intel.com
X-Envelope-To: x86@kernel.org
X-Envelope-To: hpa@zytor.com
X-Envelope-To: catalin.marinas@arm.com
X-Envelope-To: torvalds@linux-foundation.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: tmgross@umich.edu
X-Envelope-To: dakr@redhat.com
Date: Sun, 16 Jun 2024 13:59:37 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	elver@google.com, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, 
	dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <reazaqddtuh42zpz5abgo6z3er5qre6qpbowqrwmrwsj76z32p@6xgeshmg3hkg>
References: <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
 <5lwylk6fhlvqfgxmt7xdoxdrhtvmplo5kazpdbt3kxpnlltxit@v5xbpiv3dnqq>
 <Zm7zvt7cNT2YpiIi@Boquns-Mac-mini.home>
 <CANiq72mz=OzzHJJyOPeWcxEtppP+v0KUq63_u5NB7-R84avaPg@mail.gmail.com>
 <4pez6kilgykarr5qeutgaw3pvkxf2nmh4lzuftadshmkke7d3q@3jfgvjveqdbz>
 <Zm8KoUNQ4v7UvVOE@Boquns-Mac-mini.home>
 <Zm8hG58nuE3HrnyS@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm8hG58nuE3HrnyS@Boquns-Mac-mini.home>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 16, 2024 at 10:30:03AM -0700, Boqun Feng wrote:
> I think the disagreement here is not non-generic atomic vs generic
> atomic, it's pure generic atomic vs. AtomicI{32,64} etc + generic
> atomic. I said multiple times that I'm OK with generic atomics if there
> are real users, just I'm not sure it's something we want to do right now
> (or we have enough information to go fully on that direction). And I
> think it's fine to have non-generic atomic and generic atomic coexist.

Well, having the generic interface from the start does matter, that's
what we (myself included) want to code to.

No need to overcomplicate it, just
Atomic<u8>
Atomic<u16>

etc...

As long as that's available, the internal implementation shouldn't have
to change.

