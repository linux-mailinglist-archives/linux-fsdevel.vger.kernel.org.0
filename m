Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF83279F7B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 04:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjINCLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 22:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjINB4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:56:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1866210C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:55:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-592210fe8easo6708137b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656544; x=1695261344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5olfKKfAgOBEIWorNeGA6oMvbpwHV/k+KeYKQRUdq04=;
        b=bdIMT7k5UpwL0z+XvScHcf9jpYN5+dVi5xzFu2O9MWIMM32oAqzM4KN8XykaM16YUY
         YzvZruztiA1/vZf9OVN4agBdyBZdVJTRdZsLki+sc0NJ/iTeGg4HJx7Fz5o4p9z1qrMH
         sNAU5f5GrWFx3jgKckDFayc2lvRg3R08qo7wl+R40CLvXsPK0E9+KoamWo7PO3XnEmjc
         jNgIPGBPFoX5C5cWybiYlObLpUam/IHDObmiBrAQsWahbH1j0lv6H5AmJbhXuP6FVAqQ
         vP/oeOfpaTVLYk9IHWTWHxkne3AuKTv2FkpHSLunQI9BfcDIgV8bYjVSJcTg5zFk3CTb
         0yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656544; x=1695261344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5olfKKfAgOBEIWorNeGA6oMvbpwHV/k+KeYKQRUdq04=;
        b=b/cQsKa0DtEcl/aJOY69y9NfwFh6dhk2xFY68HizlgDMlSLdKvfCgPhgWw4txVOD4o
         PM8dNB0vOmBgy2emFSxNTN3zUv4xKOBQqaZe6I+94bwwDGUDPVqErCqfT1HnAHhDnRi8
         ibdfpS5tbbFbp77tj2JgpR3uzxMG27WesqBdpTSj14jbX4uSD3xcTX08yIQ4IUn1ZlqB
         j2BsnqJMT2A8fGCUrYbqTGzLXZbIcFr9HW2g7l6x3HxpzmOyePM8GlnLZTfcGWES+pDr
         ZYKmA1JV3qfWl8J8n//cxDpVZOjCodCpUw79xWtcBnVntrRQvo+lmBt/jWdoz0S1lSvc
         RbrQ==
X-Gm-Message-State: AOJu0YwR3qs9ZD0lnASh2EOgw4Cow0zUIdWV2ALy5TVVHo18uy8nHdxi
        aiw3ofOQ2Tx/y0m97iHd0P7xyv2NDHA=
X-Google-Smtp-Source: AGHT+IFAWDIKY3pID0CrDZgtjj2bXptPteu0k42w51y6Ps+oH46knUj2OnzhEQTEbd0IbAu5MzXei5K4JBI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:684:b0:d81:8e4d:b681 with SMTP id
 i4-20020a056902068400b00d818e4db681mr15248ybt.12.1694656543919; Wed, 13 Sep
 2023 18:55:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:02 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-5-seanjc@google.com>
Subject: [RFC PATCH v12 04/33] KVM: PPC: Return '1' unconditionally for KVM_CAP_SYNC_MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Advertise that KVM's MMU is synchronized with the primary MMU for all
flavors of PPC KVM support, i.e. advertise that the MMU is synchronized
when CONFIG_KVM_BOOK3S_HV_POSSIBLE=y but the VM is not using hypervisor
mode (a.k.a. PR VMs).  PR VMs, via kvm_unmap_gfn_range_pr(), do the right
thing for mmu_notifier invalidation events, and more tellingly, KVM
returns '1' for KVM_CAP_SYNC_MMU when CONFIG_KVM_BOOK3S_HV_POSSIBLE=n
and CONFIG_KVM_BOOK3S_PR_POSSIBLE=y, i.e. KVM already advertises a
synchronized MMU for PR VMs, just not when CONFIG_KVM_BOOK3S_HV_POSSIBLE=y.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/powerpc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index b0a512ede764..8d3ec483bc2b 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -635,11 +635,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 #if !defined(CONFIG_MMU_NOTIFIER) || !defined(KVM_ARCH_WANT_MMU_NOTIFIER)
 		BUILD_BUG();
 #endif
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-		r = hv_enabled;
-#else
 		r = 1;
-#endif
 		break;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	case KVM_CAP_PPC_HTAB_FD:
-- 
2.42.0.283.g2d96d420d3-goog

