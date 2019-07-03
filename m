Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA1435DB3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 03:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfGCB62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 21:58:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbfGCB62 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:58:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3DBA81A9F18DCBF70E1B;
        Wed,  3 Jul 2019 09:58:22 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 09:58:18 +0800
Subject: Re: [PATCH 2/3] f2fs: use generic checking function for
 FS_IOC_FSSETXATTR
To:     Eric Biggers <ebiggers@kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>
References: <20190701202630.43776-1-ebiggers@kernel.org>
 <20190701202630.43776-3-ebiggers@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8aaeddfb-8148-0708-9106-c7f45a4827cd@huawei.com>
Date:   Wed, 3 Jul 2019 09:58:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190701202630.43776-3-ebiggers@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/7/2 4:26, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make the f2fs implementation of FS_IOC_FSSETXATTR use the new VFS helper
> function vfs_ioc_fssetxattr_check(), and remove the project quota check
> since it's now done by the helper function.
> 
> This is based on a patch from Darrick Wong, but reworked to apply after
> commit 360985573b55 ("f2fs: separate f2fs i_flags from fs_flags and ext4
> i_flags").
> 
> Originally-from: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
