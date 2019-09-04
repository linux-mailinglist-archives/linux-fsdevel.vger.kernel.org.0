Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06264A7A9F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 07:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfIDFMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 01:12:33 -0400
Received: from verein.lst.de ([213.95.11.211]:35889 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfIDFMd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:12:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E869E68AEF; Wed,  4 Sep 2019 07:12:29 +0200 (CEST)
Date:   Wed, 4 Sep 2019 07:12:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, agruenba@redhat.com,
        Damien.LeMoal@wdc.com, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: iomap_dio_rw ->end_io improvements
Message-ID: <20190904051229.GA9970@lst.de>
References: <20190903130327.6023-1-hch@lst.de> <20190903221621.GH568270@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903221621.GH568270@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:16:21PM -0700, Darrick J. Wong wrote:
> The biggest problem with merging these patches (and while we're at it,
> Goldwyn's patch adding a srcmap parameter to ->iomap_begin) for 5.4 is
> that they'll break whatever Andreas and Damien have been preparing for
> gfs2 and zonefs (respectively) based off the iomap-writeback work branch
> that I created off of 5.3-rc2 a month ago.

Does Andreas have changes pending that actually pass an end_io call
back to gfs2?  So far it just passed NULL so nothing should change.
If my memory serves me correctly zonefs uses ->end_io, but then again
Damien is asking you to queue it up with the iomap tree, so doing
that trivial rebase shouldn't be an issue.
