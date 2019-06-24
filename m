Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA2B50399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 09:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfFXHe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 03:34:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:19101 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbfFXHe7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:34:59 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 825BA6EB3A94ED6FA231;
        Mon, 24 Jun 2019 15:34:56 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 24 Jun
 2019 15:34:47 +0800
Subject: Re: [PATCH v3 0/8] staging: erofs: decompression inplace approach
To:     Gao Xiang <hsiangkao@aol.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Du Wei <weidu.du@huawei.com>
References: <20190624072258.28362-1-hsiangkao@aol.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b07bc3f7-e85e-896a-c8ae-4800ca6c9816@huawei.com>
Date:   Mon, 24 Jun 2019 15:34:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190624072258.28362-1-hsiangkao@aol.com>
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
> This is patch v3 of erofs decompression inplace approach, which is sent
> out by my personal email since I'm out of office to attend Open Source
> Summit China 2019 these days. No major change from PATCH v2 since no
> noticeable issue raised from landing to our products till now, mainly
> as a response to Chao's suggestions.
> 
> See the bottom lines which are taken from RFC PATCH v1 and describe
> the principle of these technologies.
> 
> The series is based on the latest staging-next since all dependencies
> have already been merged.
> 
> changelog from v2:
>  - wrap up some offsets as marcos;
>  - add some error handling for erofs_get_pcpubuf();
>  - move some decompression inplace stuffes from PATCH 5 -> 6.

Thanks for the update, those all changes look good to me. :)

Thanks,
