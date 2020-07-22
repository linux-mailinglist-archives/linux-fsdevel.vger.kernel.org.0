Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4DA229069
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 08:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgGVGSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 02:18:55 -0400
Received: from verein.lst.de ([213.95.11.211]:54935 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgGVGSz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:18:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E8C1068AFE; Wed, 22 Jul 2020 08:18:50 +0200 (CEST)
Date:   Wed, 22 Jul 2020 08:18:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/3] iomap: fall back to buffered writes for
 invalidation failures
Message-ID: <20200722061850.GA24799@lst.de>
References: <20200721183157.202276-1-hch@lst.de> <20200721183157.202276-4-hch@lst.de> <20200721203749.GF3151642@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721203749.GF3151642@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 01:37:49PM -0700, Darrick J. Wong wrote:
> On Tue, Jul 21, 2020 at 08:31:57PM +0200, Christoph Hellwig wrote:
> > Failing to invalid the page cache means data in incoherent, which is
> > a very bad state for the system.  Always fall back to buffered I/O
> > through the page cache if we can't invalidate mappings.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Acked-by: Dave Chinner <dchinner@redhat.com>
> > Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> For the iomap and xfs parts,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> But I'd still like acks from Ted, Andreas, and Damien for ext4, gfs2,
> and zonefs, respectively.
> 
> (Particularly if anyone was harboring ideas about trying to get this in
> before 5.10, though I've not yet heard anyone say that explicitly...)

Why would we want to wait another whole merge window?
