Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34381D2858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 08:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgENGz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 02:55:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:24279 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgENGz0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 02:55:26 -0400
IronPort-SDR: LmGVgLkRdaEFxxRrNnTbG+YU0GlEAgYw34/dzCUlj86jByMeJRw6Vgoc+9xFH6z0bNVLytw6bW
 tdG0oK4nQqHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:55:25 -0700
IronPort-SDR: 4EAhcH2eyjRNOzx8+C1/Q5Cp+otOL2Ga0272rzp6JWprrN/Q7Ido8gTOuH7YhUPeM66uO8vav/
 LKhqViWQUQGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="464413086"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga006.fm.intel.com with ESMTP; 13 May 2020 23:55:25 -0700
Date:   Wed, 13 May 2020 23:55:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] fs/ext4: Introduce DAX inode flag
Message-ID: <20200514065524.GC2140786@iweiny-DESK2.sc.intel.com>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-9-ira.weiny@intel.com>
 <20200513144706.GH27709@quack2.suse.cz>
 <20200513214154.GB2140786@iweiny-DESK2.sc.intel.com>
 <20200514064335.GB9569@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514064335.GB9569@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 08:43:35AM +0200, Jan Kara wrote:
> On Wed 13-05-20 14:41:55, Ira Weiny wrote:
> > On Wed, May 13, 2020 at 04:47:06PM +0200, Jan Kara wrote:
> > >
> > > So I think you'll have to check
> > > whether DAX flag is being changed,
> > 
> > ext4_dax_dontcache() does check if the flag is being changed.
> 
> Yes, but if you call it after inode flags change, you cannot determine that
> just from flags and EXT4_I(inode)->i_flags. So that logic needs to change.

I just caught this email... just after sending V1.

I've moved where ext4_dax_dontcache() is called.  I think it is ok now with the
current check.

LMK if I've messed it up...  :-/

Ira

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
