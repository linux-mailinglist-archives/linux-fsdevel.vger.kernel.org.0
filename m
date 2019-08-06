Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E4D82B45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 07:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfHFFvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 01:51:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfHFFvl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m+FFhH6JYl0+VCC7puYYO1iplwknB7XNzlWvEFcSM1M=; b=u3O8WGEJ5SkndaXpMMJfWkypL
        4dnNwB9DdlDQnIXYmKW6f97UCH2dGrKxK7t5s/AtxtJO85oN20L9FOpTbJ+TQ0eREGbmRIdB0Y2v/
        +EyD+GW9Yg2L8LyAScZkezBBFcUCRazZ378duIe7vAmVuOUd5+sBwLfcS/Ze53V/dHIfTnqs5nfuw
        kGEsuKahLO44X6fGWKK3kXqBzfok3Js1ShzBYRTqDhSpG7jW2WXVISrXTJkLpArRvseUvzkvsisqw
        ee9DVV25DCNDdBV05ziUDt2DVJI7X/1zV184FnB+H1QERyWnmI5fIiG9f/aiWzu9NjyGtFSZzxuxh
        BhMD+3Lbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1husNo-00083e-2r; Tue, 06 Aug 2019 05:51:40 +0000
Date:   Mon, 5 Aug 2019 22:51:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/24] xfs:: account for memory freed from metadata
 buffers
Message-ID: <20190806055139.GA25736@infradead.org>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-12-david@fromorbit.com>
 <20190801081603.GA10600@infradead.org>
 <20190801092133.GK7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801092133.GK7777@dread.disaster.area>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 07:21:33PM +1000, Dave Chinner wrote:
> > static inline void shrinker_mark_pages_reclaimed(unsigned long nr_pages)
> > {
> > 	if (current->reclaim_state)
> > 		current->reclaim_state->reclaimed_pages += nr_pages;
> > }
> > 
> > plus good documentation on when to use it.
> 
> Sure, but that's something for patch 6, not this one :)

Sounds good, I just skimmend through the XFS patches.  While we are at
it:  there is a double : in the subject line.
