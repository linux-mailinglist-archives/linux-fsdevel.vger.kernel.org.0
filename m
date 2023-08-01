Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B24D76A6A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 04:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjHACAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 22:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjHACAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:00:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557751BC8;
        Mon, 31 Jul 2023 19:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=C+JhNKpPPGmU4tqZQSFhqIVkQYav4iN5rmg1RoWtze0=; b=CLXqBAzpsLNHJkakOyMo9LmfTu
        yjnwYlmnVHa35Y3++vCkIS3snCGAq2S5czi1+/ekBe1MtBKMzRCnfU/ySaI7SvEPPZcmlz/0Hdadc
        ZjRfN8TMZJAuCWV2aESadsx/AnzZjvV8Ag2QBbAIESP+05ZeLxMCa2hP4103NC2+Iqmed9A00e7vO
        OUOSx8ctTlBqTk3og45Cr4oI4koDoIOOK3rfl1L27xYIfw3KfoQu/fzW6tiij8rd1hN8JcFzKrwvg
        MemEAtbwRYECiof445u079leNr+qjTXueTqWmPXygfN7WZ7VqAk6gIvr4xqc2JNvncTzlnekzygs3
        GjVRC/QA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQegR-000AgP-1K;
        Tue, 01 Aug 2023 02:00:23 +0000
Message-ID: <7bace63d-4e41-94d6-3d82-b3498864926e@infradead.org>
Date:   Mon, 31 Jul 2023 19:00:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v2 bootconfig 1/3] doc: Update /proc/cmdline
 documentation to include boot config
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, akpm@linux-foundation.org,
        adobriyan@gmail.com, mhiramat@kernel.org
Cc:     arnd@kernel.org, ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Jonathan Corbet <corbet@lwn.net>
References: <db98cbbf-2205-40d2-9fa1-f1c135cc151c@paulmck-laptop>
 <20230731233130.424913-1-paulmck@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230731233130.424913-1-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/31/23 16:31, Paul E. McKenney wrote:
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

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

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

-- 
~Randy
