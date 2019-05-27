Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF26B2B606
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 15:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfE0NJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 09:09:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:56612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbfE0NJv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 09:09:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E70CBAEBB;
        Mon, 27 May 2019 13:09:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7E694DA85C; Mon, 27 May 2019 15:10:42 +0200 (CEST)
Date:   Mon, 27 May 2019 15:10:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mm@kvack.org, Jonathan Corbet <corbet@lwn.net>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 2/3] mm: remove cleancache.c
Message-ID: <20190527131041.GH15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mm@kvack.org, Jonathan Corbet <corbet@lwn.net>,
        Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@oss.oracle.com
References: <20190527103207.13287-1-jgross@suse.com>
 <20190527103207.13287-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527103207.13287-3-jgross@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 27, 2019 at 12:32:06PM +0200, Juergen Gross wrote:
> With the removal of tmem and xen-selfballoon the only user of
> cleancache is gone. Remove it, too.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  Documentation/vm/cleancache.rst  | 296 ------------------------------------
>  Documentation/vm/frontswap.rst   |  10 +-
>  Documentation/vm/index.rst       |   1 -
>  MAINTAINERS                      |   7 -
>  drivers/staging/erofs/data.c     |   6 -
>  drivers/staging/erofs/internal.h |   1 -
>  fs/block_dev.c                   |   5 -

For the btrfs part:

>  fs/btrfs/extent_io.c             |   9 --
>  fs/btrfs/super.c                 |   2 -

Acked-by: David Sterba <dsterba@suse.com>
