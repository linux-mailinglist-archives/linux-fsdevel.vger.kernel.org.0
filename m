Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64889569D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 14:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfFZMze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 08:55:34 -0400
Received: from verein.lst.de ([213.95.11.211]:42926 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfFZMzd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:55:33 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C479768B05; Wed, 26 Jun 2019 14:55:02 +0200 (CEST)
Date:   Wed, 26 Jun 2019 14:55:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: don't mark the inode dirty in
 iomap_write_end
Message-ID: <20190626125502.GB4744@lst.de>
References: <20190626120333.13310-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626120333.13310-1-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 02:03:32PM +0200, Andreas Gruenbacher wrote:
> Marking the inode dirty for each page copied into the page cache can be
> very inefficient for file systems that use the VFS dirty inode tracking,
> and is completely pointless for those that don't use the VFS dirty inode
> tracking.  So instead, only set an iomap flag when changing the in-core
> inode size, and open code the rest of __generic_write_end.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Nitpick: a patch from you should never have me as the first signoff.
Just drop it, and if you feel fancy add a 'Partially based on code
from Christoph Hellwig.' sentence.  Not that I care much.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Doesn't the series also need a third patch reducing the amount
of mark_inode_dirty calls as per your initial proposal?
