Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572617A0DDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 21:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbjINTMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 15:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbjINTMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:12:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CD21FD8
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 12:12:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8186d705a9so1598531276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 12:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694718736; x=1695323536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYBWSie1WcKieNCkM5oJg6niwnE6sJx6iHmmYDkBNI4=;
        b=zYyWdm1l8P8WZXtjqDgUI3mRKkA/xQYpvM8+n/UB1d2M/ToPNMNOcK4LdO/ZCEqw59
         BGcoqSqF8bVMoIjDA2nuATKvIi15WRQF70hvkFfiXZ2LFuS5BC/y8BpnqKf5KWVW5ICI
         JalGFAlrGIIdW0gEwvUhT7Lv+f4HNnHTIgG4JoQwGJHpjlMEdHa4NIp3PHdHJfSGLZlQ
         Z083RL/ixn5egsogS8Kqh7ocxiDkroPSJy+tDo/SIGLNEZxJJOHIgIV4uvwBcpS69l5r
         r+BZ8R/8bEEKE/aSC0JcYzf3sEw/dUxsVZIYSmroQnq2IDLJEBk0xIVUl/FbX/k8Ckxy
         qwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694718736; x=1695323536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYBWSie1WcKieNCkM5oJg6niwnE6sJx6iHmmYDkBNI4=;
        b=cMArkSetIR/cuI5UcD21VzEV9HG61eyt/HenO6p7B2vPZ5cClQNnkgMFlqKl/QhLNa
         dQ6e7XJgrLxTEndgbLqCkh11SuzWRYp8AAYz9cgAA3WrRARcqFDbA1nR6ii5M0z4iVpc
         1BX+JpAf8+SW4SwX5QDRN64Z8EcXL64E7PRu6/nBX0mcFhYghwb0Qt1NFZCNjulZEvuv
         CjRB5bysC7thLV8Bt/90gkAeP97zYhxsBeD0jIcjhV182vzkeE0Rrw/5t8ALE/G46xvA
         8Nf1V0FlHfO9ddEgEgxDseHzqSs6OEGv6OcJg8nDLx/bMNHKQK+XyEJO71b/3PmdETr9
         qW9A==
X-Gm-Message-State: AOJu0YyyV+WuB722zrMk6cWkQ3UCYJi6VHCC/nBE89Ea5auRUR2tvDzl
        GeEJCBwkyb5VluI4T8iz5Vuyn/gODL4=
X-Google-Smtp-Source: AGHT+IEbiNaBi+bbmiwHYIoXYm8wvREABvNIqLAChDCxgGMZnU/PhXOjKBEoc76witsZv+IRa9HvnC8Otog=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:bc7:0:b0:d77:fb4e:d85e with SMTP id
 190-20020a250bc7000000b00d77fb4ed85emr138869ybl.6.1694718735743; Thu, 14 Sep
 2023 12:12:15 -0700 (PDT)
Date:   Thu, 14 Sep 2023 12:12:14 -0700
In-Reply-To: <253965df-6d80-bbfd-ab01-f9e69b274bf3@quicinc.com>
Mime-Version: 1.0
References: <diqzttsiu67n.fsf@ackerleytng-ctop.c.googlers.com> <253965df-6d80-bbfd-ab01-f9e69b274bf3@quicinc.com>
Message-ID: <ZQNbDt6vqwC4gZmi@google.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Ackerley Tng <ackerleytng@google.com>, pbonzini@redhat.com,
        maz@kernel.org, oliver.upton@linux.dev, chenhuacai@kernel.org,
        mpe@ellerman.id.au, anup@brainfault.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, willy@infradead.org,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, chao.p.peng@linux.intel.com,
        tabba@google.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023, Elliot Berman wrote:
> I had a 3rd question that's related to how to wire the gmem up to a virtual
> machine:
> 
> I learned of a usecase to implement copy-on-write for gmem. The premise
> would be to have a "golden copy" of the memory that multiple virtual
> machines can map in as RO. If a virtual machine tries to write to those
> pages, they get copied to a virtual machine-specific page that isn't shared
> with other VMs. How do we track those pages?

The answer is going to be gunyah specific, because gmem itself isn't designed to
provide a virtualization layer ("virtual" in the virtual memory sense, not in the
virtual machine sense).  Like any other CoW implementation, the RO page would need
to be copied to a different physical page, and whatever layer translates gfns
to physical pages would need to be updated.  E.g. in gmem terms, allocate a new
gmem page/instance and update the gfn=>gmem[offset] translation in KVM/gunyah.

For VMA-based memory, that translation happens in the primary MMU, and is largely
transparent to KVM (or any other secondary MMU).  E.g. the primary MMU works with
the backing store (if necessary) to allocate a new page and do the copy, notifies
secondary MMUs, zaps the old PTE(s), and then installs the new PTE(s).  KVM/gunyah
just needs to react to the mmu_notifier event, e.g. zap secondary MMU PTEs, and
then KVM/gunyah naturally gets the new, writable page/PTE when following the host
virtual address, e.g. via gup().

The downside of eliminating the middle-man (primary MMU) from gmem is that the
"owner" (KVM or gunyah) is now responsible for these types of operations.  For some
things, e.g. page migration, it's actually easier in some ways, but for CoW it's
quite a bit more work for KVM/gunyah because KVM/gunyah now needs to do things
that were previously handled by the primary MMU.

In KVM, assuming no additional support in KVM, doing CoW would mean modifying
memslots to redirect the gfn from the RO page to the writable page.  For a variety
of reasons, that would be _extremely_ expensive in KVM, but still possible.  If
there were a strong use case for supporting CoW with KVM+gmem, then I suspect that
we'd probably implement new KVM uAPI of some form to provide reasonable performance.

But I highly doubt we'll ever do that, because one of core tenets of KVM+gmem is
to isolate guest memory from the rest of the world, and especially from host
userspace, and that just doesn't mesh well with CoW'd memory being shared across
multiple VMs.
