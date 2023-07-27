Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50677659AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 19:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjG0RNb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 13:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjG0RNS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:13:18 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9814C30FC
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 10:13:10 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bba9a0da10so8097325ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690477989; x=1691082789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7oDMpfc0bW6NSyfuHNNNYlN2HFPFEuCSHvjU51+NBs=;
        b=uR617wLpg6qNB677nCTpj/mRcHCn7jeMQ6T975dwFWafb05LBOA5GXBHggNBovfIzX
         O/7M392ccdTOGZqesE1qC7szLmXDUVbpTkdUSAnDKesUZGTHf6YrHw7iRdcLemcslWSD
         KrRYixDmKkhke5BhBNDcGGoexHbctICnVSugeNNjkFTNcd3g+7vTx3m4xPX98nUwGt3/
         mWhf+uFvINzhg7lFN3O3GR8jmx04AReHHh1Ek1sP09ZwG+oxGwlWe7n39MiREf5a36wi
         QECqs1dJt2n4+euTMFmAQH0Oiz0RKLy4HgS6MVL8RVa78gxf6JRosPxL/mvaakJouVeF
         ho3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477989; x=1691082789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7oDMpfc0bW6NSyfuHNNNYlN2HFPFEuCSHvjU51+NBs=;
        b=L7Gtcs9staTSsEWj2w2LUULEuzzUCBpbpAdq8foMde3clzo5g7kdIfSWmptcqX/2vT
         RjZvuUBSuYrZA3EPcihpOOUoxBPeJGuUJ5IXL2xQQEUcczKcf6DcSpk10qvWJCivPtYI
         /BFekhrQSjWoZIKYdy/kdUxxmFlB3ypxupRBoKEACM8eL5KnBZw0YK4UOjtC68HHDIS/
         CZo2tMsn9m1QrnRKmWV/RNii3ibCAlNOc1IqWDNLDqTxj0k7nyY2+ecM9n5PMNNEqeTt
         WVT2pVq4J3wNsqqIA/CS/jTRupovwxBGEqPcL8PPXREUvZ79MShF5pSDJS4RTrVJvge/
         unrg==
X-Gm-Message-State: ABy/qLZmv+BPEkh2N6hCqVLMJVRRz/pWVmExFWVcMZ81IIP2bm6RkusD
        bd9HF35UX5adMTq4TgVxyVGAHrG/0jI=
X-Google-Smtp-Source: APBJJlEiCX9DyxliShqr2xPxTiyej7fUi+PkS+4LO77eNeghg1Fiv4b0fvD5YH2w9mP2/cy4q9w9vNXHRRI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:22c6:b0:1b5:2b14:5f2c with SMTP id
 y6-20020a17090322c600b001b52b145f2cmr24803plg.4.1690477989357; Thu, 27 Jul
 2023 10:13:09 -0700 (PDT)
Date:   Thu, 27 Jul 2023 10:13:07 -0700
In-Reply-To: <CA+EHjTzP2fypgkJbRpSPrKaWytW7v8ANEifofMnQCkdvYaX6Eg@mail.gmail.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-13-seanjc@google.com>
 <CA+EHjTzP2fypgkJbRpSPrKaWytW7v8ANEifofMnQCkdvYaX6Eg@mail.gmail.com>
Message-ID: <ZMKlo+Fe8n/eLQ82@google.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Fuad Tabba <tabba@google.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023, Fuad Tabba wrote:
> Hi Sean,
> 
> <snip>
> ...
> 
> > @@ -5134,6 +5167,16 @@ static long kvm_vm_ioctl(struct file *filp,
> >         case KVM_GET_STATS_FD:
> >                 r = kvm_vm_ioctl_get_stats_fd(kvm);
> >                 break;
> > +       case KVM_CREATE_GUEST_MEMFD: {
> > +               struct kvm_create_guest_memfd guest_memfd;
> > +
> > +               r = -EFAULT;
> > +               if (copy_from_user(&guest_memfd, argp, sizeof(guest_memfd)))
> > +                       goto out;
> > +
> > +               r = kvm_gmem_create(kvm, &guest_memfd);
> > +               break;
> > +       }
> 
> I'm thinking line of sight here, by having this as a vm ioctl (rather
> than a system iocl), would it complicate making it possible in the
> future to share/donate memory between VMs?

Maybe, but I hope not?

There would still be a primary owner of the memory, i.e. the memory would still
need to be allocated in the context of a specific VM.  And the primary owner should
be able to restrict privileges, e.g. allow a different VM to read but not write
memory.

My current thinking is to (a) tie the lifetime of the backing pages to the inode,
i.e. allow allocations to outlive the original VM, and (b) create a new file each
time memory is shared/donated with a different VM (or other entity in the kernel).

That should make it fairly straightforward to provide different permissions, e.g.
track them per-file, and I think should also avoid the need to change the memslot
binding logic since each VM would have it's own view/bindings.

Copy+pasting a relevant snippet from a lengthier response in a different thread[*]:

  Conceptually, I think KVM should to bind to the file.  The inode is effectively
  the raw underlying physical storage, while the file is the VM's view of that
  storage. 
  
  Practically, I think that gives us a clean, intuitive way to handle intra-host
  migration.  Rather than transfer ownership of the file, instantiate a new file
  for the target VM, using the gmem inode from the source VM, i.e. create a hard
  link.  That'd probably require new uAPI, but I don't think that will be hugely
  problematic.  KVM would need to ensure the new VM's guest_memfd can't be mapped
  until KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM (which would also need to verify the
  memslots/bindings are identical), but that should be easy enough to enforce.
  
  That way, a VM, its memslots, and its SPTEs are tied to the file, while allowing
  the memory and the *contents* of memory to outlive the VM, i.e. be effectively
  transfered to the new target VM.  And we'll maintain the invariant that each
  guest_memfd is bound 1:1 with a single VM.
  
  As above, that should also help us draw the line between mapping memory into a
  VM (file), and freeing/reclaiming the memory (inode).
  
  There will be extra complexity/overhead as we'll have to play nice with the
  possibility of multiple files per inode, e.g. to zap mappings across all files
  when punching a hole, but the extra complexity is quite small, e.g. we can use
  address_space.private_list to keep track of the guest_memfd instances associated
  with the inode.
  
  Setting aside TDX and SNP for the moment, as it's not clear how they'll support
  memory that is "private" but shared between multiple VMs, I think per-VM files
  would work well for sharing gmem between two VMs.  E.g. would allow a give page
  to be bound to a different gfn for each VM, would allow having different permissions
  for each file (e.g. to allow fallocate() only from the original owner).

[*] https://lore.kernel.org/all/ZLGiEfJZTyl7M8mS@google.com
