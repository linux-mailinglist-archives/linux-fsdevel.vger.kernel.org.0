Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1732C3A9136
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 07:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFPFhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 01:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhFPFhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 01:37:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1F2C061574;
        Tue, 15 Jun 2021 22:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7WM3/Dl0NMSgUE40lDfACWPmQcemQr14B5cKG1DML9I=; b=PMuF+TdHs0agnUqrOQZCxPj6T+
        lVwXYf9rLAbSwsG85Ls5HxfIuoGQuZlm2QLmcdi9ZtRz4aX6NT6JGu9D8Nyc/TT/AsEg3ID7X3nGw
        9VfY5SBlnnrUf/EBA5kFXdr+qGVdZqkDYVMVKk1vI/OQQWuxIwYBiI7GgK2Z4/xX2UySlnfSfgAsb
        Li3RgEp5YQzf8SO9YERFrETk6zGL7h5xz8lVuhXtERykXe9W0C8HbUJKTQRMRCK1foHibkO1RQLYd
        PHBubU9QiolCcmrKOoAWyHLiGSCbgv+CJbR5XsrRDEkJ6Y/HODyfpMrVR6AdO1tD5yyGFKtQb80nc
        /4X6sKOQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltOC9-007djU-26; Wed, 16 Jun 2021 05:34:39 +0000
Date:   Wed, 16 Jun 2021 06:34:33 +0100
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
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 04/14] mm: Add functions to lock invalidate_lock for two
 mappings
Message-ID: <YMmNafE6x/kUbRqL@infradead.org>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615091814.28626-4-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:17:54AM +0200, Jan Kara wrote:
> Some operations such as reflinking blocks among files will need to lock
> invalidate_lock for two mappings. Add helper functions to do that.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
