Return-Path: <linux-fsdevel+bounces-49673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF07AC0BAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 14:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D93D1727EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD8528AB03;
	Thu, 22 May 2025 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="up2GNasg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E423BCFD;
	Thu, 22 May 2025 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917297; cv=none; b=R2yBVuab/rnQVtf5i3v3BGxU7yfypGV+sMPWXbBn6747wtyns0HNso2iaaWv7iDc+2GUIctb5UePQTdVtqd5WOMtSlWly5YDly22MC0ExyyuAir6+ZTZ5h4RBDQZ1EyXE94759TyNnQcB+K/N9Q1C+eEasLxW/ix8UTRThfv80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917297; c=relaxed/simple;
	bh=zuUuuT8g4nMcnZMyuczg5ZlUGdfap0P36vBvj+Q0H0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvlGlgHL4Iwi1z0WLSsTUzS0+WLMA8efTl9EIlbpHZzq9wukkCgOPN2pgUADR5fG04LsqpKVg1j2lXvnlhYDHIGgxGd3hOZkklVnREogaa59OR6wldBLwkRwWH4hh+NlcuGZfKYs3VGSD+JuIemmm8KbSJXYMGqa0qKm7HKvYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=up2GNasg; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4b37636VZDz9tR0;
	Thu, 22 May 2025 14:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1747917292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X4r3LzcAMV1o5DnD3H0c6VjFoCQr5eC95fIHbTY0YYc=;
	b=up2GNasgSe2xnAXQsq8fTadg0OIhaLAnTlDMqNp3xxWXcE5EMzoqPVuI7RAIwUU6mk90IP
	ikVtAwdyZhmon4woPQnJVmHB3CBgnBeM4ohYZW8DRYDfMO/yXiRYHHVS6xHFtoSLkyD8fA
	RYPJpxpFO9jnM8cf0XS2zU15FYrwFsTJYz56lLQHW/7lbeSKBYiGJBgWockOr4H8hlWPMS
	dg7kKh8D7dQHjOr+zDyVw0G28F7yThkajDdpHlnPaCIfSLffrXsy0T2j4yH6K007ujUaZv
	CPQfoheI/FMHLvA5uavru89OhQc1/Q1FilTc3/nGT6qUlCCVpQUJGlZkPY5fAg==
Date: Thu, 22 May 2025 14:34:43 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Ryan Roberts <ryan.roberts@arm.com>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Zi Yan <ziy@nvidia.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, gost.dev@samsung.com, hch@lst.de, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, x86@kernel.org, mcgrof@kernel.org
Subject: Re: [RFC v2 0/2] add THP_HUGE_ZERO_PAGE_ALWAYS config option
Message-ID: <625s5hffr3iz35uv4hts4sxpprwwuxxpbsmbvasy24cthlsj6x@tg2zqm6v2wqm>
References: <20250522090243.758943-1-p.raghav@samsung.com>
 <aC8LGDwJXvlDl866@kernel.org>
 <6lhepdol4nlnht7elb7jx7ot5hhckiegyyl6zeap2hmltdwb5t@ywsaklwnakuh>
 <6894a8b1-a1a7-4a35-8193-68df3340f0ad@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6894a8b1-a1a7-4a35-8193-68df3340f0ad@redhat.com>
X-Rspamd-Queue-Id: 4b37636VZDz9tR0

Hi David,

> >   config ARCH_WANTS_THP_SWAP
> >          def_bool n
> > -config ARCH_WANTS_THP_ZERO_PAGE_ALWAYS
> > +config ARCH_WANTS_HUGE_ZERO_PAGE_ALWAYS
> >          def_bool n
> > +config HUGE_ZERO_PAGE_ALWAYS
> 
> Likely something like
> 
> PMD_ZERO_PAGE
> 
> Will be a lot clearer.

Sounds much better :)

> 
> > +       def_bool y> +       depends on HUGETLB_PAGE &&
> ARCH_WANTS_HUGE_ZERO_PAGE_ALWAYS
> 
> I suspect it should then also be independent of HUGETLB_PAGE?

You are right. So we don't depend on any of these features.

> 
> > +       help
> > +         Typically huge_zero_folio, which is a huge page of zeroes, is allocated
> > +         on demand and deallocated when not in use. This option will always
> > +         allocate huge_zero_folio for zeroing and it is never deallocated.
> > +         Not suitable for memory constrained systems.
> 
> I assume that code then has to live in mm/memory.c ?

Hmm, then huge_zero_folio should have always been in mm/memory.c to
begin with?

I assume probably this was placed in mm/huge_memory.c because the users
of this huge_zero_folio has been a part of mm/huge_memory.c?

So IIUC your comment, we should move the huge_zero_page_init() in the
first patch to mm/memory.c and the existing shrinker code can be a part
where they already are?

--
Pankaj

