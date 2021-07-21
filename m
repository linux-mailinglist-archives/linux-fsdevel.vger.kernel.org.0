Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA93D06D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 04:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhGUCGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 22:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhGUCGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 22:06:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B3C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 19:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mAxw64Sz94EPHMADJCWDYryBxHLaiMeI1PAZCi6zx5A=; b=VkLci9zRR+PD0jWOQj2vUtvIWG
        JcPRx7eQ8V1q0UA1gYxOIdsbxxu3w/vWKFWd8urHiz7NZTVnnX6yueJYrlV+ON6gzZdd13Pjudufd
        +SifSs9SaBirLKi8Efy7LDA0yx0+R+liauU0OsvtBkoDjKzgUPqJgTkxFr9nWeQe0FndHoXXzzLfq
        hzUn7U0s4ZV+h9OoJPo6/Q487rcuGw7EeKxXLoOer4IFCpRDCGu96hjwjcRnKjwJY3xd+EZxyn6p9
        U3SA4XTVKTOQY8CLdBSRsGk7TXT/UgWbF02xz/SyZXk0t/CLB+moD/E7VruKdoTCL+Dy2BGbQSwvY
        LNlmvjEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m62G4-008jBj-Lc; Wed, 21 Jul 2021 02:46:59 +0000
Date:   Wed, 21 Jul 2021 03:46:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Folio tree for next
Message-ID: <YPeKnIpd+EAU4SZP@casper.infradead.org>
References: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
 <20210718205758.65254408be0b2a17cfad7809@linux-foundation.org>
 <20210720094033.46b34168@canb.auug.org.au>
 <YPY7MPs1zcBClw79@casper.infradead.org>
 <20210721122102.38c80140@canb.auug.org.au>
 <20210720192927.98ee7809717b9cc28fa95bb6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720192927.98ee7809717b9cc28fa95bb6@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 07:29:27PM -0700, Andrew Morton wrote:
> On Wed, 21 Jul 2021 12:21:02 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi Matthew,
> > 
> > On Tue, 20 Jul 2021 03:55:44 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > I think conceptually, the folio for-next tree is part of mmotm for this
> > > cycle.  I would have asked Andrew to carry these patches, but there are
> > > people (eg Dave Howells) who want to develop against them.  And that's
> > > hard to do with patches that are in mmotm.
> > > 
> > > So if Andrew bases mmotm on the folio tree for this cycle, does that
> > > make sense?
> > 
> > Sure.  I will have a little pain the first day it appears, but it
> > should be OK after that.  I am on leave starting Saturday, so if you
> > could get me a tree without the mmotm patches for tomorrow that would
> > be good.
> 
> Sure, let's go that way.  Linus wasn't terribly enthusiastic about the
> folio patches and I can't claim to be overwhelmed by their value/churn
> ratio (but many MM developers are OK with it all, and that
> counts).  Doing it this way retains options...

I'm happy to take these three patches through my tree if it makes life
easier (and it does resolve the majority of the pain):

mm, memcg: add mem_cgroup_disabled checks in vmpressure and swap-related functions
mm, memcg: inline mem_cgroup_{charge/uncharge} to improve disabled memcg config
mm, memcg: inline swap-related functions to improve disabled memcg config

Up to you, really.
