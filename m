Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94C27BC3E2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 03:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjJGBtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 21:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJGBtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:49:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0BABD;
        Fri,  6 Oct 2023 18:48:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60311C433C8;
        Sat,  7 Oct 2023 01:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696643338;
        bh=peEaFP82dShEJPdQRQjOTraaw9IlSG6OaEkp5YYnl+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oaY7WRrCrZoDSs3ZsjVVbyUQEObJqLSr3gCJDqZB1Ca+N3p/YDVtOgmWkKtJnwWrj
         M6Pwlsug/2JGr9UpYS+khj8MGB9UA5LjZXrLYbPftmQI+gB2Su4kpLTSmj38ZWVuy1
         eYFzI5Xrh3kYmpnn2I96YjcPe2BXcCH49lPQoZJhFKNeBI/wtXG0kBjRdbY1zs6SAw
         qrgT7Xln/2ocaQBp3EaWFELpPd1Tc3Al/GoxQUmZzKndaenIxO/DLfiJJbXOt9vP/i
         UVTd9Y7ZNzV7hm8h8NzNoas4aaHkkRiuMxUzlO3KzMBFRBaVsONmvI9YdzwM7bGmh3
         hJ/fs40b0aQIA==
Date:   Sat, 7 Oct 2023 10:48:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH bootconfig 1/3] doc: Update /proc/cmdline documentation
 to include boot config
Message-Id: <20231007104853.c27c8e57ef2896a5aad72270@kernel.org>
In-Reply-To: <20231005171747.541123-1-paulmck@kernel.org>
References: <6ea609a4-12e3-4266-8816-b9fca1f1f21c@paulmck-laptop>
        <20231005171747.541123-1-paulmck@kernel.org>
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

On Thu,  5 Oct 2023 10:17:45 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Update the /proc/cmdline documentation to explicitly state that this
> file provides kernel boot parameters obtained via boot config from the
> kernel image as well as those supplied by the boot loader.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Arnd Bergmann <arnd@kernel.org>
> ---
>  Documentation/filesystems/proc.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 2b59cff8be17..5703b0e87cbe 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -691,7 +691,8 @@ files are there, and which are missing.
>   apm          Advanced power management info
>   buddyinfo    Kernel memory allocator information (see text)	(2.5)
>   bus          Directory containing bus specific information
> - cmdline      Kernel command line
> + cmdline      Kernel command line, both from bootloader and embedded
> + 	      in the kernel image

BTW, as same as the other lines, I changed this to white spaces instead
of tabs.

>   cpuinfo      Info about the CPU
>   devices      Available devices (block and character)
>   dma          Used DMS channels
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
