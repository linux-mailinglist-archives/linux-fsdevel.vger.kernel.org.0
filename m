Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6D45A66D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 16:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbhKWPXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 10:23:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235952AbhKWPXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637680807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nzZw5UfSegXbw18CEt/o6FXd1pUErV1MvwcNtl5mpBU=;
        b=PXbNt34wqhDZV3S3ho8nfqy6XLHaVcf3TDjhn+sjF1uYo8ccNHr2a7pt5mjOSvnL1QLkm+
        4j/VF6uD1TCizJWv/WagQ5/SFQngWX4BZJFKzVYsIgr2vM5niN2dIwvQG7XimNOkeuXDps
        LJK53mWx6zoLoj2/7zHrxQUo6eYmi1U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-mQ9ljtn2PaKZDqXGDHSH0g-1; Tue, 23 Nov 2021 10:20:05 -0500
X-MC-Unique: mQ9ljtn2PaKZDqXGDHSH0g-1
Received: by mail-wm1-f71.google.com with SMTP id l187-20020a1c25c4000000b0030da46b76daso1354826wml.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 07:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nzZw5UfSegXbw18CEt/o6FXd1pUErV1MvwcNtl5mpBU=;
        b=6VqH04bPMxv3t3VkLh2fdC5WdtTVWqv0IqD3Ulh0qAW6sPinhbV+65cQ11HKv2EfIR
         HhDCd+aMwtiVXYD8Pjqu9jbT/EQm7fwsD1pxc7y18L3rAuN1k6LFddD2eCoNCJK9PhJ+
         OPoXMUps3klalQtv+E39P+FrcuqAbqPFxQe4u9jPPw3arxiKDo9cz932aPwKeTKX64Nj
         iqdxvYbsbCclTEF4Qy7/9pCMW6kq9RPKkQKIOJ/FWQzbl74qB9Ro966swNooYIz1v1OH
         1C3tfkhKHUMPQbZv+TIrGXx7ovu8J2OlxVWXo9E6Fa8OUNfn8YbnX1jxB9uHluT5wNj6
         iSmg==
X-Gm-Message-State: AOAM531LX/XxnliFUHtsqrsPS6thFmHcB1tFJAjE4MaeeZ5qIUOQ96u+
        6bK6JCEoMKIAISXugsI2rYpouy6p0E5Ctw9cELFizwYmbdWuAo+CGJUDl7eUrl+cS1IoJlfaRlJ
        f4/SU/LvRg7OmpfpNzAC2mU3O5w==
X-Received: by 2002:a05:6000:1681:: with SMTP id y1mr8183318wrd.52.1637680804536;
        Tue, 23 Nov 2021 07:20:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUoSoPvPvLO49H6NY+gHF+4FNFe07RzaW7WxEc5sbe1D39sGgbrgj8rSNIcLf3gIFDDlAziw==
X-Received: by 2002:a05:6000:1681:: with SMTP id y1mr8183284wrd.52.1637680804298;
        Tue, 23 Nov 2021 07:20:04 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6765.dip0.t-ipconnect.de. [91.12.103.101])
        by smtp.gmail.com with ESMTPSA id n15sm1632169wmq.38.2021.11.23.07.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 07:20:03 -0800 (PST)
Message-ID: <ebe07977-8840-ebe2-57ce-9126a4081bb4@redhat.com>
Date:   Tue, 23 Nov 2021 16:20:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Content-Language: en-US
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Jonathan Corbet <corbet@lwn.net>,
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
 <6de78894-8269-ea3a-b4ee-a5cc4dad827e@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6de78894-8269-ea3a-b4ee-a5cc4dad827e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.11.21 10:06, Paolo Bonzini wrote:
> On 11/19/21 16:39, David Hildenbrand wrote:
>>> If qmeu can put all the guest memory in a memfd and not map it, then
>>> I'd also like to see that the IOMMU can use this interface too so we
>>> can have VFIO working in this configuration.
>>
>> In QEMU we usually want to (and must) be able to access guest memory
>> from user space, with the current design we wouldn't even be able to
>> temporarily mmap it -- which makes sense for encrypted memory only. The
>> corner case really is encrypted memory. So I don't think we'll see a
>> broad use of this feature outside of encrypted VMs in QEMU. I might be
>> wrong, most probably I am:)
> 
> It's not _that_ crazy an idea, but it's going to be some work to teach 
> KVM that it has to kmap/kunmap around all memory accesses.

I'm also concerned about userspace access. But you sound like you have a
plan :)

-- 
Thanks,

David / dhildenb

