Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91632FA87A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 19:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406924AbhARSOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 13:14:31 -0500
Received: from verein.lst.de ([213.95.11.211]:49110 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407353AbhARSOY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:14:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C5DBE6736F; Mon, 18 Jan 2021 19:13:38 +0100 (CET)
Date:   Mon, 18 Jan 2021 19:13:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, 'Jens Axboe ' <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add bio_limit
Message-ID: <20210118181338.GA11002@lst.de>
References: <20210114194706.1905866-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114194706.1905866-1-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 14, 2021 at 07:47:06PM +0000, Matthew Wilcox (Oracle) wrote:
> It's often inconvenient to use BIO_MAX_PAGES due to min() requiring the
> sign to be the same.  Introduce bio_limit() and change BIO_MAX_PAGES to
> be unsigned to make it easier for the users.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I like the helper, but I'm not too happy with the naming.  Why not
something like bio_guess_nr_segs() or similar?
