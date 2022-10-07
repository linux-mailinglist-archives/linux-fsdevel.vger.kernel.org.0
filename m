Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84FC5F754B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 10:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJGI23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 04:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJGI21 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:28:27 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D7A4F39C;
        Fri,  7 Oct 2022 01:28:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id F2B2D5803B7;
        Fri,  7 Oct 2022 04:28:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 07 Oct 2022 04:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665131302; x=1665134902; bh=wUO69rfJuc
        WBI2Ed7ObFQqU3WibCkuVFp9bQab42AqY=; b=SjuAzMMCYhq3/XzFvsfGEKvXD9
        DZoa8hm1rBgzqgEw5TNhtbrdWT/nlitLRCxsJE+vziNFVDXaBeTcAvUS/2GRnIOS
        XSWfI/DR+ritwiZP1e5PWQdq3WXZYoME8XIE4jnT8+f3jDRuvJ2o9173+F5j57+T
        0d6X1awAA1GQM8tMK5rDEo1yJr8kt1b/IhZzuNYXL1cZ5KHAhKhqGBuKPUpCNJie
        2Qzgb7GsCQtAPiU44kAdrOwDfOVYkmsOfPA5CZto3ADCR78zfWr0r2p3DAPBNTiD
        KVVZ5IXMAcvkLGFP1YlayAT/Zz1wX7ZJxCUl+IUL7RUO8ghPuhEX0M0iJRpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665131302; x=1665134902; bh=wUO69rfJucWBI2Ed7ObFQqU3WibC
        kuVFp9bQab42AqY=; b=ccqshGcuHog9XlavT95TcnT7zstkhseVbo089b4qzYuV
        MXiNd/VVe4hNFUSb5b+nzI5x7gE2T8b1fevVdaPQ1gnLwONesH2OvlhblJYtOzB8
        SFpZ11U327GtDXwbrRA8lMEJCboAxmRUM8xpat9+dPemqdtqe5sJesh9pfvyZ81g
        Tn7jW8jl427x/SZj42HlilZAwhfqAIKCN0CTWfKhMAynPMbjd2r0ddEYcqn0ptFk
        sIo1K1ikil730TkRboiItq8T7dbfin0nN+GgEtDuZb7QLzHV/JNyDaYbMen+ZgP9
        bUNp27MKFbDN0eUOU5wJ1BtgZIKontNR1YW4PUBTMA==
X-ME-Sender: <xms:JuM_Y9__FMozOD-cFQivjVtEUb1z84NPhS8m3aYZOXiP4fZWx-pFlQ>
    <xme:JuM_YxtoXXQ9eW1UZEebjrhs_mUus2Fex53pm0a_BjgSBGJ80v1yxs99id3j9fgJT
    9XXtkA9fqhFX-6zkic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeijedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:JuM_Y7DtkdF82LjEBR0OXrH3YQsDngb6ORnZVZzorlLPHYmAYg3dKQ>
    <xmx:JuM_YxfA0VnsDiUPUN-LcwzfnVe33Gbb6sIh-Vi_XJTmFj3u6relvQ>
    <xmx:JuM_YyM4W_SUyb9BWwUUx5ka9j5Prra-oy9y2v2vJGPIMmDrCSbLcA>
    <xmx:JuM_YziiV0VHBhHHw6p_MHaooz7iz7QNVRsKflmbrd8weNrmXc9WDA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 54C05B60086; Fri,  7 Oct 2022 04:28:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <c646ea1e-c860-41cf-9a8e-9abe541034ff@app.fastmail.com>
In-Reply-To: <20221006222124.aabaemy7ofop7ccz@google.com>
References: <20190307090146.1874906-1-arnd@arndb.de>
 <20221006222124.aabaemy7ofop7ccz@google.com>
Date:   Fri, 07 Oct 2022 10:28:02 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nick Desaulniers" <ndesaulniers@google.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Eric Dumazet" <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Fri, Oct 7, 2022, at 12:21 AM, Nick Desaulniers wrote:
> On Thu, Mar 07, 2019 at 10:01:36AM +0100, Arnd Bergmann wrote:
>> The select() implementation is carefully tuned to put a sensible amount
>> of data on the stack for holding a copy of the user space fd_set,
>> but not too large to risk overflowing the kernel stack.
>> 
>> When building a 32-bit kernel with clang, we need a little more space
>> than with gcc, which often triggers a warning:
>> 
>> fs/select.c:619:5: error: stack frame size of 1048 bytes in function 'core_sys_select' [-Werror,-Wframe-larger-than=]
>> int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
>> 
>> I experimentally found that for 32-bit ARM, reducing the maximum
>> stack usage by 64 bytes keeps us reliably under the warning limit
>> again.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  include/linux/poll.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/include/linux/poll.h b/include/linux/poll.h
>> index 7e0fdcf905d2..1cdc32b1f1b0 100644
>> --- a/include/linux/poll.h
>> +++ b/include/linux/poll.h
>> @@ -16,7 +16,11 @@
>>  extern struct ctl_table epoll_table[]; /* for sysctl */
>>  /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
>>     additional memory. */
>> +#ifdef __clang__
>> +#define MAX_STACK_ALLOC 768
>
> Hi Arnd,
> Upon a toolchain upgrade for Android, our 32b x86 image used for
> first-party developer VMs started tripping -Wframe-larger-than= again
> (thanks -Werror) which is blocking our ability to upgrade our toolchain.
>
> I've attached the zstd compressed .config file that reproduces with ToT
> LLVM:
>
> $ cd linux
> $ zstd -d path/to/config.zst -o .config
> $ make ARCH=i386 LLVM=1 -j128 fs/select.o
> fs/select.c:625:5: error: stack frame size (1028) exceeds limit (1024)
> in 'core_sys_select' [-Werror,-Wframe-larger-than]
> int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
>     ^
>
> As you can see, we're just barely tipping over the limit.  Should I send
> a patch to reduce this again? If so, any thoughts by how much?
> Decrementing the current value by 4 builds the config in question, but
> seems brittle.
>
> Do we need to only do this if !CONFIG_64BIT?
> commit ad312f95d41c ("fs/select: avoid clang stack usage warning")
> seems to allude to this being more problematic on 32b targets?

I think we should keep the limit consistent between 32 bit and 64 bit
kernels. Lowering the allocation a bit more would of course have a
performance impact for users that are just below the current limit,
so I think it would be best to first look at what might be going
wrong in the compiler.

I managed to reproduce the issue and had a look at what happens
here. A few random observations:

- the kernel is built with -fsanitize=local-bounds, dropping this
  option reduces the stack allocation for this function by around
  100 bytes, which would be the easiest change for you to build
  those kernels again without any source changes, but it may also
  be possible to change the core_sys_select function in a way that
  avoids the insertion of runtime bounds checks.

- If I mark 'do_select' as noinline_for_stack, the reported frame
  size is decreased a lot and is suddenly independent of
  -fsanitize=local-bounds:
  fs/select.c:625:5: error: stack frame size (336) exceeds limit (100) in 'core_sys_select' [-Werror,-Wframe-larger-than]
int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
  fs/select.c:479:21: error: stack frame size (684) exceeds limit (100) in 'do_select' [-Werror,-Wframe-larger-than]
static noinline int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
  However, I don't even see how this makes sense at all, given that
  the actual frame size should be at least SELECT_STACK_ALLOC!

- The behavior of -ftrivial-auto-var-init= is a bit odd here: with =zero or
  =pattern, the stack usage is just below the limit (1020), without the
  option it is up to 1044. It looks like your .config picks =zero, which
  was dropped in the latest clang version, so it falls back to not
  initializing. Setting it to =pattern should give you the old
  behavior, but I don't understand why clang uses more stack without
  the initialization, rather than using less, as it would likely cause
  fewer spills

       Arnd
