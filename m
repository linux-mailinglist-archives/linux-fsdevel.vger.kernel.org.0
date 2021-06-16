Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12533A9129
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 07:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhFPFdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 01:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhFPFdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 01:33:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521B2C061574;
        Tue, 15 Jun 2021 22:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t++zkK6+3jhlyv3CdaWkO1s/YSSZiDhwUfUI7hox61M=; b=L51zmJv2LnWVezREZ5qO4Sb4wj
        hCkTE/m0QqQeN/5fgrUDw/vgFNIIeg8Tim3ewCdoojjCilGOiOR8c57029dd+orJh4t/rmvG+zR/a
        UHO8a7GTTdjaSw/kYKR/waNT0IQxcbOBjD41L++7qEygfR8I4on7v/P+EaeWtR63wtcqY1TO2xSjQ
        9P8FymJ5aMKYu9uPSQ7YvWMS45J/3ptspKhWI6C9d9j4lZ0Xa63qEj+Ap3dUQFJO2ltsaz2mqEU3D
        iiFAOfRtA97vNbBHFBSJkoX95S7mAUqFyCzG8TXG+C1sA44zQbHJcvdjyoMdBgCBcGaMbTYHXu6FM
        EEVq3gEA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltO8n-007dWP-Eq; Wed, 16 Jun 2021 05:31:07 +0000
Date:   Wed, 16 Jun 2021 06:31:05 +0100
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
Subject: Re: [PATCH 02/14] documentation: Sync file_operations members with
 reality
Message-ID: <YMmMmdWGDQvkggf0@infradead.org>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615091814.28626-2-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:17:52AM +0200, Jan Kara wrote:
> Sync listing of struct file_operations members with the real one in
> fs.h.

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I wonder if we could just move the locking documentation into the
header itself using kerneldoc annotation to avoid all this syncing..
