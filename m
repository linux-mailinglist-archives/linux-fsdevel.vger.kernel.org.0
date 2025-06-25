Return-Path: <linux-fsdevel+bounces-52879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B277BAE7DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 11:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46368161C29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58322DFA3F;
	Wed, 25 Jun 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GPnNP10/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aWa40d3L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GPnNP10/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aWa40d3L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1572BDC06
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844104; cv=none; b=BTHJ72TiBKPNeQuLgxPEroPt2wN/CDpn3L2IAbhAoIp43UHeUsZQJktN+n2u2HAsDWtCRiI9ob//DFUnOKlxfYjruz+Nkib0ho7hXo0vFZFocpK3FWimlWH55JSUCuIN0mUojxYbUZPCfUM0xurJGBrfPtyivdVDOA7ec1ZQp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844104; c=relaxed/simple;
	bh=E7ejp8P8YsbKJJK/1FBGYKpEgGrI2RIqByFQgAvsWjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxWxSDMS6AGv8TqZbxwKWzLDQBoDubLh7rrjWW4G9NqTQAssV6n36EGlTAl9ijcpCJjRXkCGHxYMzmkruG5YC/UhcLgOcJ7SlzAKMDOusmOftumxzWImXgYURh/+RWXLS5n6+zBPdcdmw/MpN1tOWDL3DrKq8SQRUMgZGdN1mhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GPnNP10/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aWa40d3L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GPnNP10/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aWa40d3L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D18E51F441;
	Wed, 25 Jun 2025 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750844100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9yD9bDvc4ttPN1JbIa1TTy9wP5vivopfbZOV9iRQ4o=;
	b=GPnNP10/8VxFC0xTPvnzcEmlYxnOcsmX+aAqnKYNgYu2cjsDWyMDW9Bs2Dx5hqdJRSzlPJ
	Yvq22aBwLZwTIeEuRO/rgPREPzOrW8UMGEYvP8USIsYJQRuXqrkyfmVsCsAhjDQhp7yyxd
	9/mK7HUm/59/9/8BgnfhuFhHwLK0SsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750844100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9yD9bDvc4ttPN1JbIa1TTy9wP5vivopfbZOV9iRQ4o=;
	b=aWa40d3L6ijqeA3155PROSbkBuA67JPZ2t4v0J9mFBwaqwu+0GbN8u6iE6pVjMcPyhPbF5
	kvvblYRcQ/qKcMCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750844100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9yD9bDvc4ttPN1JbIa1TTy9wP5vivopfbZOV9iRQ4o=;
	b=GPnNP10/8VxFC0xTPvnzcEmlYxnOcsmX+aAqnKYNgYu2cjsDWyMDW9Bs2Dx5hqdJRSzlPJ
	Yvq22aBwLZwTIeEuRO/rgPREPzOrW8UMGEYvP8USIsYJQRuXqrkyfmVsCsAhjDQhp7yyxd
	9/mK7HUm/59/9/8BgnfhuFhHwLK0SsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750844100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9yD9bDvc4ttPN1JbIa1TTy9wP5vivopfbZOV9iRQ4o=;
	b=aWa40d3L6ijqeA3155PROSbkBuA67JPZ2t4v0J9mFBwaqwu+0GbN8u6iE6pVjMcPyhPbF5
	kvvblYRcQ/qKcMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EE7B13485;
	Wed, 25 Jun 2025 09:34:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SemZDMPCW2gENQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 25 Jun 2025 09:34:59 +0000
Date: Wed, 25 Jun 2025 11:34:57 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, nvdimm@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Vrabel <david.vrabel@citrix.com>
Subject: Re: [PATCH RFC 14/14] mm: rename vm_ops->find_special_page() to
 vm_ops->find_normal_page()
Message-ID: <aFvCwYDzEOQfpu0G@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-15-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-15-david@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhwqoz3wsm4df3nfubx4grhps)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Tue, Jun 17, 2025 at 05:43:45PM +0200, David Hildenbrand wrote:
> ... and hide it behind a kconfig option. There is really no need for
> any !xen code to perform this check.
> 
> The naming is a bit off: we want to find the "normal" page when a PTE
> was marked "special". So it's really not "finding a special" page.
> 
> Improve the documentation, and add a comment in the code where XEN ends
> up performing the pte_mkspecial() through a hypercall. More details can
> be found in commit 923b2919e2c3 ("xen/gntdev: mark userspace PTEs as
> special on x86 PV guests").

Looks good to me.
Since this seems a "mistake" from the past we don't want to repeat, I wonder
whether we could seal FIND_NORMAL_PAGE somehow, and scream if someone
tries to enable it on !XEN environments.



-- 
Oscar Salvador
SUSE Labs

