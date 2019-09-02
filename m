Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE163A56CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfIBM5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:57:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbfIBM5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4uQk5Xm18GTABT+G8OsD3K71+2QPjkHFnf8r37qKtTE=; b=nerDje4bRvHKsxmrU9ErzEg6C
        XmO0jcDPkxJ24FKir+7nJxLK3vQy2EYHByyseDUBBwwRSRbwXJ9VV4dvz3wkDzn309jwycyF6AFzF
        WfVbR32AfUA50cq9ZK9Iy9KOZ/fJkYN8xgAMntTvHYkRi7GkAGfuKNU1ph7kgQsobxZPtBLckhVS8
        v5NWE9kMiVz5npki47o7oME94ytvKEiGUi9gJ4WENLftj9K8L6aawRGWKRsnHOVMZsRUi2GW9yfnj
        ZOJFaSSOFHSwb6tFEbEV3G66+AhALwuUIPsEBRB6ZFYL+ouHG9UItBQrV+PQsLtvsgnNqcnCYDvK1
        gPfgRU2Pw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4ltP-0006HV-IL; Mon, 02 Sep 2019 12:57:11 +0000
Date:   Mon, 2 Sep 2019 05:57:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v8 11/24] erofs: introduce xattr & posixacl support
Message-ID: <20190902125711.GA23462@infradead.org>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-12-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815044155.88483-12-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +config EROFS_FS_XATTR
> +	bool "EROFS extended attributes"
> +	depends on EROFS_FS
> +	default y
> +	help
> +	  Extended attributes are name:value pairs associated with inodes by
> +	  the kernel or by users (see the attr(5) manual page, or visit
> +	  <http://acl.bestbits.at/> for details).
> +
> +	  If unsure, say N.
> +
> +config EROFS_FS_POSIX_ACL
> +	bool "EROFS Access Control Lists"
> +	depends on EROFS_FS_XATTR
> +	select FS_POSIX_ACL
> +	default y

Is there any good reason to make these optional these days?
