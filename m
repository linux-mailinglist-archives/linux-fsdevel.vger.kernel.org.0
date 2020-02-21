Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233B0168617
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgBUSGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:06:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:40438 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgBUSGI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:06:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 10:06:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,469,1574150400"; 
   d="scan'208";a="225289968"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2020 10:06:07 -0800
Date:   Fri, 21 Feb 2020 10:06:07 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 10/13] fs/xfs: Clean up locking in dax invalidate
Message-ID: <20200221180607.GA4462@iweiny-DESK2.sc.intel.com>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-11-ira.weiny@intel.com>
 <20200221174522.GC11378@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221174522.GC11378@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 06:45:22PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 04:41:31PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Define a variable to hold the lock flags to ensure that the correct
> > locks are returned or released on error.
> 
> I don't see how this cleans up anything..

It ensures the correct flags are released in the error path without having to
add the flag in the next patch in 2 places.

Ira

