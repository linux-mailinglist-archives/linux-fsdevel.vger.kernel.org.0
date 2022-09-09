Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF8F5B3F43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 21:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIITLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 15:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiIITLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:11:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FA9C0BD8;
        Fri,  9 Sep 2022 12:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84FA2B8256A;
        Fri,  9 Sep 2022 19:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E41AC433B5;
        Fri,  9 Sep 2022 19:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662750691;
        bh=SUgnHRqE57J9ijihjzghns114gPu46lDz6ObxsACSls=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=NnfCE4rlcwmQQcpvB+mhRsBr0rzh50pyIUa4C+etmVe/qS55Vw83aYPCuRPWZtzki
         VnvajzmJY7ZR7EuaY6N+IoPq2Ux1o/Ntp4XCNReCeio0JfKfbwK5kjBqN97ig3lzFE
         5IRjrFDxqZsbnqGY1vJbpHvetd9hy91Taa8EgM/g5ZzEOey/2i4qd604I3vfmYiN/g
         yLjKYPLOzCZ8CLL8ftW1R8Jol+bEF/uuGfKEuMbRRqILRNu/0MKwLKxOVKnpthPIqV
         DEwm6ntnNqxodg49PF9VGVU+rZd+rNC9xwcdBd7zrFxI/W/sqW6obpMP3iOXzcnMed
         EQEwNup4Q488g==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 553A027C005B;
        Fri,  9 Sep 2022 15:11:28 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Fri, 09 Sep 2022 15:11:28 -0400
X-ME-Sender: <xms:3Y8bY6W-KYrmAFI553F8rujXR0g64BgP6DLpnotxRF1FXtLNJ8HFBw>
    <xme:3Y8bY2mGIHOUYqrgPQoo6lCLblHQfRXn1TrwdrKu37BsJGaUl1q9KEsnmDthPnrkU
    H166w9VAMXv6wF6C60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedthedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeekuddthfelkeegtdelteeuieevkeegudduheevtdetieegheet
    ffelleduvddtueenucffohhmrghinhepihhnthgvlhdrtghomhdpmhgvmhdrphgrghgvne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugih
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvie
    efudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdr
    uhhs
X-ME-Proxy: <xmx:3Y8bY-boxyux9UHxTSpDjSQ_XMb8t9pN3tnUfCzsYYr-YmbSUrrfYQ>
    <xmx:3Y8bYxU6SKx_iHwkYWHhgjAFp228ubVUSNUw1K9UBfWNqpN08LyJKg>
    <xmx:3Y8bY0ldjzwm-xTSJ0MnLj-GuI65WGFYRayDMrmStHHIV_vywU2XFg>
    <xmx:4I8bY2CvMpUqEExrjUfE79Y1rQF_Xta75SFKNDsCa1iznWpscOiDs5SXkxE>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4802E31A0062; Fri,  9 Sep 2022 15:11:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <762581e4-a6bf-41d1-b0d3-72543153ffb1@www.fastmail.com>
In-Reply-To: <20220909143236.sznwzkpedldrlnn5@box.shutemov.name>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
 <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
 <95bd287b-d17f-fda8-58c9-20700b1e0c72@kernel.org>
 <20220909143236.sznwzkpedldrlnn5@box.shutemov.name>
Date:   Fri, 09 Sep 2022 12:11:05 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Hugh Dickins" <hughd@google.com>,
        "Chao Peng" <chao.p.peng@linux.intel.com>,
        "kvm list" <kvm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Sean Christopherson" <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        "Wanpeng Li" <wanpengli@tencent.com>,
        "Jim Mattson" <jmattson@google.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
        "Steven Price" <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Vishal Annapurve" <vannapurve@google.com>,
        "Yu Zhang" <yu.c.zhang@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "David Hildenbrand" <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        "Quentin Perret" <qperret@google.com>,
        "Michael Roth" <michael.roth@amd.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Muchun Song" <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM guest
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



On Fri, Sep 9, 2022, at 7:32 AM, Kirill A . Shutemov wrote:
> On Thu, Sep 08, 2022 at 09:48:35PM -0700, Andy Lutomirski wrote:
>> On 8/19/22 17:27, Kirill A. Shutemov wrote:
>> > On Thu, Aug 18, 2022 at 08:00:41PM -0700, Hugh Dickins wrote:
>> > > On Thu, 18 Aug 2022, Kirill A . Shutemov wrote:
>> > > > On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
>> > > > > 
>> > > > > If your memory could be swapped, that would be enough of a good reason
>> > > > > to make use of shmem.c: but it cannot be swapped; and although there
>> > > > > are some references in the mailthreads to it perhaps being swappable
>> > > > > in future, I get the impression that will not happen soon if ever.
>> > > > > 
>> > > > > If your memory could be migrated, that would be some reason to use
>> > > > > filesystem page cache (because page migration happens to understand
>> > > > > that type of memory): but it cannot be migrated.
>> > > > 
>> > > > Migration support is in pipeline. It is part of TDX 1.5 [1]. And swapping
>> > > > theoretically possible, but I'm not aware of any plans as of now.
>> > > > 
>> > > > [1] https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
>> > > 
>> > > I always forget, migration means different things to different audiences.
>> > > As an mm person, I was meaning page migration, whereas a virtualization
>> > > person thinks VM live migration (which that reference appears to be about),
>> > > a scheduler person task migration, an ornithologist bird migration, etc.
>> > > 
>> > > But you're an mm person too: you may have cited that reference in the
>> > > knowledge that TDX 1.5 Live Migration will entail page migration of the
>> > > kind I'm thinking of.  (Anyway, it's not important to clarify that here.)
>> > 
>> > TDX 1.5 brings both.
>> > 
>> > In TDX speak, mm migration called relocation. See TDH.MEM.PAGE.RELOCATE.
>> > 
>> 
>> This seems to be a pretty bad fit for the way that the core mm migrates
>> pages.  The core mm unmaps the page, then moves (in software) the contents
>> to a new address, then faults it in.  TDH.MEM.PAGE.RELOCATE doesn't fit into
>> that workflow very well.  I'm not saying it can't be done, but it won't just
>> work.
>
> Hm. From what I see we have all necessary infrastructure in place.
>
> Unmaping is NOP for inaccessible pages as it is never mapped and we have
> mapping->a_ops->migrate_folio() callback that allows to replace software
> copying with whatever is needed, like TDH.MEM.PAGE.RELOCATE.
>
> What do I miss?

Hmm, maybe this isn't as bad as I thought.

Right now, unless I've missed something, the migration workflow is to unmap (via try_to_migrate) all mappings, then migrate the backing store (with ->migrate_folio(), although it seems like most callers expect the actual copy to happen outside of ->migrate_folio(), and then make new mappings.  With the *current* (vma-based, not fd-based) model for KVM memory, this won't work -- we can't unmap before calling TDH.MEM.PAGE.RELOCATE.

But maybe it's actually okay with some care or maybe mild modifications with the fd-based model.  We don't have any mmaps, per se, to unmap for secret / INACCESSIBLE memory.  So maybe we can get all the way to ->migrate_folio() without zapping anything in the secure EPT and just call TDH-MEM.PAGE.RELOCATE from inside migrate_folio().  And there will be nothing to fault back in.  From the core code's perspective, it's like migrating a memfd that doesn't happen to have my mappings at the time.

--Andy
