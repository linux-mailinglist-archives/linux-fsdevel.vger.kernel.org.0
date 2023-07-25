Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4BD76063B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 05:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGYDEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 23:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjGYDEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:04:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8B6E71;
        Mon, 24 Jul 2023 20:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lN8WxZ/PNOH793oh3nQ8Vx+a0wKT+Wax0we8reIecA0=; b=vc1ravXAQSZfS1uVYSySEQ8IkA
        oL8kK2j1eEJj+2NpHdsxTG3zHEK9L786DXf/2pCkumM2jzawl+26yg8WZCGdrRFiZDKCy7pA8FYUN
        DvkQclMnOaKiq7vqISPUNPvOQy0q1j7YdOuCvFhfdaqOlh7EpDyvathv5WW/oDyGGwlZ8aaoYqpKf
        AWNy5jlRYBKvoOByjTp3hJqK1VUNsbRfA6/ZEBz8yc05HAZlXvAYNYLndbUie8iTff1h8YAj/3Sn6
        QgOawZxPONJ2bfr21BGwGXImwrqIfew4+wDNtDgFvJROb73gZq/n9mPYQ5kxw/4j1gqauBeFhQJtS
        67vvb+rw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO8LG-0054hT-J5; Tue, 25 Jul 2023 03:04:06 +0000
Date:   Tue, 25 Jul 2023 04:04:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 19/20] lib/generic-radix-tree.c: Add a missing include
Message-ID: <ZL87ppG5/rGdGxeB@casper.infradead.org>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-20-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712211115.2174650-20-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 05:11:14PM -0400, Kent Overstreet wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> We now need linux/limits.h for SIZE_MAX.

I think this should be squashed into the previous commit

> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  include/linux/generic-radix-tree.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
> index 63080822dc..f6cd0f909d 100644
> --- a/include/linux/generic-radix-tree.h
> +++ b/include/linux/generic-radix-tree.h
> @@ -38,6 +38,7 @@
>  
>  #include <asm/page.h>
>  #include <linux/bug.h>
> +#include <linux/limits.h>
>  #include <linux/log2.h>
>  #include <linux/math.h>
>  #include <linux/types.h>
> -- 
> 2.40.1
> 
