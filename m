Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B7D275077
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 07:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgIWFt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 01:49:29 -0400
Received: from verein.lst.de ([213.95.11.211]:47260 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgIWFt3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:49:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB6F367373; Wed, 23 Sep 2020 07:49:25 +0200 (CEST)
Date:   Wed, 23 Sep 2020 07:49:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/15] iomap: Call inode_dio_end() before
 generic_write_sync()
Message-ID: <20200923054925.GA15389@lst.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de> <20200921144353.31319-5-rgoldwyn@suse.de> <20bf949a-7237-8409-4230-cddb430026a9@toxicpanda.com> <20200922163156.GD7949@magnolia> <20200922214934.GC12096@dread.disaster.area> <20200923051658.GA14957@lst.de> <20200923053149.GK7964@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923053149.GK7964@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:31:49PM -0700, Darrick J. Wong wrote:
> > ... and I replied with a detailed analysis of what it is fine, and
> > how this just restores the behavior we historically had before
> > switching to the iomap direct I/O code.  Although if we want to go
> > into the fine details we did not have the REQ_FUA path back then,
> > but that does not change the analysis.
> 
> You did?  Got a link?  Not sure if vger/oraclemail are still delaying
> messages for me.... :/

Two replies from September 17 to the
"Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context"

thread.

Msg IDs:

20200917055232.GA31646@lst.de

and

20200917064238.GA32441@lst.de
