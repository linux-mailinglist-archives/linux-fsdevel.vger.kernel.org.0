Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503DB1A8CA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 22:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633276AbgDNUjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 16:39:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:20214 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633271AbgDNUjP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:39:15 -0400
IronPort-SDR: 7mZfxL0dywrp+YRKi5y3VEr+t6jjr2eMj4AbLgFr+rszM9A6rwW04ff9IqRWpmQ8tRM+Y5U2M+
 OfZ4XOkZA/Yg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 13:39:13 -0700
IronPort-SDR: 7pqIX6PVS4iEVIXIAgFH4UOqHFplFeItWNGqkULEons+fNnJrmTkr+rMrP7/4Mq0CqJFRE7Wdn
 2s8qCCEwkDXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="243919223"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 14 Apr 2020 13:39:12 -0700
Date:   Tue, 14 Apr 2020 13:39:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 3/9] fs/stat: Define DAX statx attribute
Message-ID: <20200414203912.GA1982089@iweiny-DESK2.sc.intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-4-ira.weiny@intel.com>
 <20200414062306.GB23154@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414062306.GB23154@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:23:06AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 12, 2020 at 10:40:40PM -0700, ira.weiny@intel.com wrote:
> > STATX_ATTR_DAX
> > 
> > 	The file is in the DAX (cpu direct access) state.  DAX state
> > 	attempts to minimize software cache effects for both I/O and
> > 	memory mappings of this file.  It requires a file system which
> > 	has been configured to support DAX.
> 
> Can we remove the misleading DAX name?  Something like
> STATX_ATTR_DIRECT_LOAD_STORE?

This is easy enough to change but...

Honestly I feel like this ship has already sailed.  We have so much out there
which uses the term "DAX".  Is it really better to introduce a new terminology
for the same thing?

Ira

