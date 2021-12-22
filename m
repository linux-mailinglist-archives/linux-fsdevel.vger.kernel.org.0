Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185D047CAC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Dec 2021 02:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhLVB05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 20:26:57 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29278 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhLVB05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:26:57 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JJbJS4ZRnzbjXv;
        Wed, 22 Dec 2021 09:26:32 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 09:26:55 +0800
Subject: Re: [PATCH -next] sysctl: returns -EINVAL when a negative value is
 passed to proc_doulongvec_minmax
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <keescook@chromium.org>,
        <yzaikin@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20211209085635.1288737-1-libaokun1@huawei.com>
 <Yb+kHuIFnCKcfM5l@bombadil.infradead.org>
 <4b2cba44-b18a-dd93-b288-c6a487e4857a@huawei.com>
 <YcDZKxXJKglR6mcO@bombadil.infradead.org>
 <70910c5b-4681-db00-27ba-715dddd7831a@huawei.com>
 <YcJO3f8LWvSMWBKz@bombadil.infradead.org>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <0d2b0af4-b0c0-487d-549b-5817ae75284d@huawei.com>
Date:   Wed, 22 Dec 2021 09:26:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YcJO3f8LWvSMWBKz@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2021/12/22 6:02, Luis Chamberlain 写道:
> On Tue, Dec 21, 2021 at 09:15:28AM +0800, libaokun (A) wrote:
>> 在 2021/12/21 3:27, Luis Chamberlain 写道:
>>> On Mon, Dec 20, 2021 at 04:53:57PM +0800, libaokun (A) wrote:
>>>> 在 2021/12/20 5:29, Luis Chamberlain 写道:
>>>>> Curious do you have docs on Hulk Robot?
>>>> Hulk Robot is Huawei's internal test framework. It contains many things.
>>> Neat, is the code public?
>> The code is not public.
> Why not?
Because it's currently only used internally, and I don't know much about it.
>
>    Luis
> .

-- 
With Best Regards,
Baokun Li

