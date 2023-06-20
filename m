Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C89737313
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 19:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjFTRm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 13:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFTRm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B5F10F8;
        Tue, 20 Jun 2023 10:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8464061347;
        Tue, 20 Jun 2023 17:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47344C433C0;
        Tue, 20 Jun 2023 17:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687282945;
        bh=HqPSWIaowE4nj5clj2k3JH4V3AbdDov4B8Rb4Patkfo=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=s9339xQyC0XBKYSx0zEQ4dFF/ahukeax3w/RKWqvx7TT7ZJ7GRStLt1BnylGu1Gam
         Fw4rsznAdu1fiSViLVt+OpO2XHctAYsz1uyYa/cqpHNsuHmtwpz4dxAE/R5Sc6gyF+
         hZjVpSzhbWQQ/b+f7tOJ/usvDxSj09R99gxfklRToSZPVR3w466sG7kpO7cDKT0QAT
         SqA41wCiDuXRb1McOCqYoz+2IFjfv5x8AsKFF0Y6oQBLQh4oIXwN6tzhIvHEEi6a8I
         zAspRdgqXHatVMKHs6T8ISpg90hOsS5aIaqikisTvWksXpKhoeolozwTPp1t3VX49G
         6EIsTI2sFKAEA==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3A59727C0054;
        Tue, 20 Jun 2023 13:42:24 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 20 Jun 2023 13:42:24 -0400
X-ME-Sender: <xms:_-SRZKxsZMGFSxhBm5vRIo2EoKSGS8PpdQ_wugFe3zouweIOzSbx3Q>
    <xme:_-SRZGTp6i9qiZioW-dK_LNkg8xwsH4bsPCcZSen7ae9TjPmgUPyk9dEULN-D0MI3
    topYDn6ZtfAalKwFFo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefhedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:_-SRZMWPRUyDhdMWDnDD7do9LqcwVDUrkhdEhlplOUG6DzGrAmaeAw>
    <xmx:_-SRZAihSJ0YPyqsvXgdSSG3PoFHsCfe9Rb_iiYwjJQ6TbJObK0ylw>
    <xmx:_-SRZMCEPdi2mA8OAEnJ1wUaXGyuTw_TiaHoWkOlDTgQeu6K_zXblA>
    <xmx:AOWRZMsTaJULl8zgHzhqmEqR8dg-NFprFlff4PCAbRGKO8uNJIFOdQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B26A831A0063; Tue, 20 Jun 2023 13:42:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <5ef2246b-9fe5-4206-acf0-0ce1f4469e6c@app.fastmail.com>
In-Reply-To: <20230619191740.2qmlza3inwycljih@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZJAdhBIvwFBOFQU/@FVFF77S0Q05N>
 <20230619104717.3jvy77y3quou46u3@moria.home.lan>
 <ZJBOVsFraksigfRF@FVFF77S0Q05N.cambridge.arm.com>
 <20230619191740.2qmlza3inwycljih@moria.home.lan>
Date:   Tue, 20 Jun 2023 10:42:02 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Kent Overstreet" <kent.overstreet@linux.dev>,
        "Mark Rutland" <mark.rutland@arm.com>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>, linux-mm@kvack.org,
        "Kees Cook" <keescook@chromium.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
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

On Mon, Jun 19, 2023, at 12:17 PM, Kent Overstreet wrote:
> On Mon, Jun 19, 2023 at 01:47:18PM +0100, Mark Rutland wrote:
>> Sorry, but I do have an engineering rationale here: I want to make sure that
>> this actually works, on architectures that I care about, and will be
>> maintanable long-term.
>> 
>> We've had a bunch of problems with other JITs ranging from JIT-local "we got
>> the encoding wrong" to major kernel infrastructure changes like tasks RCU rude
>> synchronization. I'm trying to figure out whether any of those are likely to
>> apply and/or whether we should be refactoring other infrastructure for use here
>> (e.g. the factoring the acutal instruction generation from arch code, or
>> perhaps reusing eBPF so this can be arch-neutral).
>> 
>> I appreciate that's not clear from my initial mail, but please don't jump
>> straight to assuming I'm adversarial here.
>
> I know you're not trying to be adversarial, but vague negative feedback
> _is_ hostile, because productive technical discussions can't happen
> without specifics and you're putting all the onus on the other person to
> make that happen.

I'm sorry, but this isn't how correct code gets written, and this isn't how at least x86 maintenance operates.

Code is either correct, and comes with an explanation as to how it is correct, or it doesn't go in.  Saying that something is like BPF is not an explanation as to how it's correct.  Saying that someone has not come up with the chain of events that causes a mere violation of architecture rules to actual incorrect execution is not an explanation as to how something is correct.

So, without intending any particular hostility:

<puts on maintainer hat>

bcachefs's x86 JIT is:
Nacked-by: Andy Lutomirski <luto@kernel.org> # for x86

<takes off maintainer hat>

This makes me sad, because I like bcachefs.  But you can get it merged without worrying about my NAK by removing the x86 part.

>
> When you're raising an issue, try be specific - don't make people dig.
> If you're unable to be specific, perhaps you're not the right person to
> be raising the issue.
>
> I'm of course happy to answer questions that haven't already been asked.
>
> This code is pretty simple as JITs go. With the existing, vmalloc_exec()
> based code, there aren't any fancy secondary mappings going on, so no
> crazy cache coherency games, and no crazy syncronization issues to worry
> about: the jit functions are protected by the per-btree-node locks.
>
> vmalloc_exec() isn't being upstreamed however, since people don't want
> WX mappings.
>
> The infrastructure changes we need (and not just for bcachefs) are
>  - better executable memory allocation API, with support for sub-page
>    allocations: this is already being worked on, the prototype slab
>    allocator I posted is probably going to be the basis for part of this
>
>  - an arch indepenendent version of text_poke(): we don't want user code
>    to be flipping page permissions to update text, text_poke() is the
>    proper API but it's x86 only. No one has volunteered for this yet.
>

text_poke() by itself is *not* the proper API, as discussed.  It doesn't serialize adequately, even on x86.  We have text_poke_sync() for that.

--Andy
