Return-Path: <linux-fsdevel+bounces-12174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C1085C41A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 19:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BB91F23F2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82641133422;
	Tue, 20 Feb 2024 18:57:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDD77652
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455434; cv=none; b=FfVF+ja+EksC72/4VVi/nwh0AWAYQyrHvC3fQ/tDsibZRCSr4Jex5IfLK/RATtPnwQBjiHDgfFpF+tNraH3svQBEK+7SvPCLfbS9F8Zq7Fg1cjAmV0xL44C9IKowD905778uSEB6fpqe/18WasWSU8gp6MveRO44CnNC7A/85Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455434; c=relaxed/simple;
	bh=2AJMM3Na6vVTLu4s6ylsknzzYTfPF0vFcwg0MnVpps4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1HCdLorff6TwYtx7Ou1ZsB9MR7hGeMZ0FBIimhJ3sFAGuJ+fPj14o40AHRqrP72e4k02852HMb6hD26vrPGRw9QCIWsQUM4pSNKRIKyVH5Ppk7Zl+rXl657VsOPeEFeh/68wXl1rIiJrTxLExf7w2vC8/59F65LwU3VxS1+ApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Tue, 20 Feb 2024 13:57:15 -0500
From: Rich Felker <dalias@libc.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"will@kernel.org" <will@kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"sorear@fastmail.com" <sorear@fastmail.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Message-ID: <20240220185714.GO4163@brightrain.aerifal.cx>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Feb 20, 2024 at 06:41:05PM +0000, Edgecombe, Rick P wrote:
> Hi,
> 
> I worked on the x86 kernel shadow stack support. I think it is an
> interesting suggestion. Some questions below, and I will think more on
> it.
> 
> On Tue, 2024-02-20 at 11:36 -0500, Stefan O'Rear wrote:
> > While discussing the ABI implications of shadow stacks in the context
> > of
> > Zicfiss and musl a few days ago, I had the following idea for how to
> > solve
> > the source compatibility problems with shadow stacks in POSIX.1-2004
> > and
> > POSIX.1-2017:
> > 
> > 1. Introduce a "flexible shadow stack handling" option.  For what
> > follows,
> >    it doesn't matter if this is system-wide, per-mm, or per-vma.
> > 
> > 2. Shadow stack faults on non-shadow stack pages, if flexible shadow
> > stack
> >    handling is in effect, cause the affected page to become a shadow
> > stack
> >    page.  When this happens, the page filled with invalid address
> > tokens.
> 
> Hmm, could the shadow stack underflow onto the real stack then? Not
> sure how bad that is. INCSSP (incrementing the SSP register on x86)
> loops are not rare so it seems like something that could happen.

Shadow stack underflow should fault on attempt to access
non-shadow-stack memory as shadow-stack, no?

> >    Faults from non-shadow-stack accesses to a shadow-stack page which
> > was
> >    created by the previous paragraph will cause the page to revert to
> >    non-shadow-stack usage, with or without clearing.
> 
> Won't this prevent catching stack overflows when they happen? An
> overflow will just turn the shadow stack into normal stack and only get
> detected when the shadow stack unwinds?

I don't think that's as big a problem as it sounds like. It might make
pinpointing the spot at which things went wrong take a little bit more
work, but it should not admit any wrong-execution.

> A related question would be how to handle the expanding nature of the
> initial stack. I guess the initial stack could be special and have a
> separate shadow stack.

That seems fine.

> >    Important: a shadow stack operation can only load a valid address
> > from
> >    a page if that page has been in continuous shadow stack use since
> > the
> >    address was written by another shadow stack operation; the
> > flexibility
> >    delays error reporting in cases of stray writes but it never
> > allows for
> >    corruption of shadow stack operation.
> 
> Shadow stacks currently have automatic guard gaps to try to prevent one
> thread from overflowing onto another thread's shadow stack. This would
> somewhat opens that up, as the stack guard gaps are usually maintained
> by userspace for new threads. It would have to be thought through if
> these could still be enforced with checking at additional spots.

I would think the existing guard pages would already do that if a
thread's shadow stack is contiguous with its own data stack.

> > 3. Standards-defined operations which use a user-provided stack
> >    (makecontext, sigaltstack, pthread_attr_setstack) use a subrange
> > of the
> >    provided stack for shadow stack storage.  I propose to use a
> > shadow
> >    stack size of 1/32 of the provided stack size, rounded up to a
> > positive
> >    integer number of pages, and place the shadow stack allocation at
> > the
> >    lowest page-aligned address inside the provided stack region.
> > 
> >    Since page usage is flexible, no change in page permissions is
> >    immediately needed; this merely sets the initial shadow stack
> > pointer for
> >    the new context.
> > 
> >    If the shadow stack grew in the opposite direction to the
> > architectural
> >    stack, it would not be necessary to pick a fixed direction.
> > 
> > 4. SIGSTKSZ and MINSIGSTKSZ are increased by 2 pages to provide
> > sufficient
> >    space for a minimum-sized shadow stack region and worst case
> > alignment.
> 
> Do all makecontext() callers ensure the size is greater than this?
> 
> I guess glibc's makecontext() could do this scheme to prevent leaking
> without any changes to the kernel. Basically steal a little of the
> stack address range and overwrite it with a shadow stack mapping. But
> only if the apps leave enough room. If they need to be updated, then
> they could be updated to manage their own shadow stacks too I think.

From the musl side, I have always looked at the entirely of shadow
stack stuff with very heavy skepticism, and anything that breaks
existing interface contracts, introduced places where apps can get
auto-killed because a late resource allocation fails, or requires
applications to code around the existence of something that should be
an implementation detail, is a non-starter. To even consider shadow
stack support, it must truely be fully non-breaking.

> > _Without_ doing this, sigaltstack cannot be used to recover from
> > stack
> > overflows if the shadow stack limit is reached first, and makecontext
> > cannot be supported without memory leaks and unreportable error
> > conditions.
> 
> FWIW, I think the makecontext() shadow stack leaking is a bad idea. I
> would prefer the existing makecontext() interface just didn't support
> shadow stack, rather than the leaking solution glibc does today.

AIUI the proposal by Stefan makes it non-leaking because it's just
using normal memory that reverts to normal usage on any
non-shadow-stack access.

Rich

