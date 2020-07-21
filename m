Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06092228470
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgGUQBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:01:48 -0400
Received: from verein.lst.de ([213.95.11.211]:52832 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgGUQBr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:01:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E5A9068AFE; Tue, 21 Jul 2020 18:01:43 +0200 (CEST)
Date:   Tue, 21 Jul 2020 18:01:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org
Subject: Re: RFC: iomap write invalidation
Message-ID: <20200721160143.GA12046@lst.de>
References: <20200713074633.875946-1-hch@lst.de> <20200720215125.bfz7geaftocy4r5l@fiona> <20200721145313.GA9217@lst.de> <20200721150432.GH15516@casper.infradead.org> <20200721150615.GA10330@lst.de> <20200721151437.GI15516@casper.infradead.org> <20200721151616.GA11074@lst.de> <20200721152754.GD7597@magnolia> <20200721154132.GA11652@lst.de> <20200721155925.GB3151642@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721155925.GB3151642@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 08:59:25AM -0700, Darrick J. Wong wrote:
> In the comment that precedes iomap_dio_rw() for the iomap version,

maybe let's just do that..

> ``direct_IO``
> 	called by the generic read/write routines to perform direct_IO -
> 	that is IO requests which bypass the page cache and transfer
> 	data directly between the storage and the application's address
> 	space.  This function can return -ENOTBLK to signal that it is
> 	necessary to fallback to buffered IO.  Note that
> 	blockdev_direct_IO and variants can also return -ENOTBLK.

->direct_IO is not used for iomap and various other implementations.
In fact it is a horrible hack that I've been trying to get rid of
for a while.
