Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB50D81F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfJOVUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:20:25 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:50698 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbfJOVUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:20:25 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 49BCF362940;
        Wed, 16 Oct 2019 08:20:22 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iKUEu-0000bN-Oj; Wed, 16 Oct 2019 08:20:20 +1100
Date:   Wed, 16 Oct 2019 08:20:20 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] xfs: initialize iomap->flags in xfs_bmbt_to_iomap
Message-ID: <20191015212020.GU16973@dread.disaster.area>
References: <20191015154345.13052-1-hch@lst.de>
 <20191015154345.13052-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015154345.13052-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=lhxiFK1EMG2CG1D2i8wA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 05:43:34PM +0200, Christoph Hellwig wrote:
> Currently we don't overwrite the flags field in the iomap in
> xfs_bmbt_to_iomap.  This works fine with 0-initialized iomaps on stack,
> but is harmful once we want to be able to reuse an iomap in the
> writeback code.  Replace the shared paramter with a set of initial
> flags an thus ensures the flags field is always reinitialized.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
