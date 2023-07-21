Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD34875D067
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 19:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGURNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 13:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGURNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:13:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91281710
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 10:13:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583a4015791so5040987b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689959628; x=1690564428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7shZuEDiffXRYK22UXnQcffVUND6wfTW4U7DmHj+BWc=;
        b=saEUf4445sfHkPWRX975heL8zENfXcs3PgCyCgvEVdQjEpNK/pp+iAjdHt4YEb3A4E
         Wx6AMp1fx4AxdUC7quE/wuY8PzajpllFI1PSVxa0GJ6TCvZZ95BwZYWsRgoM01BQ4SqE
         g1i1UMNIUCRiN6vVjQF+QtV7pxLVFxnr+vtjGFTshuCRS/R0Np16E0/qf+bH5mnx7XFz
         ZsljdMjRbBLWTIazxQedjqyAevMpWeXTTd8MiT3v+VX/sBebfo66Po7WIiS0jw2kNrZS
         H5psY9S7R0h0zicR7miAPapKCtbYppPvDwh7bNN96b+Zux6kO9omgHgr2n7bbHvjHh23
         55GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689959628; x=1690564428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7shZuEDiffXRYK22UXnQcffVUND6wfTW4U7DmHj+BWc=;
        b=GqETKmGJ8FStZf7MrJQIjnY00+0BB/h3E9hvHiDnkDlQwj5k34UAVsYy/35ddWcE3y
         M2Z6IRlONBMH3F7FabpR0f5iSJ+MunTuYXwRqBJmPGOdIe0gctS3gNKoyLhSavNoVWwl
         gXr5+YZi03XCUpiP3YzSf2bgi4fwuCVVGOmowMCjW+l7uJinzziufyR9NP7u1qZG9L3C
         sTk0N8XfSRRzOcFnMwjNjO4RMdZpd3WcAir2rUXA5qDvMZ/zr2fOHA32t1hWIb+B948H
         YE2Bg0RnS+HPQIU6PEZjhfkkhMZvuHhrjONojuD2uw95JVkaiRyolN+ao+N4t6CI5Deh
         9leA==
X-Gm-Message-State: ABy/qLZs2cUP9ud17zsAsDaSPNS0VFXeuZ7XOzAznue/HOv0IAeQ8WDV
        T9J51I3/WVJcMf4AlJ7M00N8eWm+C2k=
X-Google-Smtp-Source: APBJJlHTu6oxQip7Fs57WKX81frcXYslN0cZxNmgdAvx9eWDlCTFu1+cjXODNvw8IvlIlsVUOd7h6YXth7Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:a28f:0:b0:c6e:fe1a:3657 with SMTP id
 c15-20020a25a28f000000b00c6efe1a3657mr16139ybi.3.1689959627795; Fri, 21 Jul
 2023 10:13:47 -0700 (PDT)
Date:   Fri, 21 Jul 2023 10:13:46 -0700
In-Reply-To: <84a908ae-04c7-51c7-c9a8-119e1933a189@redhat.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-14-seanjc@google.com>
 <84a908ae-04c7-51c7-c9a8-119e1933a189@redhat.com>
Message-ID: <ZLq8ylTsFQ1s4BAZ@google.com>
Subject: Re: [RFC PATCH v11 13/29] KVM: Add transparent hugepage support for
 dedicated guest memory
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 21, 2023, Paolo Bonzini wrote:
> On 7/19/23 01:44, Sean Christopherson wrote:
> > @@ -413,6 +454,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
> >   	u64 flags = args->flags;
> >   	u64 valid_flags = 0;
> > +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > +		valid_flags |= KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
> > +
> 
> I think it should be always allowed.  The outcome would just be "never have
> a hugepage" if thp is not enabled in the kernel.

I don't have a strong preference.  My thinking was that userspace would probably
rather have an explicit error, as opposed to silently running with a misconfigured
setup.
