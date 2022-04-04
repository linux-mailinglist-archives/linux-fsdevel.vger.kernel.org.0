Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F824F1F5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 00:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbiDDWwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 18:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbiDDWvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25B162105;
        Mon,  4 Apr 2022 15:05:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F63E615E9;
        Mon,  4 Apr 2022 22:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527C5C34110;
        Mon,  4 Apr 2022 22:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649109902;
        bh=crI8OWa/ILQsosVqMgWDeCCHWKp1heV2rpDD9+ltpjk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=VSS0WYvCh8U/wTA1tky+XNuhgT9ZBOQSihN2yC977jGLr7A4FIdpX8DHWg3Xwp+94
         4mnoqR12GB1qEYr4lsd2B0DWz0J7J+6xxdg1XLixgxZZfw7318LkINdU3v8BPjvGJ7
         DArHMpmCjlvsLUTajVXcgDPMxNYV0xVSyCHhluHKuMFkYjr640tISjOj3dKwiy2rgX
         S1/PXqn3kPkcqjNn62evu/NVfVHISL+lgZEnNdXsayL5cm7khfiVfUS6F2h/kIoOA4
         VJ5scAYLwR0ySDPXZx0xV5V5spGuHRNORpc3PFFnnQT0h0zKa483p5VIQnW08XKVcK
         A5ySxn3g4LBxQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id E91D827C005C;
        Mon,  4 Apr 2022 18:04:59 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Mon, 04 Apr 2022 18:04:59 -0400
X-ME-Sender: <xms:imtLYtbmuXBb-CR_X_doiTrPKcKWg4NNZfEo0QSYuGGNzrWlFCh8ag>
    <xme:imtLYkapya1yCRkOmevv2zLb3QY9mqtqV1FsUEiD7QcwgBazL00LiEzuVdvBBAFMk
    SMuE79NU7zn4AMtg_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejfedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:imtLYv9O2uTJPGfIAprEk78SSKii49ihDteleFopSC9LOBdDLc7JNA>
    <xmx:imtLYroo5M1o1eUy4GHtpHG0qQT3ccZnrnE5qrgORNPjETQmuS01Zg>
    <xmx:imtLYoo3eLpLZOIqK255uDXkBNwKmkll3HfP2NPulU8SHrKPTL1f2Q>
    <xmx:i2tLYlLE5fv_MDSQnedDEY1S9wLK9aHDsm-OZcMYWBwQp1uIEZI2kg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B623D21E0073; Mon,  4 Apr 2022 18:04:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-385-g3a17909f9e-fm-20220404.001-g3a17909f
Mime-Version: 1.0
Message-Id: <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
In-Reply-To: <Ykslo2eo2eRXrpFR@google.com>
References: <YkH32nx+YsJuUbmZ@google.com> <YkIFW25WgV2WIQHb@google.com>
 <YkM7eHCHEBe5NkNH@google.com> <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
 <YkQzfjgTQaDd2E2T@google.com> <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com> <Ykslo2eo2eRXrpFR@google.com>
Date:   Mon, 04 Apr 2022 15:04:17 -0700
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



On Mon, Apr 4, 2022, at 10:06 AM, Sean Christopherson wrote:
> On Mon, Apr 04, 2022, Quentin Perret wrote:
>> On Friday 01 Apr 2022 at 12:56:50 (-0700), Andy Lutomirski wrote:
>> FWIW, there are a couple of reasons why I'd like to have in-place
>> conversions:
>> 
>>  - one goal of pKVM is to migrate some things away from the Arm
>>    Trustzone environment (e.g. DRM and the likes) and into protected VMs
>>    instead. This will give Linux a fighting chance to defend itself
>>    against these things -- they currently have access to _all_ memory.
>>    And transitioning pages between Linux and Trustzone (donations and
>>    shares) is fast and non-destructive, so we really do not want pKVM to
>>    regress by requiring the hypervisor to memcpy things;
>
> Is there actually a _need_ for the conversion to be non-destructive?  
> E.g. I assume
> the "trusted" side of things will need to be reworked to run as a pKVM 
> guest, at
> which point reworking its logic to understand that conversions are 
> destructive and
> slow-ish doesn't seem too onerous.
>
>>  - it can be very useful for protected VMs to do shared=>private
>>    conversions. Think of a VM receiving some data from the host in a
>>    shared buffer, and then it wants to operate on that buffer without
>>    risking to leak confidential informations in a transient state. In
>>    that case the most logical thing to do is to convert the buffer back
>>    to private, do whatever needs to be done on that buffer (decrypting a
>>    frame, ...), and then share it back with the host to consume it;
>
> If performance is a motivation, why would the guest want to do two 
> conversions
> instead of just doing internal memcpy() to/from a private page?  I 
> would be quite
> surprised if multiple exits and TLB shootdowns is actually faster, 
> especially at
> any kind of scale where zapping stage-2 PTEs will cause lock contention 
> and IPIs.

I don't know the numbers or all the details, but this is arm64, which is a rather better architecture than x86 in this regard.  So maybe it's not so bad, at least in very simple cases, ignoring all implementation details.  (But see below.)  Also the systems in question tend to have fewer CPUs than some of the massive x86 systems out there.

If we actually wanted to support transitioning the same page between shared and private, though, we have a bit of an awkward situation.  Private to shared is conceptually easy -- do some bookkeeping, reconstitute the direct map entry, and it's done.  The other direction is a mess: all existing uses of the page need to be torn down.  If the page has been recently used for DMA, this includes IOMMU entries.

Quentin: let's ignore any API issues for now.  Do you have a concept of how a nondestructive shared -> private transition could work well, even in principle?  The best I can come up with is a special type of shared page that is not GUP-able and maybe not even mmappable, having a clear option for transitions to fail, and generally preventing the nasty cases from happening in the first place.

Maybe there could be a special mode for the private memory fds in which specific pages are marked as "managed by this fd but actually shared".  pread() and pwrite() would work on those pages, but not mmap().  (Or maybe mmap() but the resulting mappings would not permit GUP.)  And transitioning them would be a special operation on the fd that is specific to pKVM and wouldn't work on TDX or SEV.

Hmm.  Sean and Chao, are we making a bit of a mistake by making these fds technology-agnostic?  That is, would we want to distinguish between a TDX backing fd, a SEV backing fd, a software-based backing fd, etc?  API-wise this could work by requiring the fd to be bound to a KVM VM instance and possibly even configured a bit before any other operations would be allowed.

(Destructive transitions nicely avoid all the nasty cases.  If something is still pinning a shared page when it's "transitioned" to private (really just replaced with a new page), then the old page continues existing for as long as needed as a separate object.)
