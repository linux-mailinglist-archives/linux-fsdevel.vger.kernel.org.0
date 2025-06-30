Return-Path: <linux-fsdevel+bounces-53294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDF3AED3BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 07:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B653B3114
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 05:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E46B1AE877;
	Mon, 30 Jun 2025 05:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="FeeygIEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FD36D;
	Mon, 30 Jun 2025 05:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751260709; cv=pass; b=dXFfAnm77vxQTuWi7DEH/eqHOmHf9A4u3FhusRrX0ZbBTX8D9pyLk6hxlUO1qZS6vgfxMjtawE3WssW40yWpayg/aLdJIuROiDhMhW32U9N4eOpa51y6WiYiv+IVBrq2z/fxEdI8bRw79E+XzZEER+ia7nCcIM/dIWj/glpQyOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751260709; c=relaxed/simple;
	bh=VCSXFRJ4YZS6MoeZRyg10NnnCbj0SeDMMqasgEgdqo0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bV6zNb8Jd8JRZFl9ST8rf70pJUHcg0t7GOFh46iCBxXoDxPkxOYNIIPAGQMsTVXNxdBR4pp9q15r+LxTu8mUoMzDzEjzgkgjUu6vOgaZifOSvdXasC9s3nCFB5CV7ZQ52+JpmuWo1XgC87x1KtB0hKg0VeKbvCq6AtMmXH7U81E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=FeeygIEB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751260702; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VbrbmQCcsvmozqpo9krGZxAFkwtFIBgD/IYNKq63xkxa7cj1o7t5u6e+4ipD2R+77X0N7LcZvw1mycLs/SdBFS9s4tgR0YUGLDb5QjBStBX7OrShEliK9oiRhoouF7W4W9bIxeRGWe14EJ/hP0TF15jAY68l9htymnWOy1pzxTE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751260702; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A06tmHYsrsLPH4ywEtWPK209Su2KHulG9/VFs1BS1Ws=; 
	b=RIWauv0jzIizaHa0tNX59S+xLslE1JXVIM5LZVb853i46iy76JMZYwnmjbYlf+lJx4RLvovA0yvpL09yrSst8oQ3BbJ3W8P+qm6laAEfnGOF1lKjHQG51pK/83YX5nxGYlJXwY8AaBjL7bG8OPhBZQSTHtCJhtEd3alS7IAvXQE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751260702;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=A06tmHYsrsLPH4ywEtWPK209Su2KHulG9/VFs1BS1Ws=;
	b=FeeygIEB8O3bvG6oFG1aaWxVpEtmBkCxZcsJFdSYZwHczIpeGdRzqHBMu/TM9PsP
	smDo37DE0jYdpZ9FHO9zLvwcBokwzCwgmwH1pGwniyQEa6sn2aLX4qVJfVDGhdLj7tH
	uuzTw6OQLHkGKptrusKb3P/XQwYv7TYey+esTzEA=
Received: by mx.zohomail.com with SMTPS id 1751260700634924.551506531858;
	Sun, 29 Jun 2025 22:18:20 -0700 (PDT)
Message-ID: <416514a7-0e0d-4cc8-912e-bcdd2bac5c2e@collabora.com>
Date: Mon, 30 Jun 2025 10:18:17 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v1] fs/proc/task_mmu: fix PAGE_IS_PFNZERO detection for
 the huge zero folio
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250617143532.2375383-1-david@redhat.com>
Content-Language: en-US
In-Reply-To: <20250617143532.2375383-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 6/17/25 7:35 PM, David Hildenbrand wrote:
> is_zero_pfn() does not work for the huge zero folio. Fix it by using
> is_huge_zero_pmd().
> 
> Found by code inspection.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Probably we should Cc stable, thoughts?
> 
> We should also extend the pagemap_ioctl selftest to cover this case, but I
> don't have time for that right now. @Muhammad ?
Currently, we don't have any test case covering zero pfn. I'm trying to write
a few test cases. But I'm not able to get ZERO PFN. I've tried to allocate a
read only memory and then read it. Is there a trick to how to create ZERO PFN
memory from userspace?

> 
> ---
>  fs/proc/task_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 27972c0749e78..4be91eb6ea5ca 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2182,7 +2182,7 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
>  				categories |= PAGE_IS_FILE;
>  		}
>  
> -		if (is_zero_pfn(pmd_pfn(pmd)))
> +		if (is_huge_zero_pmd(pmd))
>  			categories |= PAGE_IS_PFNZERO;
>  		if (pmd_soft_dirty(pmd))
>  			categories |= PAGE_IS_SOFT_DIRTY;


