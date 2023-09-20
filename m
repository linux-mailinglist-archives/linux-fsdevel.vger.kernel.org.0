Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FE47A8E29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 23:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjITVD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 17:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjITVD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:03:57 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDE29E
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 14:03:51 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c448ba292dso1833915ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 14:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695243830; x=1695848630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFTXI1M20f8gmG6BvRAdcxEpoXePrbyr+CokqbvWBWc=;
        b=YBB92SBCF7Hff5sSHvPsWLZsVpMrv+Nl0UIbQv7rB4s5KbvjkoryE7ANGFhAl3ZUOY
         XOz5HSz1JykM+i1Yb2lu7wu5YhqpmGp0qiwqGjag6g21TIuaOTtBANkCbe2wlhf62FxN
         1lak6BOZ+i864pP48UrkEPAxbstc16yg2iUAL3kqaQojWszOZsLaQGyqW7Q17wFRA5pS
         YukXT15ZjEfn2V/sRN4udANdKQS7bHzeb1rCtJKrCEAXpTbsKVowFQcM2dYmMaK7zbY1
         ARgNAbrAoaznbzr/fpH9ZnScVlSvAGQdDwVENeAYFHe1suNMj9gpIDcA1dEq4I4cKDvO
         t3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695243830; x=1695848630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFTXI1M20f8gmG6BvRAdcxEpoXePrbyr+CokqbvWBWc=;
        b=L/pOIACCGHEmncxka7p6tzKA5uSOHL+px5ycnmPmC8I2ZIN6wykXz0UuYLAsSYEDGl
         +OEGx6QYRILzQYw0NspZrnH6OHesDpNYVf79U4P2OxoY1fQ+x7BgPWEvqNI81ZAIggT6
         ioC1s1Jh8aTlAAS6nbmWN3mOm66a/4jhPxJ5Z2vXenHPIaID7QRFpnOH+lIw8KiPou4j
         pHSerl4w/WBGRJzUdYy4JplkqVZ3jb1x3rmM3cFykxK/7f5qXqzXct8UUvpkdibOs18k
         eD3ZL6lTCuJ3Ku0KqCrJvgRb1qcDtz18IL/kG1C+rZKsPlwtBn+FVooj1kVVx8jILvtP
         UXSg==
X-Gm-Message-State: AOJu0YyOimcOa06bYC0jMJ3hByImV3zTDCYpyE/LKkKQHoLDswY8mfOC
        OvhYShFiwtx1oBVFwdZRaDHYYMbn0i0=
X-Google-Smtp-Source: AGHT+IH5QBEwnaGAG6ouJVZQG2FiwG4z7ywKiDhgLSOOF+0VMXfLus6G3HR8pg7XpQjZrIgu3wnPZ1Tf/l8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c407:b0:1c3:411c:9b7c with SMTP id
 k7-20020a170902c40700b001c3411c9b7cmr51568plk.13.1695243830643; Wed, 20 Sep
 2023 14:03:50 -0700 (PDT)
Date:   Wed, 20 Sep 2023 14:03:49 -0700
In-Reply-To: <d66795f8-e524-2912-4b71-92ca4ffe8807@linux.intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-12-seanjc@google.com>
 <d66795f8-e524-2912-4b71-92ca4ffe8807@linux.intel.com>
Message-ID: <ZQteNbPfx6P3r6B8@google.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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
        "Serge E. Hallyn" <serge@hallyn.com>,
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

On Mon, Sep 18, 2023, Binbin Wu wrote:
> 
> 
> On 9/14/2023 9:55 AM, Sean Christopherson wrote:
> > From: Chao Peng <chao.p.peng@linux.intel.com>
> [...]
> > +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> > +/*
> > + * Returns true if _all_ gfns in the range [@start, @end) have attributes
> > + * matching @attrs.
> > + */
> > +bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
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
> IIUIC, xas_find() is inclusive for "end", so here should be "end - 1" ?

Yes, that does appear to be the case.  Inclusive vs. exclusive on gfn ranges has
is the bane of my existence.
