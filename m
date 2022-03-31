Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358A84EDE57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbiCaQHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 12:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbiCaQHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:07:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A6F541A5;
        Thu, 31 Mar 2022 09:05:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10D2D60FA0;
        Thu, 31 Mar 2022 16:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CA6C340F3;
        Thu, 31 Mar 2022 16:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648742723;
        bh=EdQ/DEWAOGhT7tt+PGpjGVQZwkU6Zx+llTp2J7Hfjk8=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=AbT+KHC1V+lTMkYInG9LQqRURe90y/UbGDjjiL4tm9oDicV7aq2L2MyRc1+Bt4ab0
         8R1XTmouglcqHACbStGRGC2oziEgb4AsQAnsGavRPyUlSVnarFijflXafs5HWWiPR8
         enxZZueAw0njiu1O405t6gw04XdJYB07O2YmyGERu8TP3F4Zt1g4ZYvWStfZzZJUY7
         kyyYZSmzt7QnWSpr70cE6zChHoq74KrH66O64TB/3SCgGaBRRiFMi9wa/Lmpy6lnqI
         rEDEvwZEaUJcB11Gtv6+YzLd+bReFKoeXygrA2jngV/y4WtTelUKK63vpON+f6NxeL
         XjPwr/fPsgwsQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2048527C0054;
        Thu, 31 Mar 2022 12:05:21 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Thu, 31 Mar 2022 12:05:21 -0400
X-ME-Sender: <xms:PdFFYgUg32JJFnR43IlWyP5tqL48VPSDWqIGAPFk_EuDnM8sL53vlg>
    <xme:PdFFYkk8V7JAiDZdQA_7yH92ZoHYKqx2idme9aHdl_AkOkwV-D2pXUdflc-WuwFT2
    wEY7dkr0mZLMOMvz-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:PdFFYkaZ-ifYsxvUe9nhIfND0AFFy88cPupQZQ-GrHF_2AcXGSgDug>
    <xmx:PdFFYvWS03BTA9XHA3F19wYavhU8xBc6fblWgP5TjcJPbdDT94sJXg>
    <xmx:PdFFYql0PUzWFfRik10UtiUvlVvW0DwLv4p-xTwH6hh-9ov6iKP76g>
    <xmx:QdFFYtHRj1ZwNh7yvY-n6ex-B4rIcW4eLEXmCPlV_OBvm3MxPkK3_g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 99E0F21E0073; Thu, 31 Mar 2022 12:05:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
In-Reply-To: <YkSaUQX89ZEojsQb@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <YjyS6A0o4JASQK+B@google.com> <YkHspg+YzOsbUaCf@google.com>
 <YkH32nx+YsJuUbmZ@google.com> <YkIFW25WgV2WIQHb@google.com>
 <YkM7eHCHEBe5NkNH@google.com> <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
 <YkQzfjgTQaDd2E2T@google.com> <YkSaUQX89ZEojsQb@google.com>
Date:   Thu, 31 Mar 2022 09:04:56 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Sean Christopherson" <seanjc@google.com>,
        "Quentin Perret" <qperret@google.com>
Cc:     "Steven Price" <steven.price@arm.com>,
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

On Wed, Mar 30, 2022, at 10:58 AM, Sean Christopherson wrote:
> On Wed, Mar 30, 2022, Quentin Perret wrote:
>> On Wednesday 30 Mar 2022 at 09:58:27 (+0100), Steven Price wrote:
>> > On 29/03/2022 18:01, Quentin Perret wrote:
>> > > Is implicit sharing a thing? E.g., if a guest makes a memory access in
>> > > the shared gpa range at an address that doesn't have a backing memslot,
>> > > will KVM check whether there is a corresponding private memslot at the
>> > > right offset with a hole punched and report a KVM_EXIT_MEMORY_ERROR? Or
>> > > would that just generate an MMIO exit as usual?
>> > 
>> > My understanding is that the guest needs some way of tagging whether a
>> > page is expected to be shared or private. On the architectures I'm aware
>> > of this is done by effectively stealing a bit from the IPA space and
>> > pretending it's a flag bit.
>> 
>> Right, and that is in fact the main point of divergence we have I think.
>> While I understand this might be necessary for TDX and the likes, this
>> makes little sense for pKVM. This would effectively embed into the IPA a
>> purely software-defined non-architectural property/protocol although we
>> don't actually need to: we (pKVM) can reasonably expect the guest to
>> explicitly issue hypercalls to share pages in-place. So I'd be really
>> keen to avoid baking in assumptions about that model too deep in the
>> host mm bits if at all possible.
>
> There is no assumption about stealing PA bits baked into this API.  Even within
> x86 KVM, I consider it a hard requirement that the common flows not assume the
> private vs. shared information is communicated through the PA.

Quentin, I think we might need a clarification.  The API in this patchset indeed has no requirement that a PA bit distinguish between private and shared, but I think it makes at least a weak assumption that *something*, a priori, distinguishes them.  In particular, there are private memslots and shared memslots, so the logical flow of resolving a guest memory access looks like:

1. guest accesses a GVA

2. read guest paging structures

3. determine whether this is a shared or private access

4. read host (KVM memslots and anything else, EPT, NPT, RMP, etc) structures accordingly.  In particular, the memslot to reference is different depending on the access type.

For TDX, this maps on to the fd-based model perfectly: the host-side paging structures for the shared and private slots are completely separate.  For SEV, the structures are shared and KVM will need to figure out what to do in case a private and shared memslot overlap.  Presumably it's sufficient to declare that one of them wins, although actually determining which one is active for a given GPA may involve checking whether the backing store for a given page actually exists.

But I don't understand pKVM well enough to understand how it fits in.  Quentin, how is the shared vs private mode of a memory access determined?  How do the paging structures work?  Can a guest switch between shared and private by issuing a hypercall without changing any guest-side paging structures or anything else?

It's plausible that SEV and (maybe) pKVM would be better served if memslots could be sparse or if there was otherwise a direct way for host userspace to indicate to KVM which address ranges are actually active (not hole-punched) in a given memslot or to otherwise be able to make a rule that two different memslots (one shared and one private) can't claim the same address.
