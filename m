Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBB3397F1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 04:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhFBCdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 22:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhFBCdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:33:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E11C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 19:31:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k7so782438pjf.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 19:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=sT/ogThoChr1uPFVVzKVR3CGfQEDl6jQU/9/uFyWW5g=;
        b=R9SHjWMTNpwstv/KAwlpVle1p5NurrO10Nvcb7Vjyuop9tVSCA42g8zz5PZY5Wrzrz
         FYKfTjjUvMYQBCxBG9FQutYPG11L+K45/FrOX8zcg74Mj7wMgx8lw2AWRqqmEj1wDWrV
         t7UTR3pqRrCXMTso4D4WiEg/ZQDspEPKPPJJIEJEPkk3bbacXj8onLXOJYKlVD4tCW8o
         vTv6Z707Weo+A4cz6F56Ri26U3Rx4t9ZEHL8xGylXpIjQeVzPRvxHUO4nNQ43rUt3Qaz
         ZkBxtyzzYSRsbYsi+dfU6AB3lkeH70d4G9VPOyC6ZWtaW4Uam9muoVY9r3nCSE9HplXi
         X1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sT/ogThoChr1uPFVVzKVR3CGfQEDl6jQU/9/uFyWW5g=;
        b=XDoBh3UFo2ogwt2BWvEzD6KkKw6IxE0vVzFV4A8REO3HQtbrQynZPHC72RSBrheZ3i
         +ls6vj7PrBSsaX9wVIt0LlipDrupXz6Azh+tydy3xthwUb9Xb90DSm9OAZKk0idxre/T
         ksRwaWDTIaEdYw7AOo0qlIFYBmfDP0OH2uX8yGK9xZ7GUOjspnFNycWKd4ymibe2xO6y
         IdHArFwiK6/D+FOxSHNHhK3qJnjH9dmzY5IfeFOTwIJ5RAUFxdVeeSk0d/XyBzn8vllt
         eZEUsfdTyuPU+H1xQBnlBER7TRbRUy5gqdyp0dCcbrBx5ap4hJMx60Gg8mcF2hs2P/ht
         hvUw==
X-Gm-Message-State: AOAM532pN8QNqEJLjAwq93x94jAqlz3R4VW8nu8Wu8VqO19wHBizowrR
        F4YViMUKkftgdr0nQwak9kM1Lg==
X-Google-Smtp-Source: ABdhPJwb+DeSZnRW4rwnn+8msc5yEgIKNM8POntUbCZwyaInAWajfp7lemFjPNJpBZnKi7mhxS7cxQ==
X-Received: by 2002:a17:902:e309:b029:f1:9342:2036 with SMTP id q9-20020a170902e309b02900f193422036mr28802305plc.53.1622601111408;
        Tue, 01 Jun 2021 19:31:51 -0700 (PDT)
Received: from [10.86.119.121] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id q24sm15120581pgb.19.2021.06.01.19.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 19:31:50 -0700 (PDT)
Subject: Re: [External] Re: [PATCH v2] fs/proc/kcore.c: add mmap interface
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     adobriyan@gmail.com, rppt@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, chenying.kernel@bytedance.com,
        zhengqi.arch@bytedance.com
References: <20210601082241.13378-1-zhoufeng.zf@bytedance.com>
 <20210601192257.65a514606382f0a972f918c3@linux-foundation.org>
From:   zhoufeng <zhoufeng.zf@bytedance.com>
Message-ID: <be411abf-1794-521a-8c79-0a3cbea4d3bd@bytedance.com>
Date:   Wed, 2 Jun 2021 10:31:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601192257.65a514606382f0a972f918c3@linux-foundation.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



ÔÚ 2021/6/2 ÉÏÎç10:22, Andrew Morton Ð´µÀ:
> On Tue,  1 Jun 2021 16:22:41 +0800 Feng zhou <zhoufeng.zf@bytedance.com> wrote:
> 
>> From: ZHOUFENG <zhoufeng.zf@bytedance.com>
>>
>> When we do the kernel monitor, use the DRGN
>> (https://github.com/osandov/drgn) access to kernel data structures,
>> found that the system calls a lot. DRGN is implemented by reading
>> /proc/kcore. After looking at the kcore code, it is found that kcore
>> does not implement mmap, resulting in frequent context switching
>> triggered by read. Therefore, we want to add mmap interface to optimize
>> performance. Since vmalloc and module areas will change with allocation
>> and release, consistency cannot be guaranteed, so mmap interface only
>> maps KCORE_TEXT and KCORE_RAM.
>>
>> ...
>>
>> +static int mmap_kcore(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	size_t size = vma->vm_end - vma->vm_start;
>> +	u64 start, pfn;
>> +	int nphdr;
>> +	size_t data_offset;
>> +	size_t phdrs_len, notes_len;
>> +	struct kcore_list *m = NULL;
>> +	int ret = 0;
>> +
>> +	down_read(&kclist_lock);
>> +
>> +	get_kcore_size(&nphdr, &phdrs_len, &notes_len, &data_offset);
>> +
>> +	start = kc_offset_to_vaddr(((u64)vma->vm_pgoff << PAGE_SHIFT) -
>> +		((data_offset >> PAGE_SHIFT) << PAGE_SHIFT));
>> +
>> +	list_for_each_entry(m, &kclist_head, list) {
>> +		if (start >= m->addr && size <= m->size)
>> +			break;
>> +	}
>> +
>> +	if (&m->list == &kclist_head) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	if (vma->vm_flags & (VM_WRITE | VM_EXEC)) {
>> +		ret = -EPERM;
>> +		goto out;
>> +	}
>> +
>> +	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
>> +	vma->vm_flags |= VM_MIXEDMAP;
>> +	vma->vm_ops = &kcore_mmap_ops;
>> +
>> +	if (kern_addr_valid(start)) {
>> +		if (m->type == KCORE_RAM || m->type == KCORE_REMAP)
> 
> KCORE_REMAP was removed by
> https://lkml.kernel.org/r/20210526093041.8800-2-david@redhat.com
> 
> I did this:
> 
> --- a/fs/proc/kcore.c~fs-proc-kcorec-add-mmap-interface-fix
> +++ a/fs/proc/kcore.c
> @@ -660,7 +660,7 @@ static int mmap_kcore(struct file *file,
>   	vma->vm_ops = &kcore_mmap_ops;
>   
>   	if (kern_addr_valid(start)) {
> -		if (m->type == KCORE_RAM || m->type == KCORE_REMAP)
> +		if (m->type == KCORE_RAM)
>   			pfn = __pa(start) >> PAGE_SHIFT;
>   		else if (m->type == KCORE_TEXT)
>   			pfn = __pa_symbol(start) >> PAGE_SHIFT;
> 

   Thank you very much.
