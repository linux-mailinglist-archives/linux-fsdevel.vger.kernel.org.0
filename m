Return-Path: <linux-fsdevel+bounces-28059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BFF9664D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FDF288D65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2251B5313;
	Fri, 30 Aug 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="va46Gk3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B251B3B26;
	Fri, 30 Aug 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030017; cv=none; b=RpE/8Xw4OMoPLXLj9K9O9En1aU1JEKK49cD+wIfMcIjZ6beO7EJotbZLklpTCXbeA1nNVFaTQ85KqmJRZtuJX73pNSw2CFZpMwnDYuxKaqFMfSzJBGgspglyw0eYGZBCU255JrUV768449tVJxxM2zVfPRArk8Q2tllrG0i1BAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030017; c=relaxed/simple;
	bh=aJCHJj7F4yJudNln15m+N2CXk++Y3uyJTjRDdigtxmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yodcwfmesk1DOPi2eXsJBpl2gWx5/2MirR28WABPbXx6XmIeIHgWyLr07yNbGRdlTXuXaFYtbXDA8Uu0Kt4MrC9f7Hoxonf7tIQSSu/fX0HMGnUrM6ml/QjQE4te+qKQAX2gwejDW81RYXyT1tOgPtG2OJacLJfZtorgChlIXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=va46Gk3u; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WwLsy0nx7z9scM;
	Fri, 30 Aug 2024 17:00:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1725030006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uSe2WIIADtHW0OxB1UXZsiUdfZiRjBZGocb5aTsJciI=;
	b=va46Gk3u6PyxNBujpeH70lN5Ye/FJog7YLsIMawnr4bzneiKXMTARkqve4g9gFstPG2dNs
	DbM0qbI79lFdbTY/0vx2jIq9MkzJfV8Qt5d5k0GQWh2c+4I87EfgqipWKAEQErMysEMwt6
	qlCh5hjYi8aFrJ0AFIfwdrxrAmiGyUfAuICDSjm+Wt63BeowiBNUoAhMuZ3UBJ/Tu39w7n
	0uPigJg238xnS4tzMxkXRqugVN6Q3QBZT1UWR9j0S8RUmKEnM4q/+OIisVgz9DG+aM1roa
	hcGfMee4kQTPKgd5EoLs7i7DHw3tHEKxU1lQbctckc0QUlXhFFyqUQNyODNs0A==
Message-ID: <2477a817-b482-43ed-9fd3-a7f8f948495f@pankajraghav.com>
Date: Fri, 30 Aug 2024 16:59:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
To: Luis Chamberlain <mcgrof@kernel.org>, Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, Sven Schnelle
 <svens@linux.ibm.com>, brauner@kernel.org, akpm@linux-foundation.org,
 chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org, djwong@kernel.org,
 hare@suse.de, gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
 david@fromorbit.com, yang@os.amperecomputing.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, john.g.garry@oracle.com,
 cl@os.amperecomputing.com, p.raghav@samsung.com, ryan.roberts@arm.com,
 David Howells <dhowells@redhat.com>, linux-s390@vger.kernel.org
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
 <yt9dttf3r49e.fsf@linux.ibm.com> <ZtDCErRjh8bC5Y1r@bombadil.infradead.org>
 <ZtDSJuI2hYniMAzv@casper.infradead.org>
 <221FAE59-097C-4D31-A500-B09EDB07C285@nvidia.com>
 <ZtEHPAsIHKxUHBZX@bombadil.infradead.org>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <ZtEHPAsIHKxUHBZX@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/08/2024 01:41, Luis Chamberlain wrote:
> On Thu, Aug 29, 2024 at 06:12:26PM -0400, Zi Yan wrote:
>> The issue is that the change to split_huge_page() makes split_huge_page_to_list_to_order()
>> unlocks the wrong subpage. split_huge_page() used to pass the “page” pointer
>> to split_huge_page_to_list_to_order(), which keeps that “page” still locked.
>> But this patch changes the “page” passed into split_huge_page_to_list_to_order()
>> always to the head page.
>>
>> This fixes the crash on my x86 VM, but it can be improved:
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 7c50aeed0522..eff5d2fb5d4e 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -320,10 +320,7 @@ bool can_split_folio(struct folio *folio, int *pextra_pins);
>>  int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>                 unsigned int new_order);
>>  int split_folio_to_list(struct folio *folio, struct list_head *list);
>> -static inline int split_huge_page(struct page *page)
>> -{
>> -       return split_folio(page_folio(page));
>> -}
>> +int split_huge_page(struct page *page);
>>  void deferred_split_folio(struct folio *folio);
>>
>>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index c29af9451d92..4d723dab4336 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3297,6 +3297,25 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>         return ret;
>>  }
>>
>> +int split_huge_page(struct page *page)
>> +{
>> +       unsigned int min_order = 0;
>> +       struct folio *folio = page_folio(page);
>> +
>> +       if (folio_test_anon(folio))
>> +               goto out;
>> +
>> +       if (!folio->mapping) {
>> +               if (folio_test_pmd_mappable(folio))
>> +                       count_vm_event(THP_SPLIT_PAGE_FAILED);
>> +               return -EBUSY;
>> +       }
>> +
>> +       min_order = mapping_min_folio_order(folio->mapping);
>> +out:
>> +       return split_huge_page_to_list_to_order(page, NULL, min_order);
>> +}
>> +
>>  int split_folio_to_list(struct folio *folio, struct list_head *list)
>>  {
>>         unsigned int min_order = 0;
> 
> 
> Confirmed, and also although you suggest it can be improved, I thought
> that we could do that by sharing more code and putting things in the
> headers, the below also fixes this but tries to share more code, but
> I think it is perhaps less easier to understand than your patch.
> 
It feels a bit weird to pass both folio and the page in `split_page_folio_to_list()`.

How about we extract the code that returns the min order so that we don't repeat.

Something like this:


diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c275aa9cc105..d27febd5c639 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -331,10 +331,24 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
 bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
 int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
                unsigned int new_order);
+int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
 static inline int split_huge_page(struct page *page)
 {
-       return split_folio(page_folio(page));
+       struct folio *folio = page_folio(page);
+       int ret = min_order_for_split(folio);
+
+       if (ret)
+               return ret;
+
+       /*
+        * split_huge_page() locks the page before splitting and
+        * expects the same page that has been split to be locked when
+        * returned. split_folio_to_list() cannot be used here because
+        * it converts the page to folio and passes the head page to be
+        * split.
+        */
+       return split_huge_page_to_list_to_order(page, NULL, ret);
 }
 void deferred_split_folio(struct folio *folio);

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 169f1a71c95d..b167e036d01b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3529,12 +3529,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
        return ret;
 }

-int split_folio_to_list(struct folio *folio, struct list_head *list)
+int min_order_for_split(struct folio *folio)
 {
-       unsigned int min_order = 0;
-
        if (folio_test_anon(folio))
-               goto out;
+               return 0;

        if (!folio->mapping) {
                if (folio_test_pmd_mappable(folio))
@@ -3542,10 +3540,17 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
                return -EBUSY;
        }

-       min_order = mapping_min_folio_order(folio->mapping);
-out:
-       return split_huge_page_to_list_to_order(&folio->page, list,
-                                                       min_order);
+       return mapping_min_folio_order(folio->mapping);
+}
+
+int split_folio_to_list(struct folio *folio, struct list_head *list)
+{
+       int ret = min_order_for_split(folio);
+
+       if (ret)
+               return ret;
+
+       return split_huge_page_to_list_to_order(&folio->page, list, ret);
 }

 void __folio_undo_large_rmappable(struct folio *folio)

> So I think your patch is cleaner and easier as a fix.
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c275aa9cc105..99cd9c7bf55b 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -97,6 +97,7 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
>  	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
>  
>  #define split_folio(f) split_folio_to_list(f, NULL)
> +#define split_folio_to_list(f, list) split_page_folio_to_list(&f->page, f, list)
>  
>  #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
>  #define HPAGE_PMD_SHIFT PMD_SHIFT
> @@ -331,10 +332,11 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>  bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>  int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		unsigned int new_order);
> -int split_folio_to_list(struct folio *folio, struct list_head *list);
> +int split_page_folio_to_list(struct page *page, struct folio *folio,
> +			     struct list_head *list);
>  static inline int split_huge_page(struct page *page)
>  {
> -	return split_folio(page_folio(page));
> +	return split_page_folio_to_list(page, page_folio(page), NULL);
>  }
>  void deferred_split_folio(struct folio *folio);
>  
> @@ -511,7 +513,9 @@ static inline int split_huge_page(struct page *page)
>  	return 0;
>  }
>  
> -static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
> +static inline int split_page_folio_to_list(struct page *page,
> +					   struct folio *folio,
> +					   struct list_head *list)
>  {
>  	return 0;
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 169f1a71c95d..b115bfe63b52 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3529,7 +3529,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  	return ret;
>  }
>  
> -int split_folio_to_list(struct folio *folio, struct list_head *list)
> +int split_page_folio_to_list(struct page *page, struct folio *folio,
> +			     struct list_head *list)
>  {
>  	unsigned int min_order = 0;
>  
> @@ -3544,8 +3545,7 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
>  
>  	min_order = mapping_min_folio_order(folio->mapping);
>  out:
> -	return split_huge_page_to_list_to_order(&folio->page, list,
> -							min_order);
> +	return split_huge_page_to_list_to_order(page, list, min_order);
>  }
>  
>  void __folio_undo_large_rmappable(struct folio *folio)

