Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37FA3161FE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 05:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgBREs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 23:48:59 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45268 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbgBREs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 23:48:58 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A78797EA005;
        Tue, 18 Feb 2020 15:48:55 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j3uoY-0005i5-Lq; Tue, 18 Feb 2020 15:48:54 +1100
Date:   Tue, 18 Feb 2020 15:48:54 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 02/19] mm: Ignore return value of ->readpages
Message-ID: <20200218044854.GG10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-3-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=x_zGJsPA0gc82MDK-9gA:9
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:45:43AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We used to assign the return value to a variable, which we then ignored.
> Remove the pretence of caring.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/readahead.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Simple enough.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
