Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBCE6FD074
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 23:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjEIVDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 17:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEIVDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 17:03:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52878C5;
        Tue,  9 May 2023 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=9VD/D0v5O8//quYQJySPkoRVmkT7ipxszQBf99beWVA=; b=IRvhN0sQI6XHf0q8jiOXKNeFyi
        BUV445vBF4v6Dmf8BSxlvXuIebH4e4HkZ4zLrASNuYqI8pX28W5AFfHTLwzylcQfKZqteQ7ypuRHy
        Yg5NSZ1vqRhjbqjddGeCslHsJSHuvvzv6qXU6aAChrO9yXrogA89r6tEnVUA78tKMZE63WzyzZjl7
        BwWS0Z41S7YASZurtj5ZuaWWb++1N2zLh4hE9DCiLvchMruhfcp/8noH0OoKFaAuJPtI55dcqm7qj
        WUSWh5ELuiAqUsTMTa/Rp5U3tViFm+mILL9q7f1yquyCNrNqvMwpF6ww2h6J7DHISaTt1UlSAGy57
        cnYtTmsQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pwUUl-004GZ7-0G;
        Tue, 09 May 2023 21:03:39 +0000
Message-ID: <96edbeae-59a0-2619-1fe7-f39ecf6a9206@infradead.org>
Date:   Tue, 9 May 2023 14:03:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 24/32] MAINTAINERS: Add entry for generic-radix-tree
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-25-kent.overstreet@linux.dev>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230509165657.1735798-25-kent.overstreet@linux.dev>
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
> lib/generic-radix-tree.c is a simple radix tree that supports storing
> arbitrary types. Add a maintainers entry for it.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d76169140..c550f5909e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8615,6 +8615,13 @@ F:	Documentation/devicetree/bindings/power/power?domain*
>  F:	drivers/base/power/domain*.c
>  F:	include/linux/pm_domain.h
>  
> +GENERIC RADIX TREE:

No colon at the end of the line.

> +M:	Kent Overstreet <kent.overstreet@linux.dev>
> +S:	Supported
> +C:	irc://irc.oftc.net/bcache
> +F:	include/linux/generic-radix-tree.h
> +F:	lib/generic-radix-tree.c
> +
>  GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
>  M:	Eugen Hristev <eugen.hristev@microchip.com>
>  L:	linux-input@vger.kernel.org

-- 
~Randy
