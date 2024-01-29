Return-Path: <linux-fsdevel+bounces-9358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A9840412
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBFD1C21FD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D90E5DF1E;
	Mon, 29 Jan 2024 11:46:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8685EE7C;
	Mon, 29 Jan 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528814; cv=none; b=H5lzNEHynxF+RD3IV40BftfqtUygCiJIY8SsI44Lv3iXmeagQQDm57znPWrYTvzOiu2SOoLfMrdY7TPv50bsFNBCEU7dGppp1zJYOLT6YFVDxYRd1+8iTeKeB9sG4dvoSxTcQtkg5aMQYWXvzkRVR4Ic04PRMB4QMkgBsmOpdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528814; c=relaxed/simple;
	bh=UHoui6zpUi+y4RxzG3lPZBjUPZGN2V5L8s82iND4ksY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWDnxv4H4SIN0uovPDQP/Ucvqp2xOOET8opxoO51IfoxwDSNYex00zYHInoPb3XzedgmwC3limruSJtd47QJ0qAHahRbcAHXjGbl+A9Lcy6dyBj7c8p0gJX3I6WcL52jyoDQyAyO3zQRptcbhg5oY5WqheBHwAPRI/+RxCeYwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 824181FB;
	Mon, 29 Jan 2024 03:47:35 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F77E3F5A1;
	Mon, 29 Jan 2024 03:46:46 -0800 (PST)
Date: Mon, 29 Jan 2024 11:46:43 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, vincenzo.frascino@arm.com, david@redhat.com,
	eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 05/35] mm: cma: Don't append newline when
 generating CMA area name
Message-ID: <ZbeQI-sMvJMLw7g7@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-6-alexandru.elisei@arm.com>
 <8b5dfed3-f881-4f0a-be81-d7fcf3be0deb@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b5dfed3-f881-4f0a-be81-d7fcf3be0deb@arm.com>

Hi,

On Mon, Jan 29, 2024 at 02:43:08PM +0530, Anshuman Khandual wrote:
> 
> On 1/25/24 22:12, Alexandru Elisei wrote:
> > cma->name is displayed in several CMA messages. When the name is generated
> > by the CMA code, don't append a newline to avoid breaking the text across
> > two lines.
> 
> An example of such mis-formatted CMA output from dmesg could be added
> here in the commit message to demonstrate the problem better.
> 
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> 
> Regardless, LGTM.
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks!

> 
> > 
> > Changes since rfc v2:
> > 
> > * New patch. This is a fix, and can be merged independently of the other
> > patches.
> 
> Right, need not be part of this series. Hence please send it separately to
> the MM list.

Will do!

Alex

> 
> > 
> >  mm/cma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/cma.c b/mm/cma.c
> > index 7c09c47e530b..f49c95f8ee37 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -204,7 +204,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
> >  	if (name)
> >  		snprintf(cma->name, CMA_MAX_NAME, name);
> >  	else
> > -		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
> > +		snprintf(cma->name, CMA_MAX_NAME,  "cma%d", cma_area_count);
> >  
> >  	cma->base_pfn = PFN_DOWN(base);
> >  	cma->count = size >> PAGE_SHIFT;

