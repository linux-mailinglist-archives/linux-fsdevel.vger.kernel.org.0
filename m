Return-Path: <linux-fsdevel+bounces-1435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F57F7DA008
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001781F238D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD53DFE1;
	Fri, 27 Oct 2023 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z0yniC61"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3603D995
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:23:45 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D711BEA
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:23:09 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc20955634so8190845ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698430987; x=1699035787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=o8gdvYQ3/1yqqCN7M6+cUJLwJKILjEFSh0R8bjlKI1I=;
        b=z0yniC61HgtWYnWXIzqHhRWnYFO7dk29Lb+UY/7V0Rm3ANBPFj2TiG89YaE5XGqZyY
         5DU2Q6l9ZA9EUgJyK1ihxL+lyL9eoJjeDV7QZzf1HhhZiOCMroFjvAQzPSBaPxt0cQlv
         JET/xo731zcF3XaINoqOqH4377ypoXdw+VBj2Sz4YjwCerZ8+/hQcGvsEZo3Lo/fMo64
         A/2+oaBOCZUAi27gkEhulNbia65jQyCHeBcy+iY298NQJBZzM60lFCwwkG+9r3OLJpuz
         0wOUyjnGgIKuMxZDvM/Q71msQg+L6ciZWRX4rI2gkhrMEGaukl3ZKPBQfNK9BJwx4H1c
         uEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698430987; x=1699035787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8gdvYQ3/1yqqCN7M6+cUJLwJKILjEFSh0R8bjlKI1I=;
        b=FjDt9S+YK/RQzyI0t8ufCdVUrnR5OZImiX8tJKD0qrJflka++k0zd0M1dTdxIWP1cw
         vNRQKVmPZLt2IgRg/QXDBuTvRddrgbucRM+SDV7oYd2MjuaqPO+xcpfo7lMPivVRnsrt
         SRqckKb7TJ0wJHr52xQHec2S4ougyjVdikcc7GSYYp9q5fWZ+8Lkdcyxdy/Mirfe8rx7
         9brUi0bJJCVNMS5zT4BO40X0kENfwqXJpVosEKyigCbiYp0aV3+uqzcaVHQo18WI3HWb
         FP0G4OcR38AuPbfOgEg71UJKH/mBEXqrB+DR+ydFWSjnGsjyCzKuvxSO6xEFXS+YkuiR
         QkGQ==
X-Gm-Message-State: AOJu0Yw4/PrmEMK7UTn54u3Z1Gx5WG0UoY3ws0AqKelnrOY/Lw72mx4A
	mdoPc6talNZJ2nAfsvPEXn4lHweE10o=
X-Google-Smtp-Source: AGHT+IGxPKYh61YDaE4Ab16I5616FjNw5G/WLIOxqZ93NjDEP07jn0icTkqJBzjVXPbdr7XzvwkO91qMX/M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c144:b0:1cc:281a:8463 with SMTP id
 4-20020a170902c14400b001cc281a8463mr32544plj.7.1698430987435; Fri, 27 Oct
 2023 11:23:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 27 Oct 2023 11:22:03 -0700
In-Reply-To: <20231027182217.3615211-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027182217.3615211-22-seanjc@google.com>
Subject: [PATCH v13 21/35] KVM: Drop superfluous __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
 macro
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

Drop __KVM_VCPU_MULTIPLE_ADDRESS_SPACE and instead check the value of
KVM_ADDRESS_SPACE_NUM.

No functional change intended.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 include/linux/kvm_host.h        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8d60e4745e8b..6702f795c862 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2124,7 +2124,6 @@ enum {
 #define HF_SMM_MASK		(1 << 1)
 #define HF_SMM_INSIDE_NMI_MASK	(1 << 2)
 
-# define __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
 # define KVM_ADDRESS_SPACE_NUM 2
 # define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e3223cafd7db..c3cfe08b1300 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -692,7 +692,7 @@ bool kvm_arch_irqchip_in_kernel(struct kvm *kvm);
 #define KVM_MEM_SLOTS_NUM SHRT_MAX
 #define KVM_USER_MEM_SLOTS (KVM_MEM_SLOTS_NUM - KVM_INTERNAL_MEM_SLOTS)
 
-#ifndef __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
+#if KVM_ADDRESS_SPACE_NUM == 1
 static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 {
 	return 0;
-- 
2.42.0.820.g83a721a137-goog


