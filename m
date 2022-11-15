Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AF7629FC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 18:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiKORAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 12:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKORAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:00:00 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A5C29347
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 08:59:58 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o4so25232703wrq.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 08:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfMmr+1QjnU4sjisGoRqb8FxQFwgEIl76i25CgDhNpM=;
        b=UqienqYRbAH1e7sBF3xN1GzQ8JdfuqdaWqFqMP035H8CJyl9AAUJSxwUBiO+qV+wS1
         j2+sEBQeEWUhhlE8ZdvRf+ZiZC11E+JtnjQBGWqt55TQ5ojF5av0xQ0wfwww8/QCcLo0
         8GOkGU4WQOpSOHyF0SkAkiHP6h0Lo/Q1bpP2Z9TsjHOP6LPgvrNrPFpIHdVDwAiZGv1s
         bXYcK28rMaUtSlGU+/1U6fOi4/tj6/fZgiRiWt3pEHmgs6vbP27mioTyX1gaSyGeAhJP
         E73h2QDDCPNlZZoOl/dZq2jCFsoI3nF/FCoeBB/4o1ai7DAKHVm5TRu75uSL+hb9Nzkz
         xouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mfMmr+1QjnU4sjisGoRqb8FxQFwgEIl76i25CgDhNpM=;
        b=fRd9wPSUKI2pTajdhmBbg9txKLWnB9ueCsZHs7uY5EKZobPQsMdOpiz+DbNDfkPUan
         tkJvQp0EB4GSvtoN+HZUqx0pVC5BQHyhrILagkdQzUcjL/xSTMPKw7q5mLcSVz4VkTBm
         S8SyZ+fNGJym8pjlBd/Egd9G+g35QrQ4YXLHQoEarDztUayDAf+oXBbVmwRKb51EMJyh
         XspN+3Fv+lhuasjoAuvUtWuMPnbtSJP/pGkQs/YIGqGef501eU3I7sLgwA8fq6bi+48c
         HqgeUXZqtx44BpwupCA8xJGdSud6Iqrk8mDYd5vYVGSeuoqv7msAjhBIV0eY0LEE2eEJ
         1gvQ==
X-Gm-Message-State: ANoB5pkOj6rwYZSPQ0eYXllZjioyn+QUYr/lTics4hxikac3nlKR6oq4
        cXQdjbir/zjcYqlyHLKgGNOrkg==
X-Google-Smtp-Source: AA0mqf5UAnWqAlfsUVaCZun0Qjg6m/flblOYFMgHrRCoRvoR77BrSCG7B6qCWFEvqij78GTSI8YGew==
X-Received: by 2002:a5d:6743:0:b0:22e:28fe:39d6 with SMTP id l3-20020a5d6743000000b0022e28fe39d6mr11543050wrw.701.1668531596730;
        Tue, 15 Nov 2022 08:59:56 -0800 (PST)
Received: from zen.linaroharston ([185.81.254.11])
        by smtp.gmail.com with ESMTPSA id bl21-20020adfe255000000b002366dd0e030sm12793968wrb.68.2022.11.15.08.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:59:55 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 5BEF21FFB7;
        Tue, 15 Nov 2022 16:59:55 +0000 (GMT)
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
User-agent: mu4e 1.9.2; emacs 28.2.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Date:   Tue, 15 Nov 2022 16:56:12 +0000
In-reply-to: <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
Message-ID: <87cz9o9mr8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Chao Peng <chao.p.peng@linux.intel.com> writes:

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
>  Documentation/virt/kvm/api.rst | 23 +++++++++++++++++++++++
>  include/uapi/linux/kvm.h       |  9 +++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index f3fa75649a78..975688912b8c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6537,6 +6537,29 @@ array field represents return values. The userspac=
e should update the return
>  values of SBI call before resuming the VCPU. For more details on RISC-V =
SBI
>  spec refer, https://github.com/riscv/riscv-sbi-doc.
>=20=20
> +::
> +
> +		/* KVM_EXIT_MEMORY_FAULT */
> +		struct {
> +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
> +			__u32 flags;
> +			__u32 padding;
> +			__u64 gpa;
> +			__u64 size;
> +		} memory;
> +
> +If exit reason is KVM_EXIT_MEMORY_FAULT then it indicates that the VCPU =
has
> +encountered a memory error which is not handled by KVM kernel module and
> +userspace may choose to handle it. The 'flags' field indicates the memory
> +properties of the exit.
> +
> + - KVM_MEMORY_EXIT_FLAG_PRIVATE - indicates the memory error is caused by
> +   private memory access when the bit is set. Otherwise the memory error=
 is
> +   caused by shared memory access when the bit is clear.

What does a shared memory access failure entail?

If you envision any other failure modes it might be worth making it
explicit with additional flags. I also wonder if a bitmask makes sense if
there can only be one reason for a failure? Maybe all that is needed is
a reason enum?

> +
> +'gpa' and 'size' indicate the memory range the error occurs at. The user=
space
> +may handle the error and return to KVM to retry the previous memory acce=
ss.
> +
>  ::
>=20=20
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
>=20=20
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
> @@ -538,6 +539,14 @@ struct kvm_run {
>  #define KVM_NOTIFY_CONTEXT_INVALID	(1 << 0)
>  			__u32 flags;
>  		} notify;
> +		/* KVM_EXIT_MEMORY_FAULT */
> +		struct {
> +#define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
> +			__u32 flags;
> +			__u32 padding;
> +			__u64 gpa;
> +			__u64 size;
> +		} memory;
>  		/* Fix the size of the union. */
>  		char padding[256];
>  	};


--=20
Alex Benn=C3=A9e
