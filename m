Return-Path: <linux-fsdevel+bounces-56623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD0DB19DC3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 10:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8696179186
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E6B242D6F;
	Mon,  4 Aug 2025 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="tQIosnnf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4A1E9B22;
	Mon,  4 Aug 2025 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296642; cv=none; b=IY0zYLsQ5KBb07qcjMuqexfzr6eUpEZaKLbrlp1lwUvZRGuMPBFGVDAxB6+i93wOlCLEZ4G1sTruJie1mXePZ8a83K2likRaqY5oRJ5Nic3PMrDcsthns7z2gnOXdIFkDn77x8krJEPyLRE11ye1aqeONTfJd9BP3LSYUfHML7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296642; c=relaxed/simple;
	bh=HIXk4+TAbrKiQuY/qIcBcH+nKJgvbBjd1RaFeR0UKwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alW1VrhioigaEm2fAFVjVn9j6CGmvYYdZA4UdmU/ltKqUvCbKLh3vIfhiL+2E4ONXxo1U/jxN9zn3L7QChitM063am6L0Z83JHkC355+GprJ0DSlRlt3FhzguMnzDwmskaolpfZ7Mc/JBtF3CMNn2qccSnmzheM5ODEWknL5RP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=tQIosnnf; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bwVKf31nCz9sxm;
	Mon,  4 Aug 2025 10:37:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754296630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wPJnPv1bn5Li9I/0MOxjuiNX4rqaManwCgRKuRDtlQ=;
	b=tQIosnnfJQ37NBK6nScKmwmL/r2DsnOlMH8NmKwU/1J+eiAE8TIF/z/4vRRMBiXWL9OhAs
	Ev3sNf1iILxDYEV27e320oPn8umOlMIt6ywe0tFVSMBmakfOSZkEOotKPLOxsWsnsDZ1VB
	CsQshtiJmUg9dq7RvfYFsVH9rZMVlC3u15dB1eolZJrLOASd2fFncxcTgJrGAfigKokZDo
	gys9bNHNBOlK+176OkV886HR7vQF2uqIrJVNyLf8ECIQfGBcJgg1kQOo9Ok5CKz6z/C8Iu
	xVAa/fv1eyE1jqdOng8qoE26TuCp4oqzCYXRIIWObZ+G/nyeN54b8uJufuVUmw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Mon, 4 Aug 2025 10:36:57 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	willy@infradead.org, linux-mm@kvack.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC v2 1/4] mm: rename huge_zero_page_shrinker to
 huge_zero_folio_shrinker
Message-ID: <arhm7vlux7xl627zvlexwziq6gpgxueeslxvjrzhofld7xgvul@uvlyngrizze3>
References: <20250724145001.487878-1-kernel@pankajraghav.com>
 <20250724145001.487878-2-kernel@pankajraghav.com>
 <87v7n7r7xx.fsf@gmail.com>
 <88296851-3bbe-44fc-a507-70964c0bea8c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88296851-3bbe-44fc-a507-70964c0bea8c@redhat.com>
X-Rspamd-Queue-Id: 4bwVKf31nCz9sxm

On Fri, Aug 01, 2025 at 05:30:46PM +0200, David Hildenbrand wrote:
> On 01.08.25 06:18, Ritesh Harjani (IBM) wrote:
> > "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:
> > 
> > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > 
> > > As we already moved from exposing huge_zero_page to huge_zero_folio,
> > > change the name of the shrinker to reflect that.
> > > 
> > 
> > Why not change get_huge_zero_page() to get_huge_zero_folio() too, for
> > consistent naming?
> 
> Then we should also rename put_huge_zero_folio(). Renaming
> MMF_HUGE_ZERO_PAGE should probably be done separately.

Thanks Ritesh and David.

I will change them in the next version! :)

--
Pankaj

