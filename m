Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB1370A039
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjEST60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 15:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEST6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 15:58:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EC410DC
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 12:57:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c2999fdc7so70247247b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684526250; x=1687118250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKqky4qtLhLMqwc+jYDJn6p8bYat7L/lp+nKxMPkRyY=;
        b=Y4/nCNzrFtAXrTxhpgxnIohVGQ15GL4scvI0E/2mwJYj0GQbPVuXot7Jeu/0WvRvj2
         9Uxos5w5dD8ChOUGochlppnIBC5WV72wtD3Z57q1qVzEB6BAU0zrp0Rj839OpxiYl1kv
         G7aILpvUERbXB4ndb2rR/5sC8oXuhx9NqV1vUAEDqYGF4xFHckOEfCC8e/Xg4DdMuR9l
         zQm9PUkP+OBFNpwTjL8yMr9HKgLvxTY4wkwyU4C1eKD22zw0o+8bYInRVaF8kFuyTWom
         12s22nrLwFtLZKHZJekTC38ZFlIu/iG4U6Mf6VoeQ952/z/sfp8161qhLkUY71jT5lqI
         iHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684526250; x=1687118250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKqky4qtLhLMqwc+jYDJn6p8bYat7L/lp+nKxMPkRyY=;
        b=ahYZSr+QmoVlaFsteqEmohOq4wDi/ivaOTWItjYyMqFeGv/+UwVOoOoFE6VLQld5Pl
         2XwQ3cKmUCl+6j80USkYIMWtXGRWWXMkAHsPEboN1rgHdroNOJVxGkx4CW3PQj17yaRO
         cG+/O7IEEQwlPqH0NJKTWfs/S20z1liHl16ps2DbRLQb8XRaLiG9K+cVcECaA9JSgqjM
         KJmR7twGX1B5oU2DyiWvcpeomjlYfZVduWonf+c2fXbM8FXra9dzOSHeWZlGKJ319IaL
         P8M10HNuwiIaCZ8l6xfOttMus/5tk3TouDz1pgul5wQFNVURH9FlP3AIhyA6lS47X1BX
         rduw==
X-Gm-Message-State: AC+VfDxfV9KWvIRAbSwv8jkRI5QM3I8l9FHHs1aFhQWSsKDFoO8LXRuO
        v/84jszoyFrWfJUhCr1BhHVhVE3NMQ4=
X-Google-Smtp-Source: ACHHUZ6FEiPmU5v43LWifQRBpo81052L49sw5QgxYInZToAzWsR8mGtYDH7+PppQKkPgp34+c6aLJuvLWhk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9f0a:0:b0:561:949f:227 with SMTP id
 s10-20020a819f0a000000b00561949f0227mr1854093ywn.1.1684526250423; Fri, 19 May
 2023 12:57:30 -0700 (PDT)
Date:   Fri, 19 May 2023 12:57:28 -0700
In-Reply-To: <CSQI5IB968XC.GO0OPMYT1C8N@dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com>
Mime-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com> <CSQFE7I30W27.2TPDIHOTZNRIZ@dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com>
 <ZGe+m+uFzpiW7wlr@google.com> <CSQI5IB968XC.GO0OPMYT1C8N@dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com>
Message-ID: <ZGfUqBLaO+cI9ypv@google.com>
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, graf@amazon.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com, anelkz@amazon.de
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023, Nicolas Saenz Julienne wrote:
> Hi Sean,
> 
> On Fri May 19, 2023 at 6:23 PM UTC, Sean Christopherson wrote:
> > On Fri, May 19, 2023, Nicolas Saenz Julienne wrote:
> > > Hi,
> > >
> > > On Fri Dec 2, 2022 at 6:13 AM UTC, Chao Peng wrote:
> > >
> > > [...]
> > > > +The user sets the per-page memory attributes to a guest memory range indicated
> > > > +by address/size, and in return KVM adjusts address and size to reflect the
> > > > +actual pages of the memory range have been successfully set to the attributes.
> > > > +If the call returns 0, "address" is updated to the last successful address + 1
> > > > +and "size" is updated to the remaining address size that has not been set
> > > > +successfully. The user should check the return value as well as the size to
> > > > +decide if the operation succeeded for the whole range or not. The user may want
> > > > +to retry the operation with the returned address/size if the previous range was
> > > > +partially successful.
> > > > +
> > > > +Both address and size should be page aligned and the supported attributes can be
> > > > +retrieved with KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES.
> > > > +
> > > > +The "flags" field may be used for future extensions and should be set to 0s.
> > >
> > > We have been looking into adding support for the Hyper-V VSM extensions
> > > which Windows uses to implement Credential Guard. This interface seems
> > > like a good fit for one of its underlying features. I just wanted to
> > > share a bit about it, and see if we can expand it to fit this use-case.
> > > Note that this was already briefly discussed between Sean and Alex some
> > > time ago[1].
> > >
> > > VSM introduces isolated guest execution contexts called Virtual Trust
> > > Levels (VTL) [2]. Each VTL has its own memory access protections,
> > > virtual processors states, interrupt controllers and overlay pages. VTLs
> > > are hierarchical and might enforce memory protections on less privileged
> > > VTLs. Memory protections are enforced on a per-GPA granularity.
> > >
> > > The list of possible protections is:
> > > - No access -- This needs a new memory attribute, I think.
> >
> > No, if KVM provides three bits for READ, WRITE, and EXECUTE, then userspace can
> > get all the possible combinations.  E.g. this is RWX=000b
> 
> That's not what the current implementation does, when attributes is
> equal 0 it clears the entries from the xarray:
> 
> static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> 					   struct kvm_memory_attributes *attrs)
> {
> 
>     entry = attrs->attributes ? xa_mk_value(attrs->attributes) : NULL;
> [...]
>     for (i = start; i < end; i++)
>     	if (xa_err(xa_store(&kvm->mem_attr_array, i, entry,
>     			    GFP_KERNEL_ACCOUNT)))
>         		break;
> }
> 
> >From Documentation/core-api/xarray.rst:
> 
> "There is no difference between an entry that has never
> been stored to, one that has been erased and one that has most recently
> had ``NULL`` stored to it."
> 
> The way I understood the series, there needs to be a differentiation
> between no attributes (regular page fault) and no-access.

Ah, I see what you're saying.  There are multiple ways to solve things without a
"no access" flag while still maintaining an empty xarray for the default case.
E.g. invert the flags to be DENY flags[*], have an internal-only "entry valid" flag,
etc.

[*] I vaguely recall suggesting a "deny" approach somewhere, but I may just be
    making things up to make it look like I thought deeply about this ;-)
