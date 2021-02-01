Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09E030AD45
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 18:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhBAQ7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 11:59:12 -0500
Received: from verein.lst.de ([213.95.11.211]:42096 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbhBAQ7K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:59:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7D2AE68AFE; Mon,  1 Feb 2021 17:58:26 +0100 (CET)
Date:   Mon, 1 Feb 2021 17:58:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <david@fromorbit.com>
Subject: Re: reduce sub-block DIO serialisation v4
Message-ID: <20210201165825.GB9858@lst.de>
References: <20210122162043.616755-1-hch@lst.de> <20210123185706.GG1282159@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123185706.GG1282159@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 23, 2021 at 10:57:06AM -0800, Darrick J. Wong wrote:
> On Fri, Jan 22, 2021 at 05:20:32PM +0100, Christoph Hellwig wrote:
> > This takes the approach from Dave, but adds a new flag instead of abusing
> > the nowait one, and keeps a simpler calling convention for iomap_dio_rw.
> 
> Hm.  I realized while putting together for-next branches that I really
> would have preferred the three iomap patches at the start so that I
> could push those parts through the iomap tree.  The changes required to
> resequence the series is minor and the iomap changes (AFAICT) are inert
> if the calling fs doesn't set IOMAP_DIO_OVERWRITE_ONLY, so I think it's
> low risk to push the iomap changes into iomap-for-next as a 5.12 thing.
> 
> The rest of the xfs patches in this series would form the basis of a
> second week pull request (or not) since I think I ought to evaluate the
> effects on performance for a little longer.

So that is the reason why they aren't in for-next yet?  Or do you want
the remaining patches resent on top of the iomap branch?
