Return-Path: <linux-fsdevel+bounces-29136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE6E976198
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 08:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12F91C21203
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 06:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3955718BC14;
	Thu, 12 Sep 2024 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="CrTFeYBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4B189BAD
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122981; cv=pass; b=rJVNWdCPQd+diJWTbW7LkUAKrnsxhR7v0yANOzzKKNyLbN4V+/toQUnlPVVNxJ9+Ksq+s1f7j2x0ybMclhn5KgN/3gzq2qoN05n9fc+FUKKkrPWewheMeHlbM0tiRxeRCaLLo07pP8cmhFE6xTh0o+YaBI/kNY04XEaOu/k57mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122981; c=relaxed/simple;
	bh=61UMdz6PwPrUAEqtPmAiWu/Zm3GRSE+hjmVW0EJWds0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=py1rhZx2PD2mJ2W481vLedjl2W/tt2NYSo17hp+MWaan6g0hCu39JRadN6fclwNZWFi5u7Z1ILLqXWFrmnsCXKMHgqwa2n18bRPhSbZZ4HGm6pY04e9Ukc/bFMLeo4dZAn0f/RukSsOeBgP71smV77UqlL8xe6+fs/D9WICV/BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=CrTFeYBQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726122977; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fQ+6N5ViUzK+ceegFWpObEHz+RnOebnwb406CimsRI7T7zR8Ub6CkAmCY4mf4EpnUf7i/shvE/Ngy75MBMl9EcWwT/dzdo+DbGBDVf171Bz7mxNzzGzGHJMEA4gok7lvG6t3naCZGWmgwk9B0kJZrRbdmWs8cUhq3wP0tkbgzo4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726122977; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jwoXeBXN1Cdrx5uDSRKPlZK4scdoNuO8q665Nvn4o4w=; 
	b=mCoxs51iN5Jo3q9l48whnL2dHpY1PwYw+z+M7c/tK8r0mMuJIyLq4l+b5H/jGiMo+SIA5ijgWnFSdm1Wv90pVwhXzyEdCMO30YWtsRHxmPo7ugfaLwWcA2uiTx8GxYb1WM5eept9EdmYX4a9DWUDJTTTkiMo+vfWR4TMDPY0T48=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726122977;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jwoXeBXN1Cdrx5uDSRKPlZK4scdoNuO8q665Nvn4o4w=;
	b=CrTFeYBQv7M1QWt1CdFn1TjNOtwtLzKPqpdJb5C9R5aJJOVwa/4+sXM+WeM4EnhF
	bAtvV0cFyeuArYJVqC2UysbCj1TIPnlbGQXPSgg6T3Rokk46Y7ApQRm19+4tnrXCrnD
	JPguRHP000iCJrTxBqUo2Pa+5YJuWPNtmmKuBcqI=
Received: by mx.zohomail.com with SMTPS id 1726122975087477.75692641145986;
	Wed, 11 Sep 2024 23:36:15 -0700 (PDT)
Message-ID: <b33db5d3-2407-4d25-a516-f0fd8d74a827@collabora.com>
Date: Thu, 12 Sep 2024 11:36:08 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-fsdevel@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
Subject: Re: [bug report] fs/proc/task_mmu: implement IOCTL to get and
 optionally clear info about PTEs
To: Dan Carpenter <dan.carpenter@linaro.org>
References: <3a4e2a3e-b395-41e6-807d-0e6ad8722c7d@stanley.mountain>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <3a4e2a3e-b395-41e6-807d-0e6ad8722c7d@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Dan,

Thank you for reporting.

On 9/11/24 3:21 PM, Dan Carpenter wrote:
> Hello Muhammad Usama Anjum,
> 
> Commit 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and
> optionally clear info about PTEs") from Aug 21, 2023 (linux-next),
> leads to the following Smatch static checker warning:
> 
> 	fs/proc/task_mmu.c:2664 pagemap_scan_get_args()
> 	warn: potential user controlled sizeof overflow 'arg->vec_len * 24' '0-u64max * 24' type='ullong'
> 
> fs/proc/task_mmu.c
>     2637 static int pagemap_scan_get_args(struct pm_scan_arg *arg,
>     2638                                  unsigned long uarg)
>     2639 {
>     2640         if (copy_from_user(arg, (void __user *)uarg, sizeof(*arg)))
> 
> arg comes from the user
> 
>     2641                 return -EFAULT;
>     2642 
>     2643         if (arg->size != sizeof(struct pm_scan_arg))
>     2644                 return -EINVAL;
>     2645 
>     2646         /* Validate requested features */
>     2647         if (arg->flags & ~PM_SCAN_FLAGS)
>     2648                 return -EINVAL;
>     2649         if ((arg->category_inverted | arg->category_mask |
>     2650              arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATEGORIES)
>     2651                 return -EINVAL;
>     2652 
>     2653         arg->start = untagged_addr((unsigned long)arg->start);
>     2654         arg->end = untagged_addr((unsigned long)arg->end);
>     2655         arg->vec = untagged_addr((unsigned long)arg->vec);
>     2656 
>     2657         /* Validate memory pointers */
>     2658         if (!IS_ALIGNED(arg->start, PAGE_SIZE))
>     2659                 return -EINVAL;
> 
> We should probably check ->end here as well.
> 
>     2660         if (!access_ok((void __user *)(long)arg->start, arg->end - arg->start))
I'll add check to verify that end is equal or greater than start.

> 
> Otherwise we're checking access_ok() and then making ->end larger.  Maybe move
> the arg->end = ALIGN(arg->end, PAGE_SIZE) before the access_ok() check?
> 
>     2661                 return -EFAULT;
>     2662         if (!arg->vec && arg->vec_len)
>     2663                 return -EINVAL;
> --> 2664         if (arg->vec && !access_ok((void __user *)(long)arg->vec,
>     2665                               arg->vec_len * sizeof(struct page_region)))
> 
> This "arg->vec_len * sizeof(struct page_region)" multiply could have an integer
> overflow.
I'll check for overflow before calling access_ok().

> 
> arg->vec_len is a u64 so size_add() won't work on a 32bit system.  I wonder if
> size_add() should check for sizes larger than SIZE_MAX?
> 
>     2666                 return -EFAULT;
>     2667 
>     2668         /* Fixup default values */
>     2669         arg->end = ALIGN(arg->end, PAGE_SIZE);
>     2670         arg->walk_end = 0;
>     2671         if (!arg->max_pages)
>     2672                 arg->max_pages = ULONG_MAX;
>     2673 
>     2674         return 0;
>     2675 }
I'll send fix soon.

> 
> regards,
> dan carpenter

-- 
BR,
Muhammad Usama Anjum


