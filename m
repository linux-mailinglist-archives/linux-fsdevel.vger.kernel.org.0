Return-Path: <linux-fsdevel+bounces-56834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB62B1C5AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 14:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646C6560551
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD0B28A1CC;
	Wed,  6 Aug 2025 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="vCHDdWya"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C232417C3;
	Wed,  6 Aug 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482702; cv=none; b=BpIl6BiPhnY1UTUpCffVv4XtR48rJbzHan0foQHMnXALO3Q4SgGxFxeaTIA3qTeFcwANNEV9/txaZ4VmGHN5XKTCnNp28SjqwaXTzaFDTEJgeVuvzJhF9Wtxi/Fcn8JGjspYUBIPZFU20d8FGlEQlvHUFDAzLZq50LVXoSuAptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482702; c=relaxed/simple;
	bh=Gb1sbf37EVVXuRDsOk2K10OFqD9QslGQBGrH6LjwaTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kd+cN76QNQH5rhT+LBQyHN83mxQG8VnHfuUTTKzIAv14bFc7e7HBK8S2i5rcs9Gm8wNcbSZ89i17+3CRe9d3mFT6Jl/6Gs63wBLuUk/G29/Zo4RE7fN1hyXttwvqM56u4EMMhH95UB8Iv9cvT5KXtRJaAud91FxY6OdSNZshvfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=vCHDdWya; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bxq7q45K8z9tQW;
	Wed,  6 Aug 2025 14:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754482695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5O1ajgOeaeiocA+1U0rfXnrWE+rOnG3cAc3QPkT9QLo=;
	b=vCHDdWyalXiuBEyJq8kQbTmBAy2dZK+IDjgzL9AGeiz2+QY/PFSNGiGNDY3zz/6CKHp7DB
	LVzdMTpLXPMunqiyw2H1me2Z7kL7UKcWArXCTnhH21NeuZGxQRKrKdk+JxHzXOSKaMo/LG
	IFWNVtY5tAB9Gsb0QF3K6mGoVFREF6YB7gRjl9fy7qOjaODPvxNHKhZY/1JtAcXjJMglMv
	pWDreyV54K+S44Q2KU5AIqBNCZmqcfJEzooJ8f5OmjPNoz0pKEDfnBpD6QKyhzU4p12kqZ
	kEBLmNbvUyTPtcYFsd2yJZAVMIAk/EdrrlH8S/e5TuZ/Crjrb2Q3tArR1o5PXw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Wed, 6 Aug 2025 14:18:05 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, x86@kernel.org, linux-block@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 3/5] mm: add static huge zero folio
Message-ID: <bmngjssdvffqvnfcoledenlxefdqesvfv7l6os5lfpurmczfw5@mn7jouglo72s>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-4-kernel@pankajraghav.com>
 <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
 <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
 <6ff6fc46-49f1-49b0-b7e4-4cb37ec10a57@lucifer.local>
 <bc6cdb11-41fc-486b-9c39-17254f00d751@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc6cdb11-41fc-486b-9c39-17254f00d751@redhat.com>
X-Rspamd-Queue-Id: 4bxq7q45K8z9tQW

> We could go one step further and special case in mm_get_huge_zero_folio() +
> mm_put_huge_zero_folio() on CONFIG_STATIC_HUGE_ZERO_FOLIO.
> 

Hmm, but we could have also failed to allocate even though the option
was enabled.

2 options:
- we could do: 
if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO) && huge_zero_folio)
  return huge_zero_folio;

or
- As dave suggested, we could do a static key and enable it when the
  option is enabled and the allocation succeeded. The same static key
  can also be used in get_static_huge_zero_folio().

I think the latter option will look more clean and slightly more
optimal?

> Something like
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9c38a95e9f091..9b87884e5f299 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -248,6 +248,9 @@ static void put_huge_zero_page(void)
> 
>  struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
>  {
> +       if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
> +               return huge_zero_folio;
> +
>         if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
>                 return READ_ONCE(huge_zero_folio);
> 
> @@ -262,6 +265,9 @@ struct folio *mm_get_huge_zero_folio(struct mm_struct
> *mm)
> 
>  void mm_put_huge_zero_folio(struct mm_struct *mm)
>  {
> +       if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
> +               return huge_zero_folio;
> +
>         if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
>                 put_huge_zero_page();
>  }
> 
--
Pankaj


