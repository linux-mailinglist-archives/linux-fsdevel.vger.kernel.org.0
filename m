Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE17A118F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 01:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjINXTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 19:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINXTm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:19:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04FB270A
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 16:19:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7e8bb74b59so1856875276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 16:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694733577; x=1695338377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4dPufiPQCtPzWz5WHSfvhHWIcWm8zH/JZg221REQo40=;
        b=BE71Wxnxf9TXA4uEG1U0seh2vfYltm/8zcCFo5uV0eHujhfmKpQ6viEb+NNBb6Dwhc
         P8bs3PYzSbe3D4fPu4d+k7pb0gvCNTZ/skyj5fMz59hs2XZDM9Iu8EIT2QGUj8CwD2hF
         VhP+MTv0bFqBaHPQ1155wjxTqW899a7knVyzkqvEyTb10+GMcMamfhqMH+ycTMc3nHO3
         6TpxZWCJ3/7kuA/983/tRwmmq72d/RwcxFAXY8BXaGPZVMoy3HoUsXsh/WP+ZEUko9kB
         uumFQJq+gwCpW4SLi2GtEJ/RodOlKnZ/i0sCV5zSDbqp6z708wVn/Y3sxijCTb3ibSzT
         MMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694733577; x=1695338377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dPufiPQCtPzWz5WHSfvhHWIcWm8zH/JZg221REQo40=;
        b=bD1VrTbOIplc4QirQ25sudJwvH8dpws/WmSjJ8yL3Cg+3eMgLDHVPYXOd1lBSM/0l8
         uOigCZb51wD+WnuMQLXFc7n3urva3hT4OiYDx1wdguC68vLZ09hDzZF/Pl0CKcogi6Ao
         vfRwtQ5blDiSBj2wYIx4+d7GIBz6El3QmQWeQX0mSqE1u3oXYCOfTaA0uYZ6ws9TbcHQ
         IJTKz6QnF8PocsY43t8ZP/Sb28NJ8fr2rDRzOP14+VbAQFemXapI8ogXOrbScat/n+HE
         2ZMms1yIYkggmsYPTP8CV2ihySdghxxcU1PMXdxrUvFtdC5ZUXeV+zIoXFEzPsAWFBdg
         J5Xw==
X-Gm-Message-State: AOJu0Yz6DMfTEEFXmM1QQ0uHWg3mL0HLXPxgQ7kEgJcUjtMHxLfmU6RJ
        RINK4es2pjASfYFCmYSbLkpp5J7jtPIT8WkT0A==
X-Google-Smtp-Source: AGHT+IGXEzZPfzBJslkSHoMTui4zDBSgnXtUGummxt07D80J/zY1rCAlKy2IgGo0zSECxNr/ULgwmLbLuPQoPz0S1A==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:aa83:0:b0:d77:984e:c770 with SMTP
 id t3-20020a25aa83000000b00d77984ec770mr158034ybi.5.1694733576882; Thu, 14
 Sep 2023 16:19:36 -0700 (PDT)
Date:   Thu, 14 Sep 2023 23:19:34 +0000
In-Reply-To: <ZQNN2AyDJ8dF0/6D@google.com>
Mime-Version: 1.0
References: <ZOO782YGRY0YMuPu@google.com> <diqzttsiu67n.fsf@ackerleytng-ctop.c.googlers.com>
 <ZQNN2AyDJ8dF0/6D@google.com>
Message-ID: <diqzv8ccjqbd.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Ackerley Tng <ackerleytng@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
        chenhuacai@kernel.org, mpe@ellerman.id.au, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, willy@infradead.org,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Aug 28, 2023, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> >> If we track struct kvm with the inode, then I think (a), (b) and (c) can
>> >> be independent of the refcounting method. What do you think?
>> >
>> > No go.  Because again, the inode (physical memory) is coupled to the virtual machine
>> > as a thing, not to a "struct kvm".  Or more concretely, the inode is coupled to an
>> > ASID or an HKID, and there can be multiple "struct kvm" objects associated with a
>> > single ASID.  And at some point in the future, I suspect we'll have multiple KVM
>> > objects per HKID too.
>> >
>> > The current SEV use case is for the migration helper, where two KVM objects share
>> > a single ASID (the "real" VM and the helper).  I suspect TDX will end up with
>> > similar behavior where helper "VMs" can use the HKID of the "real" VM.  For KVM,
>> > that means multiple struct kvm objects being associated with a single HKID.
>> >
>> > To prevent use-after-free, KVM "just" needs to ensure the helper instances can't
>> > outlive the real instance, i.e. can't use the HKID/ASID after the owning virtual
>> > machine has been destroyed.
>> >
>> > To put it differently, "struct kvm" is a KVM software construct that _usually_,
>> > but not always, is associated 1:1 with a virtual machine.
>> >
>> > And FWIW, stashing the pointer without holding a reference would not be a complete
>> > solution, because it couldn't guard against KVM reusing a pointer.  E.g. if a
>> > struct kvm was unbound and then freed, KVM could reuse the same memory for a new
>> > struct kvm, with a different ASID/HKID, and get a false negative on the rebinding
>> > check.
>> 
>> I agree that inode (physical memory) is coupled to the virtual machine
>> as a more generic concept.
>> 
>> I was hoping that in the absence of CC hardware providing a HKID/ASID,
>> the struct kvm pointer could act as a representation of the "virtual
>> machine". You're definitely right that KVM could reuse a pointer and so
>> that idea doesn't stand.
>> 
>> I thought about generating UUIDs to represent "virtual machines" in the
>> absence of CC hardware, and this UUID could be transferred during
>> intra-host migration, but this still doesn't take host userspace out of
>> the TCB. A malicious host VMM could just use the migration ioctl to copy
>> the UUID to a malicious dumper VM, which would then pass checks with a
>> gmem file linked to the malicious dumper VM. This is fine for HKID/ASIDs
>> because the memory is encrypted; with UUIDs there's no memory
>> encryption.
>
> I don't understand what problem you're trying to solve.  I don't see a need to
> provide a single concrete representation/definition of a "virtual machine".  E.g.
> there's no need for a formal definition to securely perform intrahost migration,
> KVM just needs to ensure that the migration doesn't compromise guest security,
> functionality, etc.
>
> That gets a lot more complex if the target KVM instance (module, not "struct kvm")
> is a different KVM, e.g. when migrating to a different host.  Then there needs to
> be a way to attest that the target is trusted and whatnot, but that still doesn't
> require there to be a formal definition of a "virtual machine".
>
>> Circling back to the original topic, was associating the file with
>> struct kvm at gmem file creation time meant to constrain the use of the
>> gmem file to one struct kvm, or one virtual machine, or something else?
>
> It's meant to keep things as simple as possible (relatively speaking).  A 1:1
> association between a KVM instance and a gmem instance means we don't have to
> worry about the edge cases and oddities I pointed out earlier in this thread.
>

I looked through this thread again and re-read the edge cases and
oddities that was pointed out earlier (last paragraph at [1]) and I
think I understand better, and I have just one last clarification.

It was previously mentioned that binding on creation time simplifies the
lifecycle of memory:

"(a) prevent a different VM from *ever* binding to the gmem instance" [1]

Does this actually mean

"prevent a different struct kvm from *ever* binding to this gmem file"

?

If so, then binding on creation

+ Makes the gmem *file* (and just not the bindings xarray) the binding
  between struct kvm and the file.
+ Simplifies the KVM-userspace contract to "this gmem file can only be
  used with this struct kvm"

Binding on creation doesn't offer any way to block the contents of the
inode from being used with another "virtual machine" though, since we
can have more than one gmem file pointing to the same inode, and the
other gmem file is associated with another struct kvm. (And a strut kvm
isn't associated 1:1 with a virtual machine [2])

The point about an inode needing to be coupled to a virtual machine as a
thing [2] led me to try to find a single concrete representation of a
"virtual machine".

Is locking inode contents to a "virtual machine" outside the scope of
gmem? If so, then it is fine to bind on creation time, use a VM ioctl
over a system ioctl, and the method of refcounting in gmem v12 is okay.

[1] https://lore.kernel.org/lkml/ZNKv9ul2I7A4V7IF@google.com/
[2] https://lore.kernel.org/lkml/ZOO782YGRY0YMuPu@google.com/

> <snip>
