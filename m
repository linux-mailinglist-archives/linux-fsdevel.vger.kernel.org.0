Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2068F29BE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390731AbfEXQLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 12:11:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390411AbfEXQLu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 12:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XMpCB89ytjbHczxqQZJ1ZkGk4p/wzfOhXhEuznTtcMU=; b=VdgAfLUXLCJlXG5l/7G3EXePj
        SSJwDOnYPi2jv9q8sjeH/rp5wl1hTE0k/mlDMPdly9vpf0znyQWHE8P/xVkTzmwchhL3NdHUR7Zut
        n0dGIxrqop8fek0MoEG+PplDVqzElFrd1g2zn+17UZgMLiGSfdYN5pHxWDRasOM76wm59MNcuHm3e
        W+jzXozQbR427BFuT7WuqXHdnjX8+XTo6y+4gsoqt+cCg+b1HDipQVf4KCcyy1Fnn8fUmaDw9HUBS
        80J/IN9BUnKAmEqEy0gKcjABkN60UlsvYuSKfiBxJEEcLE4HITTrK43TTI0zj2SL340n2TrIdrYna
        rs1KInx3w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hUCnK-00037T-RC; Fri, 24 May 2019 16:11:46 +0000
Date:   Fri, 24 May 2019 09:11:46 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: xarray breaks thrashing detection and cgroup isolation
Message-ID: <20190524161146.GC1075@bombadil.infradead.org>
References: <20190523174349.GA10939@cmpxchg.org>
 <20190523183713.GA14517@bombadil.infradead.org>
 <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
 <20190523190032.GA7873@bombadil.infradead.org>
 <20190523192117.GA5723@cmpxchg.org>
 <20190523194130.GA4598@bombadil.infradead.org>
 <20190523195933.GA6404@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523195933.GA6404@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 03:59:33PM -0400, Johannes Weiner wrote:
> My point is that we cannot have random drivers' internal data
> structures charge to and pin cgroups indefinitely just because they
> happen to do the modprobing or otherwise interact with the driver.
> 
> It makes no sense in terms of performance or cgroup semantics.

But according to Roman, you already have that problem with the page
cache.
https://lore.kernel.org/linux-mm/20190522222254.GA5700@castle/T/

So this argument doesn't make sense to me.
