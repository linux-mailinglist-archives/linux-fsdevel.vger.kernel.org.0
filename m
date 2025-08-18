Return-Path: <linux-fsdevel+bounces-58147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BCFB2A12E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7CB188F994
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 12:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1672326D71;
	Mon, 18 Aug 2025 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JIZIkc02";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hXpd5nL3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JIZIkc02";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hXpd5nL3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5E22A808
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518570; cv=none; b=HYAw+wieB9ixPRiJBvcOP8dugOTJoMtxgGVUSaIZfEpMb1TG5ohS3VJWdyhGidKxoWd5ANu6SgAmcHgnkGuIUCQLTS5wIgTc/8Mysbbt7x3S9ja4pOmQH4Z+idUUcX7gWscgD8Ow8z3mD41JUVFf9BEiqoxnt+Yp0fMpMCwYLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518570; c=relaxed/simple;
	bh=ZGX2zGsGNvw805IyudKJ15/DmyboLEhvv9LxS0Dbza0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCaOEjMcbbedLRmYpmRFebR8NgZcUkZh7x/qgwdfWE2fxn4DnM+Zzdy48ecNrju1f3+hXYvBMXXcOSxcnpdS+wyl33B/5xPe49ZqXqXO0Zsy6cC/Hr32ZUf+WkcF/HVho/F+oVkN+ZbmXVzPRskNZ9EShCQts34zj+vOXKMneL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JIZIkc02; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hXpd5nL3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JIZIkc02; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hXpd5nL3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C9FC1F387;
	Mon, 18 Aug 2025 12:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755518566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+3lGak+12Vl27FVM2SSyx0kSJAGYOUNyyYt5Oy3FxA=;
	b=JIZIkc02a8dlmuExIatpt2ibFt1oHaVgpfYJlzavqpHiN63uXU3zsBHjuPYfqIMpR4mVG1
	SJp8AbTMrdjoYyQ4qK8k1fLJwJoVyEBOG3Jsgt3171NJo8DOukjDlkf6n1TiH8+MOsCatu
	Uzr5aUuu9imvUiEuaKTrR832xM5X4w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755518566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+3lGak+12Vl27FVM2SSyx0kSJAGYOUNyyYt5Oy3FxA=;
	b=hXpd5nL3/MIuI8ZUT7MUGVF7scVkEDjhZHYAWXWWH9MtMDpgE5Y4CT3gVGk/sTAvpyc0ul
	6QHbKQ9UAUUmsgDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JIZIkc02;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hXpd5nL3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755518566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+3lGak+12Vl27FVM2SSyx0kSJAGYOUNyyYt5Oy3FxA=;
	b=JIZIkc02a8dlmuExIatpt2ibFt1oHaVgpfYJlzavqpHiN63uXU3zsBHjuPYfqIMpR4mVG1
	SJp8AbTMrdjoYyQ4qK8k1fLJwJoVyEBOG3Jsgt3171NJo8DOukjDlkf6n1TiH8+MOsCatu
	Uzr5aUuu9imvUiEuaKTrR832xM5X4w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755518566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+3lGak+12Vl27FVM2SSyx0kSJAGYOUNyyYt5Oy3FxA=;
	b=hXpd5nL3/MIuI8ZUT7MUGVF7scVkEDjhZHYAWXWWH9MtMDpgE5Y4CT3gVGk/sTAvpyc0ul
	6QHbKQ9UAUUmsgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4984313A55;
	Mon, 18 Aug 2025 12:02:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RUFWB2EWo2gSbAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 12:02:41 +0000
Message-ID: <ff1dcd4b-db64-4982-bfc5-78db033f61d8@suse.de>
Date: Mon, 18 Aug 2025 14:02:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: add persistent huge zero folio
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Vlastimil Babka
 <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250808121141.624469-1-kernel@pankajraghav.com>
 <20250808121141.624469-4-kernel@pankajraghav.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250808121141.624469-4-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,kvack.org,gmail.com,kernel.org,samsung.com,lst.de];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLxigy8pr3gnoabpfzcidubger)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4C9FC1F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

On 8/8/25 14:11, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Many places in the kernel need to zero out larger chunks, but the
> maximum segment that can be zeroed out at a time by ZERO_PAGE is limited
> by PAGE_SIZE.
> 
> This is especially annoying in block devices and filesystems where
> multiple ZERO_PAGEs are attached to the bio in different bvecs. With
> multipage bvec support in block layer, it is much more efficient to send
> out larger zero pages as a part of single bvec.
> 
> This concern was raised during the review of adding Large Block Size
> support to XFS[1][2].
> 
> Usually huge_zero_folio is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left. At moment,
> huge_zero_folio infrastructure refcount is tied to the process lifetime
> that created it. This might not work for bio layer as the completions
> can be async and the process that created the huge_zero_folio might no
> longer be alive. And, one of the main points that came up during
> discussion is to have something bigger than zero page as a drop-in
> replacement.
> 
> Add a config option PERSISTENT_HUGE_ZERO_FOLIO that will result in
> allocating the huge zero folio during early init and never free the memory
> by disabling the shrinker. This makes using the huge_zero_folio without
> having to pass any mm struct and does not tie the lifetime of the zero
> folio to anything, making it a drop-in replacement for ZERO_PAGE.
> 
> If PERSISTENT_HUGE_ZERO_FOLIO config option is enabled, then
> mm_get_huge_zero_folio() will simply return the allocated page instead of
> dynamically allocating a new PMD page.
> 
> Use this option carefully in resource constrained systems as it uses
> one full PMD sized page for zeroing purposes.
> 
> [1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
> [2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/
> 
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   include/linux/huge_mm.h | 16 ++++++++++++++++
>   mm/Kconfig              | 16 ++++++++++++++++
>   mm/huge_memory.c        | 40 ++++++++++++++++++++++++++++++----------
>   3 files changed, 62 insertions(+), 10 deletions(-)
> 
As mentioned, I really would like to have a kernel commandline parameter
for disabling huge zero folio.
Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

