Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9E33A914A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 07:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFPFk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 01:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhFPFkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 01:40:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BDDC061574;
        Tue, 15 Jun 2021 22:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i6Te121nsbASjm5MP8RDzAtp9SFu5KeY0UqFquXM9wo=; b=rbOxO1z7VyYAhtsj0d8YPyVLvX
        2b8Vyz7JNNOwBXWgCtSk3tgrMbQ/QC6cxA5fq7aQjdllRezVEGC+SDDNNXGeT3M+Gwx9D4oG/9XHy
        neZSiCMSbujw7lF2Fruj6EygGNzeK2Bd67SXBjir21DbZhpfx+xvP+r6gaomB7iJpgN0qQLLzawb3
        qzKWxtm6Wb1ppZxg00KKTx6FAfwV/m5QKO/Q5FdlgGZEyj08Hs8K/yP7+SUCt8KP4ewHUEW4DzW21
        RKi7y8jkyMOCZ+YwWFHK03dfDmwzKqFTWKwoKH1VJoE4E3zgQ7hE8m0NK0zkgq3je86CxD41eol8e
        iEnX/FOA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltOFt-007e1r-NG; Wed, 16 Jun 2021 05:38:28 +0000
Date:   Wed, 16 Jun 2021 06:38:25 +0100
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
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 09/14] xfs: Convert double locking of MMAPLOCK to use VFS
 helpers
Message-ID: <YMmOUXSKfAWSwRFM@infradead.org>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-9-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615091814.28626-9-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:17:59AM +0200, Jan Kara wrote:
> Convert places in XFS that take MMAPLOCK for two inodes to use helper
> VFS provides for it (filemap_invalidate_down_write_two()). Note that
> this changes lock ordering for MMAPLOCK from inode number based ordering
> to pointer based ordering VFS generally uses.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
