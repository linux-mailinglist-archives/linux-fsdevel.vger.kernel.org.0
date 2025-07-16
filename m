Return-Path: <linux-fsdevel+bounces-55111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4DB06F5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1311A66595
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D4828EA62;
	Wed, 16 Jul 2025 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="1izeZ3gS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA928C872;
	Wed, 16 Jul 2025 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652091; cv=none; b=SXDr/yjpZ58c8HfzdNkwyWGEeUs9Nu/F9ztjIQFttQdJdZD0rO5LG2mcPYTKSJbPOJ3XCtLiYOEwATKA5Q1MOW8byzbbFqX7niMgpQOoIixBq/VLSmeUdyLxdebX8agpXhtdYijlbTAZ/ah7i5926Op0aYvf7cdIs6e46ueQKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652091; c=relaxed/simple;
	bh=q5tlGgN4hGF7YyJcCpPiQlN4oYyRAg/tS0iZ2xg1lFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFPVlCTLpCLOFM4knKPsytvS6iR/Ytu2uXdskwjxUSAGy2xC0Ziq5w5zDmNbwVU3p2NFOY/kBkf2BImeUyDaKBSrr+PDkXhrJKXP97gmW0hudQCayM44giyaDmZ7bJOoNAB05qxA4NP9exT0zxCAB9pzGezcpwVDJOVOZS7Y510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=1izeZ3gS; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bhp7h18QTz9st4;
	Wed, 16 Jul 2025 09:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1752652080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1EqZLQw7tah4DL/vfuoIKpuF0J4DZz2EQrgNRTQ+98=;
	b=1izeZ3gS36y6dVm2SXoZQMgV4uu6K4WUpBSOW12sVGpNYwQGQUku64h5dqtCwnmuWO8J5U
	gze6egm9P63dUUxgFRq1lyFsY4tku2LSw/nT9YrVBi2V29TQt/Wy+So/cM/xCepnOkiWpO
	rFtLohVOjXS0PdibyNaaS91YXkE2cz4qWaCG30DbcQfNCDqTVmFLWuS8jaajRNnl1BpeRE
	L5B79psuz5kOZs2RQaRygFGh/BzQPcZknyZrxKRAdA5fmoI6nhPI55QRYayZbedL2Ypg1b
	YKExuvbtKbqKend7+zQM0gy+XtM9HSaqrytymH5pd59Y7ilCDpdL5Bd0dXef8Q==
Date: Wed, 16 Jul 2025 09:47:47 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	willy@infradead.org, linux-mm@kvack.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/5] mm: move huge_zero_page declaration from
 huge_mm.h to mm.h
Message-ID: <hi7i4k7gbbd27mtjyucwxjgwhjq7z4wtzm2nd6fqfnd5m7yo52@k7vwf576a44x>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-2-kernel@pankajraghav.com>
 <a0233f30-b04d-461e-a662-b6f20dca02c5@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0233f30-b04d-461e-a662-b6f20dca02c5@lucifer.local>

On Tue, Jul 15, 2025 at 03:08:40PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jul 07, 2025 at 04:23:15PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> >
> > Move the declaration associated with huge_zero_page from huge_mm.h to
> > mm.h. This patch is in preparation for adding static PMD zero page as we
> > will be reusing some of the huge_zero_page infrastructure.
> 
> Hmm this is really iffy.
> 
> The whole purpose of huge_mm.h is to handle huge page stuff, and now you're
> moving it to a general header... not a fan of this - now we have _some_
> huge stuff in mm.h and some stuff here.
> 
> Yes this might be something we screwed up already, but that's not a recent
> to perpetuate mistakes.
> 
> Surely you don't _need_ to do this and this is a question of fixing up
> header includes right?
> 
> Or is them some horrible cyclical header issue here?
> 
> Also your commit message doesn't give any reason as to why you _need_ to do
> this also. For something like this where you're doing something that at
> face value seems to contradict the purpose of these headers, you need to
> explain why.
> 

In one of the earlier versions, David asked me to experiment by moving some of these
declarations to mm.h and see how it looks. Mainly because, as you
guessed it later, we can use it without THP being enabled.

But I see that you strongly feel against moving this to mm.h (and I see
why).

I can move it back to huge_mm.h.

Thanks

--
Pankaj


