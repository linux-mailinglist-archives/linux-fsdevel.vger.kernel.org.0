Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEF2481EA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 18:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbhL3Rcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 12:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhL3Rcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 12:32:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91046C061574;
        Thu, 30 Dec 2021 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=aA9xBCuC2t/FCahUtFoF9vl9PxKpUL1fgzD9EinxOdo=; b=Z8drxXgAC81DL2C+p/fauQxUXf
        NsKPhFvqfekg/WFrvVja5bA4fBORGdpvl0dWCK1Aoy3l5uVtRvRBA9iSLlKP7MEsBfdf/5Fu5FSLU
        sDrJhGQg0kzhDDj/znSXRYMKj8gNfjGfKfzPuBuKqbI+FiNy+JxXh4xugYlsC7E9GWKVC6f1MDl9S
        Y6gPYgQNL7lvyLoboMGvlG7EvgBVcGm9mBUQH3kBagIVy5gjGwDniIoBNVLLGX4ciE9bYzSNqeSxg
        TaJvSv6YFKo1M5aY7TKF3d6WSTbKPOsj5qwdeTGeZpTdggtOoHpx+gKJFlk48Ggu+VoGK6+XLFRGa
        4m2kFgjQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n2zI7-009x46-N5; Thu, 30 Dec 2021 17:32:39 +0000
Message-ID: <3ad11107-30d8-ab75-961b-8142404c8c21@infradead.org>
Date:   Thu, 30 Dec 2021 09:32:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: mmotm 2021-12-29-20-07 uploaded (mm/damon)
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        SeongJae Park <sj@kernel.org>
References: <20211230040740.SbquJAFf5%akpm@linux-foundation.org>
 <a57f9bc4-2c1b-f819-17a6-2e1d2f9dd173@infradead.org>
 <1aaf9c11-0d8e-b92d-5c92-46e50a6e8d4e@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1aaf9c11-0d8e-b92d-5c92-46e50a6e8d4e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/29/21 22:33, Baolin Wang wrote:
> Hi,
> 
> On 12/30/2021 2:27 PM, Randy Dunlap wrote:
>> Hi--
>>
>> On 12/29/21 20:07, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2021-12-29-20-07 has been uploaded to
>>>
>>>     https://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> https://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>> https://ozlabs.org/~akpm/mmotm/series
>>>
>>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>>> followed by the base kernel version against which this patch series is to
>>> be applied.
>>
>>
>> On i386:
>>
>> ../mm/damon/vaddr.c: In function ‘damon_hugetlb_mkold’:
>> ../mm/damon/vaddr.c:402:17: warning: unused variable ‘h’ [-Wunused-variable]
>>    struct hstate *h = hstate_vma(vma);
> 
> Ah, thanks for report, I think below changes can fix the warning. And I'll send a new version to address this warning.

Yes, that works. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index bcdc602..25bff8a 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -397,7 +397,6 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
>                                 struct vm_area_struct *vma, unsigned long addr)
>  {
>         bool referenced = false;
> -       struct hstate *h = hstate_vma(vma);
>         pte_t entry = huge_ptep_get(pte);
>         struct page *page = pte_page(entry);
> 
> @@ -414,7 +413,7 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
>         }
> 
>  #ifdef CONFIG_MMU_NOTIFIER
> -       if (mmu_notifier_clear_young(mm, addr, addr + huge_page_size(h)))
> +       if (mmu_notifier_clear_young(mm, addr, addr + huge_page_size(hstate_vma(vma))))
>                 referenced = true;
>  #endif /* CONFIG_MMU_NOTIFIER */

-- 
~Randy
