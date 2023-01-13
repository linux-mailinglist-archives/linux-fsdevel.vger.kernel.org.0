Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2EA669952
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 15:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbjAMOC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 09:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241808AbjAMOCA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:02:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414BD1CA;
        Fri, 13 Jan 2023 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6kboQ5MB7uZ6CHhRg2eIn8RfDMDJ2TsZf8BKVulus5A=; b=ZTAU6Pkntpy8KSSflFMFJA3/gN
        HcJPCQ631UoV2WzEQqkqBBRdS27YRmIkPpCdYTrvOnvUolnOaXifUsp+2b65sxHOta8lGzjoSrgwc
        VoSKLSh3nfRimYnSzPZMhWamT1YRmRsOHkw0bZUjWOfDVFlNWWwxGnl+cZN82szTQepK5g1XbHefy
        mG9Ety+ssNpJsCiAOr9DXLXTwbjjzOKeKgWyPWaeanvE0O03P9LaO2HE/NsKmu40ggOiM3aFQzL9y
        Xpvc8GJqBrxfKlsYsKrpyUZemhy2q4fde6o8PQt6HQbEIjg3vIwA6dcFY8bGeaBQk5vjXxAb/J8tk
        QX7/er3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGKaj-0069DE-CO; Fri, 13 Jan 2023 13:59:33 +0000
Date:   Fri, 13 Jan 2023 13:59:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     yang.yang29@zte.com.cn, akpm@linux-foundation.org,
        hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iamjoonsoo.kim@lge.com, ran.xiaokai@zte.com.cn
Subject: Re: [PATCH linux-next v2] swap_state: update shadow_nodes for
 anonymous page
Message-ID: <Y8FjxV4gWiBw8o5l@casper.infradead.org>
References: <202301131550455361823@zte.com.cn>
 <Y8Eao1l0qRVLKK7e@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Eao1l0qRVLKK7e@debian.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 03:47:31PM +0700, Bagas Sanjaya wrote:
> On Fri, Jan 13, 2023 at 03:50:45PM +0800, yang.yang29@zte.com.cn wrote:
> > This patch updates shadow_nodes of anonymous page when swap
> > cache is add or delete.
> 
> By what?

This is not a helpful question.

> > @@ -252,6 +256,8 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
> >  		struct address_space *address_space = swap_address_space(entry);
> >  		XA_STATE(xas, &address_space->i_pages, curr);
> > 
> > +		xas_set_update(&xas, workingset_update_node);
> > +
> >  		xa_lock_irq(&address_space->i_pages);
> >  		xas_for_each(&xas, old, end) {
> >  			if (!xa_is_value(old))
> 
> Adding xas_set_update() call?

It makes perfect sense to me.

> In any case, please explain what you are doing above in imperative mood
> (no "This patch does foo" but "Do foo" instead).

Not helpful either.

