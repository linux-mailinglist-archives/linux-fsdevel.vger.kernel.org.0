Return-Path: <linux-fsdevel+bounces-12273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAD485E060
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 15:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FE81F24A7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8947FBCD;
	Wed, 21 Feb 2024 14:57:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473867FBA7
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527468; cv=none; b=YHchI7S8BAn5vQwILdL+Trd3dUcN71OSrMlT4E9EAJGmkGonzDvNd6ovOTy4CApO46Nv+5TRkSSU+6PDRd+dogCjdphWKobvrimdQXAUnXWTWaARnZBCuh8S7hMzF9MPKJmZogo2t8Z1poPdyEXLQFLqd+RIpAbQ5WhUlzgYMKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527468; c=relaxed/simple;
	bh=VXm+kZmxMVHqvGGNho4lRaBPvFnNMXrsUkhaZtCVkdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di+Ph33/9JeP4ALbeKH/nteq+3JqDV4ThjtqH9emARidu3obJZKnTZ6LQ/AfmrvZbXi99bmQ14l+B9jpfL0t9wBVDY03RS2xEjZPv7E0ulhBrMDklvjf1iGBCamM/ZPbKnCK198k9kNEnqB3LS3eOFxGk6/DK17wTzGBt5aEWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Wed, 21 Feb 2024 09:58:01 -0500
From: "dalias@libc.org" <dalias@libc.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
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
Message-ID: <20240221145800.GR4163@brightrain.aerifal.cx>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
 <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
 <20240220235415.GP4163@brightrain.aerifal.cx>
 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
 <20240221012736.GQ4163@brightrain.aerifal.cx>
 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Feb 21, 2024 at 01:53:10PM +0000, Mark Brown wrote:
> On Tue, Feb 20, 2024 at 08:27:37PM -0500, dalias@libc.org wrote:
> > On Wed, Feb 21, 2024 at 12:35:48AM +0000, Edgecombe, Rick P wrote:
> 
> > > (INCSSP, RSTORSSP, etc). These are a collection of instructions that
> > > allow limited control of the SSP. When shadow stack gets disabled,
> > > these suddenly turn into #UD generating instructions. So any other
> > > threads executing those instructions when shadow stack got disabled
> > > would be in for a nasty surprise.
> 
> > This is the kernel's problem if that's happening. It should be
> > trapping these and returning immediately like a NOP if shadow stack
> > has been disabled, not generating SIGILL.
> 
> I'm not sure that's going to work out well, all it takes is some code
> that's looking at the shadow stack and expecting something to happen as
> a result of the instructions it's executing and we run into trouble.  A
> lot of things won't notice and will just happily carry on but I expect
> there are going to be things that care.  We also end up with an
> additional state for threads that have had shadow stacks transparently
> disabled, that's managable but still.

I said NOP but there's no reason it strictly needs to be a NOP. It
could instead do something reasonable to convey the state of racing
with shadow stack being disabled.

> 
> > > > The place where it's really needed to be able to allocate the shadow
> > > > stack synchronously under userspace control, in order to harden
> > > > normal
> > > > applications that aren't doing funny things, is in pthread_create
> > > > without a caller-provided stack.
> 
> > > Yea most apps don't do anything too tricky. Mostly shadow stack "just
> > > works". But it's no excuse to just crash for the others.
> 
> > One thing to note here is that, to enable this, we're going to need
> > some way to detect "new enough kernel that shadow stack semantics are
> > all right". If there are kernels that have shadow stack support but
> > with problems that make it unsafe to use (this sounds like the case),
> > we can't turn it on without a way to avoid trying to use it on those.
> 
> If we have this automatic conversion of pages to shadow stack then we
> should have an API for enabling it, userspace should be able to use the
> presence of that API to determine if the feature is there.

Yes, or if a new prctl is needed to make disabling safe (see above)
that could probably be used.

Rich

