Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA4278C22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 17:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgIYPH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 11:07:26 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50581 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729152AbgIYPGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:06:22 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 11:06:20 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6C28D580762;
        Fri, 25 Sep 2020 10:57:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 25 Sep 2020 10:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=tBfuOWmQyjKgArCfu4khNo2TUG7
        Jq21FgCLcBIcnmPM=; b=OofIQppgkot+WhAGmGPKk5hZgjNlpN1ZlHwJkZhHUT7
        KzQ9a4UKLvBtvt6IoY28ep/w/+2zSquvjNGRBmkSersamyUPK4mq6bGc213GAiGs
        6eeA6co4G2jngyV6y9+g8szoci4GiiwwXywXX2pXq0HGjzmMhlmRWxQ85LK/DlDy
        irsPbph5wkukocpS6KgwRtiTKpYoXd3eKdxCN9qwKIkQcRRXIio+zFQ2SjqkppTg
        SNQPkGiduZegcLFBIHP5gJ/Op/FSZLeDDXJiOr9hfVgoldvcVMrRECA9TV6Wq7zO
        8FAbll8jR/Sd8TZyP6RpX6gZdv/A69N8+b8xGORjw1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=tBfuOW
        mQyjKgArCfu4khNo2TUG7Jq21FgCLcBIcnmPM=; b=O2AlydY1ltQyDVNghirgyE
        d0O51zrG8EUimzMadviff/NiqC0auMDDpsNj82EjtYhLCHLnvp4ul7cmJcKB4oic
        8GyaGwvleCXSsdBrsydeqkvzbq2T7kD4/ki04+EPu9S3o67WbG3C4srDADzAbfLV
        SaqsEs/JPQPxAl+TMoyLW00k6FlCJFMhhZSC9xeH5+0jlcUcku9NsJuXufMDdzoq
        zdAtNnQpSuuO9acwwrKLSyqcC1vJ24Bg4hY3bq8wGRJsi/GvmWV6uSzubM/akmk0
        XCtdH3b4xnADHi4BE95Cgt9gxaWKV/9k1KSsSHPJtWhz0FVMgsaL4L1E5bop9FyA
        ==
X-ME-Sender: <xms:UwVuXzT2_EVK-X89sY8bB0QEc5kSSYKtd5Y6-1axvefCEYWOlYSnYA>
    <xme:UwVuX0yozWkEYrLjnjNMdRGhiQbd_yK2RWC7ovDaSPkcaNL6mvOJ2S11sWTDI9fTG
    93ab4J4YjRsXoIH6_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghhohcu
    tehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrfgrth
    htvghrnhepgeekfeejgeektdejgfefudelkeeuteejgefhhfeugffffeelheegieefvdfg
    tefhnecukfhppedukeegrdduieejrddvtddruddvjeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:UwVuX41INdcWU29T0AMGhJaB3HJIGlhdpwpZMI-KwyruwPc6EXwYOw>
    <xmx:UwVuXzD-ve1UN48X78PrtetY1smAql28prAO4tEFqGl7ymEh84gqxQ>
    <xmx:UwVuX8geyBzOSq6I0Ijh-k5-hQ3NuL4eld4Pjyi37IJqiLjeZx6tRA>
    <xmx:VQVuX1Bsar3AUsWBYtFGXXzyHoYMRcAzPxIbRAmmT678sqzqCjgIfI7lyA7qd_3J>
Received: from cisco (184-167-020-127.res.spectrum.com [184.167.20.127])
        by mail.messagingengine.com (Postfix) with ESMTPA id B8B0B328005D;
        Fri, 25 Sep 2020 10:57:18 -0400 (EDT)
Date:   Fri, 25 Sep 2020 08:57:17 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200925145717.GA284424@cisco>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <8435eff6-7fa9-d923-45e5-d8850e4c6d73@redhat.com>
 <20200925095029.GX2628@hirez.programming.kicks-ass.net>
 <20200925103114.GA7407@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925103114.GA7407@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:31:14AM +0100, Mark Rutland wrote:
> Hi,
> 
> Sorry to come to this so late; I've been meaning to provide feedback on
> this for a while but have been indisposed for a bit due to an injury.
> 
> On Fri, Sep 25, 2020 at 11:50:29AM +0200, Peter Zijlstra wrote:
> > On Fri, Sep 25, 2020 at 11:00:30AM +0200, David Hildenbrand wrote:
> > > On 25.09.20 09:41, Peter Zijlstra wrote:
> > > > On Thu, Sep 24, 2020 at 04:29:03PM +0300, Mike Rapoport wrote:
> > > >> From: Mike Rapoport <rppt@linux.ibm.com>
> > > >>
> > > >> Removing a PAGE_SIZE page from the direct map every time such page is
> > > >> allocated for a secret memory mapping will cause severe fragmentation of
> > > >> the direct map. This fragmentation can be reduced by using PMD-size pages
> > > >> as a pool for small pages for secret memory mappings.
> > > >>
> > > >> Add a gen_pool per secretmem inode and lazily populate this pool with
> > > >> PMD-size pages.
> > > > 
> > > > What's the actual efficacy of this? Since the pmd is per inode, all I
> > > > need is a lot of inodes and we're in business to destroy the directmap,
> > > > no?
> > > > 
> > > > Afaict there's no privs needed to use this, all a process needs is to
> > > > stay below the mlock limit, so a 'fork-bomb' that maps a single secret
> > > > page will utterly destroy the direct map.
> > > > 
> > > > I really don't like this, at all.
> > > 
> > > As I expressed earlier, I would prefer allowing allocation of secretmem
> > > only from a previously defined CMA area. This would physically locally
> > > limit the pain.
> > 
> > Given that this thing doesn't have a migrate hook, that seems like an
> > eminently reasonable contraint. Because not only will it mess up the
> > directmap, it will also destroy the ability of the page-allocator /
> > compaction to re-form high order blocks by sprinkling holes throughout.
> > 
> > Also, this is all very close to XPFO, yet I don't see that mentioned
> > anywhere.
> 
> Agreed. I think if we really need something like this, something between
> XPFO and DEBUG_PAGEALLOC would be generally better, since:

Perhaps we can brainstorm on this? XPFO has mostly been abandoned
because there's no good/safe way to make it faster. There was work on
eliminating TLB flushes, but that waters down the protection. When I
was last thinking about it in anger, it just seemed like it was
destined to be slow, especially on $large_num_cores machines, since
you have to flush everyone else's map too.

I think the idea of "opt in to XPFO" is mostly attractive because then
people only have to pay the slowness cost for memory they really care
about. But if there's some way to make XPFO, or some alternative
design, that may be better.

Tycho
