Return-Path: <linux-fsdevel+bounces-56626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C42B19DE1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 10:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692BE1730D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E70242D72;
	Mon,  4 Aug 2025 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="d3ew3y4C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666682F2D;
	Mon,  4 Aug 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296930; cv=none; b=YSnh3GT1sQAzKENF83qHyOv+V3zT+aL7/6zU2cGBszxpzZfjypyTq3SAT6lKSg/WZCecLb/U2grL+W2NmMjd+3v1iHlwsWn/onlwaeT2W/XGZmhlLNtrGRJ/s02IIbkxnfL/AUpjewx9I6GETV6NxLFIIGKheGC+IKFbf4E0qek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296930; c=relaxed/simple;
	bh=fAlwdqLalSWQzGnJHjxgzwKR+E4wl43ZeLk3xqZ1L6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uwha3AmAUA7gnqH6snpjFMYr00w5jYDkq1CFVRItt6+toBIebqFFAgXHgVnhwwNSD/SROFHJbrmgwOOhnejvEc4ZhzN/8sZ+YEDufvHAeOOeBI/xK4R5UwKiYuZrWNP1WIHwf/V3nQKyCC//6sfjm58mRRCS+qBKwiSiZi3TnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=d3ew3y4C; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bwVRC3tJPz9tgT;
	Mon,  4 Aug 2025 10:41:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754296919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5cvOoIUvXoSA3YDvNmkVTraImUN1coRcGDWgmZ0ku8=;
	b=d3ew3y4CFKYZ+VyhNFbndX+TRRbDqEyyOElvf8iYszezLZcjM4iI59HEe5ORk8OvsLOEpS
	WikS6cICQGDoEVQuAj3pfdaPq/TcRJmue3XirL0NjyC9KNh8k3hJPDaz3RBTVJf1ip6ibg
	VBRQCMBbi1b4MqAutC4q4CEY94wl7eSUpI1MQtpnagSCPLI7Td8wTC5KOKNDY8Dn4l0ENJ
	RC4QkJWB3NqKa6JyL0sTpubQfiSInAJRb4T1eNOJ6AoWsYdZtQQEmV8/myQtaz38Pdn5vn
	29RaegynYI9FqjOl7OyBeaMUlCo/leLxpqJsCoR2ZvJIae653f2ijMpYB0TuVA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Mon, 4 Aug 2025 10:41:49 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	willy@infradead.org, linux-mm@kvack.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC v2 2/4] mm: add static huge zero folio
Message-ID: <6inodp2wabvb27ecfpqu7mzyxb6tktc4ec4sc4yatksfbl45eg@ndyi3ucvj5r2>
References: <20250724145001.487878-1-kernel@pankajraghav.com>
 <20250724145001.487878-3-kernel@pankajraghav.com>
 <87tt2rr7oj.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt2rr7oj.fsf@gmail.com>
X-Rspamd-Queue-Id: 4bwVRC3tJPz9tgT

> > This option can waste memory in small systems or systems with 64k base
> > page size. So make it an opt-in and also add an option from individual
> > architecture so that we don't enable this feature for larger base page
> > size systems.
> 
> Can you please help me understand why will there be memory waste with
> 64k base pagesize, if this feature gets enabled?
> 
> Is it because systems with 64k base pagsize can have a much larger PMD
> size then 2M and hence this static huge folio won't really get used?

Yeah, exactly. More than 2M seems to be excessive for zeroing.

> 
> Just want to understand this better. On Power with Radix MMU, PMD size
> is still 2M, but with Hash it can be 16M.
> So I was considering if we should enable this with Radix. Hence the ask
> to better understand this.

I enabled only for x86 as a part of this series to reduce the scope. But
the idea is to enable for all architectures with reasonable PMD size,
like ARM with 4k, Power with Radix MMU, etc.

Once we get the base patches up, I can follow up with enabling for those
architectures.

--
Pankaj

