Return-Path: <linux-fsdevel+bounces-12201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D113A85CD77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 02:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BC3284E0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 01:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54083522F;
	Wed, 21 Feb 2024 01:27:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCDB4428
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478844; cv=none; b=HB1qH4TMD8e+P1BiFg7d7LiNYCvUea8XRKzSTkVZ2T859ZD/ma5SrRVlo6r99t4xpZRRQHhPobZMcY55jCKi0amfVs+48w50QRhw2jsGVqfpLQvCRMIRORob5PISqtSMRyBzRe22AHgQfTCABaYd8cBngiPZtRJjE9TzfeCDQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478844; c=relaxed/simple;
	bh=pJwSeYFj2jRtte9Mv3vmD/7PvwCI3TccoqOgPr5VrYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5s13mMLlyGoQP8GX8ghmNlfGOT5Vd2ueBHc/JMbPHfLz4lCwxhZPWwZKMg7bjO2RWKP8+9v8UjerPwDuYmZbY6+0wLzdDDNz/xJsgoaQODPdJA3JzGmWfo4iqCH01O8UF3fhXlWCD9VO6JPUG1gvxV3K2LO3KYyOMkfOn4Afkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Tue, 20 Feb 2024 20:27:37 -0500
From: "dalias@libc.org" <dalias@libc.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org" <maz@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"will@kernel.org" <will@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"sorear@fastmail.com" <sorear@fastmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Message-ID: <20240221012736.GQ4163@brightrain.aerifal.cx>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
 <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
 <20240220235415.GP4163@brightrain.aerifal.cx>
 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Feb 21, 2024 at 12:35:48AM +0000, Edgecombe, Rick P wrote:
> On Tue, 2024-02-20 at 18:54 -0500, dalias@libc.org wrote:
> > On Tue, Feb 20, 2024 at 11:30:22PM +0000, Edgecombe, Rick P wrote:
> > > On Tue, 2024-02-20 at 13:57 -0500, Rich Felker wrote:
> > > > On Tue, Feb 20, 2024 at 06:41:05PM +0000, Edgecombe, Rick P
> > > > > Shadow stacks currently have automatic guard gaps to try to
> > > > > prevent
> > > > > one
> > > > > thread from overflowing onto another thread's shadow stack.
> > > > > This
> > > > > would
> > > > > somewhat opens that up, as the stack guard gaps are usually
> > > > > maintained
> > > > > by userspace for new threads. It would have to be thought
> > > > > through
> > > > > if
> > > > > these could still be enforced with checking at additional
> > > > > spots.
> > > > 
> > > > I would think the existing guard pages would already do that if a
> > > > thread's shadow stack is contiguous with its own data stack.
> > > 
> > > The difference is that the kernel provides the guard gaps, where
> > > this
> > > would rely on userspace to do it. It is not a showstopper either.
> > > 
> > > I think my biggest question on this is how does it change the
> > > capability for two threads to share a shadow stack. It might
> > > require
> > > some special rules around the syscall that writes restore tokens.
> > > So
> > > I'm not sure. It probably needs a POC.
> > 
> > Why would they be sharing a shadow stack?
> 
> The guard gap was introduced originally based on a suggestion that
> overflowing a shadow stack onto an adjacent shadow stack could cause
> corruption that could be used by an attacker to work around the
> protection. There wasn't any concrete demonstrated attacks or
> suggestion that all the protection was moot.

OK, so not sharing, just happening to be adjacent.

I was thinking from a standpoint of allocating them as part of the
same range as the main stack, just with different protections, where
that would never happen; you'd always have intervening non-shadowstack
pages. But when they're kernel-allocated, yes, they need their own
guard pages.

> But when we talk about capabilities for converting memory to shadow
> stack with simple memory accesses, and syscalls that can write restore
> token to shadow stacks, it's not immediately clear to me that it
> wouldn't open up something like that. Like if two restore tokens were
> written to a shadow stack, or two shadow stacks were adjacent with
> normal memory between them that later got converted to shadow stack.
> Those sorts of scenarios, but I won't lean on those specific examples.
> Sorry for being hand wavy. It's just where I'm at, at this point.

I don't think it's safe to have automatic conversions back and forth,
only for normal accesses to convert shadowstack to normal memory (in
which case, any subsequent attempt to operate on it as shadow stack
indicates a critical bug and should be trapped to terminate the
process).

> > > > From the musl side, I have always looked at the entirely of
> > > > shadow
> > > > stack stuff with very heavy skepticism, and anything that breaks
> > > > existing interface contracts, introduced places where apps can
> > > > get
> > > > auto-killed because a late resource allocation fails, or requires
> > > > applications to code around the existence of something that
> > > > should be
> > > > an implementation detail, is a non-starter. To even consider
> > > > shadow
> > > > stack support, it must truely be fully non-breaking.
> > > 
> > > The manual assembly stack switching and JIT code in the apps needs
> > > to
> > > be updated. I don't think there is a way around it.
> > 
> > Indeed, I'm not talking about programs with JIT/manual stack-
> > switching
> > asm, just anything using existing APIs for control of stack --
> > pthread_setstack, makecontext, sigaltstack, etc.
> 
> Then I think WRSS might fit your requirements better than what glibc
> did. It was considered a reduced security mode that made libc's job
> much easier and had better compatibility, but the last discussion was
> to try to do it without WRSS.

Where can I read more about this? Some searches I tried didn't turn up
much useful information.

> > > I agree though that the late allocation failures are not great.
> > > Mark is
> > > working on clone3 support which should allow moving the shadow
> > > stack
> > > allocation to happen in userspace with the normal stack. Even for
> > > riscv
> > > though, doesn't it need to update a new register in stack
> > > switching?
> > 
> > If clone is called with signals masked, it's probably not necessary
> > for the kernel to set the shadow stack register as part of clone3.
> 
> So you would want a mode of clone3 that basically leaves the shadow
> stack bits alone? Mark was driving that effort, but it doesn't seem
> horrible to me on first impression. If it would open up the possibility
> of musl support.

Well I'm not sure. That's what we're trying to figure out. But I don't
think modifying it is a hard requirement, since it can be modified
from userspace if needed as long as signals are masked.

> > One reasonable thing to do, that might be preferable to
> > overengineered
> > solutions, is to disable shadow-stack process-wide if an interface
> > incompatible with it is used (sigaltstack, pthread_create with an
> > attribute setup using pthread_attr_setstack, makecontext, etc.), as
> > well as if an incompatible library is is dlopened.
> 
> I think it would be an interesting approach to determining
> compatibility. On x86 there has been cases of binaries getting
> mismarked as supporting shadow stack. So an automated way of filtering
> some of those out would be very useful I think. I guess the dynamic
> linker could determine this based on some list of functions?

I didn't follow this whole mess, but from our side (musl) it does not
seem relevant. There are no legacy binaries wrongly marked because we
have never supported shadow stacks so far.

> The dlopen() bit gets complicated though. You need to disable shadow
> stack for all threads, which presumably the kernel could be coaxed into
> doing. But those threads might be using shadow stack instructions
> (INCSSP, RSTORSSP, etc). These are a collection of instructions that
> allow limited control of the SSP. When shadow stack gets disabled,
> these suddenly turn into #UD generating instructions. So any other
> threads executing those instructions when shadow stack got disabled
> would be in for a nasty surprise.

This is the kernel's problem if that's happening. It should be
trapping these and returning immediately like a NOP if shadow stack
has been disabled, not generating SIGILL.

> > The place where it's really needed to be able to allocate the shadow
> > stack synchronously under userspace control, in order to harden
> > normal
> > applications that aren't doing funny things, is in pthread_create
> > without a caller-provided stack.
> 
> Yea most apps don't do anything too tricky. Mostly shadow stack "just
> works". But it's no excuse to just crash for the others.

One thing to note here is that, to enable this, we're going to need
some way to detect "new enough kernel that shadow stack semantics are
all right". If there are kernels that have shadow stack support but
with problems that make it unsafe to use (this sounds like the case),
we can't turn it on without a way to avoid trying to use it on those.

Rich

