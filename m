Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59671A7389
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 08:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405919AbgDNGXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 02:23:10 -0400
Received: from verein.lst.de ([213.95.11.211]:37610 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbgDNGXJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 02:23:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7474768BEB; Tue, 14 Apr 2020 08:23:06 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:23:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 3/9] fs/stat: Define DAX statx attribute
Message-ID: <20200414062306.GB23154@lst.de>
References: <20200413054046.1560106-1-ira.weiny@intel.com> <20200413054046.1560106-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413054046.1560106-4-ira.weiny@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:40:40PM -0700, ira.weiny@intel.com wrote:
> STATX_ATTR_DAX
> 
> 	The file is in the DAX (cpu direct access) state.  DAX state
> 	attempts to minimize software cache effects for both I/O and
> 	memory mappings of this file.  It requires a file system which
> 	has been configured to support DAX.

Can we remove the misleading DAX name?  Something like
STATX_ATTR_DIRECT_LOAD_STORE?
