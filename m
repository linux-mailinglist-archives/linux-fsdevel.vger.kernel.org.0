Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F1345B45D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 07:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhKXGkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 01:40:47 -0500
Received: from verein.lst.de ([213.95.11.211]:35810 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhKXGkr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:40:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D2F768AFE; Wed, 24 Nov 2021 07:37:35 +0100 (CET)
Date:   Wed, 24 Nov 2021 07:37:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 08/29] dax: remove dax_capable
Message-ID: <20211124063735.GB6889@lst.de>
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-9-hch@lst.de> <20211123223123.GF266024@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123223123.GF266024@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 02:31:23PM -0800, Darrick J. Wong wrote:
> > -	struct super_block	*sb = mp->m_super;
> > -
> > -	if (!xfs_buftarg_is_dax(sb, mp->m_ddev_targp) &&
> > -	   (!mp->m_rtdev_targp || !xfs_buftarg_is_dax(sb, mp->m_rtdev_targp))) {
> > +	if (!mp->m_ddev_targp->bt_daxdev &&
> > +	   (!mp->m_rtdev_targp || !mp->m_rtdev_targp->bt_daxdev)) {
> 
> Nit: This  ^ paren should be indented one more column because it's a
> sub-clause of the if() test.

Done.

> Nit: xfs_alert() already adds a newline to the end of the format string.

Already done in the current tree.
