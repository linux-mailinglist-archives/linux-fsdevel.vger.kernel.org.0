Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE72E677F81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 16:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjAWPU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 10:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjAWPUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:20:47 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E11EFE5;
        Mon, 23 Jan 2023 07:20:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 16807581DF8;
        Mon, 23 Jan 2023 10:18:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 23 Jan 2023 10:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1674487090; x=
        1674494290; bh=5kISd+ukDqvXoyuUF5unW5X7Gt8EcZaBqFcmuVPXAbs=; b=N
        Axston+PNN+fEVioeD1V/lezUKAdjHfU9WuPeXM7fHsZvGjnyyO2FVQ+2IoofTD3
        jrYl4JgKxDGXYTYKPMymgiEMsC6peKta1bphKVU1+UBG482ZbUobglIP4uLXLjvh
        iz8svKCfNXQ9/sb9i3m+ZwF5ZaddAN//4EqhB6TPnfp+I0l6pe5vuwRi/QBKI2DA
        cqTe9fYYC3tH3u6FnXRVcaV+S9g7rlE4KqmpdJeD8mCh158fZwqoQlGQz8gdR2RT
        TZ5v5u6AHEuv162fcDTraiqMcKEIhKISRcihlR2d/22rn6pKJO8WIigCLYMAcka4
        KPN16U9YlPtzjLX8HdEjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674487090; x=
        1674494290; bh=5kISd+ukDqvXoyuUF5unW5X7Gt8EcZaBqFcmuVPXAbs=; b=Z
        3pTD1YXyo5r/MKhvY5k85GR656ULBrcYsZOWggTr2ZC9w1c1I7Z+bY6sDSWgAvWJ
        pM9aBZtww7dRFxUv0HoqMx4JpXc19n0xHG4h7LLGQ/08CnSbx2/q5hLy1/xprtl9
        qgZlahCrM5wO2hvkE4Tfk+OSCUq8ywtwPX2h8kxtc5LDqf8FTDbrxmiXwVaQVDxJ
        xy3rZPsc21uBW4nhTe5K7Yh1Z/O1Dh7LFReqE6wP2gfn1gkC7JRM4oIl+QfDAPt2
        WTHg5DxjkMM4wlaD4/wKzLCzEXARGfJLoC5MplhMLol16WrJvJqE5JOjumf6rDBs
        A9ScnDZUD2WKfbk/pDqkw==
X-ME-Sender: <xms:L6XOY4oW7cZ0KsMoQyyuZwGY6jxIFenT4PMiIaNSantfsE6uWTbs7Q>
    <xme:L6XOY-qwYHDktIPazniKsn1AzUL4NopVlq5iIgFWK6yLtyjtue5J0HMAdGfxcfvIb
    CUpYKUzjwhHy2gSVpo>
X-ME-Received: <xmr:L6XOY9PnNbOfZeVRWc98vtlCAHFsQcqdhzKjr484mTEUBaeQgt7coobZR7I4Vk5VDQZ57g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddukedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvdfgjeffteevffetleefgfehjefffefftdeh
    ffeljeevfffgffefueegfeeuuefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:L6XOY_6yorHsS7PDkOUT35AZUSKjesOd8aMtN7N5ktN03p3PIE_yAg>
    <xmx:L6XOY34uglE0JUtYx3xfFAjCtULHppwxo-Xi9yXUcwt4A53OqeQTJg>
    <xmx:L6XOY_ibQUsgnKvUQ-qOWqsyFDdeARW97L0u0i9DUtUP8-Pi_dwYWA>
    <xmx:MqXOY6cPQD-FBOYGYtkZJfYS69Xrq4oiYU-q5LMz6mcdWQpO5Xl6rA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jan 2023 10:18:06 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 45D7C10352A; Mon, 23 Jan 2023 18:18:03 +0300 (+03)
Date:   Mon, 23 Jan 2023 18:18:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Huang, Kai" <kai.huang@intel.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "tabba@google.com" <tabba@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "qperret@google.com" <qperret@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "vannapurve@google.com" <vannapurve@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20230123151803.lwbjug6fm45olmru@box>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
 <20221219075313.GB1691829@chaop.bj.intel.com>
 <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
 <20221220072228.GA1724933@chaop.bj.intel.com>
 <126046ce506df070d57e6fe5ab9c92cdaf4cf9b7.camel@intel.com>
 <20221221133905.GA1766136@chaop.bj.intel.com>
 <b898e28d7fd7182e5d069646f84b650c748d9ca2.camel@intel.com>
 <010a330c-a4d5-9c1a-3212-f9107d1c5f4e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <010a330c-a4d5-9c1a-3212-f9107d1c5f4e@suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 03:03:45PM +0100, Vlastimil Babka wrote:
> On 12/22/22 01:37, Huang, Kai wrote:
> >>> I argue that this page pinning (or page migration prevention) is not
> >>> tied to where the page comes from, instead related to how the page will
> >>> be used. Whether the page is restrictedmem backed or GUP() backed, once
> >>> it's used by current version of TDX then the page pinning is needed. So
> >>> such page migration prevention is really TDX thing, even not KVM generic
> >>> thing (that's why I think we don't need change the existing logic of
> >>> kvm_release_pfn_clean()). 
> >>>
> > This essentially boils down to who "owns" page migration handling, and sadly,
> > page migration is kinda "owned" by the core-kernel, i.e. KVM cannot handle page
> > migration by itself -- it's just a passive receiver.
> > 
> > For normal pages, page migration is totally done by the core-kernel (i.e. it
> > unmaps page from VMA, allocates a new page, and uses migrate_pape() or a_ops-
> >> migrate_page() to actually migrate the page).
> > In the sense of TDX, conceptually it should be done in the same way. The more
> > important thing is: yes KVM can use get_page() to prevent page migration, but
> > when KVM wants to support it, KVM cannot just remove get_page(), as the core-
> > kernel will still just do migrate_page() which won't work for TDX (given
> > restricted_memfd doesn't have a_ops->migrate_page() implemented).
> > 
> > So I think the restricted_memfd filesystem should own page migration handling,
> > (i.e. by implementing a_ops->migrate_page() to either just reject page migration
> > or somehow support it).
> 
> While this thread seems to be settled on refcounts already, just wanted
> to point out that it wouldn't be ideal to prevent migrations by
> a_ops->migrate_page() rejecting them. It would mean cputime wasted (i.e.
> by memory compaction) by isolating the pages for migration and then
> releasing them after the callback rejects it (at least we wouldn't waste
> time creating and undoing migration entries in the userspace page tables
> as there's no mmap). Elevated refcount on the other hand is detected
> very early in compaction so no isolation is attempted, so from that
> aspect it's optimal.

Hm. Do we need a new hook in a_ops to check if the page is migratable
before going with longer path to migrate_page().

Or maybe add AS_UNMOVABLE?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
