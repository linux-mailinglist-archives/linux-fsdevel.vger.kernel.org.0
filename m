Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095859A446
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 02:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfHWAYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 20:24:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:11269 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfHWAYq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 20:24:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 17:24:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,419,1559545200"; 
   d="scan'208";a="173314320"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2019 17:24:44 -0700
Date:   Thu, 22 Aug 2019 17:24:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mm/gup: introduce vaddr_pin_pages_remote(),
 FOLL_PIN
Message-ID: <20190823002443.GA19517@iweiny-DESK2.sc.intel.com>
References: <20190821040727.19650-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821040727.19650-1-jhubbard@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 09:07:24PM -0700, John Hubbard wrote:
> Hi Ira,
> 
> This is for your tree. I'm dropping the RFC because this aspect is
> starting to firm up pretty well.
> 
> I've moved FOLL_PIN inside the vaddr_pin_*() routines, and moved
> FOLL_LONGTERM outside, based on our recent discussions. This is
> documented pretty well within the patches.
> 
> Note that there are a lot of references in comments and commit
> logs, to vaddr_pin_pages(). We'll want to catch all of those if
> we rename that. I am pushing pretty hard to rename it to
> vaddr_pin_user_pages().
> 
> v1 of this may be found here:
> https://lore.kernel.org/r/20190812015044.26176-1-jhubbard@nvidia.com

I am really sorry about this...

I think it is fine to pull these in...  There are some nits which are wrong but
I think with the XDP complication and Daves' objection I think the vaddr_pin
information is going to need reworking.  So the documentation there is probably
wrong.  But until we know what it is going to be we should just take this.

Do you have a branch with this on it?

The patches don't seem to apply.  Looks like they got corrupted somewhere...

:-/

Thanks,
Ira

> 
> John Hubbard (3):
>   For Ira: tiny formatting tweak to kerneldoc
>   mm/gup: introduce FOLL_PIN flag for get_user_pages()
>   mm/gup: introduce vaddr_pin_pages_remote(), and invoke it
> 
>  drivers/infiniband/core/umem.c |  1 +
>  include/linux/mm.h             | 61 ++++++++++++++++++++++++++++++----
>  mm/gup.c                       | 40 ++++++++++++++++++++--
>  mm/process_vm_access.c         | 23 +++++++------
>  4 files changed, 106 insertions(+), 19 deletions(-)
> 
> -- 
> 2.22.1
> 
> 
