Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5560179C21
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 00:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbgCDXI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 18:08:58 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53261 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388400AbgCDXI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:08:58 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7FBE73A1FC6;
        Thu,  5 Mar 2020 10:08:54 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j9d8H-0004tO-6G; Thu, 05 Mar 2020 10:08:53 +1100
Date:   Thu, 5 Mar 2020 10:08:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v3] iomap: Remove pgoff from tracepoints
Message-ID: <20200304230853.GD10776@dread.disaster.area>
References: <20200304175429.GI29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304175429.GI29971@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=NJjT1FRF5uaCxtXpL_UA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 09:54:29AM -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> The 'pgoff' displayed by the tracepoints wasn't a pgoff at all; it
> was a byte offset from the start of the file.  We already emit that in
> the form of the 'offset', so we can just remove pgoff.  That means we
> can remove 'page' as an argument to the tracepoint, and rename this
> type of tracepoint from being a page class to being a range class.
> 
> Fixes: 0b1b213fcf3a ("xfs: event tracing support")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> ---
> v2: Get rid of 'pgoff' instead of fixing it
> v3: Fix releasepage and writepage to actually set offset/length.
> 
>  buffered-io.c |    7 ++++---
>  trace.h       |   27 +++++++++++----------------
>  2 files changed, 15 insertions(+), 19 deletions(-)

With the range updates for release/writeage it looks good to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
