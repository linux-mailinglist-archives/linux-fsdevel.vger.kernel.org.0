Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C352FA8E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 19:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405554AbhARScA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 13:32:00 -0500
Received: from verein.lst.de ([213.95.11.211]:49184 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407624AbhARSb4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:31:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2D5DF6736F; Mon, 18 Jan 2021 19:31:13 +0100 (CET)
Date:   Mon, 18 Jan 2021 19:31:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        'Jens Axboe ' <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add bio_limit
Message-ID: <20210118183113.GA11473@lst.de>
References: <20210114194706.1905866-1-willy@infradead.org> <20210118181338.GA11002@lst.de> <20210118181712.GC2260413@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118181712.GC2260413@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 06:17:12PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 18, 2021 at 07:13:38PM +0100, Christoph Hellwig wrote:
> > On Thu, Jan 14, 2021 at 07:47:06PM +0000, Matthew Wilcox (Oracle) wrote:
> > > It's often inconvenient to use BIO_MAX_PAGES due to min() requiring the
> > > sign to be the same.  Introduce bio_limit() and change BIO_MAX_PAGES to
> > > be unsigned to make it easier for the users.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > I like the helper, but I'm not too happy with the naming.  Why not
> > something like bio_guess_nr_segs() or similar?
> 
> This feels like it's a comment on an entirely different patch, like this one:
> 
> https://git.infradead.org/users/willy/pagecache.git/commitdiff/fe9841debe24e15100359acadd0b561bbb2dceb1
> 
> bio_limit() doesn't guess anything, it just clamps the argument to
> BIO_MAX_PAGES (which is itself misnamed; it's BIO_MAX_SEGS now)

No, it was for thi patch.  Yes, it divides and clamps.  Which is sort of
a guess as often we might need less of them.  That being said I'm not
very fond of my suggestion either, but limit sounds wrong as well.
