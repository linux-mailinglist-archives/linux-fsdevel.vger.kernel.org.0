Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72D7A9D00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjIUT1x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 15:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjIUT1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:27:30 -0400
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6E7A7B67
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:01:31 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id ada2fe7eead31-452598c86f8so457325137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695319290; x=1695924090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hX9qb1Iw7SkuB3FcSZYopfwd6y9xnz247DDm3mrX40=;
        b=oTC1+IhhS4nGF/u3K0mfUlD3e0n/fh3wQgL23erg3YvD0Z/1XdNehoh6oxdcVKN/EU
         LD6WRmRBnotZzUT1O82aX58OGsTNqgBc//JxiaVfVLvl2K2YAYj3pm26YptJI8lx8oKW
         MBQ4LiPqZyy2XMZDXEnV/Hmw7VbwcJsfFGKAM4IlcK80U/Qo9Gr+NhfzG/zqxGjnuRtM
         zMntfU7JEK7T9undBj2wEEjGPlTqHptAf5vpK5MOV3JGciEjnIkr0zcSVzApYmhld7p6
         aveOZ8HhfsxCIVGgfY+hFL7/gzo/+brFb3/C1w/MYdO4X4Pdzk0V/gwkYZY7JALmvGa1
         encg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319290; x=1695924090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hX9qb1Iw7SkuB3FcSZYopfwd6y9xnz247DDm3mrX40=;
        b=dfOno31THZnWQIX9RU1hWnun4oRGD5OQby74v25A91zvDiherpwwQEouz5yuJtler4
         km3MXrD5EdX4UaKg/asucX/1gOs4aIeReXe0PmVNPS6lVt0xcvr63U91MByaecnC4rSk
         RRb6n9Qejv0BoywRoZBWocKTqtzIvzM6Z0mRUVBFa3U67dRJDarN1mStk2C3nu6WLrgn
         HDcW+/E28pC4UaVCP7qButZ+pis7lVeaI9XHmJPHmsIrGw2ebv2+Q1zKT6Zgb94ig/Bd
         cqbyy6geubN+kUOTxJ5TrjPVDnOxbQb7kggdULitND61OUuKevtYIPeagEMOASvpBNLj
         FhJA==
X-Gm-Message-State: AOJu0Yx2m3JKs6Qnemlx8msScGGsN69lRnJExTPCPWpx0gY54TBloABJ
        zkuVzwyVDZ8WX9wz2J6eLxo9BKXi0Zs=
X-Google-Smtp-Source: AGHT+IGMlI3r5pTKtUH2X22CRcKkDXwZa01FQ/zuLj/x6iC6Lpx1DAvznI7oMbumBcX5i3FsE4fH+yzcjSE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2906:b0:59e:ee51:52a1 with SMTP id
 eg6-20020a05690c290600b0059eee5152a1mr76581ywb.10.1695308352199; Thu, 21 Sep
 2023 07:59:12 -0700 (PDT)
Date:   Thu, 21 Sep 2023 07:59:10 -0700
In-Reply-To: <ZQef3zAEYjZMkn9k@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-19-seanjc@google.com>
 <ZQPuMK6D/7UzDH+D@yzhao56-desk.sh.intel.com> <ZQRpiOd1DNDDJQ3r@google.com> <ZQef3zAEYjZMkn9k@yzhao56-desk.sh.intel.com>
Message-ID: <ZQxaPsNiFgfXH7aq@google.com>
Subject: Re: [RFC PATCH v12 18/33] KVM: x86/mmu: Handle page fault for private memory
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
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023, Yan Zhao wrote:
> On Fri, Sep 15, 2023 at 07:26:16AM -0700, Sean Christopherson wrote:
> > On Fri, Sep 15, 2023, Yan Zhao wrote:
> > > >  static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> > > >  {
> > > >  	struct kvm_memory_slot *slot = fault->slot;
> > > > @@ -4293,6 +4356,14 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> > > >  			return RET_PF_EMULATE;
> > > >  	}
> > > >  
> > > > +	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
> > > In patch 21,
> > > fault->is_private is set as:
> > > 	".is_private = kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT)",
> > > then, the inequality here means memory attribute has been updated after
> > > last check.
> > > So, why an exit to user space for converting is required instead of a mere retry?
> > > 
> > > Or, is it because how .is_private is assigned in patch 21 is subjected to change
> > > in future? 
> > 
> > This.  Retrying on SNP or TDX would hang the guest.  I suppose we could special
> Is this because if the guest access a page in private way (e.g. via
> private key in TDX), the returned page must be a private page?

Yes, the returned page must be private, because the GHCI (TDX) and GHCB (SNP)
require that the host allow implicit conversions.  I.e. if the guest accesses
memory as private (or shared), then the host must map memory as private (or shared).
Simply resuming the guest will not change the guest access, nor will it change KVM's
memory attributes.

Ideally (IMO), implicit conversions would be disallowed, but even if implicit
conversions weren't a thing, retrying would still be wrong as KVM would either
inject an exception into the guest or exit to userspace to let userspace handle
the illegal access.

> > case VMs where .is_private is derived from the memory attributes, but the
> > SW_PROTECTED_VM type is primary a development vehicle at this point.  I'd like to
> > have it mimic SNP/TDX as much as possible; performance is a secondary concern.
> Ok. But this mimic is somewhat confusing as it may be problematic in below scenario,
> though sane guest should ensure no one is accessing a page before doing memory
> conversion.
> 
> 
> CPU 0                           CPU 1
> access GFN A in private way
> fault->is_private=true
>                                 convert GFN A to shared
> 			        set memory attribute of A to shared
> 
> faultin, mismatch and exit
> set memory attribute of A
> to private
> 
>                                 vCPU access GFN A in shared way
>                                 fault->is_private = true
>                                 faultin, match and map a private PFN B
> 
>                                 vCPU accesses private PFN B in shared way

If this is a TDX or SNP VM, then the private vs. shared information comes from
the guest itself, e.g. this sequence

                                   vCPU access GFN A in shared way
                                   fault->is_private = true

cannot happen because is_private will be false based on the error code (SNP) or
the GPA (TDX).

And when hardware doesn't generate page faults based on private vs. shared, i.e.
for non-TDX/SNP VMs, from a fault handling perspective there is no concept of the
guest accessing a GFN in a "private way" or a "shared way".  I.e. there are no
implicit conversions.

For SEV and SEV-ES, the guest can access memory as private vs. shared, but the
and the host VMM absolutely must be in agreement and synchronized with respect to
the state of a page, otherwise guest memory will be corrupted.  But that has
nothing to do with the fault handling, e.g. creating aliases in the guest to access
a single GFN as shared and private from two CPUs will create incoherent cache
entries and/or corrupt data without any involvement from KVM.

In other words, the above isn't possible for TDX/SNP, and for all other types,
the conflict between CPU0 and CPU1 is unequivocally a guest bug.
