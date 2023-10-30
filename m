Return-Path: <linux-fsdevel+bounces-1590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336B57DC24C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 23:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2681C20B61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 22:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25661DA2A;
	Mon, 30 Oct 2023 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVEKXpML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E91D536
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 22:07:34 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA44AE8
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 15:07:32 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso24871825ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698703652; x=1699308452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EkAABuzKmGyzNibmrxwxoleV2c1qCswFjV4kStA9p5Y=;
        b=kVEKXpML+Xnymqdjk1TIs+7FkXy/G1sadkB/VgrZzHoFMEIC5U9Cbi2svdIskMQlp2
         JdcWE3bzzlvB4zldFNiaEwV5b9LGDRGUlatM/AUm9SLVFjS5tUKDbdziWIvm5rkE0KpF
         jslcwgkRtvHIYTWNHlzL9sKt4LD133P8Jc3i6FwWqTlVmpz7CmYgk0ADh2y9mYSe5dFO
         4Htk6JSLnncnyPq4aSokKHxDfdSEL7t7Csi/1NtgeY+cp0u5FajTnSSu23DrgTZ78XVp
         0XaMgLVhEj/MPuYhiA7OzjVCPgs/RRBLh7/s/g74aT3sijqc6TDWioD/cmsPaRSw1ucn
         nVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698703652; x=1699308452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkAABuzKmGyzNibmrxwxoleV2c1qCswFjV4kStA9p5Y=;
        b=O8AgwlGzO1XZLAmGLtD3OS6tOa/+9686ajDr8TAY0mw0oTTjBPLcWb89nFX5GQZIuS
         zt9oPw29cf/dUi8cca5ria+AVpJ90D3J2laaaNcIH+cthPf99GtXQlDwWt+SSLWxwdCb
         gl+boAPv5ClbzbW/Szv+/LphdG7FE5va8RoP3qvit0ygulttr+O96P9NwVN1lVTbx8lD
         xoEHXEyo/IiOCEMSczCi2fxJpA2To/nQ+UnHrW1L+ykLIM0b43IArTcd5YjyKSgL2ItO
         KGm5grmQ2q/GkTJhvxT9gyZDcE6VgiJGtD62KZpP01P3vHR8rcz8OiNO/5RxN2SAP/kJ
         WGSw==
X-Gm-Message-State: AOJu0YxivgtZ5RfnQPJ0P/JpaS3zzTPG/DNhwQEfocRkkS4TKlm2Dwc1
	BsaHu8T8EAktFz/2kfym03Qdqex+QHQ=
X-Google-Smtp-Source: AGHT+IHfmttfYISWufdVkZGI1GGv3oPE0CaVU/9uw2yWegmaBLqLOedbYI1/usu4SKmN8TEK3NCdArCTZyE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ed45:b0:1cc:533e:f52b with SMTP id
 y5-20020a170902ed4500b001cc533ef52bmr49726plb.4.1698703652255; Mon, 30 Oct
 2023 15:07:32 -0700 (PDT)
Date: Mon, 30 Oct 2023 15:07:30 -0700
In-Reply-To: <077cec97-7920-4d20-8bd3-fe07ab8bcc29@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-13-seanjc@google.com>
 <077cec97-7920-4d20-8bd3-fe07ab8bcc29@redhat.com>
Message-ID: <ZUApIvo_gIdsfEEV@google.com>
Subject: Re: [PATCH v13 12/35] KVM: Prepare for handling only shared mappings
 in mmu_notifier events
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Xu Yilun <yilun.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Anish Moorthy <amoorthy@google.com>, David Matlack <dmatlack@google.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Maciej Szmigiero <mail@maciej.szmigiero.name>, David Hildenbrand <david@redhat.com>, 
	Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 30, 2023, Paolo Bonzini wrote:
> On 10/27/23 20:21, Sean Christopherson wrote:
> > @@ -635,6 +635,13 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
> >  			 * the second or later invocation of the handler).
> >  			 */
> >  			gfn_range.arg = range->arg;
> > +
> > +			/*
> > +			 * HVA-based notifications aren't relevant to private
> > +			 * mappings as they don't have a userspace mapping.
> 
> It's confusing who "they" is.  Maybe
> 
> 	 * HVA-based notifications provide a userspace address,
> 	 * and as such are only relevant for shared mappings.

Works for me.

