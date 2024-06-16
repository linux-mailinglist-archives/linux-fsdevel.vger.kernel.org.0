Return-Path: <linux-fsdevel+bounces-21785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CB1909E25
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 17:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57DF1F215AB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15531757D;
	Sun, 16 Jun 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qBn8YPc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301E14AB2
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718551964; cv=none; b=dDiCsLF36amNY568djzglk+iAsNp2RO4SS20cHDGOUcuHvfY7fGfs+yy9kAbKKmqEeHFWOr9EfZU6on/WapWjm8yzCtIQKTKyRRjuytdRcOVWhoQXcv3m0kwpHJM/7txJQmq8BrkPh1jrPbSL/McTeJC/7YY9HD6Z/6NVckzofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718551964; c=relaxed/simple;
	bh=uVdTOpoqCs1tXlSXuegTKEr1kms4N6fLFNvkatDFQ/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7i1dM2foQbkZAjFiDbmp+8U3Vq2vfsG4lMS6NV32Xisv3a7y6MfDlaR3s7mfUMDrx9SdCXnFeQREGDy5tTOwgd9aoCFDsdfdvWxhr5rNDq/uhAi1r6zH10fXzLTkuBe/VpQK9V8ShSqN6TJRXEKIjYIdY/l1tekIVshSYnQhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qBn8YPc+; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: miguel.ojeda.sandonis@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718551960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ll3O6qu97KkSvJ8QsIboEEwbJeNhMP7fi32IUtBVHiY=;
	b=qBn8YPc+8gQTTCTfPXn+NLJvV06FoUZnxL+APcrxgFz5+PzSDPSNhQkvPgIsKFKBAAxV5y
	IqmuqOnexSMZcJv8PwWThkCw1vwq+jLy036imkGm7Pzqg8G2mCpi6X57Pu7fej5bDhBlZB
	7KGUEI96BBwvYI1vHLIU+NljWMkMbwM=
X-Envelope-To: boqun.feng@gmail.com
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
Date: Sun, 16 Jun 2024 11:32:31 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, 
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
Message-ID: <4pez6kilgykarr5qeutgaw3pvkxf2nmh4lzuftadshmkke7d3q@3jfgvjveqdbz>
References: <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
 <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
 <5lwylk6fhlvqfgxmt7xdoxdrhtvmplo5kazpdbt3kxpnlltxit@v5xbpiv3dnqq>
 <Zm7zvt7cNT2YpiIi@Boquns-Mac-mini.home>
 <CANiq72mz=OzzHJJyOPeWcxEtppP+v0KUq63_u5NB7-R84avaPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mz=OzzHJJyOPeWcxEtppP+v0KUq63_u5NB7-R84avaPg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 16, 2024 at 05:14:56PM +0200, Miguel Ojeda wrote:
> On Sun, Jun 16, 2024 at 4:16 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hmm? Have you seen the email I replied to John, a broader Rust community
> > seems doesn't appreciate the idea of generic atomics.
> 
> I don't think we can easily draw that conclusion from those download
> numbers / dependent crates.
> 
> portable-atomic may be more popular simply because it provides
> features for platforms the standard library does not. The interface
> being generic or not may have nothing to do with it. Or perhaps
> because it has a 1.x version, while the other doesn't, etc.
> 
> In fact, the atomic crate is essentially about providing `Atomic<T>`,
> so one could argue that all those downloads are precisely from people
> that want a generic atomic.
> 
> Moreover, I noticed portable-atomic's issue #1 in GitHub is,
> precisely, adding `Atomic<T>` support. The maintainer has a PR for
> that updated over time, most recently a few hours ago.
> 
> There is also `AtomicCell<T>` from crossbeam, which is the first
> feature listed in its docs.
> 
> Anyway...
> 
> The way I see it, both approaches seem similar (i.e. for what we are
> going to use them for today, at least) and neither apparently has a
> major downside today for those use cases (apart from needed refactors
> later to go to another approach).
> 
> (By the "generic approach", by the way, I mean just providing
> `Atomic<{i32,i64}>`, not a complex design)
> 
> So it is up to you on what you send for the non-RFC patches, of
> course, and if nobody has the time / wants to do the work for the
> "simple" generic approach, then we can just go ahead with this for the
> moment. But I think it would be nice to at least consider the "simple"
> generic approach to see how much worse it would be.
> 
> Other bits to consider, that perhaps give you arguments for one or the
> other: consequences on the compilation time, on inlining, on the error
> messages for new users, on the generated documentation, on how easy to
> grep they are, etc.

Yeah, rereading the thread - I'm with Miguel and Gary.

Generics are simply the correct way to do it, if the wider rust
community didn't do it that way I think that can be chalked up more to
historical baggage or needlessly copying the base integer type scheme.

Let's please do it right here, and generics are the correct approach.

