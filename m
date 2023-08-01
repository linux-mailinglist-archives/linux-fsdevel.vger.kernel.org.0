Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3970876A5ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 03:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjHABFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 21:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHABFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:05:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC6E71;
        Mon, 31 Jul 2023 18:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4326F6137B;
        Tue,  1 Aug 2023 01:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74655C433C8;
        Tue,  1 Aug 2023 01:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690851904;
        bh=qoiJAbStOAZvf0uhHNpKHKN9NNZWfrfeHYJH9NL8v38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l95iStFF4xrr/O/ut4YDXaiLMjs3Y0NG01yd6s/xKHnZ7bz4wzVmNucumjyfqOLE5
         kQ3msRIlwXWUZGtGm2MWWaWAaKXR4VXA5KqjMRbTI0ZuyQE7dNHI96NQhNqzLltYk2
         C/PWM+bcYH/R3LQcXvxXvepz2m7wcV1lMiiZTJtTEEvvSfWtdoikA3A+rKq3zKaM0p
         0e2/bquyKUHwI9tw8barh1/nor834JQyHlkLi54zwR68fJrJ2g29HDHPx0Bv0es3wQ
         9shbMGP/Y/fXaCZLSBRaf3y7K3UPLtm78ASnHUQMihlZkVHxyCB+EIqZPiVohHoqo9
         jJ89ANcfCBJTA==
Date:   Tue, 1 Aug 2023 10:04:59 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com, arnd@kernel.org,
        ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC v2 bootconfig 3/3] doc: Add /proc/bootconfig to
 proc.rst
Message-Id: <20230801100459.97153e94f9e6c2cdbd727569@kernel.org>
In-Reply-To: <20230731233130.424913-3-paulmck@kernel.org>
References: <db98cbbf-2205-40d2-9fa1-f1c135cc151c@paulmck-laptop>
        <20230731233130.424913-3-paulmck@kernel.org>
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

On Mon, 31 Jul 2023 16:31:30 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Add /proc/bootconfig description to Documentation/filesystems/proc.rst.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


Thank you!

> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  Documentation/filesystems/proc.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index c2aee55248a8..4b9e9510a53f 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -684,6 +684,7 @@ files are there, and which are missing.
>   File         Content
>   ============ ===============================================================
>   apm          Advanced power management info
> + bootconfig   Kernel command line obtained from boot config	(5.5)
>   buddyinfo    Kernel memory allocator information (see text)	(2.5)
>   bus          Directory containing bus specific information
>   cmdline      Kernel command line, both from bootloader and embedded
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
