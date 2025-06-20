Return-Path: <linux-fsdevel+bounces-52350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A24ECAE2239
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BFA16A847
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF052EACF8;
	Fri, 20 Jun 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FeUhZIrL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UpOOBQAm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FeUhZIrL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UpOOBQAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B75A21FF3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750444276; cv=none; b=b1pPaIOTf1r+QgQ8vVt4DeL19lxlzyBO/XJS6GIh72sRPfnOkc3C0s9k+iElq+H9qHrO5Ov506WoaT0dlWDEH/mdh1iix8pXRVLMY1KooYd89FEHZornY+zzBKgoN1lH6B3eMQ5n6mMZgMCN3nfQo6nVky0MetsrkNGHZ0m43ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750444276; c=relaxed/simple;
	bh=ad8vsSAm+A1358ro5HG+HW/KxeIAxNbEZgK7hOb00Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9z6gwB6bwNgy52BvbP9xT6uUPJ5WZ3tPxRIfw0lHZXC/JftF/wmkM/kFxy75wDThFeJhPdtDxOt8ebFkjSgb+6Uqk8XGUtSH7lFsn8OY5h9/hKcgAp/kLLiDDwQkOhog7czZ6VCg0gS+cBdeMfge+Kp3Qhyj8mDTXBIULU29CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FeUhZIrL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UpOOBQAm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FeUhZIrL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UpOOBQAm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1D172122A;
	Fri, 20 Jun 2025 18:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750444272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qmVG12TKwc2QVW0G8ian8AtN9mnqlZh4WCEqhc8pLTY=;
	b=FeUhZIrLYm4/o8S8eNa53r7vMhoRAGFZLex3j4P4J6P9AZkL45f+IeQQIeeaiug+ZzRNFG
	hARXJHANDh34/IjopPPX5I/xdKap8H63G8FhHa/3gDH6eeKztqNporF0VCesY+e0CanTA5
	51aYl4AdOBArxDE3UjQRoagrNSvGRVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750444272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qmVG12TKwc2QVW0G8ian8AtN9mnqlZh4WCEqhc8pLTY=;
	b=UpOOBQAmFBCtjEINkxipWx6NT/FVaqv9UBV56UH2PdyRFK1+D8Q4qnl2CvuUL/i+Ynj3b+
	2x9kYcDlaPYsWpDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750444272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qmVG12TKwc2QVW0G8ian8AtN9mnqlZh4WCEqhc8pLTY=;
	b=FeUhZIrLYm4/o8S8eNa53r7vMhoRAGFZLex3j4P4J6P9AZkL45f+IeQQIeeaiug+ZzRNFG
	hARXJHANDh34/IjopPPX5I/xdKap8H63G8FhHa/3gDH6eeKztqNporF0VCesY+e0CanTA5
	51aYl4AdOBArxDE3UjQRoagrNSvGRVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750444272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qmVG12TKwc2QVW0G8ian8AtN9mnqlZh4WCEqhc8pLTY=;
	b=UpOOBQAmFBCtjEINkxipWx6NT/FVaqv9UBV56UH2PdyRFK1+D8Q4qnl2CvuUL/i+Ynj3b+
	2x9kYcDlaPYsWpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B93313736;
	Fri, 20 Jun 2025 18:31:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c8qtA+2oVWgNEwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 20 Jun 2025 18:31:09 +0000
Date: Fri, 20 Jun 2025 19:31:07 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: change vm_get_page_prot() to accept vm_flags_t
 argument
Message-ID: <drycqgdeh73cfghcovl3ujiaxcbmgrat73sf3aqtyanvoahrij@umib45jrz5qa>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_GT_50(0.00)[64];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,armlinux.org.uk,arm.com,kernel.org,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,davemloft.net,gaisler.com,linux.intel.com,linutronix.de,redhat.com,alien8.de,zytor.com,infradead.org,zeniv.linux.org.uk,suse.cz,nvidia.com,linux.alibaba.com,oracle.com,zte.com.cn,linux.dev,google.com,suse.com,surriel.com,intel.com,goodmis.org,efficios.com,ziepe.ca,suse.de,cmpxchg.org,bytedance.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed, Jun 18, 2025 at 08:42:52PM +0100, Lorenzo Stoakes wrote:
> We abstract the type of the VMA flags to vm_flags_t, however in may places
> it is simply assumed this is unsigned long, which is simply incorrect.
> 
> At the moment this is simply an incongruity, however in future we plan to
> change this type and therefore this change is a critical requirement for
> doing so.
> 
> Overall, this patch does not introduce any functional change.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Nice little cleanup, thanks!

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

