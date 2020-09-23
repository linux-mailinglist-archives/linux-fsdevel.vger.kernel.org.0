Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83197275086
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 07:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIWF7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 01:59:35 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:49010 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgIWF7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:59:35 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3B64B825975;
        Wed, 23 Sep 2020 15:59:25 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kKxoK-0004zG-D5; Wed, 23 Sep 2020 15:59:24 +1000
Date:   Wed, 23 Sep 2020 15:59:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/15] iomap: Call inode_dio_end() before
 generic_write_sync()
Message-ID: <20200923055924.GE12096@dread.disaster.area>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-5-rgoldwyn@suse.de>
 <20bf949a-7237-8409-4230-cddb430026a9@toxicpanda.com>
 <20200922163156.GD7949@magnolia>
 <20200922214934.GC12096@dread.disaster.area>
 <20200923051658.GA14957@lst.de>
 <20200923053149.GK7964@magnolia>
 <20200923054925.GA15389@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923054925.GA15389@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=sFGyzmBIlTUhO1WhgXwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 07:49:25AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 22, 2020 at 10:31:49PM -0700, Darrick J. Wong wrote:
> > > ... and I replied with a detailed analysis of what it is fine, and
> > > how this just restores the behavior we historically had before
> > > switching to the iomap direct I/O code.  Although if we want to go
> > > into the fine details we did not have the REQ_FUA path back then,
> > > but that does not change the analysis.
> > 
> > You did?  Got a link?  Not sure if vger/oraclemail are still delaying
> > messages for me.... :/
> 
> Two replies from September 17 to the
> "Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context"
> 
> thread.
> 
> Msg IDs:
> 
> 20200917055232.GA31646@lst.de
> 
> and
> 
> 20200917064238.GA32441@lst.de

<sigh>

That last one is not in my local archive - vger has been on the
blink lately, so I guess I'm not really that surprised that mail has
gone missing and not just delayed for a day or two....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
