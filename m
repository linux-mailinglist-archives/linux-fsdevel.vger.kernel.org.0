Return-Path: <linux-fsdevel+bounces-75675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC9sBZFWeWlIwgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:21:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E89B9FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 110F8301C8B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7A419F40B;
	Wed, 28 Jan 2026 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zLxVLiLw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0BC19AD8B
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769559676; cv=pass; b=S3alCmP4WlYMMPDndKHg/gCrbKwCdnrNfRyxXEZ6wgcoom6RnSYAqqA4JRtuOl9YjWaKhwF8cHzUhlLGVo9d4rJNsmjyEVfw610LfIJo9wVjJ4xxZtQ+Kkps+wXzNO3bBqJWky5uK3Jrt/dlEJaRkiKki59Qgdl9Ajk2gE5CLYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769559676; c=relaxed/simple;
	bh=/kA8M2mqA273+dmaL09+/9pRCOJMn38c8HSeLt8VdYo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJqpBLpRTaFRkIZPHD8H3vwYOO/zWWJqjE8bsQO63IoCzk2gJvTEYuI9NMPpCtLMekQkqtZOf9Z6QeKu0SJR5NRnYa0L6ozVuxAoyYLOuj9BzE5J8mG6hpxU+WyKP1HGY3XlTISweQa945Kvn2x97LG5PLvphzMN6P8zQTOmTns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zLxVLiLw; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9480ec9596cso1777342241.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 16:21:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769559673; cv=none;
        d=google.com; s=arc-20240605;
        b=SBi+E3dN6L8uYpM7KhUaPl9h8iAc2FoWqpByG6dCuHIu2I/3U0zWPBUKEaUk7+l/s6
         ggeYE+NsNTBRzb/5+dGKexp+mwlhPHmeNVTVErXwUmilmesIU3vhuZxzodIewM9M6OWr
         d0/su9ix6nlFxcmIav3eL/WLoRg9u5eCSKQ1arC4y+gg7md+lZKTkLrk64ooPD5IrPAd
         kn7Up7NcnKtRVTfy0B9zk+ek9ZJdX2HUuYXyoSqCG64DB1R7NXEZ6r87owVy4h8rbsA3
         9LKAzG79gJ1GecFi9gNWG1UVVoVGMfcSvxMxZoTXiYtQon9WZLPo4+oSzQa2C73HSBYf
         4oUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=dtv6l5aP4r9bRMzqX9oNvs3QGYC/8h1s4fLDq3qnO1s=;
        fh=OV0IFGV9xA1wmtnpnJsQGgPIyMtR/8B8FDqIQArGGIY=;
        b=ePpcxF17qrJgk4DRx5QbUECVmR9slWp4btlN4e94wW94lnSqQkBweIDmgQ3oF658OG
         Fg6pektfT/+PguPq8s3Ss6/AcKDC8jB5CRYIe+L9DhJ1bYT2ACuJe0C9e8ORhtEkSaTx
         iuLnm+4TCPShIS4wdB1ZcPBGjT5mzFc7sFx6nKq+VqzaqyHQe9ZMEdFF4uu6wp0SHgyc
         yrdfu9olj/GaOXFW6lncg39D3mZX+9gNiXUk21s8FEQj8Qy/XgM4NxV+30byE8tJqOrY
         dg7FExkAJSyBZ1rOpUyLig9wV2XjrbC6/lL1n8GUmrB/vjbUdL6grVLntVQNKW/zv8Mm
         mjsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769559673; x=1770164473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtv6l5aP4r9bRMzqX9oNvs3QGYC/8h1s4fLDq3qnO1s=;
        b=zLxVLiLwCl5TKZ5w6lbIQfLz95YzQ9rWelKRMBVskh1IgN7IUZ8J905zocwnkYbB12
         9IU3w5q8ykIbETiMbYDppF4hkTGp5dovsYCfaTHfWxGp8uzY5bPUz2tlynmhUdtQJv8g
         f0VIG5tCeMpqSwtNoOU4C1uoE/62uPwPPxImfNlXRHraU30DSQXQoR7lBjwCmPOu3f/f
         b36LINQUU6r2jPZCumEMEduX+RkzSd/6zn4EDfmJl5j94rYPh08sDC5JymGyJkEPDkrq
         7fHX+/BL2kTemKMa8JuCcxvLlTs46VgX32V4qAue126JYDenFRLX+3HXBmPdvqkpwcTB
         VQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769559673; x=1770164473;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtv6l5aP4r9bRMzqX9oNvs3QGYC/8h1s4fLDq3qnO1s=;
        b=EeQcJDPWQ0JcGXvFrMVy0mS4yFqNLjKachd7k7G51iqZUlRbDQQzLDSthc6q4goh+F
         143fbeh7fkdGFt+NctLlByja0JSPC0SNzCxk3PmH2SoxXa058K+5VhxkHISoWqWdLI98
         n5cEGuvb+Yws+MV2Wx4tYEnJ0f4XfINvTTR8dfekh8XsBOhKP/pLhDxQ8/2cdkPBcJft
         9YoaIKzwUJsVjzInzq8gCWv/yEwzQi20ut5OTadiweLqKFLnX9uB2+WLRmPHi4ne043W
         yyYfIHPdLbyLHcr9ii5k4a7rQAHNw9y1dOzCl6/1lzubeyQmfr/R/LhQtpKGvUGuv0jM
         aXtA==
X-Forwarded-Encrypted: i=1; AJvYcCUNHLDednBRxiDzSMuXIcN+EIYzewzfLNm+i6DbzGQg9+34MV95whLxZDQiz9yTBiMZox+h45l0eYmmoMWs@vger.kernel.org
X-Gm-Message-State: AOJu0YyD234L/ur0UXFqRQGeo5GMvyF6KqxylMa5JLjgNIbgovSbYiiR
	0w5xaRsYjZDEch7LdGxjAkJiAr+F4cvPYBrTrX97i57w0+KplPKCqwsjma3hflzsW2V28cNTilS
	ubd8iAcpgSzwpGj8TuHuvd1hxGq8YxRzYjPyAGEDZ
X-Gm-Gg: AZuq6aLsRvaFYQ/dawrH86vT3EYd/OdeDacWi8CsMTrlj/J7IMMjI07Ry9gnlDTPgYg
	nmLwwt1Xao2g/VcmkOqyBk2jgL5n4LEw6Smsp6S6+s0ZcbjxXOTB6aia9fSl9RgZlEjYMUHCBDZ
	JCtQDvHoHXfQEWBIBkGA0uSRc2wi1iH/HW/Htx0XZ5AbmqoYS4VWrVOeFfsichT3uVsjkXC2BsS
	3HVFgHlyhHahCyJWaWJ3R8IMrxcfUO8q5D8B9TMkmRFH5C2cpQEu7Qx/Zo5f/nhnq5hFsqVDcoP
	BXUvso/ZoN/Z5Szwe5IpBkCy+Q==
X-Received: by 2002:a05:6102:2926:b0:5f5:2ab7:cef4 with SMTP id
 ada2fe7eead31-5f7236280c7mr1308564137.12.1769559672438; Tue, 27 Jan 2026
 16:21:12 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 16:21:11 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 16:21:11 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <afddc163-4b1e-46ee-920a-85de3b347291@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-8-kalyazin@amazon.com>
 <e619ded526a2f9a4cec4f74383cef31519624935.camel@intel.com>
 <294bca75-2f3e-46db-bb24-7c471a779cc1@amazon.com> <CAEvNRgEvd9tSwrkaYrQyibO2DP99vgVj6_zr=jBH5+zMnJwYbA@mail.gmail.com>
 <afddc163-4b1e-46ee-920a-85de3b347291@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 Jan 2026 16:21:11 -0800
X-Gm-Features: AZwV_QgCVtca03XgnQCypNXAbjgX301aeAGuQByaW4GAjqTre8UeoPpevsc7bzA
Message-ID: <CAEvNRgFCwU7ezDV4Spj=H1JZohG9CSQRKMh_h1OGY1GrR2=7Eg@mail.gmail.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct map
To: kalyazin@amazon.com, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
Cc: "david@kernel.org" <david@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"jgross@suse.com" <jgross@suse.com>, "surenb@google.com" <surenb@google.com>, 
	"riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>, 
	"thuth@redhat.com" <thuth@redhat.com>, "maz@kernel.org" <maz@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "ast@kernel.org" <ast@kernel.org>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "Annapurve, Vishal" <vannapurve@google.com>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>, 
	"pjw@kernel.org" <pjw@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"willy@infradead.org" <willy@infradead.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, "jmattson@google.com" <jmattson@google.com>, 
	"luto@kernel.org" <luto@kernel.org>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"hpa@zytor.com" <hpa@zytor.com>, "song@kernel.org" <song@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"Yu, Yu-cheng" <yu-cheng.yu@intel.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"shuah@kernel.org" <shuah@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>, 
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "derekmn@amazon.com" <derekmn@amazon.com>, 
	"xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "jackmanb@google.com" <jackmanb@google.com>, "bp@alien8.de" <bp@alien8.de>, 
	"corbet@lwn.net" <corbet@lwn.net>, "jannh@google.com" <jannh@google.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kas@kernel.org" <kas@kernel.org>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,arm.com,linux.ibm.com,suse.com,google.com,surriel.com,suse.de,redhat.com,linux.intel.com,suse.cz,ghiti.fr,linutronix.de,infradead.org,os.amperecomputing.com,linux.dev,linux-foundation.org,ziepe.ca,zytor.com,loongson.cn,oracle.com,nvidia.com,intel.com,huawei.com,gmail.com,amd.com,amazon.co.uk,iogearbox.net,eecs.berkeley.edu,amazon.com,fomichev.me,alien8.de,lwn.net];
	TAGGED_FROM(0.00)[bounces-75675-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[97];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 679E89B9FA
X-Rspamd-Action: no action

Nikita Kalyazin <kalyazin@amazon.com> writes:

> On 22/01/2026 18:37, Ackerley Tng wrote:
>> Nikita Kalyazin <kalyazin@amazon.com> writes:
>>
>>> On 16/01/2026 00:00, Edgecombe, Rick P wrote:
>>>> On Wed, 2026-01-14 at 13:46 +0000, Kalyazin, Nikita wrote:
>>>>> +static void kvm_gmem_folio_restore_direct_map(struct folio *folio)
>>>>> +{
>>>>> +     /*
>>>>> +      * Direct map restoration cannot fail, as the only error condition
>>>>> +      * for direct map manipulation is failure to allocate page tables
>>>>> +      * when splitting huge pages, but this split would have already
>>>>> +      * happened in folio_zap_direct_map() in kvm_gmem_folio_zap_direct_map().
>>
>> Do you know if folio_restore_direct_map() will also end up merging page
>> table entries to a higher level?
>>
>>>>> +      * Thus folio_restore_direct_map() here only updates prot bits.
>>>>> +      */
>>>>> +     if (kvm_gmem_folio_no_direct_map(folio)) {
>>>>> +             WARN_ON_ONCE(folio_restore_direct_map(folio));
>>>>> +             folio->private = (void *)((u64)folio->private & ~KVM_GMEM_FOLIO_NO_DIRECT_MAP);
>>>>> +     }
>>>>> +}
>>>>> +
>>>>
>>>> Does this assume the folio would not have been split after it was zapped? As in,
>>>> if it was zapped at 2MB granularity (no 4KB direct map split required) but then
>>>> restored at 4KB (split required)? Or it gets merged somehow before this?
>>
>> I agree with the rest of the discussion that this will probably land
>> before huge page support, so I will have to figure out the intersection
>> of the two later.
>>
>>>
>>> AFAIK it can't be zapped at 2MB granularity as the zapping code will
>>> inevitably cause splitting because guest_memfd faults occur at the base
>>> page granularity as of now.
>>
>> Here's what I'm thinking for now:
>>
>> [HugeTLB, no conversions]
>> With initial HugeTLB support (no conversions), host userspace
>> guest_memfd faults will be:
>>
>> + For guest_memfd with PUD-sized pages
>>      + At PUD level or PTE level
>> + For guest_memfd with PMD-sized pages
>>      + At PMD level or PTE level
>>
>> Since this guest_memfd doesn't support conversions, the folio is never
>> split/merged, so the direct map is restored at whatever level it was
>> zapped. I think this works out well.
>>
>> [HugeTLB + conversions]
>> For a guest_memfd with HugeTLB support and conversions, host userspace
>> guest_memfd faults will always be at PTE level, so the direct map will
>> be split and the faulted pages have the direct map zapped in 4K chunks
>> as they are faulted.
>>
>> On conversion back to private, put those back into the direct map
>> (putting aside whether to merge the direct map PTEs for now).
>
> Makes sense to me.
>
>>
>>
>> Unfortunately there's no unmapping callback for guest_memfd to use, so
>> perhaps the principle should be to put the folios back into the direct
>> map ASAP - at unmapping if guest_memfd is doing the unmapping, otherwise
>> at freeing time?
>
> I'm not sure I fully understand what you mean here.  What would be the
> purpose for hooking up to unmapping?  Why would making sure we put
> folios back into the direct map whenever they are freed or converted to
> private not be sufficient?

I think putting the folios back into the direct map when the folios are
freed or converted to private should cover all cases.

I was just thinking that being able to hook up to unmapping is nice
since unmapping is the counterpart to mapping when the folios are
removed from the direct map.

