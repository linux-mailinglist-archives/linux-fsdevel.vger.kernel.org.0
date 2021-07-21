Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21873D075B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 05:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhGUCmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 22:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhGUCmq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 22:42:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E4AC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 20:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gCTT5Fb3qJaQvjoF9z/WovDilwkGIJURG3uBwzHc+7E=; b=dThau3xkp/q1kI7F1woXi+uieU
        J1FsvMRYXanwXhYHdtEKRjfnCA4ynHBgASN3H6X9PnwTeKM2bDO2iMcTJe5y/C2GgWwaRcxGaM/Tl
        n4dG2NV3SqhCeQW+S9cBPqPLmzNGqDCOmMJp2B2t50CWfS5c1fuCxRHI0JIibcF5/TrwI5FxYLlKN
        N9M/Y8ZDycujPffwBYT6RS39zqAqsEaifyPI4gj7s/nyMLW+6z9QQCXd3uo2eX5DTKNG+lvJsdE4q
        +lQtUHzAoYrEk8KjY+OaJtUGjjoPA8jMkUcIzi1xxM1iO+7Y9TIa7M/Z6ZRPL5adAgEuURx3n6dVL
        RRTX8peQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m62p1-008kmN-NQ; Wed, 21 Jul 2021 03:23:04 +0000
Date:   Wed, 21 Jul 2021 04:22:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Folio tree for next
Message-ID: <YPeTEx8slsZfawPw@casper.infradead.org>
References: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
 <20210718205758.65254408be0b2a17cfad7809@linux-foundation.org>
 <20210720094033.46b34168@canb.auug.org.au>
 <YPY7MPs1zcBClw79@casper.infradead.org>
 <20210721122102.38c80140@canb.auug.org.au>
 <20210720192927.98ee7809717b9cc28fa95bb6@linux-foundation.org>
 <YPeKnIpd+EAU4SZP@casper.infradead.org>
 <20210720202202.dfd4d9c3490e51e35cf1455e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720202202.dfd4d9c3490e51e35cf1455e@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 08:22:02PM -0700, Andrew Morton wrote:
> On Wed, 21 Jul 2021 03:46:52 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > Sure, let's go that way.  Linus wasn't terribly enthusiastic about the
> > > folio patches and I can't claim to be overwhelmed by their value/churn
> > > ratio (but many MM developers are OK with it all, and that
> > > counts).  Doing it this way retains options...
> > 
> > I'm happy to take these three patches through my tree if it makes life
> > easier (and it does resolve the majority of the pain):
> > 
> > mm, memcg: add mem_cgroup_disabled checks in vmpressure and swap-related functions
> > mm, memcg: inline mem_cgroup_{charge/uncharge} to improve disabled memcg config
> > mm, memcg: inline swap-related functions to improve disabled memcg config
> 
> They're rather unimportant, can be deferred.
> 
> I'll probably move these to the post-linux-next queue, but let's just
> do it and see how it goes.

OK, dropping them from my tree.
