Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2B51991B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 11:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgCaJVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 05:21:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbgCaJVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yqNlown0MzgWJHh7vQQU8YQxRZVzreHtSlK6DAEVltU=; b=dZM+SjPDyPx2aDRbdMAcvY6BM4
        bYgSP7hH5mr+/1aMS6aiCd5ttX76Qx8kdNvJr+dgPxck7c1oSTDQG/JHoHhCGKzwqq0bUacWI9XH+
        YVtcF4LUB8jcxOoFoHjwP6s3ubbLWvLSJGjQo7ANjT97ZB4HELHYf9/4FiLxxLiVocluxsLNPYRno
        AHR9TUi9rLge2FbDKrRVH240Uo5T8EjVY2l2c6v1lrmtDu0bdi+prc6D0AQEi3+d8tmS2C9W4d2Xt
        rKu1PDCzjmbP3XkeDzRkA1KaX9YwzkXK5FukAoZed4GcVZg/c/xBKmpllatHpsoc2xRCUBgX3VV5H
        +XPv4lqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJD54-0006ai-Lk; Tue, 31 Mar 2020 09:21:10 +0000
Date:   Tue, 31 Mar 2020 02:21:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Do not use GFP_NORETRY to allocate BIOs
Message-ID: <20200331092110.GA24694@infradead.org>
References: <20200323131244.29435-1-willy@infradead.org>
 <20200323132052.GA7683@infradead.org>
 <20200323134032.GH4971@bombadil.infradead.org>
 <20200323135500.GA14335@infradead.org>
 <20200323151054.GI4971@bombadil.infradead.org>
 <20200323165154.GB30433@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323165154.GB30433@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 23, 2020 at 09:51:54AM -0700, Christoph Hellwig wrote:
> On Mon, Mar 23, 2020 at 08:10:54AM -0700, Matthew Wilcox wrote:
> > > That looks silly to me.  This just means we'll keep iterating over
> > > small bios for readahead..  Either we just ignore the different gfp
> > > mask, or we need to go all the way and handle errors, although that
> > > doesn't really look nice.
> > 
> > I'm not sure it's silly,
> 
> Oh well, I'm not going to be in the way of fixing a bug I added.  So
> feel free to go ahead with this and mention it matches mpage_readpages.

Are you going to submit this as a formal patch?
