Return-Path: <linux-fsdevel+bounces-79609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JwRCKjPqmnVXQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:59:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC1221341
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEE34307790C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5F3391503;
	Fri,  6 Mar 2026 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qJl9tLI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A038F244;
	Fri,  6 Mar 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801329; cv=none; b=eLWs/Yys7miASR9VEw+yWKT925EoLZdAExanmiOSrZOZKOMqMXL9BFFpYE7tfqU+oaJlRGiLclwkD4hftMMTH08L7jTRPMtg9KVgzyQIJohAAkSV1yyiIpv5h2WD2PjjERFPodlWL62d2Ys77tyv1YC/Niz+ydh7CfpzFayCN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801329; c=relaxed/simple;
	bh=A4w55fhkSP5SYqH4itJWFNtaO6TtNfPXoavYXd9Qto0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yi76rrrboO7WgW+mkJGTWkZNVm4h33Iokc2cd6VqXVFDDsjMll4LgnJVaWs0enkXuQyEbW6ZA3LeNwhs8OF0lHexOE6UICt5I6VXiu0nwxEzikmjDBJJjp2PNJ9gykIPwsOrwLY4w4NCSe8tD8NeWX+mj2mm9CVAG8iFc5nuWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qJl9tLI6; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1772801327; x=1804337327;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=bMQYOYMXLfYYqfrzv9J2aTP1fDeqWn0su8Gslng5WAw=;
  b=qJl9tLI6Hmyo/cvynocC/dXRUh6jTzwgUewXZHe5Qx3AqbGjsC/cvgHe
   GYoZXOO1tUCAOOHHOfR+Q9AO0pYhzUQCBYe4g8OUwMtZPU8+mNmklmL1X
   6ifSEp2IHSGmA2Hzq1YxFJfLl2A+gzoDp+LWtP932fRUaBKSdIqSocb7K
   84GfU5suoK6/w2pac4s/CoUj/ce6Ack1D+uodCJsgwqOeAIYjB1rhzA9+
   qzT/ArGvxWtrLw4J9sxk/meMNDwTYlRwRB4OPeH2VvkKNXhOJR9KrmMA6
   eSITT6cdyNGNGTSbyS0SKMWH7iodhFgbkfXgOsA0VYTtMtQ+ZlqoTB+Nl
   w==;
X-CSE-ConnectionGUID: Yx/EHmQHRFy5mQfbcc7SOQ==
X-CSE-MsgGUID: vFI11kARTzO+6Dwqg0rWgg==
X-IronPort-AV: E=Sophos;i="6.23,104,1770595200"; 
   d="scan'208";a="10334043"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 12:48:42 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:9741]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.16.189:2525] with esmtp (Farcaster)
 id 782955b1-d49c-41df-ab22-e29b6a3853bb; Fri, 6 Mar 2026 12:48:42 +0000 (UTC)
X-Farcaster-Flow-ID: 782955b1-d49c-41df-ab22-e29b6a3853bb
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 6 Mar 2026 12:48:41 +0000
Received: from [192.168.2.180] (10.106.83.26) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 6 Mar 2026
 12:48:36 +0000
Message-ID: <92fcec4f-43f9-4207-8472-eb94874f2efd@amazon.com>
Date: Fri, 6 Mar 2026 12:48:35 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v10 01/15] set_memory: set_direct_map_* to take address
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org"
	<willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"shuah@kernel.org" <shuah@kernel.org>, "riel@surriel.com" <riel@surriel.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com"
	<jgross@suse.com>, "yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
	"prsampat@amd.com" <prsampat@amd.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com"
	<agordeev@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com"
	<gor@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "thuth@redhat.com"
	<thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com"
	<urezki@gmail.com>, "zhengqi.arch@bytedance.com"
	<zhengqi.arch@bytedance.com>, "gerald.schaefer@linux.ibm.com"
	<gerald.schaefer@linux.ibm.com>, "jiayuan.chen@shopee.com"
	<jiayuan.chen@shopee.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"osalvador@suse.de" <osalvador@suse.de>, "pavel@kernel.org"
	<pavel@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
	<jackmanb@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>
References: <20260126164445.11867-1-kalyazin@amazon.com>
 <20260126164445.11867-2-kalyazin@amazon.com>
 <90058ff2-9dea-4090-b2e6-da4c3cdba81b@kernel.org>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
In-Reply-To: <90058ff2-9dea-4090-b2e6-da4c3cdba81b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D002EUA002.ant.amazon.com (10.252.50.7) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)
X-Rspamd-Queue-Id: 61BC1221341
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79609-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,lwn.net,kernel.org,arm.com,huawei.com,google.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.cz,suse.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,surriel.com,intel.com,loongson.cn,amd.com,linux.ibm.com,ghiti.fr,eecs.berkeley.edu,dabbelt.com,os.amperecomputing.com,bytedance.com,shopee.com,amazon.co.uk,amazon.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalyazin@amazon.com,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[104];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[kalyazin@amazon.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 05/03/2026 17:23, David Hildenbrand (Arm) wrote:
> On 1/26/26 17:46, Kalyazin, Nikita wrote:
>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>
>> This is to avoid excessive conversions folio->page->address when adding
>> helpers on top of set_direct_map_valid_noflush() in the next patch.
>>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   arch/arm64/include/asm/set_memory.h     |  7 ++++---
>>   arch/arm64/mm/pageattr.c                | 19 +++++++++----------
>>   arch/loongarch/include/asm/set_memory.h |  7 ++++---
>>   arch/loongarch/mm/pageattr.c            | 25 ++++++++++++-------------
>>   arch/riscv/include/asm/set_memory.h     |  7 ++++---
>>   arch/riscv/mm/pageattr.c                | 17 +++++++++--------
>>   arch/s390/include/asm/set_memory.h      |  7 ++++---
>>   arch/s390/mm/pageattr.c                 | 13 +++++++------
>>   arch/x86/include/asm/set_memory.h       |  7 ++++---
>>   arch/x86/mm/pat/set_memory.c            | 23 ++++++++++++-----------
>>   include/linux/set_memory.h              |  9 +++++----
>>   kernel/power/snapshot.c                 |  4 ++--
>>   mm/execmem.c                            |  6 ++++--
>>   mm/secretmem.c                          |  6 +++---
>>   mm/vmalloc.c                            | 11 +++++++----
>>   15 files changed, 90 insertions(+), 78 deletions(-)
> 
> [...]
> 
>> --- a/arch/loongarch/mm/pageattr.c
>> +++ b/arch/loongarch/mm/pageattr.c
>> @@ -198,32 +198,31 @@ bool kernel_page_present(struct page *page)
>>        return pte_present(ptep_get(pte));
>>   }
>>
>> -int set_direct_map_default_noflush(struct page *page)
>> +int set_direct_map_default_noflush(const void *addr)
>>   {
>> -     unsigned long addr = (unsigned long)page_address(page);
>> -
>> -     if (addr < vm_map_base)
>> +     if ((unsigned long)addr < vm_map_base)
>>                return 0;
>>
>> -     return __set_memory(addr, 1, PAGE_KERNEL, __pgprot(0));
>> +     return __set_memory((unsigned long)addr, 1, PAGE_KERNEL, __pgprot(0));
>>   }
>>
>> -int set_direct_map_invalid_noflush(struct page *page)
>> +int set_direct_map_invalid_noflush(const void *addr)
>>   {
>> -     unsigned long addr = (unsigned long)page_address(page);
>> +     unsigned long addr = (unsigned long)addr;
> 
> Are you sure you want a local variable with the exact same name
> 

You're right.  Thanks for spotting that.

> ...
> 
>>
>> -     if (addr < vm_map_base)
>> +     if ((unsigned long)addr < vm_map_base)
>>                return 0;
>>
>> -     return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
>> +     return __set_memory((unsigned long)addr, 1, __pgprot(0),
>> +                         __pgprot(_PAGE_PRESENT | _PAGE_VALID));
> 
> And cast it to (unsigned long) even though not required two times? :)
> 
> I assume you wanted to get rid of the local varable.

Yes, that's what I meant.

> 
>>   }
>>
>> -int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>> +int set_direct_map_valid_noflush(const void *addr, unsigned long numpages,
>> +                              bool valid)
> 
> 
> 
> Nothing else jumped at me.
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

> 
> It would be good to get some ACK from some arch people that are CCed :)
> 
> --
> Cheers,
> 
> David


