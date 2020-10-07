Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873A828616A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgJGOlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 10:41:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38855 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728535AbgJGOls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:41:48 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 097EfEdZ005736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Oct 2020 10:41:15 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3E8A6420107; Wed,  7 Oct 2020 10:41:14 -0400 (EDT)
Date:   Wed, 7 Oct 2020 10:41:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ext4/xfs: add page refcount helper
Message-ID: <20201007144114.GB235506@mit.edu>
References: <20201006230930.3908-1-rcampbell@nvidia.com>
 <CAPcyv4gYtCmzPOWErYOkCCfD0ZvLcrgfR8n2kG3QPMww9B0gyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gYtCmzPOWErYOkCCfD0ZvLcrgfR8n2kG3QPMww9B0gyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 06, 2020 at 07:40:05PM -0700, Dan Williams wrote:
> On Tue, Oct 6, 2020 at 4:09 PM Ralph Campbell <rcampbell@nvidia.com> wrote:
> >
> > There are several places where ZONE_DEVICE struct pages assume a reference
> > count == 1 means the page is idle and free. Instead of open coding this,
> > add a helper function to hide this detail.
> >
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >
> > I'm resending this as a separate patch since I think it is ready to
> > merge. Originally, this was part of an RFC and is unchanged from v3:
> > https://lore.kernel.org/linux-mm/20201001181715.17416-1-rcampbell@nvidia.com
> >
> > It applies cleanly to linux-5.9.0-rc7-mm1 but doesn't really
> > depend on anything, just simple merge conflicts when applied to
> > other trees.
> > I'll let the various maintainers decide which tree and when to merge.
> > It isn't urgent since it is a clean up patch.
> 
> Thanks Ralph, it looks good to me. Jan, or Ted care to ack? I don't
> have much else pending for dax at the moment as Andrew is carrying my
> dax updates for this cycle. Andrew please take this into -mm if you
> get a chance. Otherwise I'll cycle back to it when some other dax
> updates arrive in my queue.

Acked-by: Theodore Ts'o <tytso@mit.edu> # for fs/ext4/inode.c
