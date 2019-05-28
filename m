Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9581F2BCDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 03:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfE1BYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 21:24:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727018AbfE1BYg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 21:24:36 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CDBE6741DB59E7908D31;
        Tue, 28 May 2019 09:24:33 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 28 May
 2019 09:24:26 +0800
Subject: Re: [PATCH 2/3] mm: remove cleancache.c
To:     Juergen Gross <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <linux-mm@kvack.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Gao Xiang <gaoxiang25@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        <ocfs2-devel@oss.oracle.com>
References: <20190527103207.13287-1-jgross@suse.com>
 <20190527103207.13287-3-jgross@suse.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8f69d56d-3fdd-a160-9574-f81bd066e5ac@huawei.com>
Date:   Tue, 28 May 2019 09:24:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190527103207.13287-3-jgross@suse.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/5/27 18:32, Juergen Gross wrote:
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
>  fs/btrfs/extent_io.c             |   9 --
>  fs/btrfs/super.c                 |   2 -
>  fs/ext4/readpage.c               |   6 -
>  fs/ext4/super.c                  |   2 -
>  fs/f2fs/data.c                   |   3 +-

For erofs and f2fs part,

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>  fs/mpage.c                       |   7 -
>  fs/ocfs2/super.c                 |   2 -
>  fs/super.c                       |   3 -
>  include/linux/cleancache.h       | 124 ---------------
>  include/linux/fs.h               |   5 -
>  mm/Kconfig                       |  22 ---
>  mm/Makefile                      |   1 -
>  mm/cleancache.c                  | 317 ---------------------------------------
>  mm/filemap.c                     |  11 --
>  mm/truncate.c                    |  15 +-
