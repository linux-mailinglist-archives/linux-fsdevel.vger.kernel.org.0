Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8286E396BB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 04:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhFAC7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 22:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhFAC67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 22:58:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AE6C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 19:57:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id jz2-20020a17090b14c2b0290162cf0b5a35so575980pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 19:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=g1PHDhhxCS5yi9x7VR5tTU+yhTRifgFTSodvUZspY38=;
        b=gu3h0aceBpPFczJDv9Pi+fQSM09xTOA591JpnjzIQVDiyd0d7iN0pU3mknLbA87WW/
         dg0IOl6q8OLmHiER0Q+/3cBhbECxfmbvnC9XJaUmKL27cpvPEx7bu8odCgOTHxJ3ignP
         vcQNwSNLSZhSt1QMB/TIJ3wIHAb7speMs+X3GmErM/YIBVoypH/C/NFqrgy9F7Ob8XHn
         QwX4qsTc7p/N1JQ4PynIQH72F1ffsvA8EowqbmaEJnwI6yOzolSroeUTihAAfeKDfCsW
         zVq243bZjcqaov2YGV7wT8+Pjw7l/duVKbeKh/7hwrTSxwAamVDl7JEAjzyt9XXOI8bH
         ZNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=g1PHDhhxCS5yi9x7VR5tTU+yhTRifgFTSodvUZspY38=;
        b=IphX08m7ezRXHvokB01ZiAitmhF2znUVt/FTSl4C8odJ1NtXfN8ZxIn7bBFnCY0Ipe
         9CuvtXKCRFpJJzM2ioNgsyv7i/9zixDq045nvaAUPSzqo3SX2sOhDsvyFZi9Tg1MNZuY
         CkNtvpkjyXgYQC2Bi3GsLhNLSIkW1BfG9nb6QM/Pz97aiNsthpveUSDwgvaTy4jWDyYT
         i22zh7hyiK3CdYXprWXpykKv2TNgpOOLesdifmw/clq4vbmsZa9yRf2izMTXOto1FpGw
         2rSAN/tcKUGXeDgTlcNfR0Y7v4Ma3u0qbjr0ndm4vwQ4s6yc+iC18+lBdzzhNZ5aSWFO
         ywvg==
X-Gm-Message-State: AOAM530zp4bzl7zdsQ1+pPeDw82ad64YjZYmiepn04bWDwKWQ5qoxvlj
        VSSx/sbLGp42Pow2WlhHJYy6fA==
X-Google-Smtp-Source: ABdhPJw5se7nGmi1mY4jYYGJgMtQfC0d2xDPLu0O23svfDmLl1Fh+jQphNvKrqTQp4FUhtKilfqG4Q==
X-Received: by 2002:a17:90a:bd08:: with SMTP id y8mr2298232pjr.8.1622516237963;
        Mon, 31 May 2021 19:57:17 -0700 (PDT)
Received: from [10.86.119.121] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id f16sm12057659pju.12.2021.05.31.19.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 19:57:17 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] fs/proc/kcore.c: add mmap interface
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     adobriyan@gmail.com, rppt@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, chenying.kernel@bytedance.com,
        zhengqi.arch@bytedance.com
References: <20210526075142.9740-1-zhoufeng.zf@bytedance.com>
 <20210531182344.e9692132981a5bf9bf6d4583@linux-foundation.org>
From:   zhoufeng <zhoufeng.zf@bytedance.com>
Message-ID: <06da9f61-3003-078a-4e44-722e978cecd3@bytedance.com>
Date:   Tue, 1 Jun 2021 10:57:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531182344.e9692132981a5bf9bf6d4583@linux-foundation.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



ÔÚ 2021/6/1 ÉÏÎç9:23, Andrew Morton Ð´µÀ:
> On Wed, 26 May 2021 15:51:42 +0800 Feng zhou <zhoufeng.zf@bytedance.com> wrote:
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
>> --- a/fs/proc/kcore.c
>> +++ b/fs/proc/kcore.c
>> @@ -573,11 +573,81 @@ static int release_kcore(struct inode *inode, struct file *file)
>>   	return 0;
>>   }
>>   
>> +static vm_fault_t mmap_kcore_fault(struct vm_fault *vmf)
>> +{
>> +	return VM_FAULT_SIGBUS;
>> +}
>> +
>> +static const struct vm_operations_struct kcore_mmap_ops = {
>> +	.fault = mmap_kcore_fault,
>> +};
>> +
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
>> +			pfn = __pa(start) >> PAGE_SHIFT;
>> +		else if (m->type == KCORE_TEXT)
>> +			pfn = __pa_symbol(start) >> PAGE_SHIFT;
>> +		else {
>> +			ret = -EFAULT;
>> +			goto out;
>> +		}
>> +
>> +		if (remap_pfn_range(vma, vma->vm_start, pfn, size,
>> +				vma->vm_page_prot)) {
>> +			ret = -EAGAIN;
> 
> EAGAIN seems a strange errno for this case.   The mmap manpage says
> 
>         EAGAIN The file has been locked, or too much  memory  has  been  locked
>                (see setrlimit(2)).
> 
> 
> remap_pfn_range() already returns an errno - why not return whatever
> that code was?
> 

   yes, that's a good idea.

>> +			goto out;
>> +		}
>> +	} else {
>> +		ret = -EFAULT;
>> +	}
>> +
>> +out:
>> +	up_read(&kclist_lock);
>> +	return ret;
>> +}
>> +
>>   static const struct proc_ops kcore_proc_ops = {
>>   	.proc_read	= read_kcore,
>>   	.proc_open	= open_kcore,
>>   	.proc_release	= release_kcore,
>>   	.proc_lseek	= default_llseek,
>> +	.proc_mmap	= mmap_kcore,
>>   };
>>   
>>   /* just remember that we have to update kcore */
> 
> Otherwise looks OK to me.  Please update the changelog to reflect the
> discussion thus far and send a v2?
> 
   OK, I am very happy to do so, I will send a v2 in two days.
