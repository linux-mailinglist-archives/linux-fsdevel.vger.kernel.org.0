Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036DD59A695
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 21:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351030AbiHSTh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 15:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351077AbiHSTh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:37:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C65109A1B
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 12:37:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo8428789pjd.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=k9KpOd9i/ZNi1t1K9tR8np0p9gkpfM3VrD2lfsO25Mo=;
        b=HC3bATKO80CNvgZPBl3R//G0TK0r3ngVuJktWYhEP8NaHJnXH6/HXfP142vc4oH9Aw
         oJyeetzADSpgcohe210zCSh8DQfsxcwVcf8c/0gFINaAT23hmdkT8TGnAAdrxDmHlKGf
         fctMqKyKBGj1alfGcbKBQ2/gLlX44if/PwK0HhdyLICbvLdbiwe2vlRz/1zOJjoePZzP
         pxHe9IuraDvzqkDJ8J71BHT2b3xfBrXGMv+aVkONLXSJx4ZIfmskklMmsRvcCwUvoOUK
         TVCUXOcQ5kN8i0t/EAZeKwJMG0HSZvtVvquJlnRoYjq4V1P98OEYU5jvAIbcSHYlInUs
         Kn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=k9KpOd9i/ZNi1t1K9tR8np0p9gkpfM3VrD2lfsO25Mo=;
        b=EG4s9PbcH658j8PwvM6wKbkZgoksN9GGtg3MB4Jkd1iIYHNdGEbuqk+Wib76AuQUPa
         IEGDRfFteHbQpL21Ar31D7xVNDLtyniNCdusdhWc8IhARgc88cuDlP2ihkMsOB0ZDS5p
         DZVNGbJXr31o3+LYpaWuvtyj1I4bMYkO+W1hi72GH9rYeiTBM+UaIZUmmjwPg/CHRp6g
         zHs5blPlyqlQXVzmYvOboSx1bYdmbGy67RlHP6i6LMkEjtDTnkGZmgCoMotkr9GD7r1G
         YhF/KawhyU1VpOCku0oy2qDEypRjUIK0gDBMvofjSvchYlsfxIBlR7XG5ayIuAhf3IN/
         UUow==
X-Gm-Message-State: ACgBeo0NXE3spGa5xkmJm6f5ACKrXvaiHNGaWhkk8s5vxb5DeiH+55mT
        az6K4KSjJKUDYJyy2ZB/rApGe1xOLwQU3IgtUEeAdxUkjXnENnsu
X-Google-Smtp-Source: AA6agR6k/DAzQx9qRqaoRc0DfYUeZpNmDFrlAHfGRBtmhp/IGDr8OXnmdkj2tKhP7ciJU8phJ2DTP7DaAQ0zqKSGHws=
X-Received: by 2002:a17:90b:4b91:b0:1f4:e116:8f1 with SMTP id
 lr17-20020a17090b4b9100b001f4e11608f1mr10112497pjb.121.1660937873970; Fri, 19
 Aug 2022 12:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com> <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
In-Reply-To: <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Fri, 19 Aug 2022 12:37:42 -0700
Message-ID: <CAGtprH9xyw6bt4=RBWF6-v2CSpabOCpKq5rPz+e-9co7EisoVQ@mail.gmail.com>
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> ...
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 230c8ff9659c..bb714c2a4b06 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -914,6 +914,35 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>
>  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
>
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +#define KVM_MEM_ATTR_PRIVATE   0x0001
> +static int kvm_vm_ioctl_set_encrypted_region(struct kvm *kvm, unsigned int ioctl,
> +                                            struct kvm_enc_region *region)
> +{
> +       unsigned long start, end;
> +       void *entry;
> +       int r;
> +
> +       if (region->size == 0 || region->addr + region->size < region->addr)
> +               return -EINVAL;
> +       if (region->addr & (PAGE_SIZE - 1) || region->size & (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       start = region->addr >> PAGE_SHIFT;
> +       end = (region->addr + region->size - 1) >> PAGE_SHIFT;
> +
> +       entry = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION ?
> +                               xa_mk_value(KVM_MEM_ATTR_PRIVATE) : NULL;
> +
> +       r = xa_err(xa_store_range(&kvm->mem_attr_array, start, end,
> +                                       entry, GFP_KERNEL_ACCOUNT));

xa_store_range seems to create multi-index entries by default.
Subsequent xa_store_range call changes all the entries stored
previously.
xa_store needs to be used here instead of xa_store_range to achieve
the intended behavior.

> +
> +       kvm_zap_gfn_range(kvm, start, end + 1);
> +
> +       return r;
> +}
> +#endif /* CONFIG_HAVE_KVM_PRIVATE_MEM */
> +
> ...
