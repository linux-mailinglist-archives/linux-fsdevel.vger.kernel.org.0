Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCD1170E94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 03:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgB0Cn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 21:43:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:57388 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbgB0Cn6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:43:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 18:43:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="436874427"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 26 Feb 2020 18:43:56 -0800
Date:   Wed, 26 Feb 2020 18:43:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 00/13] Enable per-file/per-directory DAX operations V4
Message-ID: <20200227024356.GB28721@iweiny-DESK2.sc.intel.com>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <x49pne13qyh.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49pne13qyh.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 05:48:38PM -0500, Jeff Moyer wrote:
> Hi, Ira,
> 
> ira.weiny@intel.com writes:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > https://github.com/weiny2/linux-kernel/pull/new/dax-file-state-change-v4
> >
> > Changes from V3: 
> > https://lore.kernel.org/lkml/20200208193445.27421-1-ira.weiny@intel.com/
> >
> > 	* Remove global locking...  :-D
> > 	* put back per inode locking and remove pre-mature optimizations
> > 	* Fix issues with Directories having IS_DAX() set
> > 	* Fix kernel crash issues reported by Jeff
> > 	* Add some clean up patches
> > 	* Consolidate diflags to iflags functions
> > 	* Update/add documentation
> > 	* Reorder/rename patches quite a bit
> 
> I left out patches 1 and 2, but applied the rest and tested.  This
> passes xfs tests in the following configurations:
> 1) MKFS_OPTIONS="-m reflink=0" MOUNT_OPTIONS="-o dax"
> 2) MKFS_OPTIONS="-m reflink=0"
>    but with the added configuration step of setting the dax attribute on
>    the mounted test directory.
> 
> I also tested to ensure that reflink fails when a file has the dax
> attribute set.  I've got more testing to do, but figured I'd at least
> let you know I've been looking at it.

Thank you!

I need to update my xfstest which is specific to this as well...  I'll get to
that tomorrow and send an updated patch...

Thanks!
Ira

> 
> Thanks!
> Jeff
> 
