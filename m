Return-Path: <linux-fsdevel+bounces-12350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D1285E8E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D39FB23A4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A936126F25;
	Wed, 21 Feb 2024 20:18:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203D86AE6
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708546704; cv=none; b=bIpHtUBAYC3ETe0xfDZ7H5cBLi6DyWYnapjkrk8+hEy8NSPdWyMoEM6uOjwYi5sI1DVo0SZD275v31XZEwy5CTAeChPxp+W5RgWb3ddkO2dBrDqssXhhpSFwNCgCfoyT/X8RVfFOkv5PISqhqkWEHU6TyB1J2T5VmgOnMi6ahP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708546704; c=relaxed/simple;
	bh=fxZvJOJiXDTvbkMu2Yj2fcSV/FlmP4uoP83ryrj44dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+LFF8iYpeaWUiENX6+0Q9sH8Wa0/JQAr7TMI/3JfWufSariv/QqjdOfz8s9NMMYley4pEvq4OMgs6dyT5dbyWkeKUO2tnfJup3abWLs7ryRTghxZqd6Xifm5Ei4fpgr6UYXF1RagMLPiICc5HLQRQX9tqCU/CJVvvVtwoKCi9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Wed, 21 Feb 2024 15:18:37 -0500
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
Message-ID: <20240221201837.GW4163@brightrain.aerifal.cx>
References: <20240221012736.GQ4163@brightrain.aerifal.cx>
 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
 <20240221145800.GR4163@brightrain.aerifal.cx>
 <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
 <20240221175717.GS4163@brightrain.aerifal.cx>
 <f4a54297767eb098d903404cbe8860d655d79bed.camel@intel.com>
 <20240221183055.GT4163@brightrain.aerifal.cx>
 <c3085fbe10193dfe59b25bc7da776e60779b0e8c.camel@intel.com>
 <20240221190639.GU4163@brightrain.aerifal.cx>
 <e3a432c0fa9f5fe837e9d2fc7b36304709a34428.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3a432c0fa9f5fe837e9d2fc7b36304709a34428.camel@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Feb 21, 2024 at 07:22:21PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2024-02-21 at 14:06 -0500, dalias@libc.org wrote:
> > Due to arbitrarily nestable signal frames, no, this does not suffice.
> > An interrupted operation using the lock could be arbitrarily delayed,
> > even never execute again, making any call to dlopen deadlock.
> 
> Doh! Yep, it is not robust to this. The only thing that could be done
> would be a timeout in dlopen(). Which would make the whole thing just
> better than nothing.
> 
> > 
> > > 
> > 
> > It's fine to turn RDSSP into an actual emulated read of the SSP, or
> > at
> > least an emulated load of zero so that uninitialized data is not left
> > in the target register.
> 
> We can't intercept RDSSP, but it becomes a NOP by default. (disclaimer
> x86-only knowledge).

OK, then I think the contract just has to be that userspace, in a
process that might dynamically disable shadow stack, needs to do
something like xor %reg,%reg before rdssp so that the outcome is
deterministic in disabled case.

> >  If doing the latter, code working with the
> > shadow stack just needs to be prepared for the possibility that it
> > could be async-disabled, and check the return value.
> > 
> > I have not looked at all the instructions that become #UD but I
> > suspect they all have reasonable trivial ways to implement a
> > "disabled" version of them that userspace can act upon reasonably.
> 
> This would have to be thought through functionally and performance
> wise. I'm not opposed if can come up with a fully fleshed out plan. How
> serious are you in pursuing musl support, if we had something like
> this?

Up til this thread, my position was pretty much "nope" because it
looked like it could not be done in a way compatible with existing
interface requirements.

However, what's been discussed here, contingent on a dynamic-disable
(ideally allowing choice of per-thread or global, to minimize loss of
hardening properties),

Personally, I believe shadow stack has very low hardening value
relative to cost/complexity, and my leaning would be just to ignore
it. However, I also know it becomes marketing pressure, including
pressure on distros that use musl -- "Why doesn't [distro] do shadow
stack?? I thought you were security oriented!!!" -- and if it can be
done in a non-breaking and non-invasive way, I think it's reasonable
to pursue and make something work.

> HJ, any thoughts on whether glibc would use this as well?
> 
> It is probably worth mentioning that from the security side (as Mark
> mentioned there is always tension in the tradeoffs on these features),
> permissive mode is seen by some as something that weakens security too
> much. Apps could call dlopen() on a known unsupported DSO before doing
> ROP. I don't know if you have any musl users with specific shadow stack
> use cases to ask about this.

Yes, this is potentially an argument for something like the option 2,
if there's a way to leave SS enabled but then trap when something goes
wrong, detect if it went wrong via SS-incompatible library code, and
lazily disable SS, otherwise terminate.

But I just realized, I'm not even sure why shared libraries need to be
explicitly SS-compatible. Unless they're doing their own asm stack
switches, shouldn't they just work by default? And since I don't
understand this reason, I also don't understand what the failure mode
is when an incompatible library is loaded, and thus whether it would
be possible to detect and attribute the failure to the library, or
whether the library would induce failure somewhere else.

Anyway, a mechanism to allow the userspace implementation to disable
SS doesn't inherently expose a means to do that. A system integrator
doing maximum hardening might choose to build all libraries as
SS-compatible, or to patch the loader to refuse to load incompatible
libraries.

Rich

