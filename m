Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A501AC1E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894619AbgDPM5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 08:57:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2894377AbgDPM45 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:56:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B0FD17830174335B0639;
        Thu, 16 Apr 2020 20:56:41 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.198) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 16 Apr 2020
 20:56:32 +0800
Subject: Re: [PATCH] io_getevents.2: Add EINVAL for case of timeout parameter
 out of range
To:     <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>
CC:     linux-man <linux-man@vger.kernel.org>, <linux-aio@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        <bcrl@kvack.org>, Jeff Moyer <jmoyer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, <deepa.kernel@gmail.com>,
        <wangkefeng.wang@huawei.com>
References: <1564542193-89171-1-git-send-email-yi.zhang@huawei.com>
 <CAKgNAkivz=qXpLTPt5qbGHn0_zH-ReQ76LKhnoRd5zZuudu1NQ@mail.gmail.com>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <799c237c-a5c4-6d67-50b7-057b728f0327@huawei.com>
Date:   Thu, 16 Apr 2020 20:56:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAKgNAkivz=qXpLTPt5qbGHn0_zH-ReQ76LKhnoRd5zZuudu1NQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.198]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Michael.

On 2020/4/16 20:12, Michael Kerrisk (man-pages) wrote:
> Hello Zhangyi,
> 
> On Wed, 31 Jul 2019 at 04:57, zhangyi (F) <yi.zhang@huawei.com> wrote:
>>
>> io_[p]getevents syscall should return -EINVAL if timeout is out of
>> range, update description of this error return value.
>>
>> Link: https://lore.kernel.org/lkml/1564451504-27906-1-git-send-email-yi.zhang@huawei.com/
> 
> 
> It appears that the kernel patch to implement this check was never
> merged. Do you know what happened to it?
> 

I'm not sure why this patch was not merged and pinged it last mounth,
but there is no response.

https://www.spinics.net/lists/linux-fsdevel/msg164111.html

Hi, Al.

Any chance to apply below kernel patch?
https://lore.kernel.org/lkml/1564451504-27906-1-git-send-email-yi.zhang@huawei.com/

Thanks,
Yi.

>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>> Cc: Jeff Moyer <jmoyer@redhat.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Deepa Dinamani <deepa.kernel@gmail.com>
>> ---
>>  man2/io_getevents.2 | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/man2/io_getevents.2 b/man2/io_getevents.2
>> index 0eb4b385e..5560bb8ee 100644
>> --- a/man2/io_getevents.2
>> +++ b/man2/io_getevents.2
>> @@ -73,8 +73,9 @@ Interrupted by a signal handler; see
>>  .TP
>>  .B EINVAL
>>  \fIctx_id\fP is invalid.
>> -\fImin_nr\fP is out of range or \fInr\fP is
>> -out of range.
>> +\fImin_nr\fP is out of range or \fInr\fP is out of range, or
>> +\fItimeout\fP is out of range (\fItv_sec\fP was less than zero, or
>> +\fItv_nsec\fP was not less than 1,000,000,000).
>>  .TP
>>  .B ENOSYS
>>  .BR io_getevents ()
>> --
>> 2.20.1
>>
> 
> 

