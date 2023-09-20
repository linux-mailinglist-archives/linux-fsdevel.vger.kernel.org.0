Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CA97A8E17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 23:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjITVAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 17:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjITVAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:00:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E126ABB
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 14:00:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d818e01823aso422657276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695243624; x=1695848424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WD85YU6GCdPtOsLZeVlIeZZfzAYdtoOH/7wu6gyWXNI=;
        b=lrXR4KDKyB3CuUyGP5uNfXTfoHTjrrZkUVpu9kQNuYv9InUBqUeB4fMdB30349PPIZ
         RcGYV8CUadyrYi4ihZfTHpQg/09qpPl+c/zYxq0o2P7dwkfgXkXcp+bq3MVEF+9duUBe
         HTtCh9+ypTXfAcyFaAzJk68f4w++iv6tmGozumlieWuG+llNlw0IlHzHC0WhvmQeQ47D
         BIPb11gg7udeYiklPqgWMrsDyd383pwOvV8mQ+zScwuU8lJXO0Vahq5kKfJ4f6dThPzb
         EXaItMpjNVLeAY+6Kq+gMt7n0juNGBqQvhqE4dZEpjqEgFDXknQSWJecxRAUASzTRNFm
         LQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695243624; x=1695848424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WD85YU6GCdPtOsLZeVlIeZZfzAYdtoOH/7wu6gyWXNI=;
        b=ZEBq49B/HfAV7el0P3ks63DHF+ux93XNUo/DO39NPfVKAtH9sv7cvFgEEkm2oldvFe
         zO6ec2tmISM0tVviPpv5H8yQsAWzlD/asSCZl4Jvjc9Fpe4k9cjCddsJIeNG/yl61jPa
         P+PUcFfs3Li85Fd9JJiELdwcIqwQMKWzqamU+DqE12rOFFTcV8mOm/HJkHBorFEQH9mx
         onV+16o2boTTsEtw7JlhLaTU/NvUhk3BPZH/dvuHOYsubGSrI8tNw0sOUtp50Iw1+klB
         SnRdqVLNPyRR+/yd6zOwysSNArbnYeoiZHBR1BDulktnrK+CGGReso3ey/KgV0l0zjHJ
         xP0w==
X-Gm-Message-State: AOJu0YyS5zymtd7j47/O2uObum7OYkN1xPmIQ/Eb4lsY5fv5K1pNO5pY
        YmoKP2yjhjyzdAu/K05HXDqvE1ZgBmA=
X-Google-Smtp-Source: AGHT+IE6bowhyf6hyHthYBPyW6IZfmwFxVZA3ErkF6QZibGvin1ESoG81Vf7MPhR8G5wDRxCxsmQT8EV7w4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:496:0:b0:d7f:2cb6:7d88 with SMTP id
 144-20020a250496000000b00d7f2cb67d88mr58003ybe.13.1695243624102; Wed, 20 Sep
 2023 14:00:24 -0700 (PDT)
Date:   Wed, 20 Sep 2023 14:00:22 -0700
In-Reply-To: <ZQP6ZqXH81V24Lj/@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-12-seanjc@google.com>
 <ZQP6ZqXH81V24Lj/@yzhao56-desk.sh.intel.com>
Message-ID: <ZQtdZmJ3SekURjiQ@google.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
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

On Fri, Sep 15, 2023, Yan Zhao wrote:
> On Wed, Sep 13, 2023 at 06:55:09PM -0700, Sean Christopherson wrote:
> > From: Chao Peng <chao.p.peng@linux.intel.com>
> > 
> > In confidential computing usages, whether a page is private or shared is
> > necessary information for KVM to perform operations like page fault
> > handling, page zapping etc. There are other potential use cases for
> > per-page memory attributes, e.g. to make memory read-only (or no-exec,
> > or exec-only, etc.) without having to modify memslots.
> > 
> ...
> >> +bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> > +				     unsigned long attrs)
> > +{
> > +	XA_STATE(xas, &kvm->mem_attr_array, start);
> > +	unsigned long index;
> > +	bool has_attrs;
> > +	void *entry;
> > +
> > +	rcu_read_lock();
> > +
> > +	if (!attrs) {
> > +		has_attrs = !xas_find(&xas, end);
> > +		goto out;
> > +	}
> > +
> > +	has_attrs = true;
> > +	for (index = start; index < end; index++) {
> > +		do {
> > +			entry = xas_next(&xas);
> > +		} while (xas_retry(&xas, entry));
> > +
> > +		if (xas.xa_index != index || xa_to_value(entry) != attrs) {
> Should "xa_to_value(entry) != attrs" be "!(xa_to_value(entry) & attrs)" ?

No, the exact comparsion is deliberate.  The intent of the API is to determine
if the entire range already has the desired attributes, not if there is overlap
between the two.

E.g. if/when RWX attributes are supported, the exact comparison is needed to
handle a RW => R conversion.

> > +			has_attrs = false;
> > +			break;
> > +		}
> > +	}
> > +
> > +out:
> > +	rcu_read_unlock();
> > +	return has_attrs;
> > +}
> > +
> ...
> > +/* Set @attributes for the gfn range [@start, @end). */
> > +static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> > +				     unsigned long attributes)
> > +{
> > +	struct kvm_mmu_notifier_range pre_set_range = {
> > +		.start = start,
> > +		.end = end,
> > +		.handler = kvm_arch_pre_set_memory_attributes,
> > +		.on_lock = kvm_mmu_invalidate_begin,
> > +		.flush_on_ret = true,
> > +		.may_block = true,
> > +	};
> > +	struct kvm_mmu_notifier_range post_set_range = {
> > +		.start = start,
> > +		.end = end,
> > +		.arg.attributes = attributes,
> > +		.handler = kvm_arch_post_set_memory_attributes,
> > +		.on_lock = kvm_mmu_invalidate_end,
> > +		.may_block = true,
> > +	};
> > +	unsigned long i;
> > +	void *entry;
> > +	int r = 0;
> > +
> > +	entry = attributes ? xa_mk_value(attributes) : NULL;
> Also here, do we need to get existing attributes of a GFN first ?

No?  @entry is the new value that will be set for all entries.  This line doesn't
touch the xarray in any way.  Maybe I'm just not understanding your question.
