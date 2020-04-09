Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C0B1A3666
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 16:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgDIO5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 10:57:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:43830 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgDIO5s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:57:48 -0400
IronPort-SDR: +8O6pwnemwrKSqSh+fFrfOmtUnRm7BiVFT1l6Cu002rGQdAHf2DAZZRYZk9fVTycRmGctKdAcc
 Bi4w8lEXRDgg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 07:57:48 -0700
IronPort-SDR: hWIHqFJAKXewk6/sKwLmSZsN92xEpLx2GPDTgP2gywa6d7/KUy8wCmqL7INQxhknGssoSm/7+z
 7dsmfMxNOd0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; 
   d="scan'208";a="286912897"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga002.fm.intel.com with ESMTP; 09 Apr 2020 07:57:48 -0700
Date:   Thu, 9 Apr 2020 07:57:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 2/8] fs: Remove unneeded IS_DAX() check
Message-ID: <20200409145747.GF664132@iweiny-DESK2.sc.intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-3-ira.weiny@intel.com>
 <20200409073134.GA31376@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409073134.GA31376@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 09:31:34AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 07, 2020 at 11:29:52AM -0700, ira.weiny@intel.com wrote:
> >  static inline bool io_is_direct(struct file *filp)
> >  {
> > -	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
> > +	return (filp->f_flags & O_DIRECT);
> >  }
> 
> As requested last time: Can you please also just remove io_is_direct?

FWIW I just found this mail in my junk folder...  My fault I know... :-/

Regardless I did not see that request last time but I can do that,

Done for V7
Ira
