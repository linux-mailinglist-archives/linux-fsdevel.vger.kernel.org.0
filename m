Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0963A8A6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 22:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFOUtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 16:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOUtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:49:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB0C061574;
        Tue, 15 Jun 2021 13:47:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v9so69722wrx.6;
        Tue, 15 Jun 2021 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pv+gm9xDaMhQpoizgc0lp2cOTulVOFNanGwYqtdnjlI=;
        b=qT1amIc0uTPuqFTDflzSF7bcrf/Ppt5Idz9VagguvZdVZ4iVWgGgBCwcGhTiSEnUCq
         EydrtbiroD30qLVHoJhc3jRfg4s9MT492ziZwMhAVFybsr5EojFt/5KmrtfGbolmrXBH
         b9fx6T2HrUCeRxkXyEFdR2ESoOF02uEqIKB+Vg/aLXUy0mZVFkjZYL12UkbeNVIomffp
         /12nRJ1cwn99qq5OtJN0gIV9Umuve9uAnU6GXmTV5NyB5onGTPMzioWN01kSaVL5Ldn9
         GkI+26T6EDAPGzZf4LlZVT0+vT1RxuG3BgSGELRNnkWUeh2d43P0vyXyh9tRwgfjVMuT
         cX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pv+gm9xDaMhQpoizgc0lp2cOTulVOFNanGwYqtdnjlI=;
        b=Vlkat6Ym6IgIubWykDSJmgOOu986bloIs9BVJKx5bL845rGaSV0wPCMbwraTDXnJyr
         76ChjvcnRTc9CIqsPC6M7ZMAqe8GEh3M4G/0X5H47wwlNCrH3dfvIsERdYWb3waWpdjB
         NrGUFM17FMisQ14q1RLt07V1Uao3T47g9dR2aB0eEb/wVim8HK5IbZvwhcf3BCf3xI5P
         KDfSnSXBMInA9PmmbHB8MF2JwBZL4/H2JpuMREbFYp1DakOhX3Cwpdr3cuNM+YeAoW4T
         zWogpEdkeZJU48gbLfUXgk0ytBdGQhng5XAtanl2Y2BGZQb2bQoyK7kGgBc4QkNe9Giv
         d6qw==
X-Gm-Message-State: AOAM531ztB45hxMEfBKR5lT/gMlf/zsSRr5eIu0zmROKKPXbAKeu/9+i
        PSGvyz/fTYd1rcW2S7kIcqMpQThFJssB3ZrxdWA=
X-Google-Smtp-Source: ABdhPJzi4dNLm8JUfC/BUZyZh05JZKtpCZuUVzJwHYKgnbzLCUnkN7wCA04TN40B4Xohixcq2Ba6Z3aEimcXDivJv8I=
X-Received: by 2002:adf:f6d1:: with SMTP id y17mr1170948wrp.250.1623790065304;
 Tue, 15 Jun 2021 13:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210615154952.2744-1-justin.he@arm.com> <20210615154952.2744-5-justin.he@arm.com>
In-Reply-To: <20210615154952.2744-5-justin.he@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Jun 2021 23:47:29 +0300
Message-ID: <CAHp75VeB68UUfz=6dO31zf59p6_5wGBX7etWJEV_xtLYsy=hBQ@mail.gmail.com>
Subject: Re: [PATCH RFCv4 4/4] lib/test_printf.c: add test cases for '%pD'
To:     Jia He <justin.he@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 6:55 PM Jia He <justin.he@arm.com> wrote:
>
> After the behaviour of specifier '%pD' is changed to print full path
> of struct file, the related test cases are also updated.
>
> Given the string of '%pD' is prepended from the end of the buffer, the
> check of "wrote beyond the nul-terminator" should be skipped.
>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  lib/test_printf.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index d1d2f898ebae..9f851a82b3af 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -16,6 +16,7 @@
>
>  #include <linux/bitmap.h>
>  #include <linux/dcache.h>
> +#include <linux/fs.h>
>  #include <linux/socket.h>
>  #include <linux/in.h>
>
> @@ -34,6 +35,7 @@ KSTM_MODULE_GLOBALS();
>
>  static char *test_buffer __initdata;
>  static char *alloced_buffer __initdata;
> +static bool is_prepended_buf __initdata;
>
>  extern bool no_hash_pointers;
>
> @@ -78,7 +80,7 @@ do_test(int bufsize, const char *expect, int elen,
>                 return 1;
>         }
>
> -       if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {

> +       if (!is_prepended_buf && memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {

Can it be parametrized? I don't like the custom test case being
involved here like this.

>                 pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
>                         bufsize, fmt);
>                 return 1;
> @@ -501,6 +503,27 @@ dentry(void)
>         test("  bravo/alfa|  bravo/alfa", "%12pd2|%*pd2", &test_dentry[2], 12, &test_dentry[2]);
>  }
>
> +static struct vfsmount test_vfsmnt __initdata = {};
> +
> +static struct file test_file __initdata = {
> +       .f_path = { .dentry = &test_dentry[2],
> +                   .mnt = &test_vfsmnt,
> +       },
> +};
> +
> +static void __init
> +f_d_path(void)
> +{
> +       test("(null)", "%pD", NULL);
> +       test("(efault)", "%pD", PTR_INVALID);
> +
> +       is_prepended_buf = true;
> +       test("/bravo/alfa   |/bravo/alfa   ", "%-14pD|%*pD", &test_file, -14, &test_file);
> +       test("   /bravo/alfa|   /bravo/alfa", "%14pD|%*pD", &test_file, 14, &test_file);
> +       test("   /bravo/alfa|/bravo/alfa   ", "%14pD|%-14pD", &test_file, &test_file);
> +       is_prepended_buf = false;
> +}
> +
>  static void __init
>  struct_va_format(void)
>  {
> @@ -784,6 +807,7 @@ test_pointer(void)
>         ip();
>         uuid();
>         dentry();
> +       f_d_path();
>         struct_va_format();
>         time_and_date();
>         struct_clk();
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
