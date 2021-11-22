Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18DE458F82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 14:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbhKVNjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 08:39:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239341AbhKVNjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637588154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=602lNvVOZar2m+HSFbxBYiyDNXrGO+dVi/Ze/KZAj6g=;
        b=ZNDVdueQ4xrwWe5pXhJgvmseao91pgGi4k943MKsjUnPjFhJBevrarVBZ/Y/Ght0GUGvXk
        FmHMfDzufOBWB+sPHo6bKBVpkZ+lMUvw/XAK8svFtTb9U9RdnRxN1+r6M/Y5LPG17FVzoR
        9xfdcuB2bWSuUu1Z0DjXDXXh6biDfrs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-LR8kMv0kOniFkxSrrS5Xuw-1; Mon, 22 Nov 2021 08:35:53 -0500
X-MC-Unique: LR8kMv0kOniFkxSrrS5Xuw-1
Received: by mail-wm1-f71.google.com with SMTP id 187-20020a1c02c4000000b003335872db8dso6324560wmc.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 05:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=602lNvVOZar2m+HSFbxBYiyDNXrGO+dVi/Ze/KZAj6g=;
        b=dqsSrk+X4kdrvypSbIUg6Ie7BxGJAhcjpEx6qCxdYPrFotzpRlAobeSZXva7phRI9v
         9SlkCoEx1Wf7YaBSPWqnbjj6efYYvmKMlV41z9MJPOYOxglv/peaahDY/I9UIwQgd0SC
         tzv0/S0rCtQbTPBJSmsLd8yhnnnHtATlfZOyuPYt2fF844jeFivFSQFUPeDrWel9ccei
         e4b4Qg7W8n8Fb0r6OkT229H9AwhYWTrKG8kdSd6vRN/bqAg5rhhnlpma7weknBbe7j+B
         zYhaLAtjASrSc+j5h/cI+s6i8V5ePDxWF50u1IoFbNvK0D+tQPjY9UOFaYx4qFnHtpZu
         G7sA==
X-Gm-Message-State: AOAM5318HVfShr2xB++gjHmWtKBWQW9RYBU5cZBFWpAXW54zH+7B7+Zh
        y2hoGa5f6M5oDanfRPr0hkrYO6EC3o2K8iajx/Cmf4MgtDUqqed9FfxBoIJV0KOf1ZcOWxkFbGF
        uR1dUlRuUp7Oh/gQaUMElu7iVPQ==
X-Received: by 2002:adf:f042:: with SMTP id t2mr39515190wro.180.1637588151973;
        Mon, 22 Nov 2021 05:35:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1uMKJXFglAoRaU5wdp0h6HMWbMcVgb35JuanaPUNLoA7JZ4ctjynARZIlt7KcqMq8Cl1Yqg==
X-Received: by 2002:adf:f042:: with SMTP id t2mr39515155wro.180.1637588151703;
        Mon, 22 Nov 2021 05:35:51 -0800 (PST)
Received: from [192.168.3.132] (p5b0c667b.dip0.t-ipconnect.de. [91.12.102.123])
        by smtp.gmail.com with ESMTPSA id m34sm24540329wms.25.2021.11.22.05.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 05:35:51 -0800 (PST)
Message-ID: <56c0dffc-5fc4-c337-3e85-a5c9ce619140@redhat.com>
Date:   Mon, 22 Nov 2021 14:35:49 +0100
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
 <4efdccac-245f-eb1f-5b7f-c1044ff0103d@redhat.com>
 <20211122133145.GQ876299@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211122133145.GQ876299@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22.11.21 14:31, Jason Gunthorpe wrote:
> On Mon, Nov 22, 2021 at 10:26:12AM +0100, David Hildenbrand wrote:
> 
>> I do wonder if we want to support sharing such memfds between processes
>> in all cases ... we most certainly don't want to be able to share
>> encrypted memory between VMs (I heard that the kernel has to forbid
>> that). It would make sense in the use case you describe, though.
> 
> If there is a F_SEAL_XX that blocks every kind of new access, who
> cares if userspace passes the FD around or not?
I was imagining that you actually would want to do some kind of "change
ownership". But yeah, the intended semantics and all use cases we have
in mind are not fully clear to me yet. If it's really "no new access"
(side note: is "access" the right word?) then sure, we can pass the fd
around.

-- 
Thanks,

David / dhildenb

