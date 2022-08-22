Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA47659CC94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 01:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbiHVXzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 19:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbiHVXzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:55:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6C52FE9
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 16:55:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s6so6217957lfo.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 16:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=niLyS67g7armALDit3lWWwA/6MSSHSl2h7o2NXDxzOY=;
        b=Ab/JGunfBkj09p8UYHG+04gv816Wj6N7QlDDVVmzM4DFI5gLIqcVRpnuYpYDw4zN9Z
         GC9DTAq+2w/DGPakMHbgeqIEa04A3tzy5mxAo2FPHW9PtLJK5/LHo73RxYC61jrvd9tD
         H/zdqD6e5RJqffQ4sqcDj7ewWi1otnmiDVBH/mQClKCeYi/oQnWx5RhAn+Y7IoQbgtNQ
         2fM7FGnz3W4Jcxkcj0tbA39mtRCU9YQ+2J/Qh646fdCl3xiMG+XJUu80H6qsHSXu5FZu
         +YrxVK8USlIJxZ95dKRbjR0g42EEIlmTQkvNsmDimAbDB6uNwAfyIS5mrzzQhuR3Dc83
         QOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=niLyS67g7armALDit3lWWwA/6MSSHSl2h7o2NXDxzOY=;
        b=1lNTQv478VZJz7Irp0NjMLB6ovnYlYphfkxz62nnqOPCdkIW8mwN2v7U6KNhmLifL0
         +W7q/n5VwdnANuDymdBXEKFczKJE6VqUrFHPhqJTGzwaRdU9AhJW9xc/qvvkpVGu2N9h
         hRTB1CXYEi3jAiR+n6JyhaSNFKp7JEeWmEyxUJS071M0VGSRQIVZXrn51B2086sZBIIC
         PSmmDev1iLXG97+6QrpEpb2HCAkvVAnI0i4VshU1SmZ5ZrIlcvtHF9UzYvoQdFQMxYuT
         lRQTAwg9gvRDBKIk5eJD4C5/DAi8BdAud66P+GXvXdRGPByaZxwQ/dDSPXZcxt7OGKZ7
         3r+A==
X-Gm-Message-State: ACgBeo3MWnV7q8L3ERRNZCjZZMD7IVCYPXkeEE8rwWOAlnl3rMuSJdv+
        dLLeTpxeqEOdIarTh3zcjp+5hMqDOVi8iFeOMVSKSw==
X-Google-Smtp-Source: AA6agR5apkHpwR0VwjGEEi6Q1l+gdgRdLUzQTlqNRG4Scr/20JoVUR8iHBbZdYKS7e/RZBvAA1BDCYIuwOH1X5uEI6o=
X-Received: by 2002:a05:6512:29c:b0:492:db8e:5e77 with SMTP id
 j28-20020a056512029c00b00492db8e5e77mr3555610lfp.403.1661212528009; Mon, 22
 Aug 2022 16:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-10-ojeda@kernel.org>
In-Reply-To: <20220805154231.31257-10-ojeda@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Aug 2022 16:55:15 -0700
Message-ID: <CAKwvOd=q0uErrBVadCbVVLyTzvXxmgJSdOyRHqahO5at8enN6w@mail.gmail.com>
Subject: Re: [PATCH v9 09/27] rust: add `compiler_builtins` crate
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 5, 2022 at 8:44 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Rust provides `compiler_builtins` as a port of LLVM's `compiler-rt`.
> Since we do not need the vast majority of them, we avoid the
> dependency by providing our own crate.
>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

I still really really do not like this patch. Thoughts below.

> ---
>  rust/compiler_builtins.rs | 63 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 rust/compiler_builtins.rs
>
> diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
> new file mode 100644
> index 000000000000..f8f39a3e6855
> --- /dev/null
> +++ b/rust/compiler_builtins.rs
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Our own `compiler_builtins`.
> +//!
> +//! Rust provides [`compiler_builtins`] as a port of LLVM's [`compiler-rt`].
> +//! Since we do not need the vast majority of them, we avoid the dependency
> +//! by providing this file.
> +//!
> +//! At the moment, some builtins are required that should not be. For instance,
> +//! [`core`] has 128-bit integers functionality which we should not be compiling

It's not just 128b, these are for double word sizes, so for 32b
targets (I recall an earlier version of series supporting armv6) these
symbols are for 64b types.

> +//! in. We will work with upstream [`core`] to provide feature flags to disable
> +//! the parts we do not need. For the moment, we define them to [`panic!`] at

Where is the bug filed upstream (or in your issue tracker)?

> +//! runtime for simplicity to catch mistakes, instead of performing surgery
> +//! on `core.o`.

Wait, so Kbuild performs surgery on alloc, but core is off limits? bah

Core is huge!
$ du -h rust/core.o
1.3M    rust/core.o

> +//!
> +//! In any case, all these symbols are weakened to ensure we do not override
> +//! those that may be provided by the rest of the kernel.
> +//!
> +//! [`compiler_builtins`]: https://github.com/rust-lang/compiler-builtins
> +//! [`compiler-rt`]: https://compiler-rt.llvm.org/
> +
> +#![feature(compiler_builtins)]
> +#![compiler_builtins]
> +#![no_builtins]
> +#![no_std]
> +
> +macro_rules! define_panicking_intrinsics(
> +    ($reason: tt, { $($ident: ident, )* }) => {
> +        $(
> +            #[doc(hidden)]
> +            #[no_mangle]
> +            pub extern "C" fn $ident() {
> +                panic!($reason);
> +            }
> +        )*
> +    }
> +);
> +
> +define_panicking_intrinsics!("`f32` should not be used", {
> +    __eqsf2,

I don't see ^ this symbol in core.

$ llvm-nm rust/core.o | grep "U __" | sort | tr -s " "
 U __gesf2
 U __lesf2
 U __udivti3
 U __umodti3
 U __unorddf2
 U __unordsf2
 U __x86_indirect_thunk_r11

so a few of these seem extraneous. Are you sure they're coming from
core? (or was it the different arch support that was removed from v8
to facilitate v9?)

__gesf2, __lesf2, and __unordsf2 all seem to be coming from
<<f32>::classify> and <<f32>::to_bits::ct_f32_to_u32>.  Surely we can
avoid more f32 support by relying on objcopy
-N/--strip-symbol=/--strip-symbols=filename to slice out/drop symbols
from core.o?

<core::fmt::num::exp_u128> uses __umodti3+__udivti3

__unorddf2 is referenced by <<f64>::classify> and
<<f64>::to_bits::ct_f64_to_u64>.

Can we slice those 5 symbols out from core, or are they further
referenced from within core?  If we can, we can drop this patch
outright, and avoid a false-negative when C code generates references
to these symbols from the compiler runtime, for architectures where
don't want to provide a full compiler runtime.  (--rtlib=none is a
pipe dream; first we need to get to the point where we're not
-ffreestanding for all targets...)

I suspect someone can iteratively whittle down core to avoid these symbols?

```
diff --git a/rust/Makefile b/rust/Makefile
index 7700d3853404..e64a82c21156 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -359,6 +359,7 @@ $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs
$(obj)/target.json FORCE
 $(obj)/compiler_builtins.o: private rustc_objcopy = -w -W '__*'
 $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
        $(call if_changed_dep,rustc_library)
+       @$(OBJCOPY) --strip-symbols=$(obj)/strip-symbols.txt $(obj)/core.o

 $(obj)/alloc.o: private skip_clippy = 1
 $(obj)/alloc.o: private skip_flags = -Dunreachable_pub
```
then define symbols in rust/strip-symbols.txt?

I'm getting the sense that no, there are many functions like
<usize as core::fmt::UpperExp>::fmt
<i64 as core::fmt::UpperExp>::fmt
<u64 as core::fmt::UpperExp>::fmt

that call many of these functions...so if you call format! on an
i64/u64/usize you'll potentially panic the kernel? Seems kinda
dangerous.

I'm also seeing disassemblers having trouble completely disassembling
core.o ... the more I look to see who's calling what, the more
instances I find...

> +    __gesf2,
> +    __lesf2,
> +    __nesf2,
> +    __unordsf2,
> +});
> +
> +define_panicking_intrinsics!("`f64` should not be used", {
> +    __unorddf2,
> +});
> +
> +define_panicking_intrinsics!("`i128` should not be used", {
> +    __ashrti3,
> +    __muloti4,
> +    __multi3,
> +});
> +
> +define_panicking_intrinsics!("`u128` should not be used", {
> +    __ashlti3,
> +    __lshrti3,
> +    __udivmodti4,
> +    __udivti3,
> +    __umodti3,
> +});
> --
> 2.37.1
>


-- 
Thanks,
~Nick Desaulniers
