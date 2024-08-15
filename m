Return-Path: <linux-fsdevel+bounces-26064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A8695307C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2599F1C2504A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDD719F471;
	Thu, 15 Aug 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="nzgwInHZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450F1198E78;
	Thu, 15 Aug 2024 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729408; cv=none; b=R3SB0/iCYIn+BBhft6KB5+sGItdIgPolOQK0UZd3J7+0O//iL+0ZVLz1Sr6bAr3MdeH3okWPshMW9wrBDIbPs3cwXgLQrm/v1iQW9cBLjVqViZRmHKdwerD+wXMQqU01Kf2E+2Oq+7Hxm3rAwLotbVAfvGg3OVho+QvExJ+n4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729408; c=relaxed/simple;
	bh=Ph4FtNVKoaw0OcMp+awfgaGWGwBkaALXj3ATCIi+uXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKhYBpGBjaskRCuNErFq2/INDxnyFc2CNjVPKZkn4XC4uR+0hZmliqkOd+85mKZpJriByyxq8cPmivaQcqg7peJKVZPVVaAqlq+auMzyrr6F5Ip4Y+bAa/LRAUdBilKGRcsjsDkVlO6a29rEVkuJAxiPOGLo5WzmENmYOWfsPXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=nzgwInHZ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Wl5tL0xQDz9shW;
	Thu, 15 Aug 2024 15:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1723729402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Hpq6ksyDyUHd4So1QZsJOGGQCrhZxE48p6ibJ33Odk=;
	b=nzgwInHZh2zeO0XU7LkZpRjNksVr9RPBAtBO6uSA0SBZSI6osMxGbjzKZeUGCqgcFLM1U9
	Yf6SUO2S5rhtQdG2BGJeY0mcm2vGlEH51AcB8HO1QcIaDM1tya/vrNGGnT4vBmGnJiuovv
	izOVHYDETMo7KAZfZBl0lxZDGzeLV37X7QARxem5/QDu+VeSijdCV4E7TVMveIMLn5kYJl
	rVE8mFs6a+HgbcO2jmWNHwB0OP8sEfCkzU+UddH1/GtWXsH729UGALyOy0ZsC58q+XPZwz
	EAxMTmPZUKrYOUWa5qaTQ56aq2xwWR80CwgAFTCsboURZZ7II2R5KuQPFgFsQg==
Date: Thu, 15 Aug 2024 13:43:16 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, agordeev@linux.ibm.com,
	akpm@linux-foundation.org, borntraeger@linux.ibm.com,
	corbet@lwn.net, frankja@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
	imbrenda@linux.ibm.com, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, svens@linux.ibm.com,
	willy@infradead.org
Subject: Re: [PATCH v1 07/11] mm/huge_memory: convert split_huge_pages_pid()
 from follow_page() to folio_walk
Message-ID: <20240815134316.h4l4wohtgm2oz2uo@quentin>
References: <20240802155524.517137-8-david@redhat.com>
 <20240815100423.974775-1-p.raghav@samsung.com>
 <6938b43c-ec61-46f1-bccc-d1b8f6850253@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6938b43c-ec61-46f1-bccc-d1b8f6850253@redhat.com>
X-Rspamd-Queue-Id: 4Wl5tL0xQDz9shW

On Thu, Aug 15, 2024 at 12:20:04PM +0200, David Hildenbrand wrote:
> On 15.08.24 12:04, Pankaj Raghav wrote:
> > Hi David,
> > 
> > On Fri, Aug 02, 2024 at 05:55:20PM +0200, David Hildenbrand wrote:
> > >   			continue;
> > >   		}
> > > -		/* FOLL_DUMP to ignore special (like zero) pages */
> > > -		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> > > -
> > > -		if (IS_ERR_OR_NULL(page))
> > > +		folio = folio_walk_start(&fw, vma, addr, 0);
> > > +		if (!folio)
> > >   			continue;
> > > -		folio = page_folio(page);
> > >   		if (!is_transparent_hugepage(folio))
> > >   			goto next;
> > > @@ -3544,13 +3542,19 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
> > >   		if (!folio_trylock(folio))
> > >   			goto next;
> > > +		folio_get(folio);
> > 
> > Shouldn't we lock the folio after we increase the refcount on the folio?
> > i.e we do folio_get() first and then folio_trylock()?
> > 
> > That is how it was done before (through follow_page) and this patch changes
> > that. Maybe it doesn't matter? To me increasing the refcount and then
> > locking sounds more logical but I do see this ordering getting mixed all
> > over the kernel.
> 
> There is no need to grab a folio reference if we hold an implicit reference
> through the mapping that cannot go away (not that we hold the page table
> lock). Locking the folio is not special in that regard: we just have to make
> sure that the folio cannot get freed concurrently, which is the case here.
> 
> So here, we really only grab a reference if we have to -- when we are about
> to drop the page table lock and will continue using the folio afterwards.
Got it. Thanks!
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

