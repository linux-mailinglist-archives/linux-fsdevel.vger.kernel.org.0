Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16E21B3509
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 04:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDVCe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 22:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDVCeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:34:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F6FC0610D6;
        Tue, 21 Apr 2020 19:34:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR5DD-00815r-17; Wed, 22 Apr 2020 02:34:07 +0000
Date:   Wed, 22 Apr 2020 03:34:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 09/11] fs: Introduce DCACHE_DONTCACHE
Message-ID: <20200422023407.GH23230@ZenIV.linux.org.uk>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-10-ira.weiny@intel.com>
 <20200421202519.GC6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421202519.GC6742@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 01:25:19PM -0700, Darrick J. Wong wrote:

> > DCACHE_DONTCACHE indicates a dentry should not be cached on final
> > dput().
> > 
> > Also add a helper function to mark DCACHE_DONTCACHE on all dentries
> > pointing to a specific inode when that inode is being set I_DONTCACHE.
> > 
> > This facilitates dropping dentry references to inodes sooner which
> > require eviction to swap S_DAX mode.

Explain, please.  Questions:

1) does that ever happen to directories?
2) how much trouble do we get if such inode is *NOT* evicted for, say, several
days?
