Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB474571CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhKSPmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 10:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235470AbhKSPmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637336360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DsNc1Iy6WSOW9ZyvvnH8bkc6OnCaXrc9G/cZpSnv6/Y=;
        b=Ahji00mm5wzmW1gi3w1PIQMf93hSmKcyLGGLP/NtWQrrxl3GnRgtA90H1KEjSdaxQRG5Wo
        xzAGbE+L09S6owDYIs8wRQ8aon6QXO5OL8lHh3WHUW/Tvd/TAmHjVM3FjKQL65q+76uZ9v
        Hzak3qCf5Lv9JywC/uWuxABmwgQFK0s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-d-dW5TX4PW-uB3RQInXudQ-1; Fri, 19 Nov 2021 10:39:19 -0500
X-MC-Unique: d-dW5TX4PW-uB3RQInXudQ-1
Received: by mail-wm1-f70.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso4938615wms.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 07:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=DsNc1Iy6WSOW9ZyvvnH8bkc6OnCaXrc9G/cZpSnv6/Y=;
        b=RTTBL3upmNHlWWiAlyzcwLdCbs/REm27S4W9Kv92/SxU4bK0qc1Qb8F6dMG1v4KKUg
         ZSKIzfb65fOoDE2K7vUS+rwn7pwX/9QWv7QABEcKY9RarLIj6LZOP4nMzgrQR9R/z+J/
         MW21qxF539Cho4/+zQl2g6lFB4qlW+fgVW6fLovjtjsH6fKa3DvrL7+33dWFrTKS/Qnr
         0qLAN1TIXG71tpXNhTSaycpJvqR1IaiQoWiglBzZU175o2p/Erl6WrENV4v6Eq293afR
         pjzKqS9HTmxTfhFFtht1K1jLbTMCBEdylws3iNv5S/M5iMmg684mWv9kwus1P1EAlGcD
         XUeQ==
X-Gm-Message-State: AOAM533gGUhgk2TdU5Fk2MV/MjTlKaaPc+k7z1czyxpZdlMGgXc5kMO6
        iWVHH5YTzWATsn65oqgnK6Eg7ZBd4uP8RUWemce49aTuODqUYjJp2RRjUbkxwwzp/Gjq9KMX97E
        7QZeBkzxtgz2VL+g+SpcFZKl8zQ==
X-Received: by 2002:a1c:7f56:: with SMTP id a83mr731983wmd.32.1637336357602;
        Fri, 19 Nov 2021 07:39:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4oITHzX1lxkkdw28CPiDPbmMdcPR9dT1zPt74sOy7KqZZqsLOUPmgkUDSXt/kGh+UoeRKqw==
X-Received: by 2002:a1c:7f56:: with SMTP id a83mr731928wmd.32.1637336357312;
        Fri, 19 Nov 2021 07:39:17 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6271.dip0.t-ipconnect.de. [91.12.98.113])
        by smtp.gmail.com with ESMTPSA id j19sm110732wra.5.2021.11.19.07.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 07:39:16 -0800 (PST)
Message-ID: <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
Date:   Fri, 19 Nov 2021 16:39:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Chao Peng <chao.p.peng@linux.intel.com>
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
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211119151943.GH876299@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.11.21 16:19, Jason Gunthorpe wrote:
> On Fri, Nov 19, 2021 at 09:47:27PM +0800, Chao Peng wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> The new seal type provides semantics required for KVM guest private
>> memory support. A file descriptor with the seal set is going to be used
>> as source of guest memory in confidential computing environments such as
>> Intel TDX and AMD SEV.
>>
>> F_SEAL_GUEST can only be set on empty memfd. After the seal is set
>> userspace cannot read, write or mmap the memfd.
>>
>> Userspace is in charge of guest memory lifecycle: it can allocate the
>> memory with falloc or punch hole to free memory from the guest.
>>
>> The file descriptor passed down to KVM as guest memory backend. KVM
>> register itself as the owner of the memfd via memfd_register_guest().
>>
>> KVM provides callback that needed to be called on fallocate and punch
>> hole.
>>
>> memfd_register_guest() returns callbacks that need be used for
>> requesting a new page from memfd.
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>>  include/linux/memfd.h      |  24 ++++++++
>>  include/linux/shmem_fs.h   |   9 +++
>>  include/uapi/linux/fcntl.h |   1 +
>>  mm/memfd.c                 |  33 +++++++++-
>>  mm/shmem.c                 | 123 ++++++++++++++++++++++++++++++++++++-
>>  5 files changed, 186 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
>> index 4f1600413f91..ff920ef28688 100644
>> +++ b/include/linux/memfd.h
>> @@ -4,13 +4,37 @@
>>  
>>  #include <linux/file.h>
>>  
>> +struct guest_ops {
>> +	void (*invalidate_page_range)(struct inode *inode, void *owner,
>> +				      pgoff_t start, pgoff_t end);
>> +	void (*fallocate)(struct inode *inode, void *owner,
>> +			  pgoff_t start, pgoff_t end);
>> +};
>> +
>> +struct guest_mem_ops {
>> +	unsigned long (*get_lock_pfn)(struct inode *inode, pgoff_t offset,
>> +				      bool alloc, int *order);
>> +	void (*put_unlock_pfn)(unsigned long pfn);
>> +
>> +};
> 
> Ignoring confidential compute for a moment
> 
> If qmeu can put all the guest memory in a memfd and not map it, then
> I'd also like to see that the IOMMU can use this interface too so we
> can have VFIO working in this configuration.

In QEMU we usually want to (and must) be able to access guest memory
from user space, with the current design we wouldn't even be able to
temporarily mmap it -- which makes sense for encrypted memory only. The
corner case really is encrypted memory. So I don't think we'll see a
broad use of this feature outside of encrypted VMs in QEMU. I might be
wrong, most probably I am :)

> 
> As designed the above looks useful to import a memfd to a VFIO
> container but could you consider some more generic naming than calling
> this 'guest' ?

+1 the guest terminology is somewhat sob-optimal.

> 
> Along the same lines, to support fast migration, we'd want to be able
> to send these things to the RDMA subsytem as well so we can do data
> xfer. Very similar to VFIO.
> 
> Also, shouldn't this be two patches? F_SEAL is not really related to
> these acessors, is it?


Apart from the special "encrypted memory" semantics, I assume nothing
speaks against allowing for mmaping these memfds, for example, for any
other VFIO use cases.

-- 
Thanks,

David / dhildenb

