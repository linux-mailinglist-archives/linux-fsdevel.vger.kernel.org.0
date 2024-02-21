Return-Path: <linux-fsdevel+bounces-12298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F204D85E507
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CEE1C241B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5785260;
	Wed, 21 Feb 2024 17:57:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE081737
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538225; cv=none; b=Wed/RiXHzqqAZaW1yU29kmnHrb46YdM9n7Bkw0V1g8IcN6sKMFN5T/tn3MCAhS6aMPPiF0ESdcHkSF+ib/PbM3y2EsfSfS23Pn9H8IgfIc8SgktZZ92qFwPpe5HjsmTOUPacKH/phs6kFUUBFmt4JKqn7jrjRw5XAefB6drM0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538225; c=relaxed/simple;
	bh=+QLcuEiiCvBLANsK9jrSNNm+hbOucpscqS9eo+SVwXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyQYvJQ00awgNlVSYijFi8L2I72G+IPDpTadoTdCOlU2VIuT35WTlTjlc3GAG3KMMbIDYz/iP3vfqOETnEIFPxz2ybmGctVa8BQsh3DRS1z3LunA3DtEtgBV4NAvbGlmqh0xvMn1b9T99zyhW8FOo9PsUao5daiR8QFKkVU5AK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Wed, 21 Feb 2024 12:57:19 -0500
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
Message-ID: <20240221175717.GS4163@brightrain.aerifal.cx>
References: <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
 <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
 <20240220235415.GP4163@brightrain.aerifal.cx>
 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
 <20240221012736.GQ4163@brightrain.aerifal.cx>
 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
 <20240221145800.GR4163@brightrain.aerifal.cx>
 <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Feb 21, 2024 at 05:36:12PM +0000, Mark Brown wrote:
> On Wed, Feb 21, 2024 at 09:58:01AM -0500, dalias@libc.org wrote:
> > On Wed, Feb 21, 2024 at 01:53:10PM +0000, Mark Brown wrote:
> > > On Tue, Feb 20, 2024 at 08:27:37PM -0500, dalias@libc.org wrote:
> > > > On Wed, Feb 21, 2024 at 12:35:48AM +0000, Edgecombe, Rick P wrote:
> 
> > > > > (INCSSP, RSTORSSP, etc). These are a collection of instructions that
> > > > > allow limited control of the SSP. When shadow stack gets disabled,
> > > > > these suddenly turn into #UD generating instructions. So any other
> > > > > threads executing those instructions when shadow stack got disabled
> > > > > would be in for a nasty surprise.
> 
> > > > This is the kernel's problem if that's happening. It should be
> > > > trapping these and returning immediately like a NOP if shadow stack
> > > > has been disabled, not generating SIGILL.
> 
> > > I'm not sure that's going to work out well, all it takes is some code
> > > that's looking at the shadow stack and expecting something to happen as
> > > a result of the instructions it's executing and we run into trouble.  A
> 
> > I said NOP but there's no reason it strictly needs to be a NOP. It
> > could instead do something reasonable to convey the state of racing
> > with shadow stack being disabled.
> 
> This feels like it's getting complicated and I fear it may be an uphill
> struggle to get such code merged, at least for arm64.  My instinct is
> that it's going to be much more robust and generally tractable to let
> things run to some suitable synchronisation point and then disable
> there, but if we're going to do that then userspace can hopefully
> arrange to do the disabling itself through the standard disable
> interface anyway.  Presumably it'll want to notice things being disabled
> at some point anyway?  TBH that's been how all the prior proposals for
> process wide disable I've seen were done.

If it's possible to disable per-thread rather than per-process, some
things are easier. Disabling on account of using alt stacks only needs
to be done on the threads using those stacks. However, for dlopen
purposes you need a way to disable shadow stack for the whole process.
Initially this is only needed for the thread that called dlopen, but
it needs to have propagated to any thread that synchronizes with
completion of the call to dlopen by the time that synchronization
occurs, and since that synchronization can happen in lots of different
ways that are purely userspace (thanks to futexes being userspace in
the uncontended case), I don't see any way to make it work without
extremely invasive, high-cost checks.

If folks on the kernel side are not going to be amenable to doing the
things that are easy for the kernel to make it work without breaking
compatibility with existing interfaces, but that are impossible or
near-impossible for userspace to do, this seems like a dead-end. And I
suspect an operation to "disable shadow stack, but without making
threads still in SS-critical sections crash" is going to be
necessary..

Rich

