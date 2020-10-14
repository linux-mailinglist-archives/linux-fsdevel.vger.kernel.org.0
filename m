Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0261328E564
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 19:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbgJNRap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 13:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgJNRap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:30:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD0FC061755;
        Wed, 14 Oct 2020 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AK8bcl5go2531vZZGKg0DJyQ5BbOzGirGdwSJSVvpg8=; b=Z/v/BmAErP8cNwni3jP1t43syF
        RUEKfwVmpNhm+d92PuP21fdDLgzACeWsqPzbQv06gEOJgGyCGzIACmm/E66qy3CuwA98Fgi0mt9Ng
        u96Cu0UBzwhbqD+rwVbM06hMTT9h6pNUm2uUR8VWLn+82769+AGxORqvDjZci4U3HczqI1jgeF/Xg
        75xnEEjb8u/6dBFKoU7vv3DqIn+jjXELSymweRfc7yV6XcfDlND+bpwlBKQkif/ooIRiUGQCfLT/g
        5g3kJK/LUuaqwH55REmjIuNW5+JW43EzauppKTQnPuwnRTcwDOFEQBqhgzMavs+70zeROD+8fjZZb
        JINWOBuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSkbr-00054e-RY; Wed, 14 Oct 2020 17:30:43 +0000
Date:   Wed, 14 Oct 2020 18:30:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 14/14] xfs: Support THPs
Message-ID: <20201014173043.GQ20115@casper.infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-15-willy@infradead.org>
 <20201014165116.GL9832@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014165116.GL9832@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:51:16AM -0700, Darrick J. Wong wrote:
> > -	.fs_flags		= FS_REQUIRES_DEV,
> > +	.fs_flags		= FS_REQUIRES_DEV | FS_THP_SUPPORT,
> 
> Mostly looks reasonable to me so far, though I forget where exactly
> FS_THP_SUPPORT got added...?

That's in akpm's tree ... not sure if it's in his current pull request,
but I'm assuming it'll go upstream this merge window.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=akpm&id=b97a1c642769622b2f22f575f624aefcd1cd9b7f
