Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EABB5E54FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 23:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiIUVLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 17:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiIUVLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:11:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567AD55094;
        Wed, 21 Sep 2022 14:11:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4410BB82369;
        Wed, 21 Sep 2022 21:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD3CC433C1;
        Wed, 21 Sep 2022 21:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663794687;
        bh=q5iTDoMb1h594m9zBAcQ294TqIVliTEQoMBfbSTQOEc=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=HXKQICEaWSNQF2IN43p5UTWR7wkEBhbRHnddHQoZkXz8gJLh7Pr2bkQPAxjcpnJi2
         0Q/h6CzriwchnUlmsO9BDrIPtn/TeLnrVo5uHkw+szXrG+6sXl1ElJp1xhSdyvhMlJ
         cuioDOWdEvguwOM6wEjHbayOspWvgVYmtrk92qmcaHWzfQCFkqJWQC2h1+eW5FaVCH
         Wv0Tu9JJEiRYwy9ADZliY6hVGdYUT8dEXk/XfHpcHKoPPq7vjZWjV2QbbCcjdLDi+Z
         vuZjF6LDsm0w768UHnwzYxUul0fXGQ4vzbQ9ilbulLqSISqwiHkJi3bQJ47+UV6Hyw
         mrdSIgubNRwXg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 277B227C0054;
        Wed, 21 Sep 2022 17:11:25 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Wed, 21 Sep 2022 17:11:25 -0400
X-ME-Sender: <xms:-n0rY_4N0LKpSTfU-17jxItIVA2IeOyeV3GBH-kTGeaQnD44QEGWsA>
    <xme:-n0rY05FRoGSPXzqMPaO0MmZQgUZpWgYxdjP4kFXdAHqngqCBvxsuyaZNtPNWtT0M
    maJP6ri53jokKJgZsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefuddgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:-n0rY2fud6xh0WVrheag-M-5En3oxyvmXPkXJRxC0S-XYaeJiPIqsw>
    <xmx:-n0rYwJ4GI3Nzi4ft0zhvleIXE5-DX0-OH5WjOjQhfMBWzMBrktPoA>
    <xmx:-n0rYzKpWKke8wVrjYykrrHICZQAPwgvRIuBwudPMdXnQbse-OJeWA>
    <xmx:_X0rYxkptztuCef_-KiMtVyhiKBRT0-vPWSHiG4dcD54DzNMZcfFTWwsQ6o>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C289931A0062; Wed, 21 Sep 2022 17:11:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <84e81d21-c800-4fd5-ad7c-f20bcdd7508b@www.fastmail.com>
In-Reply-To: <Yyi+l3+p9lbBAC4M@google.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <Yyi+l3+p9lbBAC4M@google.com>
Date:   Wed, 21 Sep 2022 14:10:51 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Sean Christopherson" <seanjc@google.com>,
        "David Hildenbrand" <david@redhat.com>
Cc:     "Chao Peng" <chao.p.peng@linux.intel.com>,
        "kvm list" <kvm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, "Paolo Bonzini" <pbonzini@redhat.com>,
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
        "Shuah Khan" <shuah@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
        "Steven Price" <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Vishal Annapurve" <vannapurve@google.com>,
        "Yu Zhang" <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        "Quentin Perret" <qperret@google.com>,
        "Michael Roth" <michael.roth@amd.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Muchun Song" <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        "Will Deacon" <will@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
        "Fuad Tabba" <tabba@google.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(please excuse any formatting disasters.  my internet went out as I was composing this, and i did my best to rescue it.)

On Mon, Sep 19, 2022, at 12:10 PM, Sean Christopherson wrote:
> +Will, Marc and Fuad (apologies if I missed other pKVM folks)
>
> On Mon, Sep 19, 2022, David Hildenbrand wrote:
>> On 15.09.22 16:29, Chao Peng wrote:
>> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> > 
>> > KVM can use memfd-provided memory for guest memory. For normal userspace
>> > accessible memory, KVM userspace (e.g. QEMU) mmaps the memfd into its
>> > virtual address space and then tells KVM to use the virtual address to
>> > setup the mapping in the secondary page table (e.g. EPT).
>> > 
>> > With confidential computing technologies like Intel TDX, the
>> > memfd-provided memory may be encrypted with special key for special
>> > software domain (e.g. KVM guest) and is not expected to be directly
>> > accessed by userspace. Precisely, userspace access to such encrypted
>> > memory may lead to host crash so it should be prevented.
>> 
>> Initially my thaught was that this whole inaccessible thing is TDX specific
>> and there is no need to force that on other mechanisms. That's why I
>> suggested to not expose this to user space but handle the notifier
>> requirements internally.
>> 
>> IIUC now, protected KVM has similar demands. Either access (read/write) of
>> guest RAM would result in a fault and possibly crash the hypervisor (at
>> least not the whole machine IIUC).
>
> Yep.  The missing piece for pKVM is the ability to convert from shared 
> to private
> while preserving the contents, e.g. to hand off a large buffer 
> (hundreds of MiB)
> for processing in the protected VM.  Thoughts on this at the bottom.
>
>> > This patch introduces userspace inaccessible memfd (created with
>> > MFD_INACCESSIBLE). Its memory is inaccessible from userspace through
>> > ordinary MMU access (e.g. read/write/mmap) but can be accessed via
>> > in-kernel interface so KVM can directly interact with core-mm without
>> > the need to map the memory into KVM userspace.
>> 
>> With secretmem we decided to not add such "concept switch" flags and instead
>> use a dedicated syscall.
>>
>
> I have no personal preference whatsoever between a flag and a dedicated syscall,
> but a dedicated syscall does seem like it would give the kernel a bit more
> flexibility.

The third option is a device node, e.g. /dev/kvm_secretmem or /dev/kvm_tdxmem or similar.  But if we need flags or other details in the future, maybe this isn't ideal.

>
>> What about memfd_inaccessible()? Especially, sealing and hugetlb are not
>> even supported and it might take a while to support either.
>
> Don't know about sealing, but hugetlb support for "inaccessible" memory 
> needs to
> come sooner than later.  "inaccessible" in quotes because we might want 
> to choose
> a less binary name, e.g. "restricted"?.
>
> Regarding pKVM's use case, with the shim approach I believe this can be done by
> allowing userspace mmap() the "hidden" memfd, but with a ton of restrictions
> piled on top.
>
> My first thought was to make the uAPI a set of KVM ioctls so that KVM 
> could tightly
> tightly control usage without taking on too much complexity in the 
> kernel, but
> working through things, routing the behavior through the shim itself 
> might not be
> all that horrific.
>
> IIRC, we discarded the idea of allowing userspace to map the "private" 
> fd because
> things got too complex, but with the shim it doesn't seem _that_ bad.

What's the exact use case?  Is it just to pre-populate the memory?

>
> E.g. on the memfd side:
>
>   1. The entire memfd must be mapped, and at most one mapping is allowed, i.e.
>      mapping is all or nothing.
>
>   2. Acquiring a reference via get_pfn() is disallowed if there's a mapping for
>      the restricted memfd.
>
>   3. Add notifier hooks to allow downstream users to further restrict things.
>
>   4. Disallow splitting VMAs, e.g. to force userspace to munmap() everything in
>      one shot.
>
>   5. Require that there are no outstanding references at munmap().  Or if this
>      can't be guaranteed by userspace, maybe add some way for userspace to wait
>      until it's ok to convert to private?  E.g. so that get_pfn() doesn't need
>      to do an expensive check every time.

Hmm.  I haven't looked at the code to see if this would really work, but I think this could be done more in line with how the rest of the kernel works by using the rmap infrastructure.  When the pKVM memfd is in not-yet-private mode, just let it be mmapped as usual (but don't allow any form of GUP or pinning).  Then have an ioctl to switch to to shared mode that takes locks or sets flags so that no new faults can be serviced and does unmap_mapping_range.

As long as the shim arranges to have its own vm_ops, I don't immediately see any reason this can't work.
