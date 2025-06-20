Return-Path: <linux-fsdevel+bounces-52344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BA6AE21C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19737AE0EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4672E974C;
	Fri, 20 Jun 2025 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QQ4jfbH2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FkSgmwEa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QQ4jfbH2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FkSgmwEa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492421DF25C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750443085; cv=none; b=nVUdWU3+NIBBi9nkmW3Quj6LiDVOoMCH30sQw6hM8pJY7TBsIRblYHLsgkQ4O96Uf6DQOlmHE0salpJHyou5jqrmUgbeBtFJ+a+kWYD6AR1QmN3pP8i9X9HMiaxf315qTfeDEV4/d1TRVUjVWurwHtA4f3AzJkU42XFwbsjJrpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750443085; c=relaxed/simple;
	bh=UHvHChrgG5t1z1XdYwrjPeORXMs45w/rp2wXZzO+P9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhi1iHvcQ8YwPuEpSJ+5IJ9Zvmoa2KzIqz+ugHBw926WfZuhdc9HljTPHlhtN8EvldmyeXxGXV2LS+5dZNsFT1PgnXi8D6dU+ty1S4z2o8kb35SG7vdlnFK+VK40Jy53FdmgGIGELSUnjn2udTs6A+NSqoVA9k+W0oHDPT3NHvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QQ4jfbH2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FkSgmwEa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QQ4jfbH2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FkSgmwEa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2BAFE1F390;
	Fri, 20 Jun 2025 18:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750443081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wNCyoAtgIAvJijllAWHlslig+KAc6oaM2vaNgyMkiM=;
	b=QQ4jfbH2nf45VaK4NaygGchxSxjvAnBo7ze/NGwgK6XivCdj4hbaJUgrRG6Ii+nUsoDg0/
	dKD0XtrQ5WHHr3nP81fs8uDicD37/SUAepGENZYRSFmz0o5KITub4Dx3dUilD8ZuogJVFP
	74DUATe5QdMrbyyr1OzGMRr8msZCPx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750443081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wNCyoAtgIAvJijllAWHlslig+KAc6oaM2vaNgyMkiM=;
	b=FkSgmwEaB4NvL6x2VN1Tj7UhrEo8MuOdS9/HQt4ivzx86lJk0muDbw2ZZDNQ9NEznxzUmr
	rBtES02FP09ODSBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QQ4jfbH2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FkSgmwEa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750443081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wNCyoAtgIAvJijllAWHlslig+KAc6oaM2vaNgyMkiM=;
	b=QQ4jfbH2nf45VaK4NaygGchxSxjvAnBo7ze/NGwgK6XivCdj4hbaJUgrRG6Ii+nUsoDg0/
	dKD0XtrQ5WHHr3nP81fs8uDicD37/SUAepGENZYRSFmz0o5KITub4Dx3dUilD8ZuogJVFP
	74DUATe5QdMrbyyr1OzGMRr8msZCPx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750443081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wNCyoAtgIAvJijllAWHlslig+KAc6oaM2vaNgyMkiM=;
	b=FkSgmwEaB4NvL6x2VN1Tj7UhrEo8MuOdS9/HQt4ivzx86lJk0muDbw2ZZDNQ9NEznxzUmr
	rBtES02FP09ODSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 849CC13736;
	Fri, 20 Jun 2025 18:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ksaeHEekVWjtDQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 20 Jun 2025 18:11:19 +0000
Date: Fri, 20 Jun 2025 19:11:13 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, nvdimm@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alistair Popple <apopple@nvidia.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC 02/14] mm: drop highest_memmap_pfn
Message-ID: <3ippshswsyi3gxhnfwxs2eat25633az3v6csdhx2xwx5cx7atr@5kq763xxyyy6>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-3-david@redhat.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL89xh3ijk4gdpeanxbepagf1s)];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2BAFE1F390
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Tue, Jun 17, 2025 at 05:43:33PM +0200, David Hildenbrand wrote:
> Now unused, so let's drop it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

