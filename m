Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536733CF248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 04:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbhGTCRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 22:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345078AbhGTCPo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 22:15:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C4C061768
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 19:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ddFeRTWSZ+X6AQt7FcVLxDNr63yOS1Yd3t70mbLKXzI=; b=fYVv5ucLOhkhhtiSIF6xRyOBP/
        cV2wxlhBWulN2BlKt7DKyAIpW8oHCxoaAiVn7MyLfJcicfsvg6gGseiEgURzMwwnMS7jT2LU6GU5F
        hGSh9x5DQLDv5fjLewivc1nojYhfvj3CpsXA6/vUqnoRBz8ctTUdEBlEZ0JAwLX7RGMqkYdGVan2c
        shYhxrL9h+6gYowbcRGRe3CwTyKOrjQst/M7BOko3HHS88vHiktdRW6xoNBi9QblTYs0JrqGjm+wp
        RufyTCMtwv1Nz4mDF/cZEFBkGyTCcNnbS1479nGyIJH3LdXbeiYJHLSmZcIJeIpgkmHNUo4oSQi8f
        PWZmsH6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5fv6-007iR0-47; Tue, 20 Jul 2021 02:55:48 +0000
Date:   Tue, 20 Jul 2021 03:55:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Folio tree for next
Message-ID: <YPY7MPs1zcBClw79@casper.infradead.org>
References: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
 <20210718205758.65254408be0b2a17cfad7809@linux-foundation.org>
 <20210720094033.46b34168@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720094033.46b34168@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 09:40:33AM +1000, Stephen Rothwell wrote:
> Hi Andrew,
> 
> On Sun, 18 Jul 2021 20:57:58 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 19 Jul 2021 04:18:19 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > > Please include a new tree in linux-next:
> > > 
> > > https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next
> > > aka
> > > git://git.infradead.org/users/willy/pagecache.git for-next
> > > 
> > > There are some minor conflicts with mmotm.  I resolved some of them by
> > > pulling in three patches from mmotm and rebasing on top of them.
> > > These conflicts (or near-misses) still remain, and I'm showing my
> > > resolution:  
> > 
> > I'm thinking that it would be better if I were to base all of the -mm
> > MM patches on linux-next.  Otherwise Stephen is going to have a pretty
> > miserable two months...
> 
> If they are only minor conflicts, then please leave them to me (and
> Linus).  That way if Linus decides not to take the folio tree or the
> mmotm changes (or they get radically changed), then they are not
> contaminated by each other ... hints (or example resolutions) are
> always welcome.

I think conceptually, the folio for-next tree is part of mmotm for this
cycle.  I would have asked Andrew to carry these patches, but there are
people (eg Dave Howells) who want to develop against them.  And that's
hard to do with patches that are in mmotm.

So if Andrew bases mmotm on the folio tree for this cycle, does that
make sense?
