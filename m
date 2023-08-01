Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9DB76A5E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 03:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjHABC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 21:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHABC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:02:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA46E67;
        Mon, 31 Jul 2023 18:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3216961378;
        Tue,  1 Aug 2023 01:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1417AC433C8;
        Tue,  1 Aug 2023 01:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690851774;
        bh=Qm+tfMP3bEHNp+bQ9ZudUtuf3evUcVZ+4G2yoEEnB9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=atAtPDCg9fybUyEOQSa6/n0+tjVkMVyf+w+V4I/lOLbTPXYoq0Bjc1z4Z9uRvL9Wl
         5JJRxOCaKXRn9Bp6eOM7eZvgL6HIpK0KTp+Y7nsGkLr1M6V5DGXhWJUphLDnB3ZHiT
         nNOPhhcxTkJAnoaY+ZS0xCBWbz+LHOs+olvKfuFbniXdb0NUMdU4XT1lJJu1dsauV/
         r3kRk0bwB6kWzmgX2aYtPxX+/71ViYsU8n3FhwFbk6IAk1D2fZfHWhVLfPAHNFEoHm
         mveJRkLtwEaP7bp0NMNZUrOG5ig+x5zVazs/2vUTHRLMn76dnhJpGMN37dl+Gbu5BX
         ATzcgLNuZYtkw==
Date:   Tue, 1 Aug 2023 10:02:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com, arnd@kernel.org,
        ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH RFC v2 bootconfig 1/3] doc: Update /proc/cmdline
 documentation to include boot config
Message-Id: <20230801100249.5877631a7b3aefe911c3e9af@kernel.org>
In-Reply-To: <20230731233130.424913-1-paulmck@kernel.org>
References: <db98cbbf-2205-40d2-9fa1-f1c135cc151c@paulmck-laptop>
        <20230731233130.424913-1-paulmck@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 31 Jul 2023 16:31:28 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Update the /proc/cmdline documentation to explicitly state that this
> file provides kernel boot parameters obtained via boot config from the
> kernel image as well as those supplied by the boot loader.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Arnd Bergmann <arnd@kernel.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  Documentation/filesystems/proc.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 7897a7dafcbc..75a8c899ebcc 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -686,7 +686,8 @@ files are there, and which are missing.
>   apm          Advanced power management info
>   buddyinfo    Kernel memory allocator information (see text)	(2.5)
>   bus          Directory containing bus specific information
> - cmdline      Kernel command line
> + cmdline      Kernel command line, both from bootloader and embedded
> + 	      in the kernel image.
>   cpuinfo      Info about the CPU
>   devices      Available devices (block and character)
>   dma          Used DMS channels
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
