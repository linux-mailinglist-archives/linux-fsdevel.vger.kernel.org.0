Return-Path: <linux-fsdevel+bounces-79624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKkSKqjpqmmOYAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:50:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DF223116
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2081C3069DEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70713ACA49;
	Fri,  6 Mar 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PV2FiYyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07029372671;
	Fri,  6 Mar 2026 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808571; cv=none; b=pT8sGb1cTVFpV357036Q3uY8ZQfchEwC+RpZEy5oCqiQdvPHi2LLax+jQ9HVneUVgQQklS8a1p/hGm4DX6hBG2OFfOV004v4OyBy4qdly4UB3yDHviW8oBhTHPS2XfMnzOSmc1ochjPlHZVT5eEuRa5m9BuczFnDQadvsPkrKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808571; c=relaxed/simple;
	bh=laNYli1TF2KqJ1NK09RHrGK14IKe8N3u2ap5ELxvYaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BpeAQjiI+6ciQvr9Un4V0GiPByxZJ+Iplc1b2xOGZelSb/UurF5O1/PPRSslqBR82DWKLjAmOGo7gW0IbcfpKrTbkzQgWCqS5iuaDCD7BKBlfCNXrQMQTj4Me2iTZm0MkHdX/f1j6Excxh7KGnR/pC/I0GiPxXgvF82ND6DgB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PV2FiYyU; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1772808570; x=1804344570;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=NrzHXx0Lp7Elw8ALF5D0u+kNkH3P0Dcowz8U+9XDncM=;
  b=PV2FiYyUcSj/Ph2peJYSeE+UvdfwoCCv2lcJaDCk502nTuviKEvPJjy1
   Qdm0ZHtaTIzJTdLIlYVblDkh0kkyo3Hwx0X9sQEu4yMVL116+MsO5Fdsv
   3xCL0RJFNH2+sXlWwbFVcojNO/9D6VfCsOI+50QGfJQsm6+i79A8I5Y+u
   36xjcCYkDzVb2XOH4pR20uhqjJXdwOtWXF/hNaBCChkbtw1/IariBX9Zu
   i5tl/G7si+UQUtE8EE7cRi9Ba8EbW03gdJvonbraqYad64dUhOmQKXZua
   ECuByklrf5lDZkwc+RcQ5yTHTdAoz3g1WjvL6ROtBpIrJk8grIXtiWI7d
   w==;
X-CSE-ConnectionGUID: 5IccaEBNQVSWRB5rNmqQOQ==
X-CSE-MsgGUID: 2TQ5H7tGR3uCD8Jr0npB8Q==
X-IronPort-AV: E=Sophos;i="6.23,105,1770595200"; 
   d="scan'208";a="10436907"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 14:49:25 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:3701]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.26.205:2525] with esmtp (Farcaster)
 id 00a2718f-a0c4-43d5-bed7-970a51d610b2; Fri, 6 Mar 2026 14:49:25 +0000 (UTC)
X-Farcaster-Flow-ID: 00a2718f-a0c4-43d5-bed7-970a51d610b2
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 6 Mar 2026 14:49:24 +0000
Received: from [192.168.2.180] (10.106.83.26) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 6 Mar 2026
 14:49:19 +0000
Message-ID: <936fa782-d937-4b14-b92d-cc8707336e5e@amazon.com>
Date: Fri, 6 Mar 2026 14:49:18 +0000
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
 <690c22f9-b71a-4f14-9857-008c7c858373@amazon.com>
 <0c0b911c-cda2-44a4-897e-361e02be7da5@kernel.org>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
In-Reply-To: <0c0b911c-cda2-44a4-897e-361e02be7da5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D001EUB001.ant.amazon.com (10.252.51.16) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)
X-Rspamd-Queue-Id: 514DF223116
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79624-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_CC(0.00)[redhat.com,lwn.net,kernel.org,arm.com,huawei.com,google.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.cz,suse.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,surriel.com,intel.com,loongson.cn,amd.com,linux.ibm.com,ghiti.fr,eecs.berkeley.edu,dabbelt.com,os.amperecomputing.com,bytedance.com,shopee.com,amazon.co.uk,amazon.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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



On 06/03/2026 14:22, David Hildenbrand (Arm) wrote:
> [...]
> 
>>>> +     /*
>>>> +      * Direct map restoration cannot fail, as the only error condition
>>>> +      * for direct map manipulation is failure to allocate page tables
>>>> +      * when splitting huge pages, but this split would have already
>>>> +      * happened in folio_zap_direct_map() in
>>>> kvm_gmem_folio_zap_direct_map().
>>>> +      * Note that the splitting occurs always because guest_memfd
>>>> +      * currently supports only base pages.
>>>> +      * Thus folio_restore_direct_map() here only updates prot bits.
>>>> +      */
>>>> +     WARN_ON_ONCE(folio_restore_direct_map(folio));
>>>
>>> Which raised the question: why should this function then even return an
>>> error?
>>
>> Dave pointed earlier that the failures were possible [1].  Do you think
>> we can document it better?
> 
> I'm fine with checking that somewhere (to catch any future problems).
> 
> Why not do the WARN_ON_ONCE() in folio_restore_direct_map()?
> 
> Then, carefully document (in the new kerneldoc for
> folio_restore_direct_map() etc) that folio_restore_direct_map() is only
> allowed after a prior successful folio_zap_direct_map(), and add a
> helpful comment above the WARN_ON_ONCE() in folio_restore_direct_map()
> that we don't expect errors etc.

My only concern about that is the assumptions we make in KVM may not 
apply to the general case and the WARN_ON_ONCE may become too 
restrictive compared to proper error handling in some (rare) cases.  For 
example, is it possible for the folio to migrate in between?

> 
> [...]
> 
>>>> -     if (!is_prepared)
>>>> +     if (!is_prepared) {
>>>>                 r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>>>> +             if (r)
>>>> +                     goto out_unlock;
>>>> +     }
>>>> +
>>>> +     if (kvm_gmem_no_direct_map(folio_inode(folio))) {
>>>> +             r = kvm_gmem_folio_zap_direct_map(folio);
>>>> +             if (r)
>>>> +                     goto out_unlock;
>>>> +     }
>>>
>>>
>>> It's a bit nasty that we have two different places where we have to call
>>> this. Smells error prone.
>>
>> We will actually have 2 more: for the write() syscall and UFFDIO_COPY,
>> and 0 once we have [2]
>>
>> [2] https://lore.kernel.org/linux-mm/20260225-page_alloc-unmapped-v1-0-
>> e8808a03cd66@google.com/
>>
>>>
>>> I was wondering why kvm_gmem_get_folio() cannot handle that?
>>
>> Most of the call sites follow the pattern alloc -> write -> zap so
>> they'll need direct map for some time after the allocation.
>>
> 
> Okay. Nasty. :)
> 
> --
> Cheers,
> 
> David


