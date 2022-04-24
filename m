Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D73150D3C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 19:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiDXRDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 13:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiDXRDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 13:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CFCAE72
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Apr 2022 10:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE2B1611DD
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Apr 2022 17:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CDFC385A9;
        Sun, 24 Apr 2022 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650819602;
        bh=Je+h7tOqeRuiQPlVHJ9YBtSjYKQSsE87o9H6bqNhv0E=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=LQiLb34FBw2eNgmoSiK231PONOUqKINkvAm71Hqa/6IFcH84IBd4KI62BNG2mLhtK
         Hc6wfzDdol11Q6iTwsjdogfokTjyEWWEbGSpsOx/knOJKp6Crx5ySz6ZBPNfCPm2Y2
         UTOM8YD+BmK8eAmsrEjDxw20mEt5bF7RNwdoAAbcP7G3bq3wsJBVcC+ket5QCp7pNZ
         ebwBj9BNaRZhioAXdPrTG0cP2ypE2dSneAE2Y4RaBLyhY3E0B2q6+EJuUHx1fwlqL9
         ky9DUb3woG18oxgarN9knFcnkhJA5NdzVOb2xc+hnzYweKSFCn+6GsqSZcJd4W0g4C
         eLcYkopG6nWTg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id AF9FB27C0054;
        Sun, 24 Apr 2022 12:59:59 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Sun, 24 Apr 2022 12:59:59 -0400
X-ME-Sender: <xms:DYJlYrS34FbKgFIeuLj_dSMvkd5cU95kEUVKwMNEB6sujYQvoPVv6Q>
    <xme:DYJlYswLoJzXo6S6_R7s1t-GiUI4O6DLQ-Pd_h4VfsSNC7qvDxGEUISicXFj94Pnp
    ZNy6B9ZgrmKpY1sYlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:DYJlYg2mLjrVZeMpqDRGXmRBOA-ECqlSFMjTE8uGdMFCztXmSs1Oww>
    <xmx:DYJlYrDN603TmyI_zfJc_c4WIOl52Lr3VQyhal9I5Eb6ECdOYdjpsg>
    <xmx:DYJlYkh4toKPkrvr3za3g-nANRCLI8UWxf7YtZx3gqdjE5hym31nCA>
    <xmx:D4JlYtA1fc6cjZhfnkcH18sWUIyRZ7lxNJCXAb7CsWUmjH9hBozjjg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5AA8821E006E; Sun, 24 Apr 2022 12:59:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-569-g7622ad95cc-fm-20220421.002-g7622ad95
Mime-Version: 1.0
Message-Id: <3b99f157-0f30-4b30-8399-dd659250ab8d@www.fastmail.com>
In-Reply-To: <20220422105612.GB61987@chaop.bj.intel.com>
References: <YkQzfjgTQaDd2E2T@google.com> <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com> <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com> <YkyEaYiL0BrDYcZv@google.com>
 <20220422105612.GB61987@chaop.bj.intel.com>
Date:   Sun, 24 Apr 2022 09:59:37 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Chao Peng" <chao.p.peng@linux.intel.com>,
        "Sean Christopherson" <seanjc@google.com>
Cc:     "Quentin Perret" <qperret@google.com>,
        "Steven Price" <steven.price@arm.com>,
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Fri, Apr 22, 2022, at 3:56 AM, Chao Peng wrote:
> On Tue, Apr 05, 2022 at 06:03:21PM +0000, Sean Christopherson wrote:
>> On Tue, Apr 05, 2022, Quentin Perret wrote:
>> > On Monday 04 Apr 2022 at 15:04:17 (-0700), Andy Lutomirski wrote:
>     Only when the register succeeds, the fd is
>     converted into a private fd, before that, the fd is just a normal (shared)
>     one. During this conversion, the previous data is preserved so you can put
>     some initial data in guest pages (whether the architecture allows this is
>     architecture-specific and out of the scope of this patch).

I think this can be made to work, but it will be awkward.  On TDX, for example, what exactly are the semantics supposed to be?  An error code if the memory isn't all zero?  An error code if it has ever been written?

Fundamentally, I think this is because your proposed lifecycle for these memfiles results in a lightweight API but is awkward for the intended use cases.  You're proposing, roughly:

1. Create a memfile. 

Now it's in a shared state with an unknown virt technology.  It can be read and written.  Let's call this state BRAND_NEW.

2. Bind to a VM.

Now it's an a bound state.  For TDX, for example, let's call the new state BOUND_TDX.  In this state, the TDX rules are followed (private memory can't be converted, etc).

The problem here is that the BOUND_NEW state allows things that are nonsensical in TDX, and the binding step needs to invent some kind of semantics for what happens when binding a nonempty memfile.


So I would propose a somewhat different order:

1. Create a memfile.  It's in the UNBOUND state and no operations whatsoever are allowed except binding or closing.

2. Bind the memfile to a VM (or at least to a VM technology).  Now it's in the initial state appropriate for that VM.

For TDX, this completely bypasses the cases where the data is prepopulated and TDX can't handle it cleanly.  For SEV, it bypasses a situation in which data might be written to the memory before we find out whether that data will be unreclaimable or unmovable.


----------------------------------------------

Now I have a question, since I don't think anyone has really answered it: how does this all work with SEV- or pKVM-like technologies in which private and shared pages share the same address space?  I sounds like you're proposing to have a big memfile that contains private and shared pages and to use that same memfile as pages are converted back and forth.  IO and even real physical DMA could be done on that memfile.  Am I understanding correctly?

If so, I think this makes sense, but I'm wondering if the actual memslot setup should be different.  For TDX, private memory lives in a logically separate memslot space.  For SEV and pKVM, it doesn't.  I assume the API can reflect this straightforwardly.

And the corresponding TDX question: is the intent still that shared pages aren't allowed at all in a TDX memfile?  If so, that would be the most direct mapping to what the hardware actually does.

--Andy
