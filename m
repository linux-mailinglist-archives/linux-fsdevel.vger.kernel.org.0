Return-Path: <linux-fsdevel+bounces-1415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4062D7D9FD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706C91C210F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051E3CD01;
	Fri, 27 Oct 2023 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="39QyUmea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1293C698
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:22:32 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B7C1A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:22:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d815354ea7fso1672909276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698430949; x=1699035749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn/2IBJw8IgyOIqoe5CTcghLJbfyq3WPHSyzyGJhcug=;
        b=39QyUmeajrHDHhG5YVcaFoKB+A6LJNfkc21vAg/MSsqP1QRmZ4ijZCI3+Vo7jOGgp9
         c+yWikBszSU2V9+J6D5IEUzSWWvzt1NSYt6COPi+of+l0Fbk7rzi8Jcl00J/ocBHUYsU
         1+qbBpPzIorOGL3r7deSFn3ubuNE+7knU7A5H4qkU1Mr56LYh8EWa7rWyXEhXtv6F8rU
         RgbgtDiz78QZlV4/ux6bhITo+aQD6UJOtSw+liTBPRh/2uHLsFTyJoqMbmqJKmu9ZU+7
         6limj3Pq+1960Knnkm457oH7PtDMaOSzW2TywYUaUujlwQkMQ93T7qZ65YQawMxWnnns
         ijIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698430949; x=1699035749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn/2IBJw8IgyOIqoe5CTcghLJbfyq3WPHSyzyGJhcug=;
        b=Au8BD1nYinqBph1B5qdwyzsgpje3vwt6uOiMwGK//D37GDkBlRGPnsyJRt2c7Un2PO
         mzdU2i02vOi44tyobcYICbnpv71gxUdYjfvD54t/2smPqeYDvRpHssXNnX6JaDNCLfa0
         J2BjzyZuz0HGO4YrkwPEwQWqQ/oSwp2ke5HF368kUxKl4s/GJ6ips7L+rJGGWIZB/nl1
         uJzAQ1R7Bu3BYS210nemRLDSf4GSEN7Y9G2heqGNXRc8B1Jlemuv5CP5jOlfpxBeO6S8
         6KaJ9M5yshEMn5jy8UFJUTnsVS9vFMbrzVjIAECo+Zt8bLyzzA6lOFIVJOqCchVKHH3Z
         Hejw==
X-Gm-Message-State: AOJu0Yzekx7nmY/wIj+5LQV2iMXF+K1KNyCU/woDjtEIeaymik1iWWYW
	OYo3FtAcAOl1K61Sz2Qu6uZydzWK24o=
X-Google-Smtp-Source: AGHT+IE/2A67BLmFvNwLQGxAeqfnMv4JVTEXFJ3uXVKssW9yJHFYWQUNgIG+FyGEOnQbWZWT52otjVeFu0A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1788:b0:da0:c9a5:b529 with SMTP id
 ca8-20020a056902178800b00da0c9a5b529mr57775ybb.12.1698430949628; Fri, 27 Oct
 2023 11:22:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 27 Oct 2023 11:21:44 -0700
In-Reply-To: <20231027182217.3615211-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027182217.3615211-3-seanjc@google.com>
Subject: [PATCH v13 02/35] KVM: Assert that mmu_invalidate_in_progress *never*
 goes negative
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Sean Christopherson <seanjc@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>, 
	David Matlack <dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Maciej Szmigiero <mail@maciej.szmigiero.name>, David Hildenbrand <david@redhat.com>, 
	Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the assertion on the in-progress invalidation count from the primary
MMU's notifier path to KVM's common notification path, i.e. assert that
the count doesn't go negative even when the invalidation is coming from
KVM itself.

Opportunistically convert the assertion to a KVM_BUG_ON(), i.e. kill only
the affected VM, not the entire kernel.  A corrupted count is fatal to the
VM, e.g. the non-zero (negative) count will cause mmu_invalidate_retry()
to block any and all attempts to install new mappings.  But it's far from
guaranteed that an end() without a start() is fatal or even problematic to
anything other than the target VM, e.g. the underlying bug could simply be
a duplicate call to end().  And it's much more likely that a missed
invalidation, i.e. a potential use-after-free, would manifest as no
notification whatsoever, not an end() without a start().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0524933856d4..5a97e6c7d9c2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -833,6 +833,7 @@ void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
 	 * in conjunction with the smp_rmb in mmu_invalidate_retry().
 	 */
 	kvm->mmu_invalidate_in_progress--;
+	KVM_BUG_ON(kvm->mmu_invalidate_in_progress < 0, kvm);
 }
 
 static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
@@ -863,8 +864,6 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 	 */
 	if (wake)
 		rcuwait_wake_up(&kvm->mn_memslots_update_rcuwait);
-
-	BUG_ON(kvm->mmu_invalidate_in_progress < 0);
 }
 
 static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
-- 
2.42.0.820.g83a721a137-goog


