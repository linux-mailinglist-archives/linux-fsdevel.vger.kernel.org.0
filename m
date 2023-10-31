Return-Path: <linux-fsdevel+bounces-1653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE277DD26A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 17:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80382814FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D208D1E51E;
	Tue, 31 Oct 2023 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xq/K6WUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016511D522
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 16:43:42 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C207C133
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 09:43:40 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso5174746b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698770620; x=1699375420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUWzNpZFu6ZH+LPCMipXBlnOZ2iMu0xo6DdlSVTTSCM=;
        b=xq/K6WUJT8CqcSv142B1xusTthevqQt6VrjvnoB/CJrAeL2QYkp8xFzyY1QhKEn9o0
         jB3q0hvnxRPMa+81oNjJCGfntadyK2H4PI+20Z771RVjlZek59qEx55TFuo8S92jI8J0
         niwZwMOcRuVyHckT0B/XE0BqEiG+FWYXQN1MCYjyAfxwXktdeg2mDnBGmmq5EV62Fxfn
         /+y+SwE6dFPmC101DRBtthXKgkcejhuLrjUdnYNYJ9lwkSBq+WZyv95SWWu5SNrNxsGj
         kMDia302Dw1tdeq17HmMWj51BKtyGrY5Ek3gshWqT4HRovXRrC7UZaEdiCPodhEMOo1w
         hfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698770620; x=1699375420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUWzNpZFu6ZH+LPCMipXBlnOZ2iMu0xo6DdlSVTTSCM=;
        b=WUZlW4ndovpsy4wm04YCOo6peJiFyB2PkuSNYQiaK06A2DR/ybEH9BR12UNEthS1Sq
         4s4BL/dmb2z0URpuqptblqp0kXRTrvcPtiuun30DtUehpwfdLRjXUcCTy4GDrMIDU+ZF
         HU+VCettyEZRoVkTA9zPoEZ13yiZzug9S6Q4QWiie9ItJaQvOY0OSedkJREihBbAzeWb
         t53LTaDSIbvPJCHHz3vGVUVmv7TpEEHY6L6XwO5QV2qjz8mYf/mGirGzogAU9cIKgWnl
         xi3ie1K0T0sSDM3o0Nb7xzRYtcmeLikF1K1PVu5f30HUErMlQcj6PNn0O3KxjRGlETQF
         Cfng==
X-Gm-Message-State: AOJu0YxlGhhB7FVuHNzm0tM4/uG/0s8vTJFbFyr2IztuWUAv10Y9BnhI
	rFl3ntXO+6wJ2dAaRPYCmm0wng==
X-Google-Smtp-Source: AGHT+IEij7+ydhlYjhr1xlKLUtNUJw25BFH2l+RQ8zeBA7dBnKRXxZXchV1bLlBIgwVsc3GuzIJ3dQ==
X-Received: by 2002:a05:6a20:a10b:b0:15d:7e2a:cc77 with SMTP id q11-20020a056a20a10b00b0015d7e2acc77mr12395968pzk.48.1698770620059;
        Tue, 31 Oct 2023 09:43:40 -0700 (PDT)
Received: from google.com (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with ESMTPSA id fb17-20020a056a002d9100b006b1e8f17b85sm1451493pfb.201.2023.10.31.09.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 09:43:39 -0700 (PDT)
Date: Tue, 31 Oct 2023 09:43:32 -0700
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Anish Moorthy <amoorthy@google.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Vishal Annapurve <vannapurve@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Maciej Szmigiero <mail@maciej.szmigiero.name>,
	David Hildenbrand <david@redhat.com>,
	Quentin Perret <qperret@google.com>,
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v13 13/35] KVM: Introduce per-page memory attributes
Message-ID: <ZUEutAmPcVLHXlQc@google.com>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-14-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027182217.3615211-14-seanjc@google.com>

On 2023-10-27 11:21 AM, Sean Christopherson wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 89c1a991a3b8..df573229651b 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -808,6 +809,9 @@ struct kvm {
>  
>  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>  	struct notifier_block pm_notifier;
> +#endif
> +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> +	struct xarray mem_attr_array;

Please document how access to mem_attr_array is synchronized. If I'm
reading the code correctly I think it's...

  /* Protected by slots_locks (for writes) and RCU (for reads) */

