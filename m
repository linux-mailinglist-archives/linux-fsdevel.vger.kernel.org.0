Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC454F6B50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiDFUZG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 16:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiDFUYG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3274B1D41B1;
        Wed,  6 Apr 2022 11:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCDC461C57;
        Wed,  6 Apr 2022 18:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5A3C385A1;
        Wed,  6 Apr 2022 18:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649270562;
        bh=sbHbRXEyEAYhEDFwzan7utBqpNK0sjzefEArFgF8uSU=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=eIaWhMw6qdMVoRFxQeR1SfjCYwZy9RX4+1QgPmQTaYkMgXq5EQ0sAVb/ULadR9MI7
         LH+S/c+4WuHCz9BUADIJglVSfcRcc6WejwYyM8Zb7kxiMxjNjlQQDilGIN/w8F20LF
         hrAlrpaJiEnF7GwrtgY3GeH3IG43iicZf7iLsWrBPdjz0Xcg62zOdFu6x9zo7xgJk5
         hq2ap75faI5QFkM7ufk+5PP4JDHKHirOI6tOCxRHtxkvbVauUHCe7lAi4Fdoyzj8y9
         G3ucqOIFtsChrg/dqSy9ybRF2yetOLigWYzb0CjPhvgDFTZx/nxy8vUOVNf/cZzrqO
         oArXJrEdmbMlg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0C18527C005B;
        Wed,  6 Apr 2022 14:42:39 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Wed, 06 Apr 2022 14:42:40 -0400
X-ME-Sender: <xms:Ht9NYhmq5xzhyiIJCwoSNR5UKnnggxn-w-bA7jJiiVPF0uyVtVnVhQ>
    <xme:Ht9NYs3-dzZtMQe620UwGT8ssxHBBO-eBkOnyr5HtekaozhZyGx33dQF5TpjmUy85
    LbHHkaqaYX2JUhBy4I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejiedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:Ht9NYnoDYKLmq3-m68aE4ZmTtDuPp5nNnCT76TQ2-A9bkXUgsPDoLQ>
    <xmx:Ht9NYhmDXKudHVFzfFNB9vrnlRpFqFnPc15MUqY9W5FRFPjkhgnWOw>
    <xmx:Ht9NYv0LfNldKQsbPRd1ZzGo2WkQjQkgAIaqEiMoePxTGJRS43r7JA>
    <xmx:H99NYqX58bpe62swpvglNF4SOMgzeqaX78xe7NzkfeRGX_q08j8zpA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8341B21E006E; Wed,  6 Apr 2022 14:42:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-385-g3a17909f9e-fm-20220404.001-g3a17909f
Mime-Version: 1.0
Message-Id: <4ae11ddc-0fe6-4644-a30e-006d99dba456@www.fastmail.com>
In-Reply-To: <YkyKywkQYbr9U0CA@google.com>
References: <YkQzfjgTQaDd2E2T@google.com> <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com> <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com>
 <54acbba9-f4fd-48c1-9028-d596d9f63069@www.fastmail.com>
 <YkyKywkQYbr9U0CA@google.com>
Date:   Wed, 06 Apr 2022 11:42:17 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Sean Christopherson" <seanjc@google.com>
Cc:     "Quentin Perret" <qperret@google.com>,
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



On Tue, Apr 5, 2022, at 11:30 AM, Sean Christopherson wrote:
> On Tue, Apr 05, 2022, Andy Lutomirski wrote:

>
>> resume guest
>> *** host -> hypervisor -> guest ***
>> Guest unshares the page.
>> *** guest -> hypervisor ***
>> Hypervisor removes PTE.  TLBI.
>> *** hypervisor -> guest ***
>> 
>> Obviously considerable cleverness is needed to make a virt IOMMU like this
>> work well, but still.
>> 
>> Anyway, my suggestion is that the fd backing proposal get slightly modified
>> to get it ready for multiple subtypes of backing object, which should be a
>> pretty minimal change.  Then, if someone actually needs any of this
>> cleverness, it can be added later.  In the mean time, the
>> pread()/pwrite()/splice() scheme is pretty good.
>
> Tangentially related to getting private-fd ready for multiple things, 
> what about
> implementing the pread()/pwrite()/splice() scheme in pKVM itself?  I.e. 
> read() on
> the VM fd, with the offset corresponding to gfn in some way.
>

Hmm, could make sense.
