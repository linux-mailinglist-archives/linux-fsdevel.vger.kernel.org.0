Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1921D2DFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 13:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgENLPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 07:15:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgENLPr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 07:15:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3141EB04C;
        Thu, 14 May 2020 11:15:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8D5B21E12A8; Thu, 14 May 2020 13:15:44 +0200 (CEST)
Date:   Thu, 14 May 2020 13:15:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 9/9] Documentation/dax: Update DAX enablement for ext4
Message-ID: <20200514111544.GG9569@quack2.suse.cz>
References: <20200514065316.2500078-1-ira.weiny@intel.com>
 <20200514065316.2500078-10-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514065316.2500078-10-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-05-20 23:53:15, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Update the document to reflect ext4 and xfs now behave the same.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes from RFC:
> 	Update with ext2 text...
> ---
>  Documentation/filesystems/dax.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
> index 735fb4b54117..265c4f808dbf 100644
> --- a/Documentation/filesystems/dax.txt
> +++ b/Documentation/filesystems/dax.txt
> @@ -25,7 +25,7 @@ size when creating the filesystem.
>  Currently 3 filesystems support DAX: ext2, ext4 and xfs.  Enabling DAX on them
>  is different.
>  
> -Enabling DAX on ext4 and ext2
> +Enabling DAX on ext2
>  -----------------------------
>  
>  When mounting the filesystem, use the "-o dax" option on the command line or
> @@ -33,8 +33,8 @@ add 'dax' to the options in /etc/fstab.  This works to enable DAX on all files
>  within the filesystem.  It is equivalent to the '-o dax=always' behavior below.
>  
>  
> -Enabling DAX on xfs
> --------------------
> +Enabling DAX on xfs and ext4
> +----------------------------
>  
>  Summary
>  -------
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
