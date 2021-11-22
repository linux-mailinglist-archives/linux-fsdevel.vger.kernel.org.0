Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DD2458B49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 10:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbhKVJ3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 04:29:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239046AbhKVJ3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637573177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W24LOqoXm5rO4QnnE3nnOA9qNOGul+S9uy89jqjOA+M=;
        b=JsDWvvyOwg7B1qEHfHgUTlJBgb/rH5nZAqr/wCm59mY0ufqqLWqbW4U4+aI8z2vK5M0GKT
        zp2npE0kwCrqCIxizdonnROTfIbcboRxa0SJjuOW25g00FtoejRVTh9I8MDjSz7byMvTz6
        A80LXZLhh1uOdZlPCwBhfvvy1yTVFmA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-jsGF0w8UPza8XfBzQFezQQ-1; Mon, 22 Nov 2021 04:26:15 -0500
X-MC-Unique: jsGF0w8UPza8XfBzQFezQQ-1
Received: by mail-wr1-f70.google.com with SMTP id q17-20020adff791000000b00183e734ba48so2941083wrp.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 01:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=W24LOqoXm5rO4QnnE3nnOA9qNOGul+S9uy89jqjOA+M=;
        b=raY0CADlBWoaDC1X09rrrIQJOyDCPksK5e5TQmqlCLseTztererMajhcGKBNKpYibb
         kjYdXOJyfbDFsZMKNQbDjcYUFB9uhtzhp2Y7yQXboLd9UZbiMO/TpU9SvEMFnqgPPsnD
         aJsH2ldpFfEg7YTOEM0vuM/kjHjU1BK8p4Ep2r8thoHVfMkuuT0Twz1qrE9aV7JB37tH
         QUBnLlH5o2VXJOtE5vgqJhqCaikqnQQmouV3UyGWfoGK1TqMeZNKdzEX2ckIhgmcWxtk
         v/DsM/kvUOZUtUHmhTo2BvkmBO+2aN1OmjCGCn+VA5J3xAd1Yb9p2FDlHVESSG8hz45t
         cAHQ==
X-Gm-Message-State: AOAM530GIkTvz2tE7k3/ugjPnfZjz6mjbefjNdqqjylySNdHfXq5YPso
        AcDNXP5h4C2tV+ZbOI70bIzA3y6Q3h1+roJ+Tvk8v7jwbIFny7Ah2Vp3gXh2UJun/DA5CiOFv9Z
        DpJ0+6xYxk6UV9j2g0U/HuLWy2g==
X-Received: by 2002:a05:600c:104b:: with SMTP id 11mr28668552wmx.54.1637573174580;
        Mon, 22 Nov 2021 01:26:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLFJu5j4VPLLnAmpU8CA4IejbWxqy8Vo0yv4T3cYINYpxhqk/tZpLIoYKCers6pf22TsjTpQ==
X-Received: by 2002:a05:600c:104b:: with SMTP id 11mr28668518wmx.54.1637573174383;
        Mon, 22 Nov 2021 01:26:14 -0800 (PST)
Received: from [192.168.3.132] (p5b0c667b.dip0.t-ipconnect.de. [91.12.102.123])
        by smtp.gmail.com with ESMTPSA id t8sm8351680wrv.30.2021.11.22.01.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 01:26:13 -0800 (PST)
Message-ID: <4efdccac-245f-eb1f-5b7f-c1044ff0103d@redhat.com>
Date:   Mon, 22 Nov 2021 10:26:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
 <20211119160023.GI876299@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211119160023.GI876299@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.11.21 17:00, Jason Gunthorpe wrote:
> On Fri, Nov 19, 2021 at 04:39:15PM +0100, David Hildenbrand wrote:
> 
>>> If qmeu can put all the guest memory in a memfd and not map it, then
>>> I'd also like to see that the IOMMU can use this interface too so we
>>> can have VFIO working in this configuration.
>>
>> In QEMU we usually want to (and must) be able to access guest memory
>> from user space, with the current design we wouldn't even be able to
>> temporarily mmap it -- which makes sense for encrypted memory only. The
>> corner case really is encrypted memory. So I don't think we'll see a
>> broad use of this feature outside of encrypted VMs in QEMU. I might be
>> wrong, most probably I am :)
> 
> Interesting..
> 
> The non-encrypted case I had in mind is the horrible flow in VFIO to
> support qemu re-execing itself (VFIO_DMA_UNMAP_FLAG_VADDR).

Thanks for sharing!

> 
> Here VFIO is connected to a VA in a mm_struct that will become invalid
> during the kexec period, but VFIO needs to continue to access it. For
> IOMMU cases this is OK because the memory is already pinned, but for
> the 'emulated iommu' used by mdevs pages are pinned dynamically. qemu
> needs to ensure that VFIO can continue to access the pages across the
> kexec, even though there is nothing to pin_user_pages() on.
> 
> This flow would work a lot better if VFIO was connected to the memfd
> that is storing the guest memory. Then it naturally doesn't get
> disrupted by exec() and we don't need the mess in the kernel..

I do wonder if we want to support sharing such memfds between processes
in all cases ... we most certainly don't want to be able to share
encrypted memory between VMs (I heard that the kernel has to forbid
that). It would make sense in the use case you describe, though.

> 
> I was wondering if we could get here using the direct_io APIs but this
> would do the job too.
> 
>> Apart from the special "encrypted memory" semantics, I assume nothing
>> speaks against allowing for mmaping these memfds, for example, for any
>> other VFIO use cases.
> 
> We will eventually have VFIO with "encrypted memory". There was a talk
> in LPC about the enabling work for this.

Yes, I heard about that as well. In the foreseeable future, we'll have
shared memory only visible for VFIO devices.

> 
> So, if the plan is to put fully encrpyted memory inside a memfd, then
> we still will eventually need a way to pull the pfns it into the
> IOMMU, presumably along with the access control parameters needed to
> pass to the secure monitor to join a PCI device to the secure memory.

Long-term, agreed.

-- 
Thanks,

David / dhildenb

