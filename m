Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFBF333758
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 09:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCJIdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 03:33:06 -0500
Received: from verein.lst.de ([213.95.11.211]:35121 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhCJIcf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:32:35 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C9A8168B05; Wed, 10 Mar 2021 09:32:31 +0100 (CET)
Date:   Wed, 10 Mar 2021 09:32:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: make alloc_anon_inode more useful
Message-ID: <20210310083231.GB5217@lst.de>
References: <20210309155348.974875-1-hch@lst.de> <20210309165452.GL2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309165452.GL2356281@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 09, 2021 at 12:54:52PM -0400, Jason Gunthorpe wrote:
> On Tue, Mar 09, 2021 at 04:53:39PM +0100, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series first renames the existing alloc_anon_inode to
> > alloc_anon_inode_sb to clearly mark it as requiring a superblock.
> > 
> > It then adds a new alloc_anon_inode that works on the anon_inode
> > file system super block, thus removing tons of boilerplate code.
> > 
> > The few remainig callers of alloc_anon_inode_sb all use alloc_file_pseudo
> > later, but might also be ripe for some cleanup.
> 
> I like it
> 
> For a submission plan can we have this on a git branch please? I will
> need a copy for RDMA and Alex will need one for vfio..

anon_inode.c stuff seems to mostly go through Al's tree, but also various
others.  So best would be if Al has a branch, but I could also set one up.
