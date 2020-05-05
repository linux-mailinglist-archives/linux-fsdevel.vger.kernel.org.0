Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE4C1C51BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgEEJSu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:18:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38240 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728596AbgEEJSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588670327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuMGxsvybi8NjrS2E9p5tIYiMOdSBLcmmuty15NCl3s=;
        b=a8jAlpX2OgkAjKjZ0SMA+T/46LAjEUwU5wDzR272oqmoNLTNBxkLAIIDORGlgnAhBSD6OH
        Dg0xiGTXRvJmEWGJ95tgTHOgwA9LZbXkL4fE6UIKcOcs5VI7qMiDSauOCdVSCtTrU/m4/n
        hqMovwsAxVnrPaTN/ZpT3x44XCGql00=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-mbdNpxYhOvGH_r6k3W2Hnw-1; Tue, 05 May 2020 05:18:44 -0400
X-MC-Unique: mbdNpxYhOvGH_r6k3W2Hnw-1
Received: by mail-wr1-f71.google.com with SMTP id m5so906603wru.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zuMGxsvybi8NjrS2E9p5tIYiMOdSBLcmmuty15NCl3s=;
        b=t0Dob/uopuq5qhOpelNWKksBDE3QjVGWPTFuHR4+r9dhkBSThz6zSQlG2ci9s+0lbp
         LdcT6buKsYtVzITrDuZOW4X5YiA4wwgTOS6XS+0Apz/tAO41acbbJhnPiYSezGD5SA4c
         VH3uCU7wWQMMydmuLFip11XnC0oa+FFwJneebNCKaioD0SBZaxDDuhPAb6BvGK5+3hED
         5ziHJq8GCbzw3LmZt+3A5MKpWejU3vre/4+3ovLXzAblPw/oeh/KkvZP8i73l/xBis/T
         E5bxNHZYbCQBYyRhv3/XuhV4z/81wd61HGqiNfZvsfPwPyUFz8am5gsqt1gl5QP+mkCS
         zmwA==
X-Gm-Message-State: AGi0PuaROpxrtf7+qAMRKDbqFmyKYwzilGHR1Rs91Ln2Ppm/pJC0Um4P
        0KCkwI+Q4JKzToDohG0P1kHiKbZx0wt3PYh4r/f3qDKoWqfOw2dGTU8jI42UIhuHfQcMjwN5BxQ
        UY+ugTkjnoANSAz0Lc5EW5BPD5w==
X-Received: by 2002:adf:fc92:: with SMTP id g18mr2673638wrr.10.1588670322687;
        Tue, 05 May 2020 02:18:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypKX7pVuROFVyxwt8yc6FBoonk6++mD6BpR68uHXCtbveK9HdmTEsxgnCte+p9bp4Db4rFjGdw==
X-Received: by 2002:adf:fc92:: with SMTP id g18mr2673592wrr.10.1588670322377;
        Tue, 05 May 2020 02:18:42 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.186])
        by smtp.gmail.com with ESMTPSA id n6sm2246200wrs.81.2020.05.05.02.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 02:18:41 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To:     David Rientjes <rientjes@google.com>
Cc:     Jonathan Adams <jwadams@google.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200504110344.17560-1-eesposit@redhat.com>
 <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <f2654143-b8e5-5a1f-8bd0-0cb0df2cd638@redhat.com>
Date:   Tue, 5 May 2020 11:18:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/4/20 11:37 PM, David Rientjes wrote:
> On Mon, 4 May 2020, Emanuele Giuseppe Esposito wrote:
> 
>>
>> In this patch series I introduce statsfs, a synthetic ram-based virtual
>> filesystem that takes care of gathering and displaying statistics for the
>> Linux kernel subsystems.
>>
> 
> This is exciting, we have been looking in the same area recently.  Adding
> Jonathan Adams <jwadams@google.com>.
> 
> In your diffstat, one thing I notice that is omitted: an update to
> Documentation/* :)  Any chance of getting some proposed Documentation/
> updates with structure of the fs, the per subsystem breakdown, and best
> practices for managing the stats from the kernel level?

Yes, I will write some documentation. Thank you for the suggestion.

>>
>> Values represent quantites that are gathered by the statsfs user. Examples
>> of values include the number of vm exits of a given kind, the amount of
>> memory used by some data structure, the length of the longest hash table
>> chain, or anything like that. Values are defined with the
>> statsfs_source_add_values function. Each value is defined by a struct
>> statsfs_value; the same statsfs_value can be added to many different
>> sources. A value can be considered "simple" if it fetches data from a
>> user-provided location, or "aggregate" if it groups all values in the
>> subordinates sources that include the same statsfs_value.
>>
> 
> This seems like it could have a lot of overhead if we wanted to
> periodically track the totality of subsystem stats as a form of telemetry
> gathering from userspace.  To collect telemetry for 1,000 different stats,
> do we need to issue lseek()+read() syscalls for each of them individually
> (or, worse, open()+read()+close())?
> 
> Any thoughts on how that can be optimized?  A couple of ideas:
> 
>   - an interface that allows gathering of all stats for a particular
>     interface through a single file that would likely be encoded in binary
>     and the responsibility of userspace to disseminate, or
> 
>   - an interface that extends beyond this proposal and allows the reader to
>     specify which stats they are interested in collecting and then the
>     kernel will only provide these stats in a well formed structure and
>     also be binary encoded.

Are you thinking of another file, containing all the stats for the 
directory in binary format?

> We've found that the one-file-per-stat method is pretty much a show
> stopper from the performance view and we always must execute at least two
> syscalls to obtain a single stat.
> 
> Since this is becoming a generic API (good!!), maybe we can discuss
> possible ways to optimize gathering of stats in mass?

Sure, the idea of a binary format was considered from the beginning in 
[1], and it can be done either together with the current filesystem, or 
as a replacement via different mount options.

Thank you,
Emanuele

>> [1] https://lore.kernel.org/kvm/5d6cdcb1-d8ad-7ae6-7351-3544e2fa366d@redhat.com/?fbclid=IwAR18LHJ0PBcXcDaLzILFhHsl3qpT3z2vlG60RnqgbpGYhDv7L43n0ZXJY8M


>>
>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>>
>> v1->v2 remove unnecessary list_foreach_safe loops, fix wrong indentation,
>> change statsfs in stats_fs
>>
>> Emanuele Giuseppe Esposito (5):
>>    refcount, kref: add dec-and-test wrappers for rw_semaphores
>>    stats_fs API: create, add and remove stats_fs sources and values
>>    kunit: tests for stats_fs API
>>    stats_fs fs: virtual fs to show stats to the end-user
>>    kvm_main: replace debugfs with stats_fs
>>
>>   MAINTAINERS                     |    7 +
>>   arch/arm64/kvm/Kconfig          |    1 +
>>   arch/arm64/kvm/guest.c          |    2 +-
>>   arch/mips/kvm/Kconfig           |    1 +
>>   arch/mips/kvm/mips.c            |    2 +-
>>   arch/powerpc/kvm/Kconfig        |    1 +
>>   arch/powerpc/kvm/book3s.c       |    6 +-
>>   arch/powerpc/kvm/booke.c        |    8 +-
>>   arch/s390/kvm/Kconfig           |    1 +
>>   arch/s390/kvm/kvm-s390.c        |   16 +-
>>   arch/x86/include/asm/kvm_host.h |    2 +-
>>   arch/x86/kvm/Kconfig            |    1 +
>>   arch/x86/kvm/Makefile           |    2 +-
>>   arch/x86/kvm/debugfs.c          |   64 --
>>   arch/x86/kvm/stats_fs.c         |   56 ++
>>   arch/x86/kvm/x86.c              |    6 +-
>>   fs/Kconfig                      |   12 +
>>   fs/Makefile                     |    1 +
>>   fs/stats_fs/Makefile            |    6 +
>>   fs/stats_fs/inode.c             |  337 ++++++++++
>>   fs/stats_fs/internal.h          |   35 +
>>   fs/stats_fs/stats_fs-tests.c    | 1088 +++++++++++++++++++++++++++++++
>>   fs/stats_fs/stats_fs.c          |  773 ++++++++++++++++++++++
>>   include/linux/kref.h            |   11 +
>>   include/linux/kvm_host.h        |   39 +-
>>   include/linux/refcount.h        |    2 +
>>   include/linux/stats_fs.h        |  304 +++++++++
>>   include/uapi/linux/magic.h      |    1 +
>>   lib/refcount.c                  |   32 +
>>   tools/lib/api/fs/fs.c           |   21 +
>>   virt/kvm/arm/arm.c              |    2 +-
>>   virt/kvm/kvm_main.c             |  314 ++-------
>>   32 files changed, 2772 insertions(+), 382 deletions(-)
>>   delete mode 100644 arch/x86/kvm/debugfs.c
>>   create mode 100644 arch/x86/kvm/stats_fs.c
>>   create mode 100644 fs/stats_fs/Makefile
>>   create mode 100644 fs/stats_fs/inode.c
>>   create mode 100644 fs/stats_fs/internal.h
>>   create mode 100644 fs/stats_fs/stats_fs-tests.c
>>   create mode 100644 fs/stats_fs/stats_fs.c
>>   create mode 100644 include/linux/stats_fs.h
>>
>> -- 
>> 2.25.2
>>

