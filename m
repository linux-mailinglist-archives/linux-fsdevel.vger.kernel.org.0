Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048F26FD072
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 23:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbjEIVDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 17:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEIVDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 17:03:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E96EC5;
        Tue,  9 May 2023 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=UIrvC3Iyv7jfdutZqpvvDIIYTPv+d2M5m4v+y+ZJWKg=; b=ncFMPWovlCiXLU4r7LPaCc51sW
        qVkKp8dKsBiak+BEI3S7BXpJRoVlFGrdv/4aIN8oiqEsv8u5aWAOv41qu3idJwzHbC2F5uMj2UNML
        rKfhFWmOeuFJ9auCKRYEJU2VDf3VnuimwCz9p6X3a4sIkLyCW7YDKfBZk6DIb0WJD98OK/sSiCVq9
        IhTGCkNA4P5Gv0uOQJBs/NBFT9a4GGj/ulO0WgszAv2jr35VOXJ/S2wnxotP/3ihGlpt8KwxzPu2z
        6ehj5Z6+IXOksLRZxhucylsNh40bhoHqh95ohBVYDt9E66Y+2cXHVU+8JqEDonZApxOXjfFMuLndR
        40VzNk4g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pwUUg-004GYh-3D;
        Tue, 09 May 2023 21:03:35 +0000
Message-ID: <60de8092-f8a7-3d1f-26e1-eeeeebaa9044@infradead.org>
Date:   Tue, 9 May 2023 14:03:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 16/32] MAINTAINERS: Add entry for closures
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-17-kent.overstreet@linux.dev>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230509165657.1735798-17-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/9/23 09:56, Kent Overstreet wrote:
> closures, from bcache, are async widgets with a variety of uses.
> bcachefs also uses them, so they're being moved to lib/; mark them as
> maintained.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Coly Li <colyli@suse.de>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3fc37de3d6..5d76169140 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5044,6 +5044,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
>  F:	Documentation/devicetree/bindings/timer/
>  F:	drivers/clocksource/
>  
> +CLOSURES:

No colon at the end of the line.

> +M:	Kent Overstreet <kent.overstreet@linux.dev>
> +L:	linux-bcachefs@vger.kernel.org
> +S:	Supported
> +C:	irc://irc.oftc.net/bcache
> +F:	include/linux/closure.h
> +F:	lib/closure.c
> +
>  CMPC ACPI DRIVER
>  M:	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
>  M:	Daniel Oliveira Nascimento <don@syst.com.br>

-- 
~Randy
