Return-Path: <linux-fsdevel+bounces-1425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 473B67D9FF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0202E28266C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F143DFE1;
	Fri, 27 Oct 2023 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="08fNJEpx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088193D986
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:23:03 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4361A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:22:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so22562367b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698430969; x=1699035769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MfwjFnr1wNHEBMs743caMc0qlRTo5HMEnN08vNH/OXQ=;
        b=08fNJEpxrOA73DzIS5HsS3tbQeoFbn8458B4ODXRv0n3dgNXe5Vfy/oGRpFYfmqKtW
         yIppLJWj0njbYItciv4j8iAvLTdEOH8yvzQ6atTEBM2ahp7POQ6U5XbuzopLKCRQ30TS
         86Wp0V3usyiUUV2Ma2E3dPuMzO1i/ECz3KMYz67ccChFdL3pvi1iYH3g1Sd2JT0d2/0Q
         dwzO2RhJH32kg8TFp1ViXQIzQj4wrmoEd4ppWA9DPYgekfddHVIEgY9Q7x+/IhsC1k/a
         cUN7cZG4IR+RKd0QYICZbhuha2XqHGRYEKE9K4/KX3RUyIP0UZuIcGe/ovbDWEfEUd8Z
         vPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698430969; x=1699035769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfwjFnr1wNHEBMs743caMc0qlRTo5HMEnN08vNH/OXQ=;
        b=mnXhJMGbyu1DXdVG3gehqwFW3aKBMfgl8MndqmVumK4KC7dJ8sQYY87J//sigXzhM0
         NWELtB+ggua8fIHSiUFcwHhR6/2xcZJkeLqX+67QN0kMw5jJjYYfSStvImjhvw3MqKwm
         ERtw58lWv7EXyyLg0HPkn8O+el8IYbNk1FEj0HAm3IsVTEezIrQnsaHBYjc5TQBGaxg0
         JAhcCxJUbw7M73JJmOzYb05Jeh+vpBZgl7rbQ+UvDDWbI1ixS23mMqdMPkcxtkxrwgG3
         sexadS4OZTt2Tlitmr+KQXHJxuaOz3gKD26Yc8lj0nkxYY7a/6hfP3JKvhr25QrI2r7V
         Ur9Q==
X-Gm-Message-State: AOJu0YzCCbd7vQvI4X1jdgWnM9rrEh01zhLGs6OkmiSsF/qZPFMikPko
	XrLOM1K+tAvPzGY5HPWqkWJhFx9CTnU=
X-Google-Smtp-Source: AGHT+IHtw6A7NuD1zDZw/j7xBoNpID5PTLHCLxD7YeudY/tlgoiYGQdJN9iuOebDV/xY0oQ2kV5qeLUK06Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ca0f:0:b0:59b:e663:23b0 with SMTP id
 m15-20020a0dca0f000000b0059be66323b0mr102868ywd.4.1698430969394; Fri, 27 Oct
 2023 11:22:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 27 Oct 2023 11:21:54 -0700
In-Reply-To: <20231027182217.3615211-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027182217.3615211-13-seanjc@google.com>
Subject: [PATCH v13 12/35] KVM: Prepare for handling only shared mappings in
 mmu_notifier events
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

Add flags to "struct kvm_gfn_range" to let notifier events target only
shared and only private mappings, and write up the existing mmu_notifier
events to be shared-only (private memory is never associated with a
userspace virtual address, i.e. can't be reached via mmu_notifiers).

Add two flags so that KVM can handle the three possibilities (shared,
private, and shared+private) without needing something like a tri-state
enum.

Link: https://lore.kernel.org/all/ZJX0hk+KpQP0KUyB@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 2 ++
 virt/kvm/kvm_main.c      | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 96aa930536b1..89c1a991a3b8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -263,6 +263,8 @@ struct kvm_gfn_range {
 	gfn_t start;
 	gfn_t end;
 	union kvm_mmu_notifier_arg arg;
+	bool only_private;
+	bool only_shared;
 	bool may_block;
 };
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cb9376833c18..302ccb87b4c1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -635,6 +635,13 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
 			 * the second or later invocation of the handler).
 			 */
 			gfn_range.arg = range->arg;
+
+			/*
+			 * HVA-based notifications aren't relevant to private
+			 * mappings as they don't have a userspace mapping.
+			 */
+			gfn_range.only_private = false;
+			gfn_range.only_shared = true;
 			gfn_range.may_block = range->may_block;
 
 			/*
-- 
2.42.0.820.g83a721a137-goog


