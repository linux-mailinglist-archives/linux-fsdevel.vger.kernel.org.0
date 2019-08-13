Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC58AFE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 08:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfHMG0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 02:26:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbfHMG0c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:26:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 48E537F3B8CC13C0C464;
        Tue, 13 Aug 2019 14:10:40 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 14:10:32 +0800
Subject: Re: [PATCH 3/3] staging: erofs: xattr.c: avoid BUG_ON
To:     Gao Xiang <gaoxiang25@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        "Fang Wei" <fangwei1@huawei.com>
References: <20190813023054.73126-1-gaoxiang25@huawei.com>
 <20190813023054.73126-3-gaoxiang25@huawei.com>
 <84f50ca2-3411-36a6-049a-0d343d8df325@huawei.com>
 <20190813035754.GA23614@138>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <aa7660a6-b8a9-f22f-2616-f51c45dd52ac@huawei.com>
Date:   Tue, 13 Aug 2019 14:10:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190813035754.GA23614@138>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Xiang,

On 2019/8/13 11:57, Gao Xiang wrote:
> Hi Chao,
> 
> On Tue, Aug 13, 2019 at 11:20:22AM +0800, Chao Yu wrote:
>> On 2019/8/13 10:30, Gao Xiang wrote:
>>> Kill all the remaining BUG_ON in EROFS:
>>>  - one BUG_ON was used to detect xattr on-disk corruption,
>>>    proper error handling should be added for it instead;
>>>  - the other BUG_ONs are used to detect potential issues,
>>>    use DBG_BUGON only in (eng) debugging version.
>>
>> BTW, do we need add WARN_ON() into DBG_BUGON() to show some details function or
>> call stack in where we encounter the issue?
> 
> Thanks for kindly review :)
> 
> Agreed, it seems much better. If there are no other considerations
> here, I can submit another patch addressing it later or maybe we
> can change it in the next linux version since I'd like to focusing
> on moving out of staging for this round...

No problem, we can change it in a proper time.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>>>
>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Thanks,
> .
> 
