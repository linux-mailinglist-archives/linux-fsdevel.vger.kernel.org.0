Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49D076A7BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 06:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjHAEBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 00:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjHAEAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:00:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF190173E;
        Mon, 31 Jul 2023 21:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E36661444;
        Tue,  1 Aug 2023 04:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B825C433C7;
        Tue,  1 Aug 2023 04:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690862435;
        bh=yv9ncCe6SpB8LHTlifKO5Y47t/5ltvngYfZFrm5b8aA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=liCUHuos24Y2Rzze3/Eu9UE9BedLIaOaoRQ/ii9pxmVN2kJEDpCYTl4t/r7qN5pPO
         WY5fDsUbEDa2oLGt1NqiNHF51Krv17dCoJzTUBccBMSEYL7kprLSpxuwWhN44Zw5xi
         sxLQa8s7KNSXAF77+dbuO7cZ4Jg3iIOD1x76WXIXL6WeCUwXlRe7mjatEMcH1tGJWB
         9CpC1f2i52oV3+elf497Vc1mB7UH6tNHNz9dK+q9CoMS58eOe8c6pxaVmXph0+1cPz
         z0TH6eIPkim4dxwBnbb3hcZMFWNfbzT/zlaofYLxZj+eL83FpgVMaglj845LrOWVEa
         XidOjnaxgYcBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F17A7CE0975; Mon, 31 Jul 2023 21:00:34 -0700 (PDT)
Date:   Mon, 31 Jul 2023 21:00:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        mhiramat@kernel.org, arnd@kernel.org, ndesaulniers@google.com,
        sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH RFC v2 bootconfig 1/3] doc: Update /proc/cmdline
 documentation to include boot config
Message-ID: <4278bc27-8ab8-4cf2-bc55-26b4e271a821@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <db98cbbf-2205-40d2-9fa1-f1c135cc151c@paulmck-laptop>
 <20230731233130.424913-1-paulmck@kernel.org>
 <7bace63d-4e41-94d6-3d82-b3498864926e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bace63d-4e41-94d6-3d82-b3498864926e@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 07:00:22PM -0700, Randy Dunlap wrote:
> On 7/31/23 16:31, Paul E. McKenney wrote:
> > Update the /proc/cmdline documentation to explicitly state that this
> > file provides kernel boot parameters obtained via boot config from the
> > kernel image as well as those supplied by the boot loader.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Arnd Bergmann <arnd@kernel.org>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thank you both!  I will apply these on my next rebase.

							Thanx, Paul

> Thanks.
> 
> > ---
> >  Documentation/filesystems/proc.rst | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 7897a7dafcbc..75a8c899ebcc 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -686,7 +686,8 @@ files are there, and which are missing.
> >   apm          Advanced power management info
> >   buddyinfo    Kernel memory allocator information (see text)	(2.5)
> >   bus          Directory containing bus specific information
> > - cmdline      Kernel command line
> > + cmdline      Kernel command line, both from bootloader and embedded
> > + 	      in the kernel image.
> >   cpuinfo      Info about the CPU
> >   devices      Available devices (block and character)
> >   dma          Used DMS channels
> 
> -- 
> ~Randy
