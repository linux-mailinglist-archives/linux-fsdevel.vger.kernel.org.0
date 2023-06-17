Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B3B734384
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 22:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346442AbjFQUf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 16:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346432AbjFQUf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:35:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8785172C;
        Sat, 17 Jun 2023 13:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C4926121F;
        Sat, 17 Jun 2023 20:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34307C433CA;
        Sat, 17 Jun 2023 20:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687034123;
        bh=LPH4D0EuhGovBKf9L5cFwblZMXTjBgzV3kREfhZQ+ks=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=OMexxDFernOxeez6bulKg5fmSNlPAmeoBGhEVrSW6IrKR+yXX7BDZ8gZfohRD99x8
         5lqCoIniVeRKUfW0lBQ/r/LqEdE1qcGMzMPP2cCjlxZDVLgPlEKKIEyAc8w2Axjgad
         7Xhc7WxMVcDjoqayjmfB3/B83ay17wAU8WtbrhyGsIeGeyHJRAnOmGlyU1x+NzA3Q9
         OMzruAH5Dj73NVyYkpbzf4+vCSRIWIadjOaV5wggGPtAf/E6rHuvmR8wgccNH/SuOC
         xWiOXbRRU86tShqrLXKF/0OqGzoNOAe2Tpl85QFQno9LCMtbvr8JO6h+jEGTUfIr7o
         L1ja1jjCKA3xw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 16EED27C005B;
        Sat, 17 Jun 2023 16:35:22 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Sat, 17 Jun 2023 16:35:22 -0400
X-ME-Sender: <xms:CRmOZA_uQC2fjzsQD54my1MeXphVCaUfV-Ah9x5x4gfIXSvpyka3aA>
    <xme:CRmOZIvyUFoPxVSKEk29Bv-sscEebfWvijmbdiHz_HVtB84NkFLtlDRyPrZ3jeHCY
    oII4dlkqxeac_WOZuY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvjedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:CRmOZGB_5EetWlq8yUIXPGH-qotgY7vAXqsBc1RxtEeErkdD-f_ilQ>
    <xmx:CRmOZAfoHdjCo5SC0XAtCcCi_rbzObNB2Dz2pOdKsYIzy4R5ola_sA>
    <xmx:CRmOZFPZ6Rc23PfHcm7CM9A_lzm4GypiTlOcui-0Hg8mX_CprXlmxA>
    <xmx:ChmOZIoYqfsPixz7i_DBNMwusVMNipEUDMBkFoEXcH0eM39l3yyVsA>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8AC4E31A0063; Sat, 17 Jun 2023 16:35:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Mime-Version: 1.0
Message-Id: <cb6533c6-cea0-4f04-95cf-b8240c6ab405@app.fastmail.com>
In-Reply-To: <ZI4SyXjmA1DsR3Gl@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook> <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook> <ZGPzocRpSlg+4vgN@moria.home.lan>
 <1d249326-e3dd-9c9d-7b53-2fffeb39bfb4@kernel.org>
 <ZI3Sh6p8b4FcP0Y2@moria.home.lan>
 <1d332a4f-3c45-4e6c-81ca-7f8e669b0366@app.fastmail.com>
 <ZI4SyXjmA1DsR3Gl@moria.home.lan>
Date:   Sat, 17 Jun 2023 13:35:01 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Kent Overstreet" <kent.overstreet@linux.dev>
Cc:     "Kees Cook" <keescook@chromium.org>,
        "Johannes Thumshirn" <Johannes.Thumshirn@wdc.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
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



On Sat, Jun 17, 2023, at 1:08 PM, Kent Overstreet wrote:
> On Sat, Jun 17, 2023 at 12:19:41PM -0700, Andy Lutomirski wrote:
>> On Sat, Jun 17, 2023, at 8:34 AM, Kent Overstreet wrote:

>> Great, then propose a model where the codegen operates in an
>> extra-safe protected context.  Or pre-generate the most common
>> variants, have them pull their constants from memory instead of
>> immediates, and use that.
>
> I'll do no such nonsense.

You can avoid generating code beyond what gcc generates at all, or you can pre-generate code but not on an ongoing basis at runtime, or you can generate code at runtime correctly.  I don't think there are many other options.

>
>> > If what you were saying was true, it would be an issue any time we
>> > mapped in new executable code for userspace - minor page faults would be
>> > stupidly slow.
>> 
>> I literally mentioned this in the email.
>
> No, you didn't. Feel free to link or cite if you think otherwise.

"It's clear that a way to do this without 
serializing must exist, because that's what happens when code is paged 
in from a user program."

>> > text_poke() doesn't even send IPIs.
>> 
>> text_poke() and the associated machinery is unbelievably complicated.  
>
> It's not that bad.

This is a useless discussion.

>
> The only reference to IPIs in text_poke() is the comment that indicates
> that flush_tlb_mm_range() may sometimes do IPIs, but explicitly
> indicates that it does _not_ do IPIs the way text_poke() is using it.
>
>> Also, arch/x86/kernel/alternative.c contains:
>> 
>> void text_poke_sync(void)
>> {
>> 	on_each_cpu(do_sync_core, NULL, 1);
>> }
>
> ...which is for modifying code that is currently being executed, not the
> text_poke() or text_poke_copy() paths.
>
>> 
>> The magic in text_poke() was developed over the course of years, and
>> Intel architects were involved.
>> 
>> (And I think some text_poke() stuff uses RCU, which is another way to
>> sync without IPI.  I doubt the performance characteristics are
>> appropriate for bcachefs, but I could be wrong.)
>
> No, it doesn't use RCU.

It literally says in alternative.c:

 * Not safe against concurrent execution; useful for JITs to dump
 * new code blocks into unused regions of RX memory. Can be used in
 * conjunction with synchronize_rcu_tasks() to wait for existing
 * execution to quiesce after having made sure no existing functions
 * pointers are live.

I don't know whether any callers actually do this.  I didn't look.

>
>> > I think you've been misled about some things :)
>> 
>> I wish.
>
> Given your comments on text_poke(), I think you are. You're confusing
> synchronization requirements for _self modifying_ code with the
> synchronization requirements for writing new code to memory, and then
> executing it.

No, you are misunderstanding the difference.

Version A:

User mmap()s an executable file (DSO, whatever).  At first, there is either no PTE or a not-present PTE.  At some point, in response to a page fault or just the kernel prefetching, the kernel fills in the backing page and then creates the PTE.  From the CPU's perspective, the virtual address atomically transitions from having nothing there to having the final code there.  It works (despite the manual having nothing to say about this case).  It's also completely unavoidable.

Version B:

Kernel vmallocs some space *and populates the pagetables*.  There is backing storage, that is executable (or it's a non-NX system, although those are quite rare these days).

Because the CPU hates you, it speculatively executes that code.  (Maybe you're under attack.  Maybe you're just unlucky.  Doesn't matter.)  It populates the instruction cache, remembers the decoded instructions, etc.  It does all the things that make the manual say scary things about serialization.  It notices that the speculative execution was wrong and backs it out, but nothing is invalidated.

Now you write code into there.  Either you do this from a different CPU or you do it at a different linear address, so the magic hardware that invalidates for you does not trigger.

Now you jump into that code, and you tell yourself that it was new code because it was all zeros before and you never intentionally executed it.  But the CPU could not care less what you think, and you lose.

>
> And given that bcachefs is not doing anything new here - we're doing a
> more limited form of what BPF is already doing - I don't think this is
> even the appropriate place for this discussion. There is a new
> executable memory allocator being developed and posted, which is
> expected to wrap text_poke() in an arch-independent way so that
> allocations can share pages, and so that we can remove the need to have
> pages mapped both writeable and executable.

I don't really care what BPF is doing, and BPF may well have the same problem.

But if I understood what bcachefs is doing, it's creating code vastly more frequently than BPF, in response to entirely unprivileged operations from usermode.  It's a whole different amount of exposure.

>
> If you've got knowledge you wish to share on how to get cache coherency
> right, I think that might be a more appropriate thread.

I'll look.
