Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADB921BA45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgGJQDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 12:03:42 -0400
Received: from verein.lst.de ([213.95.11.211]:43859 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgGJQDl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:03:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D7A368AEF; Fri, 10 Jul 2020 18:03:37 +0200 (CEST)
Date:   Fri, 10 Jul 2020 18:03:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, dsterba@suse.cz, cluster-devel@redhat.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return
 if page invalidation fails
Message-ID: <20200710160337.GA21808@lst.de>
References: <20200707124346.xnr5gtcysuzehejq@fiona> <20200707125705.GK25523@casper.infradead.org> <20200707130030.GA13870@lst.de> <20200708065127.GM2005@dread.disaster.area> <20200708135437.GP25523@casper.infradead.org> <20200709022527.GQ2005@dread.disaster.area> <20200709160926.GO7606@magnolia> <20200709170519.GH12769@casper.infradead.org> <20200709171038.GE7625@magnolia> <20200709225936.GZ2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709225936.GZ2005@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This looks sane - slightly updated version below to not bother with
the ret and a few tidyups.

That being said and to get back to the discussion in this thread:
I think it would be saner to give up on direct I/O in case of the
invalidation failure.  I've cooked up a patch on top of this one
(for which I had a few trivial cleanups).  It is still under testing,
but I'll send the two out in a new thread.
