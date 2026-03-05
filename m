Return-Path: <linux-fsdevel+bounces-79462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UARSCTY/qWnK3QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 09:30:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E84820D7B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 09:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCE07301C127
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFE7372B4F;
	Thu,  5 Mar 2026 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+6pE2pM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F095A374183
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699438; cv=none; b=h4E55FqXdVFL/nqPQRTA0oZqURtXYVuiDK+2Qgt/WwK4jn2qpT3oakZRcbIcy5b3oRlI5v/yRGwqvMOHTTIofConfBiHIyt/HYJ4J8b7IjNFqR+gw4e2ImrBJuOS5g5C4tdjKTz0BjXPxh7eWlnkil0GIWbIlamuykYD62L0vMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699438; c=relaxed/simple;
	bh=IyyJMi7zPwn5aDcvOkYvk2n/48jPMfx+VyvC/C5ynGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp60kSWFtuUEg0anBTBEVEDxgR4dctvbn/5Uer4W94peD7+zWnbz7KQjYR1PXmIeAhj7BEU+ULkN5OAI7KhublOe4P777Ks2htLN6qOCg367Kr/+xLZb5Vcd0EzRv0U+yhH5IcItxKkfttRwT7kZgkjHjSZzg5Ff8otXcOUoHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+6pE2pM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B27C116C6;
	Thu,  5 Mar 2026 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772699437;
	bh=IyyJMi7zPwn5aDcvOkYvk2n/48jPMfx+VyvC/C5ynGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+6pE2pMJ8eA/sgIrVOnNXfzfmGrnCAf9YRW/w3MFdSoxh0qseE/ROGlo4PanvJf7
	 WzhVLQ0CA6FEYFDoFKOv+W17RHOvtGBEgUsjEuZhfH11Sa7Gt3YuUwc1QSg4C2v/+U
	 +wdU5Dfb3L17RoNi+8WWFkLYDJHOaa7oLfbOdMTR3gsiepGviK+VNLOCqo0VZCXvQq
	 JPLoJ4uIvi0Rjq+c6nlPR0RTDMwPanwmKJDQKyl8bnb84Nll6FfiWeqpLdY/o3URLo
	 26mivd0iDu+XZ67R4QhUFijMbgAcX69YcGAkJauoS2So1AcINF0T9gcINiCviXpcLm
	 vmepa4yQh15Yw==
Date: Thu, 5 Mar 2026 08:30:30 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add mm-related procfs files to MM sections
Message-ID: <2cb16db9-75c8-4df6-b4e9-ea2a8b260d1b@lucifer.local>
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
X-Rspamd-Queue-Id: 8E84820D7B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79462-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-mm.org:url]
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

Acked-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

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

