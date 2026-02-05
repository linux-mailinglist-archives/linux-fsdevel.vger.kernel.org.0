Return-Path: <linux-fsdevel+bounces-76429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CEoEkWOhGkO3gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:34:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7C1F2925
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 127B130574B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A13D34B7;
	Thu,  5 Feb 2026 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2QL4syKI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841C3D34A1;
	Thu,  5 Feb 2026 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294584; cv=none; b=eyDNY0PTcIwsN81nJ36nWKgkPkro0eM1KB/bloOInJy7pZvp92Oa4w5iQQju5kcz4MusLzhRcQUzZgFpGKsk5AZNbUSJKMfmgsQt14dMbuypSXAgXNHcWqL6Iq4dVcDE8c1eS8nP708eQQWhsWsbTtNmV93WKmer0P02bXBjokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294584; c=relaxed/simple;
	bh=NhgZbHZZ1Q9Z0OG4w1HWU7IxM4fUhT5hDIzn625P1Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JCcOsX9pVdvRRIf/FMV/9TNCLHH5Py+nsek5leCfr4LtFJiUJr2mZgtG+M7c8ciKNdOn/qCMWjEjmV4HQQqWwXSsnK0c7D/C39mfWJIUuq3BMhBwbn8iTfE+gn7tzBmPS/bMTuG7sxODViDbhw2eaurtWZUcQDkKo9iJR+9hDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2QL4syKI; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jtsUXhyAvatzceINDh9NMVJtw3FRNynLbx55TjnNyxM=;
	b=2QL4syKIiUad0uvktFEzB9QW3jPvVVDELkvlqePTOcaG4yCEs/yGQnT6uBlDofgFWn3DY0086
	Dh9O0ezIvz1RK5c+uqGBcM6fGcdNhtUlgk28c296fusfrByVFLPOFHYWp4UFXNvnEP1J8Sl/b4J
	L0ni9aUFwhy+88F9koHGCwM=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4f6GdR3rlwz1T4FV;
	Thu,  5 Feb 2026 20:25:15 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F93B40561;
	Thu,  5 Feb 2026 20:29:39 +0800 (CST)
Received: from [10.174.176.137] (10.174.176.137) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 5 Feb 2026 20:29:38 +0800
Message-ID: <b2b8391c-c957-460a-bdd4-38642a5aa2bb@huawei.com>
Date: Thu, 5 Feb 2026 20:29:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dcache: Limit the minimal number of bucket to two
To: Zhihao Cheng <chengzhihao1@huawei.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260130034853.215819-1-chengzhihao1@huawei.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20260130034853.215819-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100006.china.huawei.com (7.202.181.220)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-76429-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: AB7C1F2925
X-Rspamd-Action: no action

LGTM

Reviewed-by: Yang Erkun <yangerkun@huawei.com>

在 2026/1/30 11:48, Zhihao Cheng 写道:
> There is an OOB read problem on dentry_hashtable when user sets
> 'dhash_entries=1':
>    BUG: unable to handle page fault for address: ffff888b30b774b0
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    Oops: Oops: 0000 [#1] SMP PTI
>    RIP: 0010:__d_lookup+0x56/0x120
>     Call Trace:
>      d_lookup.cold+0x16/0x5d
>      lookup_dcache+0x27/0xf0
>      lookup_one_qstr_excl+0x2a/0x180
>      start_dirop+0x55/0xa0
>      simple_start_creating+0x8d/0xa0
>      debugfs_start_creating+0x8c/0x180
>      debugfs_create_dir+0x1d/0x1c0
>      pinctrl_init+0x6d/0x140
>      do_one_initcall+0x6d/0x3d0
>      kernel_init_freeable+0x39f/0x460
>      kernel_init+0x2a/0x260
> 
> There will be only one bucket in dentry_hashtable when dhash_entries is
> set as one, and d_hash_shift is calculated as 32 by dcache_init(). Then,
> following process will access more than one buckets(which memory region
> is not allocated) in dentry_hashtable:
>   d_lookup
>    b = d_hash(hash)
>      dentry_hashtable + ((u32)hashlen >> d_hash_shift)
>      // The C standard defines the behavior of right shift amounts
>      // exceeding the bit width of the operand as undefined. The
>      // result of '(u32)hashlen >> d_hash_shift' becomes 'hashlen',
>      // so 'b' will point to an unallocated memory region.
>    hlist_bl_for_each_entry_rcu(b)
>     hlist_bl_first_rcu(head)
>      h->first  // read OOB!
> 
> Fix it by limiting the minimal number of dentry_hashtable bucket to two,
> so that 'd_hash_shift' won't exceeds the bit width of type u32.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>   fs/dcache.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 66dd1bb830d1..957a44d2c44a 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -3260,7 +3260,7 @@ static void __init dcache_init_early(void)
>   					HASH_EARLY | HASH_ZERO,
>   					&d_hash_shift,
>   					NULL,
> -					0,
> +					2,
>   					0);
>   	d_hash_shift = 32 - d_hash_shift;
>   
> @@ -3292,7 +3292,7 @@ static void __init dcache_init(void)
>   					HASH_ZERO,
>   					&d_hash_shift,
>   					NULL,
> -					0,
> +					2,
>   					0);
>   	d_hash_shift = 32 - d_hash_shift;
>   


