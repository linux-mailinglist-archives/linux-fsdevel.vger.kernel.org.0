Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0082CE556
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 02:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgLDBpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 20:45:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:22953 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLDBpV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:45:21 -0500
IronPort-SDR: Jzy7hgoFvCwEvhfL1SOvWeK+Y/VUtYQQIFp4FpNsaF2NQoJJ/rlqtO927JIw+OU92gXJ3fs6UQ
 zX1bwPIimnGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="234917597"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="234917597"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 17:44:39 -0800
IronPort-SDR: Mcyx6D3nTWzTvO62HGuIWnhDH61K3QPnToO9ehSCOjzrP6vE+6CubJn4BHBf5TPwi1z2rwyT5L
 gRoCR+h9HxLg==
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="482195127"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 17:44:39 -0800
Date:   Thu, 3 Dec 2020 17:44:39 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Eric Sandeen <sandeen@sandeen.net>, fstests@vger.kernel.org,
        Eric Sandeen <sandeen@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] common/rc: Fix _check_s_dax()
Message-ID: <20201204014439.GE1563847@iweiny-DESK2.sc.intel.com>
References: <20201202214145.1563433-1-ira.weiny@intel.com>
 <20201203081556.GA15306@lst.de>
 <b757842d-b020-49c9-498c-df5de89f10af@sandeen.net>
 <20201203180838.GA25196@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203180838.GA25196@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 07:08:39PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 03, 2020 at 11:55:50AM -0600, Eric Sandeen wrote:
> > *nod* and my suggestion was to explicitly test for the old/wrong value and
> > offer the test-runner a hint about why it may have been set (missing the
> > fix commit), but we should still ultimately fail the test when it is seen.
> 
> Yes, that's what I'd prefer.

Sorry for the misunderstanding.  V3 on it's way.

Ira
