Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F57DBE35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2019 09:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbfJRHUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Oct 2019 03:20:43 -0400
Received: from verein.lst.de ([213.95.11.211]:45772 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbfJRHUn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:20:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A78B568BE1; Fri, 18 Oct 2019 09:20:40 +0200 (CEST)
Date:   Fri, 18 Oct 2019 09:20:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 01/14] iomap: iomap that extends beyond EOF should be
 marked dirty
Message-ID: <20191018072040.GB23428@lst.de>
References: <20191017175624.30305-1-hch@lst.de> <20191017175624.30305-2-hch@lst.de> <20191017183917.GL13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017183917.GL13108@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:39:17AM -0700, Darrick J. Wong wrote:
> Looks ok, but need fixes tag.  Also, might it be wise to split off the
> ext4 section into a separate patch so that it can be backported
> separately?

I'll let Dave handle all that.  I've just pulled it in here as multiple
patches conflict with this one.
