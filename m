Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C93779CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 03:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhEJBaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 21:30:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2420 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhEJBaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 21:30:19 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fdk0p4TqgzCqt2;
        Mon, 10 May 2021 09:26:34 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 09:29:08 +0800
Subject: Re: [RFC PATCH 0/3] block_dump: remove block dump
To:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <jack@suse.cz>
CC:     <tytso@mit.edu>, <viro@zeniv.linux.org.uk>, <hch@infradead.org>,
        <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>
References: <20210313030146.2882027-1-yi.zhang@huawei.com>
 <15f9c6ce-f22a-59cd-8ce7-eb908f663826@kernel.dk>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <c432c9b0-cef1-123e-1fcd-0549b24e381e@huawei.com>
Date:   Mon, 10 May 2021 09:29:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <15f9c6ce-f22a-59cd-8ce7-eb908f663826@kernel.dk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/3/13 11:37, Jens Axboe wrote:
> On 3/12/21 8:01 PM, zhangyi (F) wrote:
>> Hi,
>>
>> block_dump is an old debugging interface and can be replaced by
>> tracepoints, and we also found a deadlock issue relate to it[1]. As Jan
>> suggested, this patch set delete the whole block_dump feature, we can
>> use tracepoints to get the similar information. If someone still using
>> this feature cannot switch to use tracepoints or any other suggestions,
>> please let us know.
> 
> Totally agree, that's long overdue. The feature is no longer useful
> and has been deprecated by much better methods. Unless anyone objects,
> I'll queue this up for 5.13.
> 
Hi, Jens. Could you please send these patches upstream ?

Thanks,
Yi.
