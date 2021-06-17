Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747BE3AAF28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 10:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFQI5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 04:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFQI5U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:57:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B14C061574;
        Thu, 17 Jun 2021 01:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7kLQp6MYKDk8/sAaxwp980AGLDLmbDndmOr3pBheMP8=; b=s8gPNuR5E60SDx/0jvFuG+ztKT
        LhkO7ekXck3IFxpaFRh0aXcx68zPSCb9j8qEojrfsBzB458A8Wpo3blG/4i9Fgwvbw3TjTMpCRW59
        VDdK549e9Uj+LlQ4b0QFL2VyktYjZNBGvUW6vlpaztsCzTyyYhazCPnhn1tUZ5f4pnweFZ+zoTfcW
        vi3pQgHb9r1oipRjtDslyHYP3KK6c5uEA0YJ0qhlIfuVzu7oTLsvgGpZktf1hxdc8y2w+1WnpyYtm
        5hFg7oBbDir+o13KteeAI+h/AHOcmJHO7kEJdITTE4WSd+WSgTmHe3mKfyx7gYxOZETR30oq6EHa1
        6BJ7DQog==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltnnN-008wOt-0k; Thu, 17 Jun 2021 08:54:45 +0000
Date:   Thu, 17 Jun 2021 09:54:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        ceph-devel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Reichl <preichl@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 07/14] xfs: Refactor xfs_isilocked()
Message-ID: <YMsN0beVOAXn0Mx4@infradead.org>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-7-jack@suse.cz>
 <YMr/eA3Eq2u6yUNw@infradead.org>
 <20210617085319.GD32587@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617085319.GD32587@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:53:19AM +0200, Jan Kara wrote:
> On Thu 17-06-21 08:53:28, Christoph Hellwig wrote:
> > On Tue, Jun 15, 2021 at 11:17:57AM +0200, Jan Kara wrote:
> > > From: Pavel Reichl <preichl@redhat.com>
> > > 
> > > Refactor xfs_isilocked() to use newly introduced __xfs_rwsem_islocked().
> > > __xfs_rwsem_islocked() is a helper function which encapsulates checking
> > > state of rw_semaphores hold by inode.
> > 
> > Looks good with the updated commit log:
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I suppose you mean Reviewed-by, don't you?

Yes:

Reviewed-by: Christoph Hellwig <hch@lst.de>
