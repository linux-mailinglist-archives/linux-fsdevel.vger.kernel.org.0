Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9098D60F500
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 12:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiJ0K14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 06:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiJ0K1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:27:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5C987FA8
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d25so1428123lfb.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ht1qDbWjn1s/Tw8Yqm0aVlTSVNxYRnuUWU/s2QqT7o4=;
        b=i9fpSLzo5jMs1+PlsjmjCMb+bkUFi0v3Bacdvscp0fuYHO+3FGaxuBdH9ct3K7RBFW
         GOHO2JyUIW1XW5jN40lUo04IVtr6sii/DKrSh0WfspjvZb3qBHVd8hHkcE/+pQE5KgUT
         S2C3X4NjLiLtUUo2sU1/2YrB8+0hbHtyswI86zJlvJsldbkJ1TcRW77xj3Ekpg2FTn5F
         yLbrMrtYI7k8BF9mLNKwdIJf3ttus48z491adWnKD4QvBxh4IYkD7eHihmuxCq7D5Fig
         oDQgpPvQAoHoFBnco6A5aUUG8BlMm3axdurIL1eFAQNWMO59iSALUb8xpG0lZ7hWTkgh
         HBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ht1qDbWjn1s/Tw8Yqm0aVlTSVNxYRnuUWU/s2QqT7o4=;
        b=s7Hj03dt6VYsdcvyHwf0hpaeTR1sVTmER1x+9nDypt4yESQ0zn7LMeqH1K+7g6Bq7Z
         z+2i4IU0kNrqtHZrmaZmyS45UWyrDyD1eLINbDRe4yKiEGydpM+rtV43QvUjukwcXCjj
         /KKI+obBUgR0iI977FjoicslqsjPr5imxBoKlABSB3dZJuA2Rg6jN8t+TMmsF2ttThya
         a8eKYA06aJid0hJuHjZ1Cse2TxQ2SBh5xBra6cKHyLfHNPO/1eS0lVloYppxKjYzh62N
         AAXuZkj1jJaQ62Nx41L9pRkCwKDm1DFDTxFdG/XA6/wIXhBsjNRxQS2fGdVdQl4sv3Bo
         oBfw==
X-Gm-Message-State: ACrzQf2EnDF+S6/oVPOwO5n5bkR2Fg3Cpp5LnSN5ZXUpnMb3+iFsv7WR
        i/3luOpm/7IYR0EsyNOFYwUHb5PSmx3whOCvEmZ67Q==
X-Google-Smtp-Source: AMsMyM7ZrmnFdb+RDiq0D6Ba0YwSUUNSHZjttBJh/zpOd85NYIAHkkRHyIoh13rneHkuGCKm3HEm2TuLmTrwb52teuM=
X-Received: by 2002:a05:6512:3f8b:b0:492:d1ed:5587 with SMTP id
 x11-20020a0565123f8b00b00492d1ed5587mr19119426lfa.355.1666866462514; Thu, 27
 Oct 2022 03:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com> <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
In-Reply-To: <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 27 Oct 2022 11:27:05 +0100
Message-ID: <CA+EHjTxzLDAW=MyfKFcL2cGQimw3bdVYePUgRw+=1+AbCQouUQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, Oct 25, 2022 at 4:19 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> This new KVM exit allows userspace to handle memory-related errors. It
> indicates an error happens in KVM at guest memory range [gpa, gpa+size).
> The flags includes additional information for userspace to handle the
> error. Currently bit 0 is defined as 'private memory' where '1'
> indicates error happens due to private memory access and '0' indicates
> error happens due to shared memory access.
>
> When private memory is enabled, this new exit will be used for KVM to
> exit to userspace for shared <-> private memory conversion in memory
> encryption usage. In such usage, typically there are two kind of memory
> conversions:
>   - explicit conversion: happens when guest explicitly calls into KVM
>     to map a range (as private or shared), KVM then exits to userspace
>     to perform the map/unmap operations.
>   - implicit conversion: happens in KVM page fault handler where KVM
>     exits to userspace for an implicit conversion when the page is in a
>     different state than requested (private or shared).
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

I have tested the V8 version of this patch on arm64/qemu, and
considering this hasn't changed:
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad



>  Documentation/virt/kvm/api.rst | 23 +++++++++++++++++++++++
>  include/uapi/linux/kvm.h       |  9 +++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index f3fa75649a78..975688912b8c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6537,6 +6537,29 @@ array field represents return values. The userspace should update the return
>  values of SBI call before resuming the VCPU. For more details on RISC-V SBI
>  spec refer, https://github.com/riscv/riscv-sbi-doc.
>
> +::
> +
> +               /* KVM_EXIT_MEMORY_FAULT */
> +               struct {
> +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE (1 << 0)
> +                       __u32 flags;
> +                       __u32 padding;
> +                       __u64 gpa;
> +                       __u64 size;
> +               } memory;
> +
> +If exit reason is KVM_EXIT_MEMORY_FAULT then it indicates that the VCPU has
> +encountered a memory error which is not handled by KVM kernel module and
> +userspace may choose to handle it. The 'flags' field indicates the memory
> +properties of the exit.
> +
> + - KVM_MEMORY_EXIT_FLAG_PRIVATE - indicates the memory error is caused by
> +   private memory access when the bit is set. Otherwise the memory error is
> +   caused by shared memory access when the bit is clear.
> +
> +'gpa' and 'size' indicate the memory range the error occurs at. The userspace
> +may handle the error and return to KVM to retry the previous memory access.
> +
>  ::
>
>      /* KVM_EXIT_NOTIFY */
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index f1ae45c10c94..fa60b032a405 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -300,6 +300,7 @@ struct kvm_xen_exit {
>  #define KVM_EXIT_RISCV_SBI        35
>  #define KVM_EXIT_RISCV_CSR        36
>  #define KVM_EXIT_NOTIFY           37
> +#define KVM_EXIT_MEMORY_FAULT     38
>
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
> @@ -538,6 +539,14 @@ struct kvm_run {
>  #define KVM_NOTIFY_CONTEXT_INVALID     (1 << 0)
>                         __u32 flags;
>                 } notify;
> +               /* KVM_EXIT_MEMORY_FAULT */
> +               struct {
> +#define KVM_MEMORY_EXIT_FLAG_PRIVATE   (1 << 0)
> +                       __u32 flags;
> +                       __u32 padding;
> +                       __u64 gpa;
> +                       __u64 size;
> +               } memory;
>                 /* Fix the size of the union. */
>                 char padding[256];
>         };
> --
> 2.25.1
>
