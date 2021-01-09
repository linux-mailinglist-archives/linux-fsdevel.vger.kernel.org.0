Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77402EFE36
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 07:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbhAIGwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 01:52:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10482 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIGwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 01:52:39 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DCVwv0Y6mzj4cp;
        Sat,  9 Jan 2021 14:50:55 +0800 (CST)
Received: from [10.174.176.235] (10.174.176.235) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Sat, 9 Jan 2021 14:51:50 +0800
Subject: Re: [PATCH] syscalls: add comments show the define file for aio
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>
References: <20210109031416.1375292-1-yangerkun@huawei.com>
 <20210109045848.GS3579531@ZenIV.linux.org.uk>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <d8c556cc-bbfd-16df-61ee-3a8dc6a0c012@huawei.com>
Date:   Sat, 9 Jan 2021 14:51:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210109045848.GS3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



ÔÚ 2021/1/9 12:58, Al Viro Ð´µÀ:
> On Sat, Jan 09, 2021 at 11:14:16AM +0800, yangerkun wrote:
>> fs/aio.c define the syscalls for aio.
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
> 
> That (and the next patch) really ought to go to Arnd - I've very little
> to do with the unistd.h machinery.
> .

Thanks! Will resend patch to Arnd!

> 
