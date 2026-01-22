Return-Path: <linux-fsdevel+bounces-75139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDQxBsRncmmrjwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:09:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 864786C03F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62ECB30125EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F5933D6E4;
	Thu, 22 Jan 2026 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="SRxR6z5n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5642EC54C;
	Thu, 22 Jan 2026 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105136; cv=none; b=MVRLUefGB+I/4eR+CrXR6w6iFYSnZtWbCUo5SCP200lybOUEVcjhpto0zIukNd9cus5T4XT9jsy4OzzK9vrTFoJClvnR8LfRXQTDpBf2Xa010Qg+A7sT3DNH9qDakJ1qX6ahuCMnBIdfzt6SPsBJOTGRcTth9xdRxLsLr2tMoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105136; c=relaxed/simple;
	bh=dzHIKT6pbpAcJntXJuY2LaAF2Sl4NHnNq8TAcpMKU5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nkhCoj2YI77v8KnXBEEpV1KqioPrNfj73YB6Yc9x6qQOWAoGWu8YFpVvuyVudAGj6NQc6ZqMP8Rl1DaFr+79NWaAz6wKgy3yxKTwecSUbn5pbR722c/XAiTZqKtn3qRw1J++tu6VMm1eDn1Y8y9macKYietY/i4XlMCmDILgc9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=SRxR6z5n; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769105124; x=1800641124;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=/VQH+ZVpl7s1y6QFfIzvVBX/lOO8CFVE93gGifWyjYo=;
  b=SRxR6z5nIjiIyOyK1erNw+yrYS+fip4pyc/8/mYHZSjI7wxKJ8eCWVo9
   0h7mrdIpQRWsy1u5SK2+VUHT2qN+asQxEAAEy+RmGIliYgVe2jCujRXrk
   ryl0LyjeqxfR0+l+LjMcqXGqJtOxkqOW0C487hYKs2R9Aj8sEjSMDT4Im
   bYkNh5U+UxubALyZIIS57OoWgX1lSYtosdvoCY1nCFoCWTjckzp38zrBQ
   HvXlCSewTJgxOuXuxtec1AJ1mwDCEy+MmwYbyDhXWVt18fSs5gvtVKujN
   RDUefKLO16vWtZg2S8fARVJ+VDIvql0crImPNFhl2dw2qPgAVJFvI+Lcs
   w==;
X-CSE-ConnectionGUID: FzJfTE6DQPiBT8xS65L//g==
X-CSE-MsgGUID: NWC2jrzvQJKPewYEWGLFVA==
X-IronPort-AV: E=Sophos;i="6.21,246,1763424000"; 
   d="scan'208";a="8303027"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 18:04:57 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:24209]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.13.107:2525] with esmtp (Farcaster)
 id 3ec1e9f4-fd44-4c0b-b87e-d835b8518924; Thu, 22 Jan 2026 18:04:57 +0000 (UTC)
X-Farcaster-Flow-ID: 3ec1e9f4-fd44-4c0b-b87e-d835b8518924
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 22 Jan 2026 18:04:57 +0000
Received: from [192.168.23.186] (10.106.82.17) by
 EX19D005EUB003.ant.amazon.com (10.252.51.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 22 Jan 2026 18:04:53 +0000
Message-ID: <f2f2a6bd-5cb4-46c9-a0f8-3240670094b5@amazon.com>
Date: Thu, 22 Jan 2026 18:04:51 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct
 map
To: Ackerley Tng <ackerleytng@google.com>, "Kalyazin, Nikita"
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
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org"
	<luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "shuah@kernel.org" <shuah@kernel.org>,
	"riel@surriel.com" <riel@surriel.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>,
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "maobibo@loongson.cn"
	<maobibo@loongson.cn>, "prsampat@amd.com" <prsampat@amd.com>,
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com"
	<jmattson@google.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "dev.jain@arm.com"
	<dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"pjw@kernel.org" <pjw@kernel.org>, "shijie@os.amperecomputing.com"
	<shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>,
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com"
	<wyihan@google.com>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "vannapurve@google.com"
	<vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri,
 Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20260114134510.1835-1-kalyazin@amazon.com>
 <20260114134510.1835-8-kalyazin@amazon.com>
 <CAEvNRgEzVhEzr-3GWTsE7GSBsPdvVLq7WFEeLHzcmMe=R9S51w@mail.gmail.com>
 <a2b79af7-e5d1-4668-bff3-606f57d32dfc@amazon.com>
 <CAEvNRgF46M1jp0+eBu2wQMO7P1afyo00SOkENFwvB2KYX3dnFA@mail.gmail.com>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <CAEvNRgF46M1jp0+eBu2wQMO7P1afyo00SOkENFwvB2KYX3dnFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D002EUC004.ant.amazon.com (10.252.51.230) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75139-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_CC(0.00)[redhat.com,lwn.net,kernel.org,arm.com,huawei.com,google.com,linutronix.de,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.cz,suse.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,surriel.com,intel.com,loongson.cn,amd.com,linux.ibm.com,ghiti.fr,eecs.berkeley.edu,dabbelt.com,os.amperecomputing.com,amazon.co.uk,amazon.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalyazin@amazon.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[96];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	HAS_REPLYTO(0.00)[kalyazin@amazon.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 864786C03F
X-Rspamd-Action: no action



On 22/01/2026 16:34, Ackerley Tng wrote:
> Nikita Kalyazin <kalyazin@amazon.com> writes:
> 
> Was preparing the reply but couldn't get to it before the
> meeting. Here's what was also discussed at the guest_memfd biweekly on
> 2026-01-22:
> 
>>
>> [...snip...]
>>
>>>> @@ -423,6 +464,12 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>>>>                 kvm_gmem_mark_prepared(folio);
>>>>         }
>>>>
>>>> +     err = kvm_gmem_folio_zap_direct_map(folio);
>>>
>>> Perhaps the check for gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP should
>>> be done here before making the call to kvm_gmem_folio_zap_direct_map()
>>> to make it more obvious that zapping is conditional.
>>
>> Makes sense to me.
>>
>>>
>>> Perhaps also add a check for kvm_arch_gmem_supports_no_direct_map() so
>>> this call can be completely removed by the compiler if it wasn't
>>> compiled in.
>>
>> But if it is compiled in, we will be paying the cost of the call on
>> every page fault?  Eg on arm64, it will call the following:
>>
>> bool can_set_direct_map(void)
>> {
>>
>> ...
>>
>>        return rodata_full || debug_pagealloc_enabled() ||
>>                arm64_kfence_can_set_direct_map() || is_realm_world();
>> }
>>
> 
> You're right that this could end up paying the cost on every page
> fault. Please ignore this request!
> 
>>>
>>> The kvm_gmem_folio_no_direct_map() check should probably remain in
>>> kvm_gmem_folio_zap_direct_map() since that's a "if already zapped, don't
>>> zap again" check.
>>>
>>>> +     if (err) {
>>>> +             ret = vmf_error(err);
>>>> +             goto out_folio;
>>>> +     }
>>>> +
>>>>         vmf->page = folio_file_page(folio, vmf->pgoff);
>>>>
>>>>    out_folio:
>>>> @@ -533,6 +580,8 @@ static void kvm_gmem_free_folio(struct folio *folio)
>>>>         kvm_pfn_t pfn = page_to_pfn(page);
>>>>         int order = folio_order(folio);
>>>>
>>>> +     kvm_gmem_folio_restore_direct_map(folio);
>>>> +
>>>
>>> I can't decide if the kvm_gmem_folio_no_direct_map(folio) should be in
>>> the caller or within kvm_gmem_folio_restore_direct_map(), since this
>>> time it's a folio-specific property being checked.
>>
>> I'm tempted to keep it similar to the kvm_gmem_folio_zap_direct_map()
>> case.  How does the fact it's a folio-speicific property change your
>> reasoning?
>>
> 
> This is good too:
> 
>    if (kvm_gmem_folio_no_direct_map(folio))
>            kvm_gmem_folio_restore_direct_map(folio)

It turns out we can't do that because folio->mapping is gone by the time 
filemap_free_folio() is called so we can't inspect the flags.  Are you 
ok with only having this check when zapping (but not when restoring)? 
Do you think we should add a comment saying it's conditional here?

> 
>>>
>>> Perhaps also add a check for kvm_arch_gmem_supports_no_direct_map() so
>>> this call can be completely removed by the compiler if it wasn't
>>> compiled in. IIUC whether the check is added in the caller or within
>>> kvm_gmem_folio_restore_direct_map() the call can still be elided.
>>
>> Same concern as the above about kvm_gmem_folio_zap_direct_map(), ie the
>> performance of the case where kvm_arch_gmem_supports_no_direct_map() exists.
>>
> 
> Please ignore this request!
> 
>>>
>>>>         kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
>>>>    }
>>>>
>>>> @@ -596,6 +645,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>>>         /* Unmovable mappings are supposed to be marked unevictable as well. */
>>>>         WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>>>
>>>> +     if (flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)
>>>> +             mapping_set_no_direct_map(inode->i_mapping);
>>>> +
>>>>         GMEM_I(inode)->flags = flags;
>>>>
>>>>         file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
>>>> @@ -807,6 +859,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>>>         if (!is_prepared)
>>>>                 r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>>>>
>>>> +     kvm_gmem_folio_zap_direct_map(folio);
>>>> +
>>>
>>> Is there a reason why errors are not handled when faulting private memory?
>>
>> No, I can't see a reason.  Will add a check, thanks.
>>
>>>
>>>>         folio_unlock(folio);
>>>>
>>>>         if (!r)
>>>> --
>>>> 2.50.1


