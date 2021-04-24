Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3B7369F02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Apr 2021 08:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhDXGNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Apr 2021 02:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhDXGM4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Apr 2021 02:12:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EFEC061574;
        Fri, 23 Apr 2021 23:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QyglVt+EWc9B423iJYSDhdV5d15kNgjcPs3aWvxtgoI=; b=aHlXZ3V/yaWD2pxpPq5I0n6dDZ
        yNafLRHE8BYroDdjfFeAJvURT0QqJwwn1gmhDSXR6UmKK0GXxirKe4rP7HqYsZj9m6H9YNQKeVb8X
        uDm7xYTZj0xWEQhUee1Z4RBRfwvDtuPZwri81YxoXvrhThD620UKYFPx7tbgUDflg22k2uhoPI6/8
        hej5S8jyxVnqw426XX9t9SoQWvwFB18HL0n92Qogffo2EI4zhKZ1SI35/VWKmBEBF8++oWCwebAwy
        ykt6ttQXOkkmFA+yEjEbNocdTCA1vbpuaANDgDvatn3fHY3bgxY/gTG7hXZgoLkpwoJegNNYEbtsX
        asNKYtMg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1laBVs-002nBm-F5; Sat, 24 Apr 2021 06:11:33 +0000
Date:   Sat, 24 Apr 2021 07:11:32 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Ted Tso <tytso@mit.edu>,
        ceph-devel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH 0/12 v4] fs: Hole punch vs page cache filling races
Message-ID: <20210424061132.GA665596@infradead.org>
References: <20210423171010.12-1-jack@suse.cz>
 <20210423220751.GB63242@dread.disaster.area>
 <20210423235149.GE235567@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423235149.GE235567@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 24, 2021 at 12:51:49AM +0100, Matthew Wilcox wrote:
> On Sat, Apr 24, 2021 at 08:07:51AM +1000, Dave Chinner wrote:
> > I've got to spend time now reconstructing the patchset into a single
> > series because the delivery has been spread across three different
> > mailing lists and so hit 3 different procmail filters.  I'll comment
> > on the patches once I've reconstructed the series and read through
> > it as a whole...
> 
> $ b4 mbox 20210423171010.12-1-jack@suse.cz
> Looking up https://lore.kernel.org/r/20210423171010.12-1-jack%40suse.cz
> Grabbing thread from lore.kernel.org/ceph-devel
> 6 messages in the thread
> Saved ./20210423171010.12-1-jack@suse.cz.mbx

Yikes.  Just send them damn mails.  Or switch the lists to NNTP, but
don't let the people who are reviewing your patches do stupid work
with weird tools.
