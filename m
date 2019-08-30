Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3192A3C1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 18:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfH3Qfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 12:35:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3Qfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qjMbYb7pZX3h+u+WxhCaqJiHflS54PzmrV2Ki0KAxtg=; b=UljtLp+nXvq3zhhMc/qzw9CK+
        OZQWG5SZ+yUDGVutwjT48sAl8Gaf58I4Ms7FfTOUk3s0eAd82Z6KP+SQWkD8VsvPeQCrghKOVPmf5
        JvBPfh0hTx5sIzovqOvJ0uZ3UvRTIWWEKqAm4RWLEecNqVDtDTW51BodqDK5JvAs78F13iJpT1A9J
        yMMb7GzPQbKAMDVIvruKzfiuEyQIAaCavV87GN/TwO0qnD6gvZVEXB41k/4987+pQXTK1E1mWR2AG
        8Yvz7tP445Tx6zdf9gAy4X4wtOD7k1RQKvZoT9J+z5PYKtyDkAPwWPqQY/hXNmUtllRl+216w7Vqv
        xV9kRz0yQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3js6-00010N-Da; Fri, 30 Aug 2019 16:35:34 +0000
Date:   Fri, 30 Aug 2019 09:35:34 -0700
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
Subject: Re: [PATCH v8 20/24] erofs: introduce generic decompression backend
Message-ID: <20190830163534.GA29603@infradead.org>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-21-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815044155.88483-21-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 12:41:51PM +0800, Gao Xiang wrote:
> +static bool use_vmap;
> +module_param(use_vmap, bool, 0444);
> +MODULE_PARM_DESC(use_vmap, "Use vmap() instead of vm_map_ram() (default 0)");

And how would anyone know which to pick? 
