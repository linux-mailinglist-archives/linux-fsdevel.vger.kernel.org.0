Return-Path: <linux-fsdevel+bounces-1083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7914E7D5401
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5C9B21088
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90CD2E626;
	Tue, 24 Oct 2023 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lnoys8I1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8411732
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 14:27:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ABCB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698157664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zTFJV5k7+i9C9Z7qzVK56ikmY/bbbinFNVFi5dg08gA=;
	b=Lnoys8I19WewsdkFgRzxFABqMzTLWhKYDi5qScbIB0Y6h/icc3qHxCMQhvLTWuYuOH9f1K
	cJDGm8BVjR8v7wZ7chGfwl5sDxMl6va9l53UPAURr2UQKr0AnjeH/BPtXUwD4lG+iz3l4P
	bW4clF9ryHeBcwc1jeCY4mGHtuSnt+I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-wPvBQpMsPraKTMHU6vsNBQ-1; Tue, 24 Oct 2023 10:27:43 -0400
X-MC-Unique: wPvBQpMsPraKTMHU6vsNBQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31fd48da316so2069700f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 07:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157662; x=1698762462;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTFJV5k7+i9C9Z7qzVK56ikmY/bbbinFNVFi5dg08gA=;
        b=NhHgpfq4j0pCvdAltJp2Ayj4bCbnNprti1qKIGquHypdA8fvjVF8uc8L93tjDVV43o
         Q6p0FU/OWCfBMUpe0ULrMEEwhEram5SSUc2LffiGCFRKeY4R6qYxv8nrqV6rkM+Jgb5+
         I3c0uS4ITtb31vgYWK+PnaxktpylLDmd+rpT/n2dfWRHI7oS0KjgZhmMOHECOOQw7sWa
         XBxdss2rY+eC9ZGhLgIyO99gDw2ByJD1AsRu7esnUHAlILBTFGjryK3W0cEP/usCv//+
         Et6foS7xojrkIRD7e6hrBUFyqBTH2FMbH4EcNERwGDOG1oPe4xfwBKNhgf4TkjR+Qhkh
         sYZA==
X-Gm-Message-State: AOJu0Yyq1l81cEgLL46v5PO2mIW6p90zmu5K/vpH+m6Fwwih86EPRV2Z
	awwL7fexwyigoc8pVksGE7GsepryC4hWuO4vcOrHnKh4nsbdxh1FWxkviJ4rvKtpU1hyh9i4gui
	A6sWiSzKDAWbM88lYkO1LzNzIuQ==
X-Received: by 2002:a5d:654a:0:b0:32d:95dc:c065 with SMTP id z10-20020a5d654a000000b0032d95dcc065mr9035942wrv.19.1698157662246;
        Tue, 24 Oct 2023 07:27:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGzZ+MDYL4XswAVtsNXNsDOf7rBlSuRCfM64Jng93K6wkcmAXafGLAHfJSBks+dn0VOFuClg==
X-Received: by 2002:a5d:654a:0:b0:32d:95dc:c065 with SMTP id z10-20020a5d654a000000b0032d95dcc065mr9035903wrv.19.1698157661765;
        Tue, 24 Oct 2023 07:27:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:ac00:f27c:e128:f876:f17e? (p200300cbc741ac00f27ce128f876f17e.dip0.t-ipconnect.de. [2003:cb:c741:ac00:f27c:e128:f876:f17e])
        by smtp.gmail.com with ESMTPSA id m17-20020a056000009100b0032d829e10c0sm10092335wrx.28.2023.10.24.07.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 07:27:41 -0700 (PDT)
Message-ID: <356a8b2e-1f70-45dd-b2f7-6c0b6b87b53b@redhat.com>
Date: Tue, 24 Oct 2023 16:27:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
 peterx@redhat.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
 <721366d0-7909-45c9-ae49-f652c8369b9d@redhat.com>
 <CAJuCfpErrAqZuiiU5uthVU87Sa=yztRRqnTszezFCMQgBEawCg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJuCfpErrAqZuiiU5uthVU87Sa=yztRRqnTszezFCMQgBEawCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.10.23 20:56, Suren Baghdasaryan wrote:
> On Mon, Oct 23, 2023 at 5:29 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> Focusing on validate_remap_areas():
>>
>>> +
>>> +static int validate_remap_areas(struct vm_area_struct *src_vma,
>>> +                             struct vm_area_struct *dst_vma)
>>> +{
>>> +     /* Only allow remapping if both have the same access and protection */
>>> +     if ((src_vma->vm_flags & VM_ACCESS_FLAGS) != (dst_vma->vm_flags & VM_ACCESS_FLAGS) ||
>>> +         pgprot_val(src_vma->vm_page_prot) != pgprot_val(dst_vma->vm_page_prot))
>>> +             return -EINVAL;
>>
>> Makes sense. I do wonder about pkey and friends and if we even have to
>> so anything special.
> 
> I don't see anything special done for mremap. Do you have something in mind?

Nothing concrete, not a pkey expert. But as there is indeed nothing 
pkey-special in the VMA, there is nothing we can really check for and/or 
adjust.

So let's assume this is fine.

>>
>>> +
>>> +     /* Only allow remapping if both are mlocked or both aren't */
>>> +     if ((src_vma->vm_flags & VM_LOCKED) != (dst_vma->vm_flags & VM_LOCKED))
>>> +             return -EINVAL;
>>> +
>>> +     if (!(src_vma->vm_flags & VM_WRITE) || !(dst_vma->vm_flags & VM_WRITE))
>>> +             return -EINVAL;
>>
>> Why does one of both need VM_WRITE? If one really needs it, then the
>> destination (where we're moving stuff to).
> 
> As you noticed later, both should have VM_WRITE.

Can you comment why? Just a simplification for now? Would be good to add 
that comment in the code as well.

/* For now, we keep it simple and only move between writable VMAs. */

>>> +      */
>>> +     if (!dst_vma->vm_userfaultfd_ctx.ctx &&
>>> +         !src_vma->vm_userfaultfd_ctx.ctx)
>>> +             return -EINVAL;
>>
>>
>>
>>> +
>>> +     /*
>>> +      * FIXME: only allow remapping across anonymous vmas,
>>> +      * tmpfs should be added.
>>> +      */
>>> +     if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
>>> +             return -EINVAL;
>>
>> Why a FIXME here? Just drop the comment completely or replace it with
>> "We only allow to remap anonymous folios accross anonymous VMAs".
> 
> Will do. I guess Andrea had plans to cover tmpfs as well.


That is rather future work (or what's to fix here?) and better 
documented in the cover letter.

Having thought about VMA checks, I do wonder if we want to just block 
some VM_ flags right at the beginning (VM_IO,VM_PFNMAP,VM_HUGETLB,...). 
That might be covered by some other checks here implicitly, but I'm not 
100% sure if that's always the case. An explicit list as in 
vma_ksm_compatible() might be clearer.

Further, I wonder if we have to block VM_SHADOW_STACK; we certainly 
don't want to let users modify the shadow stack by moving modified 
target pages into place. But this might already be covered by earlier 
checks (vm_page_prot? but I didn't look up with which setting we ended 
up in the upstream version).

Cc'ing Rick: see "validate_remap_areas()" in [1]

[1] https://lkml.kernel.org/r/20231009064230.2952396-3-surenb@google.com


-- 
Cheers,

David / dhildenb


