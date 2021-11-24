Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B26745B517
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 08:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbhKXHRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 02:17:43 -0500
Received: from verein.lst.de ([213.95.11.211]:35989 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231555AbhKXHRn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:17:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8727968AFE; Wed, 24 Nov 2021 08:14:30 +0100 (CET)
Date:   Wed, 24 Nov 2021 08:14:30 +0100
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
Subject: Re: [PATCH 23/29] xfs: use IOMAP_DAX to check for DAX mappings
Message-ID: <20211124071430.GD7229@lst.de>
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-24-hch@lst.de> <20211123230124.GR266024@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123230124.GR266024@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 03:01:24PM -0800, Darrick J. Wong wrote:
> On Tue, Nov 09, 2021 at 09:33:03AM +0100, Christoph Hellwig wrote:
> > Use the explicit DAX flag instead of checking the inode flag in the
> > iomap code.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Any particular reason to pass this in as a flag vs. querying the inode?

Same reason as the addition of IOMAP_DAX.  But I think I'll redo this
a bit to do the XFS paramater passing first and then actually check
IOMAP_DAX together with introducing it to make it all a little more clear.
