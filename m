Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A74D4AC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 01:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfJKXOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 19:14:09 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:42702 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbfJKXOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:14:09 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3CDFD43E2DD;
        Sat, 12 Oct 2019 10:14:07 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iJ46o-0007j7-P2; Sat, 12 Oct 2019 10:14:06 +1100
Date:   Sat, 12 Oct 2019 10:14:06 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191011231406.GL16973@dread.disaster.area>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
 <20191011123939.GD61257@bfoster>
 <20191011125735.GB13167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011125735.GB13167@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=EWKUcU7rBY2Ml6FoIEwA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 05:57:35AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 11, 2019 at 08:39:39AM -0400, Brian Foster wrote:
> > Seems reasonable, but for inodes we also spread the ili zone. Should we
> > not be consistent with bli's as well?
> 
> Btw, can we please kill off the stupid KM_ZONE_* flags?  We only use
> each of them less than a hand ful of places, and they make reading the
> code much harder.

Separate patchset - it's not relevant to this one which is already
complex enough...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
