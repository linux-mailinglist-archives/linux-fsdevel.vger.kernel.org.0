Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295143A9133
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 07:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhFPFga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 01:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFPFg3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 01:36:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FC6C061574;
        Tue, 15 Jun 2021 22:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=KZl195pvRh/1mmP1HQAMM9NBG+
        zD34yyV2orlHEW5H/B0dha64DUHFrphWCq8oNO72/Z9Aug1EA16waS1mP7w9dmCdLHGPPG1C1e6jv
        CCb80gdb+Spp84eDqfmKp4hGqOYwj/jsrusvcYv/X0ECS0y0xs5Y6tZ9/rDt77mCGCyMdEfjKTfnd
        1fEkofUNMF8iSW140L9H5pR1WiBcFmjs0ec8n5wveYXluMU1E3EkH9/+rwV+xMSrgKmtZM6n3VPh1
        Ocfduz2dpYNcRzlOeRFikJFGZQ/pCLRmtzSElAdI0ox1lzsY2ZlsYj8pP1Er8pDGOvng0KkPX6shJ
        7iSFdoig==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltOBT-007dgt-OF; Wed, 16 Jun 2021 05:33:53 +0000
Date:   Wed, 16 Jun 2021 06:33:51 +0100
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
Subject: Re: [PATCH 03/14] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <YMmNP7fjLUOIafzJ@infradead.org>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615091814.28626-3-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
