Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5233374D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 09:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhCJIau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 03:30:50 -0500
Received: from verein.lst.de ([213.95.11.211]:35099 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhCJIap (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:30:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CA5168B05; Wed, 10 Mar 2021 09:30:41 +0100 (CET)
Date:   Wed, 10 Mar 2021 09:30:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/9] fs: rename alloc_anon_inode to alloc_anon_inode_sb
Message-ID: <20210310083040.GA5217@lst.de>
References: <20210309155348.974875-1-hch@lst.de> <20210309155348.974875-2-hch@lst.de> <YEhpiRCOUll6Ri6J@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEhpiRCOUll6Ri6J@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:39:05PM -0800, Minchan Kim wrote:
> > -struct inode *alloc_anon_inode(struct super_block *s)
> > +struct inode *alloc_anon_inode_sb(struct super_block *s)
> >  {
> >  	static const struct address_space_operations anon_aops = {
> >  		.set_page_dirty = anon_set_page_dirty,
> 
> EXPORT_SYMBOL(alloc_anon_inode_sb) ?

Yes, I actually fixed this up shortly after sending the series.
