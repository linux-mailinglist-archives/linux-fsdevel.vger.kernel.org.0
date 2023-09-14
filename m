Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCCD7A0722
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 16:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbjINOUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 10:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbjINOUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:20:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A3EE3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 07:19:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81a47e12b5so557175276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694701199; x=1695305999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OinN3M2z4I/Qg8aCda0iI1MRdyz332KlEPPYu5muKwI=;
        b=xr88NZ3hWTH3lnvGOdBo9NgKqtBG+RfRf+Ma5OOyyYFnq+jFzL65M+V4WoaB9eRMHm
         971zh2UCBLYdP76uV+Mq30FSgo6lprEyIAHWM6SBOSR9aKHFIc5lP5hALT7lI7DW6hc3
         2tZv6v0YmnnxQkLA7ALzjmjCaSIA/hUFh0usopy9109tuTlYRCtAakmcXQ/bUatDDHbU
         h5CBK2/vAkKySfz1KsqCjlBwoLMQf8sHXlk0K2SGK3ckc7R6E0h0vvWF8riWY0TWrINA
         Zq48Rcr1pRGc9ZQz2lqK1ZZMhdG35Thg67A8WQXciGYHbeYiyMYi5tFD6yK2xNXXqIYv
         i2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694701199; x=1695305999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OinN3M2z4I/Qg8aCda0iI1MRdyz332KlEPPYu5muKwI=;
        b=TjSp79qZ8dAupJSHEA9huXkeq2df8VR1Oi2wvGCeNCR5z5shyBVZ1yDTpANXYWzaHp
         9xX5Nm5utEXD6Vy2JKnLksFQ6ztW80uVQ/Ks6aj8VlK6ekyawMp5YxHLegRaxqvrf+4g
         yez74xT1bdwd1FjIYkmAaIomIzKzoIAxO4tXubvrDNmp+EWzAvFLc0EzCbendAdHljqo
         wKtscvWVqU2PYUzdNTqRgm006++jIgsk6kK7GE1fsfoh6MNWPmoQMnpwYkcaZ9NxFfvP
         VM+A/6duACBelQ7i4cLNoDrKL1nqhGXlm3vqUmJSQo0nlkP8A1H5NVT8rqiQWX4GOA5N
         hIEQ==
X-Gm-Message-State: AOJu0YyEN0NdiI/EqoP1EZJYy70o1C/QrLB4nhqVO5WCD360pnxolo9c
        HTWc8h/dsNamFWyOsArRnlzayID9m3k=
X-Google-Smtp-Source: AGHT+IEn69IOl2rxglDVCjXW4KTdScyqCw6tLi48MQpyb+nW1MjRKbjq1lfqPgEextp+IedkDxkiKrdOCXU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:e6c4:0:b0:d78:f45:d7bd with SMTP id
 d187-20020a25e6c4000000b00d780f45d7bdmr129688ybh.4.1694701199053; Thu, 14 Sep
 2023 07:19:59 -0700 (PDT)
Date:   Thu, 14 Sep 2023 07:19:57 -0700
In-Reply-To: <54d3e6bf-d374-caa5-0920-bb2fe3b7595c@linux.intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-3-seanjc@google.com>
 <54d3e6bf-d374-caa5-0920-bb2fe3b7595c@linux.intel.com>
Message-ID: <ZQMWjbt/SzKvag2K@google.com>
Subject: Re: [RFC PATCH v12 02/33] KVM: Use gfn instead of hva for mmu_notifier_retry
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023, Binbin Wu wrote:
> 
> On 9/14/2023 9:55 AM, Sean Christopherson wrote:
> > +void kvm_mmu_invalidate_end(struct kvm *kvm)
> >   {
> >   	/*
> >   	 * This sequence increase will notify the kvm page fault that
> > @@ -833,6 +848,13 @@ void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
> >   	 * in conjunction with the smp_rmb in mmu_invalidate_retry().
> >   	 */
> >   	kvm->mmu_invalidate_in_progress--;
> > +
> > +	/*
> > +	 * Assert that at least one range must be added between start() and
> > +	 * end().  Not adding a range isn't fatal, but it is a KVM bug.
> > +	 */
> > +	WARN_ON_ONCE(kvm->mmu_invalidate_in_progress &&
> > +		     kvm->mmu_invalidate_range_start == INVALID_GPA);
> Should the check happen before the decrease of kvm->mmu_invalidate_in_progress?
> Otherwise, KVM calls kvm_mmu_invalidate_begin(), then kvm_mmu_invalidate_end()
> the check will not take effect.

Indeed.  I'm pretty sure I added this code, not sure what I was thinking.  There's
no reason to check mmu_invalidate_in_progress, it's not like KVM allows
mmu_invalidate_in_progress to go negative.  The comment is also a bit funky.  I'll
post a fixup patch to make it look like this (assuming I'm not forgetting a subtle
reason for guarding the check with the in-progress flag):

	/*
	 * Assert that at least one range was added between start() and end().
	 * Not adding a range isn't fatal, but it is a KVM bug.
	 */
	WARN_ON_ONCE(kvm->mmu_invalidate_range_start == INVALID_GPA);

Regarding kvm->mmu_invalidate_in_progress, this would be a good opportunity to
move the BUG_ON() into the common end(), e.g. as is, an end() without a start()
from something other than the generic mmu_notifier would go unnoticed.  And I
_think_ we can replace the BUG_ON() with a KVM_BUG_ON() without putting the
kernel at risk.  E.g.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dd948276e5d6..54480655bcce 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -870,6 +870,7 @@ void kvm_mmu_invalidate_end(struct kvm *kvm)
         * in conjunction with the smp_rmb in mmu_invalidate_retry().
         */
        kvm->mmu_invalidate_in_progress--;
+       KVM_BUG_ON(kvm->mmu_invalidate_in_progress < 0, kvm);
 
        /*
         * Assert that at least one range was added between start() and end().
@@ -905,8 +906,6 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
         */
        if (wake)
                rcuwait_wake_up(&kvm->mn_memslots_update_rcuwait);
-
-       BUG_ON(kvm->mmu_invalidate_in_progress < 0);
 }
 
 static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,

