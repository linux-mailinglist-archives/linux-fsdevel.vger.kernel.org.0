Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED15137930
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 18:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfFFQJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 12:09:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:33754 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729191AbfFFQJe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:09:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 09:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,559,1557212400"; 
   d="scan'208";a="182358981"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2019 09:09:34 -0700
Date:   Thu, 6 Jun 2019 09:10:46 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 03/10] mm/gup: Pass flags down to __gup_device_huge*
 calls
Message-ID: <20190606161045.GA11331@iweiny-DESK2.sc.intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606014544.8339-4-ira.weiny@intel.com>
 <20190606061819.GA20520@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606061819.GA20520@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 05, 2019 at 11:18:19PM -0700, Christoph Hellwig wrote:
> On Wed, Jun 05, 2019 at 06:45:36PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > In order to support checking for a layout lease on a FS DAX inode these
> > calls need to know if FOLL_LONGTERM was specified.
> > 
> > Prepare for this with this patch.
> 
> The GUP fast argument passing is a mess.  That is why I've come up
> with this as part of the (not ready) get_user_pages_fast_bvec
> implementation:
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/c3d019802dbde5a4cc4160e7ec8ccba479b19f97

Agreed that looks better.

And I'm sure I will have to re-roll this to deal with conflicts with this set.
But for now I needed this for the follow ons and having a nice separate little
patch like this means I can just drop it after I get your clean up!  :-D

Ira

