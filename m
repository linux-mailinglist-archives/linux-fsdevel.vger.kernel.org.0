Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C402C391428
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhEZJ4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 05:56:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:4011 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbhEZJ4j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 05:56:39 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FqmTT4mh4zmb9x;
        Wed, 26 May 2021 17:52:45 +0800 (CST)
Received: from dggemx753-chm.china.huawei.com (10.0.44.37) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 17:55:06 +0800
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 26 May 2021 17:55:05 +0800
Subject: Re: [PATCH 10/13] f2fs: Convert to using invalidate_lock
To:     Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        <ceph-devel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        <linux-cifs@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
References: <20210525125652.20457-1-jack@suse.cz>
 <20210525135100.11221-10-jack@suse.cz>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <eec8bd42-d874-93cf-23e2-b6c3997814ad@huawei.com>
Date:   Wed, 26 May 2021 17:55:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210525135100.11221-10-jack@suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggemx702-chm.china.huawei.com (10.1.199.49) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/5/25 21:50, Jan Kara wrote:
> Use invalidate_lock instead of f2fs' private i_mmap_sem. The intended
> purpose is exactly the same. By this conversion we fix a long standing
> race between hole punching and read(2) / readahead(2) paths that can
> lead to stale page cache contents.
> 
> CC: Jaegeuk Kim <jaegeuk@kernel.org>
> CC: Chao Yu <yuchao0@huawei.com>
> CC: linux-f2fs-devel@lists.sourceforge.net
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,
