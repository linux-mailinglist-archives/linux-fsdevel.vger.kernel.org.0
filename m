Return-Path: <linux-fsdevel+bounces-63008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4492FBA8B10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728D33A77CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7892D663F;
	Mon, 29 Sep 2025 09:38:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3B2C15B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138713; cv=none; b=smCLkdURzIPFzPbg6G1VBIsH3MLPSJ7jMMdROHF//EjNmwZDjN1r4qEcFDEqzqVG8ErY3U5uD2bY3yM1pveGV835FA8oYju6TgzX2np733/aOav3rpbRTGLvM/76f7EbItQuoUOF8SgwxzY+BGWj0CWYd8FQEVa5gIN3dhKWQEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138713; c=relaxed/simple;
	bh=o0IirqPLTD59VJ0fkv+jMuzLOTY7bT4uP9ThimL+zio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVn9Ul99Y7dj4brHqaiAAZZ0UqyRe3YVFzvbpbEPCfKD37EjCxwwWCK7/7vF6AzINlKzKRsTagIh6VUpzqYd3iaJO2Twvxi/n4QY/288Uv5OZf/EjZEMmLdaRmDo+HQKUuJEyZQ3meDPexgCGBHUdZy1QNYKDTrkZbT6sZ5KQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54aa6a0babeso3966714e0c.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 02:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138711; x=1759743511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZOWUVpIw61KHM85AdnPz6vomTChz2t/QIwYRGjaPM8=;
        b=mfvlbT8P86ACY7SdV4LWW/x1XsN/Wfexu2Y0WfmUJAi3D1O2gzuyTeSzxxpZIqK2Cj
         DGnEjpMHk2ZorEUKbopQWHkQhU/9zg9afLRdocFEAstra69QU9TyRrg6XYLH1SWgoa5a
         ygPX6c3na9fCd/LEqZ7Fj9k/aeuvyOuDz+hwyWkDp1KGGHjCdokE4mylE+2SJjKI4+Fv
         iA/HuZWb7/Sp20Sjn9akkjdfJffQiy215+eNoZMUYuUS/3Ol/YGrgxMG2SfNcfZv6fwm
         oc3m8BDooktVdp4MDi72Z8DmIOdg8Zg0+WvkPeZZ1qZU2hJNW6SXHZSwL3rqSQg6abhE
         D0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXohh4m+BySx09cJU9etkVc7aoScCHUhS+QAefvUekh6ij8JVSR/xd0aeoVnEK0+ONGkWxbawHxfs0yaA/@vger.kernel.org
X-Gm-Message-State: AOJu0YzHFMIkELex8Nm1Kj6HNOEv2eudH+CZ3F7WJz+Jg6/D6SBWcmhc
	h0IdqEFsw+cQhmYvr26XChQ0+KdKL/aPRbEzu5KVo4Dxhhc+jLlBGreGLnXfp59u
X-Gm-Gg: ASbGncv0DBvd0dJcKZfTgrh21y87DWW5ozDznK4MgCpPK0PS3hs2VP4PBmt15FNvhh+
	BfZSizRsIaddN9bxOP+Ek48mt45WUsNWL6hjuNhGmlTPWQJqSqBHnF9MMFvrYuWpuvjAMrAfSaQ
	iK7rjRuL2NAWM+ia3+V5rbjOMDNJHGyqBcB5BmF7n9YvCBs1EupfuOYMxEiujC8hJD03wM0VKuF
	XcmG5hBHK2xsvjqRocQUnBvV/DXPs90s3MRd7KWM1EY5k2QX+w2oN7sjzZRUBLfBC2yCF+CTezk
	oZxd4OQLBWjwu1FegzaZtvwpQfa2bDpzb14PujT9H/ax+x2sK0Vc7wd2SCprJ0uW1oF4qL8qXpn
	5wbfj339VLGLRtSPjBLy2oS1g5DSz8sajbHD0tkB2HU9iQWREs6GG0Cd/eu2vuSpRvCqvido=
X-Google-Smtp-Source: AGHT+IExgcKeCUaNsmiQvfV0HUfplrSN3tSCOr0kNlOBJBSov8MTw/yfmd2ADyrVqogNVh/79sjprQ==
X-Received: by 2002:a05:6122:2c31:b0:54a:8deb:21a7 with SMTP id 71dfb90a1353d-54c0c3d487bmr2164148e0c.4.1759138710555;
        Mon, 29 Sep 2025 02:38:30 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bed8a1775sm2179933e0c.8.2025.09.29.02.38.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 02:38:29 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8eafd5a7a23so2360094241.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 02:38:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoV2m7onfaYIAN/0moQl6rwrSjoyyPxa/tftOPtlJpl3dTb009cnzwpWJD2J1Zc6bL6X1KP1uGR1eg1flr@vger.kernel.org
X-Received: by 2002:a05:6102:44da:10b0:5cd:e513:384d with SMTP id
 ada2fe7eead31-5cde51341ffmr109116137.0.1759138709242; Mon, 29 Sep 2025
 02:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916163004.674341701@linutronix.de> <20250916163252.100835216@linutronix.de>
 <20250916184440.GA1245207@ax162> <87ikhi9lhg.ffs@tglx> <87frcm9kvv.ffs@tglx>
In-Reply-To: <87frcm9kvv.ffs@tglx>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 11:38:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
X-Gm-Features: AS18NWBdCAubwt71LwkVRoRA7LVpa5BFQK_dgundxdrnw5KTmaxVCF_m7ZP3vyo
Message-ID: <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
Subject: Re: [patch V2a 2/6] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang <
 version 17
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Wed, 17 Sept 2025 at 07:51, Thomas Gleixner <tglx@linutronix.de> wrote:
> clang < 17 fails to use scope local labels with CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y:
>
>      {
>         __label__ local_lbl;
>         ...
>         unsafe_get_user(uval, uaddr, local_lbl);
>         ...
>         return 0;
>         local_lbl:
>                 return -EFAULT;
>      }
>
> when two such scopes exist in the same function:
>
>   error: cannot jump from this asm goto statement to one of its possible targets
>
> There are other failure scenarios. Shuffling code around slightly makes it
> worse and fail even with one instance.
>
> That issue prevents using local labels for a cleanup based user access
> mechanism.
>
> After failed attempts to provide a simple enough test case for the 'depends
> on' test in Kconfig, the initial cure was to mark ASM goto broken on clang
> versions < 17 to get this road block out of the way.
>
> But Nathan pointed out that this is a known clang issue and indeed affects
> clang < version 17 in combination with cleanup(). It's not even required to
> use local labels for that.
>
> The clang issue tracker has a small enough test case, which can be used as
> a test in the 'depends on' section of CC_HAS_ASM_GOTO_OUTPUT:
>
> void bar(void **);
> void* baz();
>
> int  foo (void) {
>     {
>             asm goto("jmp %l0"::::l0);
>             return 0;
> l0:
>             return 1;
>     }
>     void *x __attribute__((cleanup(bar))) = baz();
>     {
>             asm goto("jmp %l0"::::l1);
>             return 42;
> l1:
>             return 0xff;
>     }
> }
>
> Add another dependency to config CC_HAS_ASM_GOTO_OUTPUT for it and use the
> clang issue tracker test case for detection by condensing it to obfuscated
> C-code contest format. This reliably catches the problem on clang < 17 and
> did not show any issues on the non known to be broken GCC versions.
>
> That test might be sufficient to catch all issues and therefore could
> replace the existing test, but keeping that around does no harm either.
>
> Thanks to Nathan for pointing to the relevant clang issue!
>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1886
> Link: https://github.com/llvm/llvm-project/commit/f023f5cdb2e6c19026f04a15b5a935c041835d14

Thanks for your patch, which is now commit e2ffa15b9baa447e ("kbuild:
Disable CC_HAS_ASM_GOTO_OUTPUT on clang < 17") in v6.17.

> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -99,7 +99,10 @@ config GCC_ASM_GOTO_OUTPUT_BROKEN
>  config CC_HAS_ASM_GOTO_OUTPUT
>         def_bool y
>         depends on !GCC_ASM_GOTO_OUTPUT_BROKEN
> +       # Find basic issues
>         depends on $(success,echo 'int foo(int x) { asm goto ("": "=r"(x) ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
> +       # Detect buggy clang, fixed in clang-17
> +       depends on $(success,echo 'void b(void **);void* c();int f(void){{asm goto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto("jmp %l0"::::l1);return 2;l1:return 1;}}' | $(CC) -x c - -c -o /dev/null)

This is supposed to affect only clang builds, right?  I am using
gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04) to build for
arm32/arm64/riscv, and thus have:

    CONFIG_CC_IS_GCC=y

Still, this commit causes

    CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
    CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y

to disappear from my configs? Is that expected?

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

