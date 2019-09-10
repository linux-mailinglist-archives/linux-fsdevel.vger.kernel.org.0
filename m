Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09D2AF29F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 23:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfIJVaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 17:30:13 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54369 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbfIJVaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 17:30:13 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 28396361F16;
        Wed, 11 Sep 2019 07:30:09 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1i7niC-00064U-57; Wed, 11 Sep 2019 07:30:08 +1000
Date:   Wed, 11 Sep 2019 07:30:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien.LeMoal@wdc.com, agruenba@redhat.com
Subject: Re: [PATCH v4 0/6] iomap: lift the xfs writepage code into iomap
Message-ID: <20190910213008.GL16973@dread.disaster.area>
References: <156444945993.2682261.3926017251626679029.stgit@magnolia>
 <20190816065229.GA28744@infradead.org>
 <20190817014633.GE752159@magnolia>
 <20190901073440.GB13954@infradead.org>
 <20190901204400.GQ5354@magnolia>
 <20190902171637.GA10893@infradead.org>
 <20190910070124.GA23712@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910070124.GA23712@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=PON3oP9ZDMQz3vNVLwUA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 10, 2019 at 12:01:24AM -0700, Christoph Hellwig wrote:
> On Mon, Sep 02, 2019 at 10:16:37AM -0700, Christoph Hellwig wrote:
> > On Sun, Sep 01, 2019 at 01:44:00PM -0700, Darrick J. Wong wrote:
> > > Would you mind rebasing the remaining patches against iomap-for-next and
> > > sending that out?  I'll try to get to it before I go on vacation 6 - 15
> > > Sept.
> > 
> > Ok.  Testing right now, but the rebase was trivial.
> > 
> > > Admittedly I think the controversial questions are still "How much
> > > writeback code are we outsourcing to iomap anyway?" and "Do we want to
> > > do the added stress of keeping that going without breaking everyone
> > > else"?  IOWs, more philosophical than just the mechanics of porting code
> > > around.
> > 
> > At least as far as I'm concerned the more code that is common the
> > better so that I don't have to fix up 4 badly maintained half-assed
> > forks of the same code (hello mpage, ext4 and f2fs..).
> 
> Any news?

Darrick is still on holidays. The iomap-for-next branch has this
series in it already(*), but I suspect at this point the XFS
conversion is going to have to wait until the next cycle.

Cheers,

Dave.

(*) https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/log/?h=iomap-for-next

-- 
Dave Chinner
david@fromorbit.com
