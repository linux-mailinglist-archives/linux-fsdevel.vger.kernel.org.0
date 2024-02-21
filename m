Return-Path: <linux-fsdevel+bounces-12310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE26B85E6F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595FEB24214
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA7085C68;
	Wed, 21 Feb 2024 19:10:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF0985951
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542625; cv=none; b=OIVoBxzZ5VcDMiY1p6HG6RIfhfeVvD01YCHcWn6qVEdHjzMN24wv86burkaJrFfe2GSpHZ6fzTawCm8wyhI7hvSFYqhUrR047Ay9WB4kS7BhlxzthzpbkSVj8zlJRe+HOWRWqMkJcYfggIPJOgLoQIh9QwKPBi0j0jPPQuFAtz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542625; c=relaxed/simple;
	bh=AgMVTJXzONHGG61D+D+o9DyLBW2kW1yf8Ip12DuoGAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W93nx5QmJtWwFoVsredQgjQ27HcRmQb4t2M7Vl1Os2jOFQz9sRM4joeqNt2vRc785Lfcw1R9qY5L/0Oidfx1PvfSPF5uxEvj1sovC0dvktBTAT2mD7+6tIkPts0L/Ej78Y3i+2S8JRJFwuvhd7sp4yus9BkSBvFfRYqUFY76FGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Wed, 21 Feb 2024 14:10:39 -0500
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
Message-ID: <20240221191039.GV4163@brightrain.aerifal.cx>
References: <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
 <20240220235415.GP4163@brightrain.aerifal.cx>
 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
 <20240221012736.GQ4163@brightrain.aerifal.cx>
 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
 <20240221145800.GR4163@brightrain.aerifal.cx>
 <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
 <20240221175717.GS4163@brightrain.aerifal.cx>
 <b41e39d1-29f9-4958-9728-6781e72230f8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41e39d1-29f9-4958-9728-6781e72230f8@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Feb 21, 2024 at 06:32:20PM +0000, Mark Brown wrote:
> On Wed, Feb 21, 2024 at 12:57:19PM -0500, dalias@libc.org wrote:
> > On Wed, Feb 21, 2024 at 05:36:12PM +0000, Mark Brown wrote:
> 
> > > This feels like it's getting complicated and I fear it may be an uphill
> > > struggle to get such code merged, at least for arm64.  My instinct is
> > > that it's going to be much more robust and generally tractable to let
> > > things run to some suitable synchronisation point and then disable
> > > there, but if we're going to do that then userspace can hopefully
> > > arrange to do the disabling itself through the standard disable
> > > interface anyway.  Presumably it'll want to notice things being disabled
> > > at some point anyway?  TBH that's been how all the prior proposals for
> > > process wide disable I've seen were done.
> 
> > If it's possible to disable per-thread rather than per-process, some
> > things are easier. Disabling on account of using alt stacks only needs
> 
> Both x86 and arm64 currently track shadow stack enablement per thread,
> not per process, so it's not just possible to do per thread it's the
> only thing we're currently implementing.  I think the same is true for
> RISC-V but I didn't look as closely at that yet.

That's nice! It allows still keeping part of the benefit of SS in
programs which have some threads running with custom stacks. We do
however need a global-disable option for dlopen. In musl this could be
done via the same mechanism ("synccall") used for set*id -- it's
basically userspace IPI. But just having a native operation would be
nicer, and would probably help glibc where I don't think they
abstracted their set*id mechanism to do other things like this.

> > If folks on the kernel side are not going to be amenable to doing the
> > things that are easy for the kernel to make it work without breaking
> > compatibility with existing interfaces, but that are impossible or
> > near-impossible for userspace to do, this seems like a dead-end. And I
> > suspect an operation to "disable shadow stack, but without making
> > threads still in SS-critical sections crash" is going to be
> > necessary..
> 
> Could you be more specific as to the easy things that you're referencing
> here?

Basically the ARCH_SHSTK_SUPPRESS_UD proposal.

Rich

