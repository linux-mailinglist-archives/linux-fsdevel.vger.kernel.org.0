Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FFE342F62
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 20:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCTTyx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 15:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTTyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 15:54:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B79C061574;
        Sat, 20 Mar 2021 12:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n6sUomGFTdUgXHQKImE6dSIftD7hu8+DvN7lvXNoVOw=; b=lAI97FMVTPnIXvJcwPkDdBkvHZ
        /nzR6AM1P2MZxOGB+AtsymO/efY+lC1LMICWRdvIFUY/MMehtaMd4orMPIXVRY60YNAP0JZTTkbYR
        qgoNQszMAAUFOjxlG1sPDVO8V1VS1bRDARdyfvJ9So2Dq+RZtXSCpWJlqtLYdNJPGq2zxBvAZUN3c
        8Bs66qSimLsZpLkm6sqsRbXno37KaodheP5Che6kisePfZ0dzHgVkjYJAvhnywKdp7jyhCo62kdRz
        V4xFUM7dSkgc3vDjBGAvIlUR8AHWrkwV07MnTF0hqAjZXGPXu/odYQCD1GSaUHdqKOeQzdB36cZcU
        1a/5rAJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNhgF-006Fft-NZ; Sat, 20 Mar 2021 19:54:40 +0000
Date:   Sat, 20 Mar 2021 19:54:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, mhocko@suse.com,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        oliver.sang@intel.com
Subject: Re: [PATCH v4 3/3] mm: fs: Invalidate BH LRU during page migration
Message-ID: <20210320195439.GE3420@casper.infradead.org>
References: <20210319175127.886124-1-minchan@kernel.org>
 <20210319175127.886124-3-minchan@kernel.org>
 <20210320093249.2df740cd139449312211c452@linux-foundation.org>
 <YFYuyS51hpE2gp+f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFYuyS51hpE2gp+f@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 10:20:09AM -0700, Minchan Kim wrote:
> > > Tested-by: Oliver Sang <oliver.sang@intel.com>
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > 
> > The signoff chain ordering might mean that Chris was the primary author, but
> > there is no From:him.  Please clarify?
> 
> He tried first version but was diffrent implementation since I
> changed a lot. That's why I added his SoB even though current
> implementaion is much different. So, maybe I am primary author?

Maybe Chris is Reported-by: ?  And don't forget Laura Abbott as original
author of the patch Chris submitted.  I think she should be Reported-by:
as well, since there is no code from either of them in this version of
the patch.
