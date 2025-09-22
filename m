Return-Path: <linux-fsdevel+bounces-62373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571E1B8F994
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 10:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AB818A11C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C9B27FD43;
	Mon, 22 Sep 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nCUHaBhP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF125B687;
	Mon, 22 Sep 2025 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530485; cv=none; b=KKJE2ETIvVHbNPHFiSJ7ke9N7IQ+X7Xk/MytoroFCWiRx3F28CSjpJ5WUqMBRRf+gp8RKccZV3nRjsW82BOcptIiHlGm0URhVKsiaUBFpf5DuVT6vzFZgcqgYbWYQ3D+cSOdJVQUVfd4sIzM8ujB3pULU9sijEmafZsY1MG8CoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530485; c=relaxed/simple;
	bh=x4aklYGFshEx41NI2ERMJ10pOo0Dk0GTz3xaw/4licM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QXQxzl0PLCHVn0NncoRXwqIgiagk4eKb0jmKVXSRzNSpqp2QIeVOR4E+xBFMwXySWCiI42Sj3cniLYh3NfJLDqctYmTMLgbOIRN6YqNrFhez9kspojpeS6tWGHvGjDa81ggCpbELhHSPmV1KIFZhzzE/4TI+HwY+7jfryu7T1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nCUHaBhP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758530480;
	bh=x4aklYGFshEx41NI2ERMJ10pOo0Dk0GTz3xaw/4licM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=nCUHaBhPvG0KaFJG6BOXE4BwhzOe2Q1u5auBLvDgrG8mGKnQIu3OGiwqu00yc2mUa
	 LdGjScXZHd9FajMF9M2OjqjbKz/kB3fZNug/YUjj3RqzpBRVY1PK5BFG54Zr8xVq67
	 sn8Hdy/c6Ss5zX+jxF2gtzr+LnSWczBtJjXS20YpSkajSUc3yg9Np6vwptI8lvUlsg
	 H6y8YeiF06Rj9xev8rcWzkCoBnxHJrK7Gw0f58s7+J6vtMtBeab+H/mHpADS9Tgw+k
	 IBbSPrRSHpqFuAz9/77RoEAlv1FHRZdShfz8EEjMNk9ZtUcrxQAs8ICaxKVkfh0rhQ
	 ZCps+Zm2hlkkQ==
Received: from [192.168.100.175] (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 16B5217E124A;
	Mon, 22 Sep 2025 10:41:17 +0200 (CEST)
Message-ID: <a5400d9f-fb72-41ca-bedc-aa1c880a2234@collabora.com>
Date: Mon, 22 Sep 2025 13:39:02 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Suren Baghdasaryan <surenb@google.com>,
 Penglei Jiang <superman.xpt@gmail.com>, Mark Brown <broonie@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Andrei Vagin <avagin@gmail.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs/proc/task_mmu: check p->vec_buf for NULL
To: Jakub Acs <acsjakub@amazon.de>
References: <20250922082206.6889-1-acsjakub@amazon.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250922082206.6889-1-acsjakub@amazon.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Added mm list to cc as well

On 9/22/25 1:22 PM, Jakub Acs wrote:
> When PAGEMAP_SCAN ioctl invoked with vec_len = 0 reaches
> pagemap_scan_backout_range(), kernel panics with null-ptr-deref:
> 
> [   44.936808] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> [   44.937797] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> [   44.938391] CPU: 1 UID: 0 PID: 2480 Comm: reproducer Not tainted 6.17.0-rc6 #22 PREEMPT(none)
> [   44.939062] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   44.939935] RIP: 0010:pagemap_scan_thp_entry.isra.0+0x741/0xa80
> 
> <snip registers, unreliable trace>
> 
> [   44.946828] Call Trace:
> [   44.947030]  <TASK>
> [   44.949219]  pagemap_scan_pmd_entry+0xec/0xfa0
> [   44.952593]  walk_pmd_range.isra.0+0x302/0x910
> [   44.954069]  walk_pud_range.isra.0+0x419/0x790
> [   44.954427]  walk_p4d_range+0x41e/0x620
> [   44.954743]  walk_pgd_range+0x31e/0x630
> [   44.955057]  __walk_page_range+0x160/0x670
> [   44.956883]  walk_page_range_mm+0x408/0x980
> [   44.958677]  walk_page_range+0x66/0x90
> [   44.958984]  do_pagemap_scan+0x28d/0x9c0
> [   44.961833]  do_pagemap_cmd+0x59/0x80
> [   44.962484]  __x64_sys_ioctl+0x18d/0x210
> [   44.962804]  do_syscall_64+0x5b/0x290
> [   44.963111]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> vec_len = 0 in pagemap_scan_init_bounce_buffer() means no buffers are
> allocated and p->vec_buf remains set to NULL.
> 
> This breaks an assumption made later in pagemap_scan_backout_range(),
> that page_region is always allocated for p->vec_buf_index.
> 
> Fix it by explicitly checking p->vec_buf for NULL before dereferencing.
> 
> Other sites that might run into same deref-issue are already (directly
> or transitively) protected by checking p->vec_buf.
> 
> Note:
> From PAGEMAP_SCAN man page, it seems vec_len = 0 is valid when no output
> is requested and it's only the side effects caller is interested in,
> hence it passes check in pagemap_scan_get_args().
> 
> This issue was found by syzkaller.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Jinjiang Tu <tujinjiang@huawei.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Penglei Jiang <superman.xpt@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
> v1 -> v2: check p->vec_buf instead of cur_buf
> v2 -> v3: fix commit title
> 
> v1: https://lore.kernel.org/all/20250919142106.43527-1-acsjakub@amazon.de/ 
> v2: https://lore.kernel.org/all/20250922081713.77303-1-acsjakub@amazon.de/
> 
>  fs/proc/task_mmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 29cca0e6d0ff..b26ae556b446 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2417,6 +2417,9 @@ static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
>  {
>  	struct page_region *cur_buf = &p->vec_buf[p->vec_buf_index];
>  
> +	if (!p->vec_buf)
> +		return;
> +
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>


---
Thanks,
Usama

