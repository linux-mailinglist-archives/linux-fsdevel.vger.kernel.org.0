Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BFC1A8C8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 22:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633214AbgDNUeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 16:34:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:20105 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731386AbgDNUeQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:34:16 -0400
IronPort-SDR: WV0rZ7z4ZYD1NVu+izX+bdC7rqYUmj2KI5Shx7QvOIXO7qQzXSGHfyOr6/2F+yD9lTSAuop2nu
 GsLeK+EGjn0A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 13:34:15 -0700
IronPort-SDR: /7ExacIADyL4EAdkm89htV1tA9FuNr9H5ba4jn/YSKynG6L9Gw4c15bWBEqKQgkgOD60IagH+U
 W6Nm6jD0kYVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="400073146"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga004.jf.intel.com with ESMTP; 14 Apr 2020 13:34:15 -0700
Date:   Tue, 14 Apr 2020 13:34:14 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 4/9] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200414203414.GG1853609@iweiny-DESK2.sc.intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-5-ira.weiny@intel.com>
 <20200414062530.GD23154@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414062530.GD23154@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:25:30AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 12, 2020 at 10:40:41PM -0700, ira.weiny@intel.com wrote:
> > +#define XFS_MOUNT_DAX		(1ULL << 62)
> > +#define XFS_MOUNT_NODAX		(1ULL << 63)
> 
> Replace this with XFS_MOUNT_DAX_ALWAYS and XFS_MOUNT_DAX_NEVER?

Sounds reasonable, Done for v8

Ira

