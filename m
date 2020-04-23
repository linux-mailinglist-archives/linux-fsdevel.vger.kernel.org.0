Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647821B66DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 00:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgDWWgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 18:36:22 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:46268 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbgDWWgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 18:36:22 -0400
Received: from dread.disaster.area (pa49-180-0-232.pa.nsw.optusnet.com.au [49.180.0.232])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D11843A2EFA;
        Fri, 24 Apr 2020 08:36:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jRkSA-0006mZ-CN; Fri, 24 Apr 2020 08:36:18 +1000
Date:   Fri, 24 Apr 2020 08:36:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V10 07/11] fs/xfs: Create function
 xfs_inode_should_enable_dax()
Message-ID: <20200423223618.GV27860@dread.disaster.area>
References: <20200422212102.3757660-1-ira.weiny@intel.com>
 <20200422212102.3757660-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422212102.3757660-8-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=XYjVcjsg+1UI/cdbgX7I7g==:117 a=XYjVcjsg+1UI/cdbgX7I7g==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=o7yEu5xeGUGkZ51Z9lIA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 02:20:58PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> xfs_inode_supports_dax() should reflect if the inode can support DAX not
> that it is enabled for DAX.
> 
> Change the use of xfs_inode_supports_dax() to reflect only if the inode
> and underlying storage support dax.
> 
> Add a new function xfs_inode_should_enable_dax() which reflects if the
> inode should be enabled for DAX.
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
