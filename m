Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE283FA147
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 23:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhH0Vwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 17:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhH0Vwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:52:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A5BC0613D9;
        Fri, 27 Aug 2021 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=exmd3Tm+ti+IOKUHee1T7QXq+ITy8fgTRi4FMxbqdY0=; b=qxvGOri/sSUKTWhj7mxw7atvHs
        fXojz8mRSsj7xTcgIxNtDwjnEWih+Jb2kFvoFUU6A3YotYgWjx4hS938Bjc9Yk6Cw2G4ZAegItUBX
        ebdhoj//zQcsT1SXWObH2F38DPz1i9otQyuPyyRcX5Acyq/xN0Uzh+C+ZH9vz58Fx0sFlhh7A/MPG
        p9W+V6bpMfA6BBfeBhReTIlgJds0ZUWu09yYnrdKOSJIGqijOwM1jWPSmogwDZyFcs3QONz35poPs
        yzoybivPkJI8x4Hp7xN4DshPZa+WDA+7w39DLJSLW6JMmQFqgLIv38tmxIWQQhqKyvltqrj4UesJ0
        KivprAxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJjjS-00F3gm-K3; Fri, 27 Aug 2021 21:50:01 +0000
Date:   Fri, 27 Aug 2021 22:49:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSld/u3YbwUhV1Jr@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org>
 <YSZeKfHxOkEAri1q@cmpxchg.org>
 <20210826004555.GF12597@magnolia>
 <YSjxlNl9jeEX2Yff@cmpxchg.org>
 <YSkyjcX9Ih816mB9@casper.infradead.org>
 <CAA9_cmeVK9S2e8ECh3dTaNzUgQHC8uo7DBhENgnvoR3s+w-2Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA9_cmeVK9S2e8ECh3dTaNzUgQHC8uo7DBhENgnvoR3s+w-2Mg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 02:41:11PM -0700, Dan Williams wrote:
> On Fri, Aug 27, 2021 at 11:47 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Aug 27, 2021 at 10:07:16AM -0400, Johannes Weiner wrote:
> > > We have the same thoughts in MM and growing memory sizes. The DAX
> > > stuff said from the start it won't be built on linear struct page
> > > mappings anymore because we expect the memory modules to be too big to
> > > manage them with such fine-grained granularity.
> >
> > Well, I did.  Then I left Intel, and Dan took over.  Now we have a struct
> > page for each 4kB of PMEM.  I'm not particularly happy about this change
> > of direction.
> 
> Page-less DAX left more problems than it solved. Meanwhile,
> ZONE_DEVICE has spawned other useful things like peer-to-peer DMA.

ZONE_DEVICE has created more problems than it solved.  Pageless memory
is a concept which still needs to be supported, and we could have made
a start on that five years ago.  Instead you opted for the expeditious
solution.

