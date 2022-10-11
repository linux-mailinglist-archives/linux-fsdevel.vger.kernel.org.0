Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670EF5FB2A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 14:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJKMq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 08:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJKMq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:46:57 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58E93CBC5;
        Tue, 11 Oct 2022 05:46:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 419A25801D6;
        Tue, 11 Oct 2022 08:46:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 11 Oct 2022 08:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665492415; x=1665496015; bh=KeTUBIcKTF
        qBNdPoZmaI0adYgj0Mb+XfDZHZQqTacys=; b=wkfAs5UQIghk/i14T5tUOMaejV
        yDpMyNaz6jJGUqRraFageD0jyfJmFzSQtbScn21qS7LFSOimE1dpakf6GQCz3c5e
        PRFxvjnBD7q6pj2iyiTShDHuCqTUJdIu41YFtyxOtUrkRRI8R6IKj8SIw0y94VAm
        +IRYS7iCAMHVv6KtIbqi+dgPq8FFZAGh+1b8Es1DEc+Zm4n9lNRxgZp8wXgmx34J
        hzj9pJ4ze6vu1tht9F++K3AaYvnXJqEa4oJLVi7mNqHE2m/caWczjBYkfUUoT6fD
        YO5EgVI4Sz2046fE5fky24hdQ2JnhHzHroi6iZEH7iflDLd5i6qqgR0oYebg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665492415; x=1665496015; bh=KeTUBIcKTFqBNdPoZmaI0adYgj0M
        b+XfDZHZQqTacys=; b=aqWTZMM4a78aJ/gDgm0SO0iC8yhUP2RlYwvPKLJg9ucB
        Yw1gl5jSaLJBOgqtYpXsjlaefnPgTxDGaDPzjJYgkOJz0hSkfcj5qHsO32PGrbrk
        n0oMcurKtqS4jHiY4+XOScYJLc0lmoNTAtfWZ6IDmt01+ldKv9bfTM1u0CGe7Cu/
        1RzoSmWdDnLfsEfY3/u9lRMfSNoV4b590P0zynLs3C8T3B+SAnBk+v6b9Y1CtWvJ
        p1Q6VMRkdwPADqGmaKs/sstUN3pomSMbuj3LtB7V81KDqrwhgycp7rd3SlVuDwa6
        +w4jswG5qo0oNHjLAzu2myHlJ5VV3s0Tr6qzuRF29A==
X-ME-Sender: <xms:vWVFY4TuUsocUbtpC5rYDetWax-0Lbob7188NzkpaXnltWlynGg1LA>
    <xme:vWVFY1xCQEkJ1Gtba1a6PIH-wGDU0YBLFNMn_3vnYQaqxQ481CTVG_M9oaicrqdE3
    rRgA3eFAJNkMLZS8cM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephfegteejueeugedtteefueejjefgveekteevvdelfeeftdelkeetffehvefg
    fffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhhlvhhmrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvg
X-ME-Proxy: <xmx:vWVFY11BK9hLqBNvqqlQxl6DG--Mau6RkqbAQ3bLNJWWgs-grw8WQQ>
    <xmx:vWVFY8DOwxO5sihG0RMGIDK7mmrxVWRZUaq2yGUZYomaLJQa31-4eg>
    <xmx:vWVFYxhMY6vSQlKAcsH_FeSUQwwcmvUQ3gHho6L9wnF-M4upulb8-w>
    <xmx:vmVFY2YUFVZkrVOZEC-fBdFiErc8LaMQL8xffU0TFLQb-q0B2PNnFw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B792EB60086; Tue, 11 Oct 2022 08:46:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <c8f87abd-9d66-40cf-bcea-e2b1388d3030@app.fastmail.com>
In-Reply-To: <CAKwvOdmWvDBw9MnO==dZ8i=gqbVPSUuiuRtwKmWuV8uXzJYNww@mail.gmail.com>
References: <20190307090146.1874906-1-arnd@arndb.de>
 <20221006222124.aabaemy7ofop7ccz@google.com>
 <c646ea1e-c860-41cf-9a8e-9abe541034ff@app.fastmail.com>
 <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com>
 <e554eb3c-d065-4aad-b6d2-a12469eaf49c@app.fastmail.com>
 <CAKwvOdmNiSok3sAMJs2PQLs0yVzOfMTaQTWjyW8q2oc3VF60sw@mail.gmail.com>
 <CAKwvOdmWvDBw9MnO==dZ8i=gqbVPSUuiuRtwKmWuV8uXzJYNww@mail.gmail.com>
Date:   Tue, 11 Oct 2022 14:46:33 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nick Desaulniers" <ndesaulniers@google.com>
Cc:     "Kees Cook" <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Eric Dumazet" <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Paul Kirth" <paulkirth@google.com>
Subject: Re: [PATCH] fs/select: avoid clang stack usage warning
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 10, 2022, at 8:40 PM, Nick Desaulniers wrote:
> On Fri, Oct 7, 2022 at 3:54 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make -j128 defconfig fs/select.o
> $ llvm-objdump -Dr --disassemble-symbols=core_sys_select fs/select.o |
> grep do_select
>     1a48: 2e fb ff 97  bl 0x700 <do_select>
>
> Same for 32b ARM.
> arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110
>
> $ CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm make -j128 defconfig fs/select.o
> $ llvm-objdump -Dr --disassemble-symbols=core_sys_select fs/select.o |
> grep do_select
>     1620: 07 fc ff eb  bl #-4068 <do_select>
>
> Is there a set of configs or different compiler version for which
> that's not the case? Perhaps. But it doesn't look like marking
> do_select noinline_for_stack changes the default behavior for GCC
> builds, which is good.

I checked all arm32 defconfigs, and all supported gcc versions for arm32,
they all behave the same.

> So it looks like it's just clang being aggressive with inlining since
> it doesn't have -fconserve-stack.  I think
> https://lore.kernel.org/lkml/20221007201140.1744961-1-ndesaulniers@google.com/
> is still on the right track, though I'd remove the 32b only guard for
> v2.

I think it's again the difference between top-down and bottom-up inlining.

> Paul also mentioned that -finline-max-stacksize is a thing, at least 
> for clang.
> https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-finline-max-stacksize
> Though this only landed recently
> https://reviews.llvm.org/rG8564e2fea559 and wont ship until clang-16.
> That feels like a large hammer for core_sys_select/do_select; I think
> we can use a fine scalpel.  But it might be interesting to use that
> with KASAN.


It's an interesting question whether it would help or hurt with
KASAN_STACK: Normally the idea is that KASAN_STACK intentionally
makes stack slots inside of a function non-overlapping, similar
to the use-after-scope sanitizer that we no longer use because
it caused too many stack overflows. Making it inline less should
help reduce the actual stack consumption (not just the reported
usage) because it makes called functions reuse the same stack slots,
but it also makes KASAN_STACK less effective because of the same
thing.

If -finline-max-stacksize is the equivalent of gcc's
-fconserve-stack, we could of course just always enable that.

    Arnd
