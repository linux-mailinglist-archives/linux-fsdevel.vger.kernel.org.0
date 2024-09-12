Return-Path: <linux-fsdevel+bounces-29144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F66B9765BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 11:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26681F214F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B085190057;
	Thu, 12 Sep 2024 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="GzoRH4xm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F5188910
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133712; cv=pass; b=Uf6loNauRPaRcCmnZlpfqCdVHZkquJbjSppZjclHSRzo8NNfaW7w5EdivQc+CjaOJR77LYzsAY9kO8c/pTsxGjee8Y8bGKK15utaEirRQpVL5x1eNaCvCxu3YqQusX2byemrRBL51s1LM/kCC3/nL2GOHq3Kp1uqik8kbPxI20U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133712; c=relaxed/simple;
	bh=iXsmtVzVopqHXLdONAhccBM+ywVkZnStJOTjrh/wmW8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WecoTBVEx8JfPFZ6fJrYMve1Ry9WygiYq8BItmfqPjFckMWNyJ/xl2g6p4Dk/lDSksL8v9T8QhOaIe481WiD0GKT6FljrwXUn7AjWIKIWq+ykmnGSFCCXrWck32FQsaB6JsetEkLNEt2flZuewUlhUeRS6fZ8pvephor8wuW31s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=GzoRH4xm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726133703; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L1sVBzz+Q//JWpyjuu7csmCT6cHY7f1SfyvmJFyExKmnvoHGS+3L60MPe47J7Ry5mnXbKlxwXQw4NkVOqfmIqkZED3VJ/trzlre3xmQ+Rys9UDWIxeCC6DeMSxQB3zApyM6agwj7pvDRF+haK+Sd/c2TRNBZFpS5Boakq0rh1eE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726133703; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E0n7JRVOdlG+c3taXjUGqlrkCmLavvou2F5X4LHBmrA=; 
	b=QqdKB1m8faNa8c1w6T38zghafV544IGX+hnckpCFrEZ7VUvsVh4jjRelYq5gDAryWmW1nn7Rn8TxhrEcCiztThXm2Ya1l68eC96Bg0noOEK/1XVZXeQ2OBQ/e19Pak/HTO5fHqeL5NhMUn57UBNopHJ3N3qUK6O/1mcAMHV0zLE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726133703;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=E0n7JRVOdlG+c3taXjUGqlrkCmLavvou2F5X4LHBmrA=;
	b=GzoRH4xmtRlxdsD8tsUf+S8ildZ4+cdvQYc6korTIqoc6iXJxMghFUUvUPOJqRMu
	7ZMdUsiioAuqFocKlj6+VHWPgG6IAU0HUJ5pvC+pbzpx+9tbcxByaxUrDdxkv9VYWlI
	MPKXZvRiw4COIbaFAIV9lt/I0tBg21Ldvsffbfuk=
Received: by mx.zohomail.com with SMTPS id 1726133702205592.6102112099303;
	Thu, 12 Sep 2024 02:35:02 -0700 (PDT)
Message-ID: <d3db84fc-c107-423d-9f02-3cae0217b576@collabora.com>
Date: Thu, 12 Sep 2024 14:34:54 +0500
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
To: Dan Carpenter <dan.carpenter@linaro.org>, linux-mm@kvack.org
References: <3a4e2a3e-b395-41e6-807d-0e6ad8722c7d@stanley.mountain>
 <b33db5d3-2407-4d25-a516-f0fd8d74a827@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <b33db5d3-2407-4d25-a516-f0fd8d74a827@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/12/24 11:36 AM, Muhammad Usama Anjum wrote:
> Hi Dan,
> 
> Thank you for reporting.
I've debugged more and found out that no changes are required as
access_ok() already deals well with the overflows. I've tested the
corner cases on x86_64 and there are no issue found.

I'll add more test cases in the selftest for this ioctl. Please share
your thoughts if I may have missed something.

> 
> On 9/11/24 3:21 PM, Dan Carpenter wrote:
>> Hello Muhammad Usama Anjum,
>>
>> Commit 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and
>> optionally clear info about PTEs") from Aug 21, 2023 (linux-next),
>> leads to the following Smatch static checker warning:
>>
>> 	fs/proc/task_mmu.c:2664 pagemap_scan_get_args()
>> 	warn: potential user controlled sizeof overflow 'arg->vec_len * 24' '0-u64max * 24' type='ullong'
>>
>> fs/proc/task_mmu.c
>>     2637 static int pagemap_scan_get_args(struct pm_scan_arg *arg,
>>     2638                                  unsigned long uarg)
>>     2639 {
>>     2640         if (copy_from_user(arg, (void __user *)uarg, sizeof(*arg)))
>>
>> arg comes from the user
>>
>>     2641                 return -EFAULT;
>>     2642 
>>     2643         if (arg->size != sizeof(struct pm_scan_arg))
>>     2644                 return -EINVAL;
>>     2645 
>>     2646         /* Validate requested features */
>>     2647         if (arg->flags & ~PM_SCAN_FLAGS)
>>     2648                 return -EINVAL;
>>     2649         if ((arg->category_inverted | arg->category_mask |
>>     2650              arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATEGORIES)
>>     2651                 return -EINVAL;
>>     2652 
>>     2653         arg->start = untagged_addr((unsigned long)arg->start);
>>     2654         arg->end = untagged_addr((unsigned long)arg->end);
>>     2655         arg->vec = untagged_addr((unsigned long)arg->vec);
>>     2656 
>>     2657         /* Validate memory pointers */
>>     2658         if (!IS_ALIGNED(arg->start, PAGE_SIZE))
>>     2659                 return -EINVAL;
>>
>> We should probably check ->end here as well.
>>
>>     2660         if (!access_ok((void __user *)(long)arg->start, arg->end - arg->start))
> I'll add check to verify that end is equal or greater than start.
> 
>>
>> Otherwise we're checking access_ok() and then making ->end larger.  Maybe move
>> the arg->end = ALIGN(arg->end, PAGE_SIZE) before the access_ok() check?
>>
>>     2661                 return -EFAULT;
>>     2662         if (!arg->vec && arg->vec_len)
>>     2663                 return -EINVAL;
>> --> 2664         if (arg->vec && !access_ok((void __user *)(long)arg->vec,
>>     2665                               arg->vec_len * sizeof(struct page_region)))
>>
>> This "arg->vec_len * sizeof(struct page_region)" multiply could have an integer
>> overflow.
> I'll check for overflow before calling access_ok().
> 
>>
>> arg->vec_len is a u64 so size_add() won't work on a 32bit system.  I wonder if
>> size_add() should check for sizes larger than SIZE_MAX?
>>
>>     2666                 return -EFAULT;
>>     2667 
>>     2668         /* Fixup default values */
>>     2669         arg->end = ALIGN(arg->end, PAGE_SIZE);
>>     2670         arg->walk_end = 0;
>>     2671         if (!arg->max_pages)
>>     2672                 arg->max_pages = ULONG_MAX;
>>     2673 
>>     2674         return 0;
>>     2675 }
> I'll send fix soon.
> 
>>
>> regards,
>> dan carpenter
> 

-- 
BR,
Muhammad Usama Anjum


