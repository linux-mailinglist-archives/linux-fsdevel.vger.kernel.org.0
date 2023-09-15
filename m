Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A8B7A28F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbjIOVFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 17:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbjIOVFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:05:35 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD53C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 14:05:30 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-5735bb13261so3701511eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694811929; x=1695416729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yleJC+7YBNlUjlYVNZzM9vt9cQFuPW3G+hVjyHJnwaw=;
        b=ogYHCZ2nyrdLNWE91OqecuE80rv024odTbCeKa7WT8GM/View0HLXL2xILl+Fs6nk2
         T7NjFUrAfuO6olCOMtbd8Ik97WXqPabhkIaT84HZzjK44vlEmdKYD/NlTtt85n1uYokM
         6JU2vXeqU9cgAmBieBC0IrXp2bthviZGvvIMD5wZKlGVdRM2ElX6XSsJpDRtCDVTGARU
         qJ7eAMvHsgmnlbjKRUeknfoOZeL2nCrUjMSs0IzGqOytc7nfCzdzkzuJgeBb22sNXHL/
         wNvo9WV6ascGkLS1cTXkzEpyWlcvTlAx5DUq64U3kdziKTqEYhCJ2whNmhvzXt5eph5G
         T5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694811929; x=1695416729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yleJC+7YBNlUjlYVNZzM9vt9cQFuPW3G+hVjyHJnwaw=;
        b=njPadkD37rADHx5hrB9+B0svMEodpvBdZyilZ440hbHQQI6XPFo0WRypuCOKPX4ojo
         IyTUv5k7VhsNjJQNojFWXpZy2XhxkgcVYZFiRbliqOHvlVAnMMe2uW5TUHWIbhhzgGIO
         3NkryPnpOumH+c5WBztZZH0zzjBqW+BhYKmlPkXz9s2jaK1LTXrC04Y4VvjYK3msln/H
         INLJovH6nPJ5eOJcIiEeVh0bekTHEW25TQ+XHuK3bxyiZtt+DlcZLwlU8v+u+ZmyaafT
         pgKpFECzLTRZzzaWLmTtC8m574nZuRfNmED8+Fi7Mkx1jqT+/BQk0L463BT55WstiCmY
         BpCA==
X-Gm-Message-State: AOJu0Yz134z69KY+doY5scJM4EjsWImLGEeGM3csdI+Sgvu6q1ONLdMH
        G7tdnG+KScxm4AFWFyAgg9/TTtVO2ic=
X-Google-Smtp-Source: AGHT+IF9PpTOkzcgimAJrduyF4qwfWt2KP5EbzIhLTMy/s4gm21Ep/5FIgTjRytGlNZlubXZjpDBAQBvLB0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a4a:2c02:0:b0:571:1762:7718 with SMTP id
 o2-20020a4a2c02000000b0057117627718mr908496ooo.1.1694811929595; Fri, 15 Sep
 2023 14:05:29 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:05:27 -0700
In-Reply-To: <d4166c97-6ab3-89a2-eb12-f492f7521f69@intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-2-seanjc@google.com>
 <d4166c97-6ab3-89a2-eb12-f492f7521f69@intel.com>
Message-ID: <ZQTHF3J+6FXwRx98@google.com>
Subject: Re: [RFC PATCH v12 01/33] KVM: Tweak kvm_hva_range and hva_handler_t
 to allow reusing for gfn ranges
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023, Xiaoyao Li wrote:
> On 9/14/2023 9:54 AM, Sean Christopherson wrote:
> > Rework and rename "struct kvm_hva_range" into "kvm_mmu_notifier_range" so
> > that the structure can be used to handle notifications that operate on gfn
> > context, i.e. that aren't tied to a host virtual address.
> > 
> > Practically speaking, this is a nop for 64-bit kernels as the only
> > meaningful change is to store start+end as u64s instead of unsigned longs.
> > 
> > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   virt/kvm/kvm_main.c | 34 +++++++++++++++++++---------------
> >   1 file changed, 19 insertions(+), 15 deletions(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 486800a7024b..0524933856d4 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -541,18 +541,22 @@ static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
> >   	return container_of(mn, struct kvm, mmu_notifier);
> >   }
> > -typedef bool (*hva_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
> > +typedef bool (*gfn_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
> 
> Is it worth mentioning the rename of it as well in changelog?

Meh, I suppose.  At some point, we do have to assume a certain level of code
literacy though :-)
