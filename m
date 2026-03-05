Return-Path: <linux-fsdevel+bounces-79463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ElMImM/qWnK3QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 09:31:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B12020D7CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 09:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B60E230209CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C431E106;
	Thu,  5 Mar 2026 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ/n9xhp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC023288514
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699486; cv=none; b=MfsuYOZPNwsKsz/6pQTvh4jhby03WXCvKssPRpodpvMC/0ZucRlndz077+CjCPoGt8e7EoeGQ0IeZmp+HYkg1875AkPNzDIer3JK7Awf1Ytf60NXUPKPmuz2U1N1qAvIwgjAyjqUc1jenychlhJsJR6kEKSY696dQZxzUNs7Oo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699486; c=relaxed/simple;
	bh=kvHVs4NskjZVXPDgFweRxutw5zxiegP9xPjKv71JlSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tn+3I+23ENRQOFmZIC+qfo8MEzeuoQPMYdp89PhydEWIwxOVOeQYb2vg2QQ/fBlAd8K2YC7bsVl8gmgSWhpWywP7jl9K4HCVk7XU/qGRJcIRhI6dWM08O1IKyx7Di7HcErHYiIHIoD+ML3QRgS7ZMhKqaREeWrU+LKvfMYWTDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ/n9xhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B04EC116C6;
	Thu,  5 Mar 2026 08:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772699486;
	bh=kvHVs4NskjZVXPDgFweRxutw5zxiegP9xPjKv71JlSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJ/n9xhpsuSF9gMIaGks6obwLslM79XBc3nZ6X6jbX5k3cm52Jx6hHyBTc1wc1bgL
	 sj8JGcQMSVx1p4hozy/2ttQyjdubqX2YJ3HP75PdA/p6qnzXB5RGi+hMiw72pq7yEC
	 gj0c4VrE5lR8V4KDbGcm61c5PCw0mKRYy97WKoJvBs4hwXkLC4eroWHULph1rXbOkZ
	 N1Y67Du94msqmiKsFiOcPs0jJfLDPcBGFu4pmbXJuhqFhoJBx03ihqXUa0R/Wy8UST
	 X/3uyxeeZ1yGmuxbgwL9RXRRIcXWtj2wWBTWE/AHjkhU4oSW0Z0fHHOXIpZ0Tof/Wq
	 w/RMgwaOVR/0w==
Date: Thu, 5 Mar 2026 10:31:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add mm-related procfs files to MM sections
Message-ID: <aak_V32C4BnJ1i-b@kernel.org>
References: <20260305-maintainers-proc-v1-1-d6d09b3db3b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-maintainers-proc-v1-1-d6d09b3db3b6@kernel.org>
X-Rspamd-Queue-Id: 0B12020D7CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-79463-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-mm.org:url]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:26:29AM +0100, Vlastimil Babka (SUSE) wrote:
> Some procfs files are very much related to memory management so let's
> have MAINTAINERS reflect that.
> 
> Add fs/proc/meminfo.c to MEMORY MANAGEMENT - CORE.
> 
> Add fs/proc/task_[no]mmu.c to MEMORY MAPPING.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3553554019e8..39987895bcfc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16683,6 +16683,7 @@ F:	include/linux/ptdump.h
>  F:	include/linux/vmpressure.h
>  F:	include/linux/vmstat.h
>  F:	include/trace/events/zone_lock.h
> +F:	fs/proc/meminfo.c
>  F:	kernel/fork.c
>  F:	mm/Kconfig
>  F:	mm/debug.c
> @@ -16998,6 +16999,8 @@ S:	Maintained
>  W:	http://www.linux-mm.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>  F:	include/trace/events/mmap.h
> +F:	fs/proc/task_mmu.c
> +F:	fs/proc/task_nommu.c
>  F:	mm/interval_tree.c
>  F:	mm/mincore.c
>  F:	mm/mlock.c
> 
> ---
> base-commit: 7fcd8889fbf318409163ff5033fe161dd2a73243
> change-id: 20260305-maintainers-proc-30e45ca9e434
> 
> Best regards,
> -- 
> Vlastimil Babka (SUSE) <vbabka@kernel.org>
> 

-- 
Sincerely yours,
Mike.

