Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCE67BC3E8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 03:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjJGBvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 21:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjJGBvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:51:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FBABD;
        Fri,  6 Oct 2023 18:51:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3EBC433C7;
        Sat,  7 Oct 2023 01:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696643512;
        bh=ErPazlwhjvz9kGy4iLg/Jm3FSU96a/eWlLfpVkMdzbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FDWzb4eVc9PPxx+nKn0Qtnet/vMwrdb76XUqpQ6+qpDOMnvcbCKncmFQsRTrY5SXn
         Tm0gMpShqCR46GfBiVklGvQUPhpnbvDZDxwy69GucjeltRbsQwPPMZWEEyqwRaJpNG
         /vWIUW5/4p9NNhKhdgLHBYOdzA8+o4GOpDt2OEdJbZLCO3QFcHWtv4ou2ZH6BO8bdt
         kBB4PfaMY7jl6HLi/7SdIXOikBuigjLQIus7Ovvkw3Wqdm67az+YrmPeBAdY9ggrvF
         kVzmJNctU98KDmK1HxhoNQhytoj+sDHr93bCZ2SmlwFyGckDGu42opUoEc8JVczUnT
         wPCFWJQLGOykQ==
Date:   Sat, 7 Oct 2023 10:51:47 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH bootconfig 3/3] doc: Add /proc/bootconfig to proc.rst
Message-Id: <20231007105147.9e34656f36a9b3ab090ffe85@kernel.org>
In-Reply-To: <20231005171747.541123-3-paulmck@kernel.org>
References: <6ea609a4-12e3-4266-8816-b9fca1f1f21c@paulmck-laptop>
        <20231005171747.541123-3-paulmck@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu,  5 Oct 2023 10:17:47 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Add /proc/bootconfig description to Documentation/filesystems/proc.rst.
> 
> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Documentation/filesystems/proc.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 5703b0e87cbe..a2c160f29632 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -689,6 +689,11 @@ files are there, and which are missing.
>   File         Content
>   ============ ===============================================================
>   apm          Advanced power management info
> + bootconfig   Kernel command line obtained from boot config,
> + 	      and, if there were kernel parameters from the
> +	      boot loader, a "# Parameters from bootloader:"
> +	      line followed by a line containing those
> +	      parameters prefixed by "# ".			(5.5)

Ditto. Curiously, in this part of the document, the tail spaces until "(5.5)"
are using tabs, but the head spaces are using whitespaces. So updated it.
I noticed that a warning message when I imported it to my bootconfig/for-next
branch.

Thank you,

>   buddyinfo    Kernel memory allocator information (see text)	(2.5)
>   bus          Directory containing bus specific information
>   cmdline      Kernel command line, both from bootloader and embedded
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
