Return-Path: <linux-fsdevel+bounces-55794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05930B0EE10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 11:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABA21C24456
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 09:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C955E283FC3;
	Wed, 23 Jul 2025 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="u6gZzA5G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386229408;
	Wed, 23 Jul 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261726; cv=none; b=t2oh9hHEjNsD9nbVA2xMExoa9k1EIpbBKO8rc/KyR1bUnKa2KZzFhGgNcZapWNuHj45IyHvBHLBGIOauDX/1JHcAyoo1Q0aSs0sew0Yaw4UQm3A7kYpkfYr82J0nqhlQOwfXFyYLiHyqBKy/mLhdXreP9gGXL/z1NJtvI5SIDYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261726; c=relaxed/simple;
	bh=1CIic0hpNip2B7QAdnbKaQVtpQHY9JGyHE2umzIOkvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmdTZce+7DBRi5qTLfzrfFwVKUQ+zwzRDdQiP//jLsf9t7ROy3IpFBO7lZDFJ3yWEQnXnXO0e/qx/DTL8ep1sgXP+2C5rYwgjDoUEJLRv9UnX7SMANLi1mMu1g8a5AECFwhmSD1yde/Nf46KPwneC55UP+4AthSneiVKnsWfHvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=u6gZzA5G; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bn7bW451Pz9t8S;
	Wed, 23 Jul 2025 11:08:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1753261719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOKShWyoy6jXvtzkZANxNISGUx+8cVqAN/UfQ1f8cYY=;
	b=u6gZzA5GksvaoP9cxb48nlrs5FpzaMj2hPOcyVcmBc8EuIohxGTkhBQXTKG56Op47pBC48
	7oz+I7hsf/5RDixMmvJVA/p0LAnpsP7+ejws+6mTe3h22Vl4U2mXAB/UPTWLgMONAas2Aw
	7N4+p+P1awZLT3fdaFBZ9t+3YXqQYDXqzw3Skz+rGH1jQIqLRPrLua+sTvaHMFcrNN9Gns
	n5aoWmp6B+USvzhS0fjCdvrKXj65/jvJWIkngC1gyFZyyZq4QFoizpEI3E6nu2n2jLMTEX
	KMGUTHsMyxtqKoBFbeugz7JNoRvEfhHxhUFrx9I8gatwbK6qeb0r5fL4qEG7wA==
Date: Wed, 23 Jul 2025 11:08:23 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC 0/4] add static huge zero folio support
Message-ID: <vocblxknnal2t4756bkqcdajt2gkctp2wdjhfg3xkp66j47qk3@saj77wmrflqz>
References: <20250722094215.448132-1-kernel@pankajraghav.com>
 <e6648680-da88-4f01-9811-00229da858e6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6648680-da88-4f01-9811-00229da858e6@redhat.com>

> > 
> > I will send patches to individual subsystems using the huge_zero_folio
> > once this gets upstreamed.
> > 
> > Looking forward to some feedback.
> 
> Please run scripts/checkpatch.pl on your patches.
> 
> There are quite some warning for patch #2 and #3, in particular, around
> using spaces vs. tabs.

Ah, you are right. I usually run it as a post-commit hook but I forgot
to add it when I changed my workflow.

Thanks for pointing it out. I also got a unused variable warning for huge_zero_static_fail_count
as we don't use it when CONFIG_STATIC_HUGE_ZERO_FOLIO is disabled.

I will change them in the new version.

--
Pankaj

