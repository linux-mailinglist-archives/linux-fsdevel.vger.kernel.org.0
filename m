Return-Path: <linux-fsdevel+bounces-2976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B21C7EE686
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 19:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC86B20BB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 18:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2613364BC;
	Thu, 16 Nov 2023 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJpgJsiH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ECD192
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 10:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700158430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ONyKyGrGZkXEZgyChUzOaaLcqNc/RranTIE1i+0V890=;
	b=AJpgJsiH9Ajvd62BPUZP8N5sxI2FPVnRsC9UacPqWXw3HW1E+g24NKHMtGuWbbmuS88jhX
	z0xauPOz24clvkvF6yZrvs2fGffJvz0qBqg28nwb6LfYjQXW8gCnBQeC8FIPAG3+AK0vHK
	+n3nafvWMCB9IKxt2BKYJ0s8BGfj8Hk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-_g-hM0n0OqeIQqS-Cv4-Sw-1; Thu, 16 Nov 2023 13:13:47 -0500
X-MC-Unique: _g-hM0n0OqeIQqS-Cv4-Sw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-408374a3d6bso6015585e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 10:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700158426; x=1700763226;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONyKyGrGZkXEZgyChUzOaaLcqNc/RranTIE1i+0V890=;
        b=qwzGfjOQt/fBLHE8IBKVoqaAdmoXkuk7xOgJ4dY3O6UGwA3+faNHbxxUOSFp16tV2p
         7wYVH1V+j0UoaDMAAyiHWMl7r1H9nHViLgixqYoupfIeP6AksRBFukaxSrca+y6KnQyX
         onb7EzPti4UvkbC85lszBmcLRIgh/LhYf7CEOJrsY7WM4qbVPRLlkAltUj0k5evzZsoB
         7SM1S/mnRROUV/1OVjxVzfvPUIJungyxb1eQUaTiZ9+DkuWGjIzFaevnTOLzLhzy5wKl
         xYS0sewbBdFGL9Y+/jnd3YGxZAYYDoy4ax4WUeBkVSBRj1nbMlTAuer/+sXeAHH+t7EF
         IKuQ==
X-Gm-Message-State: AOJu0YxtHnUg3faDCO/MgkM/AqsHdqM0tJgz25jfnSM1gOt2AuH2hVJs
	jWUVX8vzfHLLNOSnXWOrkmuuFuEQWZdzpXscY9q6UBAdeIzZgmHiDvsFegsM7C/O2l+DCyqRLYb
	8aarKZjsqufl8NkOPi84gcLlN5A==
X-Received: by 2002:a05:600c:4f92:b0:408:57bb:ef96 with SMTP id n18-20020a05600c4f9200b0040857bbef96mr2470539wmq.30.1700158426021;
        Thu, 16 Nov 2023 10:13:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvC/WDjQ3K/pm+VHYer9HJAY8r0bTQQnbWMq5G76YQXHZVSBBUucnoFb6okpNffqX20tYxrw==
X-Received: by 2002:a05:600c:4f92:b0:408:57bb:ef96 with SMTP id n18-20020a05600c4f9200b0040857bbef96mr2470525wmq.30.1700158425516;
        Thu, 16 Nov 2023 10:13:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:e000:d929:2324:97c7:112c? (p200300cbc714e000d929232497c7112c.dip0.t-ipconnect.de. [2003:cb:c714:e000:d929:2324:97c7:112c])
        by smtp.gmail.com with ESMTPSA id f6-20020a7bcd06000000b0040a463cf09dsm4415094wmj.33.2023.11.16.10.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 10:13:45 -0800 (PST)
Message-ID: <6308590a-d958-4ecc-a478-ba088cf7984d@redhat.com>
Date: Thu, 16 Nov 2023 19:13:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in unmap_page_range (2)
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 syzbot <syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
 wangkefeng.wang@huawei.com
References: <000000000000b0e576060a30ee3b@google.com>
 <20231115140006.cc7de06f89b1f885f4583af0@linux-foundation.org>
 <a8349273-c512-4d23-bf85-5812d2a007d1@redhat.com> <ZVZYvleasZddv-TD@x1n>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZVZYvleasZddv-TD@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> It should be fine, as:
> 
> static void make_uffd_wp_pte(struct vm_area_struct *vma,
> 			     unsigned long addr, pte_t *pte)
> {
> 	pte_t ptent = ptep_get(pte);
> 
> #ifndef CONFIG_USERFAULTFD_
> 
> 	if (pte_present(ptent)) {
> 		pte_t old_pte;
> 
> 		old_pte = ptep_modify_prot_start(vma, addr, pte);
> 		ptent = pte_mkuffd_wp(ptent);
> 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
> 	} else if (is_swap_pte(ptent)) {
> 		ptent = pte_swp_mkuffd_wp(ptent);
> 		set_pte_at(vma->vm_mm, addr, pte, ptent);
> 	} else {                                      <----------------- this must be pte_none() already
> 		set_pte_at(vma->vm_mm, addr, pte,
> 			   make_pte_marker(PTE_MARKER_UFFD_WP));
> 	}
> }

Indeed! Is pte_swp_mkuffd_wp() reasonable for pte markers? I rememebr 
that we don't support multiple markers yet, so it might be good enough.

> 
>>
>> 2) We get the error on arm64, which does *not* support uffd-wp. Do we
>>     maybe end up calling make_uffd_wp_pte() and place a pte marker, even
>>     though we don't have CONFIG_PTE_MARKER_UFFD_WP?
>>
>>
>> static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
>> {
>> #ifdef CONFIG_PTE_MARKER_UFFD_WP
>> 	return is_pte_marker_entry(entry) &&
>> 	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
>> #else
>> 	return false;
>> #endif
>> }
>>
>> Will always return false without CONFIG_PTE_MARKER_UFFD_WP.
>>
>> But make_uffd_wp_pte() might just happily place an entry. Hm.
>>
>>
>> The following might fix the problem:
>>

[...]

> 
> I'd like to double check with Muhammad (as I didn't actually follow his
> work in the latest versions.. quite a lot changed), but I _think_
> fundamentally we missed something important in the fast path, and I think
> it applies even to archs that support uffd..
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e91085d79926..3b81baabd22a 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2171,7 +2171,8 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>                  return 0;
>          }
> 
> -       if (!p->vec_out) {
> +       if (!p->vec_out &&
> +           (p->arg.flags & PM_SCAN_WP_MATCHING))

Ouch, yes. So that's the global fence I was wondering where to find it.

-- 
Cheers,

David / dhildenb


