Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF3E51F206
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 01:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiEHXUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 19:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiEHXUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 19:20:39 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30B39B7EB
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 16:16:47 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 81B2B10E65C3;
        Mon,  9 May 2022 09:16:45 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nnq8q-009g6Q-5i; Mon, 09 May 2022 09:16:44 +1000
Date:   Mon, 9 May 2022 09:16:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Appoint myself page cache maintainer
Message-ID: <20220508231644.GP1949718@dread.disaster.area>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202849.666756-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508202849.666756-1-willy@infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62784f5d
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=sMl84w5dT4crFwMLUrIA:9
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 08, 2022 at 09:28:48PM +0100, Matthew Wilcox (Oracle) wrote:
> This feels like a sufficiently distinct area of responsibility to be
> worth separating out from both MM and VFS.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d47c5e7c6ae..5871ec2e1b3e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14833,6 +14833,18 @@ F:	Documentation/core-api/padata.rst
>  F:	include/linux/padata.h
>  F:	kernel/padata.c
>  
> +PAGE CACHE
> +M:	Matthew Wilcox (Oracle) <willy@infradead.org>
> +L:	linux-fsdevel@vger.kernel.org
> +S:	Supported
> +T:	git git://git.infradead.org/users/willy/pagecache.git
> +F:	Documentation/filesystems/locking.rst
> +F:	Documentation/filesystems/vfs.rst
> +F:	include/linux/pagemap.h
> +F:	mm/filemap.c
> +F:	mm/page-writeback.c
> +F:	mm/readahead.c

A big thumbs up from me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
