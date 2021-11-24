Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521F345B467
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 07:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbhKXGms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 01:42:48 -0500
Received: from verein.lst.de ([213.95.11.211]:35823 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhKXGmr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:42:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D92CF68AFE; Wed, 24 Nov 2021 07:39:34 +0100 (CET)
Date:   Wed, 24 Nov 2021 07:39:34 +0100
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
Subject: Re: [PATCH 14/29] fsdax: simplify the pgoff calculation
Message-ID: <20211124063934.GC6889@lst.de>
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-15-hch@lst.de> <20211123223642.GI266024@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123223642.GI266024@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 02:36:42PM -0800, Darrick J. Wong wrote:
> > -	phys_addr_t phys_off = (start_sect + sector) * 512;
> > -
> > -	if (pgoff)
> > -		*pgoff = PHYS_PFN(phys_off);
> > -	if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
> 
> AFAICT, we're relying on fs_dax_get_by_bdev to have validated this
> previously, which is why the error return stuff goes away?

Exactly.
