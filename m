Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B380C75B89B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 22:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjGTUUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGTUUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:20:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C95271E
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 13:20:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd69bb4507eso1031178276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689884413; x=1690489213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1/m4T5EZ9UQZdIAs+CFQOUhGGMJn3z6NAlZtvxtssM=;
        b=mbsHztlENnOTDgeCIXRdF8x4x9OfLSlTRQf7EJhk2yHC8ssudjPjJb663muGwwAUde
         HXusCSecX8QAy71He4xwRicW2VAZ7RFVOVmJQZun5eygpfocaFcEhJVdz1DXPqrP14f5
         Q9r/63tqP/iMmto5FytBtXhV7bicbpwNBGhhzc7AVroN6uvn7SvVpiEQCLnIHWcphWhi
         L6PAVpT/JWEQDmjGRRbXmNFkgwEJImoyKV1xDjpLesAAmXECVa9yb/PUNJmSrVHElsLh
         RUk/Cxj/0yokxjf+pISM5EmdcaPLl3odQz7EeG720kJEtO6hviZvCg7ubhY+cpI9tJBr
         NkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689884413; x=1690489213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1/m4T5EZ9UQZdIAs+CFQOUhGGMJn3z6NAlZtvxtssM=;
        b=YsxC9iI0k5WazjFsyo4kqFNOQd7BElJXMNaWvEnrjRxKm53Q5xaqTKqh+x+NDtwYhy
         BYeIODnrDK3ccmL4kWNhI5Ao7GYcRjXhnyizr8EVoU2R/WDnXwHbcQJXkmfKMhHNYgIy
         ydIcsm3pvnmHEpqhbLPNgVa/wCHhyj8mjriBeJvdg9HLQgMQP7DTJq3ySlGpJKvx+ueH
         ivdCU5Xocs/CN+ikZEtUzvbtd4vD/q4TbEypNde7NY/Jpww1qLMl7en5y4x/2JVO84eW
         xrm/a8uyCV9+64IZ/J+LIxyG//ZQW/gmM4GgggvEgmYXNXvbTyOmcOpVTnwg6g3dxuMw
         r6ZQ==
X-Gm-Message-State: ABy/qLYHgtE5jYu4PG4dcAyvgJ6ksh/Dt/EEkifLk8OgHO0rLd56alue
        faCsTf7CJQxCinlGxjIaNtOhJMztzP8=
X-Google-Smtp-Source: APBJJlHJCm6H269xOtL/2AMirqWxt3kOhxlKiB8lLLwF2CbQnv6wXW7fNhFjFSiI4U52DqkXiLsyKn98s/w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:4d08:0:b0:c6c:6122:5b69 with SMTP id
 a8-20020a254d08000000b00c6c61225b69mr236ybb.8.1689884413509; Thu, 20 Jul 2023
 13:20:13 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:20:11 -0700
In-Reply-To: <20230720190211.GF25699@ls.amr.corp.intel.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-9-seanjc@google.com>
 <20230720080912.g56zi5hywazrhnam@yy-desk-7060> <20230720190211.GF25699@ls.amr.corp.intel.com>
Message-ID: <ZLmW+9G6EbKLkOOz@google.com>
Subject: Re: [RFC PATCH v11 08/29] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Yuan Yao <yuan.yao@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023, Isaku Yamahata wrote:
> On Thu, Jul 20, 2023 at 04:09:12PM +0800,
> Yuan Yao <yuan.yao@linux.intel.com> wrote:
> 
> > On Tue, Jul 18, 2023 at 04:44:51PM -0700, Sean Christopherson wrote:
> > > @@ -2301,4 +2305,14 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
> > >  /* Max number of entries allowed for each kvm dirty ring */
> > >  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
> > >
> > > +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> > > +static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
> > > +{
> > > +	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
> > > +}
> > > +
> > > +bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> > > +					 struct kvm_gfn_range *range);
> > 
> > Used but no definition in this patch, it's defined in next patch 09.
> > How about add weak version in this patch and let ARCHs to overide it ?
> 
> It is guarded by CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES.

Yep.  I don't love the ordering, e.g. this patch can't even be compile tested
until later in the series, but I wanted to separate x86 usage from the generic
support code.
