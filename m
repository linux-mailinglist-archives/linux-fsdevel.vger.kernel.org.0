Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4E031591E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 23:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhBIWH5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 17:07:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:22739 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233274AbhBIWFd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:05:33 -0500
IronPort-SDR: m1NEmaNxZDW8VvhwIgMYE6p1vWWtPigJch6TzLQUn46S2320ILSY8VD3qQu3nFwmYNxsBjgPo9
 7xZSsMvD8s0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="169647767"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="169647767"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 14:03:30 -0800
IronPort-SDR: IaX1CmjvJ6RI7UEhgUqKQATMdtJDd9jx86fON4jSP8M3Tp6sdBoq/7r2rlzbHvMmULvyACX/2p
 hnT9Cv2FCTfA==
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="419836488"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 14:03:29 -0800
Date:   Tue, 9 Feb 2021 14:03:29 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/4] btrfs: Convert kmaps to core page calls
Message-ID: <20210209220329.GF2975576@iweiny-DESK2.sc.intel.com>
References: <20210205232304.1670522-1-ira.weiny@intel.com>
 <20210209151123.GT1993@suse.cz>
 <20210209110931.00f00e47d9a0529fcee2ff01@linux-foundation.org>
 <20210209205249.GB2975576@iweiny-DESK2.sc.intel.com>
 <20210209131103.b46e80db675fec8bec8d2ad1@linux-foundation.org>
 <20210209215229.GC2975576@iweiny-DESK2.sc.intel.com>
 <20210209135837.055cfd1df4e5829f2da6b062@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209135837.055cfd1df4e5829f2da6b062@linux-foundation.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 01:58:37PM -0800, Andrew Morton wrote:
> On Tue, 9 Feb 2021 13:52:29 -0800 Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > > 
> > > Let's please queue this up separately.
> > 
> > Ok can I retain your Ack on the move part of the patch?
> 
> I missed that.
> 
> >  Note that it does change kmap_atomic() to kmap_local_page() currently.
> > 
> > Would you prefer a separate change for that as well?
> 
> Really that should be separated out as well, coming after the move, to
> make it more easily reverted.  With a standalone changlog for this.
> 
> All a bit of a pain, but it's best in the long run.

Consider it done.

Ira

BTW does anyone know the reason this thread is not making it to lore?  I don't
see any of the emails between Andrew and me?

	https://lore.kernel.org/lkml/20210205232304.1670522-1-ira.weiny@intel.com/

