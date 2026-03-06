Return-Path: <linux-fsdevel+bounces-79612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDyyJhPQqmn3XQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 14:01:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB52213D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 14:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AD3D3160EF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 12:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35D23921F4;
	Fri,  6 Mar 2026 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iuw2rRWt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE834FF7A;
	Fri,  6 Mar 2026 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801396; cv=none; b=mwb0Wn6Rzs4apa8Y1Zs18gt2GxO8Q5QnLBap6QNqSGUknAEiwNll3vrnzgwXPACJXqk8irqtJ1cWqAeHGctviTeqyo4YbOw5O4/19Ky2MbGKaWjU65eJda6okRDJQbnBsuImzF8HBJOepGaiqB3Ey25xRGBEMXpvx00LsU4t1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801396; c=relaxed/simple;
	bh=pEk2FSDtL/QjsxPmzXHQgrpNF+TgzDhM8PWDYE4p8Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BMJenr2UoAYRaNs72+Ov0UxSYJW1Bf9gYKbx7ngIV0YkHWf30fagcRoExrCR/ilaKm/Q/pfRd7rUve3toVCdGwPLB91phbtFfqi1g698ix/2M8opDkyCdOyLgVBwH5H/JA/em43JV8uVBfnHmmZkbfsqiVWBjtA8IxnlZq/4HU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iuw2rRWt; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1772801394; x=1804337394;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=ZsNM+LWlhCLdso8cveAQj+8sSJJHKrqUIk0XEUUGml0=;
  b=iuw2rRWtiQTQUnNcwG6fvfr2B2pkrkHmDdMqi0BEYyeY+/FWmzm9/vI3
   lCRIpFndrR9lmd4QyuoI3aLs0iuVbBrtw3Hf2Fv3bGxlcS8bzYfJstsrJ
   PoBoEMn3XwGC3Jx+uIM5DQphKLpAXpvfhZ4cfO53r0bC+n4kKnXpYGSAJ
   7uIJ/k/acKLYEt2opstILPkqT2DmfD5buf8Q+SXAPGmmdwT+n5t/Jug4w
   6IvH7Un5j16cWlQ4gw0RxyjwedyqoojIeJTfd0Ikhx0+bb+I/Vv2vC1Tq
   cwqnkCHmM9tWxhFwqdYsDwhhAExKJVYKIcf4JucZHi531OB2W+bwwQt5i
   A==;
X-CSE-ConnectionGUID: Y4sz6pdzTp+XqctERZWOJg==
X-CSE-MsgGUID: JDyPSNQrRVitsjENXrw1AA==
X-IronPort-AV: E=Sophos;i="6.23,104,1770595200"; 
   d="scan'208";a="10315608"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 12:49:49 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:8094]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.24.155:2525] with esmtp (Farcaster)
 id 62873006-8db1-4bbe-a713-761efcd5b5c0; Fri, 6 Mar 2026 12:49:49 +0000 (UTC)
X-Farcaster-Flow-ID: 62873006-8db1-4bbe-a713-761efcd5b5c0
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 6 Mar 2026 12:49:36 +0000
Received: from [192.168.2.180] (10.106.83.26) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 6 Mar 2026
 12:49:31 +0000
Message-ID: <690c22f9-b71a-4f14-9857-008c7c858373@amazon.com>
Date: Fri, 6 Mar 2026 12:49:30 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v10 09/15] KVM: guest_memfd: Add flag to remove from
 direct map
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
 <20260126164445.11867-10-kalyazin@amazon.com>
 <13ed00e1-f0db-4326-a800-2ba306833921@kernel.org>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
In-Reply-To: <13ed00e1-f0db-4326-a800-2ba306833921@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D015EUB002.ant.amazon.com (10.252.51.123) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)
X-Rspamd-Queue-Id: 3DBB52213D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79612-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email];
	FREEMAIL_CC(0.00)[redhat.com,lwn.net,kernel.org,arm.com,huawei.com,google.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.cz,suse.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,surriel.com,intel.com,loongson.cn,amd.com,linux.ibm.com,ghiti.fr,eecs.berkeley.edu,dabbelt.com,os.amperecomputing.com,bytedance.com,shopee.com,amazon.co.uk,amazon.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalyazin@amazon.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[104];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[kalyazin@amazon.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 05/03/2026 19:18, David Hildenbrand (Arm) wrote:
> On 1/26/26 17:50, Kalyazin, Nikita wrote:
>> From: Patrick Roy <patrick.roy@linux.dev>
>>
>> Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()
>> ioctl. When set, guest_memfd folios will be removed from the direct map
>> after preparation, with direct map entries only restored when the folios
>> are freed.
>>
>> To ensure these folios do not end up in places where the kernel cannot
>> deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
>> address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.
>>
>> Note that this flag causes removal of direct map entries for all
>> guest_memfd folios independent of whether they are "shared" or "private"
>> (although current guest_memfd only supports either all folios in the
>> "shared" state, or all folios in the "private" state if
>> GUEST_MEMFD_FLAG_MMAP is not set). The usecase for removing direct map
>> entries of also the shared parts of guest_memfd are a special type of
>> non-CoCo VM where, host userspace is trusted to have access to all of
>> guest memory, but where Spectre-style transient execution attacks
>> through the host kernel's direct map should still be mitigated.  In this
>> setup, KVM retains access to guest memory via userspace mappings of
>> guest_memfd, which are reflected back into KVM's memslots via
>> userspace_addr. This is needed for things like MMIO emulation on x86_64
>> to work.
>>
>> Direct map entries are zapped right before guest or userspace mappings
>> of gmem folios are set up, e.g. in kvm_gmem_fault_user_mapping() or
>> kvm_gmem_get_pfn() [called from the KVM MMU code]. The only place where
>> a gmem folio can be allocated without being mapped anywhere is
>> kvm_gmem_populate(), where handling potential failures of direct map
>> removal is not possible (by the time direct map removal is attempted,
>> the folio is already marked as prepared, meaning attempting to re-try
>> kvm_gmem_populate() would just result in -EEXIST without fixing up the
>> direct map state). These folios are then removed form the direct map
>> upon kvm_gmem_get_pfn(), e.g. when they are mapped into the guest later.
>>
>> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   Documentation/virt/kvm/api.rst  | 21 +++++----
>>   arch/x86/include/asm/kvm_host.h |  5 +--
>>   arch/x86/kvm/x86.c              |  5 +++
>>   include/linux/kvm_host.h        | 12 +++++
>>   include/uapi/linux/kvm.h        |  1 +
>>   virt/kvm/guest_memfd.c          | 80 ++++++++++++++++++++++++++++++---
>>   6 files changed, 106 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 01a3abef8abb..c5ee43904bca 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -6440,15 +6440,18 @@ a single guest_memfd file, but the bound ranges must not overlap).
>>   The capability KVM_CAP_GUEST_MEMFD_FLAGS enumerates the `flags` that can be
>>   specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:
>>
>> -  ============================ ================================================
>> -  GUEST_MEMFD_FLAG_MMAP        Enable using mmap() on the guest_memfd file
>> -                               descriptor.
>> -  GUEST_MEMFD_FLAG_INIT_SHARED Make all memory in the file shared during
>> -                               KVM_CREATE_GUEST_MEMFD (memory files created
>> -                               without INIT_SHARED will be marked private).
>> -                               Shared memory can be faulted into host userspace
>> -                               page tables. Private memory cannot.
>> -  ============================ ================================================
>> +  ============================== ================================================
>> +  GUEST_MEMFD_FLAG_MMAP          Enable using mmap() on the guest_memfd file
>> +                                 descriptor.
>> +  GUEST_MEMFD_FLAG_INIT_SHARED   Make all memory in the file shared during
>> +                                 KVM_CREATE_GUEST_MEMFD (memory files created
>> +                                 without INIT_SHARED will be marked private).
>> +                                 Shared memory can be faulted into host userspace
>> +                                 page tables. Private memory cannot.
>> +  GUEST_MEMFD_FLAG_NO_DIRECT_MAP The guest_memfd instance will unmap the memory
>> +                                 backing it from the kernel's address space
>> +                                 before passing it off to userspace or the guest.
>> +  ============================== ================================================
>>
>>   When the KVM MMU performs a PFN lookup to service a guest fault and the backing
>>   guest_memfd has the GUEST_MEMFD_FLAG_MMAP set, then the fault will always be
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 68bd29a52f24..6de1c3a6344f 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -2483,10 +2483,7 @@ static inline bool kvm_arch_has_irq_bypass(void)
>>   }
>>
>>   #ifdef CONFIG_KVM_GUEST_MEMFD
>> -static inline bool kvm_arch_gmem_supports_no_direct_map(void)
>> -{
>> -     return can_set_direct_map();
>> -}
>> +bool kvm_arch_gmem_supports_no_direct_map(struct kvm *kvm);
> 
> It's odd given that you introduced that code two patches previously. Can
> these changes directly be squashed into the earlier patch?
> [...]

You're right, I'll pull it in the "KVM: x86: define 
kvm_arch_gmem_supports_no_direct_map()".

> 
>>
>> +#define KVM_GMEM_FOLIO_NO_DIRECT_MAP BIT(0)
>> +
>> +static bool kvm_gmem_folio_no_direct_map(struct folio *folio)
>> +{
>> +     return ((u64)folio->private) & KVM_GMEM_FOLIO_NO_DIRECT_MAP;
>> +}
>> +
>> +static int kvm_gmem_folio_zap_direct_map(struct folio *folio)
>> +{
>> +     u64 gmem_flags = GMEM_I(folio_inode(folio))->flags;
>> +     int r = 0;
>> +
>> +     if (kvm_gmem_folio_no_direct_map(folio) || !(gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP))
>> +             goto out;
>> +
>> +     folio->private = (void *)((u64)folio->private | KVM_GMEM_FOLIO_NO_DIRECT_MAP);
>> +     r = folio_zap_direct_map(folio);
> 
> And if it fails, you'd leave KVM_GMEM_FOLIO_NO_DIRECT_MAP set.
> 
> What about modifying ->private only if it really worked?

True. I'll do

	r = folio_zap_direct_map(folio);
	if (!r)
		folio->private = (void *)((u64)folio->private | 
KVM_GMEM_FOLIO_NO_DIRECT_MAP);

> 
>> +
>> +out:
>> +     return r;
>> +}
>> +
>> +static void kvm_gmem_folio_restore_direct_map(struct folio *folio)
>> +{
>> +     /*
>> +      * Direct map restoration cannot fail, as the only error condition
>> +      * for direct map manipulation is failure to allocate page tables
>> +      * when splitting huge pages, but this split would have already
>> +      * happened in folio_zap_direct_map() in kvm_gmem_folio_zap_direct_map().
>> +      * Note that the splitting occurs always because guest_memfd
>> +      * currently supports only base pages.
>> +      * Thus folio_restore_direct_map() here only updates prot bits.
>> +      */
>> +     WARN_ON_ONCE(folio_restore_direct_map(folio));
> 
> Which raised the question: why should this function then even return an
> error?

Dave pointed earlier that the failures were possible [1].  Do you think 
we can document it better?

[1] 
https://lore.kernel.org/kvm/51a059a1-f03a-4b43-8df6-d31fca09cce7@intel.com/

> 
> 
>> +     folio->private = (void *)((u64)folio->private & ~KVM_GMEM_FOLIO_NO_DIRECT_MAP);
>> +}
>> +
>>   static inline void kvm_gmem_mark_prepared(struct folio *folio)
>>   {
>>        folio_mark_uptodate(folio);
>> @@ -393,11 +433,17 @@ static bool kvm_gmem_supports_mmap(struct inode *inode)
>>        return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_MMAP;
>>   }
>>
>> +static bool kvm_gmem_no_direct_map(struct inode *inode)
>> +{
>> +     return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP;
>> +}
>> +
>>   static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>>   {
>>        struct inode *inode = file_inode(vmf->vma->vm_file);
>>        struct folio *folio;
>>        vm_fault_t ret = VM_FAULT_LOCKED;
>> +     int err;
>>
>>        if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>>                return VM_FAULT_SIGBUS;
>> @@ -423,6 +469,14 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>>                kvm_gmem_mark_prepared(folio);
>>        }
>>
>> +     if (kvm_gmem_no_direct_map(folio_inode(folio))) {
>> +             err = kvm_gmem_folio_zap_direct_map(folio);
>> +             if (err) {
>> +                     ret = vmf_error(err);
>> +                     goto out_folio;
>> +             }
>> +     }
>> +
>>        vmf->page = folio_file_page(folio, vmf->pgoff);
>>
>>   out_folio:
>> @@ -533,6 +587,9 @@ static void kvm_gmem_free_folio(struct folio *folio)
>>        kvm_pfn_t pfn = page_to_pfn(page);
>>        int order = folio_order(folio);
>>
>> +     if (kvm_gmem_folio_no_direct_map(folio))
>> +             kvm_gmem_folio_restore_direct_map(folio);
>> +
>>        kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
>>   }
>>
>> @@ -596,6 +653,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>        /* Unmovable mappings are supposed to be marked unevictable as well. */
>>        WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>
>> +     if (flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)
>> +             mapping_set_no_direct_map(inode->i_mapping);
>> +
>>        GMEM_I(inode)->flags = flags;
>>
>>        file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
>> @@ -804,15 +864,25 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>        if (IS_ERR(folio))
>>                return PTR_ERR(folio);
>>
>> -     if (!is_prepared)
>> +     if (!is_prepared) {
>>                r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>> +             if (r)
>> +                     goto out_unlock;
>> +     }
>> +
>> +     if (kvm_gmem_no_direct_map(folio_inode(folio))) {
>> +             r = kvm_gmem_folio_zap_direct_map(folio);
>> +             if (r)
>> +                     goto out_unlock;
>> +     }
> 
> 
> It's a bit nasty that we have two different places where we have to call
> this. Smells error prone.

We will actually have 2 more: for the write() syscall and UFFDIO_COPY, 
and 0 once we have [2]

[2] 
https://lore.kernel.org/linux-mm/20260225-page_alloc-unmapped-v1-0-e8808a03cd66@google.com/

> 
> I was wondering why kvm_gmem_get_folio() cannot handle that?

Most of the call sites follow the pattern alloc -> write -> zap so 
they'll need direct map for some time after the allocation.

> 
> Then also fallocate() would directly be handled directly, instead of
> later at fault time etc.

Good question about fallocate().  It's not apparent to me that it needs 
to remove pages from direct map because we may not be able to 
initisalise them later on if we do.

> 
> Is it because __kvm_gmem_populate() etc need to write to this page?

I think it also applies to write(), UFFDIO_COPY and 
kvm_gmem_fault_user_mapping().

> 
> 
> --
> Cheers,
> 
> David


