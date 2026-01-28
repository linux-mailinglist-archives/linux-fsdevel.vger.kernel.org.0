Return-Path: <linux-fsdevel+bounces-75677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EahI2dYeWldwgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:29:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88079BA81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E02AC301C899
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7601F5846;
	Wed, 28 Jan 2026 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RoTkF48w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B492A1E9B1A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769560149; cv=pass; b=hHUDi4V3H56zaEfr+TyKjOhUw/kXCDGZKUyDdXwaENPWIRgvSKqf1+OFSbJcr5sjViOKWb68XM/mwY0KlTkN8SNERNlC5YQxqrMf60H4+y8enof1XC7yt7OrEKznW8aiR0E/tTcf1MxZzypAqkP3YnZ5cvjxBDb6r6oyniLxFjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769560149; c=relaxed/simple;
	bh=afdfdT2YOMsD0iZJQSrtAQ+axiAIWjxn1C3TT/YCmDM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyFzONxJ9ZwM3VUwWoUJUIpHwzCJ1ix74v6d5mQr1wDBI6NQKftIb59tAy66L7J3KPFVaU79BmIHI+MFGJ8lhHDAlqdj3HSZU+/BKrYCikz3SnTHglvS48c8L/IWYl4JPq7LUAR1SM45zD37O9LTl0Oyuh3sq1vBRKae2Mr6TYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RoTkF48w; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5efa6d5dbf5so1852311137.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 16:29:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769560146; cv=none;
        d=google.com; s=arc-20240605;
        b=f7Ze9xTaUhVoh7OUjAyL42qnQKpCfCNktk6axpmk9uBf5dfST/VAssRu2plE7G2xnz
         CDCZ82/VxJ8RniyBzpQfuWtol3gC+NBET4e9zwDGghZo8Pl1UBkAtWa0Y4pvy397+HVl
         mQUA79HoN6hvjWRWpJVuIegM1jI3IMpYIXvAbLcotoGz2IYCS/XlArX+S+WSzgy/C4T0
         ZXtLA7i2fRWILQE+6kk5g1Bp+3gKiG9do0Wjo2DY+e3sMUfrgKt8gJBGh3zwKNYIcjv9
         eFmISllAjGTn9UrWEiyktxM3xx+m6lcvl57CtlJCdIBzWihJqiphelE5qdn4qnfQh684
         ZomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=afdfdT2YOMsD0iZJQSrtAQ+axiAIWjxn1C3TT/YCmDM=;
        fh=o4R5g/xlPRvx7hbghIPoTp2+isbFGZD95yfZXH/EUi0=;
        b=IQ0uwULnd79xlm4I1HES0Y8nBeaQcZxvJPep76imTRBwFiI/Mt/dl1sJWNlm1N+fGf
         TPAC2qnuf/yEmXNyNfMB/tU92wMU2D0U36VK3JV8fSHLlri04gvl6/qbJIYKE3l+MHvW
         lB4svNVA+h/KPs9sM4UGgwoH8y7H5Papm6jE71YxYvpwZZFpjbOQLQFBQeXy/mtw1kde
         CeEfudGeUypagwLNc+HFgwb8XdxZAC/KDi+PXSPnqWxRpZmJyQZgmXLMmrZqvrewRLFX
         UQPS6BTAr6ledvZojLKD1FVHS8kFHfc5wFxsO4IqdcRh8IZYzcLGVOl0F/HWRXUKAq9q
         wYKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769560146; x=1770164946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afdfdT2YOMsD0iZJQSrtAQ+axiAIWjxn1C3TT/YCmDM=;
        b=RoTkF48w++rpKI98DbFbYQgosbq5Z9QYSnnq2r0pJkWKQL7IXk+tBiTjV3OruM/GGg
         ODyn1mmKK+G87tX796IdJALpF+WQsSR4L1Vxu5SJc+ZvRFEwpfNQRL3hcRj5/OEI2soa
         6tWPkr57+6vqerzADKUP6NUF13qgXMGoptBRWRkx1Ax6eUQ6DQwyvVYbU3mlNTlofdzs
         HUJH460iLD2dejAHI07YqaoXQXLkT5ymt+DtUkE7p5CWNgbbwZpBXSjB8RmKNABMm+sb
         ALXGe3FrNfDccfBmdSvM+tZA37dZs+apXke4UFlxZ/l3FUpPzcVJTVRjdqdDnck/TP4s
         kwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560146; x=1770164946;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afdfdT2YOMsD0iZJQSrtAQ+axiAIWjxn1C3TT/YCmDM=;
        b=vAbhQ1xyyTR34Iq8oI0fdy+ABpldW/ID5+OBQgX/BMSnbG8M7SRIWluD7/uXG8wDS3
         2dcH+nl0Qizbb4Zd4B49/fT0NdzAmzd8QInG17ZEKRq+OpEFvWWBUMkQ8xdC7Qy4uFfI
         OrOS1mlW/nQ37NNlMpSPeyl7xPHMxKyU8v1LMoj+JsgrN+X7Musp8iebjwwjZdPtWnvr
         xzOmVAa/WcI/Ke7/NYwqo9WqzSJPD3rBlxh7UQDnHJxmskmAAPxxL3twOPcckfayPC/A
         eqMtF4Z63Xk5WsOlBfWuiJuf3Y4AoJMK/oBVsvZw4e+gEHyweIaHgOIg23OsXMU9fqz7
         D/pA==
X-Forwarded-Encrypted: i=1; AJvYcCWboi2x+Jcl8rvDmSOGZ2mwbDaN8o3CqcLBpcXg+uF68vtqoX5hiUxwNKgzIu9nfqfuFyRM6L0OyyppqEhY@vger.kernel.org
X-Gm-Message-State: AOJu0YwjDgdFTfeFXKKZ/B6DjWGS8JmxRazM25KfgyxIckblNSAsdDyv
	BMwxi8wHvslOJK+ZhM6JsQnQgeywYMgEuYzE9HsT5CMy/EJLLPTQdUEObrLL8MXb1sH4a4XaPKB
	NCzVYwCHaPz+hDlNT9iLShhdpHoN/vv7Rddc5uaGQ
X-Gm-Gg: AZuq6aIfUbsAZQtyOBCib8L5FjVrttlwgccl6ufb4fo0oXmpNLHn7oG6ifBZdChvDsH
	6gVpf7197NNnH1X8FKmHxlFLSzQYy33AhNBQFyfThEy5APum/jjQOYg/0q1mS6yj5T7JaMaZoeg
	+GH1cBHV11LZAPgXs0h7AZjciOBv6HMKh4o/j/L8LD7vaIKlw1evvaHDxRndP+dAhM71kUt6Zds
	mvPtpXPolWPdZbeVp8wbm71bgf+xPmbdI+biQ4rylCtPKL9zOqy156Ug9Sgt6EghbOLCM4i8l0J
	pMGQl3zN6Uehw5yv19OogxboeS9f7BKD2dqt
X-Received: by 2002:a05:6102:94f:b0:5db:cba0:941 with SMTP id
 ada2fe7eead31-5f72380ed5bmr1335024137.38.1769560145803; Tue, 27 Jan 2026
 16:29:05 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 16:29:05 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 16:29:04 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <f4f2a0297e38ac45e4438342ac2c882b91544acb.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-8-kalyazin@amazon.com>
 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
 <CAGtprH_qGGRvk3uT74-wWXDiQyY1N1ua+_P2i-0UMmGWovaZuw@mail.gmail.com>
 <8c1fb4092547e2453ddcdcfab97f06e273ad17d8.camel@intel.com>
 <CAEvNRgEbG-RhCTsX1D8a3MgEKN2dfMuKj0tY0MZZioEzjw=4Xw@mail.gmail.com>
 <ee9c649eed3893d852c3d20fb96bdc4904b7c295.camel@intel.com>
 <CAEvNRgEz0+ic9uvcsWYqWgR5EV=TfY0SAGC39zAL+n19SoBXmw@mail.gmail.com> <f4f2a0297e38ac45e4438342ac2c882b91544acb.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 Jan 2026 16:29:04 -0800
X-Gm-Features: AZwV_Qi5-DP-v6wjOnL-aDMsdDCx4XY7-YGdXQ0tP6_jJk0lLjibrIAwkazF3pk
Message-ID: <CAEvNRgHMOWfCRnkx7YJoAzNpBBOHCgvR5GHe66uHJX45WDT-YA@mail.gmail.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct map
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Annapurve, Vishal" <vannapurve@google.com>
Cc: "david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"jgross@suse.com" <jgross@suse.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"surenb@google.com" <surenb@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de" <pfalcato@suse.de>, "x86@kernel.org" <x86@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "maz@kernel.org" <maz@kernel.org>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "ast@kernel.org" <ast@kernel.org>, 
	"peterx@redhat.com" <peterx@redhat.com>, "alex@ghiti.fr" <alex@ghiti.fr>, "pjw@kernel.org" <pjw@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "willy@infradead.org" <willy@infradead.org>, 
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, "jmattson@google.com" <jmattson@google.com>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "luto@kernel.org" <luto@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "song@kernel.org" <song@kernel.org>, 
	"oupton@kernel.org" <oupton@kernel.org>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"kernel@xen0n.name" <kernel@xen0n.name>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>, 
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"gor@linux.ibm.com" <gor@linux.ibm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, 
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "joey.gouly@arm.com" <joey.gouly@arm.com>, 
	"derekmn@amazon.com" <derekmn@amazon.com>, "xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"jackmanb@google.com" <jackmanb@google.com>, "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "jannh@google.com" <jannh@google.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kas@kernel.org" <kas@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "will@kernel.org" <will@kernel.org>, 
	"seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,linux.ibm.com,suse.com,google.com,suse.cz,surriel.com,suse.de,redhat.com,dabbelt.com,ghiti.fr,linux.intel.com,linutronix.de,infradead.org,os.amperecomputing.com,linux.dev,linux-foundation.org,ziepe.ca,lists.linux.dev,oracle.com,xen0n.name,huawei.com,nvidia.com,intel.com,gmail.com,zytor.com,amd.com,loongson.cn,amazon.co.uk,iogearbox.net,lists.infradead.org,eecs.berkeley.edu,amazon.com,fomichev.me,alien8.de,lwn.net,kvack.org];
	TAGGED_FROM(0.00)[bounces-75677-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E88079BA81
X-Rspamd-Action: no action

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Thu, 2026-01-22 at 14:47 -0800, Ackerley Tng wrote:
>>
>> There's no use case I can think of for unmapping TDX private memory
>> from the host direct map, but Sean's suggestion
>> https://lore.kernel.org/all/aWpcDrGVLrZOqdcg@google.com/=C2=A0won't even
>> let shared guest_memfd memory be unmapped from the direct map for TDX
>> VMs.
>
> Ah!
>
>>
>> Actually, does TDX's clflush that assumes presence in the direct map
>> apply only for private pages, or all pages?
>>
>> If TDX's clflush only happens for private pages, then we could
>> restore private pages to the direct map, and then we'd be safe even
>> for TDX?
>
> Yes, just private pages need the special treatment. But it will be much
> simpler to start with just blocking the option for TDX. A shared pages
> only mode could come later.
>
> In general I think we should try to break things up like this when we
> can. Kernel code is not set in stone, only ABI. I think it will lead to
> overall faster upstreaming, because the series' can be simpler.

I agree on splitting the feature up :), agree that simpler series are
better.

Perhaps just for my understanding,

+ shared pages =3D> not in direct map =3D> no TDX clflush
+ private pages =3D> always in direct map =3D> TDX performs clflush

(I could put pages back into the direct map while doing shared to
private conversions).

Is everything good then? Or does TDX code not apply the special
treatment, as in clflush only for private pages, as of now?

