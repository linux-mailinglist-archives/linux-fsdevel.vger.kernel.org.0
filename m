Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C44B83AC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 23:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfHFVG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 17:06:26 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46573 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726016AbfHFVG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:06:26 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B989243CF0A;
        Wed,  7 Aug 2019 07:06:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hv6dv-00051f-48; Wed, 07 Aug 2019 07:05:15 +1000
Date:   Wed, 7 Aug 2019 07:05:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/24] xfs: correctly acount for reclaimable slabs
Message-ID: <20190806210515.GF7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-13-david@fromorbit.com>
 <20190806055249.GB25736@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806055249.GB25736@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=hgB5nrfzdG2RuRxMWyMA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 10:52:49PM -0700, Christoph Hellwig wrote:
> On Thu, Aug 01, 2019 at 12:17:40PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > The XFS inode item slab actually reclaimed by inode shrinker
> > callbacks from the memory reclaim subsystem. These should be marked
> > as reclaimable so the mm subsystem has the full picture of how much
> > memory it can actually reclaim from the XFS slab caches.
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Btw, I wonder if we should just kill off our KM_ZONE_* defined.  They
> just make it a little harder to figure out what is actually going on
> without a real benefit.

Yeah, they don't serve much purpose now, it might be worth cleaning
up.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
