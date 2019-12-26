Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D34312AB55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 10:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfLZJiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 04:38:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfLZJit (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 04:38:49 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 61E2EAFD2DD65EB152BF;
        Thu, 26 Dec 2019 17:38:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 26 Dec
 2019 17:38:43 +0800
Subject: Re: [PATCH] f2fs: introduce DEFAULT_IO_TIMEOUT_JIFFIES
To:     Vyacheslav Dubeyko <slava@dubeyko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20191223040020.109570-1-yuchao0@huawei.com>
 <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
 <1cc2d2a093ebb15a1fc6eb96d683e918a8d5a7d4.camel@dubeyko.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8a196bfe-666b-3d7b-e78b-8d3a9bcca978@huawei.com>
Date:   Thu, 26 Dec 2019 17:38:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1cc2d2a093ebb15a1fc6eb96d683e918a8d5a7d4.camel@dubeyko.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/25 17:58, Vyacheslav Dubeyko wrote:
> On Mon, 2019-12-23 at 09:41 +0100, Geert Uytterhoeven wrote:
>> Hi,
>>
>> CC linux-fsdevel
>>
>> On Mon, Dec 23, 2019 at 5:01 AM Chao Yu <yuchao0@huawei.com> wrote:
>>> As Geert Uytterhoeven reported:
>>>
>>> for parameter HZ/50 in congestion_wait(BLK_RW_ASYNC, HZ/50);
>>>
>>> On some platforms, HZ can be less than 50, then unexpected 0
>>> timeout
>>> jiffies will be set in congestion_wait().
>>>
> 
> 
> It looks like that HZ could have various value on diferent platforms.
> So, why does it need to divide HZ on 50? Does it really necessary?

I guess this code was copied from other filesystems, I have no idea why
we should use HZ/50 as timeout interval value.

> Could it be used HZ only without the division operation?

Actually, as Geert pointed out, we can handle that zeroed value parameter
inside congestion_wait() to cover all filesystems use cases.

Thanks,

> 
> Thanks,
> Viacheslav Dubeyko.
> 
> 
> .
> 
