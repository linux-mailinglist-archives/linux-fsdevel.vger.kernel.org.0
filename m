Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1D44E9E92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 20:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbiC1SEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 14:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244902AbiC1SCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:02:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD04839F
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 11:01:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w21so16958123wra.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ytrSkwXUDSFcv9NwzDcZHJvhwX8Ip28tSIzF/72ZJ1Q=;
        b=VcyTOLVPq+V1OSY1Zl84llZUOW1+DiM07S87IWjY6+20V2jBdQ1vm+S2GV9qIJPtqv
         pLK4CJ9etgGbTHFOsHk97o/HxvnmIVI4mMk+EGHbRX6CJrIFhyvnSC6Rfimd+X/hl2uA
         a6RBgH4fTtSovkIx/LH5QsjPzVnFtvX03n05rdHb2Niy7y93hqADUsfUaEgwWTWY0DGl
         GeMqskNlS97LRMAsvI02JTysyyghYlfjb9mf6gG4HlbTYhYnGIBhn3XdBYfTYXBaOwsF
         95L6ejUjlhIht89eN92IqbUGGnk20Xbj3EaFlV+lYxgRhw/js5pXwNxfvBz/LaSuxyZ9
         fpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ytrSkwXUDSFcv9NwzDcZHJvhwX8Ip28tSIzF/72ZJ1Q=;
        b=FdxSvxjmC4cYw5PxS1svxcBKNQ21J2MZTMCHbZDnO2gaQSw6NepZaoRfSMrb9tsXC0
         DaxFTwVrn0h2zMiL2GQ+q2piB9WY9jJ2HZd6CxNu8XL7cUduSpvwN9HyYLAVSGYAC6vw
         V8HzDkJVTez79QpKO03jedAIhPUHBq2QqjLS5jz2BPEA20vVhReLUsm5rzumzB0mxoyW
         rmkjKhdoC4BX/6eAdUPX6X6SuFUz1q9T+T+FL8341QrvVoN+9/VfuvOZ96YAx/JZdAlT
         vP2OD4FbHEM8PUfehACqiYJC4rSKr4sexuIAtYmoXUu5x1+7om4V8JgmyxUzdKeobVCs
         8bvg==
X-Gm-Message-State: AOAM533ugSsamldd/rw/C5cA3U+7YXeFo8qGa/9Hw86rH7NrsyJKPBYK
        02yeYj80zaHVH+Atge8loPfIkA==
X-Google-Smtp-Source: ABdhPJz/DFJ+XVXhJNrPMlWXh7xu5l3qH4Q/QymhLpFp1U0q32kHVhkRByS9xkteULaLyJt8VbhF/w==
X-Received: by 2002:adf:fac8:0:b0:203:fb08:ff7 with SMTP id a8-20020adffac8000000b00203fb080ff7mr24674238wrs.648.1648490463028;
        Mon, 28 Mar 2022 11:01:03 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:2cfc:d300:5bbc:f8a0])
        by smtp.gmail.com with ESMTPSA id bi20-20020a05600c3d9400b0038cfe80eeddsm142468wmb.29.2022.03.28.11.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 11:01:02 -0700 (PDT)
Date:   Mon, 28 Mar 2022 19:00:58 +0100
From:   Quentin Perret <qperret@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, maz@kernel.org,
        will@kernel.org
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YkH32nx+YsJuUbmZ@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <YjyS6A0o4JASQK+B@google.com>
 <YkHspg+YzOsbUaCf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkHspg+YzOsbUaCf@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sean,

Thanks for the reply, this helps a lot.

On Monday 28 Mar 2022 at 17:13:10 (+0000), Sean Christopherson wrote:
> On Thu, Mar 24, 2022, Quentin Perret wrote:
> > For Protected KVM (and I suspect most other confidential computing
> > solutions), guests have the ability to share some of their pages back
> > with the host kernel using a dedicated hypercall. This is necessary
> > for e.g. virtio communications, so these shared pages need to be mapped
> > back into the VMM's address space. I'm a bit confused about how that
> > would work with the approach proposed here. What is going to be the
> > approach for TDX?
> > 
> > It feels like the most 'natural' thing would be to have a KVM exit
> > reason describing which pages have been shared back by the guest, and to
> > then allow the VMM to mmap those specific pages in response in the
> > memfd. Is this something that has been discussed or considered?
> 
> The proposed solution is to exit to userspace with a new exit reason, KVM_EXIT_MEMORY_ERROR,
> when the guest makes the hypercall to request conversion[1].  The private fd itself
> will never allow mapping memory into userspace, instead userspace will need to punch
> a hole in the private fd backing store.  The absense of a valid mapping in the private
> fd is how KVM detects that a pfn is "shared" (memslots without a private fd are always
> shared)[2].

Right. I'm still a bit confused about how the VMM is going to get the
shared page mapped in its page-table. Once it has punched a hole into
the private fd, how is it supposed to access the actual physical page
that the guest shared? Is there an assumption somewhere that the VMM
should have this page mapped in via an alias that it can legally access
only once it has punched a hole at the corresponding offset in the
private fd or something along those lines?

> The key point is that KVM never decides to convert between shared and private, it's
> always a userspace decision.  Like normal memslots, where userspace has full control
> over what gfns are a valid, this gives userspace full control over whether a gfn is
> shared or private at any given time.

I'm understanding this as 'the VMM is allowed to punch holes in the
private fd whenever it wants'. Is this correct? What happens if it does
so for a page that a guest hasn't shared back?

> Another important detail is that this approach means the kernel and KVM treat the
> shared backing store and private backing store as independent, albeit related,
> entities.  This is very deliberate as it makes it easier to reason about what is
> and isn't allowed/required.  E.g. the kernel only needs to handle freeing private
> memory, there is no special handling for conversion to shared because no such path
> exists as far as host pfns are concerned.  And userspace doesn't need any new "rules"
> for protecting itself against a malicious guest, e.g. userspace already needs to
> ensure that it has a valid mapping prior to accessing guest memory (or be able to
> handle any resulting signals).  A malicious guest can DoS itself by instructing
> userspace to communicate over memory that is currently mapped private, but there
> are no new novel attack vectors from the host's perspective as coercing the host
> into accessing an invalid mapping after shared=>private conversion is just a variant
> of a use-after-free.

Interesting. I was (maybe incorrectly) assuming that it would be
difficult to handle illegal host accesses w/ TDX. IOW, this would
essentially crash the host. Is this remotely correct or did I get that
wrong?

> One potential conversions that's TBD (at least, I think it is, I haven't read through
> this most recent version) is how to support populating guest private memory with
> non-zero data, e.g. to allow in-place conversion of the initial guest firmware instead
> of having to an extra memcpy().

Right. FWIW, in the pKVM case we should be pretty immune to this I
think. The initial firmware is loaded in guest memory by the hypervisor
itself (the EL2 code in arm64 speak) as the first vCPU starts running.
And that firmware can then use e.g. virtio to load the guest payload and
measure/check it. IOW, we currently don't have expectations regarding
the initial state of guest memory, but it might be handy to have support
for pre-loading the payload in the future (should save a copy as you
said).

> [1] KVM will also exit to userspace with the same info on "implicit" conversions,
>     i.e. if the guest accesses the "wrong" GPA.  Neither SEV-SNP nor TDX mandate
>     explicit conversions in their guest<->host ABIs, so KVM has to support implicit
>     conversions :-/
> 
> [2] Ideally (IMO), KVM would require userspace to completely remove the private memslot,
>     but that's too slow due to use of SRCU in both KVM and userspace (QEMU at least uses
>     SRCU for memslot changes).
