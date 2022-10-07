Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F845F7D98
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJGTE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJGTEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:04:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B312399F2
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Oct 2022 12:04:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b2so5336802plc.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Oct 2022 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=21A6ZjPuJYw0WXuNQnO8404OZpL79Fxvlo9cifFtwEE=;
        b=OgjwR2mpvL7at1QiCptYJGYayigIS2Mnch4J2YrXJaQ42rnGB/rkvrX9a67tle7xCW
         DV71jD5VbMXXT2fc+6W0GIBPw1RiWVdwt6xGnnYBPGuFo/EzsOy/rYI7EuOCIe3RPp6f
         Yl/EYakcL4uTGWudHHVZseK0jFW5qg1nLAG4ilXwFF+7zrcOlHvO6YaFMLo01IDsHNMz
         /aLxG6AryM6U/BcZnz6+L5Z7priSsJeGNyF5GYnJIqCU0z3nnctU3XBYqlY72vmrxcCm
         oD+C6JsVYJXXYXNb2pFrfb5IRNVRWQy7LL3JjivtxT2cs4CraTszZRiSB9sC+s0w6SnG
         3gmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21A6ZjPuJYw0WXuNQnO8404OZpL79Fxvlo9cifFtwEE=;
        b=rhBQ6w5BsErMDi0oPYBzBqveussMdLI3s6xVZUPQ7bzvpxpqLAPVpiifKSayKQAFFV
         GO0mQH8I6fe3kqC49XcLRzY8DY2UVZCxYzAE5sU4Lyl52gH8o7PJ1SlO4cXgsVm+7Ybw
         bWz2LLVw7T3P3QU4Nn0Xmatcxg2Tj/sCca7bxl2s0l0/NWKSwV7JzYuGgGSLMVoD5ix7
         o1PJUX3VLdGtjS4dACflIAc3SQnp/wZapV7QKq7dZpROfy66+P+hwFu5o7j3pbrTR6T+
         gNknR+c+6fPSDgC5uiqlr3U15vA7sTgFAZtk3uqVnXc0O0LAey+ZVCpwYzWZDcCaK6Tq
         d+gQ==
X-Gm-Message-State: ACrzQf3r7/IYXj+hCeUjWF8t1K3JJicM9tGUAtcYsWMH2SFtJ6/Z3wuC
        ZfCJMLn8V5KXZb6FgvraiYyS+dgv7pYBG9abPN3M9QfR4LrcgQ==
X-Google-Smtp-Source: AMsMyM4sNQYpMbZ9f/4CGWZVJyb3GZQElKXVzVQNQlRukk6gLIsS/wsrK2rtho4EMPQYRyH3dy8QJ4ruM6l9u5XKLvo=
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id
 om8-20020a17090b3a8800b00209f35dad53mr17920889pjb.102.1665169463422; Fri, 07
 Oct 2022 12:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190307090146.1874906-1-arnd@arndb.de> <20221006222124.aabaemy7ofop7ccz@google.com>
 <c646ea1e-c860-41cf-9a8e-9abe541034ff@app.fastmail.com>
In-Reply-To: <c646ea1e-c860-41cf-9a8e-9abe541034ff@app.fastmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Oct 2022 12:04:11 -0700
Message-ID: <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com>
Subject: Re: [PATCH] fs/select: avoid clang stack usage warning
To:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Paul Kirth <paulkirth@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+ Kees, Paul

On Fri, Oct 7, 2022 at 1:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Oct 7, 2022, at 12:21 AM, Nick Desaulniers wrote:
> > On Thu, Mar 07, 2019 at 10:01:36AM +0100, Arnd Bergmann wrote:
> >> The select() implementation is carefully tuned to put a sensible amount
> >> of data on the stack for holding a copy of the user space fd_set,
> >> but not too large to risk overflowing the kernel stack.
> >>
> >> When building a 32-bit kernel with clang, we need a little more space
> >> than with gcc, which often triggers a warning:
> >>
> >> fs/select.c:619:5: error: stack frame size of 1048 bytes in function 'core_sys_select' [-Werror,-Wframe-larger-than=]
> >> int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
> >>
> >> I experimentally found that for 32-bit ARM, reducing the maximum
> >> stack usage by 64 bytes keeps us reliably under the warning limit
> >> again.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  include/linux/poll.h | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/include/linux/poll.h b/include/linux/poll.h
> >> index 7e0fdcf905d2..1cdc32b1f1b0 100644
> >> --- a/include/linux/poll.h
> >> +++ b/include/linux/poll.h
> >> @@ -16,7 +16,11 @@
> >>  extern struct ctl_table epoll_table[]; /* for sysctl */
> >>  /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
> >>     additional memory. */
> >> +#ifdef __clang__
> >> +#define MAX_STACK_ALLOC 768
> >
> > Hi Arnd,
> > Upon a toolchain upgrade for Android, our 32b x86 image used for
> > first-party developer VMs started tripping -Wframe-larger-than= again
> > (thanks -Werror) which is blocking our ability to upgrade our toolchain.
> >
> > I've attached the zstd compressed .config file that reproduces with ToT
> > LLVM:
> >
> > $ cd linux
> > $ zstd -d path/to/config.zst -o .config
> > $ make ARCH=i386 LLVM=1 -j128 fs/select.o
> > fs/select.c:625:5: error: stack frame size (1028) exceeds limit (1024)
> > in 'core_sys_select' [-Werror,-Wframe-larger-than]
> > int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
> >     ^
> >
> > As you can see, we're just barely tipping over the limit.  Should I send
> > a patch to reduce this again? If so, any thoughts by how much?
> > Decrementing the current value by 4 builds the config in question, but
> > seems brittle.
> >
> > Do we need to only do this if !CONFIG_64BIT?
> > commit ad312f95d41c ("fs/select: avoid clang stack usage warning")
> > seems to allude to this being more problematic on 32b targets?
>
> I think we should keep the limit consistent between 32 bit and 64 bit
> kernels. Lowering the allocation a bit more would of course have a
> performance impact for users that are just below the current limit,
> so I think it would be best to first look at what might be going
> wrong in the compiler.
>
> I managed to reproduce the issue and had a look at what happens
> here. A few random observations:
>
> - the kernel is built with -fsanitize=local-bounds, dropping this
>   option reduces the stack allocation for this function by around
>   100 bytes, which would be the easiest change for you to build
>   those kernels again without any source changes, but it may also
>   be possible to change the core_sys_select function in a way that
>   avoids the insertion of runtime bounds checks.

Thanks for taking a look Arnd; ++beers_owed;

I'm not sure we'd want to disable CONFIG_UBSAN_LOCAL_BOUNDS=y for this
particular configuration of the kernel over this, or remove
-fsanitize=local-bounds for this translation unit (even if we did so
specifically for 32b targets).  FWICT, the parameter n of function
core_sys_select() is used to index into the stack allocated stack_fds,
which is what -fsanitize=local-bounds is inserting runtime guards for.

If I dump the compiler IR (before register allocation), the only
explicit stack allocations I observe once the middle end optimizations
have run are:

1. a single 64b value...looks like the ktime_t passed to
poll_schedule_timeout IIUC.
2. a struct poll_wqueues inlined from do_select.
3. 64x32b array, probably stack_fds.

(oh, yeah, those are correct, if I rebuild with `KCFLAGS="-g0
-fno-discard-value-names"` the IR retains identifiers for locals. I
should send a patch for that for kbuild).

I think that implies that the final stack slots emitted are a result
of the register allocator failing to keep all temporary values live in
registers; they are spilled to the stack.

Paul has been playing with visualizing stack slots recently, and might
be able to provide more color.

I worry that the back end might do tail duplication or if conversion
and potentially split large stack values into two distinct
(non-overlapping) stack slots, but haven't seen that yet in reality.

We've also seen poor stack slot reuse with KASAN with clang as well...

>
> - If I mark 'do_select' as noinline_for_stack, the reported frame
>   size is decreased a lot and is suddenly independent of
>   -fsanitize=local-bounds:
>   fs/select.c:625:5: error: stack frame size (336) exceeds limit (100) in 'core_sys_select' [-Werror,-Wframe-larger-than]
> int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
>   fs/select.c:479:21: error: stack frame size (684) exceeds limit (100) in 'do_select' [-Werror,-Wframe-larger-than]
> static noinline int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)

I think this approach makes the most sense to me; the caller
core_sys_select() has a large stack allocation `stack_fds`, and so
does the callee do_select with `table`.  Add in inlining and long live
ranges and it makes sense that stack spills are going to tip us over
the threshold set by -Wframe-larger-than.

Whether you make do_select() `noinline_for_stack` conditional on
additional configs like CC_IS_CLANG or CONFIG_UBSAN_LOCAL_BOUNDS is
perhaps also worth considering.

How would you feel about a patch that:
1. reverts commit ad312f95d41c ("fs/select: avoid clang stack usage warning")
2. marks do_select noinline_for_stack

?

I assume the point of "small string optimization" going on with
`stack_fds` in core_sys_select() is that the potential overhead for
kmalloc is much much higher than the cost of not inlining do_select()
into core_sys_select().  The above approach does solve this .config's
instance, and seems slightly less brittle to me.

>   However, I don't even see how this makes sense at all, given that
>   the actual frame size should be at least SELECT_STACK_ALLOC!

I think the math checks out:

#define FRONTEND_STACK_ALLOC  256
#define SELECT_STACK_ALLOC  FRONTEND_STACK_ALLOC
long stack_fds[SELECT_STACK_ALLOC/sizeof(long)];

sizeof(long) == 4; // i386 ilp32
sizeof(stack_fds) == sizeof(long) * 256 / sizeof(long) == 256

>
> - The behavior of -ftrivial-auto-var-init= is a bit odd here: with =zero or
>   =pattern, the stack usage is just below the limit (1020), without the
>   option it is up to 1044. It looks like your .config picks =zero, which
>   was dropped in the latest clang version, so it falls back to not

Huh? What do you mean by "was dropped?"

The config I sent has:
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_ZERO=y

Disabling INIT_STACK_ALL_ZERO from the config provided doesn't elide
the diagnostic.
Enabling INIT_STACK_ALL_PATTERN does... explicit stack allocations in
IR haven't changed. In the generated assembly we're pushing 3x 4B
GPRs, subtracting 8B from the stack pointer, then another 1008B.
(Filed: https://github.com/llvm/llvm-project/issues/58237)
So that's 3 * 4B + 8B + 1008B == 1028.  But CONFIG_FRAME_WARN is set
to 1024.  I wonder if this diagnostic is not as precise as it could
be, or my math is wrong?

It looks like for arrays INIT_STACK_ALL_PATTERN uses memset to fill
the array with 0xFF rather than 0x00 used by INIT_STACK_ALL_ZERO. Not
sure why that would make a difference, but curious that it does.
Looking at the delta in the (massive) IR between the two, it looks
like the second for loop preheader and body differ. That's going to
result in different choices by the register allocator.  The second
loop is referencing `can_busy_loop`, `busy_flag`, and `retval1` FWICT
when looking at IR. That looks like one of the loops in do_select.

>   initializing. Setting it to =pattern should give you the old
>   behavior, but I don't understand why clang uses more stack without
>   the initialization, rather than using less, as it would likely cause
>   fewer spills
>
>        Arnd



-- 
Thanks,
~Nick Desaulniers
