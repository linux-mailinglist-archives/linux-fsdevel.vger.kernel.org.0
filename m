Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CD02F756B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 10:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbhAOJ3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 04:29:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11394 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbhAOJ3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:29:14 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DHG6p0sDqz7Vbp;
        Fri, 15 Jan 2021 17:27:30 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 15 Jan
 2021 17:28:29 +0800
Subject: Re: [PATCH] f2fs: Remove readahead collision detection
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>
References: <20210114190051.1893991-1-willy@infradead.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <dd18fd2d-dada-7685-1ca8-70ce7a691965@huawei.com>
Date:   Fri, 15 Jan 2021 17:28:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210114190051.1893991-1-willy@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/1/15 3:00, Matthew Wilcox (Oracle) wrote:
> With the new ->readahead operation, locked pages are added to the page
> cache, preventing two threads from racing with each other to read the
> same chunk of file, so this is dead code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
