Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F9148DB2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 16:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiAMP5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 10:57:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236399AbiAMP5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642089417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVjjhSTO5jv7G5CNfPQaqxy98s1YUf5RmxMVGvagrRU=;
        b=N3zuWt+qJlJ1/lgg9nWUgBBSVDXlkQwA+tscrTjhQxCvLvipy1cBqOcl09cO+oiJtLkEhA
        /yRg5DnpikhUkVIGoRroOid0Ba0FGb3bxeZutaKFF1b4U2JF9kaMeToc054R0vHhtGmBly
        SgkvZ9PN6NU9zN3Fms76Zbj6SfXv8G8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-Dvth5m44NTilOzBEAx32Bg-1; Thu, 13 Jan 2022 10:56:56 -0500
X-MC-Unique: Dvth5m44NTilOzBEAx32Bg-1
Received: by mail-ed1-f72.google.com with SMTP id i9-20020a05640242c900b003fe97faab62so5711041edc.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jan 2022 07:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=iVjjhSTO5jv7G5CNfPQaqxy98s1YUf5RmxMVGvagrRU=;
        b=2JcdZWcS7bBfMsI8BjHl4EVJy6Ly4FG3EMqM0RIm5uALRjSmLXtBfGZeyz+13ItjIC
         uVaAR+ZF1c12xAqfJ1JDI+UKwfvhF3r3Xch1KzNHeBpCzap5S0zhasxS0xSDaDXm2tNl
         yMhTv4/ThGVo1PGFeaggG525c6jTREzmR1txUfsyHBqY1gLmC+5br4N9PajRIHLZBelT
         1EIH+IOmt8JjHupFewNsGWPxaL28V5j20ai5G+Dv4F/gvp9z0N1qFIOc//VO8nYsVFdi
         VRkbWe+P39Vgm6YgFrjw72ZM/ZayeLDPe3tCQY9JmCx3KsNh6RHT913REAXFnFXPs9rO
         JFFQ==
X-Gm-Message-State: AOAM532fuxLEBgNEkNTJrBLVQR/dAqkH/kppYvyH0512X9O74Cna/tzU
        qH/nuZ0Y27JwX+uHmguNdo1L7HTF8Xcc8bLU92WJjfdt2vai0T0jPfCqdiQzMBuaaEUZlc/CwZn
        sIa3ImR1OSdTXMVzbeEhbP/UP+Q==
X-Received: by 2002:a17:907:3ea2:: with SMTP id hs34mr3985593ejc.191.1642089415158;
        Thu, 13 Jan 2022 07:56:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdEZGBZ+SY0OUOH5+ulUWsavApWdL/E+Vnbzgt7kPf6DLvU3IuDpfFk7n3gAZ11fQX3pswoQ==
X-Received: by 2002:a17:907:3ea2:: with SMTP id hs34mr3985577ejc.191.1642089414855;
        Thu, 13 Jan 2022 07:56:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:e200:8511:ed0f:ac2c:42f7? (p200300cbc703e2008511ed0fac2c42f7.dip0.t-ipconnect.de. [2003:cb:c703:e200:8511:ed0f:ac2c:42f7])
        by smtp.gmail.com with ESMTPSA id f29sm986699ejj.209.2022.01.13.07.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 07:56:54 -0800 (PST)
Message-ID: <0893e873-20c4-7e07-e7e4-3971dbb79118@redhat.com>
Date:   Thu, 13 Jan 2022 16:56:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 kvm/queue 01/16] mm/shmem: Introduce
 F_SEAL_INACCESSIBLE
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-2-chao.p.peng@linux.intel.com>
 <7eb40902-45dd-9193-37f1-efaca381529b@redhat.com>
 <20220106130638.GB43371@chaop.bj.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220106130638.GB43371@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.01.22 14:06, Chao Peng wrote:
> On Tue, Jan 04, 2022 at 03:22:07PM +0100, David Hildenbrand wrote:
>> On 23.12.21 13:29, Chao Peng wrote:
>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>
>>> Introduce a new seal F_SEAL_INACCESSIBLE indicating the content of
>>> the file is inaccessible from userspace in any possible ways like
>>> read(),write() or mmap() etc.
>>>
>>> It provides semantics required for KVM guest private memory support
>>> that a file descriptor with this seal set is going to be used as the
>>> source of guest memory in confidential computing environments such
>>> as Intel TDX/AMD SEV but may not be accessible from host userspace.
>>>
>>> At this time only shmem implements this seal.
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>>> ---
>>>  include/uapi/linux/fcntl.h |  1 +
>>>  mm/shmem.c                 | 37 +++++++++++++++++++++++++++++++++++--
>>>  2 files changed, 36 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
>>> index 2f86b2ad6d7e..e2bad051936f 100644
>>> --- a/include/uapi/linux/fcntl.h
>>> +++ b/include/uapi/linux/fcntl.h
>>> @@ -43,6 +43,7 @@
>>>  #define F_SEAL_GROW	0x0004	/* prevent file from growing */
>>>  #define F_SEAL_WRITE	0x0008	/* prevent writes */
>>>  #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
>>> +#define F_SEAL_INACCESSIBLE	0x0020  /* prevent file from accessing */
>>
>> I think this needs more clarification: the file content can still be
>> accessed using in-kernel mechanisms such as MEMFD_OPS for KVM. It
>> effectively disallows traditional access to a file (read/write/mmap)
>> that will result in ordinary MMU access to file content.
>>
>> Not sure how to best clarify that: maybe, prevent ordinary MMU access
>> (e.g., read/write/mmap) to file content?
> 
> Or: prevent userspace access (e.g., read/write/mmap) to file content?

The issue with that phrasing is that userspace will be able to access
that content, just via a different mechanism eventually ... e.g., via
the KVM MMU indirectly. If that makes it clearer what I mean :)

>>
>>>  /* (1U << 31) is reserved for signed error codes */
>>>  
>>>  /*
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 18f93c2d68f1..faa7e9b1b9bc 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -1098,6 +1098,10 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
>>>  		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
>>>  			return -EPERM;
>>>  
>>> +		if ((info->seals & F_SEAL_INACCESSIBLE) &&
>>> +		    (newsize & ~PAGE_MASK))
>>> +			return -EINVAL;
>>> +
>>
>> What happens when sealing and there are existing mmaps?
> 
> I think this is similar to ftruncate, in either case we just allow that.
> The existing mmaps will be unmapped and KVM will be notified to
> invalidate the mapping in the secondary MMU as well. This assume we
> trust the userspace even though it can not access the file content.

Can't we simply check+forbid instead?

-- 
Thanks,

David / dhildenb

