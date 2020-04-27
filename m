Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8A1B9519
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 04:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgD0CWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 22:22:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42536 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbgD0CWh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 22:22:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 800631DA473C558CD577;
        Mon, 27 Apr 2020 10:22:31 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 27 Apr
 2020 10:22:28 +0800
Subject: Re: [RFC PATCH 5/9] f2fs: use set/clear_fs_page_private
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hch@infradead.org>, <david@fromorbit.com>, <willy@infradead.org>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-6-guoqing.jiang@cloud.ionos.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fc48f93d-b705-4770-0fd0-8807b3a74403@huawei.com>
Date:   Mon, 27 Apr 2020 10:22:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200426214925.10970-6-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/4/27 5:49, Guoqing Jiang wrote:
> Since the new pair function is introduced, we can call them to clean the
> code in f2fs.h.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,
