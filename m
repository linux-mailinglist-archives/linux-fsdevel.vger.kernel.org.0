Return-Path: <linux-fsdevel+bounces-1418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7247D9FDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956DF1C2103B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048B3D962;
	Fri, 27 Oct 2023 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="siqQ9m0B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631243C086
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:22:37 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306EE1B6
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:22:36 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc20955634so8186915ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698430955; x=1699035755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JgU06SXMv6nm3bYLetCIh2Atkw0AeiFtLr3TWBcGDvg=;
        b=siqQ9m0B9m40Qs7PaCCnI/qS3fb1gku1RkXCkFjHYwI695lydFEzhsJcEwBrjmwFpF
         IWagKZp3oqCf1sQ0d00aRsezW1on4j+vUKS0GoMckHY5laTg/4r4A8lD67Ox9ovxMl51
         oyDooZIHskjXtEE71IOIYGISQluIafOLvjb2Y3mWT5b7ufKS7Z0VSXpgiiLGchattunq
         SC41iGTcZC/QXcObDgLcvbswqbZYHQAeO9Mb8Oxi2Dk+c0R0u3Q/7dpu8D1Elz9/QUVJ
         s5oUXolbLZekpH2blov4AhJvHwV/6uKGdHfDAnFita7fVdl6IrUW5oZBVn2dVerunUdV
         wLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698430955; x=1699035755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgU06SXMv6nm3bYLetCIh2Atkw0AeiFtLr3TWBcGDvg=;
        b=ki5iBhVInYEM+RKk/rXvYwF3VJt4Umu2x7CDubf7gRNsvblw3DDf2cOxMbIYVnKyHG
         eCuE5Rkm1vnIhS1EHCAMNiIXJuWdMecZYvkuIYMXJH1lA7Hbb5SZDHKdFWSRDSvnH8eq
         blj6KsGXrOuewNA1wl5J0SDPcrmSUkDrm3iR1EtN9kGRSrg85l1emdlBvj6rhnewLyhO
         IurS/sr35BaduL3K6nTAS3lbK/2J6Nl/gPZ+pPfwjJexwtelmCMUTsVgSBwCKyM9VHdx
         upKaOOQYiAQx1ejs0iuVAmHnFCyDsZeRcauhrC+wddVRGwneYetxazpW+eaG2RT8QARE
         vMCg==
X-Gm-Message-State: AOJu0YxLVqfBos/9Sda/2WoxB+BaT8w5WPGTomn77rlfC5md2JMpQIWh
	XAlfLu3njDu6ADYpnmmUO8Pw6TnuSyg=
X-Google-Smtp-Source: AGHT+IGtvUvxtvF0vLnhcz0wuwQy/3Gylfgr5sP9pToido+ZyPcnNi9qskOerQDKma1HuMTn89KXKiciq2s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c144:b0:1cc:281a:8463 with SMTP id
 4-20020a170902c14400b001cc281a8463mr32525plj.7.1698430955693; Fri, 27 Oct
 2023 11:22:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 27 Oct 2023 11:21:47 -0700
In-Reply-To: <20231027182217.3615211-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027182217.3615211-6-seanjc@google.com>
Subject: [PATCH v13 05/35] KVM: PPC: Drop dead code related to KVM_ARCH_WANT_MMU_NOTIFIER
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

Assert that both KVM_ARCH_WANT_MMU_NOTIFIER and CONFIG_MMU_NOTIFIER are
defined when KVM is enabled, and return '1' unconditionally for the
CONFIG_KVM_BOOK3S_HV_POSSIBLE=n path.  All flavors of PPC support for KVM
select MMU_NOTIFIER, and KVM_ARCH_WANT_MMU_NOTIFIER is unconditionally
defined by arch/powerpc/include/asm/kvm_host.h.

Effectively dropping use of KVM_ARCH_WANT_MMU_NOTIFIER will simplify a
future cleanup to turn KVM_ARCH_WANT_MMU_NOTIFIER into a Kconfig, i.e.
will allow combining all of the

  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)

checks into a single

  #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER

without having to worry about PPC's "bare" usage of
KVM_ARCH_WANT_MMU_NOTIFIER.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/powerpc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 7197c8256668..b0a512ede764 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -632,12 +632,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 #endif
 	case KVM_CAP_SYNC_MMU:
+#if !defined(CONFIG_MMU_NOTIFIER) || !defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+		BUILD_BUG();
+#endif
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 		r = hv_enabled;
-#elif defined(KVM_ARCH_WANT_MMU_NOTIFIER)
-		r = 1;
 #else
-		r = 0;
+		r = 1;
 #endif
 		break;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-- 
2.42.0.820.g83a721a137-goog


