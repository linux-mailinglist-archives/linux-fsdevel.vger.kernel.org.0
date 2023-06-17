Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7D6734349
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 21:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjFQTUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 15:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjFQTUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 15:20:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00D81732
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 12:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4745960F28
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 19:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5744BC433C8;
        Sat, 17 Jun 2023 19:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687029603;
        bh=ReENnH29u+Sqx2QjIOIjw6BOWCv4J/9dZWKQnNbla9g=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=bcTPYlAbVmtS4aI6yW/zkJ4jRRLGhwbQ59DW/N98HaNu1Q9gqkgy/aFYA6SkUCEFG
         5W3JZP/yqR/LZgAr7JoxSYC4Udr3M4BIuZFVLygtxXDPrUSlpubLmQ5mrV1jN1/R1G
         rTeAsuPW9fwD1wpRhnm6ycn79I7iC2lDQkZ2+yFdTgN9D4Hdje9UlWLfW68FjLlO0R
         QYTNBbWQ3BCCwQ0cizTBazKcX9jHENOn2vCIyClSadCcJ97TzV0J0MtXNBbJe+hDWI
         NROsqyNaensuDY5o0EhD6YttkKSXam2ztNeFc3vSunq/rJrUyRXjoOSiHI51w7sT9d
         nGjWfDlLq6LSA==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 23F2927C0054;
        Sat, 17 Jun 2023 15:20:02 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Sat, 17 Jun 2023 15:20:02 -0400
X-ME-Sender: <xms:YQeOZHvBSWVRdeDSoRnrfydczeHmtrBOS8mEw3QetaYgDbMmHPBkfA>
    <xme:YQeOZIf_lbOa7CLxeTWXJ3280Qism3_KtiT68bo16WtmGYFN7P9BIRhFDTs0II6FH
    TWZ17z65JSHLoaqYkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvjedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeehffdtudfgvedthedvheeiffelvdelfeehieffhffggfdvledu
    udetueejjeefleenucffohhmrghinhepsghithguvghfvghnuggvrhdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduie
    eitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:YQeOZKxuRdTaad2h6LNlOShSfXgKTV7_7Pd0xED-xvNPiWje2BE9Mg>
    <xmx:YQeOZGMTcjZBhh8m4AaXMY-SA8xFvjlHUOakg_Q3BcfxsNwyIbBGDQ>
    <xmx:YQeOZH_3hKE3x2tYfRnTqEsGaegB5-almbMNXeyi2q1YvvfYN7Typw>
    <xmx:YgeOZObSDr3qZVNILD2KRKaZzCJvtR9FPS_CFg14oYq49tFSPvuZVQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5933E31A0063; Sat, 17 Jun 2023 15:20:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Mime-Version: 1.0
Message-Id: <1d332a4f-3c45-4e6c-81ca-7f8e669b0366@app.fastmail.com>
In-Reply-To: <ZI3Sh6p8b4FcP0Y2@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook> <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook> <ZGPzocRpSlg+4vgN@moria.home.lan>
 <1d249326-e3dd-9c9d-7b53-2fffeb39bfb4@kernel.org>
 <ZI3Sh6p8b4FcP0Y2@moria.home.lan>
Date:   Sat, 17 Jun 2023 12:19:41 -0700
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 17, 2023, at 8:34 AM, Kent Overstreet wrote:
> On Fri, Jun 16, 2023 at 09:13:22PM -0700, Andy Lutomirski wrote:
>> On 5/16/23 14:20, Kent Overstreet wrote:
>> > On Tue, May 16, 2023 at 02:02:11PM -0700, Kees Cook wrote:
>> > > For something that small, why not use the text_poke API?
>> > 
>> > This looks like it's meant for patching existing kernel text, which
>> > isn't what I want - I'm generating new functions on the fly, one per
>> > btree node.
>> 
>> Dynamically generating code is a giant can of worms.
>> 
>> Kees touched on a basic security thing: a linear address mapped W+X is a big
>> no-no.  And that's just scratching the surface -- ideally we would have a
>> strong protocol for generating code: the code is generated in some
>> extra-secure context, then it's made immutable and double-checked, then
>> it becomes live.
>
> "Double checking" arbitrary code is is fantasy. You can't "prove the
> security" of arbitrary code post compilation.
>
> Rice's theorem states that any nontrivial property of a program is
> either a direct consequence of the syntax, or is undecidable. It's why
> programs in statically typed languages are easier to reason about, and
> it's also why the borrow checker in Rust is a syntactic construct.

If you want security in some theoretical sense, sure, you're probably right.  But that doesn't stop people from double-checking executable code to quite good effect.  For example:

https://www.bitdefender.com/blog/businessinsights/bitdefender-releases-landmark-open-source-software-project-hypervisor-based-memory-introspection/

(I have no personal experience with this, but I know people who do.  It's obviously not perfect, but I think it provides meaningful benefits.)

I'm not saying Linux should do this internally, but it might not be a terrible idea some day.

>
> You just have to be able to trust the code that generates the code. Just
> like you have to be able to trust any other code that lives in kernel
> space.
>
> This is far safer and easier to reason about than what BPF is doing
> because we're not compiling arbitrary code, the actual codegen part is
> 200 loc and the input is just a single table.

Great, then propose a model where the codegen operates in an extra-safe protected context.  Or pre-generate the most common variants, have them pull their constants from memory instead of immediates, and use that.

>
>> 
>> (When x86 modifies itself at boot or for static keys, it changes out the
>> page tables temporarily.)
>> 
>> And even beyond security, we have correctness.  x86 is a fairly forgiving
>> architecture.  If you go back in time about 20 years, modify
>> some code *at the same linear address at which you intend to execute it*,
>> and jump to it, it works.  It may even work if you do it through
>> an alias (the manual is vague).  But it's not 20 years ago, and you have
>> multiple cores.  This does *not* work with multiple CPUs -- you need to
>> serialize on the CPU executing the modified code.  On all the but the very
>> newest CPUs, you need to kludge up the serialization, and that's
>> sloooooooooooooow.  Very new CPUs have the SERIALIZE instruction, which
>> is merely sloooooow.
>
> If what you were saying was true, it would be an issue any time we
> mapped in new executable code for userspace - minor page faults would be
> stupidly slow.

I literally mentioned this in the email.

I don't know _precisely_ what's going on, but I assume it's that it's impossible (assuming the kernel gets TLB invalidation right) for a CPU to have anything buffered for a linear address that is unmapped, so when it gets mapped, the CPU can't have anything stale in its buffers.  (By buffers, I mean any sort of instruction or decoded instruction cache.)

Having *this* conversation is what I was talking about in regard to possible fancy future optimization.

>
> This code has been running on thousands of machines for years, and the
> only issues that have come up have been due to the recent introduction
> of indirect branch tracking. x86 doesn't have such broken caches, and
> architectures that do have utterly broken caches (because that's what
> you're describing: you're describing caches that _are not coherent
> across cores_) are not high on my list of things I care about.

I care.  And a bunch of people who haven't gotten their filesystem corrupted because of a missed serialization.

>
> Also, SERIALIZE is a spectre thing. Not relevant here.

Nope, try again.  SERIALIZE "serializes" in the rather vague sense in the Intel SDM.  I don't think it's terribly useful for Spectre.

(Yes, I know what I'm talking about.)

>
>> Based on the above, I regret to inform you that jit_update() will either
>> need to sync all cores via IPI or all cores will need to check whether a
>> sync is needed and do it themselves.
>
> text_poke() doesn't even send IPIs.

text_poke() and the associated machinery is unbelievably complicated.  

Also, arch/x86/kernel/alternative.c contains:

void text_poke_sync(void)
{
	on_each_cpu(do_sync_core, NULL, 1);
}

The magic in text_poke() was developed over the course of years, and Intel architects were involved.

(And I think some text_poke() stuff uses RCU, which is another way to sync without IPI.  I doubt the performance characteristics are appropriate for bcachefs, but I could be wrong.)

>
> I think you've been misled about some things :)

I wish.


I like bcachefs.  I really don't want to have to put on my maintainer hat here, and I do indeed generally stay in the background.  (And I haven't had nearly as much time for this kind of the work in the last couple years as I'd like, sigh.) But I personally have a fairly strict opinion that, if someone (including myself!) wants to merge something that plays clever games that may cause x86 architecture code (especially mm code) to do things it shouldn't in corner cases, even if no one has directly observed that corner case or even knows how to get it to misbehave, then they had better have a very convincing argument that it's safe.  No one likes debugging bugs when something that should be coherent becomes incoherent.

So, if you really really want self-modifying code in bcachefs, its correctness needs to be very, very well argued, and it needs to be maintainable.  Otherwise I will NAK it.  Sorry.
