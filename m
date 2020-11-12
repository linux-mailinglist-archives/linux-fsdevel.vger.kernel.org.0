Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0252B01EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 10:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKLJZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 04:25:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7212 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgKLJZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:25:44 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CWx5z41zSzkg2y;
        Thu, 12 Nov 2020 17:25:27 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 12 Nov
 2020 17:25:34 +0800
Subject: Re: [PATCH v2] f2fs: fix double free of unicode map
To:     Hyeongseok Kim <hyeongseok@gmail.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <hyeongseok.kim@lge.com>
References: <20201112091454.15311-1-hyeongseok@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6a442a9c-d8ab-3e5f-fda8-fabbbca2ed32@huawei.com>
Date:   Thu, 12 Nov 2020 17:25:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201112091454.15311-1-hyeongseok@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/11/12 17:14, Hyeongseok Kim wrote:
> In case of retrying fill_super with skip_recovery,
> s_encoding for casefold would not be loaded again even though it's
> already been freed because it's not NULL.
> Set NULL after free to prevent double freeing when unmount.
> 
> Fixes: eca4873ee1b6 ("f2fs: Use generic casefolding support")
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
