Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1225038C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 09:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfFXHd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 03:33:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19063 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfFXHd1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:33:27 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DF751AFD1527423AE49E;
        Mon, 24 Jun 2019 15:33:24 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 24 Jun
 2019 15:33:15 +0800
Subject: Re: [PATCH v3 3/8] staging: erofs: move per-CPU buffers
 implementation to utils.c
To:     Gao Xiang <hsiangkao@aol.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Du Wei <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
References: <20190624072258.28362-1-hsiangkao@aol.com>
 <20190624072258.28362-4-hsiangkao@aol.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3ab4064f-042e-1838-6e32-5fb7087f4dc1@huawei.com>
Date:   Mon, 24 Jun 2019 15:33:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190624072258.28362-4-hsiangkao@aol.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/6/24 15:22, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> This patch moves per-CPU buffers to utils.c in order for
> the upcoming generic decompression framework to use it.
> 
> Note that I tried to use generic per-CPU buffer or
> per-CPU page approaches to clean up further, but obvious
> performanace regression (about 2% for sequential read) was
> observed.
> 
> Therefore let's leave it as it is instead, just move
> to utils.c and I'll try to dig into the root cause later.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
