Return-Path: <linux-fsdevel+bounces-78874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMh0EHdfpWlc+QUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 10:59:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B75401D5DD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 10:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDEDF3031AC2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AD8392C28;
	Mon,  2 Mar 2026 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTP+7AsH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FFF38F651
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445537; cv=none; b=gSzl8p47fZQAQqmEA27NovrTSKIo3blsD3WLZ3Afda41XxPSHBiWIgfXVp3IyeoUnfekEnwl5oc8skCQ2LezVPVRUTqiH+Wi8wmkNkpn+mr56qqiJ3eTD71Oe48Okov0fOFRbJkxm4STpMdok+o0fp1GLn/FbqQ6FNrcYpgJmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445537; c=relaxed/simple;
	bh=EoMinTUOF7Oi+N5hrBw3Lofi7wnRHprWR2TKRTa/fMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyVBhKBeDUFrrYxH7lbAnSCjGvHKSJNgs3O2wqZxz1EBVzL4FTrCnS/O0m3EQB0eMRYsn/dKL465HiI7XqbJez4HrjRXbZuOakwxD+sJN2pPeph/dmgMnt6bdLIroDT4wXJIk3PCFBk0Lhx8hS8wTjYkciqiFMUdQ6vCOGb77Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTP+7AsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911BFC19423
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772445536;
	bh=EoMinTUOF7Oi+N5hrBw3Lofi7wnRHprWR2TKRTa/fMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cTP+7AsHxgP6tO/JJB+lMOUTHFVC4Uy5nBaGy+ZQJOnFgfE6vhmhiFgDtf2Ih3vsV
	 8R9+kL11EWboApBB+D5k81WNuBv0c7ZodxBn+jy33mdTg6pLr8OQHP2GY6zUQq838y
	 SmjiJeMc1t5U15FIH3sGxziKxOu4TeCZeShMa56VwlyzEGEbtQuKCTZK8RFe2VBykL
	 v4KS/LRwK1lRixWq6VtdzrVWcq6nlumj8SfElqkxdlM0ECpjqX//j7g2GSjaDpKhE2
	 YXUGU5+gVOJ7RbafaYEjfM9uU40/K6Q28P0JEayf67Cl8SlgC9mD0xJpN+UKDiXvI6
	 wOlob6A9MYvhQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b936331787bso675089566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 01:58:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5tnv9BBMw+hQojfvHLIERJ18y4IzlR893sRqYBULYqMskjIuUuERzIiheKxAOncP9xmoMcycBM/4FooFd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LzI14f3RfoEgqmrtxVsXjO56ABnT26YzMRmSWJIU+QCFgtfm
	orbfa/DWhmIqP2mf1JauiSZk/kedfhLnqt28NKByOIvqbHjSX68Y8yyxbJ9powoETM5X32ETFl+
	lttUKeuKBDHncRJiis4ma/gJr9vDwuV0=
X-Received: by 2002:a17:907:3d10:b0:b8f:e9fa:ddf7 with SMTP id
 a640c23a62f3a-b937652c23amr836938066b.40.1772445534623; Mon, 02 Mar 2026
 01:58:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301101119.447-1-anmuxixixi@gmail.com>
In-Reply-To: <20260301101119.447-1-anmuxixixi@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 2 Mar 2026 18:58:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8PmK6jXa+6kbF2Gf2HZ7Ne1-3_ZwBS9kSOY-JwogZTpg@mail.gmail.com>
X-Gm-Features: AaiRm50yvpMGpTXKPc1VTk9ipJgH8_E_3-acTXNg2QD8hKFi0lHwqbjL7CN0Z0c
Message-ID: <CAKYAXd8PmK6jXa+6kbF2Gf2HZ7Ne1-3_ZwBS9kSOY-JwogZTpg@mail.gmail.com>
Subject: Re: [PATCH] exfat: initialize caching fields during inode allocation
To: Yang Wen <anmuxixixi@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78874-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B75401D5DD7
X-Rspamd-Action: no action

> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 83396fd265cd..0c4a22b8d5fa 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -195,6 +195,10 @@ static struct inode *exfat_alloc_inode(struct super_block *sb)
>         if (!ei)
>                 return NULL;
>
> +       spin_lock_init(&ei->cache_lru_lock);
> +       ei->nr_caches = 0;
> +       ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
> +       INIT_LIST_HEAD(&ei->cache_lru);
These fields are already initialized in exfat_inode_init_once().
Please check exfat_inode_init_once().
Thanks.

