Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325BF3A9151
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 07:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFPFly (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 01:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhFPFlx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 01:41:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14835C061574;
        Tue, 15 Jun 2021 22:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xk06EVl9lp5HJyBNJxkI+EUAZw3CkFLgV9O5fKQUSsQ=; b=e49zW+xtSoJvTBSrAZ30aMVlIu
        2W2x8ol+U4HkkO8pZe/UMYZBMSzfxACSfluW8kQonKmK/JH64nS/ZFnbeC5TSQqlOfrdw7sG7kX7Y
        OX7KDbfl0HM48rIFpWqJjq/W1Ua/Q6lLO8vK06Kef/WdJYe1PbvsAXAYTHDH9tKpyxpEnXLj4r+II
        7Wvlsa8BClOU5KzSSKK0IRGsabUWpkYqV5dHb0dq2NzxFTzzA2hZ+QuO75LJ/Ut4+LaJIhwAyGgvX
        EqNEBvW7ei1f2e1V3mfaVq3MYOk3keHYVR2I+cnKOjJkWJNmG6CvUbvDkGTL4VdLMYmTQjvkYfDWg
        r6KiHf5w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltOGf-007e5R-SF; Wed, 16 Jun 2021 05:39:18 +0000
Date:   Wed, 16 Jun 2021 06:39:13 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 10/14] zonefs: Convert to using invalidate_lock
Message-ID: <YMmOgeU7Ionnk0/D@infradead.org>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-10-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615091814.28626-10-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:18:00AM +0200, Jan Kara wrote:
> Use invalidate_lock instead of zonefs' private i_mmap_sem. The intended
> purpose is exactly the same.
> 
> CC: Damien Le Moal <damien.lemoal@wdc.com>
> CC: Johannes Thumshirn <jth@kernel.org>
> CC: <linux-fsdevel@vger.kernel.org>
> Acked-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
