Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACEC4F4D47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581826AbiDEXlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573081AbiDERyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A71DE098;
        Tue,  5 Apr 2022 10:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9CD0618C2;
        Tue,  5 Apr 2022 17:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7AEC385A0;
        Tue,  5 Apr 2022 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649181121;
        bh=hqH+QSZfadwFXCGrjO8VTTfkKCqRFX1T+JupKqGVDm0=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=oSVkj/xvcy/eixrdDZ2gvxOJqdLzg99jaCn+KPG1W69J/vwgfN3Q2Ia8DPW330B7+
         hlPhjr+UTCMHUfbP3Jei2to4KuCP2aO7vGYRL1oMFDR/IqRD4z7oPPSQBlFYcW3UPN
         Bo98OhExcnySW5W7im9d1ndRd2t4bw79rTx3OGRIlEKoxmOXc7USCAdePu9EBmeUPQ
         MIeJmmJ84caFvkdjjps9un5W8fcF0aegwB3YxHeeNspew67IGfcoqOdyu4bEsIzhRB
         p0/EAqMqgqpSr2HrTfbvPutnOQMOCSdkkxCEdi6DGeeEXEdzGElTgQ2pwVuKDvxwZL
         pGDpqiEHJlfLQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 75BAB27C0060;
        Tue,  5 Apr 2022 13:51:58 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 05 Apr 2022 13:51:58 -0400
X-ME-Sender: <xms:vIFMYlYh-WoVj8LdlK5vn0io3hgG1_2YWCLsXTEbEOcySiUj70SGyg>
    <xme:vIFMYsaRRPdbml9zQnpknb8U4f7ETOqpUs5McXk9P5A4z-Y_xgx3GUwMLO-Gt8-ah
    -n3s4kP0Kdjw5PglGE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:vIFMYn9NEvF_TBL1spBkvY-0ka4JWudj32TiWmdPj6vqo9gFtTA9nA>
    <xmx:vIFMYjqFYu4_KeR9ouxcUiKNHAJPrme1qWizKsqHok3DM7XKAhFwLA>
    <xmx:vIFMYgqaYF0YjOQ9dVjgpgb6-zh5wVmi9QsUUSkcryLtZO3zICKeDA>
    <xmx:voFMYtI2E0uNsj19WzpS2ZTueo0OADSOiVkKSKe_-tDe_zfteJJWGg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 91EB721E006E; Tue,  5 Apr 2022 13:51:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-385-g3a17909f9e-fm-20220404.001-g3a17909f
Mime-Version: 1.0
Message-Id: <54acbba9-f4fd-48c1-9028-d596d9f63069@www.fastmail.com>
In-Reply-To: <Ykwbqv90C7+8K+Ao@google.com>
References: <YkM7eHCHEBe5NkNH@google.com>
 <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com> <YkQzfjgTQaDd2E2T@google.com>
 <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com> <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com>
Date:   Tue, 05 Apr 2022 10:51:36 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Quentin Perret" <qperret@google.com>
Cc:     "Sean Christopherson" <seanjc@google.com>,
        "Steven Price" <steven.price@arm.com>,
        "Chao Peng" <chao.p.peng@linux.intel.com>,
        "kvm list" <kvm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        "Wanpeng Li" <wanpengli@tencent.com>,
        "Jim Mattson" <jmattson@google.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Hugh Dickins" <hughd@google.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Vishal Annapurve" <vannapurve@google.com>,
        "Yu Zhang" <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Marc Zyngier" <maz@kernel.org>, "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM guest
 private memory
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, Apr 5, 2022, at 3:36 AM, Quentin Perret wrote:
> On Monday 04 Apr 2022 at 15:04:17 (-0700), Andy Lutomirski wrote:
>> 
>> 
>> On Mon, Apr 4, 2022, at 10:06 AM, Sean Christopherson wrote:
>> > On Mon, Apr 04, 2022, Quentin Perret wrote:
>> >> On Friday 01 Apr 2022 at 12:56:50 (-0700), Andy Lutomirski wrote:
>> >> FWIW, there are a couple of reasons why I'd like to have in-place
>> >> conversions:
>> >> 
>> >>  - one goal of pKVM is to migrate some things away from the Arm
>> >>    Trustzone environment (e.g. DRM and the likes) and into protected VMs
>> >>    instead. This will give Linux a fighting chance to defend itself
>> >>    against these things -- they currently have access to _all_ memory.
>> >>    And transitioning pages between Linux and Trustzone (donations and
>> >>    shares) is fast and non-destructive, so we really do not want pKVM to
>> >>    regress by requiring the hypervisor to memcpy things;
>> >
>> > Is there actually a _need_ for the conversion to be non-destructive?  
>> > E.g. I assume
>> > the "trusted" side of things will need to be reworked to run as a pKVM 
>> > guest, at
>> > which point reworking its logic to understand that conversions are 
>> > destructive and
>> > slow-ish doesn't seem too onerous.
>> >
>> >>  - it can be very useful for protected VMs to do shared=>private
>> >>    conversions. Think of a VM receiving some data from the host in a
>> >>    shared buffer, and then it wants to operate on that buffer without
>> >>    risking to leak confidential informations in a transient state. In
>> >>    that case the most logical thing to do is to convert the buffer back
>> >>    to private, do whatever needs to be done on that buffer (decrypting a
>> >>    frame, ...), and then share it back with the host to consume it;
>> >
>> > If performance is a motivation, why would the guest want to do two 
>> > conversions
>> > instead of just doing internal memcpy() to/from a private page?  I 
>> > would be quite
>> > surprised if multiple exits and TLB shootdowns is actually faster, 
>> > especially at
>> > any kind of scale where zapping stage-2 PTEs will cause lock contention 
>> > and IPIs.
>> 
>> I don't know the numbers or all the details, but this is arm64, which is a rather better architecture than x86 in this regard.  So maybe it's not so bad, at least in very simple cases, ignoring all implementation details.  (But see below.)  Also the systems in question tend to have fewer CPUs than some of the massive x86 systems out there.
>
> Yep. I can try and do some measurements if that's really necessary, but
> I'm really convinced the cost of the TLBI for the shared->private
> conversion is going to be significantly smaller than the cost of memcpy
> the buffer twice in the guest for us. To be fair, although the cost for
> the CPU update is going to be low, the cost for IOMMU updates _might_ be
> higher, but that very much depends on the hardware. On systems that use
> e.g. the Arm SMMU, the IOMMUs can use the CPU page-tables directly, and
> the iotlb invalidation is done on the back of the CPU invalidation. So,
> on systems with sane hardware the overhead is *really* quite small.
>
> Also, memcpy requires double the memory, it is pretty bad for power, and
> it causes memory traffic which can't be a good thing for things running
> concurrently.
>
>> If we actually wanted to support transitioning the same page between shared and private, though, we have a bit of an awkward situation.  Private to shared is conceptually easy -- do some bookkeeping, reconstitute the direct map entry, and it's done.  The other direction is a mess: all existing uses of the page need to be torn down.  If the page has been recently used for DMA, this includes IOMMU entries.
>>
>> Quentin: let's ignore any API issues for now.  Do you have a concept of how a nondestructive shared -> private transition could work well, even in principle?
>
> I had a high level idea for the workflow, but I haven't looked into the
> implementation details.
>
> The idea would be to allow KVM *or* userspace to take a reference
> to a page in the fd in an exclusive manner. KVM could take a reference
> on a page (which would be necessary before to donating it to a guest)
> using some kind of memfile_notifier as proposed in this series, and
> userspace could do the same some other way (mmap presumably?). In both
> cases, the operation might fail.
>
> I would imagine the boot and private->shared flow as follow:
>
>  - the VMM uses fallocate on the private fd, and associates the <fd,
>    offset, size> with a memslot;
>
>  - the guest boots, and as part of that KVM takes references to all the
>    pages that are donated to the guest. If userspace happens to have a
>    mapping to a page, KVM will fail to take the reference, which would
>    be fatal for the guest.
>
>  - once the guest has booted, it issues a hypercall to share a page back
>    with the host;
>
>  - KVM is notified, and at that point it drops its reference to the
>    page. It then exits to userspace to notify it of the share;
>
>  - host userspace receives the share, and mmaps the shared page with
>    MAP_FIXED to access it, which takes a reference on the fd-backed
>    page.
>
> There are variations of that idea: e.g. allow userspace to mmap the
> entire private fd but w/o taking a reference on pages mapped with
> PROT_NONE. And then the VMM can use mprotect() in response to
> share/unshare requests. I think Marc liked that idea as it keeps the
> userspace API closer to normal KVM -- there actually is a
> straightforward gpa->hva relation. Not sure how much that would impact
> the implementation at this point.
>
> For the shared=>private conversion, this would be something like so:
>
>  - the guest issues a hypercall to unshare a page;
>
>  - the hypervisor forwards the request to the host;
>
>  - the host kernel forwards the request to userspace;
>
>  - userspace then munmap()s the shared page;
>
>  - KVM then tries to take a reference to the page. If it succeeds, it
>    re-enters the guest with a flag of some sort saying that the share
>    succeeded, and the hypervisor will adjust pgtables accordingly. If
>    KVM failed to take a reference, it flags this and the hypervisor will
>    be responsible for communicating that back to the guest. This means
>    the guest must handle failures (possibly fatal).
>
> (There are probably many ways in which we can optimize this, e.g. by
> having the host proactively munmap() pages it no longer needs so that
> the unshare hypercall from the guest doesn't need to exit all the way
> back to host userspace.)
>
> A nice side-effect of the above is that it allows userspace to dump a
> payload in the private fd before booting the guest. It just needs to
> mmap the fd, copy what it wants in there, munmap, and only then pass the
> fd to KVM which will be happy enough as long as there are no current
> references to the pages. Note: in a previous email I've said that
> Android doesn't need this (which is correct as our guest bootloader
> currently receives the payload over virtio) but this might change some
> day, and there might be other implementations as well, so it's a nice
> bonus if we can make this work.
>
>> The best I can come up with is a special type of shared page that is not GUP-able and maybe not even mmappable, having a clear option for transitions to fail, and generally preventing the nasty cases from happening in the first place.
>
> Right, that sounds reasonable to me.

At least as a v1, this is probably more straightforward than allowing mmap().  Also, there's much to be said for a simpler, limited API, to be expanded if genuinely needed, as opposed to starting out with a very featureful API.

>
>> Maybe there could be a special mode for the private memory fds in which specific pages are marked as "managed by this fd but actually shared".  pread() and pwrite() would work on those pages, but not mmap().  (Or maybe mmap() but the resulting mappings would not permit GUP.)  And transitioning them would be a special operation on the fd that is specific to pKVM and wouldn't work on TDX or SEV.
>
> Aha, didn't think of pread()/pwrite(). Very interesting.

There are plenty of use cases for which pread()/pwrite()/splice() will be as fast or even much faster than mmap()+memcpy().

>
> I'd need to check what our VMM actually does, but as an initial
> reaction it feels like this might require a pretty significant rework in
> userspace. Maybe it's a good thing? Dunno. Maybe more important, those
> shared pages are used for virtio communications, so the cost of issuing
> syscalls every time the VMM needs to access the shared page will need to
> be considered...

Let's try actually counting syscalls and mode transitions, at least approximately.  For non-direct IO (DMA allocation on guest side, not straight to/from pagecache or similar):

Guest writes to shared DMA buffer.  Assume the guest is smart and reuses the buffer.
Guest writes descriptor to shared virtio ring.
Guest rings virtio doorbell, which causes an exit.
*** guest -> hypervisor -> host ***
host reads virtio ring (mmaped shared memory)
host does pread() to read the DMA buffer or reads mmapped buffer
host does the IO
resume guest
*** host -> hypervisor -> guest ***

This is essentially optimal in terms of transitions.  The data is copied on the guest side (which may well be mandatory depending on what guest userspace did to initiate the IO) and on the host (which may well be mandatory depending on what the host is doing with the data).

Now let's try straight-from-guest-pagecache or otherwise zero-copy on the guest side.  Without nondestructive changes, the guest needs a bounce buffer and it looks just like the above.  One extra copy, zero extra mode transitions.  With nondestructive changes, it's a bit more like physical hardware with an IOMMU:

Guest shares the page.
*** guest -> hypervisor ***
Hypervisor adds a PTE.  Let's assume we're being very optimal and the host is not synchronously notified.
*** hypervisor -> guest ***
Guest writes descriptor to shared virtio ring.
Guest rings virtio doorbell, which causes an exit.
*** guest -> hypervisor -> host ***
host reads virtio ring (mmaped shared memory)

mmap  *** syscall ***
host does the IO
munmap *** syscall, TLBI ***

resume guest
*** host -> hypervisor -> guest ***
Guest unshares the page.
*** guest -> hypervisor ***
Hypervisor removes PTE.  TLBI.
*** hypervisor -> guest ***

This is quite expensive.  For small IO, pread() or splice() in the host may be a lot faster.  Even for large IO, splice() may still win.


I can imagine clever improvements.  First, let's get rid of mmap() + munmap().  Instead use a special device mapping with special semantics, not regular memory.  (mmap and munmap are expensive even ignoring any arch and TLB stuff.)  The rule is that, if the page is shared, access works, and if private, access doesn't, but it's still mapped.  The hypervisor and the host cooperate to make it so.  Now it's more like:

Guest shares the page.
*** guest -> hypervisor ***
Hypervisor adds a PTE.  Let's assume we're being very optimal and the host is not synchronously notified.
*** hypervisor -> guest ***
Guest writes descriptor to shared virtio ring.
Guest rings virtio doorbell, which causes an exit.
*** guest -> hypervisor -> host ***
host reads virtio ring (mmaped shared memory)
memcpy(): just works without a fault
resume guest
*** host -> hypervisor -> guest ***
Guest unshares the page.
*** guest -> hypervisor ***
Hypervisor removes PTE.  TLBI.
*** hypervisor -> guest ***

That's *much* better.  On x86, it's still pretty terrible, but ARM64 is superior.  (For now.  I keep loudly asking Intel and AMD to catch up.  Hasn't happened yet.)

But we can improve it further by making this whole mess look like an IOMMU:


Guest shares the page by writing an IOPTE or however it works.
Guest writes descriptor to shared virtio ring.
Guest rings virtio doorbell, which causes an exit.
*** guest -> hypervisor -> host ***
host reads virtio ring (mmaped shared memory)

memcpy(): would fault to hypervisor, but the IOPTE scheme could be improved by having a ring listing recently added PTEs so the hypervisor could do it as part of the exit processing.

resume guest
*** host -> hypervisor -> guest ***
Guest unshares the page.
*** guest -> hypervisor ***
Hypervisor removes PTE.  TLBI.
*** hypervisor -> guest ***

Obviously considerable cleverness is needed to make a virt IOMMU like this work well, but still.

Anyway, my suggestion is that the fd backing proposal get slightly modified to get it ready for multiple subtypes of backing object, which should be a pretty minimal change.  Then, if someone actually needs any of this cleverness, it can be added later.  In the mean time, the pread()/pwrite()/splice() scheme is pretty good.
