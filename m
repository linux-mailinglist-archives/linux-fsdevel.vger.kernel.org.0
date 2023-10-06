Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DEF7BB3AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 11:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjJFI76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 04:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjJFI74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:59:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB4793;
        Fri,  6 Oct 2023 01:59:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29AFC433C7;
        Fri,  6 Oct 2023 08:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696582794;
        bh=ZRZ4zoIUrHvuhR7yir1ccOBONWXMYWEbomq4C32pLnc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VlgUW7LXE3NK3DFuR9GpzTXztcP+gwPt8hH0bcesUwEtCog5ycJc1rulxKq56T0Zn
         uQNAMZxQsxFbWb/t254r8A7PdDde8ZvBqIni5WbsBICf2nJJLoHNC5Tahog+qcCSXK
         FaAR1JipdGVB1eJ9GWN1ArOFEb4MTJsr9XMysesZkw0LneLQ3Qv80+J/P131yLxpo1
         KKb678z/Hy7PBSBuRk8X9Li4fKQ/Ak0SlrxlAbD4LaJw6cEly6+gtChRpommr9uIGX
         ASb9M+P8VgKLaEGKznXrgd69lHrfFjKwqjGpSvpBhZPlKIovSGV6Rr54yUk0au5bfH
         5Kzo8LwbvZ5xw==
Date:   Fri, 6 Oct 2023 17:59:48 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bootconfig 2/3] fs/proc: Add boot loader arguments as
 comment to /proc/bootconfig
Message-Id: <20231006175948.14df07948d8c6a4a46473c13@kernel.org>
In-Reply-To: <20231005171747.541123-2-paulmck@kernel.org>
References: <6ea609a4-12e3-4266-8816-b9fca1f1f21c@paulmck-laptop>
        <20231005171747.541123-2-paulmck@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu,  5 Oct 2023 10:17:46 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
> show all kernel boot parameters, both those supplied by the boot loader
> and those embedded in the kernel image.  This works well for those who
> just want to see all of the kernel boot parameters, but is not helpful to
> those who need to see only those parameters supplied by the boot loader.
> This is especially important when these parameters are presented to the
> boot loader by automation that might gather them from diverse sources.
> It is also useful when booting the next kernel via kexec(), in which
> case it is necessary to supply only those kernel command-line arguments
> from the boot loader, and most definitely not those that were embedded
> into the current kernel.
> 
> Therefore, add comments to /proc/bootconfig of the form:
> 
> 	# Parameters from bootloader:
> 	# root=UUID=ac0f0548-a69d-43ca-a06b-7db01bcbd5ad ro quiet ...
> 
> The second added line shows only those kernel boot parameters supplied
> by the boot loader.

Thanks for update it.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> Link: https://lore.kernel.org/all/CAHk-=wjpVAW3iRq_bfKnVfs0ZtASh_aT67bQBG11b4W6niYVUw@mail.gmail.com/
> Link: https://lore.kernel.org/all/20230731233130.424913-1-paulmck@kernel.org/
> Co-developed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: <linux-trace-kernel@vger.kernel.org>
> Cc: <linux-fsdevel@vger.kernel.org>
> ---
>  fs/proc/bootconfig.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> index 2e244ada1f97..902b326e1e56 100644
> --- a/fs/proc/bootconfig.c
> +++ b/fs/proc/bootconfig.c
> @@ -62,6 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
>  				break;
>  			dst += ret;
>  		}
> +		if (ret >= 0 && boot_command_line[0]) {
> +			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> +				       boot_command_line);
> +			if (ret > 0)
> +				dst += ret;
> +		}
>  	}
>  out:
>  	kfree(key);
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
