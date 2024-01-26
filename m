Return-Path: <linux-fsdevel+bounces-9082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4042383DF65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 18:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF57CB21769
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFCA1EB45;
	Fri, 26 Jan 2024 17:01:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17E31EA71;
	Fri, 26 Jan 2024 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288517; cv=none; b=CSI87BxPOp20aHcWEf5qJAsXBmThoqkP3LKz0mssmMsT/OS3GS5TIEAuxMFE0GkO0F5TNfW0pZn71E0bdsHWSucY4yZMRHpesjO3LZ686RxmNQBzBgwuWPPSauve1hqSb2k0nCnJGLiajwG62+SNZhphWeCkzokUJ3/fOhVdbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288517; c=relaxed/simple;
	bh=6GPERIrZxF09zkQWtn0tgp8Ki0MeI06mRjUPdBNea5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYp6WgK6LLbppvgR2DDo2F83tBxmylasy1KWDA+ngxtPZp6cMlV4m3z8pHFnKFIdALd6sIfqi75AWrvLuLc8qakakDg8wm5D0OZk3qfRIXb75H/XTKucZCzIR4yGr3/vVFF1YzNMO4KshnMcGZ9oHurCPBDmhsnEDh8HVyoUYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56F8B1FB;
	Fri, 26 Jan 2024 09:02:38 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D4953F762;
	Fri, 26 Jan 2024 09:01:45 -0800 (PST)
Date: Fri, 26 Jan 2024 17:01:42 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 19/35] arm64: mte: Discover tag storage memory
Message-ID: <ZbPldp5j_nDHWvHJ@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-20-alexandru.elisei@arm.com>
 <5b8ce251-0790-4e2c-b5b1-0d2aeacbdd92@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b8ce251-0790-4e2c-b5b1-0d2aeacbdd92@kernel.org>

Hi Krzysztof,

On Fri, Jan 26, 2024 at 09:50:58AM +0100, Krzysztof Kozlowski wrote:
> On 25/01/2024 17:42, Alexandru Elisei wrote:
> > Allow the kernel to get the base address, size, block size and associated
> > memory node for tag storage from the device tree blob.
> > 
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts_getmaintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, use mainline), work on fork of kernel (don't, use
> mainline) or you ignore some maintainers (really don't). Just use b4 and
> all the problems go away.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
> 
> Please kindly resend and include all necessary To/Cc entries.

My mistake, the previous iteration of the series didn't include a
devicetree binding and I forgot to update the To/Cc list. Thank you for the
heads-up, hopefully you can have a look after I resend the series.

> 
> 
> > A tag storage region represents the smallest contiguous memory region that
> > holds all the tags for the associated contiguous memory region which can be
> > tagged. For example, for a 32GB contiguous tagged memory the corresponding
> > tag storage region is exactly 1GB of contiguous memory, not two adjacent
> > 512M of tag storage memory, nor one 2GB tag storage region.
> > 
> > Tag storage is described as reserved memory; future patches will teach the
> > kernel how to make use of it for data (non-tagged) allocations.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> > 
> > Changes since rfc v2:
> > 
> > * Reworked from rfc v2 patch #11 ("arm64: mte: Reserve tag storage memory").
> > * Added device tree schema (Rob Herring)
> > * Tag storage memory is now described in the "reserved-memory" node (Rob
> > Herring).
> > 
> >  .../reserved-memory/arm,mte-tag-storage.yaml  |  78 +++++++++
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.

Thank you for pointing it out, I'll move the binding to a separate patch.

Alex

