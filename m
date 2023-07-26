Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65662764068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGZUW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 16:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGZUW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:22:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F4C270B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 13:22:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1ebc896bd7so142433276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690402944; x=1691007744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wk8YN2z9DygnTN7wIkQ/drKhQeRLfAOWaFSkpwIJ9VA=;
        b=eM8gatpIFAPsVcHsvCyPq5hyC8MsN3TVlS3mNniSEUN+A8XGjxiS8F6dC4aFmL513/
         OKqKBd4JNqQZqMKS0xCiGe+t5AXNUTDm2VuHrYqk4zFosWdPFjPIB6URfw5vd93IMKdx
         lKXXLluLhbwl+YjfsuqRPKzKU2+mG/aerZ1RHkgGlaQ2XngSQ4QWGzUzw8Bk02VhX6BY
         iemdbo75Y0mm9KaGC6Z479jAT6buL5FMFb75fU2ROzDvErIFsnjLxci0m6st5PC1U67q
         6FdRgc7HGPP7DF/FaK/f0cWfoJ+ZjAfbcmtP5i/qUasNowuJ11SfJCK8qdGxq6HB8Y5C
         RWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690402944; x=1691007744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wk8YN2z9DygnTN7wIkQ/drKhQeRLfAOWaFSkpwIJ9VA=;
        b=MZiwz6fXIskO+icXAOs19UnMej/SvkHmFnLMfC8yyp81SDJxenDERg9eXQo8/LCq4E
         7sVHp72DLQ9rinJHOZ3iskz1vEsPBXbNLZBOevRX6GPJXQJ498ZAT7v18KBF35kkh4rC
         /zlXipp1o2SvY7H1WVs/eBsZ5kuWgZIU5uIZH1Rj/SCJMRXLryKGG/B30nZ8C7mk8njl
         /DF7mkPN+xVpu4VScrkxMdyGbsBJGjA7FU3sGrFVQWz+ya5X+1yCxkXmwieyjpypiGwj
         p54vBdiWROsBHz3tMc0NE1KpKs5GOdEvH/q63fTPNYEITTf9zoEZ8KdL5ymJCKD0VYaq
         GMbA==
X-Gm-Message-State: ABy/qLbWtV1kPv9lV+OHKSZxTcifBMjVthGSsyQsqsZrVY4gvZUN0Kk8
        tD6OtZlsLdMoVYh9VxFZA8kkxxlkYbk=
X-Google-Smtp-Source: APBJJlHa4e7bNU/FXY+wuV4M+6WYSA4uQsVmjVu+paqFG49PZpexPl+XQpMgzwVCSNNiruIZErv3dNdZQXc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:cf48:0:b0:d06:1a77:7d2 with SMTP id
 f69-20020a25cf48000000b00d061a7707d2mr18632ybg.13.1690402944082; Wed, 26 Jul
 2023 13:22:24 -0700 (PDT)
Date:   Wed, 26 Jul 2023 13:22:22 -0700
In-Reply-To: <711f74d6-fe15-6bd4-a9b9-c4f178d95bf3@redhat.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-2-seanjc@google.com>
 <711f74d6-fe15-6bd4-a9b9-c4f178d95bf3@redhat.com>
Message-ID: <ZMGAfvzEkVphWPdZ@google.com>
Subject: Re: [RFC PATCH v11 01/29] KVM: Wrap kvm_gfn_range.pte in a per-action union
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>,
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
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023, Paolo Bonzini wrote:
> On 7/19/23 01:44, Sean Christopherson wrote:
> > +	BUILD_BUG_ON(sizeof(gfn_range.arg) != sizeof(gfn_range.arg.raw));
> > +	BUILD_BUG_ON(sizeof(range->arg) != sizeof(range->arg.raw));
> 
> I think these should be static assertions near the definition of the
> structs.  However another possibility is to remove 'raw' and just assign the
> whole union.

Duh, and use a named union.  I think when I first proposed this I forgot that
a single value would be passed between kvm_hva_range *and* kvm_gfn_range, and so
created an anonymous union without thinking about the impliciations.

A named union is _much_ cleaner.  I'll post a complete version of the below
snippet as a standalone non-RFC patch.

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9d3ac7720da9..9125d0ab642d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -256,11 +256,15 @@ int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
 
 #ifdef KVM_ARCH_WANT_MMU_NOTIFIER
+union kvm_mmu_notifier_arg {
+       pte_t pte;
+};
+
 struct kvm_gfn_range {
        struct kvm_memory_slot *slot;
        gfn_t start;
        gfn_t end;
-       pte_t pte;
+       union kvm_mmu_notifier_arg arg;
        bool may_block;
 };
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dfbaafbe3a00..f84ef9399aee 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -526,7 +526,7 @@ typedef void (*on_unlock_fn_t)(struct kvm *kvm);
 struct kvm_hva_range {
        unsigned long start;
        unsigned long end;
-       pte_t pte;
+       union kvm_mmu_notifier_arg arg;
        hva_handler_t handler;
        on_lock_fn_t on_lock;
        on_unlock_fn_t on_unlock;
@@ -547,6 +547,8 @@ static void kvm_null_fn(void)
 }
 #define IS_KVM_NULL_FN(fn) ((fn) == (void *)kvm_null_fn)
 
+static const union kvm_mmu_notifier_arg KVM_NO_ARG;
+
 /* Iterate over each memslot intersecting [start, last] (inclusive) range */
 #define kvm_for_each_memslot_in_hva_range(node, slots, start, last)         \
        for (node = interval_tree_iter_first(&slots->hva_tree, start, last); \
@@ -591,7 +593,7 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
                         * bother making these conditional (to avoid writes on
                         * the second or later invocation of the handler).
                         */
-                       gfn_range.pte = range->pte;
+                       gfn_range.arg = range->arg;
                        gfn_range.may_block = range->may_block;
 
                        /*

