Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8BC709F07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 20:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjESSXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 14:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESSX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 14:23:28 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81FB139
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 11:23:24 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64d1c53cad8so2538424b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684520604; x=1687112604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLB02Z/Vwsol/Ye6PM6jgDdfosuGHdGXe49pn4jVFGs=;
        b=ITz9fDEYRz6uJ1+nRWO7vsSi14em+HdSJidcWgxJ4Wt6DeOJu7xDarNLoGHPPmOBJm
         513df8JS3NzUdZBK5GSwxSAE1obesd28XWXoOz2iBbvdy2ADgD8Q7q4etCMKIPinEZf9
         82KenOrwjvv/KK8vs+qKxwowe4qePsP8+TuW1ty9rOYtzfzi/ynfD476K7Sa4jcxQ34p
         HkwfUr8RcwOMfxti367AckaqXDd3aDIN65dnmKhBIIZmfTcWPib/CZQFAhBLIgn2eTM2
         VcgA71nqkKuEZwM79FEKmyy8iW+KFC3fLH2DABkTHNX+7IlmO+RnTTQJhuLLoZh1rgpR
         H95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684520604; x=1687112604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLB02Z/Vwsol/Ye6PM6jgDdfosuGHdGXe49pn4jVFGs=;
        b=aJJW8SjidoiJMDgEnC2axnT3Kb6eys8VscYaMxzdkNz9a/jKJ/kqfs2ff5MbeEpGfj
         8eyz5d1k6W33MeQIZMrWhyl51DQhbUdUPfSh7ZS/U5osI+ap7o3l+lxwJyZ4TFbi2/DU
         TtANGw7w7UOHbodSKmI1vNL829XucU6mNdGICVP2IQS2Tsthf/re7kJrbdQxd/wCUeI4
         0FHlQ0NdrkCpTlHR6KDxr7qY2vJ/i3NEoQ5xB+TmfLfQuPfB9Hxq3WThcmA/og2Lm+cX
         yOcZTqYq0quqqQJUDvhI2IMorVjC6erPJDoxiYJa7j8uaFBx+MLieV+6TVLJdHMu1HWB
         2clA==
X-Gm-Message-State: AC+VfDyg59ll3eP7WMR2jVxvJWj6TIfyjvXVeAM6JBM2SWvtw3MJfbZH
        eXG/4t3BAjtiigIqGwsczccf13AiZeI=
X-Google-Smtp-Source: ACHHUZ419BZyva9XfjdHZezzlVRJTJng9P1rwHIVB2iZ3Kvn5yX6WZYPLwlGGRjyBM2xKvPRPQpWmzT2ch0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:88c4:0:b0:643:4595:64c7 with SMTP id
 k4-20020aa788c4000000b00643459564c7mr1352262pff.4.1684520604384; Fri, 19 May
 2023 11:23:24 -0700 (PDT)
Date:   Fri, 19 May 2023 11:23:23 -0700
In-Reply-To: <CSQFE7I30W27.2TPDIHOTZNRIZ@dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com>
Mime-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com> <CSQFE7I30W27.2TPDIHOTZNRIZ@dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com>
Message-ID: <ZGe+m+uFzpiW7wlr@google.com>
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, graf@amazon.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        wei.w.wang@intel.com, anelkz@amazon.de
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023, Nicolas Saenz Julienne wrote:
> Hi,
> 
> On Fri Dec 2, 2022 at 6:13 AM UTC, Chao Peng wrote:
> 
> [...]
> > +The user sets the per-page memory attributes to a guest memory range indicated
> > +by address/size, and in return KVM adjusts address and size to reflect the
> > +actual pages of the memory range have been successfully set to the attributes.
> > +If the call returns 0, "address" is updated to the last successful address + 1
> > +and "size" is updated to the remaining address size that has not been set
> > +successfully. The user should check the return value as well as the size to
> > +decide if the operation succeeded for the whole range or not. The user may want
> > +to retry the operation with the returned address/size if the previous range was
> > +partially successful.
> > +
> > +Both address and size should be page aligned and the supported attributes can be
> > +retrieved with KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES.
> > +
> > +The "flags" field may be used for future extensions and should be set to 0s.
> 
> We have been looking into adding support for the Hyper-V VSM extensions
> which Windows uses to implement Credential Guard. This interface seems
> like a good fit for one of its underlying features. I just wanted to
> share a bit about it, and see if we can expand it to fit this use-case.
> Note that this was already briefly discussed between Sean and Alex some
> time ago[1].
> 
> VSM introduces isolated guest execution contexts called Virtual Trust
> Levels (VTL) [2]. Each VTL has its own memory access protections,
> virtual processors states, interrupt controllers and overlay pages. VTLs
> are hierarchical and might enforce memory protections on less privileged
> VTLs. Memory protections are enforced on a per-GPA granularity.
> 
> The list of possible protections is:
> - No access -- This needs a new memory attribute, I think.

No, if KVM provides three bits for READ, WRITE, and EXECUTE, then userspace can
get all the possible combinations.  E.g. this is RWX=000b

> - Read-only, no execute

RWX=100b (using my completely arbitrary ordering of RWX bits :-) )

> - Read-only, execute

RWX=101b

> - Read/write, no execute

RWX=110b

> - Read/write, execute

RWX=111b

> We implemented this in the past by using a separate address space per
> VTL and updating memory regions on protection changes. But having to
> update the memory slot layout for every permission change scales poorly,
> especially as we have to perform 100.000s of these operations at boot
> (see [1] for a little more context).
> 
> I believe the biggest barrier for us to use memory attributes is not
> having the ability to target specific address spaces, or to the very
> least having some mechanism to maintain multiple independent layers of
> attributes.

Can you elaborate on "specific address spaces"?  In KVM, that usually means SMM,
but the VTL comment above makes me think you're talking about something entirely
different.  E.g. can you provide a brief summary of the requirements/expectations?

> Also sorry for not posting our VSM patches. They are not ready for
> upstream review yet, but we're working on it.
> 
> Nicolas
> 
> [1] https://patchwork.kernel.org/comment/25054908/
> [2] See Chapter 15 of Microsoft's 'Hypervisor Top Level Functional Specification':
>     https://raw.githubusercontent.com/MicrosoftDocs/Virtualization-Documentation/main/tlfs/Hypervisor%20Top%20Level%20Functional%20Specification%20v6.0b.pdf
