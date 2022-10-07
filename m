Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99C5F803F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 23:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJGVn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 17:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJGVnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:43:21 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F552127908;
        Fri,  7 Oct 2022 14:43:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 5146A2B06610;
        Fri,  7 Oct 2022 17:43:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 07 Oct 2022 17:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665178992; x=1665182592; bh=AnI23BSBsJ
        Pl7z4tgUtQwDLGRb6TaTjJl8AQi9i3Poo=; b=tvKQpcli/B9BBh4EKTgp12Feb9
        ZdYHQ4TVHU1qh7v4l5No1zEK2FCM9Lkz6NbkEzAqJa7i9y/LpVZf5p+Arvzt1ogk
        a86lyXLOS6xrQTrr7C7tMsj6KmC/77u67KJidDxqIIVIWjJ979Mg75Nbz/UUzRlq
        PmvK2W+fGxi2oc4EedgZjLiK9ku6Zwp+g8UKRi7MThTLVuSKU5sW0aD7nHs0yDqF
        13seVrN9JucVXwmEI3eFCnLBIvOBDzqsdurmNgBRJzJ3Irs7Y0GcHwXmlR2qsTJg
        Ejk7HOf16qFPCXmm1F0l3c2aKWW4CLyWSlHKTxPjZJa0G3zqIGGkYKaKv6wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665178992; x=1665182592; bh=AnI23BSBsJPl7z4tgUtQwDLGRb6T
        aTjJl8AQi9i3Poo=; b=qeGKAULW4BvlACmN/nluXT19xw2mvzWKVHCAIt1k+NkD
        2W367w/5HoJ5Z+VA9ZGgdlauomJJ2PQlww1DAYdqPrsvNI/XkPVcXmjOm2n575nx
        BLV8kNIBo04PiYpdttK78Rhc9S+AsQDoVAJCxYDP/YeGh204vY7aspJxz8jwvbCZ
        QpRCkBfPPiyn2LjdZCoCTKE1wTuIDC4uHyLU23wRi/+HWgJpLSzmuemMzahzdSxO
        zjFjiCmLveNvBSIlz2Q4hZe79oZeHIYHaVojsk5O1zlFjwBQFdPFcoixwb+1WgsA
        FyIunedS/iQxQKaiKUxmpc/4FkngYappFjB3vucVEA==
X-ME-Sender: <xms:b51AY4AytO4Mw3NvRvFdsCiQKICB2uT90DHLirbeE3JcB4-BLt_Jwg>
    <xme:b51AY6icDl5TDGUs_fgMffcqH95ea_EXiN_5VKl8nDiZ7-0Z6Kai_LsSjs-5Y6Irv
    cAvMuGwnvewsWtKU24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeikedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepjedvvddvudeludehjeeitdehheeivdejgfelleffiefgvefhhfeuudfhgeef
    feehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:b51AY7n7Nz84kAbPIjHwmkGnGKTkF5jHoZMRwqA8laTz0njXedj4Wg>
    <xmx:b51AY-zPbfhyWaPG_uYeda4wg_z5YmL-ScyTPiacZaaSWNmqAmLd6Q>
    <xmx:b51AY9RTYwGv4b77vfVjBwAKSALegwna_8-YPMdPUl2s1GmXoaGHQg>
    <xmx:cJ1AYyKDVi2OBrRE-3yIDisa3YBXAObRieDNTvn7Uwnba3sziW86gDZsDCc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DAD8EB60089; Fri,  7 Oct 2022 17:43:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <e554eb3c-d065-4aad-b6d2-a12469eaf49c@app.fastmail.com>
In-Reply-To: <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com>
References: <20190307090146.1874906-1-arnd@arndb.de>
 <20221006222124.aabaemy7ofop7ccz@google.com>
 <c646ea1e-c860-41cf-9a8e-9abe541034ff@app.fastmail.com>
 <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com>
Date:   Fri, 07 Oct 2022 23:42:51 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nick Desaulniers" <ndesaulniers@google.com>,
        "Kees Cook" <keescook@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org,
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

On Fri, Oct 7, 2022, at 9:04 PM, Nick Desaulniers wrote:
> On Fri, Oct 7, 2022 at 1:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Oct 7, 2022, at 12:21 AM, Nick Desaulniers wrote:
>> > On Thu, Mar 07, 2019 at 10:01:36AM +0100, Arnd Bergmann wrote:
>>
>> - the kernel is built with -fsanitize=local-bounds, dropping this
>>   option reduces the stack allocation for this function by around
>>   100 bytes, which would be the easiest change for you to build
>>   those kernels again without any source changes, but it may also
>>   be possible to change the core_sys_select function in a way that
>>   avoids the insertion of runtime bounds checks.
>
> Thanks for taking a look Arnd; ++beers_owed;
>
> I'm not sure we'd want to disable CONFIG_UBSAN_LOCAL_BOUNDS=y for this
> particular configuration of the kernel over this, or remove
> -fsanitize=local-bounds for this translation unit (even if we did so
> specifically for 32b targets).  FWICT, the parameter n of function
> core_sys_select() is used to index into the stack allocated stack_fds,
> which is what -fsanitize=local-bounds is inserting runtime guards for.

Right, so what I was thinking is that the existing runtime check
'if (size > sizeof(stack_fds) / 6)' could be rewritten in a way that
clang sees the bounds correctly, as the added check would test for
the exact same limit, right? It might be too hard to figure out, or
it might have other side-effects.

>> - If I mark 'do_select' as noinline_for_stack, the reported frame
>>   size is decreased a lot and is suddenly independent of
>>   -fsanitize=local-bounds:
>>   fs/select.c:625:5: error: stack frame size (336) exceeds limit (100) in 'core_sys_select' [-Werror,-Wframe-larger-than]
>> int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
>>   fs/select.c:479:21: error: stack frame size (684) exceeds limit (100) in 'do_select' [-Werror,-Wframe-larger-than]
>> static noinline int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
>
> I think this approach makes the most sense to me; the caller
> core_sys_select() has a large stack allocation `stack_fds`, and so
> does the callee do_select with `table`.  Add in inlining and long live
> ranges and it makes sense that stack spills are going to tip us over
> the threshold set by -Wframe-larger-than.
>
> Whether you make do_select() `noinline_for_stack` conditional on
> additional configs like CC_IS_CLANG or CONFIG_UBSAN_LOCAL_BOUNDS is
> perhaps also worth considering.
>
> How would you feel about a patch that:
> 1. reverts commit ad312f95d41c ("fs/select: avoid clang stack usage warning")
> 2. marks do_select noinline_for_stack
>
> ?

That is probably ok, but it does need proper testing to ensure that
there are no performance regressions. Do you know if gcc inlines the
function by default? If not, we probably don't need to make it
conditional.

> I assume the point of "small string optimization" going on with
> `stack_fds` in core_sys_select() is that the potential overhead for
> kmalloc is much much higher than the cost of not inlining do_select()
> into core_sys_select().  The above approach does solve this .config's
> instance, and seems slightly less brittle to me.
>
>>   However, I don't even see how this makes sense at all, given that
>>   the actual frame size should be at least SELECT_STACK_ALLOC!
>
> I think the math checks out:
>
> #define FRONTEND_STACK_ALLOC  256
> #define SELECT_STACK_ALLOC  FRONTEND_STACK_ALLOC
> long stack_fds[SELECT_STACK_ALLOC/sizeof(long)];
>
> sizeof(long) == 4; // i386 ilp32
> sizeof(stack_fds) == sizeof(long) * 256 / sizeof(long) == 256

Ah right, I misread what the code actually does here.

>> - The behavior of -ftrivial-auto-var-init= is a bit odd here: with =zero or
>>   =pattern, the stack usage is just below the limit (1020), without the
>>   option it is up to 1044. It looks like your .config picks =zero, which
>>   was dropped in the latest clang version, so it falls back to not
>
> Huh? What do you mean by "was dropped?"
>
> The config I sent has:
> CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
> # CONFIG_INIT_STACK_NONE is not set
> CONFIG_INIT_STACK_ALL_ZERO=y

When I use this config on my kernel tree (currently on top of
next-20220929 for unrelated work) and build with clang-16,
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO is disabled, so it falls
back from CONFIG_INIT_STACK_NONE instead of the unavailable
CONFIG_INIT_STACK_ALL_ZERO.

> Disabling INIT_STACK_ALL_ZERO from the config provided doesn't elide
> the diagnostic.
> Enabling INIT_STACK_ALL_PATTERN does... explicit stack allocations in
> IR haven't changed. In the generated assembly we're pushing 3x 4B
> GPRs, subtracting 8B from the stack pointer, then another 1008B.
> (Filed: https://github.com/llvm/llvm-project/issues/58237)
> So that's 3 * 4B + 8B + 1008B == 1028.  But CONFIG_FRAME_WARN is set
> to 1024.  I wonder if this diagnostic is not as precise as it could
> be, or my math is wrong?
>
> It looks like for arrays INIT_STACK_ALL_PATTERN uses memset to fill
> the array with 0xFF rather than 0x00 used by INIT_STACK_ALL_ZERO. Not
> sure why that would make a difference, but curious that it does.

The warning sizes I see are:

zero: 1028
pattern: 1020
none: 1044

So you are right, even with =pattern I get the warning, even though it's
16 bytes less than the =none case I was looking at first.

      Arnd
