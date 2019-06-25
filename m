Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97E65292B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 12:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfFYKNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 06:13:23 -0400
Received: from verein.lst.de ([213.95.11.211]:33445 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfFYKNX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:13:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 04CA768B05; Tue, 25 Jun 2019 12:12:51 +0200 (CEST)
Date:   Tue, 25 Jun 2019 12:12:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] xfs: remove XFS_TRANS_NOFS
Message-ID: <20190625101250.GJ1462@lst.de>
References: <20190624055253.31183-1-hch@lst.de> <20190624055253.31183-7-hch@lst.de> <20190624225904.GB7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624225904.GB7777@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 08:59:04AM +1000, Dave Chinner wrote:
> On Mon, Jun 24, 2019 at 07:52:47AM +0200, Christoph Hellwig wrote:
> > Instead of a magic flag for xfs_trans_alloc, just ensure all callers
> > that can't relclaim through the file system use memalloc_nofs_save to
> > set the per-task nofs flag.
> 
> I'm thinking that it would be a good idea to add comments to explain
> exactly what the memalloc_nofs_save/restore() are protecting where
> they are used. Right now the XFS_TRANS_NOFS flag is largely
> undocumented, so a reader is left guessing as to why the flag is
> necessary and what contexts it may apply to. Hence I think we should
> fix that while we are changing over to a different GFP_NOFS
> allocation context mechanism....

Sure.
