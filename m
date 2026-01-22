Return-Path: <linux-fsdevel+bounces-75148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFJqJRGJcmkPmAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:31:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AD76D6D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67165301627B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 20:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F9377563;
	Thu, 22 Jan 2026 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9cWSTdk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7B39BA2A
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769113863; cv=pass; b=nDDjij6zK651R6lxAJfB9CJNNGp/t9X5YXaNlyqMF7RLGf+W1qs8kGUnWnpC5ZFOSjBVIygo/fDjhxTy5aXuNR6NmMe384L4BmZHsaGOvoLnGyPmSvaY1uZwi1lkBXbBWsSJrpWReov+uonWxYiAKcaLfcbi+yWjgYYAtnm0qPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769113863; c=relaxed/simple;
	bh=ASZplhRqMNnIuXI0Gmdw3pwrAxGsQ+x5dICWN1yZY84=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8HBFH0bFV4uNS0okHUcKfzLdBGnfPpoQ5Bp2OEDyu+Y++PlhVfSjlHgkvzpHD4IjvSsQoMmrJ6AAGJdFA0Rek8+WfoD2ophL41PmvRHHFpS7QUjQtGwMH+hgupudzsjq3LIRs4gW0LzQ3SYMWEIqbGnn6QzGIQvLbggdlvRe+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9cWSTdk; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-947fe9e92c3so952671241.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 12:30:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769113855; cv=none;
        d=google.com; s=arc-20240605;
        b=MIOmrRIuzMfs/XXNzkCVfsxhi80oMw+NxXbZZkfYr1cKxQwYs7f636rhlpUawtLrOE
         YRDEy7mSqMBmzJFtNyPBCMw7Y4qKxfNgqHVF1xlBdargBUQgmW4yX8KuGncgy4lpuRlh
         dMWr2Rd9Lfuy66kbKrH/x9OkPd+MXeEfVcs+VuyZgwTHVLUizQno308PGtTzfD29uYZt
         UzSC56YhFkHaV/SDS9hfwBpQeK9o8zVyShQLFvq8t+q+Ak2Z0Vet3AF+w21qxn5pQEWl
         NlKgPmQcWbYaeF06GK4VRHCQmRxfm5ZAbJ8fnMXg4kPynr/2CU+yZWFFO5zseB7pFxF2
         VfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=BQj97zlME5zzETPT7vCk6obWp/pKKcD8Mr+mou6nGos=;
        fh=kQZNAV28+/FWpOE6mMHsEXXMQMUG3UUOo4Fvn2maWDo=;
        b=dDQb9Fkg778wC/PTRRmbzTqCQDl53cZkUL9AvQ4tRKLNMhnjqX0aRwf6HMAR20qIrj
         xvc8J1Gb9zQJ1MAEzACHlh/rOvsI7QqTdn9iGJWMpwMzj6035HqBWwvDxjLvTrGM/CAC
         kqgQGtppP371hfuD5h/l/fRmKw5K+hF/8/PhXCAGMg6A+GWwmPtIv0Hl2NmTDiTlPLay
         IKW5urjTkr0tCoDa5nfisk/fBbfgjPnl/jFEynOdj5MPlf2tjvOPYi7uuvymBGygXir2
         6HUBsg5x8LwuDmRM6imCPl+PoLDzNO464CpVniEytMZXIji5hlNLQF8HOAmjDJLpVhy4
         XuCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769113855; x=1769718655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQj97zlME5zzETPT7vCk6obWp/pKKcD8Mr+mou6nGos=;
        b=s9cWSTdkMw0DTkJpj9RD4xeqwJKTvnEuQS6o2lmxQr8yI+JxygOpcXlQyNkodNWeZN
         QlKZDCW7kA5FN/zuUfMW+HDnPtJb7+ympe2kD78TTtBk3Ck2FvYXAReK2lt1XILLSw5H
         QBh7wNT0aVnhZEGEA9qz8tOTHNL8dWPiJ/VwHvxBkQ4Iw8zhruQzF52rDb9aaAEUrJGQ
         yps1d7pBZmraCX4fYe9cRXLfT55iWdDhZtRb8YG5PeNfs5p2Z5eKu/TyGz2PN2paNK5J
         HBy8zc98eJILnjq8u5EUZT90+sZ4aSreI25/HQbyOqGmDODp8u4zcr2XsIp4ecAuBwL/
         6qXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769113855; x=1769718655;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQj97zlME5zzETPT7vCk6obWp/pKKcD8Mr+mou6nGos=;
        b=F10VVgk/OnP8IM3LKcVEaVsLZ2SeTXdg/XvjBEZOY5WR8dsgbZij3B5EntT89/2vTC
         sodKs24GCHcvRnk+x9dcWq7iizRC4IAYLb4GSdg1+YGRNODQcergIz44Uqq79wq/WfFN
         jUz/LKaa+lJsGAeLug4nzCEvfKltFUZ0XALVBxY0lBCPm3+qxP5RQJ9l0GEZKjwyP1WS
         2XbUZE3zxEkZiDIEIOGQGC39kabH91FFbazY9RqUI6RyRd1dmDwcIlDozO7RaBhBC0K8
         FKQSHtrmlubYa/t/NmwaaUUjLOhr9MqE+ubDq3ENoHGCDPJhklmR4zRg3O8yYWtnYmHf
         XWPg==
X-Forwarded-Encrypted: i=1; AJvYcCVX9d9G50e/SU6je5D+k7akUs1R5rYRe3oS3gqqdsXBwt66sfgh9xheDjBqbgcrOYp33fiXKY8H9/aRpP7x@vger.kernel.org
X-Gm-Message-State: AOJu0YzITzA3B0GzCf8lYIAvLSaQ5/++hDQhxiwWVkzgHQ+AzPb7P5pO
	bDM3nI6Iwh9VR+CuV/P7IhqEzVUfZRLj5J4cHj68cX4/njaUBkVI4hmgwB4LLHmKnMuHPnVdZlh
	StdVtBI+4NYjTK07ZhqUcZLPiTY32/0w7HrI9JUX4
X-Gm-Gg: AZuq6aL7ywpInLAjWp2jF4IintN1NMPQtNIb6CdIrdtGHrQxzvVGte42XqFaPYbBqI0
	5DRor9Ijuuf7IUFAIHaAPUEkfjWWRO/ukM1xPKbiRobm9IhRJF0YYtjAhK01EITovbSDIIje8No
	I1iObPvl9iUWvlML9OTilXuB1mAKiAUvrRhw91aZOyAaE/oimMnkzTeqR3zNEmjLx02bEFBMyH3
	ayJppMBfsDpLofInyj4dKSPaiaDUouq7gNQcVP8wqoOEoDE+U+Zl5vYzxwt1Cl4I6PgwSK6sLW9
	bloV6VMjgeghlJUldCCYdDoH
X-Received: by 2002:a05:6102:d89:b0:5ee:a8c4:18d4 with SMTP id
 ada2fe7eead31-5f54bd0c3f6mr359613137.35.1769113854610; Thu, 22 Jan 2026
 12:30:54 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jan 2026 12:30:53 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jan 2026 12:30:53 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <f2f2a6bd-5cb4-46c9-a0f8-3240670094b5@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-8-kalyazin@amazon.com>
 <CAEvNRgEzVhEzr-3GWTsE7GSBsPdvVLq7WFEeLHzcmMe=R9S51w@mail.gmail.com>
 <a2b79af7-e5d1-4668-bff3-606f57d32dfc@amazon.com> <CAEvNRgF46M1jp0+eBu2wQMO7P1afyo00SOkENFwvB2KYX3dnFA@mail.gmail.com>
 <f2f2a6bd-5cb4-46c9-a0f8-3240670094b5@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Jan 2026 12:30:53 -0800
X-Gm-Features: AZwV_QhoTAbsDcZFNCQXVZ12J6m5MEBpBa-k8I2xwSPIY6AXvlNDgQnkgPrJ79I
Message-ID: <CAEvNRgEd=Uh09dU_P7_vvzRpOyMYd=OKazpkxzr=VLe5HcQhGw@mail.gmail.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct map
To: kalyazin@amazon.com, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"shuah@kernel.org" <shuah@kernel.org>, "riel@surriel.com" <riel@surriel.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"coxu@redhat.com" <coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "prsampat@amd.com" <prsampat@amd.com>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, 
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>, 
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,lwn.net,kernel.org,arm.com,huawei.com,google.com,linutronix.de,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.cz,suse.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,surriel.com,intel.com,loongson.cn,amd.com,linux.ibm.com,ghiti.fr,eecs.berkeley.edu,dabbelt.com,os.amperecomputing.com,amazon.co.uk,amazon.com];
	TAGGED_FROM(0.00)[bounces-75148-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_GT_50(0.00)[96];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.986];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 13AD76D6D1
X-Rspamd-Action: no action

Nikita Kalyazin <kalyazin@amazon.com> writes:

>
> [...snip...]
>
>>>>> @@ -533,6 +580,8 @@ static void kvm_gmem_free_folio(struct folio *folio)
>>>>>         kvm_pfn_t pfn = page_to_pfn(page);
>>>>>         int order = folio_order(folio);
>>>>>
>>>>> +     kvm_gmem_folio_restore_direct_map(folio);
>>>>> +
>>>>
>>>> I can't decide if the kvm_gmem_folio_no_direct_map(folio) should be in
>>>> the caller or within kvm_gmem_folio_restore_direct_map(), since this
>>>> time it's a folio-specific property being checked.
>>>
>>> I'm tempted to keep it similar to the kvm_gmem_folio_zap_direct_map()
>>> case.  How does the fact it's a folio-speicific property change your
>>> reasoning?
>>>
>>
>> This is good too:
>>
>>    if (kvm_gmem_folio_no_direct_map(folio))
>>            kvm_gmem_folio_restore_direct_map(folio)
>
> It turns out we can't do that because folio->mapping is gone by the time
> filemap_free_folio() is called so we can't inspect the flags.  Are you
> ok with only having this check when zapping (but not when restoring)?
> Do you think we should add a comment saying it's conditional here?
>

I thought kvm_gmem_folio_no_direct_map() only reads folio->private,
which I think should still be there at the point of
filemap_free_folio().

>>
>> [...snip...]
>>

