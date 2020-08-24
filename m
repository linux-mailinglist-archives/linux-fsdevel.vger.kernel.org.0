Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D3925000C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgHXOmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 10:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXOmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 10:42:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCCBC061573;
        Mon, 24 Aug 2020 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sm/ikGBMT7yXr66/WCvwl+PKMe6pOWKqSkgLkHzx4Lc=; b=fMe0QfTQ4FBKF7HgdD2AKcKJDy
        jpK1GN1HR/22cjzUb0XYK5lfB6YRhA9AfdqZKo0uLpe7Blh31bdMq37c40i/jLxm2YkB3oSX4/OJj
        TYv0GzPrdpMG7xkBSyFews/4uSp3ImPuE96kVv3zjIy/ZJFPZYnz7VWg6HULLbJltSIvqekw/b8b9
        RKFdsxEV8Q7OHuVh4OwAwpT0NBPSZaAQrlwvPHCYOXl7XNO9BQI5IlfSGfYJnUzs81goecyjvlHWy
        9Qkayszt+5jdBZtaXYqsqcOD0WGuP7wjZvlXkdmYMgkDqfXsDlz962mCjUAE50IjJRRlxUchCKDhL
        4u3jkxrw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kADff-00027L-AM; Mon, 24 Aug 2020 14:42:03 +0000
Date:   Mon, 24 Aug 2020 15:42:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] bio: introduce BIO_FOLL_PIN flag
Message-ID: <20200824144203.GA8070@infradead.org>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
 <20200822042059.1805541-5-jhubbard@nvidia.com>
 <20200823062559.GA32480@infradead.org>
 <d75ce230-6c8d-8623-49a2-500835f6cdfc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d75ce230-6c8d-8623-49a2-500835f6cdfc@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 03:20:26AM -0600, Jens Axboe wrote:
> (not relevant to this series as this patch has thankfully already been
> dropped, just in general - but yes, definitely need a *strong* justification
> to bump the bio size).
> 
> Would actually be nice to kill off a few flags, if possible, so the
> flags space isn't totally full.

I have a series to kill two flags that I need to resurrect and post.
