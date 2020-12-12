Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394852D8732
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 16:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439226AbgLLPPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 10:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLLPPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 10:15:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612B0C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XoUM7yNFE1iQSkJXUq8c+KOxwBP45UuVQJE8YNdbyss=; b=AZH9PAccKO9v0QNodWErOsF4Ty
        Aftn59Cal5tWlpdEcmqklBhJqs9JVltMWkv0w9eBCVAUe51+qKMl0H0hUky34DyyjHYHEItqk4qvM
        hUBapg8UqwW74QS3PxLeSPMmIv9kpIM7xZGFN1c8ExUsm+A0m0TnFovwfdX5bMeEZvetigconYmKV
        y4uwnfJEu1uhwgqJ36VibdTL7J9SEqE8D6C4GVhi660KkvAPMQpKfDpthVLbeexMLRgQOonORFGum
        VHLgyVFYbYa6zkfZita/kDzkCOf3GCZZ2H6An5DzG5Kw7bzlqL7dL7m9QfROZU9ZSGQAp/q+8VTYe
        6MiRbskQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ko6bC-0004rP-KW; Sat, 12 Dec 2020 15:14:18 +0000
Date:   Sat, 12 Dec 2020 15:14:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: Zoom call about Page Folios tomorrow
Message-ID: <20201212151418.GD2443@casper.infradead.org>
References: <20201210210519.GC7338@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210210519.GC7338@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 09:05:19PM +0000, Matthew Wilcox wrote:
> Time: 18:00 UTC (7pm Prague, 1pm Montreal, 10am Los Angeles,
> 		3am Saturday Tokyo, 5am Saturday Melbourne)
> Zoom Meeting ID: 960 8868 8749
> Password: 2097152
> 
> Since we don't have physical conferences any more, I'd like to talk to
> anyone who's interested in Page Folios (see my announcement earlier this
> week [1])
> 
> I don't have a presentation prepared, this is a discussion.  Feel free
> to just call in and listen.
> 
> [1] https://lore.kernel.org/linux-mm/20201208194653.19180-1-willy@infradead.org/

Recording uploaded: https://www.youtube.com/watch?v=iP49_ER1FUM
