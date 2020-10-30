Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5629FBF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 04:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgJ3DCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 23:02:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:6992 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ3DCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:02:35 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CMnC93vQrzhdTH;
        Fri, 30 Oct 2020 11:01:41 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 30 Oct 2020
 11:01:27 +0800
Subject: Re: [PATCH] fuse: fix potential accessing NULL pointer problem in
 fuse_send_init()
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     Miklos Szeredi <mszeredi@redhat.com>,
        linfeilong <linfeilong@huawei.com>,
        <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lihaotian <lihaotian9@huawei.com>
References: <5e1bf70a-0c6b-89b6-dc9f-474ccfcfe597@huawei.com>
 <CAJfpegtcU_=hhmq9C-n1dkCBOcTX7VzkdXDpOZZNh1iZ73-t0w@mail.gmail.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <e91268c8-f384-8a98-f611-7beae329de50@huawei.com>
Date:   Fri, 30 Oct 2020 11:01:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJfpegtcU_=hhmq9C-n1dkCBOcTX7VzkdXDpOZZNh1iZ73-t0w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/10/29 23:25, Miklos Szeredi wrote:
> On Thu, Oct 22, 2020 at 4:52 PM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
>>
>>
>> In fuse_send_init func, ia is allocated by calling kzalloc func, and
>> we donot check whether ia is NULL before using it. Thus, if allocating
>> ia fails, accessing NULL pointer problem will occur.
> 
> Note the __GFP_NOFAIL flag for kzalloc(), which ensures that it will not fail.

Thanks for your reply.
Please ignore this patch.

