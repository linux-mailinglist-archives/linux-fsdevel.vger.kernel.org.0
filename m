Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA143D8D0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 13:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhG1LvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 07:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhG1LvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:51:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE7C061757;
        Wed, 28 Jul 2021 04:51:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l18so2168567wrv.5;
        Wed, 28 Jul 2021 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yp5cWmb4AkxFKBl8NuqRHF/Fj+1O+kz07eQ9B1cFrTM=;
        b=rjufznQpIgT9Y4X5wATRAu5BDsSd6HgqZ5d9ZbD1tV5XqwI37bp4dlZn7sEU3roUWH
         clGVPK5HZt0ibEg3n3rnQO/LLfCGXNB1z/OcJviBqX5BnDvPAT6ovSqtf2GG9z+b2bf5
         hNRMQ5K1GU2t5utAkiIOYPFplsyDtoOtGyLrHrE0gjJStx3UlTxodAu66P1SUyVqHuRo
         M6T6x8SRy36Ns7u7LeNWzv4QGHqMLlVM5YZOdZC2fd6M+9vcopSschELbxKP610fuQ0E
         cnkAxdbpF2osQv7uYuvrxQu8i8zU9T8kP5ggNwdog+ispko+yCugJr87oZyjOacGVREA
         620A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yp5cWmb4AkxFKBl8NuqRHF/Fj+1O+kz07eQ9B1cFrTM=;
        b=QPuryN1fLc/VPu6yEAvogl5fia8uovJAdD5soyvzbh84n3HUPMW+hTkIgVHJtGMrE1
         nKQ2jii29LcsxjHkisvumT1oAy2ADr1pz5KqxEzu5jHoMij+kNTiIBxwT8VLZiIEjnZp
         7mOdcvzPrbNAaMPE3XlRqsNZmE+RJ0MYwPs5X8F3fXxjK2ZzYVk9i4VTyklWjqIJTqCg
         6zcMSr6WQrv5MYAvttKw3SNWXQwlXfl9AfaaV8biVmyeEyU9yx6cxUwkWrDD63AV30xY
         ZE9SbLvjy/vIu8YhoD/NK3JrU6c1YMlquXYJDov8lJu/LKPfWFjJgRzl7Hg5CBQzxCZ3
         k6tA==
X-Gm-Message-State: AOAM530Ia0096yhmBDQwaQ+HSKaF4EE/BOpyfIV1bBc8AtuXPKqRweLr
        e58feEfqg/+IXQMk5+0JKt0=
X-Google-Smtp-Source: ABdhPJxnFTfpGwAmyL+B5BY1p5oMjCoBMdD/Omxoq7nc4R8MHgQpLQLkqKXCOPeVLSKKDmRSYkfgVw==
X-Received: by 2002:adf:d1c7:: with SMTP id b7mr22336082wrd.108.1627473059546;
        Wed, 28 Jul 2021 04:50:59 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6a5d:b580:2891:cbac? ([2a02:908:1252:fb60:6a5d:b580:2891:cbac])
        by smtp.gmail.com with ESMTPSA id q72sm7758671wme.14.2021.07.28.04.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 04:50:59 -0700 (PDT)
Subject: Re: [PATCH 00/11] Implement generic prot_guest_has() helper function
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        David Airlie <airlied@linux.ie>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, Baoquan He <bhe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <joro@8bytes.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Dave Young <dyoung@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5cd35ae7-a7ff-eca4-5d2a-f0dad94e1d7a@gmail.com>
Date:   Wed, 28 Jul 2021 13:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 28.07.21 um 00:26 schrieb Tom Lendacky:
> This patch series provides a generic helper function, prot_guest_has(),
> to replace the sme_active(), sev_active(), sev_es_active() and
> mem_encrypt_active() functions.
>
> It is expected that as new protected virtualization technologies are
> added to the kernel, they can all be covered by a single function call
> instead of a collection of specific function calls all called from the
> same locations.
>
> The powerpc and s390 patches have been compile tested only. Can the
> folks copied on this series verify that nothing breaks for them.

As GPU driver dev I'm only one end user of this, but at least from the 
high level point of view that makes totally sense to me.

Feel free to add an Acked-by: Christian König <christian.koenig@amd.com>.

We could run that through the AMD GPU unit tests, but I fear we actually 
don't test on a system with SEV/SME active.

Going to raise that on our team call today.

Regards,
Christian.

>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
> Cc: Will Deacon <will@kernel.org>
>
> ---
>
> Patches based on:
>    https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
>    commit 79e920060fa7 ("Merge branch 'WIP/fixes'")
>
> Tom Lendacky (11):
>    mm: Introduce a function to check for virtualization protection
>      features
>    x86/sev: Add an x86 version of prot_guest_has()
>    powerpc/pseries/svm: Add a powerpc version of prot_guest_has()
>    x86/sme: Replace occurrences of sme_active() with prot_guest_has()
>    x86/sev: Replace occurrences of sev_active() with prot_guest_has()
>    x86/sev: Replace occurrences of sev_es_active() with prot_guest_has()
>    treewide: Replace the use of mem_encrypt_active() with
>      prot_guest_has()
>    mm: Remove the now unused mem_encrypt_active() function
>    x86/sev: Remove the now unused mem_encrypt_active() function
>    powerpc/pseries/svm: Remove the now unused mem_encrypt_active()
>      function
>    s390/mm: Remove the now unused mem_encrypt_active() function
>
>   arch/Kconfig                               |  3 ++
>   arch/powerpc/include/asm/mem_encrypt.h     |  5 --
>   arch/powerpc/include/asm/protected_guest.h | 30 +++++++++++
>   arch/powerpc/platforms/pseries/Kconfig     |  1 +
>   arch/s390/include/asm/mem_encrypt.h        |  2 -
>   arch/x86/Kconfig                           |  1 +
>   arch/x86/include/asm/kexec.h               |  2 +-
>   arch/x86/include/asm/mem_encrypt.h         | 13 +----
>   arch/x86/include/asm/protected_guest.h     | 27 ++++++++++
>   arch/x86/kernel/crash_dump_64.c            |  4 +-
>   arch/x86/kernel/head64.c                   |  4 +-
>   arch/x86/kernel/kvm.c                      |  3 +-
>   arch/x86/kernel/kvmclock.c                 |  4 +-
>   arch/x86/kernel/machine_kexec_64.c         | 19 +++----
>   arch/x86/kernel/pci-swiotlb.c              |  9 ++--
>   arch/x86/kernel/relocate_kernel_64.S       |  2 +-
>   arch/x86/kernel/sev.c                      |  6 +--
>   arch/x86/kvm/svm/svm.c                     |  3 +-
>   arch/x86/mm/ioremap.c                      | 16 +++---
>   arch/x86/mm/mem_encrypt.c                  | 60 +++++++++++++++-------
>   arch/x86/mm/mem_encrypt_identity.c         |  3 +-
>   arch/x86/mm/pat/set_memory.c               |  3 +-
>   arch/x86/platform/efi/efi_64.c             |  9 ++--
>   arch/x86/realmode/init.c                   |  8 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
>   drivers/gpu/drm/drm_cache.c                |  4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_msg.c        |  6 +--
>   drivers/iommu/amd/init.c                   |  7 +--
>   drivers/iommu/amd/iommu.c                  |  3 +-
>   drivers/iommu/amd/iommu_v2.c               |  3 +-
>   drivers/iommu/iommu.c                      |  3 +-
>   fs/proc/vmcore.c                           |  6 +--
>   include/linux/mem_encrypt.h                |  4 --
>   include/linux/protected_guest.h            | 37 +++++++++++++
>   kernel/dma/swiotlb.c                       |  4 +-
>   36 files changed, 218 insertions(+), 104 deletions(-)
>   create mode 100644 arch/powerpc/include/asm/protected_guest.h
>   create mode 100644 arch/x86/include/asm/protected_guest.h
>   create mode 100644 include/linux/protected_guest.h
>

