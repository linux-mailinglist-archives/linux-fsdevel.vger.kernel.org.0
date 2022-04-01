Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7334EFAA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 21:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351155AbiDAT7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 15:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350329AbiDAT7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:59:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735BC208245;
        Fri,  1 Apr 2022 12:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23C3CB82635;
        Fri,  1 Apr 2022 19:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD89BC34111;
        Fri,  1 Apr 2022 19:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648843036;
        bh=g4Or6vlnQ5XPFOlbOvyFGMvehoU1w6Tr33vBEF06cv4=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=kUAF1W6opB6kX4aqHlrwqR4mizGnR/LCCRP2w89k7wNaETPt2sgVJyFtrqbjm3i5S
         e5XCLsZejvIOaJZJsuCmx2v1E8LpTcZ0q0wecQAdgwFQLn/VJCRsgW/k3ueJUaECsX
         4OerVqkd94oCxK0suf9ng8r6FFbIneHH99uAy0fLXVkzY+zpT+3DR6Q0JpvX+DBdke
         1uoUBEr+qj/Yk6Vf0YyBfZopwqQeCr+prjwk9Yx1mu3FLvPuyg+mhWHa0w8mA11WSI
         s4dzbUfILFfinHBykc2QAbio9JC9mObxejFCM8k4D2b+QlrRwACD6WToFkfZb3L9Z1
         u1RC2bu92QzxA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4990827C0054;
        Fri,  1 Apr 2022 15:57:14 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Fri, 01 Apr 2022 15:57:14 -0400
X-ME-Sender: <xms:GFlHYiRokfAQEOXS3JGVQ8fGEt9aARJbPyMM3ymgS2p4KiiRM0LYyA>
    <xme:GFlHYnzLn5LXF0Y7iJiXJZD1GYvvbWvvTWmoH3r3L8GGKqyKyHXaxNm38fZUMC73C
    sBCFRvt0e5DrZ7B_zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiiedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:GFlHYv1jixSdphTgcgBt4k3ApxFLLREmwzVtH2R4FpXJdYAzolT8DQ>
    <xmx:GFlHYuBMTtOSj8Tvkpa1ZxH5VAnOs_iojIWHPKc2ofrldE_VY-TwKg>
    <xmx:GFlHYri_K6w69VmxOC5PmjtQo9sfLoKQOJBISmJk3ApiuCpGFiiQXA>
    <xmx:GllHYkBzqd9lROHtGLpI27JhxgidDn8BgzezBQqjYAPE7wh_2Gh2xg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 39BD021E0073; Fri,  1 Apr 2022 15:57:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
In-Reply-To: <YkcTTY4YjQs5BRhE@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <YjyS6A0o4JASQK+B@google.com> <YkHspg+YzOsbUaCf@google.com>
 <YkH32nx+YsJuUbmZ@google.com> <YkIFW25WgV2WIQHb@google.com>
 <YkM7eHCHEBe5NkNH@google.com> <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
 <YkQzfjgTQaDd2E2T@google.com> <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
Date:   Fri, 01 Apr 2022 12:56:50 -0700
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 1, 2022, at 7:59 AM, Quentin Perret wrote:
> On Thursday 31 Mar 2022 at 09:04:56 (-0700), Andy Lutomirski wrote:


> To answer your original question about memory 'conversion', the key
> thing is that the pKVM hypervisor controls the stage-2 page-tables for
> everyone in the system, all guests as well as the host. As such, a page
> 'conversion' is nothing more than a permission change in the relevant
> page-tables.
>

So I can see two different ways to approach this.

One is that you split the whole address space in half and, just like SEV and TDX, allocate one bit to indicate the shared/private status of a page.  This makes it work a lot like SEV and TDX.

The other is to have shared and private pages be distinguished only by their hypercall history and the (protected) page tables.  This saves some address space and some page table allocations, but it opens some cans of worms too.  In particular, the guest and the hypervisor need to coordinate, in a way that the guest can trust, to ensure that the guest's idea of which pages are private match the host's.  This model seems a bit harder to support nicely with the private memory fd model, but not necessarily impossible.

Also, what are you trying to accomplish by having the host userspace mmap private pages?  Is the idea that multiple guest could share the same page until such time as one of them tries to write to it?  That would be kind of like having a third kind of memory that's visible to host and guests but is read-only for everyone.  TDX and SEV can't support this at all (a private page belongs to one guest and one guest only, at least in SEV and in the current TDX SEAM spec).  I imagine that this could be supported with private memory fds with some care without mmap, though -- the host could still populate the page with memcpy.  Or I suppose a memslot could support using MAP_PRIVATE fds and have approximately the right semantics.

--Andy


