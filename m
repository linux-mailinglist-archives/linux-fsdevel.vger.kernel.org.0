Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5E21B321C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 23:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDUVtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 17:49:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:57953 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgDUVtx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:49:53 -0400
IronPort-SDR: BOQAzbOAy5KHQQ8xToWrRII8kPxqF4ya5WRv96TgPbD1YPiRE2o2p95UK8Vld8Ej8paevJQ0GT
 diyRwu8TMa8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 14:49:53 -0700
IronPort-SDR: eVfo8RINT9OgNT3GeFKPNilkLAYIFW8XAxi5dWgdN+xqxjdVrKmQ/RJCg+tlL0tecIWGRGx6iy
 IIWxugc7skpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="245797152"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2020 14:49:53 -0700
Date:   Tue, 21 Apr 2020 14:49:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 11/11] Documentation/dax: Update Usage section
Message-ID: <20200421214952.GE3372712@iweiny-DESK2.sc.intel.com>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-12-ira.weiny@intel.com>
 <20200421203423.GE6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421203423.GE6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 01:34:23PM -0700, Darrick J. Wong wrote:
> On Tue, Apr 21, 2020 at 12:17:53PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Update the Usage section to reflect the new individual dax selection
> > functionality.
> > 

[snip]

> > +
> > +The default state is 'inode'.  Given underlying media support, the following
> > +algorithm is used to determine the effective mode of the file S_DAX on a
> > +capable device.
> > +
> > +	S_DAX = FS_XFLAG_DAX;
> > +
> > +	if (dax_mount == "always")
> > +		S_DAX = true;
> > +	else if (dax_mount == "off"
> 
> Missing trailing parenthesis here.

Done.

> 
> > +		S_DAX = false;
> > +
> > +To reiterate: Setting, and inheritance, continues to affect FS_XFLAG_DAX even
> > +while the file system is mounted with a dax override.  However, in-core inode
> > +state (S_DAX) will continue to be overridden until the filesystem is remounted
> > +with dax=inode and the inode is evicted."
> 
> Trailing double-quote here.

Fixed done.

> 
> Otherwise, this looks good to me.

thanks,
Ira
