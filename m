Return-Path: <linux-fsdevel+bounces-79519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHHSJ03XqWnHGAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 20:19:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD852175EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 20:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7517E3033222
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 19:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F8330AD1C;
	Thu,  5 Mar 2026 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkDOY0Pd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CB1F7916;
	Thu,  5 Mar 2026 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738364; cv=none; b=bbVSedmazZwxxNoPwdBYUs7Iq0ZHOscSuxHmUU32qZAJragp3G31EwgNpZcOlHUKWhE2BCQizWmMtovG+AUGxJwTXmKk9O3Krw4l7sCasSYE/vaHBCanjY7BTTgIec5p7X6U7Aki3m2RH0CtRyjo55qLmOSNdwgwrNP9svHlvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738364; c=relaxed/simple;
	bh=0BC8DI4mn1ZAuak3tHG6w/zzoWmG6a8s8y2A5isTYJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cl7Tmda1nLV8o0otkY18+M+Xu1bK/OFd3271+ydoryQFpdjdfuAQaKEDradlJjSx5QYislcMWlXYR76nR5u0gRGSHd6z485UIP4Qjc9zIdzGO4UCHymzo68yl8oEerNLLBtBkpaGtqwEvcT4kdNffKShJsZdUpj3eLeK02RALyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkDOY0Pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926CCC116C6;
	Thu,  5 Mar 2026 19:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772738363;
	bh=0BC8DI4mn1ZAuak3tHG6w/zzoWmG6a8s8y2A5isTYJk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nkDOY0PdRmdcIeLb14oL57ha8z0A2hpxlJ8rNO3LlITuc3tUNV5jVcNtY2anbKXN6
	 yxu+bZcv1c2YzIxV0OJBwy92tAUG5kLWNZlpLpy0+KnqaductKyhEpBP+LeTXc6aog
	 tYg0GLnnnypnXnlqw15da3njs9rCbqRPtm/cskwzXHDGbMbTHl+eynByAjbe6MjCh7
	 Td+7qrQNMLGF/12VIChdCWN53GeWtw0Elvmnlu9KfPZbg4WlJtlAZMvW6aOEztZdmq
	 mfv7E7xMYRVyEA2wBt0wt5uSxEiwlqvzyALRgxo/wzXArYPc55j8CGPKnqMCccNFdF
	 AJ4muGMJrdCMw==
Message-ID: <13ed00e1-f0db-4326-a800-2ba306833921@kernel.org>
Date: Thu, 5 Mar 2026 20:18:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/15] KVM: guest_memfd: Add flag to remove from
 direct map
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "kernel@xen0n.name" <kernel@xen0n.name>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>,
 "oupton@kernel.org" <oupton@kernel.org>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "seanjc@google.com"
 <seanjc@google.com>, "tglx@kernel.org" <tglx@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>,
 "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
 <mhocko@suse.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org"
 <song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me"
 <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jannh@google.com"
 <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
 "shuah@kernel.org" <shuah@kernel.org>, "riel@surriel.com"
 <riel@surriel.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
 "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "prsampat@amd.com" <prsampat@amd.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "jmattson@google.com" <jmattson@google.com>,
 "jthoughton@google.com" <jthoughton@google.com>,
 "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
 "alex@ghiti.fr" <alex@ghiti.fr>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
 "dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com"
 <gor@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org"
 <pjw@kernel.org>,
 "shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
 "svens@linux.ibm.com" <svens@linux.ibm.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com"
 <wyihan@google.com>,
 "yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "urezki@gmail.com" <urezki@gmail.com>,
 "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "jiayuan.chen@shopee.com" <jiayuan.chen@shopee.com>,
 "lenb@kernel.org" <lenb@kernel.org>, "osalvador@suse.de"
 <osalvador@suse.de>, "pavel@kernel.org" <pavel@kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "vannapurve@google.com" <vannapurve@google.com>,
 "jackmanb@google.com" <jackmanb@google.com>,
 "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
 "patrick.roy@linux.dev" <patrick.roy@linux.dev>,
 "Thomson, Jack" <jackabt@amazon.co.uk>,
 "Itazuri, Takahiro" <itazur@amazon.co.uk>,
 "Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
 <xmarcalx@amazon.co.uk>
References: <20260126164445.11867-1-kalyazin@amazon.com>
 <20260126164445.11867-10-kalyazin@amazon.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260126164445.11867-10-kalyazin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1AD852175EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79519-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,lwn.net,kernel.org,arm.com,huawei.com,google.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.cz,suse.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,surriel.com,intel.com,loongson.cn,amd.com,linux.ibm.com,ghiti.fr,eecs.berkeley.edu,dabbelt.com,os.amperecomputing.com,bytedance.com,shopee.com,amazon.co.uk,amazon.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[103];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 1/26/26 17:50, Kalyazin, Nikita wrote:
> From: Patrick Roy <patrick.roy@linux.dev>
> 
> Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()
> ioctl. When set, guest_memfd folios will be removed from the direct map
> after preparation, with direct map entries only restored when the folios
> are freed.
> 
> To ensure these folios do not end up in places where the kernel cannot
> deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
> address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.
> 
> Note that this flag causes removal of direct map entries for all
> guest_memfd folios independent of whether they are "shared" or "private"
> (although current guest_memfd only supports either all folios in the
> "shared" state, or all folios in the "private" state if
> GUEST_MEMFD_FLAG_MMAP is not set). The usecase for removing direct map
> entries of also the shared parts of guest_memfd are a special type of
> non-CoCo VM where, host userspace is trusted to have access to all of
> guest memory, but where Spectre-style transient execution attacks
> through the host kernel's direct map should still be mitigated.  In this
> setup, KVM retains access to guest memory via userspace mappings of
> guest_memfd, which are reflected back into KVM's memslots via
> userspace_addr. This is needed for things like MMIO emulation on x86_64
> to work.
> 
> Direct map entries are zapped right before guest or userspace mappings
> of gmem folios are set up, e.g. in kvm_gmem_fault_user_mapping() or
> kvm_gmem_get_pfn() [called from the KVM MMU code]. The only place where
> a gmem folio can be allocated without being mapped anywhere is
> kvm_gmem_populate(), where handling potential failures of direct map
> removal is not possible (by the time direct map removal is attempted,
> the folio is already marked as prepared, meaning attempting to re-try
> kvm_gmem_populate() would just result in -EEXIST without fixing up the
> direct map state). These folios are then removed form the direct map
> upon kvm_gmem_get_pfn(), e.g. when they are mapped into the guest later.
> 
> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  Documentation/virt/kvm/api.rst  | 21 +++++----
>  arch/x86/include/asm/kvm_host.h |  5 +--
>  arch/x86/kvm/x86.c              |  5 +++
>  include/linux/kvm_host.h        | 12 +++++
>  include/uapi/linux/kvm.h        |  1 +
>  virt/kvm/guest_memfd.c          | 80 ++++++++++++++++++++++++++++++---
>  6 files changed, 106 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 01a3abef8abb..c5ee43904bca 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6440,15 +6440,18 @@ a single guest_memfd file, but the bound ranges must not overlap).
>  The capability KVM_CAP_GUEST_MEMFD_FLAGS enumerates the `flags` that can be
>  specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:
>  
> -  ============================ ================================================
> -  GUEST_MEMFD_FLAG_MMAP        Enable using mmap() on the guest_memfd file
> -                               descriptor.
> -  GUEST_MEMFD_FLAG_INIT_SHARED Make all memory in the file shared during
> -                               KVM_CREATE_GUEST_MEMFD (memory files created
> -                               without INIT_SHARED will be marked private).
> -                               Shared memory can be faulted into host userspace
> -                               page tables. Private memory cannot.
> -  ============================ ================================================
> +  ============================== ================================================
> +  GUEST_MEMFD_FLAG_MMAP          Enable using mmap() on the guest_memfd file
> +                                 descriptor.
> +  GUEST_MEMFD_FLAG_INIT_SHARED   Make all memory in the file shared during
> +                                 KVM_CREATE_GUEST_MEMFD (memory files created
> +                                 without INIT_SHARED will be marked private).
> +                                 Shared memory can be faulted into host userspace
> +                                 page tables. Private memory cannot.
> +  GUEST_MEMFD_FLAG_NO_DIRECT_MAP The guest_memfd instance will unmap the memory
> +                                 backing it from the kernel's address space
> +                                 before passing it off to userspace or the guest.
> +  ============================== ================================================
>  
>  When the KVM MMU performs a PFN lookup to service a guest fault and the backing
>  guest_memfd has the GUEST_MEMFD_FLAG_MMAP set, then the fault will always be
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 68bd29a52f24..6de1c3a6344f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2483,10 +2483,7 @@ static inline bool kvm_arch_has_irq_bypass(void)
>  }
>  
>  #ifdef CONFIG_KVM_GUEST_MEMFD
> -static inline bool kvm_arch_gmem_supports_no_direct_map(void)
> -{
> -	return can_set_direct_map();
> -}
> +bool kvm_arch_gmem_supports_no_direct_map(struct kvm *kvm);

It's odd given that you introduced that code two patches previously. Can
these changes directly be squashed into the earlier patch?
[...]

>  
> +#define KVM_GMEM_FOLIO_NO_DIRECT_MAP BIT(0)
> +
> +static bool kvm_gmem_folio_no_direct_map(struct folio *folio)
> +{
> +	return ((u64)folio->private) & KVM_GMEM_FOLIO_NO_DIRECT_MAP;
> +}
> +
> +static int kvm_gmem_folio_zap_direct_map(struct folio *folio)
> +{
> +	u64 gmem_flags = GMEM_I(folio_inode(folio))->flags;
> +	int r = 0;
> +
> +	if (kvm_gmem_folio_no_direct_map(folio) || !(gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP))
> +		goto out;
> +
> +	folio->private = (void *)((u64)folio->private | KVM_GMEM_FOLIO_NO_DIRECT_MAP);
> +	r = folio_zap_direct_map(folio);

And if it fails, you'd leave KVM_GMEM_FOLIO_NO_DIRECT_MAP set.

What about modifying ->private only if it really worked?

> +
> +out:
> +	return r;
> +}
> +
> +static void kvm_gmem_folio_restore_direct_map(struct folio *folio)
> +{
> +	/*
> +	 * Direct map restoration cannot fail, as the only error condition
> +	 * for direct map manipulation is failure to allocate page tables
> +	 * when splitting huge pages, but this split would have already
> +	 * happened in folio_zap_direct_map() in kvm_gmem_folio_zap_direct_map().
> +	 * Note that the splitting occurs always because guest_memfd
> +	 * currently supports only base pages.
> +	 * Thus folio_restore_direct_map() here only updates prot bits.
> +	 */
> +	WARN_ON_ONCE(folio_restore_direct_map(folio));

Which raised the question: why should this function then even return an
error?


> +	folio->private = (void *)((u64)folio->private & ~KVM_GMEM_FOLIO_NO_DIRECT_MAP);
> +}
> +
>  static inline void kvm_gmem_mark_prepared(struct folio *folio)
>  {
>  	folio_mark_uptodate(folio);
> @@ -393,11 +433,17 @@ static bool kvm_gmem_supports_mmap(struct inode *inode)
>  	return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_MMAP;
>  }
>  
> +static bool kvm_gmem_no_direct_map(struct inode *inode)
> +{
> +	return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP;
> +}
> +
>  static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>  {
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
>  	struct folio *folio;
>  	vm_fault_t ret = VM_FAULT_LOCKED;
> +	int err;
>  
>  	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>  		return VM_FAULT_SIGBUS;
> @@ -423,6 +469,14 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>  		kvm_gmem_mark_prepared(folio);
>  	}
>  
> +	if (kvm_gmem_no_direct_map(folio_inode(folio))) {
> +		err = kvm_gmem_folio_zap_direct_map(folio);
> +		if (err) {
> +			ret = vmf_error(err);
> +			goto out_folio;
> +		}
> +	}
> +
>  	vmf->page = folio_file_page(folio, vmf->pgoff);
>  
>  out_folio:
> @@ -533,6 +587,9 @@ static void kvm_gmem_free_folio(struct folio *folio)
>  	kvm_pfn_t pfn = page_to_pfn(page);
>  	int order = folio_order(folio);
>  
> +	if (kvm_gmem_folio_no_direct_map(folio))
> +		kvm_gmem_folio_restore_direct_map(folio);
> +
>  	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
>  }
>  
> @@ -596,6 +653,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	/* Unmovable mappings are supposed to be marked unevictable as well. */
>  	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>  
> +	if (flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)
> +		mapping_set_no_direct_map(inode->i_mapping);
> +
>  	GMEM_I(inode)->flags = flags;
>  
>  	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
> @@ -804,15 +864,25 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
>  
> -	if (!is_prepared)
> +	if (!is_prepared) {
>  		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +		if (r)
> +			goto out_unlock;
> +	}
> +
> +	if (kvm_gmem_no_direct_map(folio_inode(folio))) {
> +		r = kvm_gmem_folio_zap_direct_map(folio);
> +		if (r)
> +			goto out_unlock;
> +	}


It's a bit nasty that we have two different places where we have to call
this. Smells error prone.

I was wondering why kvm_gmem_get_folio() cannot handle that?

Then also fallocate() would directly be handled directly, instead of
later at fault time etc.

Is it because __kvm_gmem_populate() etc need to write to this page?


-- 
Cheers,

David

