Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD3336E10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 09:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhCKImv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 03:42:51 -0500
Received: from verein.lst.de ([213.95.11.211]:39923 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhCKImV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:42:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E7A7968B05; Thu, 11 Mar 2021 09:42:17 +0100 (CET)
Date:   Thu, 11 Mar 2021 09:42:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/9] powerpc/pseries: remove the ppc-cmm file system
Message-ID: <20210311084217.GB7263@lst.de>
References: <20210309155348.974875-1-hch@lst.de> <20210309155348.974875-4-hch@lst.de> <YEjz/+HfILCUwKwb@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEjz/+HfILCUwKwb@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 04:29:51PM +0000, Al Viro wrote:
> On Tue, Mar 09, 2021 at 04:53:42PM +0100, Christoph Hellwig wrote:
> > Just use the generic anon_inode file system.
> 
> Umm...  The only problem I see here is the lifetime rules for
> that module, and that's not something introduced in this patchset.
> Said that, looks like the logics around that place is duplicated in
> cmm.c, vmw_balloon.c and virtion_balloon.c and I wonder if it would
> be better off with a helper in mm/balloon.c to be used for that setup...

Independ of all other discussions untangling that mess does seem
very useful.
