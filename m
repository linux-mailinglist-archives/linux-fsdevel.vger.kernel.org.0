Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B691D2815
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 08:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgENGnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 02:43:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:47688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgENGnj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 02:43:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 23C0EAE4B;
        Thu, 14 May 2020 06:43:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E48FE1E12A8; Thu, 14 May 2020 08:43:35 +0200 (CEST)
Date:   Thu, 14 May 2020 08:43:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] fs/ext4: Introduce DAX inode flag
Message-ID: <20200514064335.GB9569@quack2.suse.cz>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-9-ira.weiny@intel.com>
 <20200513144706.GH27709@quack2.suse.cz>
 <20200513214154.GB2140786@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513214154.GB2140786@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-05-20 14:41:55, Ira Weiny wrote:
> On Wed, May 13, 2020 at 04:47:06PM +0200, Jan Kara wrote:
> >
> > So I think you'll have to check
> > whether DAX flag is being changed,
> 
> ext4_dax_dontcache() does check if the flag is being changed.

Yes, but if you call it after inode flags change, you cannot determine that
just from flags and EXT4_I(inode)->i_flags. So that logic needs to change.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
