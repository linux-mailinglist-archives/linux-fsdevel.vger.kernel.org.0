Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB7621A3009
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 09:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDIHbi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 03:31:38 -0400
Received: from verein.lst.de ([213.95.11.211]:45525 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgDIHbh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:31:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7930968C4E; Thu,  9 Apr 2020 09:31:34 +0200 (CEST)
Date:   Thu, 9 Apr 2020 09:31:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 2/8] fs: Remove unneeded IS_DAX() check
Message-ID: <20200409073134.GA31376@lst.de>
References: <20200407182958.568475-1-ira.weiny@intel.com> <20200407182958.568475-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407182958.568475-3-ira.weiny@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 07, 2020 at 11:29:52AM -0700, ira.weiny@intel.com wrote:
>  static inline bool io_is_direct(struct file *filp)
>  {
> -	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
> +	return (filp->f_flags & O_DIRECT);
>  }

As requested last time: Can you please also just remove io_is_direct?
