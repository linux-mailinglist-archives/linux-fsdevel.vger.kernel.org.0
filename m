Return-Path: <linux-fsdevel+bounces-76405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALvzN1iChGl/3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:43:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 890FEF1FDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73AA13008246
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 11:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84E53B5309;
	Thu,  5 Feb 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YREsyiQm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD9170810;
	Thu,  5 Feb 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291793; cv=none; b=gcO7X90mwpEfvoYS6mOWj0mDO59K3vlPA1KmPluCwoZ5i8TFqXSQK4IOhBpJnLoJzZUbvdKe1PY0VgDuuV9Y72bipeRgdvUeILVg2AUifcXCcRJGrbFxldxagfzGoLWmorJ/S07SXNvAkWRKpG5kkJCvHriRdNz3Oef/Uif1uM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291793; c=relaxed/simple;
	bh=SLa9MCFdnRWjJyhu+WPJ0tBsB0AWSHQoPqTMdCSiiTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtnWL6wFyYdLKtsnaIXOrutJnehWNgmsPotEW233R4Tq6lUmXeGYaRkRuaDMaDMseEzXquxmCbKopflW7Q7qrBY2XXFgPvTP7GmF+ZzNrs2Lw+lngMA3c9n1mrz9/RuY0rhvLmQ48Ys9J1XPZzxUBuXBu4osb6eYLvGkT9h0a/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YREsyiQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E944FC4CEF7;
	Thu,  5 Feb 2026 11:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770291793;
	bh=SLa9MCFdnRWjJyhu+WPJ0tBsB0AWSHQoPqTMdCSiiTI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YREsyiQmEFsy3JMHQi78a3njdasjladiYlKxyb0n/bUUgs8SVhhx1R1VAvVF/MMO9
	 GA9bVq6DmgKlrmP++NugWkAC5nRMRMY0Or2IBLpNxmcfDnCDgUExzb3ef5nDZSMm73
	 XVKE/E8tkj8ClHCR/yx1wfC3JVN0rBnSbZREVanz8COMNSa7KOD9VkPu1XCMTmw7/N
	 NfWLd/9WaUzobP477xfSTUUNu0QyRSHvyscq1k+eKgfNDWn1JvRI0EXz+zZ5meU7Ms
	 B2gJQntUd9tW/3uqPmBDhQ9YRQL0CWaq23IrN9UnlFkgZaeIN9w2K7zANipw9Q0911
	 /T3zbV7nKMkqA==
Message-ID: <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org>
Date: Thu, 5 Feb 2026 12:43:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Carlos Llamas <cmllamas@google.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Andrew Morton <akpm@linux-foundation.org>, Dave Chinner
 <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-mm@kvack.org,
 rust-for-linux@vger.kernel.org
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com>
 <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
From: "David Hildenbrand (arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76405-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 890FEF1FDD
X-Rspamd-Action: no action

On 2/5/26 12:29, Lorenzo Stoakes wrote:
> On Thu, Feb 05, 2026 at 10:51:28AM +0000, Alice Ryhl wrote:
>> These are the functions needed by Binder's shrinker.
>>
>> Binder uses zap_page_range_single in the shrinker path to remove an
>> unused page from the mmap'd region. Note that pages are only removed
>> from the mmap'd region lazily when shrinker asks for it.
>>
>> Binder uses list_lru_add/del to keep track of the shrinker lru list, and
>> it can't use _obj because the list head is not stored inline in the page
>> actually being lru freed, so page_to_nid(virt_to_page(item)) on the list
>> head computes the nid of the wrong page.
>>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> ---
>>   mm/list_lru.c | 2 ++
>>   mm/memory.c   | 1 +
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/mm/list_lru.c b/mm/list_lru.c
>> index ec48b5dadf519a5296ac14cda035c067f9e448f8..bf95d73c9815548a19db6345f856cee9baad22e3 100644
>> --- a/mm/list_lru.c
>> +++ b/mm/list_lru.c
>> @@ -179,6 +179,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
>>   	unlock_list_lru(l, false);
>>   	return false;
>>   }
>> +EXPORT_SYMBOL_GPL(list_lru_add);
>>
>>   bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
>>   {
>> @@ -216,6 +217,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
>>   	unlock_list_lru(l, false);
>>   	return false;
>>   }
>> +EXPORT_SYMBOL_GPL(list_lru_del);
> 
> Same point as before about exporting symbols, but given the _obj variants are
> exported already this one is more valid.
> 
>>
>>   bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
>>   {
>> diff --git a/mm/memory.c b/mm/memory.c
>> index da360a6eb8a48e29293430d0c577fb4b6ec58099..64083ace239a2caf58e1645dd5d91a41d61492c4 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -2168,6 +2168,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
>>   	zap_page_range_single_batched(&tlb, vma, address, size, details);
>>   	tlb_finish_mmu(&tlb);
>>   }
>> +EXPORT_SYMBOL(zap_page_range_single);
> 
> Sorry but I don't want this exported at all.
> 
> This is an internal implementation detail which allows fine-grained control of
> behaviour via struct zap_details (which binder doesn't use, of course :)

I don't expect anybody to set zap_details, but yeah, it could be abused.
It could be abused right now from anywhere else in the kernel
where we don't build as a module :)

Apparently we export a similar function in rust where we just removed the last parameter.

I think zap_page_range_single() is only called with non-NULL from mm/memory.c.

So the following makes likely sense even outside of the context of this series:

 From d2a2d20994456b9a66008b7fef12e379e76fc9f8 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (arm)" <david@kernel.org>
Date: Thu, 5 Feb 2026 12:42:09 +0100
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand (arm) <david@kernel.org>
---
  arch/s390/mm/gmap_helpers.c    |  2 +-
  drivers/android/binder_alloc.c |  2 +-
  include/linux/mm.h             |  4 ++--
  kernel/bpf/arena.c             |  3 +--
  kernel/events/core.c           |  2 +-
  mm/memory.c                    | 15 +++++++++------
  net/ipv4/tcp.c                 |  5 ++---
  rust/kernel/mm/virt.rs         |  2 +-
  8 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index d41b19925a5a..859f5570c3dc 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -102,7 +102,7 @@ void gmap_helper_discard(struct mm_struct *mm, unsigned long vmaddr, unsigned lo
  		if (!vma)
  			return;
  		if (!is_vm_hugetlb_page(vma))
-			zap_page_range_single(vma, vmaddr, min(end, vma->vm_end) - vmaddr, NULL);
+			zap_page_range_single(vma, vmaddr, min(end, vma->vm_end) - vmaddr);
  		vmaddr = vma->vm_end;
  	}
  }
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 979c96b74cad..b0201bc6893a 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1186,7 +1186,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
  	if (vma) {
  		trace_binder_unmap_user_start(alloc, index);
  
-		zap_page_range_single(vma, page_addr, PAGE_SIZE, NULL);
+		zap_page_range_single(vma, page_addr, PAGE_SIZE);
  
  		trace_binder_unmap_user_end(alloc, index);
  	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f0d5be9dc736..b7cc6ef49917 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2621,11 +2621,11 @@ struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
  void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
  		  unsigned long size);
  void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
-			   unsigned long size, struct zap_details *details);
+			   unsigned long size);
  static inline void zap_vma_pages(struct vm_area_struct *vma)
  {
  	zap_page_range_single(vma, vma->vm_start,
-			      vma->vm_end - vma->vm_start, NULL);
+			      vma->vm_end - vma->vm_start);
  }
  void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
  		struct vm_area_struct *start_vma, unsigned long start,
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 872dc0e41c65..242c931d3740 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -503,8 +503,7 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
  	struct vma_list *vml;
  
  	list_for_each_entry(vml, &arena->vma_list, head)
-		zap_page_range_single(vml->vma, uaddr,
-				      PAGE_SIZE * page_cnt, NULL);
+		zap_page_range_single(vml->vma, uaddr, PAGE_SIZE * page_cnt);
  }
  
  static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8cca80094624..1dfb33c39c2f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6926,7 +6926,7 @@ static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
  #ifdef CONFIG_MMU
  	/* Clear any partial mappings on error. */
  	if (err)
-		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE, NULL);
+		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE);
  #endif
  
  	return err;
diff --git a/mm/memory.c b/mm/memory.c
index da360a6eb8a4..4f8dcdcd20f3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2155,17 +2155,16 @@ void zap_page_range_single_batched(struct mmu_gather *tlb,
   * @vma: vm_area_struct holding the applicable pages
   * @address: starting address of pages to zap
   * @size: number of bytes to zap
- * @details: details of shared cache invalidation
   *
   * The range must fit into one VMA.
   */
  void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
-		unsigned long size, struct zap_details *details)
+		unsigned long size)
  {
  	struct mmu_gather tlb;
  
  	tlb_gather_mmu(&tlb, vma->vm_mm);
-	zap_page_range_single_batched(&tlb, vma, address, size, details);
+	zap_page_range_single_batched(&tlb, vma, address, size, NULL);
  	tlb_finish_mmu(&tlb);
  }
  
@@ -2187,7 +2186,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
  	    		!(vma->vm_flags & VM_PFNMAP))
  		return;
  
-	zap_page_range_single(vma, address, size, NULL);
+	zap_page_range_single(vma, address, size);
  }
  EXPORT_SYMBOL_GPL(zap_vma_ptes);
  
@@ -2963,7 +2962,7 @@ static int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long add
  	 * maintain page reference counts, and callers may free
  	 * pages due to the error. So zap it early.
  	 */
-	zap_page_range_single(vma, addr, size, NULL);
+	zap_page_range_single(vma, addr, size);
  	return error;
  }
  
@@ -4187,7 +4186,11 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
  		unsigned long start_addr, unsigned long end_addr,
  		struct zap_details *details)
  {
-	zap_page_range_single(vma, start_addr, end_addr - start_addr, details);
+	struct mmu_gather tlb;
+
+	tlb_gather_mmu(&tlb, vma->vm_mm);
+	zap_page_range_single_batched(&tlb, vma, address, size, details);
+	tlb_finish_mmu(&tlb);
  }
  
  static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d5319ebe2452..9e92c71389f3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2052,7 +2052,7 @@ static int tcp_zerocopy_vm_insert_batch_error(struct vm_area_struct *vma,
  		maybe_zap_len = total_bytes_to_map -  /* All bytes to map */
  				*length + /* Mapped or pending */
  				(pages_remaining * PAGE_SIZE); /* Failed map. */
-		zap_page_range_single(vma, *address, maybe_zap_len, NULL);
+		zap_page_range_single(vma, *address, maybe_zap_len);
  		err = 0;
  	}
  
@@ -2217,8 +2217,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
  	total_bytes_to_map = avail_len & ~(PAGE_SIZE - 1);
  	if (total_bytes_to_map) {
  		if (!(zc->flags & TCP_RECEIVE_ZEROCOPY_FLAG_TLB_CLEAN_HINT))
-			zap_page_range_single(vma, address, total_bytes_to_map,
-					      NULL);
+			zap_page_range_single(vma, address, total_bytes_to_map);
  		zc->length = total_bytes_to_map;
  		zc->recv_skip_hint = 0;
  	} else {
diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index da21d65ccd20..b8e59e4420f3 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -124,7 +124,7 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
          // sufficient for this method call. This method has no requirements on the vma flags. The
          // address range is checked to be within the vma.
          unsafe {
-            bindings::zap_page_range_single(self.as_ptr(), address, size, core::ptr::null_mut())
+            bindings::zap_page_range_single(self.as_ptr(), address, size)
          };
      }
  
-- 
2.43.0


-- 
Cheers,

David

